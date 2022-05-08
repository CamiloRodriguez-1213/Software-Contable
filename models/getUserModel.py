from config.database import db
from flask import flash
cursor = db.cursor()


def User(username):
    try:
        cursor.execute("SELECT id_employe,employee.name,last_name,identification,mobile,email,address,username,login.password,description FROM employee,login,charge WHERE login.username = '"+username+"'")
        myresult = cursor.fetchone()
        return myresult
    except:
        print("Error occured in getUser")
