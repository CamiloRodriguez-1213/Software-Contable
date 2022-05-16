from config.database import db
cursor = db.cursor()

def update_producto(id, precio_venta, existencia, precio_compra):
    try:
        cursor.execute("UPDATE productos SET precio_venta = %s, existencia = %s, precio_compra = %s WHERE id_producto = %s", (
            precio_venta,
            existencia,
            precio_compra,
            id
        ))
        db.commit()
    except:
        print("Error ocurred in model update_product")