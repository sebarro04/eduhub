CREATE TABLE role (
    id INT NOT NULL CONSTRAINT PK__role PRIMARY KEY(id),
    name VARCHAR(256) NOT NULL CONSTRAINT UQ__role__name UNIQUE(name)
)
GO

CREATE TABLE person (
	id CHAR(10) NOT NULL CONSTRAINT PK__user PRIMARY KEY(id),
	identity_card CHAR(9) NOT NULL CONSTRAINT UQ__user__identity_card UNIQUE(identity_card),
	name NVARCHAR(256) NOT NULL,
	last_name NVARCHAR(256) NOT NULL,
	second_last_name NVARCHAR(256) NOT NULL,
	email NVARCHAR(255) NOT NULL CONSTRAINT UQ__user__email UNIQUE(email),
	birth_date DATE NOT NULL,
	phone_number CHAR(8) NOT NULL
)
GO

CREATE TABLE period_type (
	id INT NOT NULL CONSTRAINT PK__period_type PRIMARY KEY(id),
	name VARCHAR(256) NOT NULL CONSTRAINT UQ__school_period_type__name UNIQUE(name)
)
GO

CREATE TABLE period_status (
	id INT NOT NULL CONSTRAINT PK__school_period_status PRIMARY KEY(id),
	name VARCHAR(256) NOT NULL CONSTRAINT UQ__school_period_status__name UNIQUE(name)
)
GO

CREATE TABLE school_period (
	id INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK__school_period PRIMARY KEY(id),
	period_type_id INT NOT NULL CONSTRAINT FK__school_period__period_type FOREIGN KEY(period_type_id) REFERENCES period_type(id),
	start_time DATE NOT NULL,
	end_time DATE NOT NULL,
	period_status_id INT NOT NULL CONSTRAINT FK__school_period__period_status FOREIGN KEY(period_status_id) REFERENCES period_status(id),
	CONSTRAINT CHK__school_period__start_time__end_time CHECK(start_time < end_time)
)
GO

CREATE TABLE school (
	id CHAR(2) NOT NULL CONSTRAINT PK__id PRIMARY KEY(id),
	name VARCHAR(256) NOT NULL CONSTRAINT UQ__school__name UNIQUE(name),
	email NVARCHAR(255) NOT NULL CONSTRAINT UQ__school__email UNIQUE(email),
	phone_number CHAR(8) NOT NULL CONSTRAINT UQ__school__phone_number UNIQUE(phone_number),
	person_id CHAR(10) NOT NULL CONSTRAINT FK__school__person FOREIGN KEY(person_id) REFERENCES person(id)
)
GO

CREATE TABLE archive_type (
	id
)
GO

CREATE TABLE archive (
	id INT IDENTITY(1, 1) CONSTRAINT PK__archive PRIMARY KEY(id),
	name NVARCHAR(255) NOT NULL,
	directory NVARCHAR(255) NOT NULL,
	creation_time DATETIME NOT NULL,
	last_update_time DATETIME NOT NULL,
	type 
)
GO

CREATE TABLE course (
	id CHAR(4) NOT NULL CONSTRAINT PK__course PRIMARY KEY(id),
	name VARCHAR(256) NOT NULL CONSTRAINT UQ__course__name UNIQUE(name),
	period_type_id INT NOT NULL CONSTRAINT FK__course__period_type FOREIGN KEY(period_type_id) REFERENCES period_type(id),
	credits INT NOT NULL CONSTRAINT CHK__course__credits CHECK(credits >= 0),
	school_id CHAR(2) NOT NULL CONSTRAINT FK__course__school FOREIGN KEY(school_id) REFERENCES school(id),
	class_hours_week INT NOT NULL CONSTRAINT CHK__course__class_hours_week CHECK(class_hours_week > 0),
	description TEXT NOT NULL
)
GO

CREATE TABLE career (
	id INT IDENTITY(1, 1) CONSTRAINT PK__career PRIMARY KEY(id),
	name VARCHAR(256)
)
GO