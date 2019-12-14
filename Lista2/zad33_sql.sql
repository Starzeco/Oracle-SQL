-- WSTAWIC NA SZTYWNO WSZYSTKIE FUNKCJE


-- Podpunkt a
SELECT CASE PLEC
    WHEN 'Kotka' THEN ' '
    ELSE NAZWA END "NAZWA", "PLEC", "ILE", "SZEFUNIO", "BANDZIOR", "LOWCZY", "LAPACZ", "KOT", "MILUSIA", "DZIELCZY", "SUMA"
FROM (SELECT NAZWA,
             CASE PLEC
             WHEN 'D' THEN 'Kotka'
             ELSE 'Kocor' END "PLEC",
             TO_CHAR(COUNT(PSEUDO)) "ILE",
             TO_CHAR(SUM(DECODE(FUNKCJA,'SZEFUNIO', NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_EXTRA,0),0))) "SZEFUNIO",
             TO_CHAR(SUM(DECODE(FUNKCJA, 'BANDZIOR', NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_EXTRA,0),0))) "BANDZIOR",
             TO_CHAR(SUM(DECODE(FUNKCJA, 'LOWCZY', NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_EXTRA,0),0))) "LOWCZY",
             TO_CHAR(SUM(DECODE(FUNKCJA, 'LAPACZ', NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_EXTRA,0),0))) "LAPACZ",
             TO_CHAR(SUM(DECODE(FUNKCJA, 'KOT', NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_EXTRA,0),0))) "KOT",
             TO_CHAR(SUM(DECODE(FUNKCJA, 'MILUSIA', NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_EXTRA,0),0))) "MILUSIA",
             TO_CHAR(SUM(DECODE(FUNKCJA, 'DZIELCZY', NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_EXTRA,0),0))) "DZIELCZY",
             TO_CHAR(SUM(NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_EXTRA,0))) "SUMA"
        FROM KOCURY K JOIN BANDY B ON K.NR_BANDY = B.NR_BANDY
        GROUP BY NAZWA, PLEC

UNION

SELECT 'Z----------------', '--------', '----------', '-----------', '-----------', '----------', '----------', '----------', '----------', '----------', '----------'
FROM DUAL

UNION

SELECT 'ZJADA RAZEM', ' ' "PLEC", ' ' "ILE",
             TO_CHAR(SUM(DECODE(FUNKCJA, 'SZEFUNIO', NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_EXTRA,0),0))) "SZEFUNIO",
             TO_CHAR(SUM(DECODE(FUNKCJA, 'BANDZIOR', NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_EXTRA,0),0))) "BANDZIOR",
             TO_CHAR(SUM(DECODE(FUNKCJA, 'LOWCZY', NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_EXTRA,0),0))) "LOWCZY",
             TO_CHAR(SUM(DECODE(FUNKCJA, 'LAPACZ', NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_EXTRA,0),0))) "LAPACZ",
             TO_CHAR(SUM(DECODE(FUNKCJA, 'KOT', NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_EXTRA,0),0))) "KOT",
             TO_CHAR(SUM(DECODE(FUNKCJA, 'MILUSIA', NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_EXTRA,0),0))) "MILUSIA",
             TO_CHAR(SUM(DECODE(FUNKCJA, 'DZIELCZY', NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_EXTRA,0),0))) "DZIELCZY",
             TO_CHAR(SUM(NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_EXTRA,0))) "SUMA"
FROM KOCURY K JOIN BANDY B ON K.NR_BANDY = B.NR_BANDY
ORDER BY 1, 2);



-- Podpunkt b
WITH Glowna AS (SELECT CASE PLEC
       WHEN 'D' THEN NAZWA
       ELSE ' ' END "NAZWA BANDY",
       CASE PLEC
       WHEN 'D' THEN 'Kotka'
       ELSE 'Kocor' END "PLEC",
       TO_CHAR((SELECT COUNT(PSEUDO)
       FROM KOCURY K2
       WHERE K2.PLEC = K.PLEC AND K2.NR_BANDY = K.NR_BANDY)) "ILE",
       FUNKCJA "FUNKCJA",
       TO_CHAR((SELECT SUM(NVL(K3.PRZYDZIAL_MYSZY, 0) + NVL(K3.MYSZY_EXTRA, 0))
        FROM KOCURY K3
        WHERE K3.PLEC = K.PLEC AND K3.NR_BANDY = K.NR_BANDY)) "SUMA",
        TO_CHAR(NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0)) "PRZYDZIAL"
FROM BANDY B JOIN KOCURY K on B.NR_BANDY = K.NR_BANDY)

SELECT "NAZWA BANDY", PLEC, ILE, TO_CHAR(NVL(SZEFUNIO, 0)) "SZEFUNIO", TO_CHAR(NVL(BANDZIOR, 0)) "BANDZIOR", TO_CHAR(NVL(LOWCZY, 0)) "LOWCZY", TO_CHAR(NVL(LAPACZ, 0)) "LAPACZ", TO_CHAR(NVL(KOT, 0)) "KOT", TO_CHAR(NVL(MILUSIA, 0)) "MILUSIA", TO_CHAR(NVL(DZIELCZY, 0)) "DZIELCZY", SUMA
FROM (SELECT *
        FROM Glowna
        PIVOT (
            SUM(NVL("PRZYDZIAL", 0))
            FOR FUNKCJA
            IN ( 'SZEFUNIO' "SZEFUNIO",
                'BANDZIOR'"BANDZIOR",
                'LOWCZY' "LOWCZY",
                'LAPACZ' "LAPACZ",
                'KOT' "KOT",
                'MILUSIA' "MILUSIA",
                'DZIELCZY' "DZIELCZY")
            ))


UNION

SELECT 'Z----------------', '--------', '----------', '-----------', '-----------', '----------', '----------', '----------', '----------', '----------', '----------'
FROM DUAL

UNION

SELECT "ZJADA RAZEM", PLEC, ILE, TO_CHAR(SZEFUNIO), TO_CHAR(BANDZIOR), TO_CHAR(LOWCZY), TO_CHAR(LAPACZ), TO_CHAR(KOT), TO_CHAR(MILUSIA), TO_CHAR(DZIELCZY), TO_CHAR(SUMA)
FROM (SELECT *
            FROM (SELECT 'ZJADA RAZEM' "ZJADA RAZEM",
                   ' ' "PLEC",
                   ' ' "ILE",
                   FUNKCJA,
                   SUM(NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0)) "FUN_SUM",
                  TO_CHAR((SELECT SUM(NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0)) FROM KOCURY)) "SUMA"
                  FROM KOCURY
                  GROUP BY FUNKCJA)
            PIVOT (
                MIN(FUN_SUM)
                FOR FUNKCJA
                IN( 'SZEFUNIO' "SZEFUNIO",
                    'BANDZIOR'"BANDZIOR",
                    'LOWCZY' "LOWCZY",
                    'LAPACZ' "LAPACZ",
                    'KOT' "KOT",
                    'MILUSIA' "MILUSIA",
                    'DZIELCZY' "DZIELCZY")
            ));