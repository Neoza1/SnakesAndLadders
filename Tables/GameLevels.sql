CREATE TABLE config.GameLevels (
    LevelID INT PRIMARY KEY,
    LevelName NVARCHAR(50) NOT NULL,
    BoardSize INT NOT NULL,
    NumSnakes INT NOT NULL,
    NumLadders INT NOT NULL
);