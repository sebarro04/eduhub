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
                WHERE student_enrollment_period.student_id = ?'''
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
    
def read_all_enrollment_available_courses_by_student_id(studentID: str, enrollment_period_id: int) -> list | Exception:
    try:
        db = Database()
        query = '''
                DECLARE @period_id INT
                SET @period_id = (SELECT p.id
                FROM enrollment_period ep
                INNER JOIN period p ON ep.period_id = p.id
                WHERE ep.id = ?)

                SELECT c.id, c.name
                FROM curriculum_course cc
                INNER JOIN course c ON cc.course_id = c.id
                INNER JOIN class cl ON c.id = cl.course_id
                INNER JOIN period_type pt ON c.period_type_id = pt.id
                INNER JOIN period p ON pt.id = p.period_type_id
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
                AND p.id = @period_id
                AND cl.period_id = @period_id

                UNION
                SELECT c.id, c.name 
                FROM curriculum_course cc
                INNER JOIN course c ON cc.course_id = c.id
                INNER JOIN class cl ON c.id = cl.course_id
                INNER JOIN period_type pt ON c.period_type_id = pt.id
                INNER JOIN period p ON pt.id = p.period_type_id
                WHERE c.id IN ((SELECT ccp.course_id
                            FROM curriculum_course_prerequisite ccp
                            INNER JOIN course c ON ccp.course_prerequisite_id = c.id
                            INNER JOIN grade_record gr ON c.id = gr.course_id
                            WHERE gr.student_id = ? AND gr.grade >= 65))
                            AND c.id NOT IN (
                                SELECT gr.course_id
                                FROM grade_record gr
                                WHERE gr.student_id = ? AND gr.grade >= 65.7)
                            AND p.id = @period_id
                            AND cl.period_id = @period_id
                '''
        db.cursor.execute(query,(enrollment_period_id, studentID, studentID, studentID, studentID))
        result = db.cursor.fetchall()
        return db.jsonify_query_result_headers(result)
    except Exception as ex:
        print(ex)
        return ex
    
def enroll_class(class_id: str,studentId: str, enrollment_period_id: int) -> str | Exception:
    try:
        schedule_clash=check_schedule_clash(class_id,studentId) 
        spaces=space_available_in_class(class_id)
        if (schedule_clash==[]):
            if (spaces==True):
                db = Database()
                query = '''
                        INSERT INTO student_class (student_id,class_id)
                        VALUES (?,?)

                        UPDATE class
                        SET max_student_capacity = max_student_capacity-1
                        WHERE class.id = ?;
                        '''
                db.cursor.execute(query,(studentId, class_id, class_id))
                db.cursor.commit()
                return 'Matricula Exitosa'
            else:
                db = Database()
                query = '''
                        INSERT INTO student_waiting_enrollment (student_id, enrollment_period_id, class_id)
                        VALUES (?, ?, ?)
                        '''
                db.cursor.execute(query,(studentId, enrollment_period_id, class_id))
                db.cursor.commit()
                return 'Matricula Tentativa Exitosa'
        else:
            return 'Choque de horario'
    except Exception as ex:
        print(ex)
        return ex
    
def unenroll_class(course_id: str,studentId: str) -> bool | Exception:
    try:
        db = Database()
        query = '''
                DECLARE @class_id INT
                SELECT @class_id = cl.id FROM student_class sc
                INNER JOIN class cl ON sc.class_id = cl.id
                WHERE cl.course_id = ? AND sc.student_id = ?
        
                DELETE FROM student_class 
                WHERE student_class.class_id = @class_id AND student_class.student_id = ?

                UPDATE class
                        SET max_student_capacity = max_student_capacity+1
                        WHERE class.id = @class_id;
                '''
        db.cursor.execute(query, (course_id, studentId, studentId))
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
    
def read_all_classes_by_course(enrollment_period_id: str, course_id: str) -> list | Exception:
    try:
        db = Database()
        query = '''
                SELECT cl.*, 
                    STRING_AGG(CONCAT(d.name, ': ', CONVERT(varchar(5), s.start_time, 108), '-', CONVERT(varchar(5), s.end_time, 108)), '; ') AS class_schedule
                FROM course c
                INNER JOIN class cl ON c.id = cl.course_id
                INNER JOIN schedule s ON s.class_id = cl.id
                INNER JOIN day d ON d.id = s.day_id
                INNER JOIN period p ON cl.period_id = p.id
                INNER JOIN enrollment_period ep ON p.id = ep.period_id
                WHERE c.id = ?
                AND ep.id = ?
                GROUP BY cl.id, cl.course_id, cl.period_id, cl.professor_id, cl.max_student_capacity
                '''
        db.cursor.execute(query, (course_id, enrollment_period_id))
        result = db.cursor.fetchall()
        return db.jsonify_query_result_headers(result)
    except Exception as ex:
        print(ex)
        return ex
    

def generate_enrollment_report( student_id: str,enrollment_period_id: str) -> list | Exception:
    try:
        db = Database()
        query = '''
                SELECT class.course_id, course.name, class.period_id, class.professor_id, schedule.start_time,schedule.end_time, day.name
                FROM student_class 
                INNER JOIN class ON student_class.class_id=class.id 
                INNER JOIN course ON class.course_id=course.id
                INNER JOIN schedule ON class.id=schedule.class_id
                INNER JOIN day ON schedule.day_id=day.id
                INNER JOIN enrollment_period ON class.period_id=enrollment_period.period_id
                WHERE student_class.student_id=?
                AND enrollment_period.id=?
                '''
        db.cursor.execute(query,student_id, enrollment_period_id)
        result = db.cursor.fetchall()
        return db.jsonify_query_result_headers(result)
    except Exception as ex:
        print(ex)
        return ex
    
def show_reviews ( class_id: str) -> list | Exception:
    try:
        db = Database()
        query = '''
                DECLARE @professor_id VARCHAR(128)
                SELECT @professor_id=professor_id  
                FROM class
                WHERE class.id=?

                SELECT class_rating.comment 
                FROM class
                INNER JOIN class_rating ON class.id=class_rating.class_id
                WHERE class.professor_id= @professor_id
                '''
        db.cursor.execute(query,class_id)
        result = db.cursor.fetchall()
        return db.jsonify_query_result_headers(result)
    except Exception as ex:
        print(ex)
        return ex
    
if __name__ == '__main__':
    print(generate_enrollment_report('2021023224', '8'))
    