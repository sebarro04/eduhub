from Database import Database

#def calculate_student_enrollment_average(student_id: str) -> float | Exception:
    
# SELECT AVG(grade) as average_grade
# FROM student_class 
# INNER JOIN (
#     SELECT MAX(id) as max_id
#     FROM period
#     WHERE id IN (
#         SELECT period_id
#         FROM class
#         WHERE id IN (
#             SELECT class_id
#             FROM student_class
#             WHERE student_id = 1
#         )
#     )
# ) last_period ON student_class.class_id IN (
#     SELECT id
#     FROM class
#     WHERE period_id = last_period.max_id
# )
# WHERE student_class.student_id = 1