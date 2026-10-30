WITH RECURSIVE triangle (N, LINE) AS (
    SELECT 1, '*'
    UNION ALL
    SELECT N + 1, LINE || ' *'
    FROM triangle
    WHERE N < 20
)
SELECT LINE
FROM triangle
ORDER BY N DESC;
