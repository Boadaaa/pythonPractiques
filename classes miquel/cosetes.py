from mysql import connector
TABLE = "equip"

def connect():
        HOST = "172.19.0.2"
        USER = "root"
        PASSWORD = "Patata123"
        DATABASE = "equip"

        try:
            return connector.connect(
                HOST= HOST,
                user=USER,
                password=PASSWORD,
                database=DATABASE
            )
        except connector.Error as err:
              return err
        
def insertRow(connexio, equip):
    cursor = connexio.cursor()
    sql=f"INSERT INTO {TABLE} (hostna,e, ip) VALUES ({equip[0]}, {equip[1]})"
    try:
        cursor.execute(sql)
        connexio.commit()
        return cursor.rowcount
    except connector.Error as err:
        return err

def getAll(connexio):
    cursor = connexio.cursor()
    cursor.execute(f"SELECT * FROM {TABLE}")
    result = cursor.fetchall()
    return result

def imprimir(result):
    for equip in result:
        print(f"Hostname: {equip[0]} IP: {equip[1]}")

connexio = connect()
print(connexio)

def updateRow(connexio, equip):
    cursor = connexio.cursor()
    sql=f"UPDATE {TABLE} SET hostname = {equip[0]} WHERE ip = {equip[1]}"
    try:
        cursor.execute(sql)
        connexio.commit()
        return cursor.rowcount
    except connector.Error as err:
        return err

def deleteRow(connexio, ip):
    cursor = connexio.cursor()
    sql=f"DELETE FROM {TABLE} WHERE ip = {ip}"
    try:
        cursor.execute(sql)
        connexio.commit()
        return cursor.rowcount
    except connector.Error as err:
        return err
    
connexio = connect()
print(connexio)
    
result = insertRow (connexio, ["'PC1'", "'172.19.1.15'"])
if result == 1:
    print(f"Insert {result} row(s)")
else:
    print(f"Error: {result}")

result = insertRow (connexio, ["'PC2'", "'172.19.1.150'"])
if result == 1:
    print(f"Insert {result} row(s)")
else:
    print(f"Error: {result}")

result = getAll(connexio)
imprimir(result)

result = updateRow(connexio,"'172.19.1.150'", "'PC20'")
result = getAll(connexio)
imprimir(result)

result = deleteRow(connexio, "'172.19.1.150'")
result = getAll(connexio)
imprimir(result)
close(connexio)