from flask import Blueprint, jsonify, request
import period

PERIOD_BLUERPRINT = Blueprint('PERIOD_BLUERPRINT', __name__)

@PERIOD_BLUERPRINT.route('/eduhub/period-statuses', methods = ['GET'])
def read_all_period_statuses():
    result = period.read_all_period_statuses()    
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response

@PERIOD_BLUERPRINT.route('/eduhub/period-types', methods = ['GET'])
def read_all_period_types():
    result = period.read_all_period_types()    
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response


@PERIOD_BLUERPRINT.route('/eduhub/periods', methods = ['POST'])
def create_period():
    json = request.json
    period_type_id = json['period_type_id']
    start_date = json['start_date']
    end_date = json['end_date']
    period_status_id = json['period_status_id']
    result = period.create_period(period_type_id, start_date, end_date, period_status_id)    
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response

@PERIOD_BLUERPRINT.route('/eduhub/periods', methods = ['GET'])
def read_all_periods():
    result = period.read_all_periods()    
    if isinstance(result, Exception):
        return 'Error with the database', 500   
    response = jsonify(result)
    response.status_code = 200
    return response

@PERIOD_BLUERPRINT.route('/eduhub/periods/<id>', methods = ['PUT'])
def update_period(id):
    json = request.json
    period_type_id = json['period_type_id']
    start_date = json['start_date']
    end_date = json['end_date']
    period_status_id = json['period_status_id']
    result = period.update_period(id, period_type_id, start_date, end_date, period_status_id)    
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response

@PERIOD_BLUERPRINT.route('/eduhub/periods/<id>', methods = ['DELETE'])
def delete_period(id):
    result = period.delete_period(id)    
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response