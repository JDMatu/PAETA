from flask import render_template
from bd import obtener_conexion
#Libreria de cifrado nativa de python
from hashlib import pbkdf2_hmac 
import hashlib

def buscarUsuariosRegistrados():
    conexion = obtener_conexion()
    usuarios = [] 
    with conexion.cursor() as cursor:   
        cursor.execute("call buscarUsuariosRegistrados()")     
        usuarios = cursor.fetchall()       
    conexion.close()
    return usuarios


def buscarUsuarioXID(id):
    conexion = obtener_conexion()
    usuario = None
    with conexion.cursor() as cursor:        
        cursor.execute("call buscarUsuariosXID(%s);",id)
        usuario = cursor.fetchone()         
    conexion.close()
    return usuario


    
def crearUsuario(nombre, usuario, contraseña, email, tipo, estado, idDepartamento):
    conexion = obtener_conexion()
    with conexion.cursor() as cursor:
        cursor.execute("call crearUsuario('"+nombre+"', '"+usuario+"', '"+cifrarPaeta(contraseña)+"', '"+email+"', '"+tipo+"', '"+estado+"','"+idDepartamento+"')")
    conexion.commit() 
    conexion.close()
    return buscarUsuariosRegistrados()

    
#crearUsuario("Juan", "Juan123", "Juancho123", "Juan@gmail.com", "Admin", "Activo")


def modificarUsuario(id, nombre, usuario, contraseña, email, tipo, estado,idD):
    conexion1 = obtener_conexion()
    conexion2 = obtener_conexion()
    conexion3 = obtener_conexion()
    with conexion1.cursor() as cursor:
        cursor.execute("call modificarUsuario("+str(id)+", '"+nombre+"', '"+usuario+"', '"+cifrarPaeta(contraseña)+"', '"+email+"', '"+tipo+"','"+estado+"','"+idD+"')")
    conexion1.commit() 
    conexion1.close()


    return buscarUsuariosRegistrados()
    
#modificarUsuario(1, "Pedro", "Pedro123", "Pedroncho123", "Pedro@gmail.com", "Administrador", "Activo")
#modificarUsuario(1, "Juan", "Juan123", "Juancho123", "Juan@gmail.com", "Admin", "Activo")


def buscarUsuarioXNombre(nombre):
    conexion = obtener_conexion()
    usuario = None
    with conexion.cursor() as cursor:        
        cursor.execute("call buscarUsuariosXNombre(%s);",nombre)
        usuario = cursor.fetchone()         
    conexion.close()
    return usuario



def buscarUsuariosXUsuario(username):
        conexion = obtener_conexion()
        usuario = None
        with conexion.cursor() as cursor:        
            cursor.execute("call buscarUsuariosXUsuario(%s);",username)
            usuario = cursor.fetchone()        
        conexion.close()
        return usuario


def eliminarUsuario(id):
    conexion = obtener_conexion()
    with conexion.cursor() as cursor:        
        cursor.execute("call eliminarUsuario(%s);",id)      
    conexion.close()
    return buscarUsuarioXID(id)


def buscarUsuarioEstado():
    conexion = obtener_conexion()
    usuarios = [] 
    with conexion.cursor() as cursor:   
        cursor.execute("call buscarUsuarioEstado()")     
        usuarios = cursor.fetchall()       
    conexion.close()
    return usuarios


def cifrarPaeta(password):
    #Convertir texto en bytes
    password = password.encode('utf-8')
    #Base para concatenar bytes
    byte = b''
    #Concatenar bytes
    pssw = byte + password

    #sha512: Tipo de algoritmo de cifrado
    #pssw: Contrasena en bytes
    #b'zsbyHm4oRdPd5Jgf': "Salt" para encriptar
    #300000: "Rounds" veces que el algoritmo se ejecuta
    result = pbkdf2_hmac('sha512', pssw, b'zsbyHm4oRdPd5Jgf', 300000)
    return result.hex()[80:98]



def login(usuario, contraseña):
    conexion = obtener_conexion()
    with conexion.cursor() as cursor:        
        cursor.execute("call loginUsuario('"+usuario+"', '"+cifrarPaeta(contraseña)+"');")  
        #cursor.execute("call loginUsuario('"+usuario+"', '"+contraseña+"');")  
        login = cursor.fetchone()    
    conexion.commit()
    conexion.close()
    return login

# Se debe utilizar un algoritmo de cifrado que incluya un "salt" y tiempo de espera para proteger
# la base de datos de algun ataque por fuerza bruta

