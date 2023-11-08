from flask import render_template
from bd import obtener_conexion


def buscarAsignaturasRegistradas():#::::::::::::::::
    conexion = obtener_conexion()
    asignatura = [] 
    with conexion.cursor() as cursor:   
        cursor.execute("call ImprimirAsignaturas()")     
        asignatura = cursor.fetchall() 
    conexion.close()
    return asignatura 


def buscarAsignaturasEstado(idD):#::::::::::::::::
    conexion = obtener_conexion()
    asignatura = [] 
    with conexion.cursor() as cursor:   
        cursor.execute("call buscarAsignaturasEstado(%s)",idD)     
        asignatura = cursor.fetchall() 
    conexion.close()
    return asignatura 


def CrearAsignatura(Nb , idD ):#::::::::::::::::
    conexion = obtener_conexion()
    asignatura = [] 
    with conexion.cursor() as cursor:   
        cursor.execute("call crearAsignatura('"+Nb+"',"+str(idD)+")")     
        asignatura = cursor.fetchall() 
    conexion.commit()
    conexion.close()
    return (buscarAsignaturasRegistradas()) 

# CrearAsignatura("TIC's",1)

def buscarAsignaturaXID(id):#::::::::::::::::
    conexion = obtener_conexion()
    asignatura = None
    with conexion.cursor() as cursor:        
        cursor.execute("call BuscarAsignaturaXID(%s);",id)
        asignatura = cursor.fetchone()         
    conexion.close()
    return asignatura



def buscarAsignaturaXnombre(nb):#::::::::::::::::
    conexion = obtener_conexion()
    asignatura = [] 
    with conexion.cursor() as cursor:   
        cursor.execute("call BuscarAsignaturaXNombre('"+nb+"')")     
        asignatura = cursor.fetchall() 
    conexion.close()
    return asignatura 


def eliminarAsignatura(id):#:::::::::::::::::::::::
    conexion = obtener_conexion()
    with conexion.cursor() as cursor:
        cursor.execute("call EliminarAsignatura("+str(id)+");")
    conexion.commit()
    conexion.close()


def ModificarAsignatura(idA,nombre, id, estado):
    conexion = obtener_conexion()
    with conexion.cursor() as cursor:
        cursor.execute("call ModificarAsignatura('"+str(idA)+"','"+nombre+"',"+str(id)+",'"+estado+"');")
    conexion.commit()
    conexion.close()
    




def buscarDepartamentosRegistrados():
    conexion = obtener_conexion()
    departamentos = [] 
    with conexion.cursor() as cursor:   
        cursor.execute("call buscarDepartamentosRegistrados()")     
        departamentos = cursor.fetchall()     
    conexion.close()
    return departamentos



    
    