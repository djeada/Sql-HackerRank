SET 
  @NUMBER = 1;
SET 
  @DIVISOR = 1;
SELECT 
  GROUP_CONCAT(N SEPARATOR '&') 
FROM 
  (
    SELECT 
      @NUMBER := @NUMBER + 1 AS N 
    FROM 
      INFORMATION_SCHEMA.TABLES AS T1, 
      INFORMATION_SCHEMA.TABLES AS T2 
    LIMIT 
      1000
  ) AS N1 
WHERE 
  NOT EXISTS(
    SELECT 
      * 
    FROM 
      (
        SELECT 
          @DIVISOR := @DIVISOR + 1 AS D 
        FROM 
          INFORMATION_SCHEMA.TABLES AS T3, 
          INFORMATION_SCHEMA.TABLES AS T4 
        LIMIT 
          1000
      ) AS N2 
    WHERE 
      MOD(N, D) = 0 
      AND N <> D
  )
