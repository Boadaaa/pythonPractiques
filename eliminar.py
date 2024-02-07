import os
import hashlib
import logging
import sys

# Constantes
BLOCK_SIZE = 65536
LOG_FILE = 'dupli.log'

def calcular_hash(file_path, block_size=BLOCK_SIZE):
    """Calcula el hash SHA256 de un archivo."""
    hasher = hashlib.sha256()
    try:
        with open(file_path, 'rb') as f:
            for block in iter(lambda: f.read(block_size), b''):
                hasher.update(block)
    except Exception as e:
        logging.error(f'Error al abrir {file_path}: {str(e)}')
    return hasher.hexdigest()

def encontrar_duplicados(directorio):
    """Encuentra archivos duplicados en un directorio."""
    archivos_hash = {}


    for root, dirs, files in os.walk(directorio):
        for filename in files:
            file_path = os.path.join(root, filename)

            file_hash = calcular_hash(file_path)
            print("File hash: "+file_hash)
            print("File name: "+file_path)

            if file_hash in archivos_hash:
                print("File repeated: "+file_path)
                archivos_hash[file_hash].append(file_path)
            else:
                if file_hash not in archivos_hash:
                    archivos_hash[file_hash]=[file_path]

    return  archivos_hash

def eliminar_dupli(archivos_hash):
    """Elimina los archivos duplicados y registra la actividad en un archivo de registro."""
    

    logging.info('Archivos duplicados encontrados:')
    
    # Nuevo diccionario para almacenar rutas de archivos con el mismo hash
    
    """ for file_hash, file_paths in archivos_hash.items():
        # Mantén el primer archivo y elimina los duplicados
        keep_file = file_paths[0]
        logging.info(f'Archivo original mantenido: {keep_file}')
 """
    

    
    logging.info('Proceso de eliminación de duplicados completado.')

    # Imprime el diccionario thisdict
    
if __name__ == "_main_":
    logging.basicConfig(filename=LOG_FILE, level=logging.INFO, format='%(asctime)s %(message)s')

    directorio_a_limpiar = input("Introduce la ruta del directorio a limpiar: ")

    if not directorio_a_limpiar:
        logging.error("La ruta del directorio no puede estar vacía.")
        sys.exit(1)

    if not os.path.exists(directorio_a_limpiar):
        logging.error(f"El directorio {directorio_a_limpiar} no existe.")
        sys.exit(1)

    archivos_hash = encontrar_duplicados(directorio_a_limpiar)
    print("Archivos hash")
    for key,value in archivos_hash.items():
        print(key,value)

    


    # eliminar_dupli(archivos_duplicados, archivos_hash)