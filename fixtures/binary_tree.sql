-- Small local test data; running this file again resets these tables.

DROP TABLE IF EXISTS BST;
CREATE TABLE BST (
    N INTEGER,
    P INTEGER
);
INSERT INTO BST VALUES
    (3, 2),
    (1, 2),
    (2, 4),
    (4, NULL),
    (6, 4),
    (5, 6),
    (7, 6);
