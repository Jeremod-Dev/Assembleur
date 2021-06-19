# Assembleur
*Ce repository a pour but de rassembler les connaissances et principe que j'ai découverts sur le langage d'assembleur (notation ad hoc asm)*

Caractéristique de la machine:
- OS: Linux Manjaro
- Architecture: x86_64
- Syntaxe favorisé: Intel

---
## Introduction

Lors de mon passage à l'Institut Universitaire de Technologie du Limousin au département Informatique, j'ai eu un module (m2201) qui avait pour objectif de nous donner les prémices de l'architectur systeme et les mécanismes de programmation d'un système informatique. Dans ce module nous avons abordé l'encodage dans différentes bases (binaire, octal, decimal, hexadecimal). Par la suite, le cours m'a permis d'apprendre le principe de la Stack (pile) et des registres avec un programme en Rust et assembleur. Cependant, le nombre de cours sur le module étant restrinct je n'ai pas pus apprendre beaucoup plus de choses sur les langages d'assembleur. Afin d'éclaircir le flou de lié à certaines notions et d'approfondir le cours, j'ai pris la décision d'apprendre un langage d'assembleur et de developper de petits programmes. Le but étant de développer au plus près de la machine. Ce README permettra de transmettre les connaissances et de les garder en mémoire.  

## Sommaire

- [Le systeme d'exploitation et processeur](#system)
- [Developper son premier programme](#HelloWord)


## Le systeme d'exploitation et processeur <a id="system"></a>

L'informatique est un domaine vaste et varié qui admet deux grands domaines: le __hardware__ et le __software__. 

Le __hardware__ est la partie matériel de l'informatique avec le processeur, la carte mère et la carte graphique par exemple.
Le __software__ la partie logiciel avec le système d'exploitation par exemple.

Ces deux domaines sont interdépendants. Quand j'ai débuté en programmation, je me suis, comme beaucoup, interessé à des langages dit de haut niveau, ie dans langage éloigné du celui de la machine. Il me semble tout fois très important de comprendre le fonctionnement de notre machine. Par ailleurs, j'ai eu au début de mon DUT des cours pour apprendre le fonctionnement d'un OS (Linux). De ce fait, cela vient conforter l'idée qu'il est primordial d'apprendre le fonctionnement de ses outils.

Le systeme d'exploitation et le langage d'assembleur (notation ad hoc asm) sont très utile pour comprendre cela.

A ce jour, il y existe 3 SE (=Systeme Exploitation ou OS) dominant: __Windows__, __MacOS__ et __Linux__. Il permette le fonctionnement de l'ordinateur. C'est plus particulièrement, le noyau de l'OS appelé Kernel. Et nous pouvons interragir avec via le shell.

Le processeur est un composant materiel qui permet de faire des calculs. Il admet une horloge et des registres. L'horloge emet un signal regulier pour synchroniser les processus. Les registres sont des cases mémoire interne au processeur. Leur proximité permet une vitesse de calcul rapide.

## Le langage d'assembleur

Pour commencer, il n'existe pas un asm. Il va varié en fonction de l'OS, de l'architecture et de la syntaxe. J'ai choisi dans mon cas de developper sous Linux qui permet une liberté comparé à windows qui est limitant.

Avant de developper, je me suis renseigné sur les type de fichier. J'ai compris qu'il existait deux types de fichier: les fichiers __binaire__ et __texte__. De là, je vais devoir transformer mon code en un objet que je vais devoir lié avec un lieur (ld sous linux). 

Pour programmer en asm il faut suivre une structure conventionnelle. Je vous proposes de developper en suivant des indications, votre premier code en assembleur. Ensuite, nous essayerons de comprendre ce qui ce cache derrière certains mot barbare.

---

## Details

Après avoir codé un petit programme simpliste, voyons quelques notions qui paraissent importante. Tout d'abord les instructions `mov`, `jmp` et `syscall` sont appelés des mnémoniques.

De plus, l'affichage retourné par le désassemblage admet des differences avec notre code. Nous avons davantage de détails comme l'adresse de chaque instruction et la valeur de cette derniere en hexadecimal. Le mnémonique `syscall` correspond en hexadecimal à `07 05`, cad en binaire `0000 0111 0000 0101`.

L'argument de l'instruction `jmp` est modifié par l'adresse de l'étiquette passé en argument.

---
## Les Registres