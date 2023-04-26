import os  
from flask import Blueprint,Flask, jsonify, request,flash,redirect, url_for, send_from_directory, current_app
import enrollment

ENROLLMENT_BLUEPRINT = Blueprint('ENROLLMENT_BLUEPRINT', __name__)


@ENROLLMENT_BLUEPRINT.route('/eduhub/enrollment/<student_id>/<student_enrollment_period_id>', methods = ['GET'])
def calculate_enrollment_hour_by_student_id(student_id,student_enrollment_period_id):
    average=80 #enrollment.calculate_student_enrollment_average(student_id)
    start_enrrollment=enrollment.current_enrollment_time(student_enrollment_period_id)
    enrollment_time=start_enrrollment
    
    if (average>90 and average<=95):
        enrollment_time += 1
    elif(average>85 and average<=90):
        enrollment_time += 2 
    elif (average>80 and average<=85):
        enrollment_time += 3
    elif(average>75 and average<=80):
        enrollment_time += 4 
    elif (average>=70 and average<=75):
        enrollment_time += 5
    response = jsonify(enrollment_time)
    response.status_code = 200
    return response

@ENROLLMENT_BLUEPRINT.route('/eduhub/enrollment_load/<student_id>', methods = ['GET'])
def load_enrollment_by_student_id(student_id):
    result = enrollment.load_enrollment_by_student_id(student_id)    
    if isinstance(result, Exception):
        return 'Error with the database', 500 
    response = jsonify(result)
    response.status_code = 200
    return response