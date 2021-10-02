SELECT 
  T2.SUBMISSION_DATE, 
  T2.HACKER_CNT, 
  H.HACKER_ID, 
  H.NAME 
FROM 
  (
    SELECT 
      SUBMISSION_DATE, 
      COUNT(DISTINCT HACKER_ID) AS HACKER_CNT 
    FROM 
      (
        SELECT 
          S1.SUBMISSION_DATE, 
          S1.HACKER_ID, 
          COUNT(DISTINCT S2.SUBMISSION_DATE) AS DAY_CNT 
        FROM 
          SUBMISSIONS S1 
          JOIN SUBMISSIONS S2 ON S2.HACKER_ID = S1.HACKER_ID 
          AND S2.SUBMISSION_DATE <= S1.SUBMISSION_DATE 
        GROUP BY 
          S1.SUBMISSION_DATE, 
          S1.HACKER_ID
      ) T4 
    WHERE 
      DATEDIFF(SUBMISSION_DATE, '2016-03-01') + 1 = DAY_CNT 
    GROUP BY 
      SUBMISSION_DATE
  ) T2 
  JOIN (
    SELECT 
      SUBMISSION_DATE, 
      HACKER_ID 
    FROM 
      (
        SELECT 
          SUBMISSION_DATE, 
          HACKER_ID, 
          COUNT(*) AS CNT 
        FROM 
          SUBMISSIONS 
        GROUP BY 
          SUBMISSION_DATE, 
          HACKER_ID
      ) T 
    WHERE 
      NOT EXISTS (
        SELECT 
          1 
        FROM 
          (
            SELECT 
              SUBMISSION_DATE, 
              HACKER_ID, 
              COUNT(*) AS CNT 
            FROM 
              SUBMISSIONS 
            GROUP BY 
              SUBMISSION_DATE, 
              HACKER_ID
          ) T1 
        WHERE 
          T1.SUBMISSION_DATE = T.SUBMISSION_DATE 
          AND T1.HACKER_ID <> T.HACKER_ID 
          AND (
            T1.CNT > T.CNT 
            OR (
              T1.CNT = T.CNT 
              AND T1.HACKER_ID < T.HACKER_ID
            )
          )
      )
  ) T3 ON T3.SUBMISSION_DATE = T2.SUBMISSION_DATE 
  JOIN HACKERS H ON H.HACKER_ID = T3.HACKER_ID 
ORDER BY 
  T2.SUBMISSION_DATE;
