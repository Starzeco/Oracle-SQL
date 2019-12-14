-- Zminimalizować liczbe SELECT w petli, da się dynamicznie w dwóch SELECT

DECLARE
    liczba_szefow INTEGER := ?;
    wypisane_drzewo BOOLEAN := false;
    max_szefow INTEGER;
    ktory_szef INTEGER;
    BEGIN
        SELECT MAX(LEVEL)-1 INTO max_szefow
            FROM KOCURY
            START WITH SZEF IS NULL
            CONNECT BY PRIOR PSEUDO = SZEF;

        IF max_szefow < liczba_szefow THEN
            liczba_szefow := max_szefow;
        END IF;

        DBMS_OUTPUT.PUT(RPAD('Imie', 10) || '|');
        FOR ii IN 1..liczba_szefow
        LOOP
            DBMS_OUTPUT.PUT(RPAD('Szef ' || ii, 10) || '|');
        END LOOP;
        DBMS_OUTPUT.NEW_LINE();
        DBMS_OUTPUT.PUT('----------');
        FOR ii IN 1..liczba_szefow
        LOOP
            DBMS_OUTPUT.PUT('-----------');
        END LOOP;
        DBMS_OUTPUT.NEW_LINE();
        DBMS_OUTPUT.NEW_LINE();
        --Header
        <<Zewnetrzna>>for wiersz IN (SELECT PSEUDO FROM KOCURY WHERE FUNKCJA IN ('KOT', 'MILUSIA'))
        LOOP
            wypisane_drzewo := false;
            <<Wewnetrzna>> FOR wiersz_drugi IN (SELECT CONNECT_BY_ROOT PSEUDO "PSEUDO SZEFA", LEVEL "LEVEL", IMIE
                                                    FROM KOCURY
                                                    CONNECT BY PRIOR SZEF = PSEUDO
                                                    START WITH SZEF IS NOT NULL AND FUNKCJA IN ('KOT', 'MILUSIA'))
            LOOP
                IF wiersz.PSEUDO = wiersz_drugi."PSEUDO SZEFA" AND wiersz_drugi."LEVEL"-1 <= liczba_szefow THEN
                    DBMS_OUTPUT.PUT(RPAD(wiersz_drugi.IMIE, 10) || '|');
                    wypisane_drzewo := true;
                    ktory_szef := wiersz_drugi."LEVEL" - 1;
                ELSIF (wypisane_drzewo = true AND wiersz.PSEUDO <> wiersz_drugi."PSEUDO SZEFA") THEN
                    EXIT Wewnetrzna;
                END IF;
            END LOOP;
            IF ktory_szef < liczba_szefow THEN
                FOR ii IN ktory_szef..liczba_szefow-1
                LOOP
                    DBMS_OUTPUT.PUT(RPAD(' ', 10) || '|');
                END LOOP;
            END IF;
            DBMS_OUTPUT.NEW_LINE();
        END LOOP;
        /*
         Jeśli pseudo jest to samo co pseudo aktualnie szukane
         To wejdz w fora i wyswietlaj szefow az do liczba_szefow jesli aktualnie analizowany wiersz ma innego
         pseudo na root to jesli wyswietlono za malo szefow to wyswietlaj puste jak wystarczajaco to koneic petli
         */

        /*
         Potrzeba tablicy z pseudonimami
         Potrzeba kursora z drzewem
         */
    END;
/