from config.database import db
from flask import flash
cursor = db.cursor()

def GetCategorias():
    try:
        cursor.execute("SELECT * FROM categorias ")
        myresult = cursor.fetchall()
        return myresult
    except:
        print("Error occured in getCategorias")
        
def GetCategoriasWithId(id_categoria):
    try:
        cursor.execute("SELECT * FROM categorias WHERE id_categoria = %s",(
            id_categoria,
        ))
        myresult = cursor.fetchone()
        return myresult
    except:
        print("Error occured in getCategorias")