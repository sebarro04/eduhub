from Database import Database

def create_school(id: str, name: str, email: str, phone_number: str, director_id: str) -> bool | Exception:
    try:
        db = Database()
        query = '''
                INSERT INTO school (id, name, email, phone_number, director_id) 
                VALUES (?, ?, ?, ?, ?)
                '''
        db.cursor.execute(query, id, name, email, phone_number, director_id)
        db.cursor.commit()
        return True
    except Exception as ex:
        print(ex)
        return ex
    
def read_all_schools() -> list | Exception:
    try:
        db = Database()
        query = 'SELECT id, name, email, phone_number, director_id FROM school'
        db.cursor.execute(query)
        row_headers = [x[0] for x in db.cursor.description]
        result = db.cursor.fetchall()
        json_data = []
        for row in result:
            json_data.append(dict(zip(row_headers, row)))
        return json_data
    except Exception as ex:
        print(ex)
        return ex
    
def update_school(id: str, name: str | None, email: str | None, phone_number: str | None, director_id: str | None) -> bool | Exception:
    try:
        db = Database()
        query = '''
                UPDATE school
                SET name = COALESCE(?, name),
                    email = COALESCE(?, email),
                    phone_number = COALESCE(?, phone_number),
                    director_id = COALESCE(?, director_id)
                WHERE id = ?
                '''
        db.cursor.execute(query, name, email, phone_number, director_id, id)
        db.cursor.commit()
        return True
    except Exception as ex:
        print(ex)
        return ex
    
def delete_school(id: str) -> bool | Exception:
    try:
        db = Database()
        query = 'DELETE school WHERE id = ?'
        db.cursor.execute(query, id)
        db.cursor.commit()
        return True
    except Exception as ex:
        print(ex)
        return ex

if __name__ == '__main__':
    print('school module')
