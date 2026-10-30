-- ASCII vowel codes keep accent-insensitive collations from treating É as E.
SELECT DISTINCT CITY
FROM STATION
WHERE HEX(UPPER(SUBSTR(CITY, 1, 1))) IN ('41', '45', '49', '4F', '55')
  AND HEX(UPPER(SUBSTR(CITY, -1))) IN ('41', '45', '49', '4F', '55');
