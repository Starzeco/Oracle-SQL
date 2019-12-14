WITH Czarni AS(
    SELECT PSEUDO
    FROM KOCURY K JOIN BANDY B on K.NR_BANDY = B.NR_BANDY AND
                              B.NAZWA='CZARNI RYCERZE'
    ORDER BY W_STADKU_OD
),
     Laciaci AS(
     SELECT PSEUDO
     FROM KOCURY K JOIN BANDY B on K.NR_BANDY = B.NR_BANDY AND
                           B.NAZWA='LACIACI MYSLIWI'
     ORDER BY W_STADKU_OD
)
-- Przed Zmianami
SELECT PSEUDO "Pseudonim", PLEC "Plec", PRZYDZIAL_MYSZY "Myszy przed podw.", NVL(MYSZY_EXTRA, 0) "Extra przed podw."
FROM KOCURY
WHERE PSEUDO IN (SELECT PSEUDO
                FROM Czarni
                WHERE ROWNUM <=3
                UNION
                SELECT PSEUDO
                FROM Laciaci
                WHERE ROWNUM <=3);

-- Zmiana

UPDATE KOCURY K1
SET PRZYDZIAL_MYSZY = CASE PLEC
                        WHEN 'M' THEN PRZYDZIAL_MYSZY+10
                        ELSE PRZYDZIAL_MYSZY+0.1*(SELECT MIN(PRZYDZIAL_MYSZY)
                                                  FROM KOCURY) END,
    MYSZY_EXTRA=NVL(MYSZY_EXTRA, 0) + 0.15*(SELECT AVG(NVL(MYSZY_EXTRA, 0))
                                            FROM KOCURY K2
                                            WHERE K2.NR_BANDY=K1.NR_BANDY)
WHERE PSEUDO IN (SELECT PSEUDO
                FROM (SELECT PSEUDO
                        FROM KOCURY K JOIN BANDY B on K.NR_BANDY = B.NR_BANDY AND
                              B.NAZWA='CZARNI RYCERZE'
                        ORDER BY W_STADKU_OD)
                WHERE ROWNUM <=3
                UNION
                SELECT PSEUDO
                FROM (SELECT PSEUDO
                        FROM KOCURY K JOIN BANDY B on K.NR_BANDY = B.NR_BANDY AND
                                                        B.NAZWA='LACIACI MYSLIWI'
                        ORDER BY W_STADKU_OD)
                WHERE ROWNUM <=3);

-- Po zmianach
WITH Czarni AS(
    SELECT PSEUDO
    FROM KOCURY K JOIN BANDY B on K.NR_BANDY = B.NR_BANDY AND
                              B.NAZWA='CZARNI RYCERZE'
    ORDER BY W_STADKU_OD
),
     Laciaci AS(
     SELECT PSEUDO
     FROM KOCURY K JOIN BANDY B on K.NR_BANDY = B.NR_BANDY AND
                           B.NAZWA='LACIACI MYSLIWI'
     ORDER BY W_STADKU_OD
)
SELECT PSEUDO "Pseudonim", PLEC "Plec", PRZYDZIAL_MYSZY "Myszy przed podw.", NVL(MYSZY_EXTRA, 0) "Extra przed podw."
FROM KOCURY
WHERE PSEUDO IN (SELECT PSEUDO
                FROM Czarni
                WHERE ROWNUM <=3
                UNION
                SELECT PSEUDO
                FROM Laciaci
                WHERE ROWNUM <=3);
ROLLBACK