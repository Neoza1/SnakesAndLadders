CREATE TABLE admin.Games (
    GameID INT PRIMARY KEY IDENTITY(1,1),
    LevelID INT,
    StartTime DATETIME DEFAULT GETDATE(),
    EndTime DATETIME,
    WinnerPlayerID INT,
    CONSTRAINT FK_GameLevel FOREIGN KEY (LevelID) REFERENCES config.GameLevels(LevelID)
);