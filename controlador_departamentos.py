from flask import render_template
from bd import obtener_conexion

def crear_Departamento(nombre):
    conexion = obtener_conexion()
    with conexion.cursor() as cursor:
        cursor.execute("call crearDepartamento('"+nombre+"')")
    conexion.commit()
    conexion.close()


def modificar_Departamento(id, nombre, estado):
    conexion = obtener_conexion()
    conexion2 = obtener_conexion()
    conexion3 = obtener_conexion()
    with conexion.cursor() as cursor:
        cursor.execute("call modificarDepartamento("+str(id)+",'"+nombre+"');")
    conexion.commit()
    conexion.close()

    with conexion2.cursor() as cursor:        
        cursor.execute("call buscarDepartamentoEstado("+str(id)+");")
        estado2 = cursor.fetchone()   
    conexion2.close()

    if estado2[0] != estado:
        with conexion3.cursor() as cursor:        
            cursor.execute("call desactivarDepartamento("+str(id)+");")   
        conexion3.commit()    
        conexion3.close()


def desactivar_Departamento(id):
    conexion = obtener_conexion()
    with conexion.cursor() as cursor:
        cursor.execute("call eliminarDepartamento("+str(id)+");")
    conexion.commit()
    conexion.close()



def buscarDepartamentosRegistrados():
    conexion = obtener_conexion()
    Departamentos = [] 
    with conexion.cursor() as cursor:   
        cursor.execute("call buscarDepartamentosRegistrados()")     
        Departamentos = cursor.fetchall()       
    conexion.close()
    return Departamentos 


def buscarDepartamentosXID(id):
    conexion = obtener_conexion()
    Departamentos = None
    with conexion.cursor() as cursor:        
        cursor.execute("call buscarDepartamentosXID(%s);",id)
        Departamentos = cursor.fetchone()         
    conexion.close()
    return Departamentos


def buscarDepartamentosXNombre(nombre):
    conexion = obtener_conexion()
    Departamento = None
    with conexion.cursor() as cursor:        
        cursor.execute("call buscarDepartamentosXNombre(%s);",nombre)
        Departamento = cursor.fetchone()
    conexion.close()
    return Departamento
    


def login(usuario, contraseña):
    conexion = obtener_conexion()
    with conexion.cursor() as cursor:        
        cursor.execute("call loginUsuario('"+usuario+"', '"+contraseña+"');")  
        login = cursor.fetchone()    
    conexion.commit()
    conexion.close()
    return login
