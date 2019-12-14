CREATE OR REPLACE FUNCTION odwet_tygrysa(pseudo_param KOCURY.PSEUDO%TYPE) RETURN INTEGER
    AS
        podatek Integer;
        liczba_podwladnych Integer;
        liczba_wrogow INTEGER;
        funkcja KOCURY.FUNKCJA%TYPE;
    BEGIN
        SELECT CEIL(0.05*(NVL(PRZYDZIAL_MYSZY,0) + NVL(MYSZY_EXTRA, 0))) INTO podatek
        FROM KOCURY
            WHERE PSEUDO=pseudo_param;

        SELECT COUNT(PSEUDO) INTO liczba_podwladnych FROM KOCURY WHERE SZEF=pseudo_param;
        IF liczba_podwladnych = 0 THEN
            podatek := podatek + 2;
        END IF;

        SELECT COUNT(PSEUDO) INTO liczba_wrogow FROM WROGOWIE_KOCUROW WHERE PSEUDO=pseudo_param;
        IF liczba_wrogow = 0 THEN
            podatek := podatek + 1;
        END IF;

        --SZEF NIE LUBI MILUSIOW ZA WIRUSA
        SELECT FUNKCJA INTO funkcja FROM KOCURY WHERE PSEUDO=pseudo_param;
        IF funkcja = 'MILUSIA' THEN
            podatek := podatek +5;
        END IF;
    END;

CREATE OR REPLACE PACKAGE zad44
AS
    FUNCTION odwet_tygrysa(pseudo_param KOCURY.PSEUDO%TYPE) RETURN INTEGER;
    PROCEDURE wyjatki(nr_bandy2 BANDY.NR_BANDY%TYPE, nazwa_bandy BANDY.NAZWA%TYPE, teren2 BANDY.TEREN%TYPE);
END zad44;

CREATE OR REPLACE PACKAGE BODY zad44 AS
    FUNCTION odwet_tygrysa(pseudo_param KOCURY.PSEUDO%TYPE) RETURN INTEGER
        IS
            podatek Integer;
            liczba_podwladnych Integer;
            liczba_wrogow INTEGER;
            funkcja KOCURY.FUNKCJA%TYPE;
        BEGIN
            SELECT CEIL(0.05*(NVL(PRZYDZIAL_MYSZY,0) + NVL(MYSZY_EXTRA, 0))) INTO podatek
            FROM KOCURY
                WHERE PSEUDO=pseudo_param;

            SELECT COUNT(PSEUDO) INTO liczba_podwladnych FROM KOCURY WHERE SZEF=pseudo_param;
            IF liczba_podwladnych = 0 THEN
                podatek := podatek + 2;
            END IF;

            SELECT COUNT(PSEUDO) INTO liczba_wrogow FROM WROGOWIE_KOCUROW WHERE PSEUDO=pseudo_param;
            IF liczba_wrogow = 0 THEN
                podatek := podatek + 1;
            END IF;

            --SZEF NIE LUBI MILUSIOW ZA WIRUSA
            SELECT FUNKCJA INTO funkcja FROM KOCURY WHERE PSEUDO=pseudo_param;
            IF funkcja = 'MILUSIA' THEN
                podatek := podatek +5;
            END IF;
            RETURN podatek;
        END;

    PROCEDURE wyjatki(nr_bandy2 BANDY.NR_BANDY%TYPE, nazwa_bandy BANDY.NAZWA%TYPE, teren2 BANDY.TEREN%TYPE)
        IS
            ilosc INTEGER := 0;
            komunikat VARCHAR2(255);
            tooShort EXCEPTION;
            wrongValue EXCEPTION;
            istnieje EXCEPTION;
            BEGIN
                IF nr_bandy2 <= 0 THEN
                    RAISE wrongValue;
                END IF;

                IF LENGTH(nazwa_bandy) < 2 OR LENGTH(teren2) < 2 THEN
                    RAISE tooShort;
                END IF;

                SELECT COUNT(B.NR_BANDY) INTO ilosc
                FROM BANDY B
                WHERE B.NR_BANDY = nr_bandy2;

                IF ilosc > 0 THEN
                    komunikat := nr_bandy2 || ' ';
                END IF;

                SELECT COUNT(B.NR_BANDY) INTO ilosc
                FROM BANDY B
                WHERE B.NAZWA = nazwa_bandy;

                IF ilosc > 0 THEN
                    IF LENGTH(komunikat) <> 0 THEN
                        komunikat := komunikat || ', ' || nazwa_bandy || ' ';
                    ELSE
                        komunikat := nazwa_bandy || ' ';
                    END IF;
                END IF;

                SELECT COUNT(B.NR_BANDY) INTO ilosc
                FROM BANDY B
                WHERE B.TEREN = teren2;

                IF ilosc > 0 THEN
                    IF LENGTH(komunikat) <> 0 THEN
                        komunikat := komunikat || ', ' || teren2 || ' ';
                    ELSE
                        komunikat := teren2 || ' ';
                    END IF;
                END IF;

                IF LENGTH(komunikat) <> 0 THEN
                    RAISE istnieje;
                end if;

                INSERT INTO BANDY (NR_BANDY, NAZWA, TEREN, SZEF_BANDY)
                    VALUES (nr_bandy2, nazwa_bandy, teren2, NULL);
                EXCEPTION
                    WHEN istnieje THEN DBMS_OUTPUT.PUT_LINE(komunikat || 'już istnieje');
                    WHEN wrongValue THEN DBMS_OUTPUT.PUT_LINE('Wartosc numeru bandy musi byc wieksza od zera');
                    WHEN tooShort THEN DBMS_OUTPUT.PUT_LINE('Nazwa lub teren sa zbyt krotkie');
            END;
    END zad44;


BEGIN
  DBMS_OUTPUT.PUT(RPAD('PSEUDONIM',10));
  DBMS_OUTPUT.PUT(LPAD('PODATKEK',20));
  DBMS_OUTPUT.NEW_LINE();
  FOR kocur IN (SELECT PSEUDO FROM Kocury)
    LOOP
    DBMS_OUTPUT.PUT_LINE(RPAD(kocur.PSEUDO,10) || LPAD(zad44.odwet_tygrysa(kocur.PSEUDO),20));
  END LOOP;
  END;

DROP FUNCTION odwet_tygrysa;
DROP PACKAGE zad44;