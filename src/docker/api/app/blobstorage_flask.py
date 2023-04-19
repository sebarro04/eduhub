import os   
from flask import Blueprint,Flask, jsonify, request,flash,redirect, url_for, send_from_directory, current_app
from werkzeug.utils import secure_filename
from azure.identity import DefaultAzureCredential
from azure.storage.blob import BlobServiceClient, BlobClient, ContainerClient

account_url = "https://filesmanagerproyecto1.blob.core.windows.net"
default_credential = DefaultAzureCredential()
blob_service_client = BlobServiceClient(account_url, credential=default_credential)

BLOBSTORAGE_BLUEPRINT = Blueprint('BLOBSTORAGE_BLUEPRINT', __name__)

@BLOBSTORAGE_BLUEPRINT.route('/eduhub/files', methods=['POST']) 
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
 
 
@BLOBSTORAGE_BLUEPRINT.route('/eduhub/files/<string:name>', methods=['GET']) 
def download_file(name): 
    return send_from_directory(current_app.config["UPLOAD_FOLDER"], name)