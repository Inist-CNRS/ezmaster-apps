import requests
import os
#from random import randint
#from uuid import uuid4
#import uuid
from extractor import logger 

class sender (object):
            
    def __init__( self, file_upload, url_upload ):
        self.url = url_upload
        self.file = file_upload       

   
    def read_in_chunks(self, file_object, CHUNK_SIZE=65536):
        
        while True:
            data = file_object.read(CHUNK_SIZE)
            if not data:
                break
            yield data      
 
    '''
    upload txt file in binary mode (don't works for zip) 
    '''
    def sender_post_bin(self):
        content_name = str(self.file)
        content_path = os.path.abspath(self.file)
        content_size = os.stat(content_path).st_size 

        f = open(content_path, 'rb')
        index = 0
        offset = 0
        headers = {}
        
        for chunk in self.read_in_chunks(f):
            offset = index + len(chunk)
            headers['Content-Type'] = 'application/octet-stream'
            headers['Content-length'] = str(content_size)
            headers['Content-Range'] = 'bytes %s-%s/%s' % (index, offset, content_size)
            index = offset
            try:
                r = requests.put(self.url, data=chunk, headers=headers)
                logger.info("r: %s, Content-Range: %s" % (r, headers['Content-Range']))
            except Exception as e:
                logger.info (e)
                
        return(True)        
                
    '''
    upload zip file  
    '''
    def sender_post (self):
        
        if os.path.isfile(self.file):
            logger.info(f"OK: File [{self.file}] exist, sending to {self.url} ")
            file_to_upload =  os.path.abspath(self.file)  
        else:
            logger.info(f"ERROR:No File {self.file}")    
            exit()
        
        dfile = open(file_to_upload, "rb")
               
        response = requests.post(self.url, files = {"form_field_name": dfile} , headers = {'User-agent': 'your bot 0.1'})

        if response.ok:
            logger.info("OK:File uploaded successfully ! ")
            logger.info(response.text)
            return(True)
        else:
            logger.info("ERROR : :File uploadedn failed; Please try Upload again ! ")
            logger.info(response.text)
            return(False)
        