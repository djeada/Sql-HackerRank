-- Small local test data; running this file again resets these tables.

DROP TABLE IF EXISTS EMPLOYEES;
CREATE TABLE EMPLOYEES (
    ID INTEGER PRIMARY KEY,
    NAME VARCHAR(50),
    SALARY INTEGER
);
INSERT INTO EMPLOYEES VALUES
    (1, 'Samantha', 1420),
    (2, 'Julia', 2006),
    (3, 'Maria', 2210),
    (4, 'Ashley', 1000);
