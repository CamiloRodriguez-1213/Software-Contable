from webbrowser import get
from models import getProductsModel

def ControllerGetProductsWithCodigo(codigo):
    return getProductsModel.GetProductWithCodigo(codigo=codigo)

def ControllerGetProducts():
    return getProductsModel.GetInventario()