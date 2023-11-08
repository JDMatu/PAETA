#Libreria para crear la clase tipo usuario
from flask_login import UserMixin

class User(UserMixin):
    def __init__(self, id, usuario, contrasena, tipo, estado) -> None:
        self.id = id
        self.usuario = usuario
        self.contrasena = contrasena
        self.tipo = tipo
        self.estado = estado
        
        
class User1(UserMixin):
    def __init__(self, id, nombre, usuario, contrasena, tipo, estado,iDdepartamento) -> None:
        self.id = id
        self.nombre = nombre
        self.usuario = usuario
        self.contrasena = contrasena
        self.tipo = tipo
        self.estado = estado
        self.iDdepartamento = iDdepartamento