SELECT CASE
        WHEN COUNT(DISTINCT PSEUDO) = COUNT(PSEUDO) THEN PSEUDO || ' - Unikalny'
        ELSE PSEUDO || ' - Nieunikalny'
       END "Unikalnosc atr. PSEUDO"
    FROM KOCURY
    GROUP BY PSEUDO
    ORDER BY PSEUDO;

SELECT CASE
        WHEN COUNT(DISTINCT SZEF) = COUNT(SZEF) THEN SZEF || ' - Unikalny'
        ELSE SZEF || ' - nieunikalny'
       END "Unikalnosc atr. SZEF"
    FROM KOCURY
    GROUP BY SZEF
    HAVING SZEF IS NOT NULL
    ORDER BY SZEF;