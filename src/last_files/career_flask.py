from flask import Blueprint, jsonify, request
import career

CAREER_BLUEPRINT = Blueprint("CAREER_BLUEPRINT", __name__)

@CAREER_BLUEPRINT.route('/eduhub/careers', methods = ['post'])
def create_course():
    json = request.json
    name = json['name']
    school_id = json['school_id']
    description = json['description']
    result = career.create_career(name, school_id, description)    
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response

@CAREER_BLUEPRINT.route('/eduhub/careers', methods = ['get'])
def read_all_careers():
    result = career.read_all_careers()    
    if isinstance(result, Exception):
        return 'Error with the database', 500   
    response = jsonify(result)
    response.status_code = 200
    return response

@CAREER_BLUEPRINT.route('/eduhub/careers/<id>', methods = ['put'])
def update_career(id):
    json = request.json
    name = json['name']
    school_id = json['school_id']
    description = json['description']
    result = career.update_career(id, name, school_id, description)    
    if isinstance(result, Exception):
        return 'Error with the database', 500  
    response = jsonify(result) 
    response.status_code = 200
    return response

@CAREER_BLUEPRINT.route('/eduhub/careers/<id>', methods = ['delete'])
def delete_course(id):
    result = career.delete_career(id)    
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response
