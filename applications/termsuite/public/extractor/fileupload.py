
# Chunk Generator
import plac
from extractor.sender import sender, logger
import os 
'''

 python3 fileupload.py  /home/schneist/app/ezts/test/data/results.tsv.gz --url https://webhook.site/e3175181-5d80-4bb3-8207-6103f51a8f54

'''

@plac.annotations(
    
    file_upload=("file", "positional", None, str),
    url=(
        "url were to send the result ",
        "option",
        "url_upload",
        str,
    ),
    
)
def main(
    file_upload,
    url
):

    my_upload = sender(file_upload, url)  # init of a sender
    sender_bin = False  # send in binary mode or not
    
    if sender_bin:
       code = my_upload.sender_post_bin()
    else:    
       code = my_upload.sender_post()
     
    # delete the file after upload 
    
    if code:
        logger.info("OK:File uploaded successfully ! ")
        if os.path.isfile(file_upload):
            f  = f"{file_upload}"
            os.remove(f)
            logger.info("OK:File deleted afeter uploaded ! ")
        return (0) 
    else:
        logger.info(" Please try Upload again ! ")
        return(1)
    
  
if  __name__ == "__main__":
     
     plac.call(main)     
     exit()