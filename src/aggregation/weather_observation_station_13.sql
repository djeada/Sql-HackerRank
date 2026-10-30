-- Remove binary floating-point noise before truncating at four decimal places.
SELECT FLOOR(ROUND(SUM(LAT_N) * 10000, 6)) / 10000.0
FROM STATION
WHERE LAT_N > 38.7880 AND LAT_N < 137.2345;
