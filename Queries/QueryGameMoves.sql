SELECT 
    gm.MoveID,
    gp.PlayerID,
    gm.MoveNumber,
    gm.DiceRoll,
    gm.StartPosition,
    gm.EndPosition,
    gm.MoveType,
    gm.MoveTime
FROM 
    admin.GameMoves gm
    JOIN admin.GamePlayers gp ON gm.GamePlayerID = gp.GamePlayerID
WHERE 
    gp.GameID = 4
ORDER BY 
    gm.MoveNumber;
