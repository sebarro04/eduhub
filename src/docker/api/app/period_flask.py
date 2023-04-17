from flask import Blueprint, jsonify, request
import period

PERIOD_BLUERPRINT = Blueprint('PERIOD_BLUERPRINT', __name__)

@PERIOD_BLUERPRINT.route('/eduhub/period-statuses', methods = ['GET'])
def readAllPeriodStatuses():
    result = period.readAllPeriodStatuses()    
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response

@PERIOD_BLUERPRINT.route('/eduhub/period-types', methods = ['GET'])
def readAllPeriodTypes():
    result = period.readAllPeriodTypes()    
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response


@PERIOD_BLUERPRINT.route('/eduhub/periods', methods = ['POST'])
def createPeriod():
    json = request.json
    periodTypeId = json['period_type_id']
    startDate = json['start_date']
    endDate = json['end_date']
    periodStatusId = json['period_status_id']
    result = period.createPeriod(periodTypeId, startDate, endDate, periodStatusId)    
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response

@PERIOD_BLUERPRINT.route('/eduhub/periods', methods = ['GET'])
def readAllPeriods():
    result = period.readAllPeriods()    
    if isinstance(result, Exception):
        return 'Error with the database', 500   
    response = jsonify(result)
    response.status_code = 200
    return response

@PERIOD_BLUERPRINT.route('/eduhub/periods/<id>', methods = ['PUT'])
def updatePeriod(id):
    json = request.json
    periodTypeId = json['period_type_id']
    startDate = json['start_date']
    endDate = json['end_date']
    periodStatusId = json['period_status_id']
    result = period.updatePeriod(id, periodTypeId, startDate, endDate, periodStatusId)    
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response

@PERIOD_BLUERPRINT.route('/eduhub/periods/<id>', methods = ['DELETE'])
def deletePeriod(id):
    result = period.deletePeriod(id)    
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response