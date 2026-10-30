-- Small local test data; running this file again resets these tables.

DROP TABLE IF EXISTS STUDENTS;
CREATE TABLE STUDENTS (
    ID INTEGER PRIMARY KEY,
    NAME VARCHAR(50),
    MARKS INTEGER
);
INSERT INTO STUDENTS VALUES
    (1, 'Zoe', 61),
    (2, 'Amy', 65),
    (3, 'Bob', 78),
    (4, 'Dan', 85),
    (5, 'Eve', 85),
    (6, 'Ada', 90),
    (7, 'Lin', 0),
    (8, 'Jay', 100);

DROP TABLE IF EXISTS GRADES;
CREATE TABLE GRADES (
    GRADE INTEGER,
    MIN_MARK INTEGER,
    MAX_MARK INTEGER
);
INSERT INTO GRADES VALUES
    (1, 0, 9),
    (2, 10, 19),
    (3, 20, 29),
    (4, 30, 39),
    (5, 40, 49),
    (6, 50, 59),
    (7, 60, 69),
    (8, 70, 79),
    (9, 80, 89),
    (10, 90, 100);
