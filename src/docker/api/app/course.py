from Database import Database

def createCourse(id: str, name: str, period_type_id: int, credits: int, school_id: str, class_hours_week: int, description: str) -> bool | Exception:
    try:
        db = Database()
        query = '''
                INSERT INTO course (id, name, period_type_id, credits, school_id, class_hours_week, description)
                VALUES (?, ?, ?, ?, ?, ?, ?)
                '''
        db.cursor.execute(id, name, period_type_id, credits, school_id, class_hours_week, description)
        db.cursor.commit()
        return True
    except Exception as ex:
        return ex
      
def readAllCourses() -> list | Exception:
    try:
        db = Database()
        query = '''
                SELECT course.id, course.name, period_type.name AS period_type, course.credits, school.id AS school_id, course.class_hours_week, course.description
                FROM course 
                INNER JOIN period_type ON period.period_type_id = period_type.id
                INNER JOIN school ON course.school_id = school.id
                '''
        db.cursor.execute(query)
        rowHeaders = [x[0] for x in db.cursor.description]
        result = db.cursor.fetchall()
        jsonData = []
        for row in result:
            jsonData.append(dict(zip(rowHeaders, row)))
        return jsonData
    except Exception as ex:
        return ex
    
def updatePeriod(id: int, periodTypeId: int | None, startDate: str | None, endDate: str | None, periodStatusId: int | None) -> bool | Exception:
    try:
        db = Database()
        query = '''
                UPDATE period
                SET period_type_id = COALESCE(?, period_type_id),
                    start_date = COALESCE(?, start_date),
                    end_date = COALESCE(?, end_date),
                    period_status_id = COALESCE(?, period_status_id)
                WHERE id = ?
                '''
        db.cursor.execute(query, periodTypeId, startDate, endDate, periodStatusId, id)
        db.cursor.commit()
        return True
    except Exception as ex:
        return ex
    
def deletePeriod(id: int) -> bool | Exception:
    try:
        db = Database()
        query = 'DELETE period WHERE id = ?'
        db.cursor.execute(query, id)
        db.cursor.commit()
        return True
    except Exception as ex:
        return ex

if __name__ == '__main__':
    print('period module')
