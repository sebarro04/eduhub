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