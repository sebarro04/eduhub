from flask import Blueprint, jsonify, request
import course 

COURSE_BLUERPRINT = Blueprint('COURSE_BLUERPRINT', __name__)

@COURSE_BLUERPRINT.route('/eduhub/courses', methods = ['POST'])
def createCourse():
    json = request.json
    id = json['id']
    name = json['name']
    periodTypeId = json['period_type_id']
    credits = json['credits']
    schoolId = json['school_id']
    classHoursWeek = json['class_hours_week']
    description = json['description']
    result = course.createCourse(id, name, periodTypeId, credits, schoolId, classHoursWeek, description)    
    if isinstance(result, Exception):
        return 'Error with the database', 500 
    response = jsonify(result)
    response.status_code = 200
    return response

@COURSE_BLUERPRINT.route('/eduhub/courses', methods = ['GET'])
def readAllCourses():
    result = course.readAllCourses()    
    if isinstance(result, Exception):
        return 'Error with the database', 500   
    response = jsonify(result)  
    response.status_code = 200
    return response

@COURSE_BLUERPRINT.route('/eduhub/courses/<id>', methods = ['PUT'])
def updateCourse(id):
    json = request.json
    name = json['name']
    periodTypeId = json['period_type_id']
    credits = json['credits']
    schoolId = json['school_id']
    classHoursWeek = json['class_hours_week']
    description = json['description']
    result = course.updateCourse(id, name, periodTypeId, credits, schoolId, classHoursWeek, description)    
    if isinstance(result, Exception):
        return 'Error with the database', 500 
    response = jsonify(result)
    response.status_code = 200
    return response

@COURSE_BLUERPRINT.route('/eduhub/courses/<id>', methods = ['DELETE'])
def deleteCourse(id):
    result = course.deleteCourse(id)    
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response