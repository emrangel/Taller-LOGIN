from flask import Flask, render_template, request, redirect, url_for, session
from flask_login import LoginManager, UserMixin, login_user, login_required, current_user
import controllers.guarderia_controller as guarderia_controller
from controllers.user_controller import dar_usuario
from models.usuario import Usuario
from dotenv import load_dotenv
from db import db
import os

load_dotenv(override=True)

# DB_USERNAME = "root"
# DB_PASSWORD = "Python0011"
# DB_HOST = "localhost"
# DB_PORT = 3306
# DB_NAME = "tablas"


app = Flask(__name__, template_folder = "Views")
# app.config["SQLALCHEMY_DATABASE_URI"] = f"mysql+pymysql://{os.getenv('DB_USERNAME')}:{os.getenv('DB_PASSWORD')}@{os.getenv('DB_HOST')}:{os.getenv('DB_PORT')}/{os.getenv('DB_NAME')}"
# app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
# secret_key = os.urandom(24)

# app = Flask(_name_)
# app.config["SQLALCHEMY_DATABASE_URI"] = "mysql://root:admin123@localhost/tablas"
app.config["SQLALCHEMY_DATABASE_URI"] = "mysql+pymysql://root:Python0011@localhost:3306/tablas"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SECRET_KEY"] = os.urandom(24)

# app.config["SECRET_KEY"] = secret_key
db.init_app(app)

login_manager =  LoginManager(app)

@login_manager.user_loader
def load_user(user_id):
    return Usuario.query.get(user_id).first()
    # for user in guarderia_controller.retornar_usuarios():
    #     if user.id == int(user_id):
    #         return user
    # return None

@app.route('/')
def index():
    return render_template("index.html")

@app.route("/logout")
def logout():
    # Clear the session
    session.clear()
    return redirect("/")

@app.route('/admin')
@login_required
def admin():
    if current_user.es_admin != 1:
       return redirect(url_for("ruta_logueada"))

    perrosLassie = guarderia_controller.retornar_perros_Lassie()
    perrosCuidador = guarderia_controller.retornar_perros_Cuidador()
    modelo = { "TotalLassie": perrosLassie, "perros":  perrosCuidador }
    return render_template("admin.html", datos = modelo)

@app.route('/ruta-logueada')
@login_required
def ruta_logueada():
    return render_template("ruta-logueada.html")

@app.route('/error')
def error():
    return render_template("error.html")

@app.route('/login', methods=["GET", "POST"])
def login():
    if request.method == 'GET':
        return render_template("login.html")
    else:
        username = request.form["username"]
        password = request.form["password"]
        user = Usuario.query.filter_by(alias = username, contrasena = password).first()
        # user = dar_usuario(username, password)
        print(user)
        if user:
            if user.es_admin == 1:
                print(user)
                return redirect(url_for("admin"))
            else:
                return redirect(url_for("ruta_logueada"))
        else:
            return redirect(url_for("error"))

        # for user in guarderia_controller.retornar_usuarios():
        #     if user.alias == username and user.contrasena == password:
        #         print(f"user.alias: {user.alias}, {user.es_admin}" )
        #         login_user(user)
        #         if(user.es_admin == 1):
        #             return redirect(url_for("admin"))
        #         return redirect(url_for("ruta_logueada"))
        #     else:
        #       return redirect(url_for("error"))
        # return render_template("login.html")

if __name__ == '__main__':
    app.run(debug=True)