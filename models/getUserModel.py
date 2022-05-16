from config.database import db
from flask import flash
cursor = db.cursor()


def User(username):
    try:
        cursor.execute("SELECT id_empleado,nombre,apellido,identificacion,celular,correo,direccion,username,password,descripcion FROM empleados,login,cargos WHERE login.username = '"+username+"'")
        myresult = cursor.fetchone()
        return myresult
    except:
        print("Error occured in getUser")
