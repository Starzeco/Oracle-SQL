SELECT K1.IMIE, TO_CHAR(K1.W_STADKU_OD, 'YYYY-MM-DD') "POLUJE OD"

FROM KOCURY K1 JOIN KOCURY K2 ON K1.W_STADKU_OD < K2.W_STADKU_OD AND
                                 K2.IMIE = 'JACEK'
ORDER BY K1.W_STADKU_OD DESC;


/*



 */