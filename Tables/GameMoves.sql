CREATE TABLE admin.GameMoves (
    MoveID INT PRIMARY KEY IDENTITY(1,1),
    GamePlayerID INT,
    MoveNumber INT,
    DiceRoll INT,
    StartPosition INT,
    EndPosition INT,
    MoveType NVARCHAR(20) CHECK (MoveType IN ('Start', 'Move', 'Ladder', 'Snake', 'End')),
    MoveTime DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_GamePlayer FOREIGN KEY (GamePlayerID) REFERENCES admin.GamePlayers(GamePlayerID)
);