from flask import Blueprint, jsonify, request
import school

SCHOOL_BLUERPRINT = Blueprint('SCHOOL_BLUERPRINT', __name__)

@SCHOOL_BLUERPRINT.route('/eduhub/schools', methods = ['POST'])
def create_school():
    json = request.json
    id = json['id']
    name = json['name']
    email = json['email']
    phone_number = json['phone_number']
    director_id = json['director_id']
    result = school.create_school(id, name, email, phone_number, director_id)    
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response

@SCHOOL_BLUERPRINT.route('/eduhub/schools', methods = ['GET'])
def read_all_schools():
    result = school.read_all_schools()    
    if isinstance(result, Exception):
        return 'Error with the database', 500   
    response = jsonify(result)
    response.status_code = 200
    return response

@SCHOOL_BLUERPRINT.route('/eduhub/schools/<id>', methods = ['PUT'])
def updateSchool(id):
    json = request.json
    name = json['name']
    email = json['email']
    phone_number = json['phone_number']
    director_id = json['director_id']
    result = school.update_school(id, name, email, phone_number, director_id)    
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response

@SCHOOL_BLUERPRINT.route('/eduhub/schools/<id>', methods = ['DELETE'])
def delete_school(id):
    result = school.delete_school(id)    
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response