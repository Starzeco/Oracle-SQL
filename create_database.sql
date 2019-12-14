ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';

CREATE TABLE Funkcje (
    funkcja VARCHAR2(10) CONSTRAINT funkcje_pk PRIMARY KEY,
    min_myszy NUMBER(3) CONSTRAINT funkcje_min_myszy CHECK ( min_myszy > 5 ),
    max_myszy NUMBER(3) CONSTRAINT funkcje_max_myszy_lt CHECK ( 200 > max_myszy ),
    CONSTRAINT funkcje_max_myszy_gt1 CHECK ( max_myszy >= min_myszy )
);

CREATE TABLE Wrogowie (
    imie_wroga VARCHAR2(15) CONSTRAINT wrogowie_pk PRIMARY KEY,
    stopien_wrogosci NUMBER(2) CONSTRAINT wrogowie_stop CHECK ( stopien_wrogosci BETWEEN 1 AND 10),
    gatunek VARCHAR2(15),
    lapowka VARCHAR2(20)
);

CREATE TABLE Bandy (
    nr_bandy NUMBER(2) CONSTRAINT bandy_pk PRIMARY KEY,
    nazwa VARCHAR2(20) CONSTRAINT bandy_naz_nn NOT NULL,
    teren VARCHAR2(15) CONSTRAINT bandy_teren_uq UNIQUE,
    szef_bandy VARCHAR2(15) CONSTRAINT bandy_szef_uq UNIQUE
);

CREATE TABLE Kocury (
    imie VARCHAR2(15) CONSTRAINT kocury_imie_nn NOT NULL,
    plec VARCHAR2(1) CONSTRAINT kocury_plec_in CHECK (plec in ('M', 'D')),
    pseudo VARCHAR2(15) CONSTRAINT kocury_pk PRIMARY KEY,
    funkcja VARCHAR2(10) CONSTRAINT kocury_fun_fk REFERENCES Funkcje(funkcja),
    szef VARCHAR2(15) CONSTRAINT kocury_pseudo_fk REFERENCES Kocury(pseudo),
    w_stadku_od DATE DEFAULT SYSDATE,
    przydzial_myszy NUMBER(3),
    myszy_extra NUMBER(3),
    nr_bandy NUMBER(2) CONSTRAINT kocury_nrb_fk REFERENCES Bandy(nr_bandy)
);

CREATE TABLE Wrogowie_Kocurow (
    pseudo VARCHAR2(15) CONSTRAINT wrog_koc_fk REFERENCES Kocury(pseudo),
    imie_wroga VARCHAR2(15) CONSTRAINT wrog_koc_im_fk REFERENCES Wrogowie(imie_wroga),
    data_incydentu DATE CONSTRAINT wrog_koc_data NOT NULL,
    opis_incydentu VARCHAR2(50),
    CONSTRAINT wrog_koc_pk PRIMARY KEY (pseudo, imie_wroga)
);

ALTER TABLE Bandy ADD CONSTRAINT szef_bandy_fk FOREIGN KEY(szef_bandy) REFERENCES Kocury(pseudo);