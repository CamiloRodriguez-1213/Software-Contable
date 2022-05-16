from flask import Flask, redirect,render_template,url_for,request,session,jsonify,make_response,json
from controllers.verifyLoginController import verifyLogin
from controllers import loginController,stockProductsController

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


	
app.run(debug=True)