from Database import Database

def createClassRating(classId: int, difficulty: int, quality: int, overallGrade: int, comment: str | None) -> bool | Exception:
    try:
        db = Database()
        query = '''
                INSERT INTO class_rating (class_id, difficulty, quality, overall_grade, comment) 
                VALUES (?, ?, ?, ?, ?)
                '''
        db.cursor.execute(query, classId, difficulty, quality, overallGrade, comment)
        db.cursor.commit()
        return True
    except Exception as ex:
        return str(ex)
    
def readAllClassesRatings() -> list | Exception:
    try:
        db = Database()
        query = '''
                SELECT class_rating.id, course.name, class.professor_id, difficulty, quality, overall_grade, comment 
                FROM class_rating
                INNER JOIN class ON class_rating.class_id = class.id
                INNER JOIN course ON class.course_id = course.id
                ORDER BY course.name, class.professor_id
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
    
def readAllClassRatings(courseId: str, professorId: str) -> list | Exception:
    try:
        db = Database()
        query = '''
                SELECT difficulty, quality, overall_grade, comment
                FROM class_rating
                INNER JOIN class ON class_rating.class_id = class.id
                INNER JOIN course ON class.course_id = course.id
                WHERE course.id = ?
                AND class.professor_id = ?
                '''
        db.cursor.execute(query, courseId, professorId)
        rowHeaders = [x[0] for x in db.cursor.description]
        result = db.cursor.fetchall()
        jsonData = []
        for row in result:
            jsonData.append(dict(zip(rowHeaders, row)))
        return jsonData
    except Exception as ex:
        return str(ex)
    
if __name__ == '__main__':
    print('class_rating module')