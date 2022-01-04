CREATE DATABASE Restoran;

CREATE TABLE Vrsta (
  id_vrsta INTEGER PRIMARY KEY,
  naziv     CHARACTER(40)
);

CREATE TABLE Meni_Jelo (
  id_meni INTEGER PRIMARY KEY,
  status  CHARACTER(1),
  naziv	  CHARACTER(50),
  cijena  NUMERIC(11,2),
  id_vrsta INTEGER references Vrsta(id_vrsta)
);

CREATE TABLE Namirnica (
  id_namirnice INTEGER PRIMARY KEY,
  naziv	  CHARACTER(50),
  mj_jedinica CHARACTER(10),
  stanje  NUMERIC(9,3),
  rok_trajanja DATE DEFAULT CURRENT_DATE,
  min_stanje  NUMERIC(9,3)
);

CREATE TABLE Radnik (
  oib CHARACTER(11) PRIMARY KEY,
  ime  CHARACTER(30),
  prezime  CHARACTER(30),
  adresa CHARACTER(50),
  mjesto CHARACTER(30)
);

CREATE TABLE Nabava (
  broj_nabave INTEGER PRIMARY KEY,
  datum DATE DEFAULT CURRENT_DATE,
  cijena  NUMERIC(11,2),
  popust  NUMERIC(5,2),
  iznos  NUMERIC(11,2),
  oib CHARACTER(11) references Radnik(oib)
);

CREATE TABLE Racun (
  broj_racuna INTEGER PRIMARY KEY,
  datum DATE DEFAULT CURRENT_DATE,
  cijena  NUMERIC(11,2),
  popust  NUMERIC(5,2),
  iznos  NUMERIC(11,2),
  oib CHARACTER(11) references Radnik(oib)
);

CREATE TABLE Priprema (
  id_meni INTEGER references Meni_Jelo(id_meni),
  id_namirnice INTEGER references Namirnica(id_namirnice),
  kolicina NUMERIC(7,3) DEFAULT 0,
  PRIMARY KEY (id_meni, id_namirnice)
);

CREATE TABLE Stavke_Nabave (
  id_namirnice INTEGER references Namirnica(id_namirnice),
  broj_nabave INTEGER references Nabava(broj_nabave),
  kolicina NUMERIC(7,3) DEFAULT 0,
  PRIMARY KEY (id_namirnice, broj_nabave)
);

CREATE TABLE Stavke_Racuna (
  id_meni INTEGER references Meni_Jelo(id_meni),
  broj_racuna INTEGER references Racun(broj_racuna),
  kolicina NUMERIC(7,3) DEFAULT 0,
  PRIMARY KEY (id_meni, broj_racuna)
);

INSERT INTO Vrsta VALUES
	(10,'predjelo'),
	(20,'glavno jelo'),
	(30,'deserti'),
	(40,'pića');

INSERT INTO Meni_Jelo VALUES
	(1,'1','Brancin s medaljonima od tikvica',150,20),
	(2,'1','Tikvice s rajčicama',45.5,10),
	(3,'1','Povrće sa žara',50,10),
	(4,'1','Odresci od piletine',85.45,20),
	(5,'1','Salata od pečenih patlidžana, tikvica i srdela',40,10);
	
INSERT INTO Namirnica VALUES
	(1,'sol','kg',3,'2020-05-31',1),
	(2,'papar','kg',1,'2020-05-31',0.1),
	(3,'maslac','kg',2,'2019-06-30',0.5),
	(4,'suncokretovo ulje','l',5,'2019-07-25',2),
	(5,'maslinovo ulje','l',4.5,'2020-03-18',3),
	(6,'jaje','kom',24,'2019-06-30',8),
	(7,'tikvica','kg',3.5,'2019-05-26',0.5),
	(8,'patliđan','kg',1.2,'2019-06-26',0),
	(9,'špinat','kg',0,'2019-05-23',0.5),
	(10,'kukuruz','kg',0.4,'2019-07-31',0.5),
	(11,'paprika','kg',2.3,'2019-05-31',0.5),
	(12,'suhe šljive','kg',0,'2019-12-31',0.25),
	(13,'srdela','kg',2,'2019-05-24',0),
	(14,'brancin file','kg',2,'2019-05-24',0),
	(15,'mozarella','kg',3.5,'2019-06-01',0.5),
	(16,'šalša','l',1,'2019-06-01',0.5),
	(17,'šampinjoni','kg',1,'2019-06-01',0.5),
	(18,'mini rajčice','kg',2.5,'2019-06-01',0),
	(19,'pileća prsa','kg',2,'2019-05-28',0.5),
	(20,'mlijeko','l',0,'2019-05-23',3);
	
INSERT INTO Priprema VALUES
	(1,14,8),
	(1,7,0.6),
	(1,5,0.1),
	(2,7,0.6),
	(2,15,0.2),
	(2,16,0.3),
	(2,5,0.01),
	(2,1,0.005),
	(2,2,0.005),
	(3,7,0.2),
	(3,8,0.2),
	(3,11,0.2),
	(3,17,0.1),
	(3,18,0.1),
	(3,5,0.2),
	(4,19,0.5),
	(4,4,0.01),
	(4,1,0.005),
	(4,2,0.005),
	(4,3,0.1),
	(5,8,0.5),
	(5,7,0.5),
	(5,13,0.4),
	(5,10,0.15),
	(5,5,0.1),
	(5,1,0.01),
	(5,2,0.01);
	
INSERT INTO Radnik VALUES
	('01234567890','Filip','Ivić','Papandopula 17','Split'),
	('12345678910','Kristijan','Gaurina','Bračka 16','Split'),
	('23456789101','Ivan','Trstenjak','Uzaludna 15','Stobreč'),
	('34567891011','Zvonimir','Ivković','Pujanke 14','Split'),
	('45678910111','Pjero','Javorčić','Tomislava 4A','Zagreb');

INSERT INTO Nabava VALUES
	(1,'2019-05-01',1000,0,1000,'01234567890'),
	(2,'2019-05-10',1500,0,1500,'12345678910');

INSERT INTO Stavke_Nabave VALUES
	(1,1,1),
	(2,1,0.1),
	(3,1,0.5),
	(4,1,2),
	(5,1,3),
	(6,1,8),
	(7,1,0.5),
	(8,1,0.5),
	(9,1,0.5),
	(10,1,0.5),
	(11,2,0.5),
	(12,2,0.25),
	(13,2,0.1),
	(14,2,1),
	(15,2,0.5),
	(16,2,0.5),
	(17,2,0.5),
	(18,2,0.1),
	(19,2,0.5),
	(20,2,3);
	
INSERT INTO Racun VALUES
	(1,'2019-05-10',234.45,0,234.45,'01234567890'),
	(2,'2019-05-10',182,5,172.9,'01234567890'),
	(3,'2019-05-11',220.95,10,198.86,'12345678910'),
	(4,'2019-05-11',570,15,484.5,'12345678910'),
	(5,'2019-05-11',1483.8,20,1187.04,'12345678910');
	
INSERT INTO Stavke_Racuna VALUES
	(1,1,1),
	(4,1,1),
	(2,2,4),
	(2,3,1),
	(3,3,1),
	(4,3,1),
	(5,3,1),
	(1,4,3),
	(5,4,3),
	(5,5,4),
	(4,5,4),
	(3,5,4),
	(2,5,4),
	(1,5,4);
	
CREATE VIEW Veganska_jela AS
	SELECT *
	FROM Meni_Jelo
	WHERE id_meni IN (2, 3);
	
SELECT * FROM Veganska_jela;
	


















