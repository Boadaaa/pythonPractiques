import logging
import sys
import os

# Funciones

def prepararDades():
    dades = {}
    dades["nomUsuari"] = sys.argv[1]
    dades["nomComplert"] = sys.argv[2]
    dades["deptartament"] = sys.argv[3]
    for i in range(4, len(sys.argv), 2):
        dades[sys.argv[i]] = sys.argv[i + 1]
    
    return dades

    def crearUsuari(nomUsuari):
        return os.system("useradd -m"+nomUsuari)

def crearDirectory():
    # Implementa la lógica para crear el directorio según tus necesidades
    pass

def guardarDades(dades, fileName):
    with open(fileName, 'w') as f:
        for key, value in dades.items():
            if "--" in key:
                key = key[2:]
            f.write(f'{key[2:].upper()}: {value}\n')

def esDelDepartament(departament):
    pot = False
    currentUser=os.getenv('USER')

    os.path.exists("/etc/usuaris/"+currentUser+".dat"):

    return pot

if __name__ == "_main_":

    """
    python3 usuaris.py nomUsuari nomComplet despartament [opcion]
    opcions: 
        --mail correuElectronic
        --phone numeroTelefon  
        --mobile numeroMobil 
        --posicio carrec

        Exemple:
            python3 usuaris.py jordi "Jordi Masip" "informatica"
    """

    logging.basicConfig(
        filename='/var/log/usuaris.log', level=logging.INFO,
        format='%(asctime)s %(levelname)s %(message)s')
    
    number_of_arguments = len(sys.argv) - 1
    if number_of_arguments < 3:
        print("USAGE: python usuaris.py nomUsuaris nomComplet departament")
        logging.warning(f'{os.getenv("USER")} USAGE: {str(sys.argv)}')
        sys.exit(1)

    dades = prepararDades()
    fileName = f"/etc/usuaris/{dades['nomUsuari']}.dat"
    guardarDades(dades, fileName)
    potCrear=esDelDepartament (dades["departament"])
    ok = crearUsuari(dades["nomUsuari"])
    crearDirectory()