from config.database import db
cursor = db.cursor()
def User(username):
    try:
        cursor.execute("SELECT id_empleado,nombre,apellido,identificacion,celular,correo,direccion,username,password,descripcion FROM empleados,login,cargos WHERE login.username = '"+username+"'")
        myresult = cursor.fetchone()
        return myresult
    except:
        print("Error occured in getUserModel")
def userId(idUser):
    try:
        cursor.execute("SELECT * FROM clientes WHERE identificacion = '"+idUser+"'")
        myresult = cursor.fetchone()
        return myresult
    except:
        print("Error occured in getUserModel")
