from flask import flash
from models import getUserModel
def getUser(idUser):
    try:
        user = getUserModel.userId(idUser)
        return user
    except:
        print("Error in stock products")
