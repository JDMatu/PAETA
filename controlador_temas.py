from bd import obtener_conexion

def crearTema(nombre, asignatura):
    conexion = obtener_conexion()
    with conexion.cursor() as cursor:
        #cursor.execute("call crearTema(%s,%s);",nombre,idAsignatura)
        cursor.execute("call crearTema('" + nombre + "'," + asignatura + ");")
    conexion.commit()
    conexion.close()

def modificarTema(idTema, nombre, idAsignatura, estado):
    conexion = obtener_conexion()
    with conexion.cursor() as cursor:
        #cursor.execute("call modificarTema(%s,%s,%s);",idTema,nombre,idAsignatura)
        cursor.execute("call modificarTema('" + str(idTema) + "','" + nombre + "'," + idAsignatura + ",'" + estado +"');")
    conexion.commit()
    conexion.close() 




def eliminarTema(idTema):
    conexion = obtener_conexion()
    with conexion.cursor() as cursor:
        #cursor.execute("call eliminarTema(%s);",idTema)
        cursor.execute("call eliminarTema(" + str(idTema) + ");")
    conexion.commit()
    conexion.close()

def buscarTemasRegistrados():
    conexion = obtener_conexion()
    temas = []
    with conexion.cursor() as cursor:
        cursor.execute("call buscarTemasRegistrados();")
        temas = cursor.fetchall()
    conexion.close()
    return temas


def buscarTemasXDepartamento(idD):
    conexion = obtener_conexion()
    temas = []
    with conexion.cursor() as cursor:
        cursor.execute("call buscarTemasXDepartamento(" + str(idD) + ");")
        temas = cursor.fetchall()
    conexion.close()
    return temas


def buscarTemaXID(idTema):
    conexion = obtener_conexion()
    tema = None
    with conexion.cursor() as cursor:
        #cursor.execute("call buscarTemaXID(%s);",idTema)
        cursor.execute("call buscarTemaXID(" + str(idTema) + ");")
        tema = cursor.fetchone()
    conexion.close()
    return tema

def buscarTemasXNombre(nombre):
    conexion = obtener_conexion()
    tema = None
    with conexion.cursor() as cursor:
        #cursor.execute("call buscarTemasXNombre(%s);",nombre)
        cursor.execute("call buscarTemasXNombre('" + nombre + "');")
        tema = cursor.fetchone()
    conexion.close()
    return tema

    
def buscarAsignaturasRegistradas():
    conexion = obtener_conexion()
    temas = []
    with conexion.cursor() as cursor:
        cursor.execute("call imprimirAsignaturas();")
        temas = cursor.fetchall()
    conexion.close()
    return temas

