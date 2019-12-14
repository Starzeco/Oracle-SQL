SELECT PSEUDO, TO_CHAR(W_STADKU_OD, 'YYYY-MM-DD') "W STADKU",
       CASE
        WHEN EXTRACT(DAY FROM W_STADKU_OD) <= 15
            THEN TO_CHAR(NEXT_DAY(LAST_DAY('2019-09-24') - INTERVAL '7' DAY, 'Środa'), 'YYYY-MM-DD')
        ELSE TO_CHAR(NEXT_DAY(LAST_DAY(ADD_MONTHS('2019-09-24', 1)) - INTERVAL '7' DAY, 'Środa'), 'YYYY-MM-DD')
       END "WYPLATA"
    FROM KOCURY
    ORDER BY W_STADKU_OD;

SELECT pseudo, TO_CHAR(w_stadku_od, 'YYYY-MM-DD') "W STADKU",
       CASE
            WHEN EXTRACT(DAY FROM w_stadku_od) <= 15 AND NEXT_DAY(LAST_DAY('2019-09-26') - INTERVAL '7' DAY, 'Środa') > '2019-09-26' -- Ostatnia środa jest przed 26
                 THEN TO_CHAR(NEXT_DAY(LAST_DAY('2019-09-26') - INTERVAL '7' DAY, 'Środa'), 'YYYY-MM-DD')
            ELSE TO_CHAR(NEXT_DAY(LAST_DAY(ADD_MONTHS('2019-09-24', 1)) - INTERVAL '7' DAY, 'Środa'), 'YYYY-MM-DD')
       END "WYPLATA"
FROM Kocury
ORDER BY w_stadku_od;