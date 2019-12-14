SET SERVEROUTPUT ON;

DECLARE
    ii INTEGER := 0;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Nr    Pseudonim    Zjada');
        DBMS_OUTPUT.PUT_LINE('------------------------');
        FOR wiersz IN (SELECT PSEUDO "Pseudonim", NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0) "Zjada", DENSE_RANK() over (
            ORDER BY NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0) DESC
            ) "Nr"
            FROM KOCURY
            ORDER BY "Nr")
        LOOP
            EXIT WHEN ii > 4;
            DBMS_OUTPUT.PUT_LINE(LPAD(wiersz."Nr",2) || ' ' || LPAD(wiersz."Pseudonim",12 )|| ' ' || LPAD(wiersz."Zjada",10));
            ii := ii + 1;
        END LOOP;
    END;
/