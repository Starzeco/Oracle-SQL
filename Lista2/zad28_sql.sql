WITH LiczbaPrzysIRok AS (
    (SELECT COUNT(*) "Liczba przystapien", TO_CHAR(EXTRACT(YEAR FROM W_STADKU_OD)) "Rok"
     FROM KOCURY
     GROUP BY EXTRACT(YEAR FROM W_STADKU_OD))
), LiczbaPrzys AS (
    SELECT COUNT(*) "Liczba przystapien"
    FROM KOCURY
    GROUP BY EXTRACT(YEAR FROM W_STADKU_OD)
)

SELECT "Rok", "Liczba przystapien"
FROM (
        SELECT "Liczba przystapien",
             "Rok",
             DENSE_RANK() over(
                               ORDER BY "Liczba przystapien"- (
                                                                SELECT ROUND(AVG("Liczba przystapien"),7)
                                                                FROM LiczbaPrzys
                                                              ) DESC
                               ) "POZYCJA"
        FROM LiczbaPrzysIRok
        WHERE "Liczba przystapien" <= (
                                        SELECT ROUND(AVG("Liczba przystapien"),7)
                                        FROM LiczbaPrzys
                                      )
    )
WHERE POZYCJA=1

UNION

SELECT "Rok", "Liczba przystapien"
FROM (
        SELECT "Liczba przystapien",
               "Rok",
               DENSE_RANK() over(
                                 ORDER BY "Liczba przystapien"- (
                                                                 SELECT ROUND(AVG("Liczba przystapien"),7)
                                                                 FROM LiczbaPrzys
                                                                )
                                ) "POZYCJA"
        FROM LiczbaPrzysIRok
        WHERE "Liczba przystapien" >= (
                                        SELECT ROUND(AVG("Liczba przystapien"),7)
                                        FROM LiczbaPrzys
                                      )
    )
WHERE POZYCJA=1

UNION

SELECT 'Srednia', ROUND(AVG("Liczba przystapien"),7)
FROM LiczbaPrzys;
