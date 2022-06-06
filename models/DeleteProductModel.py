from config.database import db
cursor = db.cursor()

def deleteProduct(id):
    try:
        cursor.execute("DELETE FROM productos WHERE id_producto = "+id+" ")
    except:
        print("Error occured in deleteProduct")