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

DROP TABLE IF EXISTS CHALLENGES;
CREATE TABLE CHALLENGES (
    CHALLENGE_ID INTEGER PRIMARY KEY,
    HACKER_ID INTEGER
);
INSERT INTO CHALLENGES VALUES
    (101, 1),
    (102, 1),
    (103, 1),
    (104, 1),
    (105, 1),
    (201, 2),
    (202, 2),
    (203, 2),
    (204, 2),
    (205, 2),
    (301, 3),
    (302, 3),
    (303, 3),
    (401, 4),
    (402, 4),
    (403, 4),
    (501, 5),
    (502, 5),
    (601, 6);
