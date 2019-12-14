CREATE OR REPLACE PROCEDURE wyjatki(nr_bandy2 BANDY.NR_BANDY%TYPE, nazwa_bandy BANDY.NAZWA%TYPE, teren2 BANDY.TEREN%TYPE)
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


BEGIN
    wyjatki(1, 'SZEFOSTWO', 'SAD');
end;
SELECT * FROM USER_OBJECTS;
SELECT * FROM BANDY;

DROP PROCEDURE wyjatki;
ROLLBACK;