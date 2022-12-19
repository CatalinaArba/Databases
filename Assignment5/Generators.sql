GO
CREATE OR ALTER PROCEDURE insertIntoTa(@rows INT) AS
BEGIN
	DECLARE @max INT
	SET @max = @rows*2 + 100
	WHILE @rows > 0
	BEGIN
		INSERT INTO Ta VALUES (@rows, @max, @max%210)
		SET @rows = @rows - 1
		SET @max = @max - 2
	END
END

-- Procedure to generate and insert random data into Tb
GO
CREATE OR ALTER PROCEDURE insertIntoTb(@rows INT) AS
BEGIN
	WHILE @rows > 0 
	BEGIN
		INSERT INTO Tb VALUES(@rows, @rows%542)
		SET @rows = @rows - 1
	END
END

-- Procedure to generate and insert random data into Tc
GO
CREATE OR ALTER PROCEDURE insertIntoTc(@rows INT) AS
BEGIN
	DECLARE @aid INT
	DECLARE @bid INT
	WHILE @rows > 0
	BEGIN
		SET @aid = (SELECT TOP 1 aid FROM Ta ORDER BY NEWID())
		SET @bid = (SELECT TOP 1 bid FROM Tb ORDER BY NEWID())
		INSERT INTO Tc VALUES(@rows, @aid, @bid)
		SET @rows = @rows - 1
	END
END

GO
CREATE OR ALTER PROCEDURE insertIntoTaTbTc AS
BEGIN

 

    DECLARE @i INT=0
    DECLARE @fk1 INT
    DECLARE @fk2 INT
    WHILE @i<100
    BEGIN
        INSERT INTO Ta VALUES (@i, @i*2, @i*3)
        INSERT INTO Tb VALUES (@i, RAND()*@i)
        SET @fk1 = (SELECT TOP 1 aid FROM Ta ORDER BY NEWID())
        SET @fk2 = (SELECT TOP 1 bid FROM Tb ORDER BY NEWID())
        INSERT INTO Tc VALUES (@i,@fk1,@fk2)
        SET @i=@i+1
    END
END

 

