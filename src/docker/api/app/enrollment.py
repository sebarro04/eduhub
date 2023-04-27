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
    
def calculate_period_average(studentID: int) -> int | Exception:
    try:
        db = Database()
        query = '''
                DECLARE @last_period_id INT
                SELECT TOP 1 @last_period_id = p.id
                FROM period p
                WHERE p.end_date = (SELECT MAX(end_date) FROM period)
                AND EXISTS (
                    SELECT 1
                    FROM grade_record gr
                    WHERE gr.student_id = ?
                    AND gr.period_id = p.id
                )

                IF @last_period_id IS NULL
                BEGIN
                    SELECT 100 AS 'period_average'
                END
                ELSE
                BEGIN
                    DECLARE @total_credits INT
                    SELECT @total_credits = SUM(c.credits)
                    FROM course c
                    INNER JOIN grade_record gr ON c.id = gr.course_id
                    WHERE gr.period_id = @last_period_id

                    DECLARE @weighted_sum INT
                    SELECT @weighted_sum = SUM(gr.grade * c.credits)
                    FROM course c
                    INNER JOIN grade_record gr ON c.id = gr.course_id
                    WHERE gr.student_id = ? AND gr.period_id = @last_period_id

                    SELECT @weighted_sum / @total_credits AS 'period_average'
                END
                '''
        db.cursor.execute(query, (studentID, studentID))
        result = db.cursor.fetchone()[0]  # obtiene el resultado de la consulta
        db.cursor.commit()
        return result  # devuelve el resultado de la consulta
    except Exception as ex:
        print(ex)
        return ex
    
if __name__ == '__main__':
    print(calculate_period_average(12))