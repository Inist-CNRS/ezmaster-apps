termsuite-ezsapp
===============

<br>

## 1. Send the corpus. Can be in many requests  

</br>

```
cat <<EOF | curl --proxy "" -X POST --data-binary @- webservice_url/v1/en/collect
[
    {  "corpus":"corpus1", "value": "Organocatalysis: asymmetric cascade reactions catalysed by chiral secondary amines The utilisation of chiral secondary amines as promoters for asymmetric cascade reactions has been subject of intensive research in asymmetric organocatalysis in the past few years. Key developments in this area are highlighted in this review. As shown, these powerful synthetic methodologies serve as efficient approaches to the construction of complex chiral molecular architectures from simple achiral materials in one-pot transformations under mild conditions with high stereocontrol."},
    { "corpus":"corpus1", "value": "Organocatalysis: asymmetric cascade reactions catalysed by chiral secondary amines The utilisation of chiral secondary amines as promoters for asymmetric cascade reactions has been subject of intensive research in asymmetric organocatalysis in the past few years. Key developments in this area are highlighted in this review. As shown, these powerful synthetic methodologies serve as efficient approaches to the construction of complex chiral molecular architectures from simple achiral materials in one-pot transformations under mild conditions with high stereocontrol."},
    {  "corpus":"corpus1", "value": "Organocatalysis: asymmetric cascade reactions catalysed by chiral secondary amines The utilisation of chiral secondary amines as promoters for asymmetric cascade reactions has been subject of intensive research in asymmetric organocatalysis in the past few years. Key developments in this area are highlighted in this review. As shown, these powerful synthetic methodologies serve as efficient approaches to the construction of complex chiral molecular architectures from simple achiral materials in one-pot transformations under mild conditions with high stereocontrol." },
]
EOF
```

<br>
<br>

## 2. Extract terms   

<br>

```
cat <<EOF | curl --proxy "" -X POST --data-binary @- webservice_url/v1/en/extract
[
   { "id":"1", "value" :"corpus1" }
]
EOF
```
<br>

NB : after the treatment, corpus is deleted
<br>
<br>
## 3. Result
The results are then available in a WebDav that you have defined as follows

WEBDAV_URL= end point url  
WEBDAV_PAS= pass word   
WEBDAV_USER= user name  
