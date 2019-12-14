SELECT RPAD('===>', (LEVEL - 1)*4, '===>') || (level-1) || '     ' || IMIE "Hierarchia", NVL(SZEF, 'Sam sobie panem') "Pseudo szefa", FUNKCJA Funkcja

FROM KOCURY
WHERE MYSZY_EXTRA IS NOT NULL
CONNECT BY PRIOR PSEUDO=SZEF
START WITH SZEF IS NULL