SET SERVEROUTPUT ON;

DECLARE
    CURSOR kocury_posegregowane IS
        SELECT *
               FROM KOCURY K JOIN FUNKCJE F ON K.FUNKCJA = F.FUNKCJA
                ORDER BY K.PRZYDZIAL_MYSZY
                FOR UPDATE OF PRZYDZIAL_MYSZY;
    aktualna_suma INTEGER;
    suma_przed_podwyzkami INTEGER;
    pierwsze_przejscie BOOLEAN := true;
    liczba_zmian INTEGER := 0;
    wiersz kocury_posegregowane%ROWTYPE;
    BEGIN
        IF pierwsze_przejscie THEN
            SELECT SUM(NVL(PRZYDZIAL_MYSZY, 0)) INTO suma_przed_podwyzkami
            FROM KOCURY;
            pierwsze_przejscie := false;
        END IF;
        aktualna_suma := suma_przed_podwyzkami;

        <<Zewnetrzna>>LOOP  -- JAK JUZ RAZ PRZELECI PO RELACJI TO LECI JESZCZE RAZ PO TEJ SAME RELACJI
            OPEN kocury_posegregowane;
            <<Wewnetrzna>>LOOP -- Faktycznie przelatywanie relacji w tej pętli, zewnetrzna tylko okrelsa ile razy leciec po niej
                FETCH kocury_posegregowane INTO wiersz;
                EXIT Wewnetrzna WHEN kocury_posegregowane%NOTFOUND;

                IF 1.1*wiersz.PRZYDZIAL_MYSZY > wiersz.MAX_MYSZY THEN
                    IF wiersz.PRZYDZIAL_MYSZY <> wiersz.MAX_MYSZY THEN
                        liczba_zmian := liczba_zmian + 1;
                    END IF;
                    UPDATE KOCURY
                        SET PRZYDZIAL_MYSZY=wiersz.MAX_MYSZY
                        WHERE PSEUDO=wiersz.PSEUDO;
                    aktualna_suma := aktualna_suma + (wiersz.MAX_MYSZY - wiersz.PRZYDZIAL_MYSZY);
                ELSE
                    UPDATE KOCURY
                        SET PRZYDZIAL_MYSZY=1.1*wiersz.PRZYDZIAL_MYSZY
                        WHERE PSEUDO=wiersz.PSEUDO;
                    liczba_zmian := liczba_zmian + 1;
                    aktualna_suma := aktualna_suma + 0.1*wiersz.PRZYDZIAL_MYSZY;
                END IF;

                EXIT Zewnetrzna WHEN aktualna_suma > 1050;
            END LOOP;
            CLOSE kocury_posegregowane;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('Przydzial w stadku przed zmianami: ' || suma_przed_podwyzkami );
        DBMS_OUTPUT.PUT_LINE('Przydzial w stadku: ' || aktualna_suma );
        DBMS_OUTPUT.PUT_LINE('Zmian: ' || liczba_zmian );
    END;
/
SELECT IMIE, PRZYDZIAL_MYSZY
    FROM KOCURY;

ROLLBACK;

-- ROBI 35 zmian zamiast 30 ale nwm czemu // JUZ WIEM aktualizowalo jeszcze raz tego co ma juz maksymalne