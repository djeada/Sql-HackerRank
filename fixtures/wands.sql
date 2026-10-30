-- Small local test data; running this file again resets these tables.

DROP TABLE IF EXISTS WANDS;
CREATE TABLE WANDS (
    ID INTEGER PRIMARY KEY,
    CODE INTEGER,
    COINS_NEEDED INTEGER,
    POWER INTEGER
);
INSERT INTO WANDS VALUES
    (1, 1, 20, 5),
    (2, 1, 15, 5),
    (3, 2, 10, 5),
    (4, 3, 1, 10),
    (5, 4, 30, 8),
    (6, 4, 20, 8),
    (7, 1, 25, 8),
    (8, 2, 10, 5);

DROP TABLE IF EXISTS WANDS_PROPERTY;
CREATE TABLE WANDS_PROPERTY (
    CODE INTEGER,
    AGE INTEGER,
    IS_EVIL INTEGER
);
INSERT INTO WANDS_PROPERTY VALUES
    (1, 10, 0),
    (2, 10, 0),
    (3, 20, 1),
    (4, 30, 0);
