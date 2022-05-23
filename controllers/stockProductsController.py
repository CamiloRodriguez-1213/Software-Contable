from flask import flash
from models import getCountProductsModel
def stockProducts(buscarValor):
    try:
        busqueda = buscarValor
        if not buscarValor=='':
            datos = getCountProductsModel.getAllProductsSearch(busqueda)
        data = []
        
        for fila in datos:
            print(fila)
            data.append({
                'id_producto': fila[0],
                'codigo_producto': fila[1],
                'nombre': fila[2],
                'precio_venta': fila[3],
                'existencia': fila[5],
            })
        
        return data
    except:
        print("Error in stock products")
