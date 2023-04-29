import os  
from flask import Blueprint,Flask, jsonify, request,flash,redirect, url_for, send_from_directory, current_app
import enrollment

ENROLLMENT_BLUEPRINT = Blueprint('ENROLLMENT_BLUEPRINT', __name__)


@ENROLLMENT_BLUEPRINT.route('/eduhub/enrollments/course-classes/<enrollment_period_id>/<course_id>', methods = ['GET'])
def read_all_classes_by_course(enrollment_period_id,course_id):
    result = enrollment.read_all_classes_by_course(enrollment_period_id,course_id)
    if isinstance(result, Exception):
        return 'Error with the database', 500 
    response = jsonify(result)
    response.status_code = 200
    return response

@ENROLLMENT_BLUEPRINT.route('/eduhub/enrollments/start-date/<enrollment_period_id>', methods = ['GET'])
def enrollment_start_date(enrollment_period_id):
    result = enrollment.enrollment_start_date(enrollment_period_id)
    if isinstance(result, Exception):
        return 'Error with the database', 500 
    response = jsonify(result)
    response.status_code = 200
    return response

@ENROLLMENT_BLUEPRINT.route('/eduhub/enrollments/end-date/<enrollment_period_id>', methods = ['GET'])
def enrollment_end_date(enrollment_period_id):
    result = enrollment.enrollment_end_date(enrollment_period_id)
    if isinstance(result, Exception):
        return 'Error with the database', 500 
    response = jsonify(result)
    response.status_code = 200
    return response

@ENROLLMENT_BLUEPRINT.route('/eduhub/enrollments/start-time/<enrollment_period_id>', methods = ['GET'])
def enrollment_start_time(enrollment_period_id):
    result = enrollment.enrollment_start_time(enrollment_period_id)
    if isinstance(result, Exception):
        return 'Error with the database', 500 
    response = jsonify(result)
    response.status_code = 200
    return response

@ENROLLMENT_BLUEPRINT.route('/eduhub/enrollments/end-time/<enrollment_period_id>', methods = ['GET'])
def enrollment_end_time(enrollment_period_id):
    result = enrollment.enrollment_end_time(enrollment_period_id)
    if isinstance(result, Exception):
        return 'Error with the database', 500 
    response = jsonify(result)
    response.status_code = 200
    return response

@ENROLLMENT_BLUEPRINT.route('/eduhub/enrollments/enroll-class/<class_id>/<student_id>', methods = ['POST'])
def enroll_class(class_id,student_id):
    result = enrollment.enroll_class(class_id,student_id)
    if isinstance(result, Exception):
        return 'Error with the database', 500 
    response = jsonify(result)
    response.status_code = 200
    return response

@ENROLLMENT_BLUEPRINT.route('/eduhub/enrollments/unenroll-class/<class_id>/<student_id>', methods = ['DELETE'])
def unenroll_class(class_id,student_id):
    result = enrollment.unenroll_class(class_id,student_id)
    if isinstance(result, Exception):
        return 'Error with the database', 500 
    response = jsonify(result)
    response.status_code = 200
    return response

@ENROLLMENT_BLUEPRINT.route('/eduhub/enrollments/student-hour/<student_id>/<student_enrollment_period_id>', methods = ['GET'])
def calculate_enrollment_hour_by_student_id(student_id,student_enrollment_period_id):
    result = enrollment.calculate_enrollment_hour_by_student_id(student_id,student_enrollment_period_id)
    if isinstance(result, Exception):
        return 'Error with the database', 500 
    response = jsonify(result)
    response.status_code = 200
    return response

@ENROLLMENT_BLUEPRINT.route('/eduhub/enrollments/<student_id>', methods = ['GET'])
def read_all_enrollments_by_student_id(student_id):
    result = enrollment.read_all_enrollments_by_student_id(student_id)    
    if isinstance(result, Exception):
        return 'Error with the database', 500 
    response = jsonify(result)
    response.status_code = 200
    return response

@ENROLLMENT_BLUEPRINT.route('/eduhub/enrollments/available-courses/<student_id>/<period_id>', methods = ['GET'])
def read_all_enrollment_courses_by_student_id(student_id, period_id):
    result = enrollment.read_all_enrollment_available_courses_by_student_id(student_id, period_id)
    if isinstance(result, Exception):
        return 'Error with the database', 500 
    response = jsonify(result)
    response.status_code = 200
    return response

