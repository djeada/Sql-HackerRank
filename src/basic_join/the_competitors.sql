SELECT 
  H.HACKER_ID, 
  H.NAME 
FROM 
  SUBMISSIONS AS S 
  JOIN HACKERS AS H ON S.HACKER_ID = H.HACKER_ID 
  JOIN CHALLENGES AS C ON S.CHALLENGE_ID = C.CHALLENGE_ID 
  JOIN DIFFICULTY AS D ON C.DIFFICULTY_LEVEL = D.DIFFICULTY_LEVEL 
WHERE 
  S.SCORE = D.SCORE 
GROUP BY 
  H.HACKER_ID, 
  H.NAME 
HAVING 
  COUNT(*)> 1 
ORDER BY 
  COUNT(*) DESC, 
  H.HACKER_ID;
