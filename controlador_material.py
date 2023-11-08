from bd import obtener_conexion
# Se importa desde ell otro archivo .py donde
# se usa llamando el procedimiento con ()

from flask import redirect, render_template


#=================================================================================================#
#================================ C R U D   D E   M A T E R I A L ================================#


def crearMaterial(t, des, rA, eA, aut, dur, niv, idT):
    conexion = obtener_conexion()
    with conexion.cursor() as cursor:
        cursor.execute("call crearMaterial('"+t+"', '"+des+"', '"+str(aut) + "','"+niv+"','"+ dur+"','"+rA+"',' "+eA+"', "+idT+")")
    conexion.commit() 
    conexion.close()
    return buscarMateriales()



def modificarMaterial(id, t, des, aut, niv, dur, eA, est):
    conexion = obtener_conexion()
    with conexion.cursor() as cursor:      
        cursor.execute("call modificarMaterial("+str(id)+", '"+t+"', '"+des+"', '"+aut+"', '"+niv+"', '"+dur+"', '"+eA+"','"+est+"')")
    conexion.commit() 
    conexion.close() 
    return redirect("/Controlador_videos")   
#modificarMaterial(11, "titulito", "description", "jijija", "12°", "12:00:05", "aaaaa", 233)


def eliminarMaterial(id):
    conexion = obtener_conexion()
    with conexion.cursor() as cursor:        
        cursor.execute(
            "call eliminarMaterial(%s);",id)
    conexion.commit()      
    conexion.close()



#===============================================================#
#======================= B U S Q U E D A =======================#

def buscarMaterialesRegistrados(idD):
    conexion = obtener_conexion()
    materiales = [] 
    with conexion.cursor() as cursor:   
        cursor.execute("call buscarMaterialesRegistrados(" + str(idD) + ")")     
        materiales = cursor.fetchall()      
    conexion.close()
    return materiales


def buscarMateriales():
    conexion = obtener_conexion()
    materiales = [] 
    with conexion.cursor() as cursor:   
        cursor.execute("call buscarMateriales("")")     
        materiales = cursor.fetchall()      
    conexion.close()
    return materiales


def buscarMaterialXID(id,p):
    conexion = obtener_conexion()
    material = None
    with conexion.cursor() as cursor:        
        cursor.execute("call buscarMaterialXID(" + str(id) + "," + str(p) + ");")
        material = cursor.fetchone()         
    conexion.close()
    return material

def buscarMaterialeXDepartamento(idD):
    conexion = obtener_conexion()
    material = None
    with conexion.cursor() as cursor:        
        cursor.execute("call buscarMaterialeXDepartamento(%s);",idD)
        material = cursor.fetchall()         
    conexion.close()
    return material

def buscarMaterialXNombre(nom):
    conexion = obtener_conexion()
    material = None
    with conexion.cursor() as cursor:        
        cursor.execute("call buscarMaterialXNombre(%s);",nom)
        material = cursor.fetchall()         
    conexion.close()
    return material



def buscarMaterialXtema(tema):
    conexion = obtener_conexion()
    material = None
    with conexion.cursor() as cursor:        
        cursor.execute("call buscarMaterialXtema(%s);",tema)
        material = cursor.fetchall()         
    conexion.close()
    return material


def buscarMaterialeXEstado(est):
    conexion = obtener_conexion()
    material = None
    with conexion.cursor() as cursor:        
        cursor.execute("call buscarMaterialeXEstado(%s);",est)
        material = cursor.fetchall()         
    conexion.close()
    return material


#buscarMaterialXtema


#==============================================================================#
#======================= G U A R D A R  M A T E R I A L =======================#
def upload_config(application, folder):
    Upload_folder = 'static/' + folder
    application.secret_key = "secret key"
    application.config['UPLOAD_FOLDER'] = Upload_folder

    application.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024

