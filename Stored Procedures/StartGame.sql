CREATE PROCEDURE procs.StartGame
@LevelID INT,
@PlayerIDs NVARCHAR(MAX)
AS
BEGIN
    DECLARE @GameID INT;
    
    -- Insert the game level and get the GameID
    INSERT INTO admin.Games (LevelID) VALUES (@LevelID);
    SET @GameID = SCOPE_IDENTITY();
    
    DECLARE @PlayerID INT;
    
    -- Cursor to handle each player ID from the comma-separated list
    DECLARE PlayerCursor CURSOR FOR 
        SELECT CAST(value AS INT) 
        FROM STRING_SPLIT(@PlayerIDs, ',');
    
    OPEN PlayerCursor;
    
    FETCH NEXT FROM PlayerCursor INTO @PlayerID;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Insert each player into the GamePlayers table
        INSERT INTO admin.GamePlayers (GameID, PlayerID) VALUES (@GameID, @PlayerID);
        
        FETCH NEXT FROM PlayerCursor INTO @PlayerID;
    END;
    
    CLOSE PlayerCursor;
    DEALLOCATE PlayerCursor;
END;
