SELECT K.FUNKCJA "Funkcja", K.PSEUDO "Pseudonim kota", COUNT(WK.IMIE_WROGA) "Liczba wrogow"
FROM KOCURY K JOIN WROGOWIE_KOCUROW WK ON K.PSEUDO = WK.PSEUDO
GROUP BY K.PSEUDO, K.FUNKCJA
HAVING COUNT(WK.IMIE_WROGA) > 1;