SET 
  @NUMBER = 21;
SELECT 
  REPEAT('* ', @NUMBER := @NUMBER -1) 
FROM 
  INFORMATION_SCHEMA.TABLES 
WHERE 
  @NUMBER > 0;
