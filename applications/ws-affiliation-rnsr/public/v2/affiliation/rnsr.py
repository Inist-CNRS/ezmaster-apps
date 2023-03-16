#!/usr/bin/env python3
import fasttext
import json
import re
import sys
import pickle


# del fasttext's logs
fasttext.FastText.eprint = lambda x: None


# Charging models
dico_unite_pkl=open("./v2/affiliation/models/dict-code-unite.pkl","rb")
dico_unite=pickle.load(dico_unite_pkl)

modelDomain = fasttext.load_model("./v2/affiliation/models/model-domains_rnsr.ftz")
modelsDX = []
for i in range(11):
    modelsDX.append(fasttext.load_model("./v2/affiliation/models/model-%s_rnsr.ftz"%(i+1)))


# Normalize 
def normalizeText(text):
    text = text.lower()
    text = re.sub("é","e",text)
    text = re.sub("è","e",text)
    text = re.sub("ê","e",text)
    text = re.sub("à","a",text)
    text = re.sub("ô","o",text)
    text = re.sub("û","u",text)
    text = re.sub("î","i",text)
    text = re.sub("ù","u",text)
    text = re.sub("ç","c",text)
    text = re.sub(r"[^a-zA-Z0-9]", " ", text)
    text = re.sub(r"\s+", " ", text)
    text = re.sub("universite","univ",text)
    text = re.sub("university","univ",text)
    text = re.sub("centre","ctr",text)
    text = re.sub("center","ctr",text)
    sentance = []
    for word in text.split():
        if word not in ['france',"franc","fr"]:
            sentance.append(word)
    text = " ".join(sentance)
    return text

# Find a unit code in an affiliation
def findCodeU(text):
    text = re.sub("\n","",text)

    c=re.findall(r'u[amsrp]+ ?[0-9]+',text)
    cd=list(set(c))

    rnsrFinded= False
    rnsr = "n/a"
    for code in cd:
        # normalize
        code=code.lower()
        code=code.replace(' ','')
        code=code.replace('-','')

        try:
            rnsr2 = dico_unite[code]
            rnsr = rnsr2
            rnsrFinded = True
            break  
        except KeyError:
            continue

    return (rnsr,rnsrFinded)

# WS
for line in sys.stdin:
    data = json.loads(line)
    affiliation = normalizeText(data["value"])

    # Find code U.
    rnsr, rnsrFinded = findCodeU(affiliation)
    if rnsrFinded :
        data["value"]=rnsr
        sys.stdout.write(json.dumps(data))
        sys.stdout.write("\n")
    
    # Else, use neuronal network
    else:
        #predict domain
        predictionDomain = modelDomain.predict(affiliation)
        domain = predictionDomain[0][0]
        domain = re.sub("__label__","",domain)
        predictionRnsr = "n/a"

        #predict rnsr knowing domain
        for i in range(11):
            if i < 9:
                testModelDx = "D0%s" %(i+1)
            else:
                testModelDx = "D%s" %(i+1)
            if domain == testModelDx :
                predictionRnsr = modelsDX[i].predict(affiliation)
        rnsr, proba = re.sub("__label__","",predictionRnsr[0][0]),predictionRnsr[1][0]

        #threshold = 0.41
        if proba < 0.41 :
            data["value"]="n/a"
        else:
            data["value"]=rnsr

        sys.stdout.write(json.dumps(data))
        sys.stdout.write("\n")
