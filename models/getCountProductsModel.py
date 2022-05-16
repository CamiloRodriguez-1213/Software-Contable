from config.database import db
cursor = db.cursor()

def getAllProductsSearch(busqueda):
    cursor.execute("SELECT * FROM productos WHERE codigo_producto = "+busqueda+"")
    myresult = cursor.fetchall()
    return myresult
