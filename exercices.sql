-- REQUETES SQL Page Web de référence: sql.ch

exercice 1 a -- Donner la liste des titres des représentations 

SELECT r.titre_representation                                                       -- SELECT: nom de la colone ou des colones Utilisé pour lire des données issues de la base de données en retournant des enregistrements dans un tableau de résultat.
FROM representation r                                                               -- FROM: nom de la table Indique le lieu dans lequel les données à lire se trouvent

exercice 1 b-- Donner la liste des titres des représentations ayant lieu à l'opéra Bastille

SELECT r.titre_representation                                                       -- La commande WHERE dans une requête SQL permet d’extraire les lignes d’une base de données qui respectent une condition.
FROM representation r
WHERE r.lieu = "Opéra Bastille"

exercice 1 c-- Donner la liste des noms des musiciens et des titres des représentations auxquelles ils participent

SELECT m.nom, r.titre_representation
FROM musicien m, representation r
WHERE m.representation_id = r.num_representation                                    -- Faire 1 jointure quand on utilise 2 tables (2 pour 3 tables ...) Elles se font entre la clé primaire et la clé étrangère

exercice 1 d-- Donner la liste des titres des représentations, les lieux et les tarifs pour la journée du 14/09/2014.

SELECT r.titre_representation, p.tarif
FROM representation r, programmer p
WHERE r.num_representation = p.representation_id
AND p.date = '2014-09-14'                                                           -- AND Remplace WHERE car on ne peut en mettre q'un

exercice 2 a-- Quel est le nombre total d'étudiants ?

SELECT COUNT(e.n_etudiant)                                                          -- En SQL, la fonction d’agrégation COUNT() permet de compter le nombre d’enregistrement dans une table.
FROM etudiant e

exercice 2 b-- Quelles sont, parmi l'ensemble des notes, la note la plus haute et la note la plus basse ?

SELECT MAX(e.note), MIN(e.note)                                                     -- MAX() et MIN() sont des fonctions d’agrégation permettent de retourner la valeur maximale et minimale d’une colonne dans un set d’enregistrement.
FROM evaluer e
SELECT n_etudiant, MAX(e.note), MIN(e.note)
FROM evaluer e
GROUP BY n_etudiant                                                                 -- GROUP BY Permet d'afficher la note max et min de chaque numéro d'étudiant

exercice 2 c-- Quelles sont les moyennes de chaque étudiant dans chacune des matières ? (utilisez CREATE VIEW)

CREATE VIEW moyenne_etudiant AS                                                     -- Avant de créer une VIEW on teste le SELECT pour vérifier si tout est ok-- CREATE VIEW (on inscrit un nom qui fait référence à ce que l'on veut afficher) L'intérêt de créer une VIEW est de pouvoir stocker un select pour le réutiliser plus tard
SELECT etu.n_etudiant, etu.nom, etu.prenom, m.libellemat, AVG(eva.note) AS moyEtu
FROM etudiant etu, evaluer eva, matiere m                                           -- AVG La fonction d’agrégation AVG() dans le langage SQL permet de calculer une valeur moyenne sur un ensemble d’enregistrement de type numérique et non nul.
WHERE eva.n_etudiant = etu.n_etudiant                                               -- AS est un alias
AND eva.codemat = m.codemat                                                         -- etu - eva - m sont aussi des alias
GROUP BY etu.n_etudiant, etu.nom, etu.prenom, m.libellemat                          -- GROUP BY Pour grouper plusieurs résultats et utiliser une fonction de totaux sur un groupe de résultat. 

exercice 2 d-- Quelles sont les moyennes par matière ? (cf. question c)

CREATE VIEW moyenne_matiere AS
SELECT m.libellemat, AVG(eva.note) AS moyMat
FROM matiere m, evaluer eva
WHERE eva.codemat = m.codemat
GROUP BY m.libellemat

exercice 2 e-- Quelle est la moyenne générale de chaque étudiant ? (utilisez CREATE VIEW + cf. question 3)

CREATE VIEW moyenne_generale_etudiant AS
SELECT etu.nom, etu.prenom, AVG(eva.note) AS moyGenEtu
FROM etudiant etu, evaluer eva
WHERE etu.n_etudiant = eva.n_etudiant
GROUP BY etu.nom, etu.prenom                                                -- et on fait cette opération pour chaque étudiant. C'est ce qui permet d'afficher la moyenne pour 1 étudiant donné.

exercice 2 f-- Quelle est la moyenne générale de la promotion ? (cf. question e)

CREATE OR REPLACE VIEW moyenne_promo AS
SELECT AVG(evaluer.note) AS moyennePromo
FROM evaluer

exercice 2 g--Quels sont les étudiants qui ont une moyenne générale supérieure ou égale à la moyenne générale de la promotion ? (cf. question e)

CREATE VIEW moyenne_sup AS
SELECT etu.prenom, mge.moyGenEtu, mp.moyennePromo                           -- on récupère le prénom de l'étudiant sa moyenne générale ainsi que la moyenne de la promo depuis la précédente View. 
FROM etudiant etu, moyenne_generale_etudiant mge, moyenne_promo mp
WHERE mge.moyGenEtu >= mp.moyennePromo                                      -- on créer 2 conditions WHERE comparer la moyenne générale à la moyenne de la promo 
AND etu.prenom = mge.prenom                                                 -- AND afficher les élèves dont la moyenne générale est supérieur à la moyenne de la promo

exercice 3 a--Numéros et libellés des articles dont le stock est inférieur à 10 




















