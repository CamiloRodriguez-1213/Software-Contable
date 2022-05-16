from flask import flash, session
from controllers.consult import GetCategoriasController
from controllers.consult import GetProveedoresController
from controllers.consult import GetProductosController
from models import insertFacturaCompraModel
from models import insertProductsModel
from models import updateProductsModel

def ValidationsCreate(id, codigo, nombre, categoria, precio_venta, existencia, proveedor, cantidad_compra, valor_unitario, descuento, impuesto):
    session.pop('_flashes', None)
    try:
        if id is '':
            if codigo <= 0:
                flash('codigo invalido','wrong')
                return False
            else:
                if GetProductosController.ControllerGetProductsWithCodigo(codigo) != None:
                    flash('Ya existe un producto con este codigo','wrong')
                    return False
                else:
                    if nombre is '':
                        flash('producto','wrong')
                        return False
                    else: 
                        if categoria is 0:
                            flash('debe seleccionar una categoria','wrong')
                            return False
                        else:
                            if GetCategoriasController.ControllerGetCategoriasWithId(categoria) is None:
                                flash('La categoria no se encuentra registrada','wrong')
                                return False 
        if precio_venta < 0:
            flash('En el precio venta no se permiten numeros negativos','wrong')
            return False
        else:
            if existencia < 0:
                flash('En la existencia no se permiten numeros negativos','wrong')
                return False
            else:
                if proveedor is 0:
                    flash('debe seleccionar un proveedor','wrong')
                    return False
                else:
                    if GetProveedoresController.ControllerGetProveedorWithId(proveedor) is None:
                        flash('El proveedor no se encuentra registrado','wrong')
                        return False
                    else:
                        if cantidad_compra < 0:
                            flash('En la cantidad compra no se permiten numeros negativos','wrong')
                            return False
                        else:
                            if valor_unitario < 0:
                                flash('En el valor unitario no se permiten numeros negativos','wrong')
                                return False
                            else:
                                if cantidad_compra < 1:
                                    flash('En la cantidad no puede ser menor a 1','wrong')
                                    return False
                                else:
                                    if descuento < 0:
                                        flash('En el descuento no se permiten numeros negativos','wrong')
                                        return False
                                    else:
                                        if impuesto < 0:
                                            flash('En el impuesto no se permiten numeros negativos','wrong')
                                            return False
                                        else:
                                            if id is '':
                                                insert_product(codigo, nombre, precio_venta, categoria, valor_unitario, descuento, impuesto, cantidad_compra)
                                            else:
                                                update_product(id, precio_venta, existencia, valor_unitario, descuento, impuesto, cantidad_compra)
                                            insert_factura_compra(id, codigo, cantidad_compra, valor_unitario, descuento, proveedor, impuesto)
                                            flash("producto y factura guardados exitosamente", "good")
                                            return True
                             
    except:
        print("Error occured in controller ValidationsCreateProduct")
        
        
def insert_factura_compra(id_producto, codigo, cantidad, val_unitario, descuento, id_proveedor, impuesto):
    try:
        if id_producto == '':
            consulta = GetProductosController.ControllerGetProductsWithCodigo(codigo)
            id_producto = consulta[0]
        insertFacturaCompraModel.insert_factura_compra(id_producto=id_producto, cantidad=cantidad, val_unitario=val_unitario, descuento=descuento, id_proveedor=id_proveedor, impuesto=impuesto)
    except:
        print("Error ocurred in controller insert_factura_compra")
        
def insert_product(codigo, nombre, precio_venta, categoria, valor_unitario, descuento, impuesto, cantidad_compra):
    try:
        cantidad_total = cantidad_compra
        precio_compra = valor_unitario-descuento+impuesto
        insertProductsModel.insert_productos(codigo_producto=codigo, nombre=nombre, precio_venta=precio_venta, id_categoria=categoria, existencia=cantidad_total, precio_compra=precio_compra)
    except:
        print("Error ocurred in controller insert_product")
        
def update_product(id, precio_venta, existencia, valor_unitario, descuento, impuesto, cantidad_compra):
    try:
        cantidad_total = existencia+cantidad_compra
        precio_compra = valor_unitario-descuento+impuesto
        updateProductsModel.update_producto(id=id, precio_venta=precio_venta, existencia=cantidad_total, precio_compra=precio_compra)
    except:
        print("Error ocurred in controller update_product")