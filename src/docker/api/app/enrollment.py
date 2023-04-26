from Database import Database

#In process, waiting change
def current_enrollment_time() -> float | Exception:
    try:
        db = Database()
        query = ''
        db.cursor.execute(query, id)
        db.cursor.commit()
        return True
    except Exception as ex:
        print(ex)
        return ex
    
#in process
def load_enrollment_by_student_id(studentId) -> list | Exception:
    try:
        db = Database()
        query = ''
        db.cursor.execute(query, id)
        db.cursor.commit()
        return True
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