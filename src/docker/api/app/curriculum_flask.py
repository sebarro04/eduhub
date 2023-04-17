from flask import Blueprint, jsonify, request
import curriculum

CURRICULUM_BLUEPRINT = Blueprint('CURRICULUM_BLUEPRINT', __name__)

@CURRICULUM_BLUEPRINT.route('/eduhub/curriculum-statuses', methods = ['GET'])
def readAllCurriculumStatuses():
    result = curriculum.readAllCurriculumStatuses()    
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response

@CURRICULUM_BLUEPRINT.route('/eduhub/curriculums', methods = ['POST'])
def createCurriculum():
    json = request.json
    id = json['id']
    curriculumStatusId = json['curriculum_status_id']
    careerId = json['career_id']
    creationDate = json['creation_date']
    activationDate = json['activation_date']
    finishDate = json['finish_date']
    result = curriculum.createCurriculum(id, curriculumStatusId, careerId, creationDate, activationDate, finishDate)    
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response

@CURRICULUM_BLUEPRINT.route('/eduhub/curriculums', methods = ['GET'])
def readAllCurriculums():
    result = curriculum.readAllCurriculums()    
    if isinstance(result, Exception):
        return 'Error with the database', 500   
    response = jsonify(result)
    response.status_code = 200
    return response

@CURRICULUM_BLUEPRINT.route('/eduhub/curriculums/<string:id>', methods = ['PUT'])
def updateCurriculum(id):
    json = request.json
    curriculumStatusId = json['curriculum_status_id']
    careerId = json['career_id']
    creationDate = json['creation_date']
    activationDate = json['activation_date']
    finishDate = json['finish_date']
    result = curriculum.updateCurriculum(id, curriculumStatusId, careerId, creationDate, activationDate, finishDate)    
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response