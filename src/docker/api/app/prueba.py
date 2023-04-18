import os   
from flask import Blueprint,Flask, jsonify, request,flash,redirect, url_for, send_from_directory
from werkzeug.utils import secure_filename 

PRUEBA_BLUERPRINT = Blueprint('PRUEBA_BLUERPRINT', __name__)

app = Flask(__name__) 
app.secret_key = b'_5#y2L"F4Q8z\n\xec]/' 
UPLOAD_FOLDER = 'C:/Users/sofia/OneDrive/Documentos/Prueba' 
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER 

@PRUEBA_BLUERPRINT.route("/") 
def hello_world(): 
    return "<p>Hello, World!</p>" 
 
 
#@app.route('/eduhub/files/upload', methods=['POST']) 
@PRUEBA_BLUERPRINT.route('/upload', methods=['POST']) 
def upload_file(): 
    if request.method == 'POST': 
        if 'file' not in request.files: 
            flash('No file part') 
            return "<p>Upload File!</p>" 
    file = request.files['file'] 
    if file.filename == '': 
        return  "<p>Upload No name!</p>" 
    filename = secure_filename(file.filename) 
    print(filename) 
    file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename)) 
    return   "<p>Upload!</p>" 
 
 
@PRUEBA_BLUERPRINT.route('/download/<name>', methods=['GET']) 
def download_file(name): 
    return send_from_directory(app.config["UPLOAD_FOLDER"], name)