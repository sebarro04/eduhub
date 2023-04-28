from Database import Database

def current_enrollment_time(student_enrollment_period_id) -> int | Exception:
    try:
        db = Database()
        query = '''SELECT DATEPART(hour, start_datetime)
                FROM student_enrollment_period
                INNER JOIN enrollment_period ON student_enrollment_period.enrollment_period_id = enrollment_period.id 
                WHERE student_enrollment_period.id =?'''
        db.cursor.execute(query, student_enrollment_period_id)
        result = db.cursor.fetchone()[0]  # obtiene el resultado de la consulta
        db.cursor.commit()
        return result  # devuelve el resultado de la consulta
    except Exception as ex:
        print(ex)
        return ex
    
def read_all_enrollments_by_student_id(studentId: str) -> list | Exception:
    try:
        db = Database()
        query = '''SELECT enrollment_period.name, enrollment_period.start_datetime, enrollment_period.end_datetime, enrollment_period.is_open, enrollment_period.period_id
                FROM student_enrollment_period 
                INNER JOIN enrollment_period ON student_enrollment_period.enrollment_period_id = enrollment_period.id AND enrollment_period.is_open = 1
                WHERE student_enrollment_period.student_id =?'''
        db.cursor.execute(query,studentId)
        result = db.cursor.fetchall()
        return db.jsonify_query_result_headers(result)
    except Exception as ex:
        print(ex)
        return ex
    

def calculate_enrollment_hour_by_student_id(student_id : str,student_enrollment_period_id: str) -> list | Exception:
    try:
        average=calculate_period_average(student_id)
        start_enrrollment=current_enrollment_time(student_enrollment_period_id)
        enrollment_time=start_enrrollment   
        if (average>90 and average<=95):
            enrollment_time += 1
        elif(average>85 and average<=90):
            enrollment_time += 2 
        elif (average>80 and average<=85):
            enrollment_time += 3
        elif(average>75 and average<=80):
            enrollment_time += 4 
        elif (average>=70 and average<=75):
            enrollment_time += 5
        return enrollment_time  # devuelve el resultado de la consulta
    except Exception as ex:
        print(ex)
        return ex
    
def calculate_period_average(studentID: str) -> int | Exception:
    try:
        db = Database()
        query = '''
                SELECT TOP 1 (SUM(gr.grade * c.credits) / SUM(c.credits)) AS period_student_average
                FROM grade_record gr 
                INNER JOIN course c ON gr.course_id = c.id
                INNER JOIN period p ON gr.period_id = p.id
                WHERE gr.student_id = ?
                GROUP BY p.end_date
                ORDER BY p.end_date DESC
                '''
        db.cursor.execute(query, (studentID))
        result = db.cursor.fetchone()[0]  # obtiene el resultado de la consulta
        db.cursor.commit()
        return result  # devuelve el resultado de la consulta
    except Exception as ex:
        print(ex)
        return ex
    
def read_all_enrollment_available_courses_by_student_id(studentID: str) -> list | Exception:
    try:
        db = Database()
        query = '''
                SELECT c.id, c.name
                FROM curriculum_course cc
                INNER JOIN course c ON cc.course_id = c.id
                WHERE cc.curriculum_id = (
                    SELECT sc.curriculum_id
                    FROM student_curriculum sc
                    WHERE sc.student_id = ?
                )
                AND c.id NOT IN (
                    SELECT ccp.course_id
                    FROM curriculum_course_prerequisite ccp
                )
                AND c.id NOT IN (
                    SELECT gr.course_id
                    FROM grade_record gr
                    WHERE gr.student_id = ? AND gr.grade >= 65.7
                )
                UNION
                SELECT c.id, c.name 
                FROM course c
                WHERE c.id IN ((SELECT ccp.course_id
                            FROM curriculum_course_prerequisite ccp
                            INNER JOIN course c ON ccp.course_prerequisite_id = c.id
                            INNER JOIN grade_record gr ON c.id = gr.course_id
                            WHERE gr.student_id = ? AND gr.grade >= 65))
                            AND c.id NOT IN (
                                SELECT gr.course_id
                                FROM grade_record gr
                                WHERE gr.student_id = ? AND gr.grade >= 65.7)
                '''
        db.cursor.execute(query,(studentID, studentID, studentID, studentID))
        result = db.cursor.fetchall()
        return db.jsonify_query_result_headers(result)
    except Exception as ex:
        print(ex)
        return ex
    
if __name__ == '__main__':
    print(calculate_period_average(2021023226))