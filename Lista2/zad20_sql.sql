SELECT IMIE "Imie kotki", B.NAZWA "Nazwa bandy", W.IMIE_WROGA "Imie wroga", W.STOPIEN_WROGOSCI "Ocena wroga", WK.DATA_INCYDENTU "Data inc."
    FROM KOCURY K JOIN WROGOWIE_KOCUROW WK ON K.PSEUDO = WK.PSEUDO AND
                                              WK.DATA_INCYDENTU > '2007-01-01' AND
                                              K.PLEC = 'D'
        JOIN BANDY B on K.NR_BANDY = B.NR_BANDY
        JOIN WROGOWIE W on WK.IMIE_WROGA = W.IMIE_WROGA
    ORDER BY K.IMIE, W.IMIE_WROGA;

/*



 */