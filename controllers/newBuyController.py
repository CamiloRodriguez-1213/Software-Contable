from models import insertFacturaVentaModel
from flask import session
def newBuy(id_producto,codigo_producto,nombre,existencia,precio_unitario,cantidad,subtotal,total):
    data = []
    user = session['token']
    for i in range(0,len(id_producto)):
        insertFacturaVentaModel.insert_factura_venta(user,id_producto[i],precio_unitario[i],cantidad[i],subtotal[i])
        data.append({
            'id_producto': id_producto[i],
            'codigo_producto': codigo_producto[i],
            'nombre': nombre[i],
            'precio_venta': precio_unitario[i],
            'cantidad': cantidad[i],
            'subtotal': subtotal[i],
        })
    data.append({
        'total': total[0],
    })
    return data