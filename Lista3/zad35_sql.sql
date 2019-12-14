DECLARE
    wiersz KOCURY%ROWTYPE;
    BEGIN
           SELECT * INTO wiersz
            FROM KOCURY K
                WHERE K.PSEUDO = ?;
           IF NVL(wiersz.PRZYDZIAL_MYSZY, 0) + NVL(wiersz.MYSZY_EXTRA, 0) > 700 THEN
                DBMS_OUTPUT.PUT_LINE(wiersz.IMIE || ' calkowity roczny przydzial myszy >700');
                IF wiersz.IMIE LIKE '%A%' THEN
                    DBMS_OUTPUT.PUT_LINE(wiersz.IMIE || ' imię zawiera litere A');
                    IF EXTRACT(MONTH FROM wiersz.W_STADKU_OD) = 1 THEN
                        DBMS_OUTPUT.PUT_LINE(wiersz.IMIE || ' styczeń jest miesiacem przystapienia do stada');
                        ELSE
                            DBMS_OUTPUT.PUT_LINE(wiersz.IMIE || ' nie odpowiada kryteriom');
                    END IF;
                ELSE
                    DBMS_OUTPUT.PUT_LINE(wiersz.IMIE || ' nie odpowiada kryteriom');
                END IF;
            ELSE
               DBMS_OUTPUT.PUT_LINE(wiersz.IMIE || ' nie odpowiada kryteriom');
           END IF;
           EXCEPTION
                WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Nie znaleziono kota o takim pseudo');
                WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
/