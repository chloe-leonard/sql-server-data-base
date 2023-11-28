/*DROP DATABASE "TP5_";
GO


CREATE DATABASE "TP5_";
GO
*/
USE "TP5_";
GO


DROP TABLE equipe_has_personne;
GO
DROP TABLE equipe;
GO
DROP TABLE personne;
GO

CREATE TABLE personne (
  id int PRIMARY KEY IDENTITY(1, 1),
  prenom varchar(100) NOT NULL,
  nom varchar(150) NOT NULL
)
GO

CREATE TABLE equipe (
  id int PRIMARY KEY IDENTITY(1, 1),
  nom varchar(150) NOT NULL,
  projet varchar(250) NOT NULL,
  personne_id int 
) 
GO

CREATE TABLE equipe_has_personne (
	personne_id int,
	equipe_id int,
	CONSTRAINT PK_equipe_personne PRIMARY KEY (personne_id, equipe_id)
)
GO

ALTER TABLE equipe ADD FOREIGN KEY (personne_id) REFERENCES personne (id)
GO

ALTER TABLE equipe_has_personne ADD FOREIGN KEY (equipe_id) REFERENCES equipe (id)
GO

ALTER TABLE equipe_has_personne ADD FOREIGN KEY (personne_id) REFERENCES personne (id)
GO

DELETE 
FROM equipe_has_personne;
DELETE 
FROM equipe;
DELETE 
FROM personne;
GO

INSERT INTO personne(prenom, nom) VALUES 
('Brad', 'Pitt'),
('Bruce', 'Willis'),
('Nicolas', 'Cage'),
('Angelina', 'Jolie'),
('Tom', 'Cruise'),
('Tom', 'Hanks'),
('Bob', 'Dylan'),
('Johnny', 'Cash'),
('Jimmy', 'Hendrix')

INSERT INTO equipe (nom, projet, personne_id) VALUES
('Team A','Projet site internet Mairie','1'),
('Team B','Projet CRM','4'),
('Team C','Projet ERP','7')


INSERT INTO equipe_has_personne(personne_id, equipe_id) VALUES 
('1','1'), 
('2','1'),
('3','1'),
('4','2'), 
('5','2'), 
('6','2'), 
('7','3'),
('8','3'),
('9','3')


/*Affiche 1 equipe */
SELECT  equipe.nom, equipe.projet, 
CONCAT(personne.prenom, personne.nom) AS Participant
FROM equipe_has_personne
INNER JOIN personne ON equipe_has_personne.personne_id=personne.id
INNER JOIN equipe ON equipe_has_personne.equipe_id=equipe.id
WHERE equipe_has_personne.equipe_id = 1;
GO

/*Affiche tous les equipes */
SELECT  equipe.nom, equipe.projet,
CONCAT(personne.prenom, personne.nom) AS Participant
FROM equipe_has_personne
INNER JOIN personne ON equipe_has_personne.personne_id=personne.id
INNER JOIN equipe ON equipe_has_personne.equipe_id=equipe.id
GO
