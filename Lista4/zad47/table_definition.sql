DROP TABLE WierszoweKonta;
DROP TABLE WierszoweElity;
DROP TABLE WierszowePlebsy;

DROP TABLE WierszoweIncydenty;
DROP TABLE WierszoweKocury;

CREATE TABLE WierszoweKocury OF Kocur (
    CONSTRAINT wk_im CHECK ( imie IS NOT NULL ),
    CONSTRAINT wk_pl CHECK ( plec IN ('M', 'D')),
    CONSTRAINT wk_pk PRIMARY KEY (pseudo),
    w_stadku_od DEFAULT(SYSDATE)
    );

CREATE TABLE WierszowePlebsy OF PLEBS (
    CONSTRAINT wp_pk PRIMARY KEY (nr_plebsu),
    CONSTRAINT wp_sc kot SCOPE IS WierszoweKocury
);

CREATE TABLE WierszoweElity OF ELITA (
  CONSTRAINT we_pk PRIMARY KEY (nr_elity),
  CONSTRAINT we_sc_k kot SCOPE IS WierszoweKocury,
  CONSTRAINT we_sc_s sluzacy SCOPE IS WierszowePlebsy
);

CREATE TABLE WierszoweKonta OF KONTO (
    CONSTRAINT wko_pk PRIMARY KEY (nr_konta),
    CONSTRAINT wko_sc wlasciciel SCOPE IS WierszoweElity,
    CONSTRAINT wko_dw CHECK (data_wprowadzenia IS NOT NULL),
    CONSTRAINT wk_du CHECK (data_wprowadzenia <= data_usuniecia )
);

CREATE TABLE WierszoweIncydenty OF INCYDENT(
    CONSTRAINT wi_pk PRIMARY KEY (nr_incydentu),
    CONSTRAINT wi_sc pseudo SCOPE IS WierszoweKocury,
    CONSTRAINT wi_data CHECK (data_incydentu IS NOT NULL)
);
