import os   
from flask import Blueprint,Flask, jsonify, request,flash,redirect, url_for, send_from_directory, current_app
from werkzeug.utils import secure_filename 

BLOOBSTORAGE_BLUEPRINT = Blueprint('BLOOBSTORAGE_BLUEPRINT', __name__)

@BLOOBSTORAGE_BLUEPRINT.route('/eduhub/files', methods=['POST']) 
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
    file.save(os.path.join(current_app.config['UPLOAD_FOLDER'], filename)) 
    return   "<p>Upload!</p>" 
 
 
@BLOOBSTORAGE_BLUEPRINT.route('/eduhub/<name>', methods=['GET']) 
def download_file(name): 
    return send_from_directory(current_app.config["UPLOAD_FOLDER"], name)