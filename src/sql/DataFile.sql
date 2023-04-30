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
SELECT * FROM period
/*CLASES ASOCIADAS A LOS CURSOS*/
INSERT INTO class (class.course_id, class.period_id, class.professor_id, class.max_student_capacity)
VALUES ('0202', 8, 'professor1-0202', 25), ('0202', 8, 'professor2-0202', 30), ('0202', 9, 'professor1-0202', 20), ('0202', 9, 'professor2-0202', 22)