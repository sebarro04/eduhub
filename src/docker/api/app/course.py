from Database import Database

def create_course(id: str, name: str, period_type_id: int, credits: int, school_id: str, class_hours_week: int, description: str) -> bool | Exception:
    try:
        db = Database()
        query = '''
                INSERT INTO course (id, name, period_type_id, credits, school_id, class_hours_week, description)
                VALUES (?, ?, ?, ?, ?, ?, ?)
                '''
        db.cursor.execute(query, id, name, period_type_id, credits, school_id, class_hours_week, description)
        db.cursor.commit()
        return True
    except Exception as ex:
        print(ex)
        return ex
      
def read_all_courses() -> list | Exception:
    try:
        db = Database()
        query = '''
                SELECT course.id, course.name, period_type.name AS period_type, course.credits, school.name AS school, course.class_hours_week, course.description
                FROM course 
                INNER JOIN period_type ON course.period_type_id = period_type.id
                INNER JOIN school ON course.school_id = school.id
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
    
def update_course(id: str, name: str | None, period_type_id: int | None, credits: int | None, school_id: str | None, class_hours_week: int | None, description: str | None) -> bool | Exception:
    try:
        db = Database()
        query = '''
                UPDATE course
                SET name = COALESCE(?, name),
                    period_type_id = COALESCE(?, period_type_id),
                    credits = COALESCE(?, credits),
                    school_id = COALESCE(?, school_id),
                    class_hours_week = COALESCE(?, class_hours_week),
                    description = COALESCE(?, description)
                WHERE id = ?
                '''
        db.cursor.execute(query, (name, period_type_id, credits, school_id, class_hours_week, description, id))
        db.cursor.commit()
        return True
    except Exception as ex:
        print(ex)
        return ex
    
def delete_course(id: str) -> bool | Exception:
    try:
        db = Database()
        query = 'DELETE course WHERE id = ?'
        db.cursor.execute(query, id)
        db.cursor.commit()
        return True
    except Exception as ex:
        print(ex)
        return ex

if __name__ == '__main__':
    #Cursos en la base
    #createCourse("5821", "Requerimientos de Software", 2, 4, "IC", 4, "En este curso se introduce al estudiante en los procesos involucrados en obtener, analizar, especificar, validar y administrar requerimientos de software")
    print("course name")