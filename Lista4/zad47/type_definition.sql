DROP TYPE Konto;
DROP TYPE Elita;
DROP TYPE Plebs;
DROP TYPE Incydent;
DROP TYPE Kocur;

CREATE OR REPLACE TYPE Kocur AS OBJECT (
    imie VARCHAR2(15),
    plec VARCHAR2(1),
    pseudo VARCHAR2(15),
    funkcja VARCHAR2(10),
    szef REF Kocur,
    w_stadku_od DATE,
    przydzial_myszy NUMBER(3),
    myszy_extra NUMBER(3),
    banda VARCHAR2(20),

    MAP MEMBER FUNCTION Porownaj RETURN VARCHAR2,
    MEMBER FUNCTION CalkowityPrzydzial RETURN NUMBER,
    MEMBER FUNCTION GetSzef RETURN Kocur
                                       );
CREATE OR REPLACE TYPE BODY Kocur IS
    MAP MEMBER FUNCTION Porownaj RETURN VARCHAR2 IS BEGIN
       RETURN pseudo;
    END;

    MEMBER FUNCTION CalkowityPrzydzial RETURN NUMBER IS BEGIN
        RETURN NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0);
    END;

    MEMBER FUNCTION GetSzef RETURN Kocur IS
        szefunio Kocur;
    BEGIN
        SELECT DEREF(szef) INTO szefunio FROM DUAL;
        RETURN szefunio;
    END;
END;

CREATE OR REPLACE TYPE Plebs AS OBJECT (
    nr_plebsu NUMBER,
    kot REF Kocur,

    MAP MEMBER FUNCTION PorownajPlebs RETURN VARCHAR2,
    MEMBER FUNCTION GetKot RETURN Kocur
                                       );

CREATE OR REPLACE TYPE BODY Plebs IS
    MAP MEMBER FUNCTION PorownajPlebs RETURN VARCHAR2 IS
        response Kocur;
    BEGIN
        SELECT DEREF(kot) INTO response FROM DUAL;
        RETURN response.pseudo;
    END;

    MEMBER FUNCTION GetKot RETURN Kocur IS
        response Kocur;
    BEGIN
        SELECT DEREF(kot) INTO response FROM DUAL;
        RETURN response;
    END;
END;


CREATE OR REPLACE TYPE Elita AS OBJECT (
    nr_elity NUMBER,
    kot REF Kocur,
    sluzacy REF Plebs,

    MAP MEMBER FUNCTION PorownajElita RETURN VARCHAR2,
    MEMBER FUNCTION GetKot RETURN Kocur,
    MEMBER FUNCTION GetPlebs RETURN Plebs
                                       );

CREATE OR REPLACE TYPE BODY Elita IS
    MAP MEMBER FUNCTION PorownajElita RETURN VARCHAR2 IS
        response Kocur;
    BEGIN
        SELECT DEREF(kot) INTO response FROM DUAL;
        RETURN response.PSEUDO;
    END;

    MEMBER FUNCTION GetKot RETURN Kocur IS
        response Kocur;
    BEGIN
        SELECT DEREF(kot) INTO response FROM DUAL;
        RETURN response;
    END;

    MEMBER FUNCTION GetPlebs RETURN Plebs IS
        response Plebs;
    BEGIN
        SELECT DEREF(sluzacy) INTO response FROM DUAL;
        RETURN response;
    END;
END;

CREATE OR REPLACE TYPE Konto AS OBJECT (
    nr_konta NUMBER,
    wlasciciel REF Elita,
    data_wprowadzenia DATE,
    data_usuniecia DATE,

    MAP MEMBER FUNCTION PorownajKonto RETURN NUMBER,
    MEMBER FUNCTION GetWlasciciel RETURN Kocur
                                       );

CREATE OR REPLACE TYPE BODY Konto IS
    MAP MEMBER FUNCTION PorownajKonto RETURN NUMBER IS BEGIN
        RETURN nr_konta;
    END;

    MEMBER FUNCTION GetWlasciciel RETURN Kocur IS
        response Kocur;
        elit Elita;
    BEGIN
        SELECT DEREF(wlasciciel) INTO elit FROM DUAL;
        SELECT DEREF(elit.KOT) INTO response FROM DUAL;
        RETURN response;
    END;
END;

CREATE OR REPLACE TYPE Incydent AS OBJECT (
    nr_incydentu NUMBER,
    pseudo REF Kocur,
    imie_wroga VARCHAR2(15),
    data_incydentu DATE,
    opis_incydentu VARCHAR2(50),

    MAP MEMBER FUNCTION PorownajIncydent RETURN NUMBER,
    MEMBER FUNCTION GetKot RETURN Kocur
                                          );

CREATE OR REPLACE TYPE BODY Incydent IS
    MAP MEMBER FUNCTION PorownajIncydent RETURN NUMBER IS BEGIN
        RETURN nr_incydentu;
    END;

    MEMBER FUNCTION GetKot RETURN Kocur IS
        response Kocur;
    BEGIN
        SELECT DEREF(pseudo) INTO response FROM DUAL;
        RETURN response;
    END;
END;