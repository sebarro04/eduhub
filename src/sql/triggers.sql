CREATE TRIGGER check_sum_max_percentage_evaluation_category
    ON evaluation_category
    AFTER INSERT, UPDATE
AS
    IF (
        SELECT SUM(evaluation_category.percentage)
        FROM evaluation_category
        INNER JOIN inserted ON evaluation_category.id = inserted.id
        WHERE inserted.evaluation_id = evaluation_category.evaluation_id
        ) > 100
    BEGIN
        RAISERROR ('The sum of evaluation categories percentages exceeds 100%', 16, 1)
        ROLLBACK TRANSACTION
    END
GO

CREATE TRIGGER check_sum_max_percentage_activity
    ON activity
    AFTER INSERT, UPDATE
AS
    IF (
        SELECT SUM(activity.percentage)
        FROM activity
        INNER JOIN inserted ON activity.id = inserted.id
        WHERE inserted.evaluation_category_id = activity.evaluation_category_id
        ) > (SELECT evaluation_category.percentage 
            FROM evaluation_category
            INNER JOIN inserted ON evaluation_category.id = inserted.evaluation_category_id)
    BEGIN
        RAISERROR ('The sum of activities percentages, exceeds the evaluation category percentage', 16, 1)
        ROLLBACK TRANSACTION
    END
GO

CREATE OR ALTER TRIGGER tr_class_au
ON class
AFTER UPDATE
AS
BEGIN
    IF (SELECT max_student_capacity FROM inserted) = 1
    BEGIN
        DECLARE @student_id VARCHAR(128)
        SELECT TOP 1 @student_id = swe.student_id 
        FROM student_waiting_enrollment swe
        WHERE swe.class_id = (SELECT id FROM inserted)
        ORDER BY id

        IF (@student_id IS NOT NULL)
        BEGIN
            INSERT INTO student_class (student_id, class_id)
            VALUES (@student_id, (SELECT id FROM inserted))

            UPDATE class
            SET max_student_capacity = max_student_capacity - 1
            WHERE class.id = (SELECT id FROM inserted)

            DELETE FROM student_waiting_enrollment WHERE student_waiting_enrollment.student_id = @student_id
        END
    END
END
GO