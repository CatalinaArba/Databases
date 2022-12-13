use [Clothing Store 2]


--ADD PROCEDURES ----------------------------------------------------------------------------------------------------------------------
GO
CREATE OR ALTER PROCEDURE addTableToTablesTable(@tableToAdd VARCHAR(30)) AS
BEGIN
	--CHECK IF TABLE WE WANT TO ADD IS IN THE DATABASE
	IF @tableToAdd NOT IN (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES)
	BEGIN
		PRINT ('Table '+@tableToAdd+' doesn t exist in the database!')
		RETURN
	END

	--CHECK IF TABLE WE WANT TO ADD IS IN TABLES TABLE
	IF @tableToAdd IN (SELECT [Name] FROM [Tables])
	BEGIN 
		PRINT ('Table '+@tableToAdd+' is already in Tables table!')
		RETURN
	END

	INSERT INTO [Tables] ([Name]) VALUES (@tableToAdd)

END

----------------------------------------------------------------------------------------------------------------------

GO
CREATE OR ALTER PROCEDURE addViewToViewsTable(@viewToAdd VARCHAR(30)) AS
BEGIN
	--CHECK IF THE VIEW WE WANT TO ADD IS IN THE DATABASE
	IF @viewToAdd NOT IN (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS)
	BEGIN
		PRINT ('View '+@viewToAdd+' doesn t exist in the database!')
		RETURN
	END

	--CHECK IF VIEW WE WANT TO ADD IS IN VIEWS TABLE
	IF @viewToAdd IN (SELECT [Name] FROM [Views])
	BEGIN 
		PRINT ('View '+@viewToAdd+' is already in Views table!')
		RETURN
	END

	INSERT INTO [Views] ([Name]) VALUES (@viewToAdd)

END


----------------------------------------------------------------------------------------------------------------------


GO
CREATE OR ALTER PROCEDURE addTestToTestsTable(@testToAdd VARCHAR(30)) AS
BEGIN

	--CHECK IF THE TEST WE WANT TO ADD IS IN TESTS TABLE
	IF @testToAdd IN (SELECT [Name] FROM [Tests])
	BEGIN 
		PRINT ('Test '+@testToAdd+' is already in Tests table!')
		RETURN
	END

	INSERT INTO [Tests] ([Name]) VALUES (@testToAdd)

END

--CONNECT PROCEDURES----------------------------------------------------------------------------------------------------------------------

GO
CREATE OR ALTER PROCEDURE connectTestToTableInTestTablesTable(@tableToAdd VARCHAR(30),@testToAdd VARCHAR(30),@noOfRows INT, @position INT) AS
BEGIN
	--CHECK IF TABLE WE WANT TO ADD IS IN TABLES TABLE
	IF @tableToAdd IN (SELECT [Name] FROM [Tables])
	BEGIN 
		PRINT ('Table '+@tableToAdd+' is already in Tables table!')
		RETURN
	END

	--CHECK IF THE TEST WE WANT TO ADD IS IN TESTS TABLE
	IF @testToAdd IN (SELECT [Name] FROM [Tests])
	BEGIN 
		PRINT ('Test '+@testToAdd+' is already in Tests table!')
		RETURN
	END

	--CHECK IF THE POSITION IS FREE
	IF EXISTS(
		SELECT *
		FROM TestTables testTable JOIN Tests test ON testTable.TestID=test.TestID
		WHERE test.[Name]=@testToAdd AND Position=@position
		)
		BEGIN
			PRINT('The position you want to add overlaps other position')
			RETURN
		END

	INSERT INTO [TestTables](TestID,TableID,NoOfRows,Position) VALUES(
	(SELECT [Tests].TestID FROM [Tests] WHERE [Name]=@testToAdd),
	(SELECT [Tables].TableId 	FROM [Tables]	WHERE [Name]=@tableToAdd),
	@noOfRows ,
	@position )
END


----------------------------------------------------------------------------------------------------------------------


GO
CREATE OR ALTER PROCEDURE connectTestToViewInTestViewTable(@viewToAdd VARCHAR(30),@testToAdd VARCHAR(30)) AS
BEGIN
	--CHECK IF VIEW WE WANT TO ADD IS IN VIEWS TABLE
	IF @viewToAdd IN (SELECT [Name] FROM [Views])
	BEGIN 
		PRINT ('View '+@viewToAdd+' is already in Views table!')
		RETURN
	END

	--CHECK IF THE TEST WE WANT TO ADD IS IN TESTS TABLE
	IF @testToAdd IN (SELECT [Name] FROM [Tests])
	BEGIN 
		PRINT ('Test '+@testToAdd+' is already in Tests table!')
		RETURN
	END

	INSERT INTO [TestViews](TestID,ViewID) VALUES(
	(SELECT [Tests].TestId 	FROM [Tests]	WHERE [Name]=@testToAdd),
	(SELECT [Views].ViewID 	FROM [Views]	WHERE [Name]=@viewToAdd))
	
END


--DELETE PROCEDURES----------------------------------------------------------------------------------------------------------------------
GO
CREATE OR ALTER PROCEDURE deleteDataFromTable (@tableIdToDeleteFrom INT)AS
BEGIN
	--CHECK IF THE TABLE WE WANT TO DELETE FROM IS IN TABLES TABLE
	IF @tableIdToDeleteFrom NOT IN ( SELECT [TableId] FROM [TABLES])
	BEGIN
		PRINT('Table '+CONVERT(VARCHAR, @tableIdToDeleteFrom )+' doens t exists in Tables table')
		RETURN
	END
	
	DECLARE @tableNameToDeleteFrom NVARCHAR(30)=(SELECT [Name] FROM [Tables] WHERE TableId=@tableIdToDeleteFrom)
	DECLARE @query NVARCHAR(100) =N'DELETE FROM '+@tableNameToDeleteFrom
	print @query
	EXEC sp_executesql @query
	PRINT('Delete table '+@tableNameToDeleteFrom )

END
----------------------------------------------------------------------------------------------------------------------

GO
CREATE OR ALTER PROCEDURE deleteDataFromAllTables(@testIdToDeleteFrom INT) AS
BEGIN
	--CHECK IF THE TEST EXITS IN TESTS TABLE
	IF @testIdToDeleteFrom NOT IN(SELECT [TestID] FROM [Tests])
	BEGIN
		PRINT ('Test '+CONVERT(VARCHAR,@testIdToDeleteFrom)+'doesn t exist in table Test!')
		RETURN
	END
	
	--WE ITERATE THROUGH THE TABLES IN DESCENDING ORDER OF THE POSITIONS TO DELETE DATA FROM 
	DECLARE @tableId INT
	DECLARE @position INT

	DECLARE cursorForAllTables CURSOR LOCAL FOR
		SELECT testTables.TableID, testTables.Position
		FROM TestTables testTables
		INNER JOIN Tests tests ON tests.TestID=testTables.TestID
		WHERE testTables.TestID=@testIdToDeleteFrom
		ORDER BY testTables.Position DESC

	OPEN cursorForAllTables
	FETCH cursorForAllTables INTO @tableId, @position
	WHILE @@FETCH_STATUS = 0
	BEGIN
			EXEC deleteDataFromTable @tableID
			FETCH NEXT FROM cursorForAllTables INTO @tableId, @position
	END
	CLOSE cursorForAllTables
	DEALLOCATE cursorForAllTables
	PRINT 'Delete data from all tables for the test ' + CONVERT(VARCHAR, @testIdToDeleteFrom)
END


--SELECT PROCERES----------------------------------------------------------------------------------------------------------------------
GO
CREATE OR ALTER PROCEDURE selectDataFromView (@viewId INT, @testRunId INT) AS
BEGIN
	--CHECK IF VIEW IS IN VIEWS TABLE
	IF @viewId NOT IN ( SELECT [ViewID] FROM [Views])
	BEGIN
		PRINT ('View '+ CONVERT(VARCHAR, @viewId)+' doesn t exist in View table!')
		RETURN
	END

	--CHECK IS TESTRUN IS IN TESTRUNS TABLE
	IF @testRunId NOT IN ( SELECT [TestRunID] FROM [TestRuns])
	BEGIN
		PRINT ('TestRun '+ CONVERT(VARCHAR, @testRunId)+' doesn t exist in TestRuns table!')
		RETURN
	END

	DECLARE @startTime DATETIME=SYSDATETIME()
	DECLARE @viewName VARCHAR(100)=(SELECT [Name] FROM [Views] WHERE ViewID=@viewId)
	DECLARE @query NVARCHAR(150)=N'SELECT * FROM '+@viewName
	EXEC sp_executesql @query
	DECLARE @endTime DATETIME=SYSDATETIME()

	INSERT INTO TestRunViews(TestRunID, ViewID, StartAt, EndAt) VALUES(@testRunId,@viewId,@startTime,@endTime)
END

----------------------------------------------------------------------------------------------------------------------


GO
CREATE OR ALTER PROCEDURE selectDataFromAllViews(@testRunId INT,@testId INT) AS
BEGIN
	--CHECK IF THE TEST EXITS IN TESTS TABLE
	IF @testId NOT IN(SELECT [TestID] FROM [Tests])
	BEGIN
		PRINT ('Test '+CONVERT(VARCHAR,@testId)+'doesn t exist in Test table!')
		RETURN
	END

	--CHECK IS TESTRUN IS IN TESTRUNS TABLE
	IF @testRunId NOT IN ( SELECT [TestRunID] FROM [TestRuns])
	BEGIN
		PRINT ('TestRun '+ CONVERT(VARCHAR, @testRunId)+' doesn t exist in TestRuns table!')
		RETURN
	END

	--WE ITERATE THROUGH THE VIEWS TO SELECT  DATA 
	DECLARE @viewId INT
	DECLARE cursorForAllViewsAsc CURSOR LOCAL FOR
		SELECT testViews.ViewID
		FROM TestViews testViews
		INNER JOIN Tests tests ON tests.TestID=testViews.TestID
		WHERE testViews.TestID=@testId


	OPEN cursorForAllViewsAsc
	FETCH cursorForAllViewsAsc INTO @viewId
	WHILE @@FETCH_STATUS = 0
	BEGIN
			EXEC selectDataFromView @viewId,@testRunId
			FETCH NEXT FROM cursorForAllViewsAsc INTO @viewId
	END
	CLOSE cursorForAllViewsAsc
	DEALLOCATE cursorForAllViewsAsc
END


--INSERT PROCEDURES----------------------------------------------------------------------------------------------------------------------


GO
CREATE OR ALTER PROCEDURE insertDataIntoTable(@testRunId INT, @testID INT, @tableID INT) AS
BEGIN
	PRINT 'Insert data into table '
	--CHECK IF THE TEST EXITS IN TESTS TABLE
	IF @testId NOT IN(SELECT [TestID] FROM [Tests])
	BEGIN
		PRINT ('Test '+CONVERT(VARCHAR,@testId)+'doesn t exist in Test table!')
		RETURN
	END

	--CHECK IS TESTRUN IS IN TESTRUNS TABLE
	IF @testRunId NOT IN ( SELECT [TestRunID] FROM [TestRuns])
	BEGIN
		PRINT ('TestRun '+ CONVERT(VARCHAR, @testRunId)+' doesn t exist in TestRuns table!')
		RETURN
	END

	--CHECK IF TABLE IS IN TABLES TABLE
	IF @tableID NOT IN (SELECT [TableID] FROM [Tables])
	BEGIN
		PRINT 'Table not present in Tables.'
		RETURN
	END
	

	DECLARE @startTime DATETIME=SYSDATETIME()
	DECLARE @tableName VARCHAR(50)=(SELECT [Name] FROM [Tables] WHERE TableId=@tableID)
	
	DECLARE @noOfRows INT=(SELECT [NoOfRows] FROM [TestTables] WHERE TableId=@tableID AND TestID=@testID)
	
	EXEC generateDataForTable @tableName, @noOfRows
	DECLARE @endTime DATETIME=SYSDATETIME()

	INSERT INTO TestRunTables(TestRunID,TableId,StartAt,EndAt) VALUES (@testRunId,@tableID,@startTime,@endTime)
	

END


----------------------------------------------------------------------------------------------------------------------


GO
CREATE OR ALTER PROCEDURE insertDataIntoAllTable(@testRunID INT, @testID INT) AS
BEGIN
	--CHECK IF THE TEST EXITS IN TESTS TABLE
IF @testID NOT IN(SELECT [TestID] FROM [Tests])
	BEGIN	
		PRINT 'Test not in Tests'
		RETURN
	END

	IF @testRunID NOT IN (SELECT [TestRunID] FROM [TestRuns])
	BEGIN
		PRINT 'TestRun not in TestRuns'
		RETURN
	END

	PRINT 'Insert data in all the tables for the test ' + CONVERT(VARCHAR, @testID)
	DECLARE @tableID INT
	DECLARE @pos INT
	--cursor to iterate through the tables in ascending order of their position
	DECLARE allTablesCursorAsc CURSOR LOCAL FOR
		SELECT T1.TableID, T1.Position
		FROM TestTables T1
		INNER JOIN Tests T2 ON T2.TestID=T1.TestID
		WHERE T1.TestID =@testID
		ORDER BY T1.Position ASC

	OPEN allTablesCursorAsc
	FETCH allTablesCursorAsc INTO @tableID, @pos
	WHILE @@FETCH_STATUS=0
	BEGIN
		PRINT 'INSERT INTO TABLE 1'
		EXEC insertDataIntoTable @testRunID, @testID, @tableID
		FETCH NEXT FROM allTablesCursorAsc INTO @tableID, @pos
		PRINT 'INSERT INTO TABLE 2'
	END
	CLOSE allTablesCursorAsc
	DEALLOCATE allTablesCursorAsc

	
END



--RUN PROCEDURES----------------------------------------------------------------------------------------------------------------------

GO
CREATE OR ALTER PROCEDURE runTest(@testID INT, @description VARCHAR(MAX))AS
BEGIN
	--CHECK IF THE TEST EXITS IN TESTS TABLE
	IF @testId NOT IN(SELECT [TestID] FROM [Tests])
	BEGIN
		PRINT ('Test '+CONVERT(VARCHAR,@testId)+'doesn t exist in Test table!')
		RETURN
	END

	INSERT INTO TestRuns([Description]) VALUES (@description)
	DECLARE @testRunId INT=(SELECT MAX(TestRunID) FROM TestRuns)
	EXEC deleteDataFromAllTables @testID
	DECLARE @startTime DATETIME=SYSDATETIME()

	EXEC insertDataIntoAllTable @testRunID, @testID
	DECLARE @endTime DATETIME=SYSDATETIME()
	--EXEC deleteDataFromAllTables @testID

	UPDATE [TestRuns] SET StartAt=@startTime, EndAt=@endTime
	DECLARE @timeDifference INT = DATEDIFF(SECOND, @startTime, @endTime)
	PRINT 'The test with id ' + CONVERT(VARCHAR, @testID) + ' took ' + CONVERT(VARCHAR, @timeDifference) + ' seconds.'

END


----------------------------------------------------------------------------------------------------------------------

GO
CREATE OR ALTER PROCEDURE runAllTests AS
BEGIN
	DECLARE @testName VARCHAR(50)
	DECLARE @testID INT
	DECLARE @description VARCHAR(2000)
	--cursor to iterate through the tests
	DECLARE allTestsCursor CURSOR LOCAL FOR
		SELECT *
		FROM Tests

	OPEN allTestsCursor
	FETCH allTestsCursor INTO @testID, @testName
	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT 'Running ' + @testName
		SET @description = 'Test results for test with the ID ' + CAST(@testID AS VARCHAR(2))
		EXEC runTest @testID, @description
		FETCH NEXT FROM allTestsCursor INTO @testID, @testName
	END
	CLOSE allTestsCursor
	DEALLOCATE allTestsCursor
END