-- Small local test data; running this file again resets these tables.

DROP TABLE IF EXISTS CITY;
CREATE TABLE CITY (
    ID INTEGER PRIMARY KEY,
    NAME VARCHAR(50),
    COUNTRYCODE CHAR(3),
    DISTRICT VARCHAR(30),
    POPULATION INTEGER
);
INSERT INTO CITY VALUES
    (1, 'Oakland', 'USA', 'California', 110000),
    (2, 'Fresno', 'USA', 'California', 130001),
    (3, 'Salinas', 'USA', 'California', 100000),
    (4, 'Concord', 'USA', 'California', 120000),
    (5, 'Albany', 'USA', 'New York', 90000),
    (1661, 'Tokyo', 'JPN', 'Tokyo', 8310000),
    (1662, 'Osaka', 'JPN', 'Osaka', 2600000),
    (6, 'Cairo', 'EGY', 'Cairo', 9000000),
    (7, 'Nairobi', 'KEN', 'Nairobi', 3500000),
    (8, 'Paris', 'FRA', 'Ile-de-France', 2200000),
    (9, 'Sydney', 'AUS', 'New South Wales', 5000000);

DROP TABLE IF EXISTS COUNTRY;
CREATE TABLE COUNTRY (
    CODE CHAR(3) PRIMARY KEY,
    NAME VARCHAR(50),
    CONTINENT VARCHAR(30)
);
INSERT INTO COUNTRY VALUES
    ('USA', 'United States', 'North America'),
    ('JPN', 'Japan', 'Asia'),
    ('EGY', 'Egypt', 'Africa'),
    ('KEN', 'Kenya', 'Africa'),
    ('FRA', 'France', 'Europe'),
    ('AUS', 'Australia', 'Oceania'),
    ('CHN', 'China', 'Asia');
