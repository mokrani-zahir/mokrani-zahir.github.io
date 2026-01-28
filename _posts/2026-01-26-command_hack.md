---
layout: post

title: "Utilisation Avancée du Terminal : Raccourcis et Commandes pour Gagner du Temps"
description: "Je sais que beaucoup d’informaticiens ont du mal à utiliser le terminal. C’est souvent pénible et peu efficace… mais paradoxalement, on l’utilise très souvent.<br/>Je remarque que beaucoup de gens perdent beaucoup de temps à créer ou modifier des commandes simplement parce qu’ils ne connaissent pas les astuces et raccourcis que les pros utilisent.<br/>Pour ma part, j’utilise régulièrement ces raccourcis, que ce soit sur les serveurs des clients ou sur mon propre PC (Debian). Ils permettent de gagner du temps, de travailler avec plus de précision et de rester organisé.<br/>Dans cet article, je vais partager les raccourcis que j’utilise personnellement au quotidien, pour vous aider à devenir plus efficaces dans le terminal.<br/>Alors, êtes-vous prêts ? GO !"
tags: [linux, bash, ubuntu, hack]
---

## Avant d’entrer dans le vif du sujet

Avant tout, il faut comprendre quelques points très importants.
Il existe plusieurs types de terminaux et ils dépendent souvent du système d’exploitation utilisé.
Par exemple, sous Windows, on utilise principalement CMD ou PowerShell.
Sous Linux, on utilise généralement des shells comme Bash, Zsh ou Sh.
Sur d’autres systèmes comme Unix, AIX ou BSD, le terminal et les commandes peuvent être différents, même s’ils restent globalement similaires.
Beaucoup de personnes pensent que Linux et Unix utilisent exactement le même terminal, mais ce n’est pas totalement vrai.
En réalité, quand on parle de “Linux”, on fait souvent référence à GNU/Linux :

* Linux est le noyau (kernel)
* GNU fournit les outils, dont le shell et les commandes du terminal

Par exemple, Android utilise le noyau Linux, mais n’utilise pas le terminal GNU comme sur Debian ou Ubuntu.
Du côté d’Unix, il existe plusieurs distributions, les plus connues étant :
* BSD (FreeBSD, OpenBSD, etc.)
* AIX (d’IBM)

Même si leurs commandes se ressemblent, elles restent différentes de l’environnement DOS/Windows.

## Créer et modifier des commandes rapidement

Ici, nous allons explorer quelques raccourcis et astuces pour manipuler rapidement la ligne de commande, gagner du temps et travailler plus efficacement. Dans la suite de l’article, nous verrons chaque technique en détail.

### Tabulation `⇥`

*** :) *** Je sais que ça paraît connu, mais il y a des gens qui ne connaissent pas l’astuce pour recréer rapidement un nom de fichier bizarre ou très long. Ceux qui ne connaissent pas doivent le retaper entièrement, et on voit leur visage dégoûté : 'Ahh, je vais devoir tout taper… mais qui crée des noms de fichier aussi bizarres ?!' Je pense que c’est fait exprès pour embêter les gens 😅.

Bref, la tabulation : les qui gens ne savent pas où elle se trouve. Voici son symbole (⇥). En général, la touche Tab est située tout à gauche du clavier, au‑dessus de la touche Majuscule (Shift).

Cette astuce permet de compléter automatiquement une commande. Par exemple, si je veux écrire `ffmpeg.exe`, au lieu de taper tout le nom, j’écris simplement `ffm` puis j’appuie sur Tab : le terminal complète la commande tout seul.

Elle est encore plus utilisée pour les noms de fichiers. Il suffit de taper les premières lettres du fichier puis d’appuyer sur Tab, et le terminal complète automatiquement.
Si le nom ne se complète pas entièrement, c’est souvent parce qu’il existe plusieurs fichiers qui commencent par les mêmes lettres : dans ce cas, il faut ajouter une ou deux lettres de plus puis appuyer de nouveau sur Tab.

### Aller au début de la ligne de commande `CTRL` + `a`

Ouups, j’ai oublié d’ajouter ``sudo`` au début de la commande et mon curseur se trouvait à la fin. Ma commande faisait 1 km de longueur. Pas de souci : appuyez sur `CTRL` + `a` et le curseur ira directement au début de la ligne de commande.

### Aller à la fin de la ligne de commande `CTRL` + `e`

Bien, j'ai ajouté mon `sudo` au début. Maintenant, il faut ajouter d'autres paramètres. Il faut aller jusqu'à la fin de la commande : utilisez `CTRL` + `e` et le curseur ira directement à la fin de la ligne de commande.

### Déplacer plus rapidement : au lieu caractère par caractère, déplacer mot par mot ``CTRL`` + ``←`` ou ``CTRL`` + ``→``

Ahh, j’ai fait une erreur sur ce paramètre. Il se trouve au milieu du mot que le curseur doit atteindre (si on utilise juste les touches de direction du clavier, ça prend du temps).
Au lieu de déplacer caractère par caractère, déplacez mot par mot avec ``CTRL`` + ``←`` pour aller à gauche et ``CTRL`` + ``→`` pour aller à droite.

### Ctrl + Z du terminal (revenir en arrière) `CTRL` + `_`

Après avoir ajouté ce paramètre, il n’est plus compatible avec d’autres paramètres. Il faut donc enlever ce paramètre très long. Je vais ramener mon curseur à la fin du paramètre avec l’ancienne astuce 😏 puis je supprime.
Ahh zut, c’est supprimé accidentellement ! Que faire ? Pas de panique : tu sais que dans le terminal, tu peux revenir en arrière comme dans Word. Oui, oui, tu fais seulement ``CTRL`` + ``_``

### supprimer effecement ou supprimer un mot complet ``CTRL`` + ``W``

Ba, avec la touche ``supprimer ←``, ce n’est pas efficace : je effaces souvent accidentellement les autres paramètres.
Ba, fais ``CTRL`` + ``W`` à la fin du mot ou paramètre pour tout supprimer. Comme ça, tu évites de supprimer d’autres choses accidentellement.

### supprimer tous les paramètres après le curseur ``CTRL`` + ``K``

C’est bien, j’ai ajouté tous les paramètres et je supprime le paramètre qui n’est pas compatible. En fait, il faut enlever tous les autres paramètres après ce paramètre.
Bon, je place le curseur sur ce paramètre :) avec l’astuce ``CTRL`` + ``→``. Ensuite, pour supprimer tous les caractères après le curseur, fais ``CTRL`` + ``K``.

### supprimer toute la commande ``CTRL`` + ``e`` et ``CTRL`` + ``U``

En général, on perd un peu de concentration, par exemple à cause d’un collage où tu te dis "ih ih ihhh… comme en fait ça… ah ah", le moment où tu es concentré sur ton PC et tes yeux piquent à cause de l’écran de l’organisation qui ne veut pas s’inverser sur un bon écran, et en plus, on interdit d’utiliser ton PC (en effet, pour la sécurité).

Ensuite, tu fais n’importe quoi si RMS voit cette commande, il va tu considérer comme une colonne IT, donc il faut tout supprimer et recommencer la commande.

Bon bref, j’utilise ``CTRL`` + ``E`` pour aller jusqu’à la fin de la commande, puis je fais ``CTRL`` + ``U`` pour supprimer tous les caractères avant le curseur. Comme mon curseur se trouve à la fin, ça supprime toute la commande.

### Faire une recherche sur les anciennes commandes déjà tapées ``CTRL`` + ``R``

Bon, pour revenir sur les anciennes commandes déjà tapées, on utilise souvent les flèches haut et bas ``↑`` ``↓``. Mais si tu as beaucoup de commandes, ce n’est plus efficace ou ça revient à l’aveugle.

Il y a une astuce : faire une recherche sur les anciennes commandes déjà exécutées. Pour ça, fais ``CTRL`` + ``R`` et le terminal te donnera la main pour entrer le mot que tu cherches.

## Recherche sur resulta d'un command

**Anecdote** : je me souviens très bien, en installant un serveur VoIP, chaque étudiant avait son propre serveur et essayait de se connecter aux serveurs des autres pour tester si la VoIP marchait.
Pour cela, il fallait avoir l’adresse IP LAN sur Linux avec la commande ``ip address``.

Je me souviens qu’un étudiant a tapé la commande ``ip add`` et il a dit :
"Ahh c’est quoi ça ? J’ai autant de cartes réseau, c’est quoi ce bordel ?!"
En fait, ce sont les adresses de VMware (cartes réseau virtuelles), souvent en utilisées pour GNS3. Il a galéré à trouver son adresse privée.

Puis je lui ai dit : attends, ne cherche pas, voici une astuce.
Tu fais : ``ip add | grep 192.``
Il va afficher toutes les lignes qui contiennent 192.. Et comme le routeur était configuré avec des adresses 192.168.3.x, il a tout de suite trouvé la bonne IP.
Il a cliqué sur OK : waaa, c’est efficace 😄

Moi, c’est pire : avec VMware en plus de Docker, mon ip addr, c’est un livre.

---

En fait, vraiment, j’utilise beaucoup ``grep``. L’astuce, tu fais :

``TA COMMAND | grep CE_QUE_TU_CHERCHE``

## Il y a beaucoup de fichiers, c’est dur de lire

Bon, ici tu peux toujours utiliser grep, mais dans un répertoire, c’est mieux d’utiliser la commande ``find``.

``find . -name "*.mkv"`` Par exemple, je récupère tous les fichiers avec l’extension ``.mkv``.
Mais bon, moi j’utilise ça, je connais des gens qui utilisent directement grep — ça reste une préférence.

## Bon, MERCI de lire l’article

Si tu veux plus d’astuces, j’ai une formation avec un prix symbolique de 1000 $ seulement :/
Non, je rigole 😄. Il y a d’autres astuces un peu plus poussées, mais ce n’est pas avec le terminal par défaut. Moi, j’utilise des paquets pour mieux visualiser l’architecture des répertoires, etc.
Mais c’est un peu plus avancé et c’est un outil, donc je pense que ce n’est pas intéressant pour le moment.