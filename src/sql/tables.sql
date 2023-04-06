CREATE TABLE period_type (
	id INT NOT NULL CONSTRAINT PK__period_type PRIMARY KEY(id),
	name VARCHAR(255) NOT NULL CONSTRAINT UQ__period_type__name UNIQUE(name)
)
GO

CREATE TABLE period_status (
	id INT NOT NULL CONSTRAINT PK__period_status PRIMARY KEY(id),
	name VARCHAR(255) NOT NULL CONSTRAINT UQ__period_status__name UNIQUE(name)
)
GO

CREATE TABLE period (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__period PRIMARY KEY(id),
	period_type_id INT NOT NULL CONSTRAINT FK__period__period_type FOREIGN KEY(period_type_id) REFERENCES period_type(id),
	start_time DATE NOT NULL,
	end_time DATE NOT NULL,
	period_status_id INT NOT NULL CONSTRAINT FK__period__period_status FOREIGN KEY(period_status_id) REFERENCES period_status(id),
	CONSTRAINT CHK__period__start_time__end_time CHECK(start_time < end_time)
)
GO

CREATE TABLE school (
	id CHAR(2) NOT NULL CONSTRAINT PK__id PRIMARY KEY(id),
	name VARCHAR(255) NOT NULL CONSTRAINT UQ__school__name UNIQUE(name),
	email NVARCHAR(255) NOT NULL CONSTRAINT UQ__school__email UNIQUE(email),
	phone_number CHAR(8) NOT NULL CONSTRAINT UQ__school__phone_number UNIQUE(phone_number),
	director_id VARCHAR(255) NOT NULL
)
GO

CREATE TABLE course (
	id CHAR(4) NOT NULL CONSTRAINT PK__course PRIMARY KEY(id),
	name VARCHAR(255) NOT NULL CONSTRAINT UQ__course__name UNIQUE(name),
	period_type_id INT NOT NULL CONSTRAINT FK__course__period_type FOREIGN KEY(period_type_id) REFERENCES period_type(id),
	credits INT NOT NULL CONSTRAINT CHK__course__credits CHECK(credits >= 0),
	school_id CHAR(2) NOT NULL CONSTRAINT FK__course__school FOREIGN KEY(school_id) REFERENCES school(id),
	class_hours_week INT NOT NULL CONSTRAINT CHK__course__class_hours_week CHECK(class_hours_week > 0),
	description TEXT NOT NULL
)
GO

CREATE TABLE career (
	id INT IDENTITY(1, 1) CONSTRAINT PK__career PRIMARY KEY(id),
	name VARCHAR(255),
	school_id CHAR(2) NOT NULL CONSTRAINT FK__career__school FOREIGN KEY(school_id) REFERENCES school(id),
	description TEXT NOT NULL
)
GO

CREATE TABLE curriculum_status (
	id INT NOT NULL CONSTRAINT PK__curriculum_status PRIMARY KEY(id),
	name VARCHAR(255) NOT NULL CONSTRAINT UQ__curriculum_status__name UNIQUE(name)
)
GO

CREATE TABLE curriculum (
	id VARCHAR(4) NOT NULL CONSTRAINT PK__curriculum PRIMARY KEY(id),
	curriculum_status_id INT NOT NULL CONSTRAINT FK__curriculum__curriculum_status FOREIGN KEY(curriculum_status_id) REFERENCES curriculum_status(id),
	career_id INT NOT NULL CONSTRAINT FK__curriculum__career FOREIGN KEY(career_id) REFERENCES career(id),
	creation_date DATE NOT NULL,
	activation_date DATE NOT NULL,
	finish_date DATE NOT NULL,
	CONSTRAINT CHK__curriculum__activation_date__finish_date CHECK(activation_date < finish_date),
	CONSTRAINT CHK__curriculum__creation_date__activation_date__finish_date CHECK(creation_date < activation_date)
)
GO

CREATE TABLE curriculum_course (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__curriculum_course PRIMARY KEY(id),
	curriculum_id VARCHAR(4) NOT NULL CONSTRAINT FK__curriculum_course__curriculum FOREIGN KEY(curriculum_id) REFERENCES curriculum(id),
	course_id CHAR(4) NOT NULL CONSTRAINT FK__curriculum_course__course FOREIGN KEY(course_id) REFERENCES course(id)
)
GO

CREATE TABLE curriculum_course_dependency (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__course_dependency PRIMARY KEY(id),
	curriculum_id VARCHAR(4) NOT NULL CONSTRAINT FK__curriculum_course_dependency__curriculum FOREIGN KEY(curriculum_id) REFERENCES curriculum(id),
	course_id CHAR(4) NOT NULL CONSTRAINT FK__curriculum_course_dependency__course FOREIGN KEY(course_id) REFERENCES course(id),
	course_dependency_id CHAR(4) NOT NULL CONSTRAINT FK__curriculum_course_dependency__course FOREIGN KEY(course_dependency_id) REFERENCES course(id)
)
GO

CREATE TABLE curriculum_course_prerequisite (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__curriculum_course_prerequisite PRIMARY KEY(id),
	curriculum_id VARCHAR(4) NOT NULL CONSTRAINT FK__curriculum_course_prerequisite__curriculum FOREIGN KEY(curriculum_id) REFERENCES curriculum(id),
	course_id CHAR(4) NOT NULL CONSTRAINT FK__curriculum_course_prerequisite__course FOREIGN KEY(course_id) REFERENCES course(id),
	course_prerequisite_id CHAR(4) NOT NULL CONSTRAINT FK__curriculum_course_prerequisite__course FOREIGN KEY(course_prerequisite_id) REFERENCES course(id)
)
GO

CREATE TABLE class (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__class PRIMARY KEY(id),
	course_id CHAR(4) NOT NULL CONSTRAINT FK__class__course FOREIGN KEY(course_id) REFERENCES course(id),
	period_id INT NOT NULL CONSTRAINT FK__class__period FOREIGN KEY(period_id) REFERENCES period(id),
	professor_id VARCHAR(255) NOT NULL,
	max_student_capacity INT NOT NULL CONSTRAINT CHK__class__max_student_capacity CHECK(max_student_capacity > 0)
)
GO

CREATE TABLE day (
	id INT NOT NULL CONSTRAINT PK__day PRIMARY KEY(id),
	name VARCHAR(255) NOT NULL CONSTRAINT UQ__day__name UNIQUE(name)
)
GO

CREATE TABLE schedule (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__schedule PRIMARY KEY(id),
	class_id INT NOT NULL CONSTRAINT FK__schedule__class FOREIGN KEY(class_id) REFERENCES class(id),
	day_id INT NOT NULL CONSTRAINT FK__schedule__day FOREIGN KEY(day_id) REFERENCES day(id),
	start_time TIME NOT NULL,
	end_time TIME NOT NULL,
	CONSTRAINT CHK__schedule__start_time__end_time CHECK(start_time < end_time)
)
GO

CREATE TABLE archive_type (
	id INT NOT NULL CONSTRAINT PK__archive_type PRIMARY KEY(id),
	name VARCHAR(255) NOT NULL CONSTRAINT UQ__archive_type__name UNIQUE(name)
)
GO

CREATE TABLE archive (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__archive PRIMARY KEY(id),
	user_id VARCHAR(255) NOT NULL,
	archive_type_id INT NOT NULL CONSTRAINT FK__archive__archive_type FOREIGN KEY(archive_type_id) REFERENCES archive_type(id),
	period_id INT NOT NULL CONSTRAINT FK__archive__period FOREIGN KEY(period_id) REFERENCES period(id),
	creation_date DATETIME NOT NULL,
	last_update_date DATETIME NOT NULL,
	name NVARCHAR(255) NOT NULL,
	description NVARCHAR(255) NOT NULL
)
GO

CREATE TABLE course_archive (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__course_archive PRIMARY KEY(id),
	course_id CHAR(4) NOT NULL CONSTRAINT FK__course_archive__course FOREIGN KEY(course_id) REFERENCES course(id),
	archive_id INT NOT NULL CONSTRAINT FK__course_archive__archive FOREIGN KEY(archive_id) REFERENCES archive(id)
)
GO

CREATE TABLE career_archive (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__career_archive PRIMARY KEY(id),
	career_id CHAR(4) NOT NULL CONSTRAINT FK__career_archive__career FOREIGN KEY(career_id) REFERENCES career(id),
	archive_id INT NOT NULL CONSTRAINT FK__career_archive__archive FOREIGN KEY(archive_id) REFERENCES archive(id)
)
GO

CREATE TABLE class_archive (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__class_archive PRIMARY KEY(id),
	class_id CHAR(4) NOT NULL CONSTRAINT FK__class_archive__class FOREIGN KEY(class_id) REFERENCES class(id),
	archive_id INT NOT NULL CONSTRAINT FK__class_archive__archive FOREIGN KEY(archive_id) REFERENCES archive(id)
)
GO

CREATE TABLE student_curriculum (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__student_curriculum PRIMARY KEY(id),
	student_id VARCHAR(255) NOT NULL,
	curriculum_id VARCHAR(4) NOT NULL CONSTRAINT FK__student_curriculum__curriculum FOREIGN KEY(curriculum_id) REFERENCES curriculum(id)
)
GO

CREATE TABLE professor_school (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__professor_school PRIMARY KEY(id),
	professor_id VARCHAR(255) NOT NULL,
	school_id CHAR(2) NOT NULL CONSTRAINT FK__professor_school__school FOREIGN KEY(school_id) REFERENCES school(id)
)
GO


/*Edited by Gerald (check it) //////////////////////////*/



CREATE TABLE registration_period (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__registration_period PRIMARY KEY(id),
	name VARCHAR(255) NOT NULL,
	start_time DATE NOT NULL,
	end_time DATE NOT NULL,
	period_status BIT NOT NULL, /*Aqui seria manejarlo como 1 o 0, o crear una tabla de estado para este estado en especifico, ya que el estado es abierto o cerrado*/
	academic_period_id CHAR(4) NOT NULL CONSTRAINT FK__academic_period__period FOREIGN KEY(academic_period_id) REFERENCES course(id),
	CONSTRAINT CHK__registration_period__start_time__end_time CHECK(start_time < end_time)
)
GO

CREATE TABLE evaluation (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__evaluation PRIMARY KEY(id),
	class_id INT NOT NULL FK__evaluation__class FOREIGN KEY REFERENCES class(id),
	CONSTRAINT CHK__evaluation__percentage_check CHECK (SUM(SELECT Percentage FROM evaluation_category WHERE evaluation.id = evaluation_category.evaluation_id) <= 100)
)
GO

CREATE TABLE evaluation_category (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__evaluation_category PRIMARY KEY(id),
	name VARCHAR(255) NOT NULL,
	percentage INT NOT NULL, 
	evaluation_id INT NOT NULL FK__evaluation_category__evaluation FOREIGN KEY(evaluation_id) REFERENCES evalutation(id)
	CONSTRAINT CHK__evalutation_category__percentage_activity_check CHECK (SUM(SELECT Percentage FROM activity WHERE evaluation_category.id = activity.id) <= percentage)
)
GO 

CREATE TABLE activity(
	id IDENTITY(1, 1) NOT NULL CONSTRAINT PK__activity PRIMARY KEY(id),
	name VARCHAR(255) NOT NULL,
	due_date DATE NOT NULL,
	activity_percentage INT NOT NULL
)
GO

