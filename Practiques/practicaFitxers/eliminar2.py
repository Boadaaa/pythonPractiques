from ctypes import _NamedFuncPointer
import os
import hashlib
import logging
import sys

# Constantes
BLOCK_SIZE = 65536
LOG_FILE = '/var/log/dupli.log'

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
    archivos_duplicados = []

    for root, dirs, files in os.walk(directorio):
        for filename in files:
            file_path = os.path.join(root, filename)

            file_hash = calcular_hash(file_path)

            if file_hash in archivos_hash:
                archivos_duplicados.append(file_path)
            else:
                if file_hash not in archivos_hash:
                    archivos_hash[file_hash] = []
                archivos_hash[file_hash].append(file_path)

    return archivos_duplicados, archivos_hash

def eliminar_dupli():
    """Elimina los archivos duplicados y registra la actividad en un archivo de registro."""
    archivos_duplicados, archivos_hash = encontrar_duplicados(directorio_a_limpiar)

    if not archivos_duplicados:
        logging.info("No se encontraron archivos duplicados.")
        return

    logging.info('Archivos duplicados encontrados:')
    
    # Nuevo diccionario para almacenar rutas de archivos con el mismo hash
    thisdict = {}

    for file_hash, file_paths in archivos_hash.items():
        # Mantén el primer archivo y elimina los duplicados
        keep_file = file_paths[0]
        logging.info(f'Archivo original mantenido: {keep_file}')

        # Añade el primer archivo al diccionario thisdict
        if file_hash in thisdict:
            thisdict[file_hash].append(keep_file)
        else:
            thisdict[file_hash] = [keep_file]

        for duplicate_file in file_paths[1:]:
            logging.info(f'Archivo eliminado: {duplicate_file}')
            try:
                # Añade los duplicados al diccionario thisdict
                if file_hash in thisdict:
                    thisdict[file_hash].append(duplicate_file)
                else:
                    thisdict[file_hash] = [duplicate_file]
                
                # Descomenta la siguiente línea para eliminar los archivos duplicados
                # os.remove(duplicate_file)
                pass
            except OSError as e:
                logging.error(f'Error al eliminar {duplicate_file}: {str(e)}')

    logging.info('Proceso de eliminación de duplicados completado.')


if __name__ == "__main__":
    logging.basicConfig(filename=LOG_FILE, level=logging.INFO, format='%(asctime)s - %(message)s', datefmt='%Y-%m-%d %H:%M:%S')

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

