INSERT INTO WierszoweKocury VALUES ('MRUCZEK', 'M', 'TYGRYS', 'SZEFUNIO', NULL, '2002-01-01', 103, 33, 'SZEFOSTWO');
INSERT INTO WierszoweKocury VALUES ('RUDA', 'D', 'MALA', 'MILUSIA', (SELECT REF(wk) FROM WierszoweKocury wk WHERE wk.imie = 'MRUCZEK'), '2006-09-17', 22, 42, 'SZEFOSTWO');
INSERT INTO WierszoweKocury VALUES ('MICKA', 'D', 'LOLA', 'MILUSIA', (SELECT REF(wk) FROM WierszoweKocury wk WHERE wk.imie = 'MRUCZEK'), '2009-10-14', 25, 47, 'SZEFOSTWO');
INSERT INTO WierszoweKocury VALUES ('PUCEK', 'M', 'RAFA', 'LOWCZY', (SELECT REF(wk) FROM WierszoweKocury wk WHERE wk.imie = 'MRUCZEK'), '2006-10-15', 65, NULL, 'LACIACI MYSLIWI');
INSERT INTO WierszoweKocury VALUES ('CHYTRY', 'M', 'BOLEK', 'DZIELCZY', (SELECT REF(wk) FROM WierszoweKocury wk WHERE wk.imie = 'MRUCZEK'), '2002-05-05', 50, NULL, 'SZEFOSTWO');
INSERT INTO WierszoweKocury VALUES ('KOREK', 'M', 'ZOMBI', 'BANDZIOR', (SELECT REF(wk) FROM WierszoweKocury wk WHERE wk.imie = 'MRUCZEK'), '2004-03-16', 75, 13, 'CZARNI RYCERZE');
INSERT INTO WierszoweKocury VALUES ('BOLEK', 'M', 'LYSY', 'BANDZIOR', (SELECT REF(wk) FROM WierszoweKocury wk WHERE wk.imie = 'MRUCZEK'), '2006-08-15', 72, 21, 'CZARNI RYCERZE');
INSERT INTO WierszoweKocury VALUES ('KSAWERY', 'M', 'MAN', 'LAPACZ', (SELECT REF(wk) FROM WierszoweKocury wk WHERE wk.imie = 'PUCEK'), '2008-07-12', 51, NULL, 'LACIACI MYSLIWI');
INSERT INTO WierszoweKocury VALUES ('MELA', 'D', 'DAMA', 'LAPACZ', (SELECT REF(wk) FROM WierszoweKocury wk WHERE wk.imie = 'PUCEK'), '2008-11-01', 100, 37, 'LACIACI MYSLIWI');
INSERT INTO WierszoweKocury VALUES ('LATKA', 'D', 'UCHO', 'KOT', (SELECT REF(wk) FROM WierszoweKocury wk WHERE wk.imie = 'PUCEK'), '2011-01-01', 40, NULL, 'LACIACI MYSLIWI');
INSERT INTO WierszoweKocury VALUES ('DUDEK', 'M', 'MALY', 'KOT', (SELECT REF(wk) FROM WierszoweKocury wk WHERE wk.imie = 'PUCEK'), '2011-05-15', 40, NULL, 'LACIACI MYSLIWI');
INSERT INTO WierszoweKocury VALUES ('ZUZIA' ,'D', 'SZYBKA', 'LOWCZY', (SELECT REF(wk) FROM WierszoweKocury wk WHERE wk.imie = 'BOLEK'), '2006-07-21', 65, NULL, 'CZARNI RYCERZE');
INSERT INTO WierszoweKocury VALUES ('BELA', 'D', 'LASKA', 'MILUSIA', (SELECT REF(wk) FROM WierszoweKocury wk WHERE wk.imie = 'BOLEK'), '2008-02-01', 24, 28, 'CZARNI RYCERZE');
INSERT INTO WierszoweKocury VALUES ('JACEK', 'M', 'PLACEK', 'LOWCZY', (SELECT REF(wk) FROM WierszoweKocury wk WHERE wk.imie = 'BOLEK'), '2008-12-01', 67, NULL, 'CZARNI RYCERZE');
INSERT INTO WierszoweKocury VALUES ('BARI', 'M', 'RURA', 'LAPACZ', (SELECT REF(wk) FROM WierszoweKocury wk WHERE wk.imie = 'BOLEK'), '2009-09-01', 56, NULL, 'CZARNI RYCERZE');
INSERT INTO WierszoweKocury VALUES ('PUNIA', 'D', 'KURKA', 'LOWCZY', (SELECT REF(wk) FROM WierszoweKocury wk WHERE wk.imie = 'KOREK'), '2008-01-01', 61, NULL, 'BIALI LOWCY');
INSERT INTO WierszoweKocury VALUES ('SONIA', 'D', 'PUSZYSTA','MILUSIA', (SELECT REF(wk) FROM WierszoweKocury wk WHERE wk.imie = 'KOREK'), '2010-11-18', 20, 35, 'BIALI LOWCY');
INSERT INTO WierszoweKocury VALUES ('LUCEK', 'M', 'ZERO', 'KOT', (SELECT REF(wk) FROM WierszoweKocury wk WHERE wk.imie = 'PUNIA'), '2010-03-01', 43, NULL, 'BIALI LOWCY');



INSERT INTO WierszowePlebsy VALUES (1, (SELECT REF(kot) FROM WierszoweKocury kot WHERE kot.pseudo='SZYBKA'));
INSERT INTO WierszowePlebsy VALUES (2, (SELECT REF(kot) FROM WierszoweKocury kot WHERE kot.pseudo='BOLEK'));
INSERT INTO WierszowePlebsy VALUES (3, (SELECT REF(kot) FROM WierszoweKocury kot WHERE kot.pseudo='LASKA'));
INSERT INTO WierszowePlebsy VALUES (4, (SELECT REF(kot) FROM WierszoweKocury kot WHERE kot.pseudo='MAN'));
INSERT INTO WierszowePlebsy VALUES (5, (SELECT REF(kot) FROM WierszoweKocury kot WHERE kot.pseudo='DAMA'));
INSERT INTO WierszowePlebsy VALUES (6, (SELECT REF(kot) FROM WierszoweKocury kot WHERE kot.pseudo='PLACEK'));
INSERT INTO WierszowePlebsy VALUES (7, (SELECT REF(kot) FROM WierszoweKocury kot WHERE kot.pseudo='RURA'));
INSERT INTO WierszowePlebsy VALUES (8, (SELECT REF(kot) FROM WierszoweKocury kot WHERE kot.pseudo='ZERO'));
INSERT INTO WierszowePlebsy VALUES (9, (SELECT REF(kot) FROM WierszoweKocury kot WHERE kot.pseudo='PUSZYSTA'));
INSERT INTO WierszowePlebsy VALUES (10, (SELECT REF(kot) FROM WierszoweKocury kot WHERE kot.pseudo='UCHO'));
INSERT INTO WierszowePlebsy VALUES (11, (SELECT REF(kot) FROM WierszoweKocury kot WHERE kot.pseudo='MALY'));
INSERT INTO WierszowePlebsy VALUES (12, (SELECT REF(kot) FROM WierszoweKocury kot WHERE kot.pseudo='MALA'));


INSERT INTO WierszoweElity VALUES (1, (SELECT REF(kot) FROM WierszoweKocury kot WHERE kot.pseudo='TYGRYS'), (SELECT REF(sluga) FROM WierszowePlebsy sluga WHERE sluga.nr_plebsu=5));
INSERT INTO WierszoweElity VALUES (2, (SELECT REF(kot) FROM WierszoweKocury kot WHERE kot.pseudo='LOLA'), (SELECT REF(sluga) FROM WierszowePlebsy sluga WHERE sluga.nr_plebsu=9));
INSERT INTO WierszoweElity VALUES (3, (SELECT REF(kot) FROM WierszoweKocury kot WHERE kot.pseudo='ZOMBI'), (SELECT REF(sluga) FROM WierszowePlebsy sluga WHERE sluga.nr_plebsu=4));
INSERT INTO WierszoweElity VALUES (4, (SELECT REF(kot) FROM WierszoweKocury kot WHERE kot.pseudo='LYSY'), (SELECT REF(sluga) FROM WierszowePlebsy sluga WHERE sluga.nr_plebsu=1));
INSERT INTO WierszoweElity VALUES (5, (SELECT REF(kot) FROM WierszoweKocury kot WHERE kot.pseudo='KURKA'), (SELECT REF(sluga) FROM WierszowePlebsy sluga WHERE sluga.nr_plebsu=10));
INSERT INTO WierszoweElity VALUES (6, (SELECT REF(kot) FROM WierszoweKocury kot WHERE kot.pseudo='RAFA'), (SELECT REF(sluga) FROM WierszowePlebsy sluga WHERE sluga.nr_plebsu=7));

INSERT INTO WierszoweKonta VALUES (1, (SELECT REF(kot) FROM WierszoweElity kot WHERE kot.nr_elity=1), SYSDATE, NULL);
INSERT INTO WierszoweKonta VALUES (2, (SELECT REF(kot) FROM WierszoweElity kot WHERE kot.nr_elity=2), SYSDATE, NULL);
INSERT INTO WierszoweKonta VALUES (3, (SELECT REF(kot) FROM WierszoweElity kot WHERE kot.nr_elity=3), SYSDATE, NULL);
INSERT INTO WierszoweKonta VALUES (4, (SELECT REF(kot) FROM WierszoweElity kot WHERE kot.nr_elity=4), SYSDATE, NULL);
INSERT INTO WierszoweKonta VALUES (5, (SELECT REF(kot) FROM WierszoweElity kot WHERE kot.nr_elity=5), SYSDATE, NULL);
INSERT INTO WierszoweKonta VALUES (6, (SELECT REF(kot) FROM WierszoweElity kot WHERE kot.nr_elity=6), SYSDATE, NULL);
INSERT INTO WierszoweKonta VALUES (7, (SELECT REF(kot) FROM WierszoweElity kot WHERE kot.nr_elity=2), SYSDATE, NULL);
INSERT INTO WierszoweKonta VALUES (8, (SELECT REF(kot) FROM WierszoweElity kot WHERE kot.nr_elity=3), SYSDATE, NULL);
INSERT INTO WierszoweKonta VALUES (9, (SELECT REF(kot) FROM WierszoweElity kot WHERE kot.nr_elity=2), SYSDATE, NULL);
INSERT INTO WierszoweKonta VALUES (10, (SELECT REF(kot) FROM WierszoweElity kot WHERE kot.nr_elity=5), SYSDATE, NULL);
INSERT INTO WierszoweKonta VALUES (11, (SELECT REF(kot) FROM WierszoweElity kot WHERE kot.nr_elity=2), SYSDATE, NULL);

INSERT INTO WIERSZOWEINCYDENTY VALUES (1, (SELECT REF(kot) FROM WierszoweKocury kot WHERE kot.pseudo='TYGRYS'), 'Imie wroga1', SYSDATE, 'Opis');
INSERT INTO WIERSZOWEINCYDENTY VALUES (2, (SELECT REF(kot) FROM WierszoweKocury kot WHERE kot.pseudo='LOLA'), 'Imie wroga1', SYSDATE, 'Opis');
INSERT INTO WIERSZOWEINCYDENTY VALUES (3, (SELECT REF(kot) FROM WierszoweKocury kot WHERE kot.pseudo='ZOMBI'), 'Imie wroga1', SYSDATE, 'Opis');
INSERT INTO WIERSZOWEINCYDENTY VALUES (4, (SELECT REF(kot) FROM WierszoweKocury kot WHERE kot.pseudo='LYSY'), 'Imie wroga1', SYSDATE, 'Opis');
INSERT INTO WIERSZOWEINCYDENTY VALUES (5, (SELECT REF(kot) FROM WierszoweKocury kot WHERE kot.pseudo='RAFA'), 'Imie wroga1', SYSDATE, 'Opis');
INSERT INTO WIERSZOWEINCYDENTY VALUES (6, (SELECT REF(kot) FROM WierszoweKocury kot WHERE kot.pseudo='RURA'), 'Imie wroga1', SYSDATE, 'Opis');