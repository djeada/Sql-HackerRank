-- Small local test data; running this file again resets these tables.

DROP TABLE IF EXISTS FUNCTIONS;
CREATE TABLE FUNCTIONS (
    X INTEGER,
    Y INTEGER
);
INSERT INTO FUNCTIONS VALUES
    (20, 20),
    (20, 20),
    (20, 21),
    (21, 20),
    (22, 23),
    (23, 22),
    (24, 24),
    (25, 26),
    (20, 21);
