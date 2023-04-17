from flask import Blueprint, jsonify, request
import career

CAREER_BLUEPRINT = Blueprint("CAREER_BLUEPRINT", __name__)

@CAREER_BLUEPRINT.route('/thunkable/careers', methods = ['POST'])
def createCourse():
    json = request.json
    name = json['name']
    schoolId = json['school_id']
    description = json['description']
    result = career.createCareer(name, schoolId, description)
    response = jsonify(result)
    if isinstance(result, Exception):
        response.status_code = 500
        return response
    response.status_code = 200
    return response

@CAREER_BLUEPRINT.route('/thunkable/careers', methods = ['GET'])
def readAllCareers():
    result = career.readAllCareers()
    response = jsonify(result)
    if isinstance(result, Exception):
        response.status_code = 500
        return response    
    response.status_code = 200
    return response

@CAREER_BLUEPRINT.route('/thunkable/careers/<id>', methods = ['PUT'])
def updateCareer(id):
    json = request.json
    name = json['name']
    schoolId = json['school_id']
    description = json['description']
    result = career.updateCareer(id, name, schoolId, description)
    response = jsonify(result)
    if isinstance(result, Exception):
        response.status_code = 500
        return response    
    response.status_code = 200
    return response

@CAREER_BLUEPRINT.route('/thunkable/careers/<id>', methods = ['DELETE'])
def deleteCourse(id):
    result = career.deleteCareer(id)
    response = jsonify(result)
    if isinstance(result, Exception):
        response.status_code = 500
        return response
    response.status_code = 200
    return response
