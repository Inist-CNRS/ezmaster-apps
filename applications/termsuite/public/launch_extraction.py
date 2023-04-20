#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: stephane.schneider@inist.fr
"""
import subprocess
from extractor.extraction import *
import plac
import sys
import validators
#
#   Manage extraction   pipline
#
#   check_data ( to parsed, result )
#       |   
#       V
#       subprocess detached  -->   extract_terms --> send_result --> clean
#       |  
#       V
#  send_http_response OK
#
#  { token: '5gGfHeGTs', corpus: '/tmp/5gGfHeGTs/corpus' }
#  python3 launch_extraction.py   /tmp/5gGfHeGTs/corpus    --output   5gGfHeGTs, 
#
#  python3 launch_extraction.py  "/home/schneist/app/ezts/test/data/txt_local" --output "results" --url https://webhook.site/0c9f044b-d279-4eb9-8e99-0d4760c2d002  --topn 50  --lang "en"
#
#
@plac.annotations (
    
    corpus=("corpus path", "positional", None, str),
    output=("output file", "option","output_file", str),
    topn=("top nterm to produce","option", "topn", int ),
    lang=(
        "langage corpus [default en]",
        "option",
        "langue",
        str,
        ["fr", "en"],
    ),
    url=(
        "url were to send the result ",
        "option",
        "url_upload",
        str,
    ),
)


def main(corpus, output, url, topn , lang="en"):

    # mandory no default param
    exitcode=1
    if corpus and output and url and topn:
     
        logger.info("launcher process")    
        
        # check parameters    
        #if not (validators.url(url)) or (topn < 1):
        #    parser = plac.parser_from(main)
        #    parser.logger.info_help()
        #    exit()
       
        if check_if_corpus(corpus): #check if corpus exist
            
            code = extract_terms( input_corpus=corpus, output=output, topn=topn , langue=lang,  url_to_post=url )
        
            if code == 0 :
                logger.info("OK:Extraction launch !! ")
                exitcode=code
            else:
                logger.info("ERROR: extraction process finished with an error  ")
                
    else:
        logger.info("ERROR:launcher init param errors")          
   
    json_encode_stdout(message=['exit code', str(exitcode)])
    
          
if  __name__ == "__main__":
       
    plac.call(main)     
    exit()
  
    