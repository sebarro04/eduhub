from Database import Database

def current_enrollment_time(student_enrollment_period_id) -> float | Exception:
    try:
        db = Database()
        query = '''SELECT DATEPART(hour, start_datetime)
                FROM student_enrollment_period
                INNER JOIN enrollment_period ON student_enrollment_period.enrollment_period_id = enrollment_period.id 
                WHERE student_enrollment_period.id =?'''
        db.cursor.execute(query, student_enrollment_period_id)
        
        #Arreglar el retorno de datos----------------------------------
        result = db.cursor.fetchone()
        db.cursor.close()
        db.connection.close()
        if result:
            return float(result[0])
        else:
            raise Exception('No se encontró la hora de matriculación actual.')
    except Exception as ex:
        print(ex)
        return ex
    
#in process
#Error en la base de datos 
def read_all_enrollments_by_student_id(studentId: str) -> list | Exception:
    try:
        db = Database()
        query = '''SELECT enrollment_period.name, enrollment_period.start_datetime, enrollment_period.end_datetime, enrollment_period.is_open, enrollment_period.period_id
                FROM student_enrollment_period 
                INNER JOIN enrollment_period ON student_enrollment_period.enrollment_period_id = enrollment_period.id AND enrollment_period.is_open = 1
                WHERE student_enrollment_period.student_id =?'''
        db.cursor.execute(query,studentId)
        row_headers = [x[0] for x in db.cursor.name]
        result = db.cursor.fetchall()
        json_data = []
        for row in result:
            json_data.append(dict(zip(row_headers, row)))
        return json_data
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
    print(calculate_period_average(1))