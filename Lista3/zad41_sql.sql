CREATE OR REPLACE TRIGGER nr_bandy
BEFORE INSERT ON BANDY
    FOR EACH ROW
    DECLARE
        maks_numer BANDY.NR_BANDY%TYPE DEFAULT 0;
    BEGIN
        SELECT MAX(B.NR_BANDY) INTO maks_numer
        FROM BANDY B;
        :NEW.NR_BANDY := maks_numer+1;
    END;

BEGIN
    WYJATKI(10, 'HEJKA', 'OJOJOJ');
end;

SELECT * FROM BANDY;

ROLLBACK ;