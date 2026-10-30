-- ASCII vowel codes keep accent-insensitive collations from treating É as E.
SELECT DISTINCT CITY
FROM STATION
WHERE HEX(UPPER(SUBSTR(CITY, 1, 1))) NOT IN ('41', '45', '49', '4F', '55');
