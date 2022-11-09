# Les données à analyser

Nous vous proposons différents types de données qui vous permettrons d'obtenir les résultats attendus : 

- des données réelles issues du détecteur, enregistrées lors de collision proton-proton, qui contiennt les muons à analyser. Ces données sont organisées en [184 "runs"](run.list) (un run désignant une période de prise de données où les conditions expérimentales sont à peu près stables)
- des données issues d'un programme de simulation détaillée, qui reproduit, entre autres choses, l'état du détecteur au cours du temps (pour la période considérée ici)
- des données annexes nécessaires notamment à la normalisation

Lors du dévelopement de vos notebooks, vous pouvez facilement télécharger un petit jeu de données (typiquement un run) au début de votre notebook en utilisant une commande du type : 

```shell
#!curl 'https://cernbox.cern.ch/remote.php/dav/public-files/JIjQaAYEQnmRDkX/291694/AnalysisResults.root' > run291694.data.root
```

A terme cependant, vous aurez besoin de passer sur l'ensemble des données que nous vous fournissons pour ce projet, et pour cela il est plus judicieux de les télécharger avant de lancer un notebook.

Nous vous proposons à cette fin un script shell d'exemple qui télécharge les données réelles (à vous de l'adapter, si nécessaire, notamment pour les données simulées). Par défaut le script récupère les données dans le répertoire `/data`, car il suppose que la méthode [multipass](multipass.md) d'installation a été utilisé. 

```shell
./copy-data-locally.sh run.list 
```

Le fichier `run.list` est un fichier texte qui contient la liste des numéros de runs (séparés par des virgules) à télécharger.

Dans un premier temps vous pouvez commencer par télécharger quelques runs seulement.

A noter :

- le run 292397 est le plus gros mais est intéressant car il correspond en gros à la luminosité intégrée de l'analyse présentée dans le [papier d'Alice que nous vous fournissons comme référence
- pour l'ensemble des 187 runs le transfert va prendre un certain temps, car il y a 25 Go à récupérer...

