from flask import Blueprint, jsonify, request
import school

SCHOOL_BLUERPRINT = Blueprint('SCHOOL_BLUERPRINT', __name__)

@SCHOOL_BLUERPRINT.route('/eduhub/schools', methods = ['POST'])
def createSchool():
    json = request.json
    id = json['id']
    name = json['name']
    email = json['email']
    phoneNumber = json['phone_number']
    directorId = json['director_id']
    result = school.createSchool(id, name, email, phoneNumber, directorId)    
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response

@SCHOOL_BLUERPRINT.route('/eduhub/schools', methods = ['GET'])
def readAllSchools():
    result = school.readAllSchools()    
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
    phoneNumber = json['phone_number']
    directorId = json['director_id']
    result = school.updateSchool(id, name, email, phoneNumber, directorId)    
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response

@SCHOOL_BLUERPRINT.route('/eduhub/schools/<id>', methods = ['DELETE'])
def deleteSchool(id):
    result = school.deleteSchool(id)    
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response