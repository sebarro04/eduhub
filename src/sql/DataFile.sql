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

/*PERIODOS CORRIDO*/
INSERT INTO period (period_type_id, start_date, end_date, period_status_id)
VALUES (2, '2023-07-06', '2023-11-22', 1), 
	   (2, '2024-02-04', '2024-06-01', 1),
	   (3, '2023-08-01', '2023-10-27', 1)

/*ESCUELAS CORRIDO*/
INSERT INTO school (school.id, school.name, school.email, school.phone_number, school.director_id)
VALUES ('IC', 'Escuela de Ingenieria en Computacion', 'escuelacomputacion@itc.ac.cr', 83440015, 1),
	   ('CI', 'Escuela de Ciencias del Idioma', 'escuelaCienciasIdioma@itc.ac.cr', 80457790, 2),
	   ('MA', 'Escuela de Matematica', 'escuelaMatematica@itc.ac.cr', 89920010, 3),
	   ('SE', 'Escuela de Ciencias Sociales', 'escuelaCienciasSociales@itc.ac.cr', 84448052, 4),
	   ('FH', 'Escuela de Centros de Formacion Humanistica', 'escuelaCFH@itc.ac.cr', 86651740, 5)

/*CURSOS CORRIDO*/
INSERT INTO course (course.id, course.name, course.period_type_id, course.credits, course.school_id, course.class_hours_week, course.description)
VALUES ('0202', 'Ingles basico', 2, 2, 'CI', 4, 'Curso de Ingles Basico'), 
	   ('0101', 'Matematica General', 2, 2, 'MA', 4, 'Curso de Matematica General'), 
	   ('1106', 'Comunicacion escrita', 2, 2, 'CI', 4, 'Curso de Comunicacion Escrita'), 
	   ('1400', 'FOC', 2, 3, 'IC', 4, 'Curso de FOC'), 
	   ('1802', 'Introduccion a la programacion', 2, 3, 'IC', 4, 'Intro'), 
	   ('1803', 'Taller de programacion', 2, 3, 'IC', 4, 'Curso de Taller'), 
	   ('1403', 'Matematica Discreta', 2, 4, 'MA', 4, 'Curso de MD'), 
	   ('1100', 'Actividad Cultural', 2, 0, 'SE', 2, 'Actividad Cultural 1'), 
	   ('1230', 'Ingles 1', 2, 2, 'CI', 4, 'Curso de Ingles 1'), 
	   ('1000', 'CFH', 3, 0, 'FH', 4, 'CFH'), 
	   ('2001', 'Estructuras de Datos', 2, 4, 'IC', 4, 'ED'),
	   ('2101', 'Programacion Orientada a Objetos', 2, 3, 'IC', 4, 'POO'), 
	   ('3101', 'Arquitectura de Computadoras', 2, 4, 'IC', 4, 'Curso de '), 
	   ('1102', 'Calculo Diferencial e Integral', 2, 4, 'IC', 4, 'CDI') 

/*CARRERA CORRIDO*/
INSERT INTO career (career.name, career.school_id, career.description)
VALUES ('Ingenieria en Computación', 'IC', '¡Bienvenido a la carrer de Ingenieria en computacion!')

/*CURRICULUM CORRIDO*/
INSERT INTO curriculum (curriculum.id, curriculum.curriculum_status_id, curriculum.career_id, curriculum.creation_date, curriculum.activation_date, curriculum.finish_date)
VALUES('0001', 2, 2, '2016-01-01', '2016-02-01', '2026-01-01')

/*CURSOS ASOCIADOS A UN PLAN CORRIDO*/
INSERT INTO curriculum_course (curriculum_course.curriculum_id, curriculum_course.course_id)
VALUES ('0001', '0202'), ('0001', '0101'), ('0001', '1106'), ('0001', '1400'), ('0001', '1802'), ('0001', '1803'), ('0001', '1403'),
	   ('0001', '1100'), ('0001', '1230'), ('0001', '1000'), ('0001', '2001'), ('0001', '2101'), ('0001', '3101'), ('0001', '1102')

/*CURSOS CON DEPENDENCIA CORRIDO*/
INSERT INTO curriculum_course_dependency (curriculum_course_prerequisite.curriculum_id, curriculum_course_prerequisite.course_id, curriculum_course_prerequisite.course_dependency_id)
VALUES ('0001', '1803', '1802'), ('0001', '2001', '2101')

/*PREREQUISITOS ENTRE CURSOS CORRIDO*/
INSERT INTO curriculum_course_prerequisite (curriculum_course_prerequisite.curriculum_id, curriculum_course_prerequisite.course_id, curriculum_course_prerequisite.course_prerequisite_id)
VALUES ('0001', '2001', '1802'), ('0001', '2001', '1803'),
	   ('0001', '2101', '1802'), ('0001', '2101', '1803'),
	   ('0001', '3101', '1400'),
	   ('0001', '1102', '0101')

/*CLASES ASOCIADAS A LOS CURSOS*/
INSERT INTO class (class.course_id, class.period_id, class.professor_id, class.max_student_capacity)
VALUES ('0202', 8, 'professor1-0202', 25), ('0202', 8, 'professor2-0202', 30), ('0202', 9, 'professor1-0202', 20), ('0202', 9, 'professor2-0202', 22),
	   ('0101', 8, 'professor1-0101', 26), ('0101', 8, 'professor2-0101', 29), ('0101', 9, 'professor1-0101', 21), ('0101', 9, 'professor2-0101', 23),
	   ('1106', 8, 'professor1-1106', 27), ('1106', 8, 'professor2-1106', 28), ('1106', 9, 'professor1-1106', 22), ('1106', 9, 'professor2-1106', 24),
	   ('1400', 8, 'professor1-1400', 28), ('1400', 8, 'professor2-1400', 27), ('1400', 9, 'professor1-1400', 23), ('1400', 9, 'professor2-1400', 25),
	   ('1802', 8, 'professor1-1802', 29), ('1802', 8, 'professor2-1802', 26), ('1802', 9, 'professor1-1802', 24), ('1802', 9, 'professor2-1802', 26),
	   ('1803', 8, 'professor1-1803', 30), ('1803', 8, 'professor2-1803', 25), ('1803', 9, 'professor1-1803', 25), ('1803', 9, 'professor2-1803', 27),
	   ('1403', 8, 'professor1-1403', 31), ('1403', 8, 'professor2-1403', 30), ('1403', 9, 'professor1-1403', 26), ('1403', 9, 'professor2-1403', 28),
	   ('1100', 8, 'professor1-1100', 32), ('1100', 8, 'professor2-1100', 31), ('1100', 9, 'professor1-1100', 27), ('1100', 9, 'professor2-1100', 29),
	   ('1230', 8, 'professor1-1230', 33), ('1230', 8, 'professor2-1230', 32), ('1230', 9, 'professor1-1230', 28), ('1230', 9, 'professor2-1230', 30),
	   ('1000', 10, 'professor1-1000', 30), ('1000', 10, 'professor2-1000', 26),
	   ('2001', 8, 'professor1-2001', 29), ('2001', 8, 'professor2-2001', 27), ('2001', 9, 'professor1-2001', 29), ('2001', 9, 'professor2-2001', 31),
	   ('2101', 8, 'professor1-2101', 28), ('2101', 8, 'professor2-2101', 28), ('2101', 9, 'professor1-2101', 30), ('2101', 9, 'professor2-2101', 32),
	   ('3101', 8, 'professor1-3101', 27), ('3101', 8, 'professor2-3101', 29), ('3101', 9, 'professor1-3101', 31), ('3101', 9, 'professor2-3101', 33),
	   ('1102', 8, 'professor1-1102', 26), ('1102', 8, 'professor2-1102', 30), ('1102', 9, 'professor1-1102', 32), ('1102', 9, 'professor2-1102', 34)

/*ESTUDIANTE POR PLAN DE ESTUDIOS*/
INSERT INTO student_curriculum (student_curriculum.student_id, student_curriculum.curriculum_id)
VALUES ('I4jurZC2gpNEvpnWGb9iYQkVpXy1', '0001')

/*PROFESOR POR ESCUELA*/
INSERT INTO professor_school (professor_school.professor_id, professor_school.school_id)
VALUES ('professor-compu', 'IC')

/*PERIODOS DE MATRICULA*/
INSERT INTO enrollment_period (enrollment_period.name, enrollment_period.start_datetime, enrollment_period.end_datetime, enrollment_period.is_open, enrollment_period.period_id)
VALUES ('Ordinaria', '2023-07-01 07:00:00', '2023-07-02 16:00:00', 0, 8),
	   ('Ordinaria', '2024-02-01 07:00:00', '2024-02-02 16:00:00', 0, 9),
	   ('Ordinaria', '2023-07-28 07:00:00', '2023-07-29 16:00:00', 0, 10)

/*ESTUDIANTE POR PERIODO DE MATRICULA*/
INSERT INTO student_enrollment_period (student_enrollment_period.student_id, student_enrollment_period.enrollment_period_id)
VALUES ('I4jurZC2gpNEvpnWGb9iYQkVpXy1', 8), ('I4jurZC2gpNEvpnWGb9iYQkVpXy1', 10)

/**/
