SET 
  @ROWINDEX := -1;
SELECT 
  ROUND(AVG(T.LAT_N), 4)
FROM
  (
  SELECT 
    @ROWINDEX := @ROWINDEX+1 
    AS 
      ROWINDEX, S.LAT_N 
    FROM 
      STATION 
    AS 
      S 
    ORDER BY 
      S.LAT_N
  ) 
AS 
  T
WHERE 
  T.ROWINDEX 
IN 
  (FLOOR(@ROWINDEX / 2), CEIL(@ROWINDEX / 2));
