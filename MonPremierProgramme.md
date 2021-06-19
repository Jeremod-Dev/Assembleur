## Developper son premier programme

### Prérequis
Pour developper un programme en asm, il vous faudra utiliser le SE `archlinux` ou `Manjaro`, le compilateur `NASM` et le lieur `ld` *Deja present sous linux*

Si vous n'avez pas de machine a disposition où vous pouvez installer Linux utilisé une machine virtuelle. De plus, pour installer `nasm` sur archlinux ou manjaro faites:


```bash
pamac install nasm
```
puis
```bash
sudo pacman -S nasm
```
puis confirmé en appuyant sur `o` lors de la demande de confirmation.

## Commençons par le commencement

Creé un fichier `ficNom`.asm ou `ficNom`.s

```asm
bits 64
```
Ce bout de code indique l'architecture de la machine
*`uname -a` si x86->32 bits, si x86_64 =>64 bits*

Par la suite, scindez le fichier en section:
- Section .data: Dans cette section nous allons y mettre les variables initialisées
```c
//exemple de variable initialisées
int variable = 45;
```
- Section .bss: Dans cette section nous allons y mettre les variables allouées mais non-initialisées
```c
//exemple de variable non-initialisées
int variable;
```
- Section .text: Dans cette section nous allons y mettre mon code.
```c
printf("Hello Word !"); 
```
Rien de compliqué jusqu'ici :smile:

Asm demande de séparer le glossaire entre les variables initialisées et non-initialisés car elle ne vont pas aller dans le même endroit dans la machine. :wink:

Continuons!

Déclarons à présent, une variable de type chaine de caractères. Pour cela, je vais utilisé l'instruction `db` qui signifie `Data Byte` et sert à "allouer" de la memoire pour inserer des données. Voici quelques variantes:

instruction | Taille
------------|--------
db | 1 octet (= 1 byte)
dw | 2 octets
dd | 4 octets
dq | 8 octets

```asm
bits 64

section .data
    maVar db "Hello Word !",10
```
> le 10 correspond au retour à la ligne (table ascii)

Nous venons de déclarer et instancier notre première variable en asm

Quand nous programmons en c, c++ ou meme python. Nous devons spécifier à la machine l'entrée du programme, souvent c'est la procédure `main`. Dans notre cas, pour le spécifié nous devons utiliser le mot clef `global` en y mettant le nom de mon __etiquette__ d'entrée.

```asm
bits 64

global _start ; déclaration du point d'entrée du programme

section .data
    maVar db "Hello Word !",10

section .text
_start:
    ; Inserer son code
```
Une étiquette peux s'apparenté de loin à une fonction.
Pour pouvoir afficher, ma variable dans la console, je vais utilisé un `appel systeme`. L'identifiant de l'appel systeme ecrire est `1`.
> Pour ne pas apprendre tous les identifiants des appels systemes je vous proposes de jeter un oeil au [tableau](https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/)

Dans le cas de l'appel systeme 1, le tableau indique plusieurs informations à saisir. Tout d'abord, mettre de le registre `rax` l'identifiant de l'appel systeme, puis dans `rdi` le code de la sortie/entrée à utiliser (stdin = 0, stdout = 1, stderr = 2). Ensuite, il faut renseigner dans `rsi` la variable, puis dans `rdx` la taille de la variable.

Pour pouvoir mettre une valeur dans un registre l'instruction `mov` est parfaite. 

```asm
mov <destination>, <source>
```
Du coup, l'etiquette `_start` doit ressembler à ça:
```asm
bits 64

global _start

section .data
    maVar db "Hello Word !",10

section .text
_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, maVar
    mov rdx, 14 ;nbr de caractères dans maVar
    syscall
```
**Le caractère `;` sert à commenter le code*

A prèsent, nous allons assembler votre code en fichier objet. Pour ce faire, tapez dans votre terminal se trouvant dans le dossier du fichier .asm ou .s:
```bash
nasm -f elf64 nomFic.asm -o nomFic.o
```
Puis créer le lien en faisant:

```bash
ld nomFic.o -o nomFic
```
Le fichier nomFic est executable. Faites:

```
./nomFic
```
*si cela ne fonctionne pas, changez les droits sur le fichier avec un bon vieux `chmod`*

Pour assembler et tester notre programme nous ferons toujours cette manipulation.
Le programme s'execute... :smile: 

```asm 
Hello Word !
Erreur de segmentation (core dumped)
```

mais il y a une erreur :unamused:

*`echo $?` permet de savoir la valeur du code erreur dans notre cas 139*

L'erreur intervient car le programme a été fermé par l'OS. Il serait préférable de le faire nous même afin d'éviter toutes erreurs.

Dans notre code, à la suite da `_start` nous allons créer une nouvelle étiquette`_exit`. Dans cette étiquette nous allons utiliser un nouvel appel système cad le `sys_exit` avec l'id 60. Retournez dans le tableau de tout à l'heure, allez à la ligne 60 et essayer de faire la meme manipulation que précedemment. Par ailleurs pour le code erreur nous lui attriburons la valeur `0` étant donné que c'est la valeur qui signifie `pas d'erreur à l'horizon`. Une fois le code ajouté à la suite, le programme n'appel pas l'étiquette `_exit`. Dans ce cas, il faut que dans `_start` nous appelions `_exit`. Cela se fait avec l'instruction `jmp` (jump). Votre code devrait ressembler à ça:

```asm
bits 64
global _start

section .data
    maVar db "Hello World !",10

section .text
_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, maVar
    mov rdx, 14
    syscall
    jmp _exit ;appel l'etiquette _exit

_exit:
    mov rax, 60 ; id processus sys_exit
    mov rdi, 0 ; id code erreur 'ok'
    syscall ;appel systeme
```
Assemblez et executez le programme. Plus d'erreur! :smile: et `echo $?` donne le code `0`. Nickel!

A prèsent amusons nous, changons `Hello Word !` par `Hello Word ! Je m'appelle Jeremy`.

On execute :smile: ... et bruh... :unamused: La deuxième partie de la chaine ne s'affiche pas!

En effet, dans `_start`, nous avons spécifié que la chaine faisait 14 caractères donc le programme affiche 14 caractères. Nous pourrions de nouveau compter le nombre de caractère dans la chaine mais ca risque d'etre agaçant. Du coup on va faire quelque chose de plus dynamique.

Tout d'abord, il faut compter le nombre de caractères contenu dans la chaine. Dans la section `.data`, à la suite de l'initialisation de maVar, declarez et initialisez une variable qui est egal au nombre de caractères de maVar.... Vous attendez quoi? Allez y.
:smile: Je rigole, c'est plus compliqué que tout à l'heure, tout fois ça ressemble à du code bash.

```asm
section .data
    maVar db "Hello Word !",10
    longueur equ $-maVar ; 'equ' => 'égale à'
```
Une fois la variable prête, faut l'utilisé. Dans `.text` dans `_start` substitué le `14` par `longueur`

```asm
bits 64

global _start

section .data
    maVar db "Hello World ! Je m'appelle Jérémy",10,0
    longueur equ $-maVar

section .text
_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, maVar
    mov rdx, longueur
    syscall
    jmp _quitter

_quitter:
    mov rax, 60
    mov rdi, 0
    syscall
```
Assemblez puis executez...

Bim tout s'affiche et sans erreurs :partying_face: :sunglasses:

Voilà nous venons de faire notre premier code en assembleur, le fameux `Hello Word`

A present, vous etes tellement fière que vous décidez de montrer votre programme à vos amis. Pour éviter d'ouvrir votre editeur de code, tapez afin de désassembler votre code:

```bash
objdump -d nomFic
```
mais là, vous ne reconnaissez pas l'affichage

```asm
0000000000401000 <_start>:
  401000:	b8 01 00 00 00       	mov    $0x1,%eax
  401005:	bf 01 00 00 00       	mov    $0x1,%edi
  40100a:	48 be 00 20 40 00 00 	movabs $0x402000,%rsi
  401011:	00 00 00 
  401014:	ba 0d 00 00 00       	mov    $0xd,%edx
  401019:	0f 05                	syscall 
  40101b:	eb 00                	jmp    40101d <_quitter>

000000000040101d <_quitter>:
  40101d:	b8 3c 00 00 00       	mov    $0x3c,%eax
  401022:	bf 00 00 00 00       	mov    $0x0,%edi
  401027:	0f 05                	syscall 
```
Normal, comme dit au debut, il existe deux syntaxes la `AT&T` et la `Intel`. Nous avons developpé en `Intel` et là nous affichons en `AT&T`... :confused:
Pour afficher en `Intel` faites:

```bash
objdump -d -M intel nomFic
```
et là nickel :sunglasses:

```asm
0000000000401000 <_start>:
  401000:	b8 01 00 00 00       	mov    eax,0x1
  401005:	bf 01 00 00 00       	mov    edi,0x1
  40100a:	48 be 00 20 40 00 00 	movabs rsi,0x402000
  401011:	00 00 00 
  401014:	ba 0d 00 00 00       	mov    edx,0xd
  401019:	0f 05                	syscall 
  40101b:	eb 00                	jmp    40101d <_quitter>

000000000040101d <_quitter>:
  40101d:	b8 3c 00 00 00       	mov    eax,0x3c
  401022:	bf 00 00 00 00       	mov    edi,0x0
  401027:	0f 05                	syscall 
```
---

## Details

Après avoir codé un petit programme simpliste, voyons quelques notions qui paraissent importante. Tout d'abord les instructions `mov`, `jmp` et `syscall` sont appelés des mnémoniques.

De plus, l'affichage retourné par le désassemblage admet des differences avec notre code. Nous avons davantage de détails comme l'adresse de chaque instruction et la valeur de cette derniere en hexadecimal. Le mnémonique `syscall` correspond en hexadecimal à `07 05`, cad en binaire `0000 0111 0000 0101`.

L'argument de l'instruction `jmp` est modifié par l'adresse de l'étiquette passé en argument.
