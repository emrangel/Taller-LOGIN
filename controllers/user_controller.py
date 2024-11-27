from flask import Blueprint, flash, redirect, render_template, request, url_for
from flask_login import login_user, logout_user
# from models.cuidador import Cuidador
# from models.perro import Perro
from models.usuario import Usuario

user_blueprint = Blueprint('users', __name__, url_prefix='/users')

@user_blueprint.route('/')
# def retornar_perros_Cuidador():
#     return Perro.query.filter(Perro.peso<3)
def index():
    return render_template("users/index.html")

def dar_usuario(username, password):
    return Usuario.query.filter_by(alias = username, contrasena = password)