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
@app.route("/", methods=["GET", "POST"])
def index():
    if verifyLogin():
        return render_template("index.html")
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
        #if request.method=='POST':
        #    return render_template("views/inventory/inventory.html")
        print(session.get('rol'))
        return render_template("views/inventory/index.html")
    else:
        return render_template("views/auth/login.html")
    
@app.route("/crear-producto", methods=["GET", "POST"])
def CretePorduct():
    if verifyLogin():
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
            categoria = 1
            if id == '':
                categoria = ValidationsController.number(request.form['categoria'])
            if not CreateProductController.ValidationsCreate(id, codigo, nombre, categoria, precio_venta, existencia, proveedor, cantidad_compra, valor_unitario, descuento, impuesto):
                return render_template("views/inventory/products/create.html", db_categorias = db_categorias, db_proveedores = db_proveedores, id = id, cod_product = codigo, nombre = nombre, categoria=categoria, precio_venta = precio_venta, existencia = existencia, proveedor = proveedor, cantidad_compra = cantidad_compra, valor_unitario = valor_unitario, descuento = descuento, impuesto = impuesto)    
            return render_template("views/inventory/products/create.html", db_categorias = db_categorias, db_proveedores = db_proveedores, id='')
        return render_template("views/inventory/products/create.html", db_categorias = db_categorias, db_proveedores = db_proveedores, id='')
    else:
        return render_template("views/auth/login.html")
    
@app.route("/producto-codigo", methods=["POST"])
def CodPorduct():
    if verifyLogin():
        codigo = ValidationsController.number(request.form['codigo'])
        producto = GetProductosController.ControllerGetProductsWithCodigo(codigo)
        db_categorias = GetCategoriasController.ControllerGetCategorias()
        return jsonify(producto)
    else:
        return render_template("views/auth/login.html")
        

app.run(debug=True)