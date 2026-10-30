# Sql-HackerRank

Solutions for all **58 problems** in [HackerRank's SQL practice track](https://www.hackerrank.com/domains/sql), checked against its public catalog on **2026-10-30**.

Every problem below links to a solution and a small SQL setup containing `CREATE TABLE` and quick `INSERT` statements. Problems using the same schema share a setup. These are local test fixtures, not HackerRank's hidden test data. The triangle and prime queries generate their own rows and need no tables.

## Run the checks

Use Python 3.9+ and SQLite 3.35+ built with `ENABLE_MATH_FUNCTIONS` (for `FLOOR`, `CEIL`, `SQRT`, and `POWER`). The SQLite suite uses Python's standard library and needs no packages:

```sh
python3 tools/verify.py
python3 tools/verify.py --problem binary-search-tree-1 --show-results
```

The runner checks all 58 solutions against expected rows, plus edge cases. It executes each setup twice to verify that it resets cleanly, compares every result set, checks ordering where required, and preserves duplicate rows when comparing unordered results. It also checks that every solution and fixture appears in this index.

To compare coverage with HackerRank's current catalog, including every page:

```sh
python3 tools/verify.py --online --catalog-only
```

For a quick manual SQLite session from the repository root:

```sh
sqlite3 :memory: '.read fixtures/binary_tree.sql' '.read src/advanced_select/binary_tree_nodes.sql'
```

## MySQL

Use **MySQL 8.0+**. The same setups run in both databases. Fixtures drop and recreate their named tables, so use a disposable test database. One local option is Docker:

```sh
docker run --name hackerrank-mysql --rm -d \
  -e MYSQL_ROOT_PASSWORD=local-root \
  -e MYSQL_DATABASE=hackerrank_test \
  -e MYSQL_USER=hackerrank -e MYSQL_PASSWORD=local-tests \
  -p 127.0.0.1:3306:3306 mysql:8.4
# Wait until the server is ready:
docker exec hackerrank-mysql mysqladmin ping -h127.0.0.1 -uroot -plocal-root

python3 -m pip install -r requirements-test.txt
MYSQL_DATABASE=hackerrank_test MYSQL_USER=hackerrank MYSQL_PASSWORD=local-tests \
  python3 tools/verify.py --dialect mysql
```

`MYSQL_HOST` and `MYSQL_PORT` default to `127.0.0.1` and `3306`. To print one MySQL solution's results, add `--problem the-pads --show-results`. The runner selects the MySQL variant automatically and enables strict mode with `ONLY_FULL_GROUP_BY`. GitHub Actions runs the full suite on SQLite, MySQL 8.0, and MySQL 8.4.

## Meaningful dialect differences

**53 solutions are shared verbatim.** For the five exceptions, `src/` contains SQLite SQL and `src/mysql/` contains the MySQL variant; both are linked below. All fixture SQL is shared.

| Problems | SQLite | MySQL | Reason |
| --- | --- | --- | --- |
| The PADS | `||` | `CONCAT` | Text concatenation; `||` is logical OR in MySQL's default SQL mode. |
| Draw The Triangle 1 and 2 | Recursive text concatenation with `||` | `CONCAT` and a `CHAR(39)` seed | MySQL fixes recursive CTE column widths from the seed row. |
| Print Prime Numbers | Ordered subquery and `GROUP_CONCAT(N, '&')` | `GROUP_CONCAT(N ORDER BY N SEPARATOR '&')` | Separator and ordering syntax differ. |
| Weather Observation Station 5 | `LENGTH` | `CHAR_LENGTH` | MySQL's `LENGTH` counts bytes; both solutions must count characters. |

Window functions replace session-variable row numbering. Vowel checks compare the `HEX` codes of uppercase first/last characters against ASCII A/E/I/O/U, without regex extensions. This preserves the same vowel definition under MySQL's default accent-insensitive collation (so `É` is not treated as `E`). Date queries use the problem's one-day task and March 1 contest rules, so they need no dialect-specific date arithmetic. Numeric results are compared by value; database clients can display trailing decimal zeros differently.

The fixtures cover strict population and latitude bounds, mixed-case city names, a one-character city, Unicode character lengths, exact output text, duplicate company rows, report ordering, repeated perfect submissions, minimum wand costs, leaderboard ties, missing statistics, project boundaries across a month, and daily submission streaks. Extra cases check odd/even medians, duplicate median values, a single root, empty results, and zero continuing streaks. Expected rows are checked in under `tests/`; the test runner never derives them from a solution.

## Problem index

`problems.json` records challenge slugs, paths, setup files, ordering requirements, and the catalog check date. Use the setup linked on the same row as the solution: table names such as `STUDENTS`, `EMPLOYEE`, and `CHALLENGES` have different schemas in different problems.

### Basic Select

| Problem | Solution | Setup with inserts |
| --- | --- | --- |
| [Revising the Select Query I](https://www.hackerrank.com/challenges/revising-the-select-query/problem) | [SQL](src/basic_select/revising_the_select_query_i.sql) | [setup](fixtures/city.sql) |
| [Revising the Select Query II](https://www.hackerrank.com/challenges/revising-the-select-query-2/problem) | [SQL](src/basic_select/revising_the_select_query_ii.sql) | [setup](fixtures/city.sql) |
| [Select All](https://www.hackerrank.com/challenges/select-all-sql/problem) | [SQL](src/basic_select/select_all.sql) | [setup](fixtures/city.sql) |
| [Select By ID](https://www.hackerrank.com/challenges/select-by-id/problem) | [SQL](src/basic_select/select_by_id.sql) | [setup](fixtures/city.sql) |
| [Japanese Cities' Attributes](https://www.hackerrank.com/challenges/japanese-cities-attributes/problem) | [SQL](src/basic_select/japanese_cities_attributes.sql) | [setup](fixtures/city.sql) |
| [Japanese Cities' Names](https://www.hackerrank.com/challenges/japanese-cities-name/problem) | [SQL](src/basic_select/japanese_cities_names.sql) | [setup](fixtures/city.sql) |
| [Weather Observation Station 1](https://www.hackerrank.com/challenges/weather-observation-station-1/problem) | [SQL](src/basic_select/weather_observation_station_1.sql) | [setup](fixtures/station.sql) |
| [Weather Observation Station 3](https://www.hackerrank.com/challenges/weather-observation-station-3/problem) | [SQL](src/basic_select/weather_observation_station_3.sql) | [setup](fixtures/station.sql) |
| [Weather Observation Station 4](https://www.hackerrank.com/challenges/weather-observation-station-4/problem) | [SQL](src/basic_select/weather_observation_station_4.sql) | [setup](fixtures/station.sql) |
| [Weather Observation Station 5](https://www.hackerrank.com/challenges/weather-observation-station-5/problem) | [SQLite](src/basic_select/weather_observation_station_5.sql) · [MySQL](src/mysql/basic_select/weather_observation_station_5.sql) | [setup](fixtures/station.sql) |
| [Weather Observation Station 6](https://www.hackerrank.com/challenges/weather-observation-station-6/problem) | [SQL](src/basic_select/weather_observation_station_6.sql) | [setup](fixtures/station.sql) |
| [Weather Observation Station 7](https://www.hackerrank.com/challenges/weather-observation-station-7/problem) | [SQL](src/basic_select/weather_observation_station_7.sql) | [setup](fixtures/station.sql) |
| [Weather Observation Station 8](https://www.hackerrank.com/challenges/weather-observation-station-8/problem) | [SQL](src/basic_select/weather_observation_station_8.sql) | [setup](fixtures/station.sql) |
| [Weather Observation Station 9](https://www.hackerrank.com/challenges/weather-observation-station-9/problem) | [SQL](src/basic_select/weather_observation_station_9.sql) | [setup](fixtures/station.sql) |
| [Weather Observation Station 10](https://www.hackerrank.com/challenges/weather-observation-station-10/problem) | [SQL](src/basic_select/weather_observation_station_10.sql) | [setup](fixtures/station.sql) |
| [Weather Observation Station 11](https://www.hackerrank.com/challenges/weather-observation-station-11/problem) | [SQL](src/basic_select/weather_observation_station_11.sql) | [setup](fixtures/station.sql) |
| [Weather Observation Station 12](https://www.hackerrank.com/challenges/weather-observation-station-12/problem) | [SQL](src/basic_select/weather_observation_station_12.sql) | [setup](fixtures/station.sql) |
| [Higher Than 75 Marks](https://www.hackerrank.com/challenges/more-than-75-marks/problem) | [SQL](src/basic_select/higher_than_75_marks.sql) | [setup](fixtures/students.sql) |
| [Employee Names](https://www.hackerrank.com/challenges/name-of-employees/problem) | [SQL](src/basic_select/employee_names.sql) | [setup](fixtures/employee.sql) |
| [Employee Salaries](https://www.hackerrank.com/challenges/salary-of-employees/problem) | [SQL](src/basic_select/employee_salaries.sql) | [setup](fixtures/employee.sql) |

### Advanced Select

| Problem | Solution | Setup with inserts |
| --- | --- | --- |
| [Type of Triangle](https://www.hackerrank.com/challenges/what-type-of-triangle/problem) | [SQL](src/advanced_select/type_of_triangle.sql) | [setup](fixtures/triangles.sql) |
| [The PADS](https://www.hackerrank.com/challenges/the-pads/problem) | [SQLite](src/advanced_select/the_pads.sql) · [MySQL](src/mysql/advanced_select/the_pads.sql) | [setup](fixtures/occupations.sql) |
| [Occupations](https://www.hackerrank.com/challenges/occupations/problem) | [SQL](src/advanced_select/occupations.sql) | [setup](fixtures/occupations.sql) |
| [Binary Tree Nodes](https://www.hackerrank.com/challenges/binary-search-tree-1/problem) | [SQL](src/advanced_select/binary_tree_nodes.sql) | [setup](fixtures/binary_tree.sql) |
| [New Companies](https://www.hackerrank.com/challenges/the-company/problem) | [SQL](src/advanced_select/new_companies.sql) | [setup](fixtures/companies.sql) |

### Aggregation

| Problem | Solution | Setup with inserts |
| --- | --- | --- |
| [Revising Aggregations - The Count Function](https://www.hackerrank.com/challenges/revising-aggregations-the-count-function/problem) | [SQL](src/aggregation/revising_aggregations_the_count_function.sql) | [setup](fixtures/city.sql) |
| [Revising Aggregations - The Sum Function](https://www.hackerrank.com/challenges/revising-aggregations-sum/problem) | [SQL](src/aggregation/revising_aggregations_the_sum_function.sql) | [setup](fixtures/city.sql) |
| [Revising Aggregations - Averages](https://www.hackerrank.com/challenges/revising-aggregations-the-average-function/problem) | [SQL](src/aggregation/revising_aggregations_averages.sql) | [setup](fixtures/city.sql) |
| [Average Population](https://www.hackerrank.com/challenges/average-population/problem) | [SQL](src/aggregation/average_population.sql) | [setup](fixtures/city.sql) |
| [Japan Population](https://www.hackerrank.com/challenges/japan-population/problem) | [SQL](src/aggregation/japan_population.sql) | [setup](fixtures/city.sql) |
| [Population Density Difference](https://www.hackerrank.com/challenges/population-density-difference/problem) | [SQL](src/aggregation/population_density_difference.sql) | [setup](fixtures/city.sql) |
| [The Blunder](https://www.hackerrank.com/challenges/the-blunder/problem) | [SQL](src/aggregation/the_blunder.sql) | [setup](fixtures/employees.sql) |
| [Top Earners](https://www.hackerrank.com/challenges/earnings-of-employees/problem) | [SQL](src/aggregation/top_earners.sql) | [setup](fixtures/employee.sql) |
| [Weather Observation Station 2](https://www.hackerrank.com/challenges/weather-observation-station-2/problem) | [SQL](src/aggregation/weather_observation_station_2.sql) | [setup](fixtures/station.sql) |
| [Weather Observation Station 13](https://www.hackerrank.com/challenges/weather-observation-station-13/problem) | [SQL](src/aggregation/weather_observation_station_13.sql) | [setup](fixtures/station.sql) |
| [Weather Observation Station 14](https://www.hackerrank.com/challenges/weather-observation-station-14/problem) | [SQL](src/aggregation/weather_observation_station_14.sql) | [setup](fixtures/station.sql) |
| [Weather Observation Station 15](https://www.hackerrank.com/challenges/weather-observation-station-15/problem) | [SQL](src/aggregation/weather_observation_station_15.sql) | [setup](fixtures/station.sql) |
| [Weather Observation Station 16](https://www.hackerrank.com/challenges/weather-observation-station-16/problem) | [SQL](src/aggregation/weather_observation_station_16.sql) | [setup](fixtures/station.sql) |
| [Weather Observation Station 17](https://www.hackerrank.com/challenges/weather-observation-station-17/problem) | [SQL](src/aggregation/weather_observation_station_17.sql) | [setup](fixtures/station.sql) |
| [Weather Observation Station 18](https://www.hackerrank.com/challenges/weather-observation-station-18/problem) | [SQL](src/aggregation/weather_observation_station_18.sql) | [setup](fixtures/station.sql) |
| [Weather Observation Station 19](https://www.hackerrank.com/challenges/weather-observation-station-19/problem) | [SQL](src/aggregation/weather_observation_station_19.sql) | [setup](fixtures/station.sql) |
| [Weather Observation Station 20](https://www.hackerrank.com/challenges/weather-observation-station-20/problem) | [SQL](src/aggregation/weather_observation_station_20.sql) | [setup](fixtures/station.sql) |

### Basic Join

| Problem | Solution | Setup with inserts |
| --- | --- | --- |
| [Population Census](https://www.hackerrank.com/challenges/asian-population/problem) | [SQL](src/basic_join/population_census.sql) | [setup](fixtures/city.sql) |
| [African Cities](https://www.hackerrank.com/challenges/african-cities/problem) | [SQL](src/basic_join/african_cities.sql) | [setup](fixtures/city.sql) |
| [Average Population of Each Continent](https://www.hackerrank.com/challenges/average-population-of-each-continent/problem) | [SQL](src/basic_join/average_population_of_each_continent.sql) | [setup](fixtures/city.sql) |
| [The Report](https://www.hackerrank.com/challenges/the-report/problem) | [SQL](src/basic_join/the_report.sql) | [setup](fixtures/report.sql) |
| [Top Competitors](https://www.hackerrank.com/challenges/full-score/problem) | [SQL](src/basic_join/the_competitors.sql) | [setup](fixtures/competitors.sql) |
| [Ollivander's Inventory](https://www.hackerrank.com/challenges/harry-potter-and-wands/problem) | [SQL](src/basic_join/ollivanders_inventory.sql) | [setup](fixtures/wands.sql) |
| [Challenges](https://www.hackerrank.com/challenges/challenges/problem) | [SQL](src/basic_join/challenges.sql) | [setup](fixtures/challenges.sql) |
| [Contest Leaderboard](https://www.hackerrank.com/challenges/contest-leaderboard/problem) | [SQL](src/basic_join/contest_leaderboard.sql) | [setup](fixtures/leaderboard.sql) |

### Advanced Join

| Problem | Solution | Setup with inserts |
| --- | --- | --- |
| [SQL Project Planning](https://www.hackerrank.com/challenges/sql-projects/problem) | [SQL](src/advanced_join/project_planning.sql) | [setup](fixtures/projects.sql) |
| [Placements](https://www.hackerrank.com/challenges/placements/problem) | [SQL](src/advanced_join/placement.sql) | [setup](fixtures/placements.sql) |
| [Symmetric Pairs](https://www.hackerrank.com/challenges/symmetric-pairs/problem) | [SQL](src/advanced_join/symmetric_pairs.sql) | [setup](fixtures/functions.sql) |
| [Interviews](https://www.hackerrank.com/challenges/interviews/problem) | [SQL](src/advanced_join/interviews.sql) | [setup](fixtures/interviews.sql) |
| [15 Days of Learning SQL](https://www.hackerrank.com/challenges/15-days-of-learning-sql/problem) | [SQL](src/advanced_join/15_days_of_learning.sql) | [setup](fixtures/learning.sql) |

### Alternative Queries

| Problem | Solution | Setup with inserts |
| --- | --- | --- |
| [Draw The Triangle 1](https://www.hackerrank.com/challenges/draw-the-triangle-1/problem) | [SQLite](src/alternative_queries/draw_triangle_1.sql) · [MySQL](src/mysql/alternative_queries/draw_triangle_1.sql) | [setup](fixtures/no_tables.sql) |
| [Draw The Triangle 2](https://www.hackerrank.com/challenges/draw-the-triangle-2/problem) | [SQLite](src/alternative_queries/draw_triangle_2.sql) · [MySQL](src/mysql/alternative_queries/draw_triangle_2.sql) | [setup](fixtures/no_tables.sql) |
| [Print Prime Numbers](https://www.hackerrank.com/challenges/print-prime-numbers/problem) | [SQLite](src/alternative_queries/print_prime_numbers.sql) · [MySQL](src/mysql/alternative_queries/print_prime_numbers.sql) | [setup](fixtures/no_tables.sql) |
