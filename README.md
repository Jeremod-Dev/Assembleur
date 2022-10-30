# Assembleur
*Ce repository a pour but de rassembler les connaissances et les principes que j'ai découvert sur le langage d'assembleur (notation ad hoc asm)*

Caractéristiques de la machine:
- OS: Linux Manjaro
- Architecture: x86_64
- Syntaxe favorisée: Intel

---
## Introduction

Lors de mon passage à l'Institut Universitaire de Technologie du Limousin au département Informatique, j'ai eu un module (M2201) qui avait pour objectif de nous donner les prémices de l'architecture système et les mécanismes de programmation d'un système informatique. Dans ce module nous avons abordé l'encodage dans différentes bases (binaire, octal, decimal, hexadecimal). Par la suite, le cours m'a permis d'apprendre le principe de la Stack (pile) et des registres avec un programme en Rust et en assembleur. Cependant, le nombre de cours sur le module étant restreint, je n'ai pas pu apprendre beaucoup plus de choses sur les langages d'assembleur. Afin d'éclaircir le flou à propos de certaines notions et d'approfondir le cours, j'ai pris la décision d'apprendre un langage d'assembleur et de developper de petits programmes. Le but étant de développer au plus près de la machine. Ce README permettra de transmettre les connaissances et de les garder en mémoire.  

## Sommaire

- [Le système d'exploitation et processeur](#system)


## Le système d'exploitation et processeur <a id="system"></a>

L'informatique est un domaine vaste et varié qui admet deux grands domaines: le __hardware__ et le __software__. 

Le __hardware__ est la partie matériel de l'informatique avec le processeur, la carte mère et la carte graphique par exemple.
Le __software__ la partie logiciel avec le système d'exploitation par exemple.

Ces deux domaines sont interdépendants. Quand j'ai débuté en programmation, je me suis, comme beaucoup, interessé à des langages dit de haut niveau, ie dans langage éloigné du celui de la machine. Il me semble toute fois, très important de comprendre le fonctionnement de notre machine. Par ailleurs, j'ai eu au début de mon DUT des cours pour apprendre le fonctionnement d'un OS (Linux). De ce fait, cela vient conforter l'idée qu'il est primordial d'apprendre le fonctionnement de ces outils.

Le systeme d'exploitation et le langage d'assembleur (notation ad hoc asm) sont très utiles pour comprendre cela.

A ce jour, il y existe 3 SE (=Systeme Exploitation ou OS) dominant: __Windows__, __MacOS__ et __Linux__. Ils permettent le fonctionnement de l'ordinateur. C'est plus particulièrement, le noyau de l'OS appelé Kernel. Et nous pouvons intéragir avec via le shell notamment.

Le processeur est un composant matériel qui permet de faire des calculs. Il admet une horloge qui donne le "rythme", des registres qui permettent d'enregistrer des valeurs, un bus de données qui permet le transport des données, un bus d'adresse qui permet le transport des données et la MMU pour la gestion de la mémoire. L'horloge émet un signal régulier pour synchroniser les processus. Les registres sont des cases mémoire internes au processeur. Leur proximité permet une vitesse de calcul très rapide comporé au disque dur par exemple.

Un processeur peut réaliser des opérations grâce à son "cablage". Ces opérations peuvent être `nop`, `call`, `jump` etc. Lorsque l'on cherche à développer directement avec les instructions du processeur, on dit que l'on fait de l'assembleur.

## Le langage d'assembleur

Pour commencer, il n'existe pas un asm. Il va varier en fonction de l'OS, de l'architecture et de la syntaxe. J'ai choisi dans mon cas de développer sous Linux qui permet une certaine liberté comparé à windows qui est limitant.

Avant de developper, je me suis renseigné sur les types de fichiers. J'ai compris qu'il existait deux types de fichier: les fichiers __binaire__ et __texte__. De là, je vais devoir transformer mon code en un objet qui sera lié avec un lieur (ld sous linux). 

Pour programmer en asm il faut suivre une structure conventionnelle. Je vous propose de developper en suivant des indications, votre premier code en assembleur. Pour cela suivez les indications en cliquant sur ce [BOUTON](MonPremierProgramme.md)

---

## Les Registres
