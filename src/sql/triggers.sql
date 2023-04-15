CREATE TRIGGER check_sum_max_percentage_evaluation_category
    ON evaluation_category
    AFTER INSERT, UPDATE
AS
    IF (
        SELECT SUM(percentage)
        FROM evaluation_category
        WHERE inserted.evalutation_id = evaluation_id
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
        SELECT SUM(percentage)
        FROM activity
        WHERE inserted.evaluation_category_id = evaluation_category_id
        ) > SELECT percentage 
            FROM evaluation_category 
            WHERE inserted.evaluation_category_id = id
    BEGIN
        RAISERROR ('The sum of activities percentages, exceeds the evaluation category percentage', 16, 1)
        ROLLBACK TRANSACTION
    END
GO