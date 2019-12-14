SELECT IMIE, W_STADKU_OD "WSTAPILI DO STADKA", '<----------NAJSTARSZY STAZEM W BANDZIE '|| B.NAZWA " "
FROM KOCURY K1 JOIN BANDY B ON K1.NR_BANDY=B.NR_BANDY
WHERE W_STADKU_OD = (SELECT MAX(W_STADKU_OD) FROM KOCURY WHERE K1.NR_BANDY=NR_BANDY)

UNION

SELECT IMIE, W_STADKU_OD "WSTAPILI DO STADKA", '<----------NAJMLODSZY STAZEM W BANDZIE '|| NAZWA " "
FROM KOCURY K1 JOIN BANDY B ON K1.NR_BANDY=B.NR_BANDY
WHERE W_STADKU_OD = (SELECT MIN(W_STADKU_OD) FROM KOCURY WHERE K1.NR_BANDY=NR_BANDY)

UNION

SELECT IMIE, W_STADKU_OD "WSTAPILI DO STADKA", ' ' " "
FROM KOCURY K1
where W_STADKU_OD !=(SELECT MIN(W_STADKU_OD) FROM KOCURY WHERE K1.NR_BANDY=NR_BANDY)
AND W_STADKU_OD != (SELECT MAX(W_STADKU_OD) FROM KOCURY WHERE K1.NR_BANDY=NR_BANDY);