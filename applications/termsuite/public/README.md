
### usage
 exemple  qui enchaîne les scripts bash (en se communicant des données) pour parser un fichier json, le sauvegarder sur disque, compter le nombre de ligne, et envoyer le résultat sur un webhook 

https://webhook.site/#!/a23097f8-2de9-431e-8924-6bb8e4db65e7/5f76dc15-f4c5-4249-8885-af35f70e61b9/1

```bash

ezs -t  -p topn=100 -p webhook='https://webhook.site/a23097f8-2de9-431e-8924-6bb8e4db65e7' v1/en/extract.ini   < ../../test/data/22_txt.zip|jq .


 ```

