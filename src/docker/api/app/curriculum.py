from Database import Database

def createCurriculum(id: str, curriculumStatusId: int, careerId: int, creationDate: str, activationDate: str, finishDate: str) -> bool | Exception:
    try:
        db = Database()
        query = '''
                INSERT INTO curriculum (id, curriculum_status_id, career_id, creation_date, activation_date, finish_date)
                VALUES (?, ?, ?, ?, ?, ?)
                '''
        db.cursor.execute(query, (id, curriculumStatusId, careerId, creationDate, activationDate, finishDate))
        db.cursor.commit()
        return True
    except Exception as ex:
        print(ex)
        return ex

def readAllCurriculums() -> list | Exception:
    try:
        db = Database()
        query = '''
                SELECT curriculum.id, curriculum_status.name AS estado, career.name, CONVERT(VARCHAR, curriculum.creation_date) AS creationDate, CONVERT(VARCHAR, curriculum.activation_date) AS activationDate, CONVERT(VARCHAR, curriculum.finish_date) AS finishDate
                FROM curriculum
                INNER JOIN curriculum_status ON curriculum.curriculum_status_id = curriculum_status.id
                INNER JOIN career ON curriculum.career_id = career.id
                '''
        db.cursor.execute(query)
        rowHeaders = [x[0] for x in db.cursor.description]
        result = db.cursor.fetchall()
        jsonData = []
        for row in result:
            jsonData.append(dict(zip(rowHeaders, row)))
        return jsonData
    except Exception as ex:
        print(ex)
        return ex

def updateCurriculum(id: str, curriculumStatusId: int | None, careerId: int | None, creationDate: str | None, activationDate: str | None, finishDate: str | None) -> bool | Exception:
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
        db.cursor.execute(query, (id, curriculumStatusId, careerId, creationDate, activationDate, finishDate))
        db.cursor.commit()
        return True
    except Exception as ex:
        print(ex)
        return ex
    
def deleteCurriculum(id: str) -> bool | Exception:
    try:
        db = Database()
        query = 'DELETE curriculum WHERE id = ?'
        db.cursor.execute(query, id)
        db.cursor.commit()
        return True
    except Exception as ex:
        print(ex)
        return ex
    
def readAllCurriculumStatuses() -> list | Exception:
    try:
        db = Database()
        query = 'SELECT id, name FROM curriculum_status'
        db.cursor.execute(query)
        rowHeaders = [x[0] for x in db.cursor.description]
        result = db.cursor.fetchall()
        jsonData = []
        for row in result:
            jsonData.append(dict(zip(rowHeaders, row)))
        return jsonData
    except Exception as ex:
        print(ex)
        return ex

if __name__ == '__main__':
    #print(createCurriculum("2004", 2, 1, "2023/04/25", "2023/04/27", "2023/04/29"))
    print(readAllCurriculumStatuses())
    print('period module')