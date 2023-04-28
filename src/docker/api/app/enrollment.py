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
    

    

def check_schedule_clash(new_class_id: str,studentId: str) -> list | Exception:
    try:
        db = Database()
        query = '''DECLARE @new_class_start_time TIME
                    DECLARE @new_class_end_time TIME
                    DECLARE @new_class_day_id INT

                    SELECT @new_class_start_time=schedule.start_time, @new_class_end_time=schedule.end_time, @new_class_day_id=schedule.day_id
                    FROM class
                    INNER JOIN schedule ON class.id=schedule.class_id
                    WHERE class.id=?

                    SELECT student_class.id, class.course_id
                    FROM student_class
                    INNER JOIN class ON student_class.class_id = class.id
                    INNER JOIN schedule ON class.id = schedule.class_id
                    INNER JOIN enrollment_period ON class.period_id = enrollment_period.period_id
                    WHERE student_class.student_id = ?
                    AND schedule.day_id = @new_class_day_id
                    AND ((schedule.start_time >= @new_class_start_time AND schedule.start_time < @new_class_end_time)
                        OR (schedule.end_time > @new_class_start_time AND schedule.end_time <= @new_class_end_time)
                        OR (schedule.start_time <= @new_class_start_time AND schedule.end_time >= @new_class_end_time))
                    AND enrollment_period.is_open = 1'''
        db.cursor.execute(query,new_class_id,studentId)
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
    
def enroll_class(class_id: str,studentId: str) -> bool | Exception:
    try:
        schedule_clash=check_schedule_clash(class_id,studentId) 
        spaces=space_available_in_class(class_id)
        if (schedule_clash==[] and spaces==True):
            db = Database()
            query = '''INSERT INTO student_class (student_id,class_id)
                        VALUES (?,?)'''
            query2 = '''UPDATE class
                        SET max_student_capacity = max_student_capacity-1
                        WHERE class.id=?;'''
            db.cursor.execute(query,studentId,class_id)
            db.cursor.execute(query2,class_id)
            db.cursor.commit()
            return True  # devuelve el resultado de la consulta
        else:
            return False
    except Exception as ex:
        print(ex)
        return ex
    
def unenroll_class(class_id: str,studentId: str) -> bool | Exception:
    try:
        db = Database()
        query = '''DELETE FROM student_class WHERE student_class.class_id = ? AND student_class.student_id=?'''
        query2 = '''UPDATE class
                        SET max_student_capacity = max_student_capacity+1
                        WHERE class.id=?;'''
        db.cursor.execute(query, class_id,studentId)
        db.cursor.execute(query2,class_id)
        db.cursor.commit()
        return True
    except Exception as ex:
        print(ex)
        return ex
    
def space_available_in_class(class_id: str) -> bool | Exception:
    try:
        db = Database()
        query = 'SELECT max_student_capacity FROM class WHERE class.id=?'
        db.cursor.execute(query, class_id)
        result = db.cursor.fetchone()[0]
        if (result>0):
            return True
        else:
            return False
    except Exception as ex:
        print(ex)
        return ex

def enrollment_start_time(enrollment_period_id: str) -> float | Exception:
    try:
        db = Database()
        query = '''SELECT DATEPART(hour, start_datetime)
                FROM enrollment_period
                WHERE enrollment_period.id=?'''
        db.cursor.execute(query, enrollment_period_id)
        result = db.cursor.fetchone()[0]
        return result
    except Exception as ex:
        print(ex)
        return ex
    
def enrollment_end_time(enrollment_period_id: str) -> float | Exception:
    try:
        db = Database()
        query = '''SELECT DATEPART(hour, end_datetime)
                FROM enrollment_period
                WHERE enrollment_period.id=?'''
        db.cursor.execute(query, enrollment_period_id)
        result = db.cursor.fetchone()[0]
        return result
    except Exception as ex:
        print(ex)
        return ex
    

def enrollment_start_date(enrollment_period_id: str) -> str | Exception:
    try:
        db = Database()
        query = '''SELECT CAST(DATEPART(day, start_datetime) AS VARCHAR(2)) + '-' +
                RIGHT('0' + CAST(DATEPART(month, start_datetime) AS VARCHAR(2)), 2) + '-' +
                RIGHT('0' + CAST(DATEPART(year, start_datetime) AS VARCHAR(4)), 4) AS fecha
                FROM enrollment_period
                WHERE enrollment_period.id = ?'''
        db.cursor.execute(query, enrollment_period_id)
        result = db.cursor.fetchone()[0]
        return result
    except Exception as ex:
        print(ex)
        return ex
    
def enrollment_end_date(enrollment_period_id: str) -> str | Exception:
    try:
        db = Database()
        query = '''SELECT CAST(DATEPART(day, end_datetime) AS VARCHAR(2)) + '-' +
                RIGHT('0' + CAST(DATEPART(month, end_datetime) AS VARCHAR(2)), 2) + '-' +
                RIGHT('0' + CAST(DATEPART(year, end_datetime) AS VARCHAR(4)), 4) AS fecha
                FROM enrollment_period
                WHERE enrollment_period.id = ?'''
        db.cursor.execute(query, enrollment_period_id)
        result = db.cursor.fetchone()[0]
        return result
    except Exception as ex:
        print(ex)
        return ex
    
if __name__ == '__main__':
    print(enrollment_start_date(5))