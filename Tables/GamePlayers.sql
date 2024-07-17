CREATE TABLE admin.GamePlayers (
    GamePlayerID INT PRIMARY KEY IDENTITY(1,1),
    GameID INT,
    PlayerID INT,
    CurrentPosition INT DEFAULT 1,
    CONSTRAINT FK_Game FOREIGN KEY (GameID) REFERENCES admin.Games(GameID),
    CONSTRAINT FK_Player FOREIGN KEY (PlayerID) REFERENCES admin.Players(PlayerID)
);