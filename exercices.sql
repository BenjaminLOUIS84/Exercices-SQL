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












