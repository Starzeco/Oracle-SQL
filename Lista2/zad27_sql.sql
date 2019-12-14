--Podpunkt a
SELECT PSEUDO, NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0) "ZJADA"
FROM KOCURY K
WHERE $(n) > (
    SELECT COUNT(DISTINCT K2.PRZYDZIAL_MYSZY)
    FROM KOCURY K2
    WHERE NVL(K2.PRZYDZIAL_MYSZY, 0) + NVL(K2.MYSZY_EXTRA, 0)
              > NVL(K.PRZYDZIAL_MYSZY, 0) + NVL(K.MYSZY_EXTRA, 0))
ORDER BY "ZJADA" DESC;
--Podpunkt b
SELECT PSEUDO, NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0) "ZJADA"
FROM KOCURY
WHERE NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0) IN (SELECT "ZJADA"
                                                            FROM (SELECT PSEUDO, NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0) "ZJADA" -- Pseudo gwarantuje bez powtórzen
                                                                    FROM KOCURY
                                                                    ORDER BY "ZJADA" DESC)
                                                            WHERE ROWNUM <=$(n));
--Podpunkt c
SELECT K1.PSEUDO, MIN(NVL(K1.PRZYDZIAL_MYSZY,0) + NVL(K1.MYSZY_EXTRA, 0)) "ZJADA"
FROM KOCURY K1, KOCURY K2
WHERE (NVL(K1.PRZYDZIAL_MYSZY,0)  + NVL(K1.MYSZY_EXTRA, 0)) <= (NVL(K2.PRZYDZIAL_MYSZY,0)  + NVL(K2.MYSZY_EXTRA, 0))
GROUP BY K1.PSEUDO
HAVING COUNT(DISTINCT NVL(K2.PRZYDZIAL_MYSZY,0)  + NVL(K2.MYSZY_EXTRA, 0)) <= $(n)
ORDER BY "ZJADA" DESC;

--Podpunkt d
SELECT PSEUDO, "ZJADA"
FROM (SELECT PSEUDO, DENSE_RANK() OVER (
    ORDER BY NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0) DESC
    ) "POZYCJA", NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0) "ZJADA"
    FROM KOCURY)
WHERE "POZYCJA" <= $(n)