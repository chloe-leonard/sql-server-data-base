DROP DATABASE "TP_4";
GO

CREATE DATABASE "TP_4";
GO

USE "TP_4";
GO

DROP TABLE facture;
GO
DROP TABLE devis;
GO
DROP TABLE projet;
GO
DROP TABLE client;
GO

CREATE TABLE client (
  id int PRIMARY KEY IDENTITY(1, 1),
  nom varchar(255) NOT NULL
)
GO

CREATE TABLE projet (
  id int PRIMARY KEY IDENTITY(1, 1),
  client_id int NOT NULL,
  nom varchar(255)
)
GO

CREATE TABLE devis (
  id int PRIMARY KEY IDENTITY(1, 1),
  version int NOT NULL,
  reference varchar(10) NOT NULL,
  prix float NOT NULL,
  projet_id int NOT NULL
)
GO

CREATE TABLE facture (
  id int PRIMARY KEY IDENTITY(1, 1),
  reference varchar(10) NOT NULL,
  info varchar(255) NOT NULL,
  total float NOT NULL,
  date_crea date NOT NULL,
  date_paiement date,
  devis_id int NOT NULL
)
GO

INSERT INTO client(nom) VALUES 
('Mairie de Rennes'),
('Neo Soft'), 
('Sopra'),
('Accenture'),
('Amazon');

INSERT INTO projet(client_id,nom) VALUES ('1','Creation de site internet');
INSERT INTO projet(client_id,nom) VALUES ('2','Logiciel CRM');
INSERT INTO projet(client_id,nom) VALUES ('3','Logiciel de devis');
INSERT INTO projet(client_id,nom) VALUES ('4','Site internet ecommerce');
INSERT INTO projet(client_id,nom) VALUES ('2','Logiciel ERP');
INSERT INTO projet(client_id,nom) VALUES ('5','Logiciel Gestion de Stock');

INSERT INTO devis(version, reference, prix, projet_id) VALUES ('1','DEV2100A','3000','1');
INSERT INTO devis(version, reference, prix, projet_id) VALUES ('2','DEV2100B','5000','1');
INSERT INTO devis(version, reference, prix, projet_id) VALUES ('1','DEV2100C','5000','2');
INSERT INTO devis(version, reference, prix, projet_id) VALUES ('1','DEV2100D','3000','3');
INSERT INTO devis(version, reference, prix, projet_id) VALUES ('1','DEV2100E','5000','4');
INSERT INTO devis(version, reference, prix, projet_id) VALUES ('1','DEV2100F','2000','5');
INSERT INTO devis(version, reference, prix, projet_id) VALUES ('1','DEV2100G','1000','6');


INSERT INTO facture(reference, info, total, date_crea, date_paiement, devis_id) VALUES ('FA001','Site internet partie 1','1500','2023-01-09','2023-01-10','1');
INSERT INTO facture(reference, info, total, date_crea, date_paiement, devis_id) VALUES ('FA002','Site internet partie 2','1500','20-09-2023',null,'1');
INSERT INTO facture(reference, info, total, date_crea, date_paiement, devis_id) VALUES ('FA003','Logiciel CRM','5000','01-08-2023',null,'3');
INSERT INTO facture(reference, info, total, date_crea, date_paiement, devis_id) VALUES ('FA004','Logiciel devis', '3000','03-03-2023','03-04-2023','4');
INSERT INTO facture(reference, info, total, date_crea, date_paiement, devis_id) VALUES ('FA005','Site internet ecommerce', '5000','03-04-2023',null,'5');
INSERT INTO facture(reference, info, total, date_crea, date_paiement, devis_id) VALUES ('FA006','Logiciel ERP', '2000','04-05-2023',null,'4');


ALTER TABLE projet ADD FOREIGN KEY (client_id) REFERENCES client (id)
GO

ALTER TABLE devis ADD FOREIGN KEY (projet_id) REFERENCES projet (id)
GO

ALTER TABLE facture ADD FOREIGN KEY (devis_id) REFERENCES devis (id)
GO



/*
Afficher les factures à partir d'un client_id


	SELECT *
	FROM facture
	WHERE client_id = ?

Afficher le client qui a le plus de factures

	SELECT client.nom, MAX(COUNT(facture.id))
	FROM facture 
	INNER JOIN devis ON devis.id = facture.devis_id
	INNER JOIN projet ON devis.projet_id = projet.id
	INNER JOIN client ON projet.client_id = client.id
	GROUP BY client.nom;

Calculer le montant total facturé pour un Client

	SELECT client.nom, SUM(total)
	FROM facture 
	INNER JOIN devis ON facture.devis_id = devis.id
	INNER JOIN projet ON devis.projet_id = projet.id
	INNER JOIN client ON projet.client_id = client.id
	WHERE client_id= ?

Afficher le nombre de devis par client

	SELECT client.nom, COUNT(devis.id)
	FROM devis 
	INNER JOIN projet ON devis.projet_id = projet.id
	INNER JOIN client ON projet.client_id = client.id
	GROUP BY client.nom;

Calculer le CA 

	SELECT SUM(total)
	FROM facture

Calculer le montant des factures en attente de paiement

	SELECT SUM(total)
	FROM facture
	WHERE date_paiement=null

Calculer les factures en retard de paiement

	SELECT *
	FROM facture
	WHERE date_paiement=null AND MONTH(date_crea) +1 > MONTH(GETDATE())

*/

