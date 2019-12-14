-- Podpunkt A

CREATE OR REPLACE PACKAGE paczka AS
        przydzial_tygrysa KOCURY.PRZYDZIAL_MYSZY%TYPE;
        bonus_dla_tygrysa INTEGER DEFAULT 0;
        kara_dla_tygrysa INTEGER DEFAULT 0;
        flaga BOOLEAN DEFAULT TRUE; -- FLAGA DO OSTATNIEGO WYZWALACZA
    END;

CREATE OR REPLACE TRIGGER znalezienie_przydzialu_tygrysa
    BEFORE UPDATE ON KOCURY
    BEGIN
        SELECT PRZYDZIAL_MYSZY INTO paczka.przydzial_tygrysa
        FROM KOCURY
        WHERE PSEUDO = 'TYGRYS';
    END;

CREATE OR REPLACE TRIGGER wirus
    BEFORE UPDATE ON KOCURY
    FOR EACH ROW
    WHEN ( OLD.FUNKCJA = 'MILUSIA' )
    DECLARE
        podwyzka INTEGER;
    BEGIN
        IF :NEW.PRZYDZIAL_MYSZY <= :OLD.PRZYDZIAL_MYSZY THEN
            DBMS_OUTPUT.PUT_LINE('To jakis zart, nie probuj obnizac przydzialu');
            :NEW.PRZYDZIAL_MYSZY := :OLD.PRZYDZIAL_MYSZY;
        ELSE
            podwyzka := :NEW.PRZYDZIAL_MYSZY - :OLD.PRZYDZIAL_MYSZY;
            IF podwyzka < 0.1*paczka.przydzial_tygrysa THEN
                DBMS_OUTPUT.PUT_LINE('Starasz sie, ale podwyzka powinna byc wieksza');
                paczka.kara_dla_tygrysa := paczka.kara_dla_tygrysa + 0.1*paczka.przydzial_tygrysa;
                :NEW.PRZYDZIAL_MYSZY := :NEW.PRZYDZIAL_MYSZY + 0.1*paczka.przydzial_tygrysa;
                :NEW.MYSZY_EXTRA := :NEW.MYSZY_EXTRA + 5;
                ELSIF podwyzka >= 0.1*paczka.przydzial_tygrysa THEN
                    DBMS_OUTPUT.PUT_LINE('Dobra robota Tygrysie');
                    paczka.bonus_dla_tygrysa := paczka.bonus_dla_tygrysa + 5;
            END IF;
        END IF;
    END;

CREATE OR REPLACE TRIGGER kara_i_nagroda
    AFTER UPDATE ON KOCURY
    DECLARE
        zmiana INTEGER := paczka.bonus_dla_tygrysa - paczka.kara_dla_tygrysa;
    BEGIN
        IF zmiana <> 0  AND paczka.flaga THEN
            paczka.flaga := False;
            DBMS_OUTPUT.PUT_LINE('Czas na Ciebie Tygrysie');
            UPDATE KOCURY SET PRZYDZIAL_MYSZY = PRZYDZIAL_MYSZY + zmiana WHERE PSEUDO='TYGRYS';
            paczka.flaga := True;
        END IF;
    END;

UPDATE KOCURY SET PRZYDZIAL_MYSZY = (PRZYDZIAL_MYSZY +1) WHERE FUNKCJA='MILUSIA';
SELECT * FROM KOCURY;
ROLLBACK ;

DROP TRIGGER znalezienie_przydzialu_tygrysa;
DROP TRIGGER wirus;
DROP TRIGGER kara_i_nagroda;
DROP PACKAGE paczka;
-- Podpunkt B

CREATE OR REPLACE TRIGGER wirus
    FOR UPDATE ON KOCURY
    WHEN ( OLD.FUNKCJA = 'MILUSIA' )
    COMPOUND TRIGGER
        przydzial_tygrysa KOCURY.PRZYDZIAL_MYSZY%TYPE;
        bonus_dla_tygrysa INTEGER DEFAULT 0;
        kara_dla_tygrysa INTEGER DEFAULT 0;
        flaga BOOLEAN DEFAULT TRUE; -- FLAGA DO OSTATNIEGO WYZWALACZA
    BEFORE STATEMENT IS
    BEGIN
        SELECT PRZYDZIAL_MYSZY INTO przydzial_tygrysa
        FROM KOCURY
        WHERE PSEUDO = 'TYGRYS';
    END BEFORE STATEMENT;

    BEFORE EACH ROW IS
        podwyzka INTEGER DEFAULT 0;
    BEGIN
         IF :NEW.PRZYDZIAL_MYSZY <= :OLD.PRZYDZIAL_MYSZY THEN
            DBMS_OUTPUT.PUT_LINE('To jakis zart, nie probuj obnizac przydzialu');
            :NEW.PRZYDZIAL_MYSZY := :OLD.PRZYDZIAL_MYSZY;
        ELSE
            podwyzka := :NEW.PRZYDZIAL_MYSZY - :OLD.PRZYDZIAL_MYSZY;
            IF podwyzka < 0.1*przydzial_tygrysa THEN
                DBMS_OUTPUT.PUT_LINE('Starasz sie, ale podwyzka powinna byc wieksza');
                kara_dla_tygrysa := kara_dla_tygrysa + 0.1*przydzial_tygrysa;
                :NEW.PRZYDZIAL_MYSZY := :NEW.PRZYDZIAL_MYSZY + 0.1*przydzial_tygrysa;
                :NEW.MYSZY_EXTRA := :NEW.MYSZY_EXTRA + 5;
                ELSIF podwyzka >= 0.1*przydzial_tygrysa THEN
                    DBMS_OUTPUT.PUT_LINE('Dobra robota Tygrysie');
                    bonus_dla_tygrysa := bonus_dla_tygrysa + 5;
            END IF;
        END IF;
    END BEFORE EACH ROW;

    AFTER STATEMENT IS
        zmiana INTEGER := bonus_dla_tygrysa - kara_dla_tygrysa;
    BEGIN
        IF zmiana <> 0  AND flaga THEN
            flaga := False;
            DBMS_OUTPUT.PUT_LINE('Czas na Ciebie Tygrysie');
            UPDATE KOCURY SET PRZYDZIAL_MYSZY = PRZYDZIAL_MYSZY + zmiana WHERE PSEUDO='TYGRYS';
            flaga := True;
        END IF;
    END AFTER STATEMENT;
END wirus;

UPDATE KOCURY SET PRZYDZIAL_MYSZY = (PRZYDZIAL_MYSZY +1) WHERE FUNKCJA='MILUSIA';
SELECT * FROM KOCURY;
ROLLBACK ;
DROP TRIGGER wirus;