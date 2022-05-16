from flask import flash,session
from models import getUserModel
def login(username,password):
    try:
        if username is '':
            flash('Nombre de usuario','wrong')
        if password is '':
            flash('Contraseña','wrong')
        else:
            if getUserModel.User(username):
                result = getUserModel.User(username)
                if result[7] == username and result[8]== password:
                    print(result)
                    session['token'] = result[0]
                    session['user'] = (result[1]+' '+result[2])
                    session['username'] = result[7]
                    session['rol'] = result[9]
                    
                    return True
            else:
                return False, flash('El usuario '+username+' no está registrado', 'wrong')
    except:
        print("Error occured in signinUser")
        