from config.database import db
from flask import flash
cursor = db.cursor()
        
def GetProductWithCodigo(codigo):
    try:
        cursor.execute('SELECT * FROM  productos, categorias WHERE codigo_producto=%s ',(
        codigo,
        ))
        myresult = cursor.fetchone()
        return myresult
    except:
        print("Error occured in GetProductWithCodigo")
    
        
def GetInventario():
    try:
        cursor.execute("SELECT productos.codigo_producto, productos.nombre, categorias.nombre, productos.precio_venta FROM productos, categorias WHERE (productos.id_categoria = categorias.id_categoria) ")
        myresult = cursor.fetchall()
        return myresult
    except:
        print("Error occured in getCategorias")
    