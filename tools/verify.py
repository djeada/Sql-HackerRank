#!/usr/bin/env python3
"""Check catalog coverage and execute every solution against its local fixtures."""

import argparse
from collections import Counter
from datetime import date, datetime
from decimal import Decimal
import json
import os
from pathlib import Path
import re
import sqlite3
import sys
from urllib.parse import urlencode
from urllib.request import Request, urlopen


ROOT = Path(__file__).resolve().parents[1]


def read_json(path):
    return json.loads((ROOT / path).read_text(encoding='utf-8'))


def validate_catalog(manifest, expected, cases):
    problems = manifest['problems']
    slugs = [problem['slug'] for problem in problems]
    if len(slugs) != len(set(slugs)) or len(slugs) != manifest['source']['total']:
        raise ValueError('The manifest has duplicate or missing problems.')
    if set(slugs) != set(expected):
        raise ValueError('Every problem must have exactly one expected-result entry.')
    if any(case['slug'] not in slugs for case in cases):
        raise ValueError('An edge case references an unknown problem.')

    sql_paths = set()
    fixture_paths = set()
    readme = (ROOT / 'README.md').read_text(encoding='utf-8')
    for problem in problems:
        for key in ['solution', 'fixture', 'mysql_solution']:
            if key not in problem:
                continue
            path = problem[key]
            if not (ROOT / path).is_file():
                raise ValueError(f'Missing {key}: {path}')
            if f']({path})' not in readme:
                raise ValueError(f'Missing README link: {path}')
            (fixture_paths if key == 'fixture' else sql_paths).add(path)
        if f"https://www.hackerrank.com/challenges/{problem['slug']}/problem" not in readme:
            raise ValueError(f"Missing challenge link: {problem['slug']}")
        if 'mysql_solution' in problem:
            shared = (ROOT / problem['solution']).read_text(encoding='utf-8')
            mysql = (ROOT / problem['mysql_solution']).read_text(encoding='utf-8')
            if shared == mysql:
                raise ValueError(f"Unnecessary duplicate MySQL solution: {problem['slug']}")
    actual_sql = {str(path.relative_to(ROOT)) for path in (ROOT / 'src').rglob('*.sql')}
    if actual_sql != sql_paths:
        raise ValueError(f'Unindexed SQL files: {actual_sql ^ sql_paths}')
    actual_fixtures = {str(path.relative_to(ROOT)) for path in (ROOT / 'fixtures').glob('*.sql')}
    if actual_fixtures != fixture_paths:
        raise ValueError(f'Unindexed fixtures: {actual_fixtures ^ fixture_paths}')


def validate_online(manifest):
    """Compare the checked-in list with every page of HackerRank's public SQL catalog."""
    catalog = {}
    offset = 0
    while True:
        url = manifest['source']['api_url'] + '?' + urlencode({'offset': offset, 'limit': 50})
        request = Request(url, headers={'User-Agent': 'Sql-HackerRank catalog check'})
        with urlopen(request, timeout=30) as response:
            payload = json.load(response)
        models = payload['models']
        if not models:
            raise ValueError('HackerRank returned an incomplete catalog page.')
        for model in models:
            slug = model['slug']
            if slug in catalog:
                raise ValueError(f'HackerRank returned a duplicate challenge: {slug}')
            catalog[slug] = (model['name'].strip(), model['track']['name'].lower().replace(' ', '_'))
        offset += len(models)
        if offset >= payload['total']:
            break
    local = {p['slug']: (p['title'], p['category']) for p in manifest['problems']}
    if catalog != local:
        missing = sorted(set(catalog) - set(local))
        obsolete = sorted(set(local) - set(catalog))
        changed = sorted(slug for slug in set(local) & set(catalog) if local[slug] != catalog[slug])
        raise ValueError(f'Catalog drift: missing={missing}, obsolete={obsolete}, changed={changed}')
    print(f'Live HackerRank catalog: all {len(catalog)} problems covered.')


def statements(script):
    """Split these plain SQL scripts without breaking semicolons inside quoted strings."""
    buffer = ''
    for character in script:
        buffer += character
        if character == ';' and sqlite3.complete_statement(buffer):
            yield buffer
            buffer = ''
    remainder = re.sub(r'--[^\n]*', '', buffer).strip()
    if remainder:
        raise ValueError('SQL scripts must end each statement with a semicolon.')


def execute(connection, script):
    results = []
    cursor = connection.cursor()
    try:
        for statement in statements(script):
            cursor.execute(statement)
            if cursor.description is not None:
                results.append([list(row) for row in cursor.fetchall()])
    finally:
        cursor.close()
    return results


def connect(dialect):
    if dialect == 'sqlite':
        if sqlite3.sqlite_version_info < (3, 35, 0):
            raise RuntimeError('SQLite 3.35 or newer is required.')
        connection = sqlite3.connect(':memory:')
        # Force unordered reads away from insertion order; assertions must reflect the prompt.
        connection.execute('PRAGMA reverse_unordered_selects = ON')
        try:
            connection.execute('SELECT FLOOR(1.5), CEIL(1.5), SQRT(4), POWER(2, 2)')
        except sqlite3.OperationalError as error:
            connection.close()
            raise RuntimeError('SQLite must be built with ENABLE_MATH_FUNCTIONS.') from error
        return connection, f'SQLite {sqlite3.sqlite_version}'

    try:
        import pymysql
    except ImportError as error:
        raise RuntimeError('Install requirements-test.txt for MySQL checks.') from error
    if not os.environ.get('MYSQL_DATABASE'):
        raise RuntimeError('Set MYSQL_DATABASE to a disposable test database; fixtures reset tables.')
    connection = pymysql.connect(
        host=os.environ.get('MYSQL_HOST', '127.0.0.1'),
        port=int(os.environ.get('MYSQL_PORT', '3306')),
        user=os.environ.get('MYSQL_USER', 'root'),
        password=os.environ.get('MYSQL_PASSWORD', ''),
        database=os.environ['MYSQL_DATABASE'],
        charset='utf8mb4', autocommit=True, connect_timeout=10,
    )
    version = execute(connection, 'SELECT VERSION();')[0][0][0]
    if 'mariadb' in version.lower() or tuple(map(int, version.split('-')[0].split('.')[:2])) < (8, 0):
        connection.close()
        raise RuntimeError(f'MySQL 8.0 or newer is required; found {version}.')
    execute(connection, "SET SESSION sql_mode = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';")
    execute(connection, 'SET NAMES utf8mb4 COLLATE utf8mb4_bin;')
    return connection, f'MySQL {version}, strict mode and ONLY_FULL_GROUP_BY'


def normalize(value):
    if isinstance(value, (date, datetime)):
        return value.isoformat()
    if isinstance(value, (int, float, Decimal)):
        # Compare values rather than client-specific numeric types or decimal display width.
        return Decimal(str(value)).quantize(Decimal('0.0000001'))
    return value


def assert_results(actual, expected, ordered):
    if len(actual) != len(expected):
        raise AssertionError(f'Expected {len(expected)} result sets, received {len(actual)}.')
    for index, (actual_rows, expected_rows) in enumerate(zip(actual, expected), 1):
        got = [tuple(normalize(cell) for cell in row) for row in actual_rows]
        want = [tuple(normalize(cell) for cell in row) for row in expected_rows]
        match = got == want if ordered else Counter(got) == Counter(want)
        if not match:
            raise AssertionError(f'Result set {index}:\n  expected {want}\n  received {got}')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--dialect', choices=['sqlite', 'mysql'], default='sqlite')
    parser.add_argument('--problem', help='Run one HackerRank challenge slug, including its edge cases.')
    parser.add_argument('--show-results', action='store_true', help='Print query rows as JSON.')
    parser.add_argument('--online', action='store_true', help='Also compare with the live HackerRank catalog.')
    parser.add_argument('--catalog-only', action='store_true', help='Check coverage without opening a database.')
    args = parser.parse_args()

    manifest = read_json('problems.json')
    expected = read_json('tests/expected.json')
    cases = read_json('tests/cases.json')
    validate_catalog(manifest, expected, cases)
    if args.online:
        validate_online(manifest)
    print(f"Catalog: {len(manifest['problems'])} solutions, each with a setup and expected results.")
    if args.catalog_only:
        return 0
    problems = [p for p in manifest['problems'] if args.problem is None or p['slug'] == args.problem]
    if not problems:
        parser.error(f'Unknown challenge slug: {args.problem}')

    passed = failed = 0
    printed_version = False
    for problem in problems:
        scenarios = [dict(name='fixture', sql='', expected=expected[problem['slug']])]
        scenarios += [case for case in cases if case['slug'] == problem['slug']]
        for scenario in scenarios:
            connection, version = connect(args.dialect)
            try:
                if not printed_version:
                    print(version)
                    printed_version = True
                fixture = (ROOT / problem['fixture']).read_text(encoding='utf-8')
                # Every setup must be rerunnable without duplicate rows or stale data.
                execute(connection, fixture)
                execute(connection, fixture)
                execute(connection, scenario['sql'])
                path = problem.get('mysql_solution', problem['solution']) if args.dialect == 'mysql' else problem['solution']
                actual = execute(connection, (ROOT / path).read_text(encoding='utf-8'))
                assert_results(actual, scenario['expected'], problem['ordered'])
                if args.show_results:
                    print(json.dumps(dict(slug=problem['slug'], case=scenario['name'], results=actual), default=str, ensure_ascii=False))
                passed += 1
            except Exception as error:
                failed += 1
                print(f"FAIL {problem['slug']} ({scenario['name']}): {error}", file=sys.stderr)
            finally:
                connection.close()
    print(f'{args.dialect}: {passed} passed, {failed} failed ({len(problems)} problems).')
    return 1 if failed else 0


if __name__ == '__main__':
    try:
        sys.exit(main())
    except (OSError, ValueError, RuntimeError) as error:
        print(f'ERROR: {error}', file=sys.stderr)
        sys.exit(1)
