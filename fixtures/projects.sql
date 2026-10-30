-- Small local test data; running this file again resets these tables.

DROP TABLE IF EXISTS PROJECTS;
CREATE TABLE PROJECTS (
    TASK_ID INTEGER PRIMARY KEY,
    START_DATE DATE,
    END_DATE DATE
);
INSERT INTO PROJECTS VALUES
    (3, '2015-10-03', '2015-10-04'),
    (1, '2015-10-01', '2015-10-02'),
    (2, '2015-10-02', '2015-10-03'),
    (4, '2015-10-10', '2015-10-11'),
    (5, '2015-10-12', '2015-10-13'),
    (7, '2015-11-01', '2015-11-02'),
    (6, '2015-10-31', '2015-11-01');
