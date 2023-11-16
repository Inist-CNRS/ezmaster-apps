
# WS Termsuite Extraction Core

## usage  

Collecter un corpus, extraire des termes et envoyer le résultat sur un webhook   

Choisissez votre propre webhook sur https://webhook.site/
exemple = https://webhook.site/5131def3-4cc1-4f51-850b-cd6471c64b89

## TEST   

### EN LOCAL  

#### execution sans WS
```
cd public/
EZS_CONCURRENCY=1  ezs -p url="https://webhook.site/b08a3c41-8c8b-4de6-9922-d265092f0e47" -p topn=10 v1/en/extract.ini   < ../../test/data/22_txt_en.zip
```
#### appel WS - demon EZS :  http://localhost:31976/v1/$lg/extract
Lancement d'un serveur EZ
```
ezs -d  . &  
cd public/
```
--- en 
```
curl -v --data-binary @"../../test/data/22_txt_en.zip" --proxy "" -X POST  "http://localhost:31976/v1/en/extract?topn=100&url=https%3A%2F%2Fwebhook.site%2F5131def3-4cc1-4f51-850b-cd6471c64b89" | jq .  
``` 

``` 
ezts/test/ws$ ./ws_extraction_test.sh en 22_txt_en.zip  local  
``` 

---fr 
```  
curl -v --data-binary @"../../test/data/85_txt_fr.zip" --proxy "" -X POST  "http://localhost:31976/v1/fr/extract?topn=100&url=https%3A%2F%2Fwebhook.site%2F5131def3-4cc1-4f51-850b-cd6471c64b89" | jq .  
```  

```  
ezts/test/ws$ ./ws_extraction_test.sh fr 85_txt_fr.zip  local
```  

### PROD  

#### appel sur accel : http://vptermsuite.intra.inist.fr:35268/#/instances/  

```  
curl -v --data-binary @"test/data/22_txt_en.zip"  -H 'Expect:' --proxy "" -X POST  "https://termsuite-1.terminology.inist.fr/v1/en/extract?topn=10&url=100&url=https%3A%2F%2Fwebhook.site%2F5131def3-4cc1-4f51-850b-cd6471c64b89
```

```
ezts/test/ws$ ./ws_extraction_test.sh en 22_txt_en.zip  accel
```



