DROP TYPE KocurSzef;
DROP VIEW NAKSZEF;

CREATE OR REPLACE TYPE KocurSzef AS OBJECT (
    imie VARCHAR2(15),
    plec VARCHAR2(1),
    pseudo VARCHAR2(15),
    funkcja VARCHAR2(10),
    w_stadku_od DATE,
    przydzial_myszy NUMBER(3),
    myszy_extra NUMBER(3),
    banda NUMBER(3),

    MAP MEMBER FUNCTION Porownaj RETURN VARCHAR2,
    MEMBER FUNCTION CalkowityPrzydzial RETURN NUMBER
                                       );

CREATE OR REPLACE TYPE BODY KocurSzef IS
    MAP MEMBER FUNCTION Porownaj RETURN VARCHAR2 IS BEGIN
       RETURN pseudo;
    END;

    MEMBER FUNCTION CalkowityPrzydzial RETURN NUMBER IS BEGIN
        RETURN NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0);
    END;
END;

DROP TABLE WierszoweKonta;
DROP TABLE WierszoweElity;
DROP TABLE WierszowePlebsy;
DROP TABLE WierszoweKocury;

CREATE OR REPLACE TYPE Kocur AS OBJECT (
    imie VARCHAR2(15),
    plec VARCHAR2(1),
    pseudo VARCHAR2(15),
    funkcja VARCHAR2(10),
    szef REF KocurSzef,
    w_stadku_od DATE,
    przydzial_myszy NUMBER(3),
    myszy_extra NUMBER(3),
    banda NUMBER(3),

    MAP MEMBER FUNCTION Porownaj RETURN VARCHAR2,
    MEMBER FUNCTION CalkowityPrzydzial RETURN NUMBER,
    MEMBER FUNCTION GetSzef RETURN KocurSzef
                                       );
CREATE OR REPLACE TYPE BODY Kocur IS
    MAP MEMBER FUNCTION Porownaj RETURN VARCHAR2 IS BEGIN
       RETURN pseudo;
    END;

    MEMBER FUNCTION CalkowityPrzydzial RETURN NUMBER IS BEGIN
        RETURN NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0);
    END;

    MEMBER FUNCTION GetSzef RETURN KocurSzef IS
        szefunio KocurSzef;
    BEGIN
        SELECT DEREF(szef) INTO szefunio FROM DUAL;
        RETURN szefunio;
    END;
END;

DROP VIEW NakSzef;
CREATE OR REPLACE VIEW NakSzef OF KocurSzef
WITH OBJECT IDENTIFIER (pseudo) AS
SELECT
    imie, plec, pseudo, funkcja,
    w_stadku_od, przydzial_myszy, myszy_extra, nr_bandy
FROM KOCURY;

DROP VIEW NakKocury;

CREATE OR REPLACE VIEW NakKocury OF Kocur
WITH OBJECT IDENTIFIER (pseudo) AS
SELECT
  K.imie, K.plec, K.pseudo, K.funkcja,
  MAKE_REF(NakSzef, NS.pseudo) szef, K.w_stadku_od, K.przydzial_myszy, K.myszy_extra, K.nr_bandy
FROM KOCURY K LEFT JOIN NakSzef NS ON K.SZEF = NS.PSEUDO;

DROP VIEW NakPlebsy;

CREATE OR REPLACE VIEW NakPlebsy OF Plebs
WITH OBJECT IDENTIFIER (nr_plebsu) AS
SELECT
  nr_plebsu,
  MAKE_REF(NakKocury, kot) kot
FROM PLEBSY;

DROP VIEW NakElity;

CREATE OR REPLACE VIEW NakElity OF Elita
WITH OBJECT IDENTIFIER (nr_elity) AS
SELECT
  nr_elity,
  MAKE_REF(NakKocury,kot) kot,
  MAKE_REF(NakPlebsy,sluga) sluga
FROM ELITY;

DROP VIEW NakKonta;

CREATE OR REPLACE VIEW NakKonta OF Konto
WITH OBJECT IDENTIFIER (nr_konta) AS
SELECT
  nr_konta,
  MAKE_REF(NakElity, wlasciciel) wlasciciel,
  data_wprowadzenia,
  data_usuniecia
FROM KONTA;