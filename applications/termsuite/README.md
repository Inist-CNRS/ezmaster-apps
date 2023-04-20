Termsuite-ezsapp  
=================  


#### Webhook de test :   

Site : 

  https://webhook.site/#!/0c9f044b-d279-4eb9-8e99-0d4760c2d002/

endpoint : 

  https://webhook.site/0c9f044b-d279-4eb9-8e99-0d4760c2d002 

  https%3A%2F%2Fwebhook.site%2F0c9f044b-d279-4eb9-8e99-0d4760c2d002 

  %22https%3A%2F%2Fwebhook.site%2F0c9f044b-d279-4eb9-8e99-0d4760c2d002%22
  



## Utilisation en WS Service en local
------------------------------------

* build and run docker application :
```
./run_app.sh
```
* Send request 
```
curl -v --data-binary @"test/data/test.zip" --proxy "" -X POST "http://localhost:31976/v1/en/extract?topn=100&url=%22https%3A%2F%2Fwebhook.site%2F0c9f044b-d279-4eb9-8e99-0d4760c2d002%22"
```
where 
```
	* max terms		  topn=100
	* webhook url		url=https%3A%2F%2Fwebhook.site%2F0c9f044b-d279-4eb9-8e99-0d4760c2d002"
```
Resultat consultable : https://webhook.site/#!/0c9f044b-d279-4eb9-8e99-0d4760c2d002/

## Script extraction hors ezs  
-----------------------------  
Lancement du programme d'extraction en local 

 ```
python3 launch_extraction.py  "/home/schneist/app/ezts/test/data/txt_local" --output "/home/schneist/app/ezts/test/data/results.tsv" --url https://webhook.site/0c9f044b-d279-4eb9-8e99-0d4760c2d002  --topn 50  --lang "en"
```	
Usage :
```	
 launch_extraction.py [-h] [-output_file OUTPUT] [-url_upload URL] [-topn TOPN] [-langue en] corpus

positional arguments:

  corpus                corpus path

options:

   -h, --help            show this help message and exit  
  -output_file OUTPUT, --output OUTPUT  
                        output file  
  -url_upload URL, --url URL  
                      url were to send the result  
  -topn TOPN, --topn TOPN  
                        top nterm to produce  
  -langue en, --lang en  
                        langage corpus [default en]  
```	

## Test  (dev)
--------------
#### Execute all test,  nose + sh
```
./launch_all_test.sh  
```

#### Executer en mode script ezs
```
cd $HOME/app/ezts/termsuite-ezsapp/public

EZS_CONCURRENCY=1  ezs -p url="https://webhook.site/0c9f044b-d279-4eb9-8e99-0d4760c2d002" -p topn=10 v1/en/extract.ini   < ../../test/data/test.zip  

