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


