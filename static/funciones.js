const videoDivs = document.querySelectorAll('.PrevVideo');
videoDivs.forEach(div => {
  div.addEventListener('click', event => {
    const videoId = div.dataset.videoId;
    // Llama a una función de JavaScript para cargar la información detallada del video en el segundo div
    cargarVideo(videoId);
  });
});

function cargarVideo(videoId) {
    // Usa Ajax para obtener la información del video desde el servidor Flask
    const xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
      if (xhr.readyState === 4 && xhr.status === 200) {
        const videoInfo = JSON.parse(xhr.responseText);
        // Actualiza el contenido del segundo div con la información detallada del video


        const video_mostrado = document.getElementById('video_mostrar');
        video_mostrado.innerHTML = `
            <video class="video_class" controls controlslist="nodownload">
                <source src="../static/videos/${videoInfo[1].replace("%20","_")}.mp4">
            </video>
            <div class="title_vid">
                <h2 class="title">${videoInfo[1]}</h2>
                <p class="teacher">${videoInfo[4]}</p>
                <p class="description">${videoInfo[2]}</p>
        
                <div class="info">
                    <div class="info_column">
                        <p class="tema">Tema</p> <span class="tema_tag">${videoInfo[8]}</span>
                    </div>
                    <div class="info_column">
                        <p class="tema">Duración</p> <span class="tema_tag">${videoInfo[5]}</span>
                    </div>
                </div>
                
                ${
                  videoInfo[12] == 15
                    ? `
                    <h4 class="title_admin">Opciones de Administrador</h4>
                    <div class="administrator">
                        <a href="/deshabilitar_material?id=${videoInfo[0]}" class="button-video">
                            <button class="delete"><span class="icon-trash"></span> Eliminar</button>
                        </a>
                        <button class="update" onclick="editar_video('${videoInfo[0]}','${videoInfo[1]}','${videoInfo[3]}','${videoInfo[2]}','${videoInfo[6]}','${videoInfo[5]}','${videoInfo[9]}','${videoInfo[10]}')" onclick id="btn_edit1"> <span class="icon-edit"></span> Editar</button>
                    </div>
                    `
                    : ''
                }
            </div>
        `;
      }
    };
    xhr.open('GET', `/videos/${videoId}`);
    xhr.send();
    var span_edit = document.getElementsByClassName("close_edit")[0];
    span_edit.onclick = function() {
      document.getElementById("myModal_edit").style.display = "none";
    }
  }

  function editar_video (id,t,aut,des,niv,dur,esp,est){
    document.getElementById("myModal_edit").style.display = "block";
    document.getElementById("idVideo").value = id;
    document.getElementById("titulo-edit").value = t;
    document.getElementById("autoria-edit").value = aut;
    document.getElementById("des-edit").value = des;
    document.getElementById("nivel-edit").value = niv;
    document.getElementById("duracion-edit").value = dur;
    document.getElementById("espacio-edit").value = esp;
    document.getElementById("estado").value = est;
    var formulario =   document.getElementById("formulario");
    formulario.action = "editar_video"; 
  }




//Buscar videos for user

const search = document.querySelector('#buscador');
search.addEventListener('input', buscarVideos);

function buscarVideos() {
  const endsearch = search.value;

  fetch(`/videos/buscar?found=${endsearch}`)
    .then(response => response.json())
    .then(videos => {
      // Actualizar el contenido del contenedor de videos con los resultados de la búsqueda
      const contenedorVideos = document.querySelector('.videos_container');
      
      contenedorVideos.innerHTML = '';
      videos.forEach(video => {
        // Crear y agregar elementos HTML para cada video
        const videoElement = document.createElement('div');
        videoElement.innerHTML = `

          <div class="PrevVideo" style="cursor:pointer;" data-video-id="${video[0]}" onclick="cargarVideo(${video[0]})"> 

            <div class="col_img">

              ${
                video[11] === 1
                  ? '<img src="../static/img/codes.jpg" width="100%" height="100%">'
                  : video[11] === 2
                  ? '<img src="../static/img/turism.jpg" width="100%" height="100%">'
                  : video[11] === 3
                  ? '<img src="../static/img/farm.jpg" width="100%" height="100%">'
                  : video[11] === 8
                  ? '<img src="../static/img/agroindustry.jpg" width="100%" height="100%">'
                  : ''
              }

            </div>
    
            <div class="col_content">
      
                <div class="head">
                    <hp class="titulo">${video[1]}</hp> <span class="tema">Tema: ${video[8]}</span>
                </div>
      
                <div class="body">
                    <h3>Autoría: ${video[4]}</h3>
                    <p>${video[2]}</p>
                </div>
                  
      
                <div class="details">
                    <span class="salt">Duración: ${video[5]}</span> 
                    <span>Nivel: ${video[6]}</span>
                </div>
                
            </div>
          </div> 

        `;
        contenedorVideos.appendChild(videoElement);
      });
    
    });
}




//temas videos 

function VideosXtemas(str) {
  const V_temas = str;

  fetch(`/videos/tema?tema=${V_temas}`)
    .then(response => response.json())
    .then(videos => {
      // Actualizar el contenido del contenedor de videos con los resultados de la búsqueda
      const contenedorVideos = document.querySelector('.videos_container');
      contenedorVideos.innerHTML = '';

      videos.forEach(video => {
        // Crear y agregar elementos HTML para cada video
        const videoElement = document.createElement('div');
        videoElement.innerHTML = `

          <div class="PrevVideo" style="cursor:pointer;" data-video-id="${video[0]}" onclick="cargarVideo(${video[0]})"> 

            <div class="col_img">
              
              ${
                video[11] === 1
                  ? '<img src="../static/img/codes.jpg" width="100%" height="100%">'
                  : video[11] === 2
                  ? '<img src="../static/img/turism.jpg" width="100%" height="100%">'
                  : video[11] === 3
                  ? '<img src="../static/img/farm.jpg" width="100%" height="100%">'
                  : video[11] === 8
                  ? '<img src="../static/img/agroindustry.jpg" width="100%" height="100%">'
                  : ''
              }

            </div>
    
            <div class="col_content">
      
                <div class="head">
                    <hp class="titulo">${video[1]}</hp> <span class="tema">Tema: ${video[8]}</span>
                </div>
      
                <div class="body">
                    <h3>Autoría: ${video[4]}</h3>
                    <p>${video[2]}</p>
                </div>
                  
      
                <div class="details">
                    <span class="salt">Duración: ${video[5]}</span> 
                    <span>Nivel: ${video[6]}</span>
                </div>
                
            </div>
          </div> 

        `;
        contenedorVideos.appendChild(videoElement);
      });
    });
}




//Departamentos videos

function VideosXDepar(str) {
  const V_Depar = str;
  fetch(`/videos/departamento?depar=${V_Depar}`)
    .then(response => response.json())
    .then(videos => {
      // Actualizar el contenido del contenedor de videos con los resultados de la búsqueda
      const contenedorVideos = document.querySelector('.videos_container');
      contenedorVideos.innerHTML = '';

      videos.forEach(video => {
        // Crear y agregar elementos HTML para cada video
        const videoElement = document.createElement('div');
        videoElement.innerHTML = `

          <div class="PrevVideo" style="cursor:pointer;" data-video-id="${video[0]}" onclick="cargarVideo(${video[0]})"> 

            <div class="col_img">
              
              ${
                video[11] === 1
                  ? '<img src="../static/img/codes.jpg" width="100%" height="100%">'
                  : video[11] === 2
                  ? '<img src="../static/img/turism.jpg" width="100%" height="100%">'
                  : video[11] === 3
                  ? '<img src="../static/img/farm.jpg" width="100%" height="100%">'
                  : video[11] === 8
                  ? '<img src="../static/img/agroindustry.jpg" width="100%" height="100%">'
                  : ''
              }

            </div>
    
            <div class="col_content">
      
                <div class="head">
                    <hp class="titulo">${video[1]}</hp> <span class="tema">Tema: ${video[8]}</span>
                </div>
      
                <div class="body">
                    <h3>Autoría: ${video[4]}</h3>
                    <p>${video[2]}</p>
                </div>
                  
      
                <div class="details">
                    <span class="salt">Duración: ${video[5]}</span> 
                    <span>Nivel: ${video[6]}</span>
                </div>
                
            </div>
          </div> 

        `;
        contenedorVideos.appendChild(videoElement);
      });
    });
}


//Estados Videos

function VideosXestado(str) {
  const V_estado = str;

  fetch(`/videos/estado?estado=${V_estado}`)
    .then(response => response.json())
    .then(videos => {
      
      // Actualizar el contenido del contenedor de videos con los resultados de la búsqueda
      const contenedorVideos = document.querySelector('.videos_container');
      contenedorVideos.innerHTML = '';
      
      videos.forEach(video => {
        // Crear y agregar elementos HTML para cada video
        const videoElement = document.createElement('div');
        videoElement.innerHTML = `

          <div class="PrevVideo" style="cursor:pointer;" data-video-id="${video[0]}" onclick="cargarVideo(${video[0]})"> 

            <div class="col_img">
              
              ${
                video[11] === 1
                  ? '<img src="../static/img/codes.jpg" width="100%" height="100%">'
                  : video[11] === 2
                  ? '<img src="../static/img/turism.jpg" width="100%" height="100%">'
                  : video[11] === 3
                  ? '<img src="../static/img/farm.jpg" width="100%" height="100%">'
                  : video[11] === 8
                  ? '<img src="../static/img/agroindustry.jpg" width="100%" height="100%">'
                  : ''
              }

            </div>
    
            <div class="col_content">
      
                <div class="head">
                    <hp class="titulo">${video[1]}</hp> <span class="tema">Tema: ${video[8]}</span>
                </div>
      
                <div class="body">
                    <h3>Autoría: ${video[4]}</h3>
                    <p>${video[2]}</p>
                </div>
                  
      
                <div class="details">
                    <span class="salt">Duración: ${video[5]}</span> 
                    <span>Nivel: ${video[6]}</span>
                </div>
                
            </div>
          </div> 

        `;
        contenedorVideos.appendChild(videoElement);
      });
    });
}



//buscador for admin

function buscarV(str) {
  const endsearch = str;
  console.log(endsearch);
  
  fetch(`/videos/buscador?admin=${endsearch}`)
    .then(response => response.json())
    .then(videos => {
      // Actualizar el contenido del contenedor de videos con los resultados de la búsqueda
      const contenedorVideos = document.querySelector('.videos_container');
      
      contenedorVideos.innerHTML = '';
      videos.forEach(video => {
        // Crear y agregar elementos HTML para cada video
        const videoElement = document.createElement('div');
        videoElement.innerHTML = `

          <div class="PrevVideo" style="cursor:pointer;" data-video-id="${video[0]}" onclick="cargarVideo(${video[0]})"> 

            <div class="col_img">

              ${
                video[11] === 1
                  ? '<img src="../static/img/codes.jpg" width="100%" height="100%">'
                  : video[11] === 2
                  ? '<img src="../static/img/turism.jpg" width="100%" height="100%">'
                  : video[11] === 3
                  ? '<img src="../static/img/farm.jpg" width="100%" height="100%">'
                  : video[11] === 8
                  ? '<img src="../static/img/agroindustry.jpg" width="100%" height="100%">'
                  : ''
              }

            </div>
    
            <div class="col_content">
      
                <div class="head">
                    <hp class="titulo">${video[1]}</hp> <span class="tema">Tema: ${video[8]}</span>
                </div>
      
                <div class="body">
                    <h3>Autoría: ${video[4]}</h3>
                    <p>${video[2]}</p>
                </div>
                  
      
                <div class="details">
                    <span class="salt">Duración: ${video[5]}</span> 
                    <span>Nivel: ${video[6]}</span>
                </div>
                
            </div>
          </div> 

        `;
        contenedorVideos.appendChild(videoElement);
      });
    
    });
}

