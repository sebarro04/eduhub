from flask import Blueprint, jsonify, request
import course 

COURSE_BLUERPRINT = Blueprint('COURSE_BLUERPRINT', __name__)

@COURSE_BLUERPRINT.route('/eduhub/courses', methods = ['POST'])
def create_course():
    json = request.json
    id = json['id']
    name = json['name']
    period_type_id = json['period_type_id']
    credits = json['credits']
    school_id = json['school_id']
    class_hours_week = json['class_hours_week']
    description = json['description']
    result = course.create_course(id, name, period_type_id, credits, school_id, class_hours_week, description)    
    if isinstance(result, Exception):
        return 'Error with the database', 500 
    response = jsonify(result)
    response.status_code = 200
    return response

@COURSE_BLUERPRINT.route('/eduhub/courses', methods = ['GET'])
def read_all_courses():
    result = course.read_all_courses()    
    if isinstance(result, Exception):
        return 'Error with the database', 500   
    response = jsonify(result)  
    response.status_code = 200
    return response

@COURSE_BLUERPRINT.route('/eduhub/courses/<id>', methods = ['PUT'])
def update_course(id):
    json = request.json
    name = json['name']
    period_type_id = json['period_type_id']
    credits = json['credits']
    school_id = json['school_id']
    class_hours_week = json['class_hours_week']
    description = json['description']
    result = course.update_course(id, name, period_type_id, credits, school_id, class_hours_week, description)    
    if isinstance(result, Exception):
        return 'Error with the database', 500 
    response = jsonify(result)
    response.status_code = 200
    return response

@COURSE_BLUERPRINT.route('/eduhub/courses/<id>', methods = ['DELETE'])
def delete_course(id):
    result = course.delete_course(id)    
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response