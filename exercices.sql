--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- REQUETES SQL Page Web de référence: sql.ch
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

-- EXERCICE 1

-- REPRESENTATION (N°REPRESENTATION, TITRE_REPRESENTATION, LIEU) 
-- MUSICIEN (NOM, N°REPRESENTATION*) 
-- PROGRAMMER (DATE, N°REPRESENTATION*, TARIF)

--REPRESENTATION (N°REPRESENTATION, TITRE_REPRESENTATION, LIEU)
CREATE TABLE representation
(
    num_representation INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    titre_representation VARCHAR(50),
    lieu VARCHAR(50)
)

-- MUSICIEN (NOM, N°REPRESENTATION*) 
CREATE TABLE musicien
(
    nom VARCHAR(50) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    representation_id INT, CONSTRAINT fk_musicien_representation
    FOREIGN KEY () REFERENCES 
)

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

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

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

-- EXERCICE 2

-- ETUDIANT (N°ETUDIANT, NOM, PRENOM) 
-- MATIERE (CODEMAT, LIBELLEMAT, COEFFMAT) 
-- EVALUER (N°ETUDIANT*, CODEMAT*, DATE, NOTE)

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

exercice 2 a-- Quel est le nombre total d'étudiants ?

SELECT COUNT(e.n_etudiant)                                                          -- En SQL, la fonction d’agrégation COUNT() permet de compter le nombre d’enregistrement dans une table.
FROM etudiant e

exercice 2 b-- Quelles sont, parmi l'ensemble des notes, la note la plus haute et la note la plus basse ?

SELECT MAX(e.note), MIN(e.note)                                                     -- MAX() et MIN() sont des fonctions d’agrégation permettent de retourner la valeur maximale et minimale d’une colonne dans un set d’enregistrement.
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

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

-- EXERCICE 3

-- ARTICLES (NOART, LIBELLE, STOCK, PRIXINVENT)
-- FOURNISSEURS (NOFOUR, NOMFOUR, ADRFOUR, VILLEFOUR)
-- ACHETER (NOFOUR#, NOART#, PRIXACHAT, DELAI)

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

exercice 3 a--Numéros et libellés des articles dont le stock est inférieur à 10 

SELECT a.n_art, a.libelle
FROM articles a
WHERE a.stock <10

exercice 3 b--Liste des articles dont le prix d'inventaire est compris entre 100 et 300

SELECT a.libelle, a.prixinvent
FROM articles a
WHERE a.prixinvent >100
AND a.prixinvent <300

exercice 3 c--Liste des fournisseurs dont on ne connaît pas l'adresse 

SELECT f.nom_four, f.adresse_four
FROM fournisseurs f
WHERE f.adresse_four IS NULL                                                --Dans le langage SQL, l’opérateur IS permet de filtrer les résultats qui contiennent la valeur NULL.
                                                                            --IS NULL permet de filtrer les références qui n'ont pas d'adresse (Valeur par défaut NULL)

exercice 3 d--Liste des fournisseurs dont le nom commence par "STE"

SELECT f.nom_four
FROM fournisseurs f
WHERE f.nom_four LIKE 'STE%'                                                --L’opérateur LIKE est utilisé dans la clause WHERE des requêtes SQL.
                                                                            --Ce mot-clé permet d’effectuer une recherche sur un modèle particulier.
                                                                            --'STE%' permet de filtrer les références qui commencent par STE

exercice 3 e--Noms et adresses des fournisseurs qui proposent des articles pour lesquels le délai d'approvisionnement est supérieur à 20 jours 

SELECT f.nom_four, f.adresse_four, f.ville_four, ach.delai
FROM fournisseurs f, acheter ach
WHERE ach.delai>20                                                          --Pour afficher les délais >20 jours
AND f.n_four = ach.n_four                                                   --Pour afficher que les fournisseurs concernés

exercice 3 f--Nombre d'articles référencés

SELECT COUNT(art.n_art)                                                     --COUNT() Pour compter le nombre de références 
FROM articles art

exercice 3 g--Valeur du stock

SELECT SUM(art.prixinvent)                                                  --SUM() Pour calculer la somme de tous les (prixinvent) des références pour obtenir la valeur totale du stock 
FROM articles art

exercice 3 h--Numéros et libellés des articles triés dans l'ordre décroissant des stocks

SELECT art.n_art, art.libelle
FROM articles art
ORDER BY art.n_art DESC                                                     --La commande ORDER BY permet de trier les lignes dans un résultat d’une requête SQL.
                                                                            --Il est possible de trier les données sur une ou plusieurs colonnes, par ordre ascendant ASC ou descendant DESC.

exercice 3 i--Liste pour chaque article (numéro et libellé) du prix d'achat maximum, minimum et moyen 

SELECT art.n_art, art.libelle,                                              --On rentre toutes les valeurs que l'on souhaite afficher
    MAX(ach.prix_achat), MIN(ach.prix_achat), ROUND(AVG(ach.prix_achat),2)  --On peut également ajouter des formules de calcul ROUND(,2) permet d'arrondir après la virgule

FROM articles art, acheter ach                                              --On inscrit les 2 tables employées pour cette requête
WHERE art.n_art = ach.n_art                                                 --On fait la jointure entre la clé primaire et la clé étrangère d'une même valeur ici le numéro des références
GROUP BY art.n_art, art.libelle                                             --On permet d'afficher avec GROUP BY les numéros et les libellés des références 

exercice 3 j--Délai moyen pour chaque fournisseur proposant au moins 2 articles

CREATE VIEW fournisseurs_produits_delai AS                                  --Créer une vue d'un tableau dans lequel il y a les fournisseurs, les produits et les delais
SELECT art.libelle, f.nom_four, ach.delai                                   --Afin de conserver une trace des fournisseurs qui proposent plusieurs produits
FROM articles art, fournisseurs f, acheter ach
WHERE f.n_four = ach.n_four 
AND art.n_art = ach.n_art
GROUP BY art.libelle, f.nom_four, ach.delai

SELECT f.nom_four, ROUND(AVG(ach.delai)) AS delai_moyen                     --Pour afficher un tableau qui présente les fournisseurs et leurs délais moyens respectif
FROM fournisseurs f, acheter ach
WHERE f.n_four = ach.n_four
GROUP BY f.nom_four

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

-- EXERCICE 4

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

exercice 4 a--Liste de tous les étudiants

SELECT et.numetu, et.nom, et.prenom
FROM etudiant et

exercice 4 b--Liste de tous les étudiants, classée par ordre alphabétique inverse

SELECT et.numetu, et.nom, et.prenom
FROM etudiant et
ORDER BY et.nom DESC

exercice 4 c--Libellé et coefficient (exprimé en pourcentage) de chaque matière

SELECT mat.libelle, mat.coef, ROUND(SUM(mat.coef*100)) AS '%'
FROM matiere mat
WHERE mat.codemat < 4
GROUP BY mat.libelle, mat.coef

exercice 4 d--Nom et prénom de chaque étudiant

SELECT et.nom, et.prenom
FROM etudiant et

exercice 4 e--Nom et prénom des étudiants domiciliés à Lyon

SELECT et.nom, et.prenom, et.rue, et.cp, et.ville
FROM etudiant et
WHERE et.ville = "LYON"

exercice 4 f--Liste des notes supérieures ou égales à 10

SELECT n.note
FROM notation n
WHERE n.note >= 10

exercice 4 g--Liste des épreuves dont la date se situe entre le 1er janvier et le 30 juin 2014

SELECT ep.numepreuve, ep.datepreuve
FROM epreuve ep
WHERE ep.datepreuve BETWEEN '2014-01-01' AND '2014-06-30'                       --L’opérateur BETWEEN est utilisé dans une requête SQL pour sélectionner un intervalle
                                                                                --de données dans une requête utilisant WHERE.

exercice 4 h--Nom, prénom et ville des étudiants dont la ville contient la chaîne "ll"

SELECT etu.nom, etu.prenom, etu.ville
FROM etudiant etu
WHERE etu.ville LIKE '%||'

exercice 4 i--Prénoms des étudiants de nom Dupont, Durand ou Martin

SELECT etu.nom, etu.prenom
FROM etudiant etu
WHERE etu.nom IN ('MARTIN','DUPONT','DURAND')                                   --L’opérateur logique IN dans SQL  s’utilise avec la commande WHERE pour vérifier 
                                                                                --si une colonne est égale à une des valeurs comprise dans set de valeurs déterminés.

exercice 4 j--Somme des coefficients de toutes les matières

SELECT ROUND(SUM(m.coef),2) AS Somme_des_coef, ROUND(SUM(m.coef),2)*100 AS '%'
FROM matiere m

exercice 4 k--Nombre total d'épreuves

SELECT COUNT(ep.numepreuve) AS Nombre_Epreuves
FROM epreuve ep

exercice 4 l--Nombre de notes indéterminées (NULL)

SELECT COUNT(n.note IS NULL) AS Nombre_de_Notes_NULL                            --Compter toute les notes en incluant les notes NULL
FROM notation n
WHERE n.note IS NULL                                                            --Filtrer les notes NULL pour afficher celles-ci

exercice 4 m--Liste des épreuves (numéro, date et lieu) incluant le libellé de la matière

SELECT ma.libelle, ep.numepreuve, ep.datepreuve, ep.lieu
FROM matiere ma, epreuve ep
WHERE ma.numepreuve = ep.numepreuve
ORDER BY ep.datepreuve ASC

exercice 4 n--Liste des notes en précisant pour chacune le nom et le prénom de l'étudiant qui l'a obtenue

SELECT etu.nom, etu.prenom, n.note
FROM etudiant etu, notation n
WHERE etu.numetu = n.numetu

exercice 4 o--Liste des notes en précisant pour chacune le nom et le prénom de l'étudiant qui l'a obtenue et le libellé de la matière concernée

SELECT etu.nom, etu.prenom, n.note, m.libelle
FROM etudiant etu, notation n, matiere m
WHERE etu.numetu = n.numetu
AND m.numepreuve = n.numepreuve

exercice 4 p--Nom et prénom des étudiants qui ont obtenu au moins une note égale à 20

SELECT etu.nom, etu.prenom, m.libelle, n.note
FROM etudiant etu, notation n, matiere m
WHERE etu.numetu = n.numetu
AND n.numepreuve = m.numepreuve
AND n.note = 20

exercice 4 q--Moyennes des notes de chaque étudiant (indiquer le nom et le prénom)

CREATE VIEW Notes_des_Eleves AS
SELECT etu.nom, etu.prenom, m.libelle, ROUND(AVG(n.note), 2) AS Notes
FROM etudiant etu, notation n, matiere m
WHERE etu.numetu = n.numetu
AND n.numepreuve = m.numepreuve
GROUP BY etu.nom, etu.prenom, m.libelle

SELECT etu.prenom, ROUND(AVG(n.note), 2) AS Moyenne
FROM etudiant etu, notation n
WHERE etu.numetu = n.numetu
GROUP BY etu.numetu

exercice 4 r--Moyennes des notes de chaque étudiant (indiquer le nom et le prénom), classées de la meilleure à la moins bonne

SELECT etu.prenom, ROUND(AVG(n.note), 2) AS Moyenne
FROM etudiant etu, notation n
WHERE etu.numetu = n.numetu
GROUP BY etu.numetu
ORDER BY Moyenne DESC

exercice 4 s--Moyennes des notes pour les matières (indiquer le libellé) comportant plus d'une épreuve

SELECT mat.libelle, ROUND(AVG(n.note), 2) AS Moyenne_Matieres
FROM matiere mat, notation n
WHERE mat.numepreuve = n.numepreuve
GROUP BY mat.libelle

exercice 4 t--Moyennes des notes obtenues aux épreuves (indiquer le numéro d'épreuve) où moins de 6 étudiants ont été notés

SELECT ep.numepreuve, ROUND(AVG(n.note), 2) AS Moyenne_Epreuves
FROM epreuve ep, notation n
WHERE ep.numepreuve = n.numepreuve
GROUP BY ep.numepreuve

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

-- EXERCICE 5

-- USINE (NumU, NomU, VilleU)
-- PRODUIT (NumP, NomP, Couleur, Poids)
-- FOURNISSEUR (NumF, NomF, Statut, VilleF)
-- LIVRAISON (NumP, NumU, NumF, Quantité)

-- USINE(NumU, NomU, VilleU)
CREATE TABLE usine 
(
  numU INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  nomU VARCHAR(50),
  villeU VARCHAR(50)
)

-- PRODUIT(NumP, NomP, Couleur, Poids)

CREATE TABLE produit
(
  numP INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
	nomP VARCHAR(50), 
	couleur VARCHAR(50), 
	poids FLOAT
)

-- FOURNISSEUR(NumF, NomF, Statut, VilleF)

CREATE TABLE fournisseur
(
  numF INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
  nomF VARCHAR(50), 
  statut VARCHAR(10), 
  villeF VARCHAR(50)
)

-- LIVRAISON(NumP, NumU, NumF, Quantité)

CREATE TABLE livraison
(
  quantite INT,
  numP_id INT,
  numU_id INT,
  numF_id INT,
  CONSTRAINT fk_livraison_produit
  FOREIGN KEY (numP_id) REFERENCES produit(numP),
  CONSTRAINT fk_livraison_usine
  FOREIGN KEY (numU_id) REFERENCES usine(numU),
  CONSTRAINT fk_livraison_fournisseur
  FOREIGN KEY (numF_id) REFERENCES fournisseur(numF)
);

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

exercice 5 a--Ajouter un nouveau fournisseur avec les attributs de votre choix

INSERT INTO fournisseur (NumF, NomF, Statut, VilleF)    --L’insertion de données dans une table s’effectue à l’aide de la commande INSERT INTO. 
VALUES (5, 'SaintMamet','Dispo', 'Nantes');             --Cette commande permet au choix d’inclure une seule ligne à la base existante ou plusieurs lignes d’un coup.

exercice 5 b--Supprimer tous les produits de couleur noire et de numéros compris entre 100 et 1999










exercice 5 c--Changer la ville du fournisseur 3 par Mulhouse


























