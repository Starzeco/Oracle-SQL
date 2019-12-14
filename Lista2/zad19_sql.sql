--Podpunkt a
SELECT K.IMIE "Imie", K.FUNKCJA, NVL(SZ1.IMIE, ' ') "Szef 1", NVL(SZ2.IMIE, ' ') "Szef 2", NVL(SZ3.IMIE, ' ') "Szef 3"
    FROM KOCURY K
        JOIN KOCURY SZ1 ON K.SZEF = SZ1.PSEUDO AND K.FUNKCJA IN ('KOT', 'MILUSIA')
        LEFT JOIN KOCURY SZ2 ON SZ1.SZEF = SZ2.PSEUDO
        LEFT JOIN KOCURY SZ3 ON SZ2.SZEF = SZ3.PSEUDO;

--Podpunkt b
SELECT "Imie_pierwszego", "Funkcja_pierwszego", NVL(szef1, ' ') "SZEF 1", NVL(szef2, ' ') "SZEF 2", NVL(szef3, ' ') "SZEF 3"
FROM
    (SELECT CONNECT_BY_ROOT IMIE "Imie_pierwszego", CONNECT_BY_ROOT FUNKCJA "Funkcja_pierwszego", LEVEL "level", IMIE
    FROM KOCURY
    CONNECT BY PRIOR SZEF = PSEUDO
    START WITH SZEF IS NOT NULL AND FUNKCJA IN ('KOT', 'MILUSIA'))
PIVOT (
        MAX(IMIE)
        FOR "level"
        IN (2 szef1,3 szef2,4 szef3)
        );

--Podpunkt c


SELECT "Imie_pierwszego", "Funkcja_pierwszego", SUBSTR(MAX("Szefowie"), 13, 50) "Imiona kolejnych szefow"
FROM (SELECT CONNECT_BY_ROOT IMIE "Imie_pierwszego", CONNECT_BY_ROOT FUNKCJA "Funkcja_pierwszego", SYS_CONNECT_BY_PATH(RPAD(IMIE, 10, ' '), '| ') "Szefowie"
    FROM KOCURY
    CONNECT BY PRIOR SZEF = PSEUDO
    START WITH SZEF IS NOT NULL AND FUNKCJA IN ('KOT', 'MILUSIA'))
GROUP BY "Funkcja_pierwszego","Imie_pierwszego";