import sys
import logging
import os

if __name__ == "__main__":
        logging.basicConfig(filename='python.log',level=logging.DEBUG,
                            format='%(asctime)s %(message)s')
        
        logging.info(f"{os.getenv('USER')} Starting program")