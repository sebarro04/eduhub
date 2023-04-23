from Database import Database

def create_curriculum(id: str, curriculum_status_id: int, career_id: int, creation_date: str, activation_date: str, finish_date: str) -> bool | Exception:
    try:
        db = Database()
        query = '''
                INSERT INTO curriculum (id, curriculum_status_id, career_id, creation_date, activation_date, finish_date)
                VALUES (?, ?, ?, ?, ?, ?)
                '''
        db.cursor.execute(query, (id, curriculum_status_id, career_id, creation_date, activation_date, finish_date))
        db.cursor.commit()
        return True
    except Exception as ex:
        print(ex)
        return ex

def read_all_curriculums() -> list | Exception:
    try:
        db = Database()
        query = '''
                SELECT curriculum.id, curriculum_status.name AS estado, career.name, CONVERT(VARCHAR, curriculum.creation_date) AS creationDate, CONVERT(VARCHAR, curriculum.activation_date) AS activationDate, CONVERT(VARCHAR, curriculum.finish_date) AS finishDate
                FROM curriculum
                INNER JOIN curriculum_status ON curriculum.curriculum_status_id = curriculum_status.id
                INNER JOIN career ON curriculum.career_id = career.id
                '''
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

def update_curriculum(id: str, curriculum_status_id: int | None, career_id: int | None, creation_date: str | None, activation_date: str | None, finish_date: str | None) -> bool | Exception:
    try:
        db = Database()
        query = '''
                UPDATE curriculum
                SET curriculum_status_id = COALESCE(?, curriculum_status_id),
                    career_id = COALESCE(?, career_id),
                    creation_date = COALESCE(?, creation_date),
                    activation_date = COALESCE(?, activation_date),
                    finish_date = COALESCE(?, finish_date)
                WHERE id = ?
                '''
        db.cursor.execute(query, (id, curriculum_status_id, career_id, creation_date, activation_date, finish_date))
        db.cursor.commit()
        return True
    except Exception as ex:
        print(ex)
        return ex
    
def delete_curriculum(id: str) -> bool | Exception:
    try:
        db = Database()
        query = 'DELETE curriculum WHERE id = ?'
        db.cursor.execute(query, id)
        db.cursor.commit()
        return True
    except Exception as ex:
        print(ex)
        return ex
    
def read_all_curriculum_statuses() -> list | Exception:
    try:
        db = Database()
        query = 'SELECT id, name FROM curriculum_status'
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

if __name__ == '__main__':
    print('curriculum module')