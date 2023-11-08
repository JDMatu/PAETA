import os
import urllib.request
from werkzeug.utils import secure_filename

def video_config(application, folder):
    Upload_folder = 'static/' + folder
    application.secret_key = "secret key"
    application.config['UPLOAD_FOLDER'] = Upload_folder
    application.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024

