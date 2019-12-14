SELECT FUNKCJA, ROUND(AVG(NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0))) "Srednio najw. i najm. myszy"
FROM KOCURY
WHERE FUNKCJA <> 'SZEFUNIO'
GROUP BY FUNKCJA
HAVING ROUND(AVG(NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0))) IN (
                                                              (SELECT MAX(ROUND(AVG(NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0))))
                                                               FROM KOCURY
                                                               WHERE FUNKCJA <> 'SZEFUNIO'
                                                               GROUP BY FUNKCJA),
                                                              (SELECT MIN(ROUND(AVG(NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0))))
                                                               FROM KOCURY
                                                               WHERE FUNKCJA <> 'SZEFUNIO'
                                                               GROUP BY FUNKCJA) );

/*
 NIE MOŻNA STOSOWAC FUNKCJI AGREGUJĄCEJ W WHERE
 PAMIĘTAC ZAWSZE NAWIAS NA ZAGNIEZDZONY SELECT
 JAK STOSUJE FUNKCJE AGREGUJACA TO TRZEBA GRUPOWAC (CHYBA) ------ Raczej nie koniecznie
 */

