from flask import Flask, redirect,render_template,url_for,request,session
from controllers.verifyLoginController import verifyLogin
from controllers import loginController
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
app.run(debug=True)