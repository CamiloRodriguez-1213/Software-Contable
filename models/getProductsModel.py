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
        print("TRAER INVENTARIO")
        #SELECT producto.id_producto, producto.codigo_producto, producto.nombre, producto.precio_venta, categoria.nombre, factura_compra.val_unitario  FROM producto, categoria, factura_compra WHERE (producto.id_categoria = categoria.id_categoria AND producto.precio_compra = factura_compra.id_factura_compra)
        #cursor.execute("SELECT * FROM categorias ")
        #myresult = cursor.fetchone()
        #return myresult
    except:
        print("Error occured in getCategorias")
    