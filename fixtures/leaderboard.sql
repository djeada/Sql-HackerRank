-- Small local test data; running this file again resets these tables.

DROP TABLE IF EXISTS HACKERS;
CREATE TABLE HACKERS (
    HACKER_ID INTEGER PRIMARY KEY,
    NAME VARCHAR(50)
);
INSERT INTO HACKERS VALUES
    (1, 'Ada'),
    (2, 'Bob'),
    (3, 'Cara'),
    (4, 'Dan'),
    (5, 'Eve'),
    (6, 'Finn');

DROP TABLE IF EXISTS SUBMISSIONS;
CREATE TABLE SUBMISSIONS (
    SUBMISSION_ID INTEGER PRIMARY KEY,
    HACKER_ID INTEGER,
    CHALLENGE_ID INTEGER,
    SCORE INTEGER
);
INSERT INTO SUBMISSIONS VALUES
    (1, 1, 101, 10),
    (2, 1, 101, 20),
    (3, 1, 102, 30),
    (4, 2, 101, 50),
    (5, 3, 101, 0),
    (6, 4, 102, 15),
    (7, 4, 102, 10);
