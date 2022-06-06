from flask import Flask, flash, redirect,render_template,url_for,request,session,jsonify,json,make_response
from controllers.verifyLoginController import verifyLogin
from controllers.validations import ValidationsController
from controllers.consult import GetCategoriasController, GetProveedoresController, GetProductosController
from controllers import loginController,stockProductsController,CreateProductController,loginController,setCookieProductsController
from models.DeleteProductModel import deleteProduct

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
            response = stockProductsController.stockProducts(query)
            if response:
                setCookie = setCookieProductsController.setCookieProduct(response=response)
                return setCookie
            else:
                flash('El producto no está registrado','error')
                return redirect(url_for('index'))
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
def CreatePorduct():
    if verifyLogin():
        if session.get('rol') == 'administrador':
            db_categorias = GetCategoriasController.ControllerGetCategorias()
            db_proveedores = GetProveedoresController.ControllerGetProveedores()
            if request.method=='POST':
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
                categoria = ValidationsController.number(request.form['categoria'])
                if not CreateProductController.ValidationsCreate(id, codigo, nombre, categoria, precio_venta, existencia, proveedor, cantidad_compra, valor_unitario, descuento, impuesto):
                    return render_template("views/inventory/products/create.html", db_categorias = db_categorias, db_proveedores = db_proveedores, id = id, cod_product = codigo, nombre = nombre, categoria=categoria, precio_venta = precio_venta, existencia = existencia, proveedor = proveedor, cantidad_compra = cantidad_compra, valor_unitario = valor_unitario, descuento = descuento, impuesto = impuesto)    
                return redirect(url_for('CreatePorduct'))
            return render_template("views/inventory/products/create.html", db_categorias = db_categorias, db_proveedores = db_proveedores)
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
    
@app.route("/newBuy", methods=["GET", "POST"])
def newBuy():
    if verifyLogin():
        id_producto = request.form.getlist('id')
        codigo_producto = request.form.getlist('codigo')
        nombre = request.form.getlist('nombre')
        existencia = request.form.getlist('existencia')
        precio_venta = request.form.getlist('valor')
        cantidad = request.form.getlist('cantidad')
        subtotal = request.form.getlist('subtotal')
        total = request.form.getlist('total')
        
        data = []
        for i in range(0,len(id_producto)):
            data.append({
                'id_producto': id_producto[i],
                'codigo_producto': codigo_producto[i],
                'nombre': nombre[i],
                'precio_venta': precio_venta[i],
                'cantidad': cantidad[i],
                'subtotal': subtotal[i],
            })
        data.append({
            'total': total[0],
        })
        return jsonify(data)
    else:
        return render_template("views/auth/login.html")
    
@app.route("/delete/product/<id>", methods=["GET"])
def delete_product(id):
    if verifyLogin():
        if session.get('rol') == 'administrador':
            deleteProduct(id=id)
            return redirect(url_for('inventory'))
        else:
            return render_template("index.html")
    else:
        return render_template("views/auth/login.html")

@app.route("/delete_cookie")
def delete_cookie():
    resp = make_response(redirect(url_for('index')))
    resp.delete_cookie("subtotal")
    resp.delete_cookie("carrito")
    return resp
app.run(debug=True)