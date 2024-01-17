import os
import hashlib
import logging

def calcular_hash(file_path, block_size=65536):
    hasher = hashlib.sha256()
    if os.path.isfile(file_path):
        with open(file_path, 'rb') as f:
            for block in iter(lambda: f.read(block_size), b''):
                hasher.update(block)
    elif os.path.isdir(file_path):
        # Si es un directorio, simplemente utiliza el nombre del directorio para el hash
        hasher.update(file_path.encode('utf-8'))
    return hasher.hexdigest()

def eliminar_duplicados(directorio):
    archivos_info = []
    archivos_eliminados = []

    for root, dirs, files in os.walk(directorio):
        for filename in files + dirs:
            file_path = os.path.join(root, filename)

            file_hash = calcular_hash(file_path)

            if any(file_hash == info[0] for info in archivos_info):
                logging.info(f'Duplicado encontrado: {file_path} (igual a {next(info[1] for info in archivos_info if info[0] == file_hash)})')
                try:
                    if os.path.isfile(file_path):
                        os.remove(file_path)
                    elif os.path.isdir(file_path):
                        os.rmdir(file_path)
                    archivos_eliminados.append(file_path)
                except Exception as e:
                    logging.error(f'Error al eliminar {file_path}: {str(e)}')
            else:
                archivos_info.append((file_hash, os.path.abspath(file_path)))
                print(f'Ruta: {os.path.abspath(file_path)} | Hash: {file_hash}')

    logging.info('Archivos/Directorios eliminados:')
    for archivo in archivos_eliminados:
        logging.info(archivo)

if __name__ == "__main__":
    directorio_a_limpiar = input("Introduce la ruta del directorio a limpiar: ")

    if not os.path.exists(directorio_a_limpiar):
        raise FileNotFoundError(f"El directorio {directorio_a_limpiar} no existe.")

    logging.basicConfig(filename='python.log', level=logging.INFO, format='%(asctime)s - %(message)s', datefmt='%Y-%m-%d %H:%M:%S')
    logging.info(f"{os.getenv('USER')} Starting program")
    
    eliminar_duplicados(directorio_a_limpiar)
