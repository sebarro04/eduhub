INSERT INTO role (id, name)
VALUES 
(1, 'Administrador'),
(2, 'Profesor'),
(3, 'Estudiante'),
(4, 'Asistente')
GO

INSERT INTO period_type (id, name)
VALUES
(1, 'Anual'),
(2, 'Semestral'),
(3, 'Trimestral'),
(4, 'Cuatrimestral'),
(5, 'Bimestral')
GO

INSERT INTO period_status (id, name)
VALUES
(1, 'Creado'),
(2, 'En progreso'),
(3, 'Finalizado')
GO

INSERT INTO curriculum_status (id, name)
VALUES
(1, 'Creación'),
(2, 'Activo'),
(3, 'Cerrado')
GO

INSERT INTO day (id, name)
VALUES
(1, 'Lunes'),
(2, 'Martes'),
(3, 'Miércoles'),
(4, 'Jueves'),
(5, 'Viernes'),
(6, 'Sábado')
GO