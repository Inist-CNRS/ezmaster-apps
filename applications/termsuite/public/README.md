
## usage  

Colecte extraction et envoyer le résultat sur le webhook   

## TEST  
#### LOCAL  
```
cd public/  
ezs -d  . &  

cat ../../test/data/22_txt.zip | curl --data-binary @- "http://localhost:31976/v1/en/extract?topn=100&url=https%3A%2F%2Fwebhook.site%2Fa23097f8-2de9-431e-8924-6bb8e4db65e7" | jq .  
OU
curl -v --data-binary @"../../test/data/22_txt.zip" --proxy "" -X POST  "http://localhost:31976/v1/en/extract?topn=100&url=https%3A%2F%2Fwebhook.site%2Fa23097f8-2de9-431e-8924-6bb8e4db65e7" | jq .  
```

#### PROD  
```  
curl -v --data-binary @"test/data/22_txt_en.zip"  -H 'Expect:' --proxy "" -X POST  "https://termsuite-1.terminology.inist.fr/v1/en/extract?topn=10&url=https%3A%2F%2Fterminologydesign-dev.migale.inrae.fr%2Fapi%2Fextract%2Fupload%2F%3Ftask%3Dp0q-ujeaW0yUnkc"  
 ```
#### SCRIPT  
!! Be aware to the URL WS in the script  
```
/app/ezts/test/ws$ ./ws_extraction_test.sh en 22_txt_en.zip  
```
