SELECT IMIE, FUNKCJA, PRZYDZIAL_MYSZY "PRZYDZIAL MYSZY"
FROM KOCURY
WHERE PRZYDZIAL_MYSZY >= ALL (SELECT 3*PRZYDZIAL_MYSZY "PRZYDZIAL MYSZY"
    FROM KOCURY K JOIN BANDY B on K.NR_BANDY = B.NR_BANDY
    WHERE FUNKCJA='MILUSIA' AND B.TEREN IN ('CALOSC', 'SAD'));