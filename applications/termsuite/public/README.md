
### usage
 exemple  qui enchaîne les scripts bash (en se communicant des données) pour parser un fichier json, le sauvegarder sur disque, compter le nombre de ligne, et envoyer le résultat sur un webhook 


```bash

cat input.json |ezs ./extract.ini|jq .
ezs ./extract.ini <  extract.json | jq .

 ```

