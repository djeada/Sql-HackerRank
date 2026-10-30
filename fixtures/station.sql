-- Small local test data; running this file again resets these tables.

DROP TABLE IF EXISTS STATION;
CREATE TABLE STATION (
    ID INTEGER PRIMARY KEY,
    CITY VARCHAR(50),
    STATE CHAR(2),
    LAT_N DECIMAL(10, 5),
    LONG_W DECIMAL(10, 5)
);
INSERT INTO STATION VALUES
    (1, 'Rome', 'RM', '38.78800', '10.12345'),
    (2, 'Oslo', 'OS', '38.77800', '20.00000'),
    (3, 'Agra', 'AG', '100.12349', '30.54321'),
    (4, 'Lima', 'LI', '137.23450', '40.12345'),
    (5, 'A', 'AA', '137.23449', '50.98765'),
    (6, 'Erode', 'ER', '10.00000', '60.00004'),
    (7, 'Bern', 'BE', '150.98765', '70.12345'),
    (8, 'Rome', 'RM', '40.00006', '15.98765'),
    (9, 'Ulm', 'UL', '38.77799', '35.00000'),
    (10, 'Ababa', 'AB', '60.10005', '80.11111'),
    (11, 'I', 'II', '70.20009', '90.22222'),
    (12, 'Évora', 'EV', '80.30005', '100.33333');
