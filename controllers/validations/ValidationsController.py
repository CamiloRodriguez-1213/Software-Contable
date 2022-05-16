from flask import flash
def number(campo):
    try:
        return int(campo)
    except:
        if campo != '':
            flash('Solo se permiten numeros','wrong')
        return 0
    
