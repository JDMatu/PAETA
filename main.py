from flask import Flask, render_template, request, redirect, flash, url_for, jsonify
import os
import urllib.request
from werkzeug.utils import secure_filename
import controlador_usuarios
import controlador_asignaturas
import controlador_departamentos
import controlador_temas
import controlador_material
from controlador_guardar_videos import video_config
from dotenv import load_dotenv


#Libreria de control de usuarios
from flask_login import LoginManager, login_user, logout_user, login_required, current_user


#Libreria para construir funciones decoradas
from functools import wraps

#Importar la clase de usuarios
from src.models.User import User1

load_dotenv()




app = Flask(__name__)




#Inicializar el control de usuarios
login_manager = LoginManager(app)

#Configurar la llave secreta de la aplicacion
app.config['SECRET_KEY'] = os.getenv('APP_Secret')

#Funcion que carga los datos del usuario desde la base de datos 
#cada que vez que el usuario recarga la pagina
@login_manager.user_loader
def load_user(id):

    row = controlador_usuarios.buscarUsuarioXID(id)
    return User1(row[0],row[1], row[2],row[3], row[5], row[6], row[7])

#Funcion que limita el acceso a paginas solo a administradores
def administrador():
    if current_user.tipo != 'Administrador':
        return False
    else:

        return True

#Redirreciona al home
def home():
    if administrador():
        return redirect('Controlador_videos')
    else:
        return redirect(url_for('videos'))

  


#Redirecciona a usuarios no logeados a log in
@login_manager.unauthorized_handler
def unauthorized_callback():
    return redirect(url_for('login'))



#Render de /home
@app.route("/")
@app.route("/login", methods=["GET","POST"])
def login():
    if request.method == "POST":
        #Datos ingresados
        user = User1(0, "",request.form["username"], request.form["password"], "", "","")
        #Datos de la base de datos
        row = controlador_usuarios.buscarUsuariosXUsuario(request.form["username"])
        try:
            logged_user = User1(row[0],row[1], row[2],row[3], row[5], row[6],row[7])
            if load_user != None:
                if logged_user.estado == "Inactivo":
                    flash("Usuario Inactivo","alert-warning")
                    return home()
                else:
                    if logged_user.contrasena == controlador_usuarios.cifrarPaeta(user.contrasena):
                        login_user(logged_user)
                        return home()
                    else:
                        flash("Contrasena Incorrecta","alert-warning")
                        return redirect(url_for('login'))
            else:
                return redirect(url_for('login'))
        except:
            flash("Usuario no encontrado","alert-warning")
            return redirect(url_for('login'))
            
    else:
        if  current_user.is_authenticated:
            return home()
        else:
            return render_template('login.html')


    

#Render de /departamentos
@app.route("/departamentos")
@login_required
def departamentos():
    if administrador():
        departamentos = controlador_departamentos.buscarDepartamentosRegistrados()
        return render_template("departamentos.html", Departamentos=departamentos)
    else:
        flash("No estas autorizado","alert-warning")
        return redirect(url_for('videos'))

#**********************************************************************************

@app.route("/crear_departamento", methods=["GET","POST"])
@login_required
def formulario_crear_Departamento():
    if administrador():
        if request.method == "POST":
            nombre = request.form["nombre"] 
            controlador_departamentos.crear_Departamento(nombre)
            Departamentos = controlador_departamentos.buscarDepartamentosRegistrados()
            # De cualquier modo, y si todo fue bien, redireccionar
            return redirect(url_for('departamentos'))
        else:
            return home()
    else:
        return home()


#**********************************************************************************

@app.route("/deshabilitar_departamento/<int:id>")
@login_required
def deshabilitar_departamento(id):
    if administrador():
        controlador_departamentos.desactivar_Departamento(id)
        return redirect(url_for('departamentos'))
    else:
        home()

#**********************************************************************************

@app.route("/actualizar_Departamento", methods=["GET","POST"])
@login_required
def actualizar_Departamento():
    if request.method == "POST":
        id = request.form["idDepartamento"]
        nombre = request.form["nombre-edit"]   
        estado = request.form["select-estado-edit"]
        controlador_departamentos.modificar_Departamento(id, nombre, estado)   
        return redirect(url_for('departamentos'))
    else:
        return home()

#**********************************************************************************


#Render de /usuarios
@app.route("/usuarios")
@login_required
def usuarios():
    if administrador():
        usuarios = controlador_usuarios.buscarUsuariosRegistrados()
        departamentos = controlador_departamentos.buscarDepartamentosRegistrados()
        return render_template("usuarios.html", usuarios=usuarios,departamentos=departamentos)
    else:
        flash("No estas autorizado","alert-warning")
        return home()

@app.route("/crear_usuarios", methods=["GET","POST"])
@login_required
def crearUsuario():
    if administrador():
        controlador_usuarios.crearUsuario(request.form["nombre"], request.form["usuario"], request.form["contraseña"], request.form["correo"], request.form["tipo"],"Activo", request.form["idD"])
        usuarios = controlador_usuarios.buscarUsuariosRegistrados()
        return render_template("usuarios.html", usuarios=usuarios)
    else:
        return home()

@app.route("/editar_usuarios", methods=["POST"])
@login_required
def editarUsuario():
    if administrador():
        controlador_usuarios.modificarUsuario(request.form["idUsuario"], request.form["nombre-edit"], request.form["usuario-edit"], request.form["password-edit"], request.form["correo-edit"], request.form["select-tipoUsuario-edit"], request.form["select-estado-edit"], request.form["idD"])
        usuarios = controlador_usuarios.buscarUsuariosRegistrados()
        return render_template("usuarios.html", usuarios=usuarios)
    else:
        home()

@app.route("/deshabilitar_usuario/<int:id>")
@login_required
def deshabilitar_usuario(id):
    if administrador():
        controlador_usuarios.eliminarUsuario(id)
        return redirect(url_for('usuarios'))
    else:
        return home()


@app.route("/videos") # materiales
@login_required
def videos():
    materiales = controlador_material.buscarMaterialesRegistrados(current_user.iDdepartamento)
    temas = controlador_temas.buscarTemasXDepartamento(current_user.iDdepartamento)
    asignaturas = controlador_asignaturas.buscarAsignaturasEstado(current_user.iDdepartamento)
    usuarios = controlador_usuarios.buscarUsuarioEstado()
    return render_template("videos2.html", Materiales = materiales, Temas = temas, Asignaturas = asignaturas, Usuarios = usuarios)


@app.route("/Controlador_videos") # materiales
@login_required
def Controlador_videos():
    if administrador():
        materiales = controlador_material.buscarMateriales()
        temas = controlador_temas.buscarTemasRegistrados()
        asignaturas = controlador_asignaturas.buscarAsignaturasRegistradas()
        usuarios = controlador_usuarios.buscarUsuarioEstado()
        departamentos = controlador_departamentos.buscarDepartamentosRegistrados()
        return render_template("videos.html", Materiales = materiales, Temas = temas, Asignaturas = asignaturas, Usuarios = usuarios, Departamentos=departamentos, current_user=current_user)  
    else:
        return home() 
    


################ASIGNATURAS Inicio ************************************************
@app.route("/asignaturas")
@login_required
def asignaturas():   
    if administrador():
        asignaturas = controlador_asignaturas.buscarAsignaturasRegistradas()
        departamentos = controlador_asignaturas.buscarDepartamentosRegistrados()
        return render_template("asignaturas.html", Asignaturas=asignaturas, Departamentos = departamentos)
    else:
        flash("No estas autorizado","alert-warning")
        return home()
#****************************************************

@app.route("/guardar_Asignatura", methods=["GET", "POST"])
@login_required
def guardar_Asignatura():
    if administrador():
        if request.method == "POST":
            nombre = request.form["nombreA"]
            idDepartamento = request.form["departamentoA"]
            controlador_asignaturas.CrearAsignatura(nombre,idDepartamento)
            # De cualquier modo, y si todo fue bien, redireccionar
            return redirect(url_for('asignaturas'))
        else:
            return redirect(url_for('asignaturas'))
    else:
        return home()


#**********************************************************************************

@app.route("/modificar_Asignatura", methods=["GET","POST"])#Modificar
@login_required
def modificar_Asignatura():
    if administrador():
        if request.method == "POST":
            id = request.form["idAsignatura"]
            nombre = request.form["nombreA"]   
            idDepartamento = request.form["departamentoA"]
            Estado = request.form["estado"]
            controlador_asignaturas.ModificarAsignatura(id,nombre,idDepartamento,Estado)
            return redirect(url_for('asignaturas'))
        else:
            return redirect(url_for('asignaturas'))
    else:
        return home()

#**********************************************************************************
@app.route("/eliminar_asignatura/<int:id>")
@login_required
def eliminar_asignatura(id):
    if administrador():
        controlador_asignaturas.eliminarAsignatura(id)
        return redirect(url_for('asignaturas'))
    else:
        return home()

#***********************************************************


@app.route("/BuscarXnombreA")
@login_required
def BuscarXnombre():
    Nombre = request.form["nombre"]
    controlador_asignaturas.buscarAsignaturaXnombre(Nombre)
#***********************************************************


@app.route("/temas")
@login_required
def temas():
    if administrador():
        temas = controlador_temas.buscarTemasRegistrados()
        asignaturas = controlador_temas.buscarAsignaturasRegistradas()
        return render_template("temas.html", temas = temas, Asignaturas = asignaturas)
    else:
        flash("No estas autorizado","alert-warning")
        return home()

@app.route("/crearTema", methods=["POST"])
@login_required
def crearTema():
    if administrador():
        controlador_temas.crearTema(request.form["nombre"], request.form["asignatura"])
        temas = controlador_temas.buscarTemasRegistrados()
        return redirect(url_for('temas'))
    else:
        return home()


@app.route("/editarTema", methods=["POST"])
@login_required
def editarTema():
    if administrador():
        controlador_temas.modificarTema(request.form["idTema"], request.form["nombre-edit"], request.form["asignatura-edit"],request.form["estado"])
        temas = controlador_temas.buscarTemasRegistrados() 
        return redirect(url_for('temas'))
    else:
        return home()

@app.route("/deshabilitar_tema/<int:id>")
@login_required
def deshabilitar_tema(id):
    if administrador():
        controlador_temas.eliminarTema(id)
        return redirect(url_for('temas'))
    else:
        return home()


#-----------------MATERIAL

ALLOWED_EXTENSIONS = set(["mp4","jpg"])
def allowed_file(file):
    file = file.split('.')
    if file[1]in ALLOWED_EXTENSIONS:
        return True
    return False


@app.route("/guardar_material", methods=["POST"])
@login_required
def guardarMaterial():
    t = request.form['titulo'] 
    des = request.form['descripcion'] 
    rA = 'uploads'
    eA = request.form['espacio'] +" "+ request.form['unidadMedida']
    aut = request.form['profesor']
    dur = request.form['duracion'] +" "+ request.form['unidadMedidaDuracion']
    niv = request.form['nivel']
    est = "Activo"
    idT = request.form['tema']
    controlador_material.crearMaterial(t, des, rA, eA, aut, dur, niv, idT)

    video_config(app, 'videos')


    file = request.files['uploadFile']

    filename = secure_filename(file.filename)
    if file and allowed_file(filename):
        file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
        os.rename(os.path.join(app.config['UPLOAD_FOLDER']) + '/' + filename, os.path.join(app.config['UPLOAD_FOLDER']) + '/' + t + '.mp4')
    

    return redirect(url_for('Controlador_videos'))




@app.route('/videos/<video_id>')
def video(video_id):
    # Código para obtener la información del video de la base de datos
    # y enviarla como una respuesta JSON
    video_info = controlador_material.buscarMaterialXID(video_id, current_user.iDdepartamento)
    return jsonify(video_info)


@app.route('/videos/buscar')
def buscar_videos():
    Found = request.args.get('found')

    videos = controlador_material.buscarMaterialXNombre(Found)
    if (videos == ()):
        videos = controlador_material.buscarMaterialesRegistrados(current_user.iDdepartamento) 
    if (videos[0][11] != current_user.iDdepartamento):
        videos = controlador_material.buscarMaterialesRegistrados(current_user.iDdepartamento)
    if (videos[0][10]!= "Activo"):    
        videos = controlador_material.buscarMaterialesRegistrados(current_user.iDdepartamento)
    return jsonify(videos)




@app.route('/videos/tema')
def temas_videos():
  tema = request.args.get('tema')

  videos = controlador_material.buscarMaterialXtema(tema)
  print(videos)
  if (tema == ""):
      videos = controlador_material.buscarMaterialesRegistrados(current_user.iDdepartamento)
  if (videos == ()):
      videos = controlador_material.buscarMaterialXtema(tema)
  

  return jsonify(videos)


@app.route('/videos/departamento')
def depar_videos():
    depar = request.args.get('depar')

    videos = controlador_material.buscarMaterialeXDepartamento(depar)
    if (depar == ""):
        videos = controlador_material.buscarMateriales()
    if (videos == ()):
        videos = controlador_material.buscarMaterialeXDepartamento(depar)
    

    return jsonify(videos)



@app.route('/videos/estado')
def est_videos():
  est = request.args.get('estado')
    
  videos = controlador_material.buscarMaterialeXEstado(est)
  if (est == ""):
      videos = controlador_material.buscarMateriales()
  if (videos == ()):
      videos = controlador_material.buscarMaterialeXEstado(est)
  

  return jsonify(videos)


@app.route('/videos/buscador')
def buscar_v():
  V_found = request.args.get('admin')

  videos = controlador_material.buscarMaterialXNombre(V_found)
  if (videos == ()):
    videos = controlador_material.buscarMateriales() 

  return jsonify(videos)


@app.route('/deshabilitar_material')
@login_required
def deshabilitar_material():
    id = request.args.get('id')
    if administrador():
        controlador_material.eliminarMaterial(id)
        return redirect(url_for('Controlador_videos'))
    else:
        home()


@app.route("/editar_video", methods=["GET","POST"])
@login_required
def editar_video():
    if administrador():
        if request.method == "POST":
            controlador_material.modificarMaterial(request.form["idVideo"], request.form["titulo-edit"], request.form["des-edit"], request.form["autoria-edit"], request.form["nivel-edit"], request.form["duracion-edit"], request.form["espacio-edit"], request.form["estado"])
            return redirect(url_for('Controlador_videos'))
        return redirect(url_for('Controlador_videos'))
    else:
        home()








@app.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for('login'))

#Inicialilzacion del servidor
if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8000, debug=True)


