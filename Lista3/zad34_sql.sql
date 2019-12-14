
DECLARE
    fun KOCURY.FUNKCJA%TYPE;
    liczbaKocurow BINARY_INTEGER;
    funkcjaPodana VARCHAR2(14);
    BEGIN
        funkcjaPodana := ?;
        SELECT COUNT(K.PSEUDO), MIN(K.FUNKCJA) INTO liczbaKocurow, fun
            FROM KOCURY K
                WHERE K.FUNKCJA = funkcjaPodana;
        IF liczbaKocurow > 0 THEN
            DBMS_OUTPUT.PUT_LINE('Znaleziono kota/ke o funkcji: ' || fun);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Nie Znaleziono kota/ki');
        END IF;
    END;
/