CREATE PROCEDURE procs.MakeMove
@GamePlayerID INT,
@DiceRoll INT
AS
BEGIN
    DECLARE @CurrentPosition INT;
    DECLARE @NewPosition INT;
    DECLARE @ElementID INT;
    DECLARE @MoveType NVARCHAR(20);

    SELECT @CurrentPosition = CurrentPosition FROM admin.GamePlayers WHERE GamePlayerID = @GamePlayerID;
    SET @NewPosition = @CurrentPosition + @DiceRoll;

    -- Reflect if overshooting
    IF @NewPosition > 100
        SET @NewPosition = 200 - @NewPosition;

    -- Check for Snakes and Ladders
    SELECT @ElementID = ElementID, @MoveType = ElementType
    FROM config.BoardElements
    WHERE LevelID = (SELECT LevelID FROM admin.Games WHERE GameID = (SELECT GameID FROM admin.GamePlayers WHERE GamePlayerID = @GamePlayerID))
    AND StartPosition = @NewPosition;

    IF @ElementID IS NOT NULL
    BEGIN
        IF @MoveType = 'Snake'
            SET @NewPosition = (SELECT EndPosition FROM config.BoardElements WHERE ElementID = @ElementID);
        ELSE IF @MoveType = 'Ladder'
            SET @NewPosition = (SELECT EndPosition FROM config.BoardElements WHERE ElementID = @ElementID);
    END;

    -- Update Player Position
    UPDATE admin.GamePlayers
    SET CurrentPosition = @NewPosition
    WHERE GamePlayerID = @GamePlayerID;

    -- Log Move
    INSERT INTO admin.GameMoves (GamePlayerID, MoveNumber, DiceRoll, StartPosition, EndPosition, MoveType)
    VALUES (@GamePlayerID, (SELECT COUNT(*) + 1 FROM admin.GameMoves WHERE GamePlayerID = @GamePlayerID), @DiceRoll, @CurrentPosition, @NewPosition, ISNULL(@MoveType, 'Move'));
END;
