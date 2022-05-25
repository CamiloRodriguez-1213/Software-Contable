from flask import redirect,json,jsonify,request,make_response,url_for
def setCookieProduct(response):
    datos = []
    resp = make_response(redirect(url_for('index')))
    valnone = request.cookies.get('carrito')   
    envio = True         
    if valnone == None:
        resp.set_cookie('carrito',json.dumps(response))
        return resp
    else:
        datos = json.loads(request.cookies.get('carrito'))
        for h in range(0, len(datos)):
            if datos[h]['id_producto'] == response[0]['id_producto']:
                datos[h]['zcantidad'] = int(datos[h]['zcantidad'] +1)
                resp.set_cookie('carrito',json.dumps(datos))
                envio = False
                return resp
        if envio == True:
            resp.set_cookie('carrito',json.dumps(datos+response))
        return resp
        