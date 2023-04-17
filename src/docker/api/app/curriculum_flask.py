from flask import Blueprint, jsonify, request
import curriculum

CURRICULUM_BLUEPRINT = Blueprint('CURRICULUM_BLUEPRINT', __name__)

@CURRICULUM_BLUEPRINT.route('/thunkable/curriculum-statuses', methods = ['GET'])
def readAllCurriculumStatuses():
    result = curriculum.readAllCurriculumStatuses()
    response = jsonify(result)
    if isinstance(result, Exception):
        response.status_code = 500
        return response
    response.status_code = 200
    return response

@CURRICULUM_BLUEPRINT.route('/thunkable/curriculums', methods = ['POST'])
def createCurriculum():
    json = request.json
    id = json['id']
    curriculumStatusId = json['curriculum_status_id']
    careerId = json['career_id']
    creationDate = json['creation_date']
    activationDate = json['activation_date']
    finishDate = json['finish_date']
    result = curriculum.createCurriculum(id, curriculumStatusId, careerId, creationDate, activationDate, finishDate)
    response = jsonify(result)
    if isinstance(result, Exception):
        response.status_code = 500
        return response
    response.status_code = 200
    return response

@CURRICULUM_BLUEPRINT.route('/thunkable/curriculums', methods = ['GET'])
def readAllCurriculums():
    result = curriculum.readAllCurriculums()
    response = jsonify(result)
    if isinstance(result, Exception):
        response.status_code = 500
        return response    
    response.status_code = 200
    return response

@CURRICULUM_BLUEPRINT.route('/thunkable/curriculums/<id>', methods = ['PUT'])
def updateCurriculum(id):
    json = request.json
    curriculumStatusId = json['curriculum_status_id']
    careerId = json['career_id']
    creationDate = json['creation_date']
    activationDate = json['activation_date']
    finishDate = json['finish_date']
    result = curriculum.updateCurriculum(id, curriculumStatusId, careerId, creationDate, activationDate, finishDate)
    response = jsonify(result)
    if isinstance(result, Exception):
        response.status_code = 500
        return response
    response.status_code = 200
    return response