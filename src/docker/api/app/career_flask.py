from flask import Blueprint, jsonify, request
import career

CAREER_BLUEPRINT = Blueprint("CAREER_BLUEPRINT", __name__)

@CAREER_BLUEPRINT.route('/eduhub/careers', methods = ['POST'])
def createCourse():
    json = request.json
    name = json['name']
    schoolId = json['school_id']
    description = json['description']
    result = career.createCareer(name, schoolId, description)    
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response

@CAREER_BLUEPRINT.route('/eduhub/careers', methods = ['GET'])
def readAllCareers():
    result = career.readAllCareers()    
    if isinstance(result, Exception):
        return 'Error with the database', 500   
    response = jsonify(result)
    response.status_code = 200
    return response

@CAREER_BLUEPRINT.route('/eduhub/careers/<id>', methods = ['PUT'])
def updateCareer(id):
    json = request.json
    name = json['name']
    schoolId = json['school_id']
    description = json['description']
    result = career.updateCareer(id, name, schoolId, description)    
    if isinstance(result, Exception):
        return 'Error with the database', 500  
    response = jsonify(result) 
    response.status_code = 200
    return response

@CAREER_BLUEPRINT.route('/eduhub/careers/<id>', methods = ['DELETE'])
def deleteCourse(id):
    result = career.deleteCareer(id)    
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response
