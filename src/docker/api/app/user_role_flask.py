from flask import Blueprint, jsonify, request
import user_role

USER_ROLE_BLUEPRINT = Blueprint('USER_ROLE_BLUEPRINT', __name__)

@USER_ROLE_BLUEPRINT.route('/eduhub/users-roles', methods = ['POST'])
def create_user_role():
    if 'user_id' not in request.json:
        return 'Missing user_id', 400
    if 'role_id' not in request.json:
        return 'Missing role_id', 400
    user_id = request.json['user_id']
    role_id = request.json['role_id']
    result = user_role.create_user_role(user_id, role_id)
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response

@USER_ROLE_BLUEPRINT.route('/eduhub/users-roles/<string:user_id>', methods = ['GET'])
def read_user_roles(user_id):
    result = user_role.read_user_roles(user_id)
    if isinstance(result, Exception):
        return 'Error with the database', 500
    response = jsonify(result)
    response.status_code = 200
    return response