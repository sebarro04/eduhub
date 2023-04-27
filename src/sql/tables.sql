CREATE TABLE role (
	id INT NOT NULL CONSTRAINT PK__role PRIMARY KEY(id),
	name VARCHAR(15) NOT NULL CONSTRAINT UQ__role__name UNIQUE(name)
)
GO

CREATE TABLE user_role (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__user_role PRIMARY KEY(id),
	user_id VARCHAR(128) NOT NULL,
	role_id INT NOT NULL CONSTRAINT FK__user_role__role FOREIGN KEY(role_id) REFERENCES role(id)
)
GO

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
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	period_status_id INT NOT NULL CONSTRAINT FK__period__period_status FOREIGN KEY(period_status_id) REFERENCES period_status(id),
	CONSTRAINT CHK__period__start_time__end_time CHECK(start_date < end_date)
)
GO

CREATE TABLE school (
	id CHAR(2) NOT NULL CONSTRAINT PK__id PRIMARY KEY(id),
	name VARCHAR(255) NOT NULL CONSTRAINT UQ__school__name UNIQUE(name),
	email NVARCHAR(255) NOT NULL CONSTRAINT UQ__school__email UNIQUE(email),
	phone_number CHAR(8) NOT NULL CONSTRAINT UQ__school__phone_number UNIQUE(phone_number),
	director_id VARCHAR(128) NOT NULL
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
	name VARCHAR(255) NOT NULL CONSTRAINT UQ__career__name UNIQUE(name),
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
	course_id CHAR(4) NOT NULL CONSTRAINT FK__curriculum_course_dependency__course_id__course FOREIGN KEY(course_id) REFERENCES course(id),
	course_dependency_id CHAR(4) NOT NULL CONSTRAINT FK__curriculum_course_dependency__course_dependency_id__course FOREIGN KEY(course_dependency_id) REFERENCES course(id)
)
GO

CREATE TABLE curriculum_course_prerequisite (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__curriculum_course_prerequisite PRIMARY KEY(id),
	curriculum_id VARCHAR(4) NOT NULL CONSTRAINT FK__curriculum_course_prerequisite__curriculum FOREIGN KEY(curriculum_id) REFERENCES curriculum(id),
	course_id CHAR(4) NOT NULL CONSTRAINT FK__curriculum_course_prerequisite__course_id__course FOREIGN KEY(course_id) REFERENCES course(id),
	course_prerequisite_id CHAR(4) NOT NULL CONSTRAINT FK__curriculum_course_prerequisite__course_prerequisite_id__course FOREIGN KEY(course_prerequisite_id) REFERENCES course(id)
)
GO

CREATE TABLE class (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__class PRIMARY KEY(id),
	course_id CHAR(4) NOT NULL CONSTRAINT FK__class__course FOREIGN KEY(course_id) REFERENCES course(id),
	period_id INT NOT NULL CONSTRAINT FK__class__period FOREIGN KEY(period_id) REFERENCES period(id),
	professor_id VARCHAR(128) NOT NULL,
	max_student_capacity INT NOT NULL CONSTRAINT CHK__class__max_student_capacity CHECK(max_student_capacity >= 0)
)
GO

CREATE TABLE student_class (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__student_class PRIMARY KEY(id),
	student_id VARCHAR(128) NOT NULL,
	class_id INT NOT NULL CONSTRAINT FK__student_class__class FOREIGN KEY(class_id) REFERENCES class(id)
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

CREATE TABLE [file] (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__file PRIMARY KEY(id),
	name VARCHAR(242) NOT NULL,
	description VARCHAR(256),
	url VARCHAR(256) NOT NULL,
	user_id VARCHAR(128) NOT NULL,
	class_id INT CONSTRAINT FK__file__class FOREIGN KEY(class_id) REFERENCES class(id),
	creation_datetime DATETIME NOT NULL,
	last_modified_datetime DATETIME
)
GO

CREATE TABLE student_curriculum (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__student_curriculum PRIMARY KEY(id),
	student_id VARCHAR(128) NOT NULL,
	curriculum_id VARCHAR(4) NOT NULL CONSTRAINT FK__student_curriculum__curriculum FOREIGN KEY(curriculum_id) REFERENCES curriculum(id)
)
GO

CREATE TABLE professor_school (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__professor_school PRIMARY KEY(id),
	professor_id VARCHAR(128) NOT NULL,
	school_id CHAR(2) NOT NULL CONSTRAINT FK__professor_school__school FOREIGN KEY(school_id) REFERENCES school(id)
)
GO

CREATE TABLE evaluation (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__evaluation PRIMARY KEY(id),
	class_id INT NOT NULL CONSTRAINT FK__evaluation__class FOREIGN KEY(class_id) REFERENCES class(id)
)
GO

CREATE TABLE evaluation_category (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__evaluation_category PRIMARY KEY(id),
	name VARCHAR(255) NOT NULL,
	percentage INT NOT NULL CONSTRAINT CHK__evaluation_category__percentage CHECK(percentage > 0), 
	evaluation_id INT NOT NULL CONSTRAINT FK__evaluation_category__evaluation FOREIGN KEY(evaluation_id) REFERENCES evaluation(id)	
)
GO

CREATE TABLE activity (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__activity PRIMARY KEY(id),
	name VARCHAR(255) NOT NULL,
	description TEXT NOT NULL,
	due_date DATETIME NOT NULL,
	percentage FLOAT NOT NULL CONSTRAINT CHK__activity__percentage CHECK(percentage > 0),
	evaluation_category_id INT NOT NULL CONSTRAINT FK__activity__evaluation_category FOREIGN KEY(evaluation_category_id) REFERENCES evaluation_category(id),
	file_id INT CONSTRAINT FK__activity__file FOREIGN KEY(file_id) REFERENCES [file](id)
)
GO

CREATE TABLE student_activity (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__student_activity PRIMARY KEY(id),
	activity_id INT NOT NULL CONSTRAINT FK__student_activity__activity FOREIGN KEY(activity_id) REFERENCES activity(id),
	student_id VARCHAR(128) NOT NULL,
	file_id INT CONSTRAINT FK__student_activity__file_id__archive FOREIGN KEY(file_id) REFERENCES [file](id),
	upload_date DATETIME NOT NULL,
	professor_file_id INT CONSTRAINT FK__student_activity__professor_file_id__archive FOREIGN KEY(professor_file_id) REFERENCES [file](id),
	comment TEXT,
	grade FLOAT CONSTRAINT CHK__student_activity_review__grade CHECK(grade >= 0)
)
GO

CREATE TABLE enrollment_period (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__enrollment_period PRIMARY KEY(id),
	name VARCHAR(255) NOT NULL,
	start_datetime DATETIME NOT NULL,
	end_datetime DATETIME NOT NULL,
	is_open BIT NOT NULL,
	period_id INT NOT NULL CONSTRAINT FK__enrollment_period__period FOREIGN KEY(period_id) REFERENCES period(id),
	CONSTRAINT CHK__enrollment_period__start_datetime__end_datetime CHECK(start_datetime < end_datetime)
)
GO

CREATE TABLE student_enrollment_period (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__student_enrollment_time PRIMARY KEY(id),
	student_id VARCHAR(128) NOT NULL,
	enrollment_period_id INT NOT NULL CONSTRAINT FK__student_enrollment_period__enrollment_period FOREIGN KEY(enrollment_period_id) REFERENCES enrollment_period(id)
)
GO

CREATE TABLE student_waiting_enrollment (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__student_waiting_enrollment PRIMARY KEY(id),
	student_id VARCHAR(128) NOT NULL,
	enrollment_period_id INT NOT NULL CONSTRAINT FK__student_waiting_enrollment__enrollment_period FOREIGN KEY(enrollment_period_id) REFERENCES enrollment_period(id),
	class_id INT NOT NULL CONSTRAINT FK__student_waiting_enrollment__class FOREIGN KEY(class_id) REFERENCES class(id)
)
GO

CREATE TABLE class_rating (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__class_rating PRIMARY KEY(id),
	class_id INT NOT NULL CONSTRAINT FK__class_rating__class FOREIGN KEY(class_id) REFERENCES class(id),
	difficulty INT NOT NULL CONSTRAINT CHK__class_rating__difficulty CHECK(difficulty BETWEEN 1 AND 10),
	quality INT NOT NULL CONSTRAINT CHK__class_rating__quality CHECK(quality BETWEEN 1 AND 10),
	overall_grade INT NOT NULL CONSTRAINT CHK__class_rating__overall_grade CHECK(overall_grade BETWEEN 1 AND 10),
	comment VARCHAR(255)
)
GO

CREATE TABLE grade_record (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__grade_record PRIMARY KEY(id),
	student_id VARCHAR(128) NOT NULL,
	course_id CHAR(4) NOT NULL CONSTRAINT FK__grade_record__course FOREIGN KEY(course_id) REFERENCES course(id),
	period_id INT NOT NULL CONSTRAINT FK__grade_record__period FOREIGN KEY(period_id) REFERENCES period(id),
	grade INT NOT NULL CONSTRAINT CHK__grade_record__grade CHECK(grade >= 0)
)
GO