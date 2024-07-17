DECLARE @LevelID INT = 3;
DECLARE @PlayerIDs NVARCHAR(100) = '1,2';

EXEC procs.StartGame @LevelID, @PlayerIDs;