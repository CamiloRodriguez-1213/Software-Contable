from flask import json,request,make_response,redirect,url_for
def cookiesProduct(id):   
    valor = json.loads(id)
    resp = make_response(redirect(url_for('index')))
    datos = []
    datos = json.loads(request.cookies.get('carrito'))
    try:
        for h in range(0, 2):
            if datos[h]['id_producto'] == valor:
                val = True
                n = h
        if val == True:
            del datos[n]
        resp.set_cookie('carrito',json.dumps(datos))
        return resp
    except:
        resp.set_cookie('carrito',json.dumps(datos))
        return resp
        
    
