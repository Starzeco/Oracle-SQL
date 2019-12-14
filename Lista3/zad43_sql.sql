SET SERVEROUTPUT ON;
DECLARE
        CURSOR funkcje IS (SELECT FUNKCJA FROM FUNKCJE);
        ile INTEGER;
        suma_funkcji INTEGER DEFAULT 0;
        suma_bandy INTEGER DEFAULT 0;
    BEGIN

        DBMS_OUTPUT.PUT(RPAD('NAZWA BANDY', 20) || RPAD('PLEC', 6) || RPAD('ILE', 4));
        FOR fun IN funkcje
        LOOP
            DBMS_OUTPUT.PUT(LPAD(fun.FUNKCJA, 10));
        END LOOP;
        DBMS_OUTPUT.PUT(LPAD('SUMA', 10));
        DBMS_OUTPUT.NEW_LINE();
        DBMS_OUTPUT.PUT(RPAD('-', 120, '-'));
        FOR banda IN (SELECT NAZWA, NR_BANDY FROM BANDY WHERE SZEF_BANDY IS NOT NULL )
        LOOP
            --KOBIETY
            DBMS_OUTPUT.NEW_LINE();
            DBMS_OUTPUT.PUT(RPAD(banda.NAZWA, 20));

            DBMS_OUTPUT.PUT(RPAD('Kotka', 6));
            SELECT COUNT(PSEUDO) INTO ile FROM KOCURY WHERE NR_BANDY=banda.NR_BANDY AND PLEC = 'D';
            DBMS_OUTPUT.PUT(LPAD(ile, 4));

            FOR fun2 IN funkcje
            LOOP
                SELECT SUM(NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0)) INTO suma_funkcji
                FROM KOCURY
                WHERE FUNKCJA=fun2.FUNKCJA AND NR_BANDY=banda.NR_BANDY AND PLEC = 'D';
                DBMS_OUTPUT.PUT(LPAD(NVL(suma_funkcji,0), 10));
            END LOOP;

            SELECT SUM(NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0)) INTO suma_bandy
            FROM KOCURY
            WHERE PLEC='D' AND NR_BANDY=banda.NR_BANDY;
            DBMS_OUTPUT.PUT(LPAD(NVL(suma_bandy, 0), 10));
            --MEZCZYZNI
            DBMS_OUTPUT.NEW_LINE();
            DBMS_OUTPUT.PUT(RPAD(' ', 20));
            DBMS_OUTPUT.PUT(RPAD('Kocor', 6));
            SELECT COUNT(PSEUDO) INTO ile FROM KOCURY WHERE NR_BANDY=banda.NR_BANDY AND PLEC = 'M';
            DBMS_OUTPUT.PUT(LPAD(ile, 4));

            FOR fun2 IN funkcje
            LOOP
                SELECT SUM(NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0)) INTO suma_funkcji
                FROM KOCURY
                WHERE FUNKCJA=fun2.FUNKCJA AND NR_BANDY=banda.NR_BANDY AND PLEC = 'M';
                DBMS_OUTPUT.PUT(LPAD(NVL(suma_funkcji,0), 10));
            END LOOP;

            SELECT SUM(NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0)) INTO suma_bandy
            FROM KOCURY
            WHERE PLEC='M' AND NR_BANDY=banda.NR_BANDY;
            DBMS_OUTPUT.PUT(LPAD(NVL(suma_bandy, 0), 10));
        END LOOP;
         -- PODSUMOWANIE
        DBMS_OUTPUT.NEW_LINE();
        DBMS_OUTPUT.PUT('Z' || LPAD('-', 120, '-'));
        DBMS_OUTPUT.NEW_LINE();
        DBMS_OUTPUT.PUT(RPAD('ZJADA RAZEM', 30));
        FOR fun3 IN funkcje
        LOOP
            SELECT SUM(NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0)) INTO suma_funkcji
                FROM KOCURY
                    WHERE FUNKCJA = fun3.FUNKCJA;
            DBMS_OUTPUT.PUT(LPAD(NVL(suma_funkcji,0), 10));
        END LOOP;
        SELECT SUM(NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0)) INTO suma_bandy
        FROM KOCURY;
        DBMS_OUTPUT.PUT(LPAD(suma_bandy, 10));
        DBMS_OUTPUT.NEW_LINE();
    END;
/