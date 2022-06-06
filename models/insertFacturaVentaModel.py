from config.database import db
cursor = db.cursor()

def insert_factura_venta(user,id_producto,valor_unitario,cantidad,subtotal):
    try:
        cursor.execute("insert into facturas_ventas(id_cliente,id_producto,valor_unitario, cantidad, valor_total, id_empleado, id_modo_pago) values(%s,%s,%s,%s,%s,%s,%s)", (
            user,
            id_producto,
            valor_unitario,
            cantidad,
            subtotal,
            user,
            user
        ))
        db.commit()
    except:
        print("Error ocurred in model insert_factura_compra")