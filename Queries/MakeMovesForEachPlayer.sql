DECLARE @GamePlayerID INT;
DECLARE @DiceRoll INT;

-- Fetch GamePlayerIDs for the current game
DECLARE @GameID INT;
SET @GameID = (SELECT MAX(GameID) FROM admin.Games);

DECLARE GamePlayerCursor CURSOR FOR
SELECT GamePlayerID FROM admin.GamePlayers WHERE GameID = @GameID;

OPEN GamePlayerCursor;
FETCH NEXT FROM GamePlayerCursor INTO @GamePlayerID;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Simulate a dice roll (1 to 6)
    SET @DiceRoll = FLOOR(RAND() * 6) + 1;
    
    -- Make a move for the current player
    EXEC procs.MakeMove @GamePlayerID, @DiceRoll;
    
    -- Move to the next player
    FETCH NEXT FROM GamePlayerCursor INTO @GamePlayerID;
END;

CLOSE GamePlayerCursor;
DEALLOCATE GamePlayerCursor;
