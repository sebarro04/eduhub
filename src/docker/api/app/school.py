from Database import Database

def createSchool(id: str, name: str, email: str, phoneNumber: str, directorId: str) -> bool | Exception:
    try:
        db = Database()
        query = '''
                INSERT INTO school (id, name, email, phone_number, director_id) 
                VALUES (?, ?, ?, ?, ?)
                '''
        db.cursor.execute(query, id, name, email, phoneNumber, directorId)
        db.cursor.commit()
        return True
    except Exception as ex:
        print(ex)
        return ex
    
def readAllSchools() -> list | Exception:
    try:
        db = Database()
        query = 'SELECT id, name, email, phone_number, director_id FROM school'
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
    
def updateSchool(id: str, name: str | None, email: str | None, phoneNumber: str | None, directorId: str | None) -> bool | Exception:
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
        db.cursor.execute(query, name, email, phoneNumber, directorId, id)
        db.cursor.commit()
        return True
    except Exception as ex:
        print(ex)
        return ex
    
def deleteSchool(id: str) -> bool | Exception:
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
