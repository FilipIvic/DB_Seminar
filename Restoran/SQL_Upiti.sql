-- SQL upiti za dohvat podataka
SELECT * FROM VRSTA ORDER BY id_vrsta DESC;
SELECT * FROM Meni_Jelo;

SELECT * 
FROM Meni_Jelo 
WHERE status = '1';

SELECT T1.naziv, cijena 
FROM Meni_Jelo T1
JOIN Vrsta T2 ON T2.id_vrsta = T1.id_vrsta
WHERE status = '1'
AND T1.id_vrsta = 200;

SELECT T1.naziv, cijena, T2.naziv
FROM Meni_Jelo T1
JOIN Vrsta T2 ON T2.id_vrsta = T1.id_vrsta
order by T1.id_vrsta, T1.Naziv;

SELECT Meni_jelo.*
FROM Meni_Jelo
JOIN Vrsta ON Meni_jelo.id_vrsta = Vrsta.id_vrsta
order by Meni_jelo.Naziv;
--isto kao gore, samo s alias table
SELECT T1.*
FROM Meni_Jelo T1
JOIN Vrsta T3 ON T1.id_vrsta = T3.id_vrsta
order by T1.Naziv;

--poredak po koloni koja se ne prikazuje
SELECT T1.*, T3.naziv
FROM Meni_Jelo T1
JOIN Vrsta T3 ON T1.id_vrsta = T3.id_vrsta
order by T3.Naziv;
----------------------------------------------------------
-- izvještaj o svim jelima u kojima se koristi određena namirnica.
SELECT *
FROM Namirnica
WHERE id_namirnice = 2;

SELECT *
FROM Namirnica T1
JOIN Priprema T2 ON T2.id_namirnice = T1.id_namirnice
WHERE T1.id_namirnice = 2;

SELECT T1.naziv, T2.*
FROM Namirnica T1
JOIN Priprema T2 ON T2.id_namirnice = T1.id_namirnice
WHERE T1.id_namirnice = 2;

SELECT T1.naziv, T2.id_meni
FROM Namirnica T1
JOIN Priprema T2 ON T2.id_namirnice = T1.id_namirnice
WHERE T1.id_namirnice = 2;

SELECT T1.naziv, T3.naziv
FROM Namirnica T1
JOIN Priprema T2 ON T2.id_namirnice = T1.id_namirnice
JOIN Meni_Jelo T3 ON T3.id_meni = T2.id_meni
WHERE T1.id_namirnice = 2;

SELECT T1.naziv as namirnica, T3.naziv as jelo
FROM Namirnica T1
JOIN Priprema T2 ON T2.id_namirnice = T1.id_namirnice
JOIN Meni_Jelo T3 ON T3.id_meni = T2.id_meni
WHERE T1.id_namirnice = 2;
--------------------------------------------------------------
-- izvještaj o sastojcima koji odlaze u pripravu pojedinog jela i njihovoj trenutnoj
-- raspoloživosti.

SELECT T1.naziv as jelo, T3.naziv as sastojak, T3.stanje
FROM Meni_Jelo T1
JOIN Priprema T2 ON T2.id_meni = T1.id_meni
JOIN Namirnica T3 ON T3.id_namirnice = T2.id_namirnice
WHERE T1.id_meni = 1
ORDER BY T1.naziv;

--------------------------------------------------------------
--izvještaj o sastojcima koje je bilo/će biti potrebno nabaviti unutar zadanog
--vremenskog perioda.

SELECT *
FROM Namirnica
WHERE rok_trajanja < '2019-05-31'
ORDER BY rok_trajanja;

---------------------------------------------------------------
--popis svih namirnica kojih nema u dovoljnim količinama za pripravu određenog jela.

SELECT T1.naziv as jelo, T3.naziv as sastojak, T3.stanje, T2.kolicina as potrebno
FROM Meni_Jelo T1
JOIN Priprema T2 ON T2.id_meni = T1.id_meni
JOIN Namirnica T3 ON T3.id_namirnice = T2.id_namirnice
WHERE T1.id_meni = 1
AND T2.kolicina > T3.stanje 
ORDER BY T1.naziv;

--program bi sam trebao kada se izvrsi ovaj upit promijeniti status dostupnosti jela
UPDATE Meni_Jelo SET status = '0' WHERE id_meni = 1;
UPDATE Meni_Jelo SET status = '1' WHERE id_meni = 1;

---------------------------------------------------------------
--popis svih jela koja se mogu pripraviti od raspoloživih namirnica.

SELECT T1.naziv as jelo, T3.naziv as sastojak, T3.stanje, T2.kolicina as potrebno
FROM Meni_Jelo T1
JOIN Priprema T2 ON T2.id_meni = T1.id_meni
JOIN Namirnica T3 ON T3.id_namirnice = T2.id_namirnice
WHERE T1.status = '1'
ORDER BY T1.naziv;

SELECT T1.naziv as jelo
FROM Meni_Jelo T1
JOIN Priprema T2 ON T2.id_meni = T1.id_meni
JOIN Namirnica T3 ON T3.id_namirnice = T2.id_namirnice
WHERE T1.status = '1'
GROUP BY T1.naziv
ORDER BY T1.naziv;

--------------------------------------------------------------------
--pregled svih jela pripravljenih u određenom vremenskom periodu.

SELECT T3.naziv as jelo
FROM Stavke_racuna T1
JOIN Racun T2 ON T1.broj_racuna = T2.broj_racuna
JOIN Meni_Jelo T3 ON T1.id_meni = T3.id_meni
WHERE T2.datum >= '2019-05-10' --veca ili jednaka nekom datumu
GROUP BY T3.naziv
ORDER BY T3.naziv;

SELECT T3.naziv as jelo
FROM Stavke_racuna T1
JOIN Racun T2 ON T1.broj_racuna = T2.broj_racuna
JOIN Meni_Jelo T3 ON T1.id_meni = T3.id_meni
WHERE T2.datum BETWEEN '2019-01-01' AND '2019-05-10'
GROUP BY T3.naziv
ORDER BY T3.naziv;

--popis svih jela koja se mogu pripraviti od raspoloživih namirnica.
-- 2. pokušaj
SELECT T1.naziv as jelo, T3.naziv as sastojak, T3.stanje, T2.kolicina as potrebno
FROM Meni_Jelo T1
JOIN Priprema T2 ON T2.id_meni = T1.id_meni
JOIN Namirnica T3 ON T3.id_namirnice = T2.id_namirnice
WHERE T2.kolicina > T3.stanje 
ORDER BY T1.naziv;

SELECT T1.id_meni
FROM Meni_Jelo T1
JOIN Priprema T2 ON T2.id_meni = T1.id_meni
JOIN Namirnica T3 ON T3.id_namirnice = T2.id_namirnice
WHERE T2.kolicina > T3.stanje;

SELECT *
FROM Meni_Jelo
WHERE id_meni NOT IN (
	SELECT T1.id_meni
	FROM Meni_Jelo T1
	JOIN Priprema T2 ON T2.id_meni = T1.id_meni
	JOIN Namirnica T3 ON T3.id_namirnice = T2.id_namirnice
	WHERE T2.kolicina > T3.stanje)
ORDER BY NAZIV;


