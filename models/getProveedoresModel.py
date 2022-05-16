from config.database import db
from flask import flash
cursor = db.cursor()

def Proveedores():
    try:
        cursor.execute("SELECT * FROM proveedores")
        myresult = cursor.fetchall()
        return myresult
    except:
        print("Error occured in getPorveedores")
        
def ProveedorWithId(id_proveedor):
    try:
        cursor.execute("SELECT * FROM proveedores WHERE id_proveedores = %s ",(
            id_proveedor,
        ))
        myresult = cursor.fetchone()
        return myresult
    except:
        print("Error occured in getProveedor")