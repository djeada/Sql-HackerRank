-- Small local test data; running this file again resets these tables.

DROP TABLE IF EXISTS OCCUPATIONS;
CREATE TABLE OCCUPATIONS (
    NAME VARCHAR(50),
    OCCUPATION VARCHAR(20)
);
INSERT INTO OCCUPATIONS VALUES
    ('Samantha', 'Doctor'),
    ('Julia', 'Actor'),
    ('Maria', 'Actor'),
    ('Meera', 'Singer'),
    ('Ashley', 'Professor'),
    ('Ketty', 'Professor'),
    ('Christeen', 'Professor'),
    ('Jane', 'Actor'),
    ('Jenny', 'Doctor'),
    ('Priya', 'Singer');
