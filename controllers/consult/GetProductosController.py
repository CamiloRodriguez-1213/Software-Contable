from models import getProductsModel

def ControllerGetProductsWithCodigo(codigo):
    return getProductsModel.GetProductWithCodigo(codigo=codigo)