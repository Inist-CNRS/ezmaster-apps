
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import subprocess
import os
import glob
import requests
import json
import sys
from extractor import logger, debug_process
from signal import signal, SIGPIPE, SIG_DFL  
signal(SIGPIPE,SIG_DFL)


# do extraction + compress + post send  
def extract_terms (input_corpus, output,  topn , langue, url_to_post=""):

    JAR="/opt/termsuite-core-3.0.10.jar"
    sender="fileupload.py"
    

    output_file="/tmp/"+output+"/corpus_"+output+".tsv" # construct result file path
     
    #if url not define, exit after java.. just for unit test
    dont_send="sleep 0"
    if  url_to_post=="":
        dont_send ="exit 0"
        logger.info("OK:Don't send the result!")
        
    # current script path
    current_path=os.path.dirname(__file__)
    logger.info(f"current_path={current_path}")
    
    # list of commands to execute in a shell batch subprocess
    cmd = [
        [f"java -Xms16g -Xmx48g -cp {JAR} fr.univnantes.termsuite.tools.TerminologyExtractorCLI -c {input_corpus} --tsv {output_file} -l {langue} -t /opt/treetagger --post-filter-top-n={topn} --post-filter-property=spec"],
        [f'{dont_send}'], # just for a unit test
        [f"gzip -f {output_file}"],
        #[f"python3 {sender} -r {remote_user} {output_file}.gz"], # send to filesender
        [f"python3 {current_path}/{sender} {output_file}.gz --url {url_to_post}"],
        [f"rm -rf /tmp/{output}"]
    ]
    logger.info(f"OK:{cmd}")
    exitcode=0
    
    # a shell execution in bg mode
    process = subprocess.Popen(f"{encode_cmd(cmd)}", shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    
    # display in case of debug mode 
    if debug_process:    
        with process.stdout:
            log_subprocess(process.stdout)
        exitcode = process.wait() # 0 means success
    
    return(exitcode)
 
 
# Function to Check if the path is specified
def check_if_corpus(path):

    if os.path.exists(path) and not os.path.isfile(path):
  
        # Checking if the directory is empty or not
        if not os.listdir(path):
            logger.info("ERROR:empty directory")
        else:
            return True
    else:
        logger.info("ERROR:the path is not valid or not exist !!")


#log subprocess in debug mode    
def log_subprocess(pipe):
    for line in iter(pipe.readline, b''): # b'\n'-separated lines
        logger.info('OK:got line from subprocess: %r', line)
    
    return    
 
        
#encode message in json         
def json_encode_stdout (message=["ok","0"]):
    
    # key value
    k=[u"message",u"value"]
    
    # get a dict with key adnd message value
    js=[dict(zip(k, row)) for row in [message]]
    #logger.info(f"JS = {js}")
    
    sys.stdout.write((json.dumps(js)))
    sys.stdout.write('\n')
    
    
    
# format line command for subprocess
def encode_cmd  (command_list):

    commands = [ ''.join(cmd) for cmd in command_list]
    return(' && '.join(commands))

 