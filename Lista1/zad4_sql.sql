SELECT IMIE || ' zwany' || PSEUDO || ' (fun. ' || FUNKCJA || ') lowi myszki w bandzie ' || NR_BANDY || ' od ' || W_STADKU_OD "WSZYSTKO O KOCURACH"
    FROM KOCURY
    WHERE PLEC='M'
    ORDER BY  W_STADKU_OD DESC , PSEUDO