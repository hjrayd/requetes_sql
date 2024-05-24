
/* 1-Nom des lieux qui finissent par 'um'*/

SELECT *
FROM Lieu
WHERE nom_lieu
LIKE "%um";

/* 2-Nombre de personnage par lieu(trié par nombre de personnage décroissant)*/

SELECT nom_lieu,
COUNT(id_personnage) AS nb_personnages
FROM personnage
INNER JOIN lieu ON personnage.id_lieu = lieu.id_lieu
GROUP BY personnage.id_lieu
ORDER BY nb_personnages DESC;

/* 3- Nom des personnages + spécialité + adresse et lieu d'habitation, triés par lieu puis par nom de personnage*/
SELECT personnage.nom_personnage, specialite.nom_specialite, personnage.adresse_personnage, lieu.nom_lieu
FROM personnage
INNER JOIN lieu ON personnage.id_lieu = lieu.id_lieu
INNER JOIN specialite ON personnage.id_specialite = specialite.id_specialite
ORDER BY lieu.nom_lieu, personnage.nom_personnage;
/* 4- Nom des spécialités avec nombres des personnages par spécialité (trié par nombre de personnage décroissant*/

SELECT nom_specialite,
COUNT(id_personnage) AS nb_personnages
FROM personnage
INNER JOIN specialite ON personnage.id_specialite = specialite.id_specialite
GROUP BY personnage.id_specialite
ORDER BY nb_personnages DESC;

/*5- Nom, date et lieu des batailles, classées de la plus récente à la plus ancienne (dates afficéhes au format jj/mm//aaaa)*/
 SELECT DATE_FORMAT(bataille.date_bataille, "%D %b %Y"), bataille.nom_bataille, lieu.nom_lieu
 FROM bataille
 INNER JOIN lieu ON bataille.id_lieu = lieu.id_lieu
 ORDER BY bataille.date_bataille DESC;

 /*6-Nom des potions + couts de réalisation de la potion(trié par coût décroissant)*/

 SELECT 	potion.nom_potion,
SUM(ingredient.cout_ingredient * composer.qte) AS prix_potion
FROM potion
INNER JOIN composer ON potion.id_potion = composer.id_potion
INNER JOIN ingredient ON composer.id_ingredient = ingredient.id_ingredient
GROUP BY potion.id_potion
ORDER BY prix_potion DESC;

/*7- Nom des ingrédients+coût+quantité de chaque ingrédients qui composent la potion 'santé'*/

SELECT ingredient.nom_ingredient, ingredient.cout_ingredient, composer.qte
FROM ingredient
INNER JOIN composer ON ingredient.id_ingredient = composer.id_ingredient
INNER JOIN potion ON composer.id_potion = potion.id_potion
WHERE potion.nom_potion = 'Santé';

/*8-Nom du ou des personnages qui ont pris le plus de casques dans la bataille '	Bataille du village gaulois'*/

/*9-Nom des personnages et leur quantité de potion bue (en les lcassant du plus grand buveur au plus petit)*/
SELECT personnage.nom_personnage,
SUM(boire.dose_boire) AS 'quantite_potion_bue'
FROM personnage
INNER JOIN boire ON personnage.id_personnage = boire.id_personnage
GROUP BY personnage.id_personnage
ORDER BY quantite_potion_bue DESC;

/*10-Nom de la bataille oèu le nombre de casques pris a été le plus important*/
SELECT bataille.nom_bataille
FROM bataille
INNER JOIN prendre_casque ON bataille.id_bataille = prendre_casque.id_bataille

/*11-Combien existe-il de casques de chaque type et quel est leur cpût total ? (classés par nombre décroissant)*/


SELECT type_casque.nom_type_casque,
COUNT(type_casque.id_type_casque),
SUM(casque.cout_casque) AS cout_total_casque
FROM type_casque
INNER JOIN casque ON type_casque.id_type_casque = casque.id_type_casque
GROUP BY type_casque.id_type_casque
ORDER BY cout_total_casque DESC;