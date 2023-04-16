from flask import Blueprint, jsonify, request
import period

PERIOD_BLUERPRINT = Blueprint('PERIOD_BLUERPRINT', __name__)

@PERIOD_BLUERPRINT.route('/thunkable/period-statuses', methods = ['GET'])
def readAllPeriodStatuses():
    result = period.readAllPeriodStatuses()
    response = jsonify(result)
    if isinstance(result, Exception):
        response.status_code = 500
        return response
    response.status_code = 200
    return response

@PERIOD_BLUERPRINT.route('/thunkable/period-types', methods = ['GET'])
def readAllPeriodTypes():
    result = period.readAllPeriodTypes()
    response = jsonify(result)
    if isinstance(result, Exception):
        response.status_code= 500
        return response
    response.status_code = 200
    return response


@PERIOD_BLUERPRINT.route('/thunkable/periods', methods = ['POST'])
def createPeriod():
    json = request.json
    periodTypeId = json['period_type_id']
    startDate = json['start_date']
    endDate = json['end_date']
    periodStatusId = json['period_status_id']
    result = period.createPeriod(periodTypeId, startDate, endDate, periodStatusId)
    response = jsonify(result)
    if isinstance(result, Exception):
        response.status_code = 500
        return response
    response.status_code = 200
    return response

@PERIOD_BLUERPRINT.route('/thunkable/periods', methods = ['GET'])
def readAllPeriods():
    result = period.readAllPeriods()
    response = jsonify(result)
    if isinstance(result, Exception):
        response.status_code = 500
        return response    
    response.status_code = 200
    return response

@PERIOD_BLUERPRINT.route('/thunkable/periods/<id>', methods = ['PUT'])
def updatePeriod(id):
    json = request.json
    periodTypeId = json['period_type_id']
    startDate = json['start_date']
    endDate = json['end_date']
    periodStatusId = json['period_status_id']
    result = period.updatePeriod(id, periodTypeId, startDate, endDate, periodStatusId)
    response = jsonify(result)
    if isinstance(result, Exception):
        response.status_code = 500
        return response
    response.status_code = 200
    return response

@PERIOD_BLUERPRINT.route('/thunkable/periods/<id>', methods = ['DELETE'])
def deletePeriod(id):
    result = period.deletePeriod(id)
    response = jsonify(result)
    if isinstance(result, Exception):
        response.status_code = 500
        return response
    response.status_code = 200
    return response