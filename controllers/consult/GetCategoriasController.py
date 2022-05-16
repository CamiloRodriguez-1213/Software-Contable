from models import getCategoriasModel

def ControllerGetCategorias():
    return getCategoriasModel.GetCategorias()

def ControllerGetCategoriasWithId(id_categoria):
    return getCategoriasModel.GetCategoriasWithId(id_categoria=id_categoria)