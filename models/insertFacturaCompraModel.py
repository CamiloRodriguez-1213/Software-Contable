from config.database import db
cursor = db.cursor()

def insert_factura_compra(id_producto, cantidad, val_unitario, descuento, id_proveedor, impuesto):
    try:
        cursor.execute("insert into facturas_compras(id_codigo_producto, cantidad, val_unitario, descuento, id_proveedor, impuesto) values(%s,%s,%s,%s,%s,%s)", (
            id_producto, 
            cantidad, 
            val_unitario, 
            descuento,
            id_proveedor,
            impuesto
        ))
        db.commit()
    except:
        print("Error ocurred in model insert_factura_compra")