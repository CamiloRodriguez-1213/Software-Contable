from models import getProveedoresModel

def ControllerGetProveedores():
    return getProveedoresModel.Proveedores()

def ControllerGetProveedorWithId(id_proveedor):
    return getProveedoresModel.ProveedorWithId(id_proveedor=id_proveedor)