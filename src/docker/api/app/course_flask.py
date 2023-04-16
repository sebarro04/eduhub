from flask import Blueprint, jsonify, request
import course 

COURSE_BLUERPRINT = Blueprint('COURSE_BLUERPRINT', __name__)

@COURSE_BLUERPRINT.route('/thunkable/courses', methods = ['POST'])
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
    response = jsonify(result)
    if isinstance(result, Exception):
        response.status_code = 500
        return response
    response.status_code = 200
    return response

@COURSE_BLUERPRINT.route('/thunkable/courses', methods = ['GET'])
def readAllCourses():
    result = course.readAllCourses()
    response = jsonify(result)
    if isinstance(result, Exception):
        response.status_code = 500
        return response    
    response.status_code = 200
    return response

@COURSE_BLUERPRINT.route('/thunkable/courses/<id>', methods = ['PUT'])
def updateCourse(id):
    json = request.json
    name = json['name']
    periodTypeId = json['period_type_id']
    credits = json['credits']
    schoolId = json['school_id']
    classHoursWeek = json['class_hours_week']
    description = json['description']
    result = course.updateCourse(id, name, periodTypeId, credits, schoolId, classHoursWeek, description)
    response = jsonify(result)
    if isinstance(result, Exception):
        response.status_code = 500
        return response
    response.status_code = 200
    return response

@COURSE_BLUERPRINT.route('/thunkable/courses/<id>', methods = ['DELETE'])
def deleteCourse(id):
    result = course.deleteCourse(id)
    response = jsonify(result)
    if isinstance(result, Exception):
        response.status_code = 500
        return response
    response.status_code = 200
    return response