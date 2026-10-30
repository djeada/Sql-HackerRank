SELECT tree.N,
       CASE
           WHEN tree.P IS NULL THEN 'Root'
           WHEN EXISTS (SELECT 1 FROM BST AS child WHERE child.P = tree.N) THEN 'Inner'
           ELSE 'Leaf'
       END
FROM BST AS tree
ORDER BY tree.N;
