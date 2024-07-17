CREATE TABLE config.BoardElements (
    ElementID INT PRIMARY KEY IDENTITY(1,1),
    LevelID INT,
    ElementType NVARCHAR(10) CHECK (ElementType IN ('Snake', 'Ladder')),
    StartPosition INT NOT NULL,
    EndPosition INT NOT NULL,
    CONSTRAINT FK_Level FOREIGN KEY (LevelID) REFERENCES config.GameLevels(LevelID)
);