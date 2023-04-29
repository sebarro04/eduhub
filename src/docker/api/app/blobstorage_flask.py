from flask import Blueprint, jsonify, request, send_file
import mimetypes
import blobstorage

BLOBSTORAGE_BLUEPRINT = Blueprint('BLOBSTORAGE_BLUEPRINT', __name__)

@BLOBSTORAGE_BLUEPRINT.route('/eduhub/files', methods=['POST']) 
def upload_file():
    if 'file' not in request.files:
        return 'No file part', 400
    if 'description' not in request.form:
        return 'No description part', 400 
    if 'user_id' not in request.form:
        return 'No user_id part'
    file = request.files['file']
    if file.filename == '':
        return 'No file name', 400
    description = request.form['description'] 
    user_id = request.form['user_id']
    if user_id == '':
        return 'Missing user_id', 400
    result = blobstorage.upload_blob(file, description, user_id)
    if isinstance(result, Exception):
        response = jsonify(str(result))
        response.status_code = 500
        return response
    response = jsonify('File uploaded')
    response.status_code = 200
    return response
 
@BLOBSTORAGE_BLUEPRINT.route('/eduhub/files/<int:file_id>', methods=['GET']) 
def download_file(file_id): 
    stream = blobstorage.download_blob(file_id)
    if isinstance(stream, Exception):
        response = jsonify(str(stream))
        response.status_code = 500
        return response
    filename = blobstorage.read_filename(file_id)
    if isinstance(filename, Exception):
        response = jsonify(str(filename))
        response.status_code = 500
        return response
    mimetype = mimetypes.guess_type(filename)[0]
    print(stream, filename, mimetype)
    return send_file(stream, mimetype=mimetype, download_name=filename, as_attachment=True)

@BLOBSTORAGE_BLUEPRINT.route('/eduhub/files/<string:user_id>', methods=['GET']) 
def read_latest_files(user_id):
    result = blobstorage.read_latest_files(user_id)
    if isinstance(result, Exception):
        response = jsonify(str(result))
        response.status_code = 500
        return response
    response = jsonify(result)
    response.status_code = 200
    return response

@BLOBSTORAGE_BLUEPRINT.route('/eduhub/files/history/<int:file_id>', methods=['GET']) 
def read_file_history(file_id):
    result = blobstorage.read_file_history(file_id)
    if isinstance(result, Exception):
        response = jsonify(str(result))
        response.status_code = 500
        return response
    response = jsonify(result)
    response.status_code = 200
    return response

@BLOBSTORAGE_BLUEPRINT.route('/eduhub/files/<int:file_id>', methods=['PUT']) 
def update_file_description(file_id): 
    if 'description' not in request.json:
        return 'No description part'
    description = request.json['description']
    result = blobstorage.update_file_description(file_id, description)
    if isinstance(result, Exception):
        response = jsonify(str(result))
        response.status_code = 500
        return response
    response = jsonify('File description updated successfully')
    response.status_code = 200
    return response

@BLOBSTORAGE_BLUEPRINT.route('/eduhub/files/<int:file_id>', methods=['DELETE']) 
def delete_blob(file_id):
    result = blobstorage.delete_blob(file_id)
    if isinstance(result, Exception):
        response = jsonify(str(result))
        response.status_code = 500
        return response
    response = jsonify('File deleted successfully')
    response.status_code = 200
    return response