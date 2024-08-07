USE [master]
GO
/****** Object:  Database [db01]    Script Date: 30/4/2023 23:21:40 ******/
CREATE DATABASE [db01]
 WITH CATALOG_COLLATION = SQL_Latin1_General_CP1_CI_AS
GO
ALTER DATABASE [db01] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [db01].[dbo].[sp_fulltext_database] @action = 'enable'
end
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
ALTER DATABASE [db01] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [db01] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [db01] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [db01] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [db01] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [db01] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [db01] SET  MULTI_USER 
GO
ALTER DATABASE [db01] SET DB_CHAINING OFF 
GO
ALTER DATABASE [db01] SET ENCRYPTION ON
GO
ALTER DATABASE [db01] SET QUERY_STORE = ON
GO
ALTER DATABASE [db01] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 100, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [db01]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 8;
GO
USE [db01]
GO
/****** Object:  Table [dbo].[activity]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[career]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__career__name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[class]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[class_rating]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[course]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__course__name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[curriculum]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[curriculum_course]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[curriculum_course_dependency]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[curriculum_course_prerequisite]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[curriculum_status]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__curriculum_status__name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[day]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__day__name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[enrollment_period]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[evaluation]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[evaluation_category]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[file]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[grade_record]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[period]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[period_status]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__period_status__name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[period_type]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__period_type__name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[professor_school]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[role]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__role__name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[schedule]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[school]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__school__email] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__school__name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__school__phone_number] UNIQUE NONCLUSTERED 
(
	[phone_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[student_activity]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[student_class]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[student_curriculum]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[student_enrollment_period]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[student_waiting_enrollment]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_role]    Script Date: 30/4/2023 23:21:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
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
USE [master]
GO
ALTER DATABASE [db01] SET  READ_WRITE 
GO
