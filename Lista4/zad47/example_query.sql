-- Wyswietl takiego elite, ktory ma mniejszy calkowity przydzial myszy od slugi lub gdy slugus ma najmniejszy przydzial ze wszystkich slugusow
-- wykorzystanie złączenia niejawnego, metod z typow, podzapytanie
SELECT el.NR_ELITY, VALUE(el).KOT.PSEUDO "Pseudo elity", VALUE(el).KOT.CALKOWITYPRZYDZIAL() "Przydzial elity", VALUE(el).SLUZACY.GETKOT().CALKOWITYPRZYDZIAL() "Przydzial plebsu"
FROM WIERSZOWEELITY el
WHERE VALUE(el).SLUZACY.GETKOT().CALKOWITYPRZYDZIAL() > VALUE(el).KOT.CALKOWITYPRZYDZIAL() OR
      VALUE(el).SLUZACY.GETKOT().CALKOWITYPRZYDZIAL() IN (SELECT MIN(pleb.KOT.CALKOWITYPRZYDZIAL()) FROM WIERSZOWEPLEBSY pleb);

--Wyswietl ilosc elit w kazdej bandzie gdzie jest conajmniej jedna elita, sortujac po bandzie
-- wykorzystanie metody grupowania

SELECT VALUE(el).KOT.BANDA "Nazwa bandy", COUNT(VALUE(el).KOT.PSEUDO) "Liczba elit"
FROM WIERSZOWEELITY el
GROUP BY VALUE(el).KOT.BANDA
ORDER BY VALUE(el).KOT.BANDA;


--Liczba myszy na koncie kotow plci meskiej, tych ktore uczestniczyly w incydentach
-- TO SĄ QUERY KTORĘ DOSTALEM OD STASZAKA, ZEBY Z PALCA NAPISAC SAMEMU
SELECT COUNT(VALUE(WK).NR_KONTA) "Liczba"
FROM WIERSZOWEKONTA WK
WHERE VALUE(WK).WLASCICIEL.GETKOT().PLEC = 'D' AND WK.DATA_USUNIECIA IS NULL;
-- TO SĄ QUERY KTORĘ DOSTALEM OD STASZAKA, ZEBY Z PALCA NAPISAC SAMEMU
SELECT COUNT(VALUE(WI).NR_INCYDENTU) "Liczba"
FROM WIERSZOWEINCYDENTY WI JOIN WIERSZOWEKONTA WK ON VALUE(WI).PSEUDO.PSEUDO = VALUE(WK).WLASCICIEL.GETKOT().PSEUDO
WHERE VALUE(WI).PSEUDO.PLEC = 'M' AND WK.DATA_USUNIECIA IS NULL;


-- ZADANIA Z LISTY 2

--zadanie 26

SELECT wk.FUNKCJA, ROUND(AVG(wk.CalkowityPrzydzial())) "Srednio najw. i najm. myszy"
FROM WIERSZOWEKOCURY wk
WHERE wk.FUNKCJA <> 'SZEFUNIO'
GROUP BY wk.FUNKCJA
HAVING ROUND(AVG(wk.CalkowityPrzydzial())) IN ((SELECT MAX(ROUND(AVG(wk2.CalkowityPrzydzial())))
                                                               FROM WIERSZOWEKOCURY wk2
                                                               WHERE wk2.FUNKCJA <> 'SZEFUNIO'
                                                               GROUP BY wk2.FUNKCJA),
                                                              (SELECT MIN(ROUND(AVG(wk2.CalkowityPrzydzial())))
                                                               FROM WIERSZOWEKOCURY wk2
                                                               WHERE wk2.FUNKCJA <> 'SZEFUNIO'
                                                               GROUP BY wk2.FUNKCJA));

-- zadanie 18

SELECT wk1.IMIE, TO_CHAR(wk1.W_STADKU_OD, 'YYYY-MM-DD') "POLUJE OD"
FROM WIERSZOWEKOCURY wk1, WIERSZOWEKOCURY wk2
WHERE wk2.IMIE = 'JACEK' AND wk1.W_STADKU_OD < wk2.W_STADKU_OD
ORDER BY wk1.W_STADKU_OD DESC;

-- ZADANIA Z LISTY 3

-- Zadanie 37
DECLARE
    ii INTEGER := 0;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Nr    Pseudonim    Zjada');
        DBMS_OUTPUT.PUT_LINE('------------------------');
        FOR wiersz IN (SELECT wk.PSEUDO "Pseudonim", wk.CalkowityPrzydzial() "Zjada", DENSE_RANK() over (
            ORDER BY wk.CalkowityPrzydzial() DESC
            ) "Nr"
            FROM WIERSZOWEKOCURY wk
            ORDER BY "Nr")
        LOOP
            EXIT WHEN ii > 4;
            DBMS_OUTPUT.PUT_LINE(LPAD(wiersz."Nr",2) || ' ' || LPAD(wiersz."Pseudonim",12 )|| ' ' || LPAD(wiersz."Zjada",10));
            ii := ii + 1;
        END LOOP ;
    END;

-- Zadanie 34

DECLARE
    fun WIERSZOWEKOCURY.FUNKCJA%TYPE;
    liczbaKocurow BINARY_INTEGER;
    funkcjaPodana VARCHAR2(14);
    BEGIN
        funkcjaPodana := ?;
        SELECT COUNT(K.PSEUDO), MIN(K.FUNKCJA) INTO liczbaKocurow, fun
            FROM WIERSZOWEKOCURY K
                WHERE K.FUNKCJA = funkcjaPodana;
        IF liczbaKocurow > 0 THEN
            DBMS_OUTPUT.PUT_LINE('Znaleziono kota/ke o funkcji: ' || fun);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Nie Znaleziono kota/ki');
        END IF;
    END;

