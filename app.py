from flask import Flask, redirect,render_template,url_for,request,session,jsonify,make_response,json
from controllers.verifyLoginController import verifyLogin
from controllers import loginController,stockProductsController
from flask import Flask, redirect,render_template,url_for,request,session,jsonify
from controllers.verifyLoginController import verifyLogin
from controllers.validations import ValidationsController
from controllers import loginController
from controllers.consult import GetCategoriasController
from controllers.consult import GetProveedoresController
from controllers.consult import GetProductosController
from controllers import CreateProductController

app = Flask(__name__)
app.secret_key = 'fjifjidfjied5df45df485h48@'
@app.get("/")
def index():
    if verifyLogin():
        try:        
            datos = []
            datos = json.loads(request.cookies.get('carrito'))
            return render_template("index.html",datos=datos)
        except:
            return render_template("index.html")
    else:
        return render_template("views/auth/login.html")
@app.post("/")
def postIndex():
    if verifyLogin():
        if request.method == 'POST':
            query = request.form['search']
            
            datos = []
            response = stockProductsController.stockProducts(query)
            resp = make_response(redirect(url_for('index')))
            valnone = request.cookies.get('carrito')            
            if valnone == None:
                resp.set_cookie('carrito',json.dumps(response))
                resp.set_cookie('subtotal',json.dumps(response[0]['precio_venta']))
            else:
                datos = json.loads(request.cookies.get('carrito'))
                resp.set_cookie('carrito',json.dumps(datos+response))
                
                vart = json.loads(request.cookies.get('subtotal'))
                print(vart)
                
                dt = vart + response[0]['precio_venta']
                resp.set_cookie('subtotal',json.dumps(dt))
            return resp
    else:
        return render_template("views/auth/login.html")
@app.route("/login", methods=["GET", "POST"])
def login():
    if verifyLogin():
        return render_template("index.html")
    else:
        if request.method=='POST':
            username=request.form['username']
            password=request.form['password']
            if loginController.login(username,password):
                return redirect("/")
            return render_template("views/auth/login.html",username=username)
        return render_template("views/auth/login.html")

@app.get("/logout")
def logout():
    session.clear()
    return redirect(url_for('login'))
@app.route("/inventario", methods=["GET", "POST"])
def inventory():
    if verifyLogin():
        if session.get('rol') == 'administrador':
            productos = GetProductosController.ControllerGetProducts()
            return render_template("views/inventory/index.html", productos=productos)
        else:
            return render_template("index.html")
    else:
        return render_template("views/auth/login.html")
    
@app.route("/crear-producto", methods=["GET", "POST"])
def CretePorduct():
    if verifyLogin():
        if session.get('rol') == 'administrador':
            db_categorias = GetCategoriasController.ControllerGetCategorias()
            db_proveedores = GetProveedoresController.ControllerGetProveedores()
            if request.method=='POST':
                session['db_categorias'] = db_categorias
                id = request.form['id']
                codigo = ValidationsController.number(request.form['cod_product'])
                precio_venta = ValidationsController.number(request.form['precio_venta'])
                existencia = ValidationsController.number(request.form['existencia'])
                proveedor = ValidationsController.number(request.form['proveedor'])
                cantidad_compra = ValidationsController.number(request.form['cantidad_compra'])
                valor_unitario = ValidationsController.number(request.form['valor_unitario'])
                descuento = ValidationsController.number(request.form['descuento'])
                impuesto = ValidationsController.number(request.form['impuesto'])
                nombre = request.form['nombre']
                categoria = 0
                if id == '':
                    categoria = ValidationsController.number(request.form['categoria'])
                if not CreateProductController.ValidationsCreate(id, codigo, nombre, categoria, precio_venta, existencia, proveedor, cantidad_compra, valor_unitario, descuento, impuesto):
                    return render_template("views/inventory/products/create.html", db_categorias = db_categorias, db_proveedores = db_proveedores, id = id, cod_product = codigo, nombre = nombre, categoria=categoria, precio_venta = precio_venta, existencia = existencia, proveedor = proveedor, cantidad_compra = cantidad_compra, valor_unitario = valor_unitario, descuento = descuento, impuesto = impuesto)    
                return redirect(url_for('CretePorduct'))
            return render_template("views/inventory/products/create.html", db_categorias = db_categorias, db_proveedores = db_proveedores, id='')
        else:
            return render_template("index.html")
    else:
        return render_template("views/auth/login.html")
    
@app.route("/producto-codigo", methods=["POST"])
def CodPorduct():
    session.pop('_flashes', None)
    if verifyLogin():
        codigo = ValidationsController.number(request.form['codigo'])
        producto = GetProductosController.ControllerGetProductsWithCodigo(codigo)
        return jsonify(producto)
    else:
        return render_template("views/auth/login.html")
    
@app.route("/categorias", methods=["GET"])
def Cat():
    if verifyLogin():
        db_categorias = GetCategoriasController.ControllerGetCategorias()
        return jsonify(db_categorias)
    else:
        return render_template("views/auth/login.html")
        

app.run(debug=True)