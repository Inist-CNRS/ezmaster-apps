#!/usr/bin/env python3

import sys
import json
import re
from flair.models import SequenceTagger
from flair.data import Sentence
from unidecode import unidecode  
import logging

logging.getLogger('flair').handlers[0].stream = sys.stderr

# def data_normalization(sentence):
#     cpy_sentence = sentence.lower()
#     return cpy_sentence
tagger = SequenceTagger.load("best-model_4.pt")

for line in sys.stdin:
    data = json.loads(line)
    text=data['value']
    PL = []
    TNQ = []
    SNAT = []
    OA = []
    SSO = []
    EB = []
    ET = []
    NRA = []
    CST = []
    GAL = []
    AST = []
    ST = []
    AS = []
    SN = []
    XPL = []
    SR = []
    # sent = data_normalization(text)
    sent = text.split(".")
    sentences = [Sentence(sent[i]+".") for i in range(len(sent))]
    tagger.predict(sentences)
    for sentence in sentences:            
        for entity in sentence.get_spans('ner'):
            if (entity.labels[0].value == "PL"): 
                if entity.text not in PL:
                    PL.append(entity.text)
            if (entity.labels[0].value == "TNQ"):
                if entity.text not in TNQ:
                    TNQ.append(entity.text)
            if (entity.labels[0].value == "SNAT"):
                if entity.text not in SNAT:
                    SNAT.append(entity.text)
            if (entity.labels[0].value == "OA"):
                if entity.text not in OA:
                    OA.append(entity.text)
            if (entity.labels[0].value == "SSO"):
                if entity.text not in SSO:
                    SSO.append(entity.text)
            if (entity.labels[0].value == "EB"):
                if entity.text not in EB:
                    EB.append(entity.text)
            if (entity.labels[0].value == "ET"):
                if entity.text not in ET:
                    ET.append(entity.text)
            if (entity.labels[0].value == "NRA"):
                if entity.text not in NRA:
                    NRA.append(entity.text)
            if (entity.labels[0].value == "CST"):
                if entity.text not in CST:
                    CST.append(entity.text)
            if (entity.labels[0].value == "GAL"):
                if entity.text not in GAL:
                    GAL.append(entity.text)
            if (entity.labels[0].value == "AST"):
                if entity.text not in AST:
                    AST.append(entity.text)
            if (entity.labels[0].value == "ST"):
                if entity.text not in ST:
                    ST.append(entity.text)
            if (entity.labels[0].value == "AS"):
                if entity.text not in AS:
                    AS.append(entity.text)
            if (entity.labels[0].value == "SN"):
                if entity.text not in SN:
                    SN.append(entity.text)
            if (entity.labels[0].value == "XPL"):
                if entity.text not in XPL:
                    XPL.append(entity.text)
            if (entity.labels[0].value == "SR"):
                if entity.text not in SR:
                    SR.append(entity.text)
                    

    
    returnDic = {unidecode('Planète'):PL,unidecode('Trou noirs, quasars et apparentés'):TNQ,'Satellite naturel':SNAT,'Objets artificiels':OA,unidecode('Système solaire') :SSO,unidecode('Étoiles binaires (et pulsars)'):EB,unidecode('Étoiles'):ET,unidecode('Nébuleuse et région apparentés'):NRA,'Constellations':CST,'Galaxies et amas de galaxie':GAL,unidecode('Astèroïdes'):AST,unidecode('Satue hypotétique'):ST,'amas stellaires':AS,'supernovas':SN,unidecode('exoplanètes'):XPL,'sursaut radio, source radio, autres sursauts':SR}
    # ajouter unidecode
    data['value'] = returnDic
    sys.stdout.write(json.dumps(data))
    sys.stdout.write('\n')