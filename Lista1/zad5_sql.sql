SELECT PSEUDO, REGEXP_REPLACE(REGEXP_REPLACE(PSEUDO, 'A', '#', 1, 1), 'L', '%', 1, 1) "Po wymianie A na # oraz L na %"
    FROM KOCURY
    WHERE PSEUDO LIKE '%L%' AND PSEUDO LIKE '%A%';