from Database import Database

def create_class_rating(class_id: int, difficulty: int, quality: int, overall_grade: int, comment: str | None) -> bool | Exception:
    try:
        db = Database()
        query = '''
                INSERT INTO class_rating (class_id, difficulty, quality, overall_grade, comment) 
                VALUES (?, ?, ?, ?, ?)
                '''
        db.cursor.execute(query, class_id, difficulty, quality, overall_grade, comment)
        db.cursor.commit()
        return True
    except Exception as ex:
        print(ex)
        return ex
    
def read_all_classes_ratings() -> list | Exception:
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
        row_headers = [x[0] for x in db.cursor.description]
        result = db.cursor.fetchall()
        json_data = []
        for row in result:
            json_data.append(dict(zip(row_headers, row)))
        return json_data
    except Exception as ex:
        print(ex)
        return ex
    
def read_all_class_ratings(course_id: str, professor_id: str) -> list | Exception:
    try:
        db = Database()
        query = '''
                SELECT difficulty, quality, overall_grade, comment
                FROM class_rating
                INNER JOIN class ON class_rating.class_id = class.id
                INNER JOIN course ON class.course_id = course.id
                WHERE course.id = ?
                ABD class.professor_id = ?
                '''
        db.cursor.execute(query, course_id, professor_id)
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
    print('class_rating module')