from flask import Blueprint, jsonify, request
import curriculum

CURRICULUM_BLUEPRINT = Blueprint('CURRICULUM_BLUEPRINT', __name__)

@CURRICULUM_BLUEPRINT.route('/eduhub/curriculum-statuses', methods = ['GET'])
def read_all_curriculum_statuses():
    result = curriculum.read_all_curriculum_statuses()    
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response

@CURRICULUM_BLUEPRINT.route('/eduhub/curriculums', methods = ['POST'])
def createCurriculum():
    json = request.json
    id = json['id']
    curriculum_status_id = json['curriculum_status_id']
    career_id = json['career_id']
    creation_date = json['creation_date']
    activation_date = json['activation_date']
    finish_date = json['finish_date']
    result = curriculum.create_curriculum(id, curriculum_status_id, career_id, creation_date, activation_date, finish_date)    
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response

@CURRICULUM_BLUEPRINT.route('/eduhub/curriculums', methods = ['GET'])
def read_all_curriculums():
    result = curriculum.read_all_curriculums()    
    if isinstance(result, Exception):
        return 'Error with the database', 500   
    response = jsonify(result)
    response.status_code = 200
    return response

@CURRICULUM_BLUEPRINT.route('/eduhub/curriculums/<string:id>', methods = ['PUT'])
def update_curriculum(id):
    json = request.json
    curriculum_status_id = json['curriculum_status_id']
    career_id = json['career_id']
    creation_date = json['creation_date']
    activation_date = json['activation_date']
    finish_date = json['finish_date']
    result = curriculum.update_curriculum(id, curriculum_status_id, career_id, creation_date, activation_date, finish_date)    
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response