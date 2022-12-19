CREATE TABLE Ta (
	aid INT PRIMARY KEY,
	a2 INT UNIQUE,
	a3 INT
)
DELETE FROM Tc
DELETE FROM Ta
DELETE FROM Tb


CREATE TABLE Tb (
	bid INT PRIMARY KEY,
	b2 INT
)

CREATE TABLE Tc (
	cid INT PRIMARY KEY,
	aid INT FOREIGN KEY REFERENCES Ta(aid),
	bid INT FOREIGN KEY REFERENCES Tb(bid)
)

EXEC insertIntoTa 5000
EXEC insertIntoTb 6000
EXEC insertIntoTc 2000

EXEC insertIntoTaTbTc


SELECT *
FROM Ta

SELECT *
FROM Tb

SELECT *
FROM Tc

--a)
--clustered index seek
SELECT a.aid,a.a2
FROM Ta a
WHERE a.aid=70;

--non-clustered index seek
SELECT a.aid,a.a2
FROM Ta a
WHERE a.a2=190;

--clustered index scan
SELECT a.aid
FROM Ta a
ORDER BY a.aid;

--non-clustered index scan
SELECT a.a2
FROM Ta a
ORDER BY a.a2;

--include a non-indexed field (a3) -> key lookup
SELECT *
FROM Ta a
WHERE a.a2=190;

--b)
--0.003392 before creating nonclustered index
--0.0032886 after creating nonclustered index
SELECT b.b2
FROM Tb b
WHERE b.b2=1;

DROP INDEX idx_subpoint_b ON Tb
CREATE NONCLUSTERED INDEX idx_subpoint_b
ON Tb(b2)

--c)--0926
GO
CREATE OR ALTER VIEW viewC AS
SELECT a.aid,a.a2,c.cid
FROM Tc c INNER JOIN Ta a ON c.aid=a.aid
WHERE a.a3>50

GO
SELECT *
FROM viewC

CREATE NONCLUSTERED INDEX indexForeignKey ON Tc(aid)
DROP INDEX indexForeignKey ON Tc

CREATE NONCLUSTERED INDEX indexC
ON Ta(a3) INCLUDE (a2)

DROP INDEX indexC ON Ta
--before 0.003392
--after  0.003392
