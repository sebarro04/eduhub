/****** Object:  Database [db01]    Script Date: 30/4/2023 23:23:09 ******/
CREATE DATABASE [db01]  (EDITION = 'Standard', SERVICE_OBJECTIVE = 'S0', MAXSIZE = 5 GB) WITH CATALOG_COLLATION = SQL_Latin1_General_CP1_CI_AS, LEDGER = OFF;
GO
ALTER DATABASE [db01] SET COMPATIBILITY_LEVEL = 150
GO
ALTER DATABASE [db01] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [db01] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [db01] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [db01] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [db01] SET ARITHABORT OFF 
GO
ALTER DATABASE [db01] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [db01] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [db01] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [db01] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [db01] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [db01] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [db01] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [db01] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [db01] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [db01] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [db01] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [db01] SET  MULTI_USER 
GO
ALTER DATABASE [db01] SET ENCRYPTION ON
GO
ALTER DATABASE [db01] SET QUERY_STORE = ON
GO
ALTER DATABASE [db01] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 100, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
/*** The scripts of database scoped configurations in Azure should be executed inside the target database connection. ***/
GO
-- ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 8;
GO
/****** Object:  Table [dbo].[activity]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[activity](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[description] [text] NOT NULL,
	[due_date] [datetime] NOT NULL,
	[percentage] [float] NOT NULL,
	[evaluation_category_id] [int] NOT NULL,
	[file_id] [int] NULL,
 CONSTRAINT [PK__activity] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[career]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[career](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[school_id] [char](2) NOT NULL,
	[description] [text] NOT NULL,
 CONSTRAINT [PK__career] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[class]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[class](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[course_id] [char](4) NOT NULL,
	[period_id] [int] NOT NULL,
	[professor_id] [varchar](128) NOT NULL,
	[max_student_capacity] [int] NOT NULL,
 CONSTRAINT [PK__class] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[class_rating]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[class_rating](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[class_id] [int] NOT NULL,
	[difficulty] [int] NOT NULL,
	[quality] [int] NOT NULL,
	[overall_grade] [int] NOT NULL,
	[comment] [varchar](255) NULL,
 CONSTRAINT [PK__class_rating] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[course]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[course](
	[id] [char](4) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[period_type_id] [int] NOT NULL,
	[credits] [int] NOT NULL,
	[school_id] [char](2) NOT NULL,
	[class_hours_week] [int] NOT NULL,
	[description] [text] NOT NULL,
 CONSTRAINT [PK__course] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[curriculum]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[curriculum](
	[id] [varchar](4) NOT NULL,
	[curriculum_status_id] [int] NOT NULL,
	[career_id] [int] NOT NULL,
	[creation_date] [date] NOT NULL,
	[activation_date] [date] NOT NULL,
	[finish_date] [date] NOT NULL,
 CONSTRAINT [PK__curriculum] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[curriculum_course]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[curriculum_course](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[curriculum_id] [varchar](4) NOT NULL,
	[course_id] [char](4) NOT NULL,
 CONSTRAINT [PK__curriculum_course] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[curriculum_course_dependency]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[curriculum_course_dependency](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[curriculum_id] [varchar](4) NOT NULL,
	[course_id] [char](4) NOT NULL,
	[course_dependency_id] [char](4) NOT NULL,
 CONSTRAINT [PK__course_dependency] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[curriculum_course_prerequisite]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[curriculum_course_prerequisite](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[curriculum_id] [varchar](4) NOT NULL,
	[course_id] [char](4) NOT NULL,
	[course_prerequisite_id] [char](4) NOT NULL,
 CONSTRAINT [PK__curriculum_course_prerequisite] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[curriculum_status]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[curriculum_status](
	[id] [int] NOT NULL,
	[name] [varchar](255) NOT NULL,
 CONSTRAINT [PK__curriculum_status] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[day]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[day](
	[id] [int] NOT NULL,
	[name] [varchar](255) NOT NULL,
 CONSTRAINT [PK__day] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[enrollment_period]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[enrollment_period](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[start_datetime] [datetime] NOT NULL,
	[end_datetime] [datetime] NOT NULL,
	[is_open] [bit] NOT NULL,
	[period_id] [int] NOT NULL,
 CONSTRAINT [PK__enrollment_period] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[evaluation]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[evaluation](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[class_id] [int] NOT NULL,
 CONSTRAINT [PK__evaluation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[evaluation_category]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[evaluation_category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[percentage] [int] NOT NULL,
	[evaluation_id] [int] NOT NULL,
 CONSTRAINT [PK__evaluation_category] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[file]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[file](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](242) NOT NULL,
	[description] [varchar](256) NULL,
	[url] [varchar](256) NOT NULL,
	[user_id] [varchar](128) NOT NULL,
	[class_id] [int] NULL,
	[creation_datetime] [datetime] NOT NULL,
	[last_modified_datetime] [datetime] NULL,
 CONSTRAINT [PK__file] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[grade_record]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[grade_record](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [varchar](128) NOT NULL,
	[course_id] [char](4) NOT NULL,
	[period_id] [int] NOT NULL,
	[grade] [int] NOT NULL,
 CONSTRAINT [PK__grade_record] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[period]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[period](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[period_type_id] [int] NOT NULL,
	[start_date] [date] NOT NULL,
	[end_date] [date] NOT NULL,
	[period_status_id] [int] NOT NULL,
 CONSTRAINT [PK__period] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[period_status]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[period_status](
	[id] [int] NOT NULL,
	[name] [varchar](255) NOT NULL,
 CONSTRAINT [PK__period_status] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[period_type]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[period_type](
	[id] [int] NOT NULL,
	[name] [varchar](255) NOT NULL,
 CONSTRAINT [PK__period_type] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[professor_school]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[professor_school](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[professor_id] [varchar](128) NOT NULL,
	[school_id] [char](2) NOT NULL,
 CONSTRAINT [PK__professor_school] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[role]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[role](
	[id] [int] NOT NULL,
	[name] [varchar](15) NOT NULL,
 CONSTRAINT [PK__role] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[schedule]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[schedule](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[class_id] [int] NOT NULL,
	[day_id] [int] NOT NULL,
	[start_time] [time](7) NOT NULL,
	[end_time] [time](7) NOT NULL,
 CONSTRAINT [PK__schedule] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[school]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[school](
	[id] [char](2) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[email] [nvarchar](255) NOT NULL,
	[phone_number] [char](8) NOT NULL,
	[director_id] [varchar](128) NOT NULL,
 CONSTRAINT [PK__id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[student_activity]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[student_activity](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[activity_id] [int] NOT NULL,
	[student_id] [varchar](128) NOT NULL,
	[file_id] [int] NULL,
	[upload_date] [datetime] NOT NULL,
	[professor_file_id] [int] NULL,
	[comment] [text] NULL,
	[grade] [float] NULL,
 CONSTRAINT [PK__student_activity] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[student_class]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[student_class](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [varchar](128) NOT NULL,
	[class_id] [int] NOT NULL,
 CONSTRAINT [PK__student_class] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[student_curriculum]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[student_curriculum](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [varchar](128) NOT NULL,
	[curriculum_id] [varchar](4) NOT NULL,
 CONSTRAINT [PK__student_curriculum] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[student_enrollment_period]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[student_enrollment_period](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [varchar](128) NOT NULL,
	[enrollment_period_id] [int] NOT NULL,
 CONSTRAINT [PK__student_enrollment_time] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[student_waiting_enrollment]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[student_waiting_enrollment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [varchar](128) NOT NULL,
	[enrollment_period_id] [int] NOT NULL,
	[class_id] [int] NOT NULL,
 CONSTRAINT [PK__student_waiting_enrollment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_role]    Script Date: 30/4/2023 23:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_role](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [varchar](128) NOT NULL,
	[role_id] [int] NOT NULL,
 CONSTRAINT [PK__user_role] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[career] ON 

INSERT [dbo].[career] ([id], [name], [school_id], [description]) VALUES (2, N'Ingenieria en Computación', N'IC', N'¡Bienvenido a la carrer de Ingenieria en computacion!')
SET IDENTITY_INSERT [dbo].[career] OFF
GO
SET IDENTITY_INSERT [dbo].[class] ON 

INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (8, N'0202', 8, N'professor1-0202', 23)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (9, N'0202', 8, N'professor2-0202', 30)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (10, N'0202', 9, N'professor1-0202', 20)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (11, N'0202', 9, N'professor2-0202', 22)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (12, N'0101', 8, N'professor1-0101', 26)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (13, N'0101', 8, N'professor2-0101', 29)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (14, N'0101', 9, N'professor1-0101', 21)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (15, N'0101', 9, N'professor2-0101', 23)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (16, N'1106', 8, N'professor1-1106', 26)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (17, N'1106', 8, N'professor2-1106', 28)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (18, N'1106', 9, N'professor1-1106', 22)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (19, N'1106', 9, N'professor2-1106', 24)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (20, N'1400', 8, N'professor1-1400', 28)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (21, N'1400', 8, N'professor2-1400', 27)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (22, N'1400', 9, N'professor1-1400', 23)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (23, N'1400', 9, N'professor2-1400', 25)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (24, N'1802', 8, N'professor1-1802', 29)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (25, N'1802', 8, N'professor2-1802', 25)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (26, N'1802', 9, N'professor1-1802', 24)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (27, N'1802', 9, N'professor2-1802', 26)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (28, N'1803', 8, N'professor1-1803', 29)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (29, N'1803', 8, N'professor2-1803', 25)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (30, N'1803', 9, N'professor1-1803', 25)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (31, N'1803', 9, N'professor2-1803', 27)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (32, N'1403', 8, N'professor1-1403', 31)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (33, N'1403', 8, N'professor2-1403', 29)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (34, N'1403', 9, N'professor1-1403', 26)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (35, N'1403', 9, N'professor2-1403', 28)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (36, N'1100', 8, N'professor1-1100', 31)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (37, N'1100', 8, N'professor2-1100', 31)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (38, N'1100', 9, N'professor1-1100', 27)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (39, N'1100', 9, N'professor2-1100', 29)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (40, N'1230', 8, N'professor1-1230', 33)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (41, N'1230', 8, N'professor2-1230', 32)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (42, N'1230', 9, N'professor1-1230', 28)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (43, N'1230', 9, N'professor2-1230', 30)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (44, N'1000', 10, N'professor1-1000', 30)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (45, N'1000', 10, N'professor2-1000', 26)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (46, N'2001', 8, N'professor1-2001', 29)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (47, N'2001', 8, N'professor2-2001', 27)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (48, N'2001', 9, N'professor1-2001', 29)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (49, N'2001', 9, N'professor2-2001', 31)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (50, N'2101', 8, N'professor1-2101', 28)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (51, N'2101', 8, N'professor2-2101', 28)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (52, N'2101', 9, N'professor1-2101', 30)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (53, N'2101', 9, N'professor2-2101', 32)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (54, N'3101', 8, N'professor1-3101', 26)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (55, N'3101', 8, N'professor2-3101', 28)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (56, N'3101', 9, N'professor1-3101', 31)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (57, N'3101', 9, N'professor2-3101', 33)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (58, N'1102', 8, N'professor1-1102', 26)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (59, N'1102', 8, N'professor2-1102', 30)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (60, N'1102', 9, N'professor1-1102', 32)
INSERT [dbo].[class] ([id], [course_id], [period_id], [professor_id], [max_student_capacity]) VALUES (61, N'1102', 9, N'professor2-1102', 34)
SET IDENTITY_INSERT [dbo].[class] OFF
GO
INSERT [dbo].[course] ([id], [name], [period_type_id], [credits], [school_id], [class_hours_week], [description]) VALUES (N'0101', N'Matematica General', 2, 2, N'MA', 4, N'Curso de Matematica General')
INSERT [dbo].[course] ([id], [name], [period_type_id], [credits], [school_id], [class_hours_week], [description]) VALUES (N'0202', N'Ingles basico', 2, 2, N'CI', 4, N'Curso de Ingles Basico')
INSERT [dbo].[course] ([id], [name], [period_type_id], [credits], [school_id], [class_hours_week], [description]) VALUES (N'1000', N'CFH', 3, 0, N'FH', 4, N'CFH')
INSERT [dbo].[course] ([id], [name], [period_type_id], [credits], [school_id], [class_hours_week], [description]) VALUES (N'1100', N'Actividad Cultural', 2, 0, N'SE', 2, N'Actividad Cultural 1')
INSERT [dbo].[course] ([id], [name], [period_type_id], [credits], [school_id], [class_hours_week], [description]) VALUES (N'1102', N'Calculo Diferencial e Integral', 2, 4, N'IC', 4, N'CDI')
INSERT [dbo].[course] ([id], [name], [period_type_id], [credits], [school_id], [class_hours_week], [description]) VALUES (N'1106', N'Comunicacion escrita', 2, 2, N'CI', 4, N'Curso de Comunicacion Escrita')
INSERT [dbo].[course] ([id], [name], [period_type_id], [credits], [school_id], [class_hours_week], [description]) VALUES (N'1230', N'Ingles 1', 2, 2, N'CI', 4, N'Curso de Ingles 1')
INSERT [dbo].[course] ([id], [name], [period_type_id], [credits], [school_id], [class_hours_week], [description]) VALUES (N'1400', N'FOC', 2, 3, N'IC', 4, N'Curso de FOC')
INSERT [dbo].[course] ([id], [name], [period_type_id], [credits], [school_id], [class_hours_week], [description]) VALUES (N'1403', N'Matematica Discreta', 2, 4, N'MA', 4, N'Curso de MD')
INSERT [dbo].[course] ([id], [name], [period_type_id], [credits], [school_id], [class_hours_week], [description]) VALUES (N'1802', N'Introduccion a la programacion', 2, 3, N'IC', 4, N'Intro')
INSERT [dbo].[course] ([id], [name], [period_type_id], [credits], [school_id], [class_hours_week], [description]) VALUES (N'1803', N'Taller de programacion', 2, 3, N'IC', 4, N'Curso de Taller')
INSERT [dbo].[course] ([id], [name], [period_type_id], [credits], [school_id], [class_hours_week], [description]) VALUES (N'2001', N'Estructuras de Datos', 2, 4, N'IC', 4, N'ED')
INSERT [dbo].[course] ([id], [name], [period_type_id], [credits], [school_id], [class_hours_week], [description]) VALUES (N'2101', N'Programacion Orientada a Objetos', 2, 3, N'IC', 4, N'POO')
INSERT [dbo].[course] ([id], [name], [period_type_id], [credits], [school_id], [class_hours_week], [description]) VALUES (N'3101', N'Arquitectura de Computadoras', 2, 4, N'IC', 4, N'Curso de ')
GO
INSERT [dbo].[curriculum] ([id], [curriculum_status_id], [career_id], [creation_date], [activation_date], [finish_date]) VALUES (N'0001', 2, 2, CAST(N'2016-01-01' AS Date), CAST(N'2016-02-01' AS Date), CAST(N'2026-01-01' AS Date))
GO
SET IDENTITY_INSERT [dbo].[curriculum_course] ON 

INSERT [dbo].[curriculum_course] ([id], [curriculum_id], [course_id]) VALUES (8, N'0001', N'0202')
INSERT [dbo].[curriculum_course] ([id], [curriculum_id], [course_id]) VALUES (9, N'0001', N'0101')
INSERT [dbo].[curriculum_course] ([id], [curriculum_id], [course_id]) VALUES (10, N'0001', N'1106')
INSERT [dbo].[curriculum_course] ([id], [curriculum_id], [course_id]) VALUES (11, N'0001', N'1400')
INSERT [dbo].[curriculum_course] ([id], [curriculum_id], [course_id]) VALUES (12, N'0001', N'1802')
INSERT [dbo].[curriculum_course] ([id], [curriculum_id], [course_id]) VALUES (13, N'0001', N'1803')
INSERT [dbo].[curriculum_course] ([id], [curriculum_id], [course_id]) VALUES (14, N'0001', N'1403')
INSERT [dbo].[curriculum_course] ([id], [curriculum_id], [course_id]) VALUES (15, N'0001', N'1100')
INSERT [dbo].[curriculum_course] ([id], [curriculum_id], [course_id]) VALUES (16, N'0001', N'1230')
INSERT [dbo].[curriculum_course] ([id], [curriculum_id], [course_id]) VALUES (17, N'0001', N'1000')
INSERT [dbo].[curriculum_course] ([id], [curriculum_id], [course_id]) VALUES (18, N'0001', N'2001')
INSERT [dbo].[curriculum_course] ([id], [curriculum_id], [course_id]) VALUES (19, N'0001', N'2101')
INSERT [dbo].[curriculum_course] ([id], [curriculum_id], [course_id]) VALUES (20, N'0001', N'3101')
INSERT [dbo].[curriculum_course] ([id], [curriculum_id], [course_id]) VALUES (21, N'0001', N'1102')
SET IDENTITY_INSERT [dbo].[curriculum_course] OFF
GO
SET IDENTITY_INSERT [dbo].[curriculum_course_dependency] ON 

INSERT [dbo].[curriculum_course_dependency] ([id], [curriculum_id], [course_id], [course_dependency_id]) VALUES (1, N'0001', N'1803', N'1802')
INSERT [dbo].[curriculum_course_dependency] ([id], [curriculum_id], [course_id], [course_dependency_id]) VALUES (2, N'0001', N'2001', N'2101')
SET IDENTITY_INSERT [dbo].[curriculum_course_dependency] OFF
GO
SET IDENTITY_INSERT [dbo].[curriculum_course_prerequisite] ON 

INSERT [dbo].[curriculum_course_prerequisite] ([id], [curriculum_id], [course_id], [course_prerequisite_id]) VALUES (4, N'0001', N'2001', N'1802')
INSERT [dbo].[curriculum_course_prerequisite] ([id], [curriculum_id], [course_id], [course_prerequisite_id]) VALUES (5, N'0001', N'2001', N'1803')
INSERT [dbo].[curriculum_course_prerequisite] ([id], [curriculum_id], [course_id], [course_prerequisite_id]) VALUES (6, N'0001', N'2101', N'1802')
INSERT [dbo].[curriculum_course_prerequisite] ([id], [curriculum_id], [course_id], [course_prerequisite_id]) VALUES (7, N'0001', N'2101', N'1803')
INSERT [dbo].[curriculum_course_prerequisite] ([id], [curriculum_id], [course_id], [course_prerequisite_id]) VALUES (8, N'0001', N'3101', N'1400')
INSERT [dbo].[curriculum_course_prerequisite] ([id], [curriculum_id], [course_id], [course_prerequisite_id]) VALUES (9, N'0001', N'1102', N'0101')
SET IDENTITY_INSERT [dbo].[curriculum_course_prerequisite] OFF
GO
INSERT [dbo].[curriculum_status] ([id], [name]) VALUES (2, N'Activo')
INSERT [dbo].[curriculum_status] ([id], [name]) VALUES (3, N'Cerrado')
INSERT [dbo].[curriculum_status] ([id], [name]) VALUES (1, N'Creación')
GO
INSERT [dbo].[day] ([id], [name]) VALUES (4, N'Jueves')
INSERT [dbo].[day] ([id], [name]) VALUES (1, N'Lunes')
INSERT [dbo].[day] ([id], [name]) VALUES (2, N'Martes')
INSERT [dbo].[day] ([id], [name]) VALUES (3, N'Miércoles')
INSERT [dbo].[day] ([id], [name]) VALUES (6, N'Sábado')
INSERT [dbo].[day] ([id], [name]) VALUES (5, N'Viernes')
GO
SET IDENTITY_INSERT [dbo].[enrollment_period] ON 

INSERT [dbo].[enrollment_period] ([id], [name], [start_datetime], [end_datetime], [is_open], [period_id]) VALUES (8, N'Ordinaria', CAST(N'2023-07-01T07:00:00.000' AS DateTime), CAST(N'2023-07-02T16:00:00.000' AS DateTime), 1, 8)
INSERT [dbo].[enrollment_period] ([id], [name], [start_datetime], [end_datetime], [is_open], [period_id]) VALUES (9, N'Ordinaria', CAST(N'2024-02-01T07:00:00.000' AS DateTime), CAST(N'2024-02-02T16:00:00.000' AS DateTime), 0, 9)
INSERT [dbo].[enrollment_period] ([id], [name], [start_datetime], [end_datetime], [is_open], [period_id]) VALUES (10, N'CFH', CAST(N'2023-07-28T07:00:00.000' AS DateTime), CAST(N'2023-07-29T16:00:00.000' AS DateTime), 0, 10)
SET IDENTITY_INSERT [dbo].[enrollment_period] OFF
GO
SET IDENTITY_INSERT [dbo].[grade_record] ON 

INSERT [dbo].[grade_record] ([id], [student_id], [course_id], [period_id], [grade]) VALUES (11, N'I4jurZC2gpNEvpnWGb9iYQkVpXy1', N'0101', 11, 85)
INSERT [dbo].[grade_record] ([id], [student_id], [course_id], [period_id], [grade]) VALUES (12, N'I4jurZC2gpNEvpnWGb9iYQkVpXy1', N'0202', 11, 60)
INSERT [dbo].[grade_record] ([id], [student_id], [course_id], [period_id], [grade]) VALUES (13, N'I4jurZC2gpNEvpnWGb9iYQkVpXy1', N'1400', 11, 80)
SET IDENTITY_INSERT [dbo].[grade_record] OFF
GO
SET IDENTITY_INSERT [dbo].[period] ON 

INSERT [dbo].[period] ([id], [period_type_id], [start_date], [end_date], [period_status_id]) VALUES (8, 2, CAST(N'2023-07-06' AS Date), CAST(N'2023-11-22' AS Date), 1)
INSERT [dbo].[period] ([id], [period_type_id], [start_date], [end_date], [period_status_id]) VALUES (9, 2, CAST(N'2024-02-04' AS Date), CAST(N'2024-06-01' AS Date), 1)
INSERT [dbo].[period] ([id], [period_type_id], [start_date], [end_date], [period_status_id]) VALUES (10, 3, CAST(N'2023-08-01' AS Date), CAST(N'2023-10-27' AS Date), 1)
INSERT [dbo].[period] ([id], [period_type_id], [start_date], [end_date], [period_status_id]) VALUES (11, 2, CAST(N'2022-06-01' AS Date), CAST(N'2023-11-10' AS Date), 3)
SET IDENTITY_INSERT [dbo].[period] OFF
GO
INSERT [dbo].[period_status] ([id], [name]) VALUES (1, N'Creado')
INSERT [dbo].[period_status] ([id], [name]) VALUES (2, N'En progreso')
INSERT [dbo].[period_status] ([id], [name]) VALUES (3, N'Finalizado')
GO
INSERT [dbo].[period_type] ([id], [name]) VALUES (1, N'Anual')
INSERT [dbo].[period_type] ([id], [name]) VALUES (5, N'Bimestral')
INSERT [dbo].[period_type] ([id], [name]) VALUES (4, N'Cuatrimestral')
INSERT [dbo].[period_type] ([id], [name]) VALUES (2, N'Semestral')
INSERT [dbo].[period_type] ([id], [name]) VALUES (3, N'Trimestral')
GO
SET IDENTITY_INSERT [dbo].[professor_school] ON 

INSERT [dbo].[professor_school] ([id], [professor_id], [school_id]) VALUES (1, N'professor-compu', N'IC')
SET IDENTITY_INSERT [dbo].[professor_school] OFF
GO
INSERT [dbo].[role] ([id], [name]) VALUES (1, N'Administrador')
INSERT [dbo].[role] ([id], [name]) VALUES (4, N'Asistente')
INSERT [dbo].[role] ([id], [name]) VALUES (3, N'Estudiante')
INSERT [dbo].[role] ([id], [name]) VALUES (2, N'Profesor')
GO
SET IDENTITY_INSERT [dbo].[schedule] ON 

INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (8, 8, 1, CAST(N'07:30:00' AS Time), CAST(N'09:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (9, 8, 3, CAST(N'07:30:00' AS Time), CAST(N'09:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (10, 9, 1, CAST(N'09:30:00' AS Time), CAST(N'11:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (11, 9, 3, CAST(N'09:30:00' AS Time), CAST(N'11:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (12, 10, 1, CAST(N'13:00:00' AS Time), CAST(N'17:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (13, 11, 1, CAST(N'15:00:00' AS Time), CAST(N'17:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (14, 11, 3, CAST(N'15:00:00' AS Time), CAST(N'17:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (15, 12, 1, CAST(N'18:00:00' AS Time), CAST(N'20:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (16, 12, 3, CAST(N'18:00:00' AS Time), CAST(N'20:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (17, 13, 2, CAST(N'07:30:00' AS Time), CAST(N'09:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (18, 13, 4, CAST(N'07:30:00' AS Time), CAST(N'09:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (19, 14, 2, CAST(N'09:30:00' AS Time), CAST(N'11:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (20, 14, 4, CAST(N'09:30:00' AS Time), CAST(N'11:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (21, 15, 2, CAST(N'13:00:00' AS Time), CAST(N'14:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (22, 15, 4, CAST(N'13:00:00' AS Time), CAST(N'14:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (23, 16, 2, CAST(N'15:00:00' AS Time), CAST(N'17:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (24, 16, 4, CAST(N'15:00:00' AS Time), CAST(N'17:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (25, 17, 2, CAST(N'18:00:00' AS Time), CAST(N'20:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (26, 17, 4, CAST(N'18:00:00' AS Time), CAST(N'20:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (27, 18, 3, CAST(N'07:30:00' AS Time), CAST(N'09:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (28, 18, 5, CAST(N'07:30:00' AS Time), CAST(N'09:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (29, 19, 3, CAST(N'09:30:00' AS Time), CAST(N'11:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (30, 19, 5, CAST(N'09:30:00' AS Time), CAST(N'11:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (31, 20, 3, CAST(N'13:00:00' AS Time), CAST(N'14:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (32, 20, 5, CAST(N'13:00:00' AS Time), CAST(N'14:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (33, 21, 3, CAST(N'15:00:00' AS Time), CAST(N'17:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (34, 21, 5, CAST(N'15:00:00' AS Time), CAST(N'17:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (35, 22, 3, CAST(N'18:00:00' AS Time), CAST(N'20:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (36, 22, 5, CAST(N'18:00:00' AS Time), CAST(N'20:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (37, 23, 2, CAST(N'07:30:00' AS Time), CAST(N'11:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (38, 24, 2, CAST(N'09:30:00' AS Time), CAST(N'11:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (39, 24, 5, CAST(N'09:30:00' AS Time), CAST(N'11:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (40, 25, 2, CAST(N'13:00:00' AS Time), CAST(N'14:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (41, 25, 5, CAST(N'13:00:00' AS Time), CAST(N'14:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (42, 26, 2, CAST(N'15:00:00' AS Time), CAST(N'17:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (43, 26, 5, CAST(N'15:00:00' AS Time), CAST(N'17:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (44, 27, 2, CAST(N'18:00:00' AS Time), CAST(N'20:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (45, 27, 5, CAST(N'18:00:00' AS Time), CAST(N'20:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (46, 28, 1, CAST(N'07:30:00' AS Time), CAST(N'09:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (47, 28, 4, CAST(N'07:30:00' AS Time), CAST(N'09:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (48, 29, 1, CAST(N'09:30:00' AS Time), CAST(N'11:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (49, 29, 4, CAST(N'09:30:00' AS Time), CAST(N'11:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (50, 30, 1, CAST(N'15:00:00' AS Time), CAST(N'17:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (51, 30, 4, CAST(N'15:00:00' AS Time), CAST(N'17:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (52, 31, 1, CAST(N'18:00:00' AS Time), CAST(N'20:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (53, 31, 4, CAST(N'18:00:00' AS Time), CAST(N'20:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (54, 32, 1, CAST(N'07:30:00' AS Time), CAST(N'09:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (55, 32, 3, CAST(N'07:30:00' AS Time), CAST(N'09:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (56, 33, 1, CAST(N'09:30:00' AS Time), CAST(N'11:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (57, 33, 3, CAST(N'09:30:00' AS Time), CAST(N'11:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (58, 34, 1, CAST(N'13:00:00' AS Time), CAST(N'14:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (59, 34, 3, CAST(N'13:00:00' AS Time), CAST(N'14:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (60, 35, 1, CAST(N'15:00:00' AS Time), CAST(N'20:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (61, 36, 1, CAST(N'18:00:00' AS Time), CAST(N'20:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (62, 36, 3, CAST(N'18:00:00' AS Time), CAST(N'20:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (63, 37, 2, CAST(N'07:30:00' AS Time), CAST(N'09:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (64, 37, 4, CAST(N'07:30:00' AS Time), CAST(N'09:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (65, 38, 2, CAST(N'09:30:00' AS Time), CAST(N'11:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (66, 38, 4, CAST(N'09:30:00' AS Time), CAST(N'11:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (67, 39, 2, CAST(N'13:00:00' AS Time), CAST(N'14:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (68, 39, 4, CAST(N'13:00:00' AS Time), CAST(N'14:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (69, 40, 2, CAST(N'15:00:00' AS Time), CAST(N'17:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (70, 40, 4, CAST(N'15:00:00' AS Time), CAST(N'17:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (71, 41, 2, CAST(N'18:00:00' AS Time), CAST(N'20:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (72, 41, 4, CAST(N'18:00:00' AS Time), CAST(N'20:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (73, 42, 3, CAST(N'07:30:00' AS Time), CAST(N'09:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (74, 42, 5, CAST(N'07:30:00' AS Time), CAST(N'09:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (75, 43, 3, CAST(N'09:30:00' AS Time), CAST(N'11:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (76, 43, 5, CAST(N'09:30:00' AS Time), CAST(N'11:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (77, 44, 1, CAST(N'07:30:00' AS Time), CAST(N'09:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (78, 45, 6, CAST(N'07:30:00' AS Time), CAST(N'09:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (79, 46, 3, CAST(N'13:00:00' AS Time), CAST(N'14:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (80, 46, 5, CAST(N'13:00:00' AS Time), CAST(N'14:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (81, 47, 3, CAST(N'15:00:00' AS Time), CAST(N'17:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (82, 47, 5, CAST(N'15:00:00' AS Time), CAST(N'17:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (83, 48, 3, CAST(N'18:00:00' AS Time), CAST(N'20:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (84, 48, 5, CAST(N'18:00:00' AS Time), CAST(N'20:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (85, 49, 4, CAST(N'07:30:00' AS Time), CAST(N'09:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (86, 49, 6, CAST(N'07:30:00' AS Time), CAST(N'09:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (87, 50, 4, CAST(N'09:30:00' AS Time), CAST(N'11:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (88, 50, 6, CAST(N'09:30:00' AS Time), CAST(N'11:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (89, 51, 4, CAST(N'13:00:00' AS Time), CAST(N'14:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (90, 51, 6, CAST(N'13:00:00' AS Time), CAST(N'14:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (91, 52, 4, CAST(N'15:00:00' AS Time), CAST(N'17:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (92, 52, 6, CAST(N'15:00:00' AS Time), CAST(N'17:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (93, 53, 4, CAST(N'18:00:00' AS Time), CAST(N'20:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (94, 53, 6, CAST(N'18:00:00' AS Time), CAST(N'20:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (95, 54, 2, CAST(N'07:30:00' AS Time), CAST(N'09:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (96, 54, 5, CAST(N'07:30:00' AS Time), CAST(N'09:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (97, 55, 2, CAST(N'09:30:00' AS Time), CAST(N'11:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (98, 55, 5, CAST(N'09:30:00' AS Time), CAST(N'11:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (99, 56, 2, CAST(N'13:00:00' AS Time), CAST(N'14:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (100, 56, 5, CAST(N'13:00:00' AS Time), CAST(N'14:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (101, 57, 2, CAST(N'15:00:00' AS Time), CAST(N'17:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (102, 57, 5, CAST(N'15:00:00' AS Time), CAST(N'17:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (103, 58, 2, CAST(N'18:00:00' AS Time), CAST(N'20:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (104, 58, 5, CAST(N'18:00:00' AS Time), CAST(N'20:50:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (105, 59, 1, CAST(N'07:30:00' AS Time), CAST(N'09:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (106, 59, 5, CAST(N'07:30:00' AS Time), CAST(N'09:20:00' AS Time))
GO
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (107, 60, 1, CAST(N'09:30:00' AS Time), CAST(N'11:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (108, 60, 5, CAST(N'09:30:00' AS Time), CAST(N'11:20:00' AS Time))
INSERT [dbo].[schedule] ([id], [class_id], [day_id], [start_time], [end_time]) VALUES (109, 61, 1, CAST(N'07:30:00' AS Time), CAST(N'11:20:00' AS Time))
SET IDENTITY_INSERT [dbo].[schedule] OFF
GO
INSERT [dbo].[school] ([id], [name], [email], [phone_number], [director_id]) VALUES (N'CI', N'Escuela de Ciencias del Idioma', N'escuelaCienciasIdioma@itc.ac.cr', N'80457790', N'2')
INSERT [dbo].[school] ([id], [name], [email], [phone_number], [director_id]) VALUES (N'FH', N'Escuela de Centros de Formacion Humanistica', N'escuelaCFH@itc.ac.cr', N'86651740', N'5')
INSERT [dbo].[school] ([id], [name], [email], [phone_number], [director_id]) VALUES (N'IC', N'Escuela de Ingenieria en Computacion', N'escuelacomputacion@itc.ac.cr', N'83440015', N'1')
INSERT [dbo].[school] ([id], [name], [email], [phone_number], [director_id]) VALUES (N'MA', N'Escuela de Matematica', N'escuelaMatematica@itc.ac.cr', N'89920010', N'3')
INSERT [dbo].[school] ([id], [name], [email], [phone_number], [director_id]) VALUES (N'SE', N'Escuela de Ciencias Sociales', N'escuelaCienciasSociales@itc.ac.cr', N'84448052', N'4')
GO
SET IDENTITY_INSERT [dbo].[student_class] ON 

INSERT [dbo].[student_class] ([id], [student_id], [class_id]) VALUES (14, N'2021023224', 8)
INSERT [dbo].[student_class] ([id], [student_id], [class_id]) VALUES (18, N'2020091055', 8)
INSERT [dbo].[student_class] ([id], [student_id], [class_id]) VALUES (19, N'I4jurZC2gpNEvpnWGb9iYQkVpXy1', 8)
INSERT [dbo].[student_class] ([id], [student_id], [class_id]) VALUES (21, N'I4jurZC2gpNEvpnWGb9iYQkVpXy1', 16)
INSERT [dbo].[student_class] ([id], [student_id], [class_id]) VALUES (22, N'I4jurZC2gpNEvpnWGb9iYQkVpXy1', 33)
INSERT [dbo].[student_class] ([id], [student_id], [class_id]) VALUES (23, N'I4jurZC2gpNEvpnWGb9iYQkVpXy1', 25)
INSERT [dbo].[student_class] ([id], [student_id], [class_id]) VALUES (24, N'I4jurZC2gpNEvpnWGb9iYQkVpXy1', 55)
INSERT [dbo].[student_class] ([id], [student_id], [class_id]) VALUES (28, N'I4jurZC2gpNEvpnWGb9iYQkVpXy1', 36)
INSERT [dbo].[student_class] ([id], [student_id], [class_id]) VALUES (30, N'I4jurZC2gpNEvpnWGb9iYQkVpXy1', 54)
INSERT [dbo].[student_class] ([id], [student_id], [class_id]) VALUES (31, N'I4jurZC2gpNEvpnWGb9iYQkVpXy1', 28)
SET IDENTITY_INSERT [dbo].[student_class] OFF
GO
SET IDENTITY_INSERT [dbo].[student_curriculum] ON 

INSERT [dbo].[student_curriculum] ([id], [student_id], [curriculum_id]) VALUES (3, N'I4jurZC2gpNEvpnWGb9iYQkVpXy1', N'0001')
SET IDENTITY_INSERT [dbo].[student_curriculum] OFF
GO
SET IDENTITY_INSERT [dbo].[student_enrollment_period] ON 

INSERT [dbo].[student_enrollment_period] ([id], [student_id], [enrollment_period_id]) VALUES (5, N'I4jurZC2gpNEvpnWGb9iYQkVpXy1', 8)
INSERT [dbo].[student_enrollment_period] ([id], [student_id], [enrollment_period_id]) VALUES (6, N'I4jurZC2gpNEvpnWGb9iYQkVpXy1', 10)
SET IDENTITY_INSERT [dbo].[student_enrollment_period] OFF
GO
SET IDENTITY_INSERT [dbo].[user_role] ON 

INSERT [dbo].[user_role] ([id], [user_id], [role_id]) VALUES (11, N'I4jurZC2gpNEvpnWGb9iYQkVpXy1', 3)
SET IDENTITY_INSERT [dbo].[user_role] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__career__name]    Script Date: 30/4/2023 23:23:25 ******/
ALTER TABLE [dbo].[career] ADD  CONSTRAINT [UQ__career__name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__course__name]    Script Date: 30/4/2023 23:23:25 ******/
ALTER TABLE [dbo].[course] ADD  CONSTRAINT [UQ__course__name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__curriculum_status__name]    Script Date: 30/4/2023 23:23:25 ******/
ALTER TABLE [dbo].[curriculum_status] ADD  CONSTRAINT [UQ__curriculum_status__name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__day__name]    Script Date: 30/4/2023 23:23:25 ******/
ALTER TABLE [dbo].[day] ADD  CONSTRAINT [UQ__day__name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__period_status__name]    Script Date: 30/4/2023 23:23:25 ******/
ALTER TABLE [dbo].[period_status] ADD  CONSTRAINT [UQ__period_status__name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__period_type__name]    Script Date: 30/4/2023 23:23:25 ******/
ALTER TABLE [dbo].[period_type] ADD  CONSTRAINT [UQ__period_type__name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__role__name]    Script Date: 30/4/2023 23:23:25 ******/
ALTER TABLE [dbo].[role] ADD  CONSTRAINT [UQ__role__name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__school__email]    Script Date: 30/4/2023 23:23:25 ******/
ALTER TABLE [dbo].[school] ADD  CONSTRAINT [UQ__school__email] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__school__name]    Script Date: 30/4/2023 23:23:25 ******/
ALTER TABLE [dbo].[school] ADD  CONSTRAINT [UQ__school__name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__school__phone_number]    Script Date: 30/4/2023 23:23:25 ******/
ALTER TABLE [dbo].[school] ADD  CONSTRAINT [UQ__school__phone_number] UNIQUE NONCLUSTERED 
(
	[phone_number] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[activity]  WITH CHECK ADD  CONSTRAINT [FK__activity__evaluation_category] FOREIGN KEY([evaluation_category_id])
REFERENCES [dbo].[evaluation_category] ([id])
GO
ALTER TABLE [dbo].[activity] CHECK CONSTRAINT [FK__activity__evaluation_category]
GO
ALTER TABLE [dbo].[activity]  WITH CHECK ADD  CONSTRAINT [FK__activity__file] FOREIGN KEY([file_id])
REFERENCES [dbo].[file] ([id])
GO
ALTER TABLE [dbo].[activity] CHECK CONSTRAINT [FK__activity__file]
GO
ALTER TABLE [dbo].[career]  WITH CHECK ADD  CONSTRAINT [FK__career__school] FOREIGN KEY([school_id])
REFERENCES [dbo].[school] ([id])
GO
ALTER TABLE [dbo].[career] CHECK CONSTRAINT [FK__career__school]
GO
ALTER TABLE [dbo].[class]  WITH CHECK ADD  CONSTRAINT [FK__class__course] FOREIGN KEY([course_id])
REFERENCES [dbo].[course] ([id])
GO
ALTER TABLE [dbo].[class] CHECK CONSTRAINT [FK__class__course]
GO
ALTER TABLE [dbo].[class]  WITH CHECK ADD  CONSTRAINT [FK__class__period] FOREIGN KEY([period_id])
REFERENCES [dbo].[period] ([id])
GO
ALTER TABLE [dbo].[class] CHECK CONSTRAINT [FK__class__period]
GO
ALTER TABLE [dbo].[class_rating]  WITH CHECK ADD  CONSTRAINT [FK__class_rating__class] FOREIGN KEY([class_id])
REFERENCES [dbo].[class] ([id])
GO
ALTER TABLE [dbo].[class_rating] CHECK CONSTRAINT [FK__class_rating__class]
GO
ALTER TABLE [dbo].[course]  WITH CHECK ADD  CONSTRAINT [FK__course__period_type] FOREIGN KEY([period_type_id])
REFERENCES [dbo].[period_type] ([id])
GO
ALTER TABLE [dbo].[course] CHECK CONSTRAINT [FK__course__period_type]
GO
ALTER TABLE [dbo].[course]  WITH CHECK ADD  CONSTRAINT [FK__course__school] FOREIGN KEY([school_id])
REFERENCES [dbo].[school] ([id])
GO
ALTER TABLE [dbo].[course] CHECK CONSTRAINT [FK__course__school]
GO
ALTER TABLE [dbo].[curriculum]  WITH CHECK ADD  CONSTRAINT [FK__curriculum__career] FOREIGN KEY([career_id])
REFERENCES [dbo].[career] ([id])
GO
ALTER TABLE [dbo].[curriculum] CHECK CONSTRAINT [FK__curriculum__career]
GO
ALTER TABLE [dbo].[curriculum]  WITH CHECK ADD  CONSTRAINT [FK__curriculum__curriculum_status] FOREIGN KEY([curriculum_status_id])
REFERENCES [dbo].[curriculum_status] ([id])
GO
ALTER TABLE [dbo].[curriculum] CHECK CONSTRAINT [FK__curriculum__curriculum_status]
GO
ALTER TABLE [dbo].[curriculum_course]  WITH CHECK ADD  CONSTRAINT [FK__curriculum_course__course] FOREIGN KEY([course_id])
REFERENCES [dbo].[course] ([id])
GO
ALTER TABLE [dbo].[curriculum_course] CHECK CONSTRAINT [FK__curriculum_course__course]
GO
ALTER TABLE [dbo].[curriculum_course]  WITH CHECK ADD  CONSTRAINT [FK__curriculum_course__curriculum] FOREIGN KEY([curriculum_id])
REFERENCES [dbo].[curriculum] ([id])
GO
ALTER TABLE [dbo].[curriculum_course] CHECK CONSTRAINT [FK__curriculum_course__curriculum]
GO
ALTER TABLE [dbo].[curriculum_course_dependency]  WITH CHECK ADD  CONSTRAINT [FK__curriculum_course_dependency__course_dependency_id__course] FOREIGN KEY([course_dependency_id])
REFERENCES [dbo].[course] ([id])
GO
ALTER TABLE [dbo].[curriculum_course_dependency] CHECK CONSTRAINT [FK__curriculum_course_dependency__course_dependency_id__course]
GO
ALTER TABLE [dbo].[curriculum_course_dependency]  WITH CHECK ADD  CONSTRAINT [FK__curriculum_course_dependency__course_id__course] FOREIGN KEY([course_id])
REFERENCES [dbo].[course] ([id])
GO
ALTER TABLE [dbo].[curriculum_course_dependency] CHECK CONSTRAINT [FK__curriculum_course_dependency__course_id__course]
GO
ALTER TABLE [dbo].[curriculum_course_dependency]  WITH CHECK ADD  CONSTRAINT [FK__curriculum_course_dependency__curriculum] FOREIGN KEY([curriculum_id])
REFERENCES [dbo].[curriculum] ([id])
GO
ALTER TABLE [dbo].[curriculum_course_dependency] CHECK CONSTRAINT [FK__curriculum_course_dependency__curriculum]
GO
ALTER TABLE [dbo].[curriculum_course_prerequisite]  WITH CHECK ADD  CONSTRAINT [FK__curriculum_course_prerequisite__course_id__course] FOREIGN KEY([course_id])
REFERENCES [dbo].[course] ([id])
GO
ALTER TABLE [dbo].[curriculum_course_prerequisite] CHECK CONSTRAINT [FK__curriculum_course_prerequisite__course_id__course]
GO
ALTER TABLE [dbo].[curriculum_course_prerequisite]  WITH CHECK ADD  CONSTRAINT [FK__curriculum_course_prerequisite__course_prerequisite_id__course] FOREIGN KEY([course_prerequisite_id])
REFERENCES [dbo].[course] ([id])
GO
ALTER TABLE [dbo].[curriculum_course_prerequisite] CHECK CONSTRAINT [FK__curriculum_course_prerequisite__course_prerequisite_id__course]
GO
ALTER TABLE [dbo].[curriculum_course_prerequisite]  WITH CHECK ADD  CONSTRAINT [FK__curriculum_course_prerequisite__curriculum] FOREIGN KEY([curriculum_id])
REFERENCES [dbo].[curriculum] ([id])
GO
ALTER TABLE [dbo].[curriculum_course_prerequisite] CHECK CONSTRAINT [FK__curriculum_course_prerequisite__curriculum]
GO
ALTER TABLE [dbo].[enrollment_period]  WITH CHECK ADD  CONSTRAINT [FK__enrollment_period__period] FOREIGN KEY([period_id])
REFERENCES [dbo].[period] ([id])
GO
ALTER TABLE [dbo].[enrollment_period] CHECK CONSTRAINT [FK__enrollment_period__period]
GO
ALTER TABLE [dbo].[evaluation]  WITH CHECK ADD  CONSTRAINT [FK__evaluation__class] FOREIGN KEY([class_id])
REFERENCES [dbo].[class] ([id])
GO
ALTER TABLE [dbo].[evaluation] CHECK CONSTRAINT [FK__evaluation__class]
GO
ALTER TABLE [dbo].[evaluation_category]  WITH CHECK ADD  CONSTRAINT [FK__evaluation_category__evaluation] FOREIGN KEY([evaluation_id])
REFERENCES [dbo].[evaluation] ([id])
GO
ALTER TABLE [dbo].[evaluation_category] CHECK CONSTRAINT [FK__evaluation_category__evaluation]
GO
ALTER TABLE [dbo].[file]  WITH CHECK ADD  CONSTRAINT [FK__file__class] FOREIGN KEY([class_id])
REFERENCES [dbo].[class] ([id])
GO
ALTER TABLE [dbo].[file] CHECK CONSTRAINT [FK__file__class]
GO
ALTER TABLE [dbo].[grade_record]  WITH CHECK ADD  CONSTRAINT [FK__grade_record__course] FOREIGN KEY([course_id])
REFERENCES [dbo].[course] ([id])
GO
ALTER TABLE [dbo].[grade_record] CHECK CONSTRAINT [FK__grade_record__course]
GO
ALTER TABLE [dbo].[grade_record]  WITH CHECK ADD  CONSTRAINT [FK__grade_record__period] FOREIGN KEY([period_id])
REFERENCES [dbo].[period] ([id])
GO
ALTER TABLE [dbo].[grade_record] CHECK CONSTRAINT [FK__grade_record__period]
GO
ALTER TABLE [dbo].[period]  WITH CHECK ADD  CONSTRAINT [FK__period__period_status] FOREIGN KEY([period_status_id])
REFERENCES [dbo].[period_status] ([id])
GO
ALTER TABLE [dbo].[period] CHECK CONSTRAINT [FK__period__period_status]
GO
ALTER TABLE [dbo].[period]  WITH CHECK ADD  CONSTRAINT [FK__period__period_type] FOREIGN KEY([period_type_id])
REFERENCES [dbo].[period_type] ([id])
GO
ALTER TABLE [dbo].[period] CHECK CONSTRAINT [FK__period__period_type]
GO
ALTER TABLE [dbo].[professor_school]  WITH CHECK ADD  CONSTRAINT [FK__professor_school__school] FOREIGN KEY([school_id])
REFERENCES [dbo].[school] ([id])
GO
ALTER TABLE [dbo].[professor_school] CHECK CONSTRAINT [FK__professor_school__school]
GO
ALTER TABLE [dbo].[schedule]  WITH CHECK ADD  CONSTRAINT [FK__schedule__class] FOREIGN KEY([class_id])
REFERENCES [dbo].[class] ([id])
GO
ALTER TABLE [dbo].[schedule] CHECK CONSTRAINT [FK__schedule__class]
GO
ALTER TABLE [dbo].[schedule]  WITH CHECK ADD  CONSTRAINT [FK__schedule__day] FOREIGN KEY([day_id])
REFERENCES [dbo].[day] ([id])
GO
ALTER TABLE [dbo].[schedule] CHECK CONSTRAINT [FK__schedule__day]
GO
ALTER TABLE [dbo].[student_activity]  WITH CHECK ADD  CONSTRAINT [FK__student_activity__activity] FOREIGN KEY([activity_id])
REFERENCES [dbo].[activity] ([id])
GO
ALTER TABLE [dbo].[student_activity] CHECK CONSTRAINT [FK__student_activity__activity]
GO
ALTER TABLE [dbo].[student_activity]  WITH CHECK ADD  CONSTRAINT [FK__student_activity__file_id__archive] FOREIGN KEY([file_id])
REFERENCES [dbo].[file] ([id])
GO
ALTER TABLE [dbo].[student_activity] CHECK CONSTRAINT [FK__student_activity__file_id__archive]
GO
ALTER TABLE [dbo].[student_activity]  WITH CHECK ADD  CONSTRAINT [FK__student_activity__professor_file_id__archive] FOREIGN KEY([professor_file_id])
REFERENCES [dbo].[file] ([id])
GO
ALTER TABLE [dbo].[student_activity] CHECK CONSTRAINT [FK__student_activity__professor_file_id__archive]
GO
ALTER TABLE [dbo].[student_class]  WITH CHECK ADD  CONSTRAINT [FK__student_class__class] FOREIGN KEY([class_id])
REFERENCES [dbo].[class] ([id])
GO
ALTER TABLE [dbo].[student_class] CHECK CONSTRAINT [FK__student_class__class]
GO
ALTER TABLE [dbo].[student_curriculum]  WITH CHECK ADD  CONSTRAINT [FK__student_curriculum__curriculum] FOREIGN KEY([curriculum_id])
REFERENCES [dbo].[curriculum] ([id])
GO
ALTER TABLE [dbo].[student_curriculum] CHECK CONSTRAINT [FK__student_curriculum__curriculum]
GO
ALTER TABLE [dbo].[student_enrollment_period]  WITH CHECK ADD  CONSTRAINT [FK__student_enrollment_period__enrollment_period] FOREIGN KEY([enrollment_period_id])
REFERENCES [dbo].[enrollment_period] ([id])
GO
ALTER TABLE [dbo].[student_enrollment_period] CHECK CONSTRAINT [FK__student_enrollment_period__enrollment_period]
GO
ALTER TABLE [dbo].[student_waiting_enrollment]  WITH CHECK ADD  CONSTRAINT [FK__student_waiting_enrollment__class] FOREIGN KEY([class_id])
REFERENCES [dbo].[class] ([id])
GO
ALTER TABLE [dbo].[student_waiting_enrollment] CHECK CONSTRAINT [FK__student_waiting_enrollment__class]
GO
ALTER TABLE [dbo].[student_waiting_enrollment]  WITH CHECK ADD  CONSTRAINT [FK__student_waiting_enrollment__enrollment_period] FOREIGN KEY([enrollment_period_id])
REFERENCES [dbo].[enrollment_period] ([id])
GO
ALTER TABLE [dbo].[student_waiting_enrollment] CHECK CONSTRAINT [FK__student_waiting_enrollment__enrollment_period]
GO
ALTER TABLE [dbo].[user_role]  WITH CHECK ADD  CONSTRAINT [FK__user_role__role] FOREIGN KEY([role_id])
REFERENCES [dbo].[role] ([id])
GO
ALTER TABLE [dbo].[user_role] CHECK CONSTRAINT [FK__user_role__role]
GO
ALTER TABLE [dbo].[activity]  WITH CHECK ADD  CONSTRAINT [CHK__activity__percentage] CHECK  (([percentage]>(0)))
GO
ALTER TABLE [dbo].[activity] CHECK CONSTRAINT [CHK__activity__percentage]
GO
ALTER TABLE [dbo].[class]  WITH CHECK ADD  CONSTRAINT [CHK__class__max_student_capacity] CHECK  (([max_student_capacity]>=(0)))
GO
ALTER TABLE [dbo].[class] CHECK CONSTRAINT [CHK__class__max_student_capacity]
GO
ALTER TABLE [dbo].[class_rating]  WITH CHECK ADD  CONSTRAINT [CHK__class_rating__difficulty] CHECK  (([difficulty]>=(1) AND [difficulty]<=(10)))
GO
ALTER TABLE [dbo].[class_rating] CHECK CONSTRAINT [CHK__class_rating__difficulty]
GO
ALTER TABLE [dbo].[class_rating]  WITH CHECK ADD  CONSTRAINT [CHK__class_rating__overall_grade] CHECK  (([overall_grade]>=(1) AND [overall_grade]<=(10)))
GO
ALTER TABLE [dbo].[class_rating] CHECK CONSTRAINT [CHK__class_rating__overall_grade]
GO
ALTER TABLE [dbo].[class_rating]  WITH CHECK ADD  CONSTRAINT [CHK__class_rating__quality] CHECK  (([quality]>=(1) AND [quality]<=(10)))
GO
ALTER TABLE [dbo].[class_rating] CHECK CONSTRAINT [CHK__class_rating__quality]
GO
ALTER TABLE [dbo].[course]  WITH CHECK ADD  CONSTRAINT [CHK__course__class_hours_week] CHECK  (([class_hours_week]>(0)))
GO
ALTER TABLE [dbo].[course] CHECK CONSTRAINT [CHK__course__class_hours_week]
GO
ALTER TABLE [dbo].[course]  WITH CHECK ADD  CONSTRAINT [CHK__course__credits] CHECK  (([credits]>=(0)))
GO
ALTER TABLE [dbo].[course] CHECK CONSTRAINT [CHK__course__credits]
GO
ALTER TABLE [dbo].[curriculum]  WITH CHECK ADD  CONSTRAINT [CHK__curriculum__activation_date__finish_date] CHECK  (([activation_date]<[finish_date]))
GO
ALTER TABLE [dbo].[curriculum] CHECK CONSTRAINT [CHK__curriculum__activation_date__finish_date]
GO
ALTER TABLE [dbo].[curriculum]  WITH CHECK ADD  CONSTRAINT [CHK__curriculum__creation_date__activation_date__finish_date] CHECK  (([creation_date]<[activation_date]))
GO
ALTER TABLE [dbo].[curriculum] CHECK CONSTRAINT [CHK__curriculum__creation_date__activation_date__finish_date]
GO
ALTER TABLE [dbo].[enrollment_period]  WITH CHECK ADD  CONSTRAINT [CHK__enrollment_period__start_datetime__end_datetime] CHECK  (([start_datetime]<[end_datetime]))
GO
ALTER TABLE [dbo].[enrollment_period] CHECK CONSTRAINT [CHK__enrollment_period__start_datetime__end_datetime]
GO
ALTER TABLE [dbo].[evaluation_category]  WITH CHECK ADD  CONSTRAINT [CHK__evaluation_category__percentage] CHECK  (([percentage]>(0)))
GO
ALTER TABLE [dbo].[evaluation_category] CHECK CONSTRAINT [CHK__evaluation_category__percentage]
GO
ALTER TABLE [dbo].[grade_record]  WITH CHECK ADD  CONSTRAINT [CHK__grade_record__grade] CHECK  (([grade]>=(0)))
GO
ALTER TABLE [dbo].[grade_record] CHECK CONSTRAINT [CHK__grade_record__grade]
GO
ALTER TABLE [dbo].[period]  WITH CHECK ADD  CONSTRAINT [CHK__period__start_time__end_time] CHECK  (([start_date]<[end_date]))
GO
ALTER TABLE [dbo].[period] CHECK CONSTRAINT [CHK__period__start_time__end_time]
GO
ALTER TABLE [dbo].[schedule]  WITH CHECK ADD  CONSTRAINT [CHK__schedule__start_time__end_time] CHECK  (([start_time]<[end_time]))
GO
ALTER TABLE [dbo].[schedule] CHECK CONSTRAINT [CHK__schedule__start_time__end_time]
GO
ALTER TABLE [dbo].[student_activity]  WITH CHECK ADD  CONSTRAINT [CHK__student_activity_review__grade] CHECK  (([grade]>=(0)))
GO
ALTER TABLE [dbo].[student_activity] CHECK CONSTRAINT [CHK__student_activity_review__grade]
GO
ALTER DATABASE [db01] SET  READ_WRITE 
GO
