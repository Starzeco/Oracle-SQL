DROP TABLE Konta;
DROP TABLE Elity;
DROP TABLE Plebsy;

CREATE TABLE Plebsy (
  nr_plebsu NUMBER CONSTRAINT rp_pk PRIMARY KEY,
  kot VARCHAR2(15) CONSTRAINT rp_sc_k REFERENCES Kocury(pseudo)
);

CREATE TABLE Elity (
  nr_elity NUMBER CONSTRAINT re_pk PRIMARY KEY,
  kot VARCHAR(15) CONSTRAINT re_sc_k REFERENCES Kocury(pseudo),
  sluga NUMBER CONSTRAINT re_sc_e REFERENCES Plebsy(nr_plebsu)
);

CREATE TABLE Konta (
  nr_konta NUMBER CONSTRAINT ro_pk PRIMARY KEY,
  wlasciciel NUMBER CONSTRAINT ro_sc_k REFERENCES Elity(nr_elity),
  data_wprowadzenia DATE,
  data_usuniecia DATE,
  CONSTRAINT ro_dw CHECK(data_wprowadzenia IS NOT NULL),
  CONSTRAINT ro_du CHECK(data_wprowadzenia <= data_usuniecia)
);