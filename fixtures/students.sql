-- Small local test data; running this file again resets these tables.

DROP TABLE IF EXISTS STUDENTS;
CREATE TABLE STUDENTS (
    ID INTEGER PRIMARY KEY,
    NAME VARCHAR(50),
    MARKS INTEGER
);
INSERT INTO STUDENTS VALUES
    (1, 'Ashley', 81),
    (2, 'Julia', 76),
    (3, 'Belvet', 84),
    (4, 'Stuart', 75),
    (5, 'Samantha', 80),
    (6, 'Charlie', 81),
    (7, 'A', 90),
    (8, 'Bradley', 77);
