from flask import Blueprint, jsonify, request
import class_rating

CLASS_RATING_BLUERPRINT = Blueprint('CLASS_RATING_BLUERPRINT', __name__)

@CLASS_RATING_BLUERPRINT.route('/thunkable/classes-ratings', methods = ['POST'])
def createClassRating():
    json = request.json
    classId = json['class_id']
    difficulty = json['difficulty']
    quality = json['quality']
    overallGrade = json['overall_grade']
    comment = json['comment']
    result = class_rating.createClassRating(classId, difficulty, quality, overallGrade, comment)
    response = jsonify(result)
    if isinstance(result, Exception):
        response.status_code = 500
        return response
    response.status_code = 200
    return response

@CLASS_RATING_BLUERPRINT.route('/thunkable/classes-ratings', methods = ['GET'])
def readAllClassesRatings():
    result = class_rating.readAllClassesRatings()
    response = jsonify(result)
    if isinstance(result, Exception):
        response.status_code = 500
        return response
    response.status_code = 200
    return response

@CLASS_RATING_BLUERPRINT.route('/thunkable/class-ratings/<string:course_id>/<string:professor_id>', methods = ['GET'])
def readAllClassRatings(course_id, professor_id):
    result = class_rating.readAllClassRatings(course_id, professor_id)
    response = jsonify(result)
    if isinstance(result, Exception):
        response.status_code = 500
        return response
    response.status_code = 200
    return response