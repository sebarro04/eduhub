/*Para eliminar en orden y sin conflictos
DELETE FROM student_class
DELETE FROM schedule
DELETE FROM student_waiting_enrollment
DELETE FROM class
DELETE FROM student_enrollment_period
DELETE FROM enrollment_period
DELETE FROM grade_record
DELETE FROM period
DELETE FROM professor_school
DELETE FROM curriculum_course
DELETE FROM curriculum_course_prerequisite
DELETE FROM curriculum_course_dependency
DELETE FROM course
DELETE FROM student_curriculum
DELETE FROM curriculum
DELETE FROM career
DELETE FROM school
*/
/*CREACION DE TABLAS DE ACUERDO A ORDEN Y PRIORIDA PARA FK'S*/

/*PERIODOS*/
INSERT INTO period (period_type_id, start_date, end_date, period_status_id)
VALUES (2, '2023-07-06', '2023-11-22', 1), 
	   (2, '2024-02-04', '2024-06-01', 1),
	   (3, '2023-08-01', '2023-10-27', 1)

/*ESCUELAS*/
INSERT INTO school (