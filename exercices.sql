-- REQUETES SQL

--  Page Web de référence: sql.ch

exercice 1 a 

-- Donner la liste des titres des représentations

-- SELECT: nom de la colone ou des colones 
-- Utilisé pour lire des données issues de la base de données en retournant des enregistrements dans un tableau de résultat.

-- FROM: nom de la table
-- Indique le lieu dans lequel les données à lire se trouvent

-- r : Alias pour améliorer l'écriture en indiquant la bonne référence cela permet de limiter les fautes d'orthographe
-- (r correspond à la première lettre de la table désignée)

SELECT r.titre_representation
FROM representation r

exercice 1 b

-- Donner la liste des titres des représentations ayant lieu à l'opéra Bastille

-- La commande WHERE dans une requête SQL permet d’extraire les lignes d’une base de données qui respectent une condition.
-- Cela permet d’obtenir uniquement les informations désirées.

SELECT r.titre_representation
FROM representation r
WHERE r.lieu = "Opéra Bastille"

exercice 1 c

-- Donner la liste des noms des musiciens et des titres des représentations auxquelles ils participent

-- Faire 1 jointure quand on utilise 2 tables (2 pour 3 tables ...)
-- Elles se font entre la clé primaire et la clé étrangère

SELECT m.nom, r.titre_representation
FROM musicien m, representation r
WHERE m.representation_id = r.num_representation


exercice 1 d

-- Donner la liste des titres des représentations, les lieux et les tarifs pour la journée du 14/09/2014.

-- AND Remplace WHERE car on ne peut en mettre q'un

SELECT r.titre_representation, p.tarif
FROM representation r, programmer p
WHERE r.num_representation = p.representation_id
AND p.date = '2014-09-14'

exercice 2 a

-- a) Quel est le nombre total d'étudiants ?

-- En SQL, la fonction d’agrégation COUNT() permet de compter le nombre d’enregistrement dans une table.

SELECT COUNT(e.n_etudiant)
FROM etudiant e

exercice 2 b

-- Quelles sont, parmi l'ensemble des notes, la note la plus haute et la note la plus basse ?

-- MAX()La fonction d’agrégation MAX() permet de retourner la valeur maximale d’une colonne dans un set d’enregistrement.
-- MIN()La fonction d’agrégation MIN() permet de retourner la valeur minimale d’une colonne dans un set d’enregistrement.

SELECT MAX(e.note), MIN(e.note)
FROM evaluer e

SELECT n_etudiant, MAX(e.note), MIN(e.note)
FROM evaluer e
GROUP BY n_etudiant

-- GROUP BY Permet d'afficher la note max et min de chaque numéro d'étudiant

exercice 2 c

-- Quelles sont les moyennes de chaque étudiant dans chacune des matières ? (utilisez CREATE VIEW)

-- Avant de créer une VIEW on teste le SELECT pour vérifier si tout est ok

-- CREATE VIEW (on inscrit un nom qui fait référence à ce que l'on veut afficher)
-- Afin de créer une table virtuelle moyenne_etudiant (AS) de
-- L'intérêt de créer une VIEW est de pouvoir stocker un select pour le réutiliser plus tard

-- AS est un alias
-- etu - eva - m sont aussi des alias
-- AVG La fonction d’agrégation AVG() dans le langage SQL permet de calculer une valeur moyenne sur un ensemble d’enregistrement de type numérique et non nul.

--GROUP BY Pour grouper plusieurs résultats et utiliser une fonction de totaux sur un groupe de résultat. 

CREATE VIEW moyenne_etudiant AS

SELECT etu.n_etudiant, etu.nom, etu.prenom, m.libellemat, AVG(eva.note) AS moyEtu
FROM etudiant etu, evaluer eva, matiere m

WHERE eva.n_etudiant = etu.n_etudiant
AND eva.codemat = m.codemat

GROUP BY etu.n_etudiant, etu.nom, etu.prenom, m.libellemat

exercice 2 d

-- Quelles sont les moyennes par matière ? (cf. question c)

CREATE VIEW moyenne_matiere AS

SELECT m.libellemat, AVG(eva.note) AS moyMat
FROM matiere m, evaluer eva
WHERE eva.codemat = m.codemat

GROUP BY m.libellemat

exercice 2 e

-- Quelle est la moyenne générale de chaque étudiant ? 
--  (utilisez CREATE VIEW + cf. question 3)

-- Ajouter les coeficients pour le calcul de la moyenne générale
CREATE VIEW moyenne_generale AS
SELECT
	etu.n_etudiant,
	etu.nom,
	etu.prenom,
	SUM(moyMat*coeffmat)/SUM(coeffmat) AS moyGen

FROM moyEtu

--On peut remplacer l'alias de la vue par le select complet de celle ci
	-- ( 
	-- 	SELECT
	-- 		etu.n_etudiant,
	-- 		etu.nom,
	-- 		etu.prenom,
	-- 		m.libellemat,
	-- 		AVG(eva.note) AS MoyEtu
	-- 	FROM 
	-- 		etudiant etu,
	-- 		evaluer eva,
	-- 		matiere m
	-- 	WHERE
	-- 		eva.n_etudiant = etu.n_etudiant
	-- 	AND
	-- 		eva.codemat = m.codemat
	-- 	GROUP BY
	-- 		etu.n_etudiant,
	-- 		etu.nom,
	-- 		etu.prenom,
	-- 		m.libellemat
	-- )AS Saw
		
GROUP BY
	etu.n_etudiant,
	etu.nom,
	etu.prenom


























