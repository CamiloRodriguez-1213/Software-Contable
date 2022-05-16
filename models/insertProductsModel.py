from config.database import db
cursor = db.cursor()

def insert_productos(codigo_producto, nombre, precio_venta, id_categoria, existencia, precio_compra):
    try:
        cursor.execute("insert into productos(codigo_producto, nombre, precio_venta, id_categoria, existencia, precio_compra) values(%s,%s,%s,%s,%s,%s)", (
            codigo_producto, 
            nombre, 
            precio_venta, 
            id_categoria,
            existencia,
            precio_compra
        ))
        db.commit()
    except:
        print("Error ocurred in model insert_product")

