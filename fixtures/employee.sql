-- Small local test data; running this file again resets these tables.

DROP TABLE IF EXISTS EMPLOYEE;
CREATE TABLE EMPLOYEE (
    EMPLOYEE_ID INTEGER PRIMARY KEY,
    NAME VARCHAR(50),
    MONTHS INTEGER,
    SALARY INTEGER
);
INSERT INTO EMPLOYEE VALUES
    (3, 'Zoe', 5, 3000),
    (1, 'Amy', 6, 2500),
    (2, 'Bob', 10, 2000),
    (4, 'Dan', 4, 5000),
    (5, 'Eve', 9, 2000),
    (6, 'Tim', 10, 1000);
