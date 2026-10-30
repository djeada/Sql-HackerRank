-- Remove binary floating-point noise before truncating at four decimal places.
SELECT FLOOR(ROUND(MAX(LAT_N) * 10000, 6)) / 10000.0
FROM STATION
WHERE LAT_N < 137.2345;
