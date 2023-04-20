import logging

# if True : trace log in file +  no bakckground process
debug_process= False

if debug_process:
    P=logging.INFO
else:    
    P=logging.WARNING


#FORMAT="%(asctime)s [%(levelname)s] %(message)s"
#logging.basicConfig(format=FORMAT)
logger = logging.getLogger('extraction_application')
logger.setLevel(P)
# create file handler which logs even debug messages
fh = logging.FileHandler("extraction.log")
logger.addHandler(fh)

__all__ = [
    "filesender",
    "extraction",
    "fileupload",
    "sender",
    "logger",
]
       
     



