-- Small local test data; running this file again resets these tables.

DROP TABLE IF EXISTS TRIANGLES;
CREATE TABLE TRIANGLES (
    A INTEGER,
    B INTEGER,
    C INTEGER
);
INSERT INTO TRIANGLES VALUES
    (3, 3, 3),
    (3, 3, 4),
    (3, 4, 5),
    (1, 2, 3),
    (2, 2, 5),
    (0, 1, 1);
