from Database import Database

def create_user_role(user_id: str, role_id: int) -> bool | Exception:
    try:
        db = Database()
        query = 'INSERT INTO user_role (user_id, role_id) VALUES (?, ?)'
        db.cursor.execute(query, user_id, role_id)
        db.cursor.commit()
        return True
    except Exception as ex:
        print(ex)
        return ex
    
def read_user_roles(user_id: str) -> list | Exception:
    try:
        db = Database()
        query = '''
                SELECT role.name as role
                FROM user_role
                INNER JOIN role ON user_role.role_id = role.id
                WHERE user_role.user_id = ?
                '''
        db.cursor.execute(query, user_id)
        result = db.cursor.fetchall()
        return db.jsonify_query_result_headers(result)
    except Exception as ex:
        print(ex)
        return ex
    
def read_roles() -> list | Exception:
    try:
        db = Database()
        query = 'SELECT id, name FROM role ORDER BY id'
        db.cursor.execute(query)
        result = db.cursor.fetchall()
        return db.jsonify_query_result_headers(result)
    except Exception as ex:
        print(ex)
        return ex