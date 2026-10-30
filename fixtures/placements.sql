-- Small local test data; running this file again resets these tables.

DROP TABLE IF EXISTS STUDENTS;
CREATE TABLE STUDENTS (
    ID INTEGER PRIMARY KEY,
    NAME VARCHAR(50)
);
INSERT INTO STUDENTS VALUES
    (1, 'Ada'),
    (2, 'Bob'),
    (3, 'Cara'),
    (4, 'Dan');

DROP TABLE IF EXISTS FRIENDS;
CREATE TABLE FRIENDS (
    ID INTEGER,
    FRIEND_ID INTEGER
);
INSERT INTO FRIENDS VALUES
    (1, 2),
    (2, 3),
    (3, 4),
    (4, 3);

DROP TABLE IF EXISTS PACKAGES;
CREATE TABLE PACKAGES (
    ID INTEGER,
    SALARY DECIMAL(10, 2)
);
INSERT INTO PACKAGES VALUES
    (1, '10.00'),
    (2, '15.00'),
    (3, '12.00'),
    (4, '15.00');
