from Database import Database

def createCareer(name: str, school_id: str, description: str) -> bool | Exception:
    try:
        db = Database()
        query = '''
                INSERT INTO career (name, school_id, description)
                VALUES (?, ?, ?)
                '''
        db.cursor.execute(query, (name, school_id, description))
        db.cursor.commit()
        return True
    except Exception as ex:
        return str(ex)    

def readAllCareers() -> list | Exception:
    try:
        db = Database()
        query = '''
                SELECT career.id, career.name, school.name AS schoolName, career.description
                FROM career
                INNER JOIN school ON career.school_id = school.id
                '''
        db.cursor.execute(query)
        rowHeaders = [x[0] for x in db.cursor.description]
        result = db.cursor.fetchall()
        jsonData = []
        for row in result:
            jsonData.append(dict(zip(rowHeaders, row)))
        return jsonData
    except Exception as ex:
        return str(ex)    

def updateCareer(id: int, name: str | None, school_id: str | None, description: str | None) -> bool | Exception:
    try:
        db = Database()
        query = '''
                UPDATE career 
                SET name = COALESCE(?, name),
                    school_id = COALESCE(?, school_id),
                    description = COALESCE(?, description)
                WHERE id = ?
                '''  
        db.cursor.execute(query, (name, school_id, description, id))
        db.cursor.commit()
        return True
    except Exception as ex:
        return str(ex)
    
def deleteCareer(id: int) -> bool | Exception:
    try:
        db = Database()
        query = 'DELETE career WHERE id = ?'
        db.cursor.execute(query, id)
        db.cursor.commit()
        return True
    except Exception as ex:
        return str(ex)

if __name__ == '__main__':
    print(readAllCareers())
    print("Module name")