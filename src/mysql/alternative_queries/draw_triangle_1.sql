WITH RECURSIVE triangle (N, LINE) AS (
    SELECT 1, CAST('*' AS CHAR(39))
    UNION ALL
    SELECT N + 1, CONCAT(LINE, ' *')
    FROM triangle
    WHERE N < 20
)
SELECT LINE
FROM triangle
ORDER BY N DESC;
