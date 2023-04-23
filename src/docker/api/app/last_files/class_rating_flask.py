from flask import Blueprint, jsonify, request
import class_rating

CLASS_RATING_BLUERPRINT = Blueprint('CLASS_RATING_BLUERPRINT', __name__)

@CLASS_RATING_BLUERPRINT.route('/eduhub/classes-ratings', methods = ['POST'])
def create_class_rating():
    json = request.json
    class_id = json['class_id']
    difficulty = json['difficulty']
    quality = json['quality']
    overall_grade = json['overall_grade']
    comment = json['comment']
    result = class_rating.create_class_rating(class_id, difficulty, quality, overall_grade, comment)    
    if isinstance(result, Exception):
        return 'Error with the database', 500 
    response = jsonify(result)
    response.status_code = 200
    return response

@CLASS_RATING_BLUERPRINT.route('/eduhub/classes-ratings', methods = ['GET'])
def read_all_classes_ratings():
    result = class_rating.read_all_classes_ratings()    
    if isinstance(result, Exception):
        return 'Error with the database', 500 
    response = jsonify(result)
    response.status_code = 200
    return response

@CLASS_RATING_BLUERPRINT.route('/eduhub/class-ratings/<string:course_id>/<string:professor_id>', methods = ['GET'])
def read_all_class_ratings(course_id, professor_id):
    result = class_rating.read_all_class_ratings(course_id, professor_id)    
    if isinstance(result, Exception):
        return 'Error with the database', 500 
    response = jsonify(result)
    response.status_code = 200
    return response