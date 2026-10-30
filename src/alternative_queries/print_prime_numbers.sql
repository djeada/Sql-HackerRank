WITH RECURSIVE numbers (N) AS (
    SELECT 2
    UNION ALL
    SELECT N + 1 FROM numbers WHERE N < 1000
)
SELECT GROUP_CONCAT(N, '&')
FROM (
    SELECT candidate.N
    FROM numbers AS candidate
    WHERE NOT EXISTS (
        SELECT 1
        FROM numbers AS divisor
        WHERE divisor.N * divisor.N <= candidate.N
          AND candidate.N % divisor.N = 0
    )
    ORDER BY candidate.N
) AS primes;
