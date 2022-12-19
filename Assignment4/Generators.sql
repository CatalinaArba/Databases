GO

IF EXISTS (SELECT [name] FROM sys.objects 
            WHERE object_id = OBJECT_ID('generateRandomString'))
BEGIN
   DROP PROCEDURE generateRandomString;
END

IF EXISTS (SELECT [name] FROM sys.objects
			WHERE object_id = OBJECT_ID('generateRandomDataForTable'))
BEGIN
	DROP PROCEDURE generateRandomDataForTable
END

--procedure to generate a random string with a limited length
GO 
CREATE OR ALTER PROCEDURE generateRandomString @RandomString VARCHAR(10) OUTPUT AS
BEGIN

	--SELECT @stringValue = CONVERT(varchar(255), NEWID()) COULD BE AN ALTERNATIVE WAY
	--OR A MORE FLEXIBLE WAY:
	DECLARE @Length INT
	DECLARE @CharPool VARCHAR(50)
	DECLARE @PoolLength INT
	DECLARE @LoopCount INT

	-- min_length = 8, max_length = 12
	SET @Length = RAND() * 5 + 8
	-- SET @Length = RAND() * (max_length - min_length + 1) + min_length 

	-- define allowable character explicitly - easy to read this way an easy to 
	-- omit easily confused chars like l (ell) and 1 (one) or 0 (zero) and O (oh)
	

	SET @CharPool = 
		'abcdefghijkmnopqrstuvwxyzABCDEFGHIJKLMNPQRSTUVWXYZ'
	SET @PoolLength = Len(@CharPool)
	SET @LoopCount = 0
	SET @RandomString = ''

	WHILE (@LoopCount < @Length) BEGIN
		SELECT @RandomString = @RandomString + 
			SUBSTRING(@Charpool, CONVERT(int, RAND() * @PoolLength) + 1, 1)
		SELECT @LoopCount = @LoopCount + 1
	END
END

--TEST THE PROCEDURE 'generateRandomString'
--DECLARE @RandomString VARCHAR(50)
--EXEC generateRandomString @RandomString OUTPUT
--PRINT(@RandomString)

----------------------------------------------------------------------------------------------------------------------
GO
CREATE OR ALTER PROCEDURE generateDataForTable @tableName VARCHAR(50),@numberOfRows INT AS
BEGIN
	--CREATE A CURSOR TO ITERATE THROUGH THE NAMES AND TYPES OF THE COLUMN 
	DECLARE dataCursor SCROLL CURSOR FOR
		SELECT COLUMN_NAME, DATA_TYPE
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME=@tableName
		ORDER BY ORDINAL_POSITION

	--DECLARATIONS
	DECLARE @columnName VARCHAR(200)
	DECLARE @dataType VARCHAR(20)
	DECLARE @intValue INT
	DECLARE @stringValue VARCHAR(50)
	DECLARE @checkIfPKQuery NVARCHAR(20)
	DECLARE @hasPK INT

	--QUERY USED TO INSERT IN TABLES
	DECLARE @insertQuery VARCHAR(MAX)

	--OPEN CURSOR 
	OPEN dataCursor

	WHILE @numberOfRows > 0
	BEGIN
		PRINT @numberOfRows
		SET @hasPK = 0
		SET @insertQuery = 'INSERT INTO ' + @tableName + ' VALUES('
		SET @checkIfPKQuery = N'SELECT @outputPK = COUNT(*) FROM ' + @tableName + ' WHERE '
		FETCH FIRST FROM dataCursor INTO @columnName, @dataType
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF COLUMNPROPERTY(OBJECT_ID(@tableName), @columnName, 'IsIdentity') = 0
			BEGIN
				-- check if the current column has a foreign key property and if it has, take its values from the referenced table
				IF EXISTS(
					SELECT *
					FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE C
					WHERE C.CONSTRAINT_NAME like 'FK%' AND @columnName = C.COLUMN_NAME AND @tableName = C.TABLE_NAME)
					BEGIN
					    --PRINT 'into fk check'
						-- get the name of the referenced table and the name of the referenced column
						DECLARE @referencedTable VARCHAR(50)
						DECLARE @referencedColumn VARCHAR(50)
						DECLARE @result TABLE([tableName] VARCHAR(50), [columnName] VARCHAR(50))
						INSERT INTO @result SELECT OBJECT_NAME (f.referenced_object_id) AS referenced_table_name,
						COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS referenced_column_name
						FROM sys.foreign_keys AS f
						INNER JOIN sys.foreign_key_columns AS fc ON f.object_id = fc.constraint_object_id
						WHERE fc.parent_object_id = OBJECT_ID(@tableName) AND COL_NAME(fc.parent_object_id, fc.parent_column_id) = @columnName

						SET @referencedTable = (SELECT TOP 1 [tableName] FROM @result)
						SET @referencedColumn = (SELECT TOP 1 [columnName] FROM @result)
						
						-- empty the table, otherwise it will always have at the top the first table and column found
						DELETE FROM @result

						-- int case
						IF @dataType = 'int'
							BEGIN
								-- get a random value from the referenced table
								DECLARE @getRandomFK NVARCHAR(1000)
								SET @getRandomFK = N'SELECT TOP 1 @intValue = [' + @referencedColumn + '] FROM ' + @referencedTable + ' ORDER BY NEWID()'
								EXEC sp_executesql @getRandomFK, N'@intValue INT OUTPUT', @intValue OUTPUT
								SET @insertQuery = @insertQuery + CAST(@intValue AS NVARCHAR(10)) + ','
							END
						ELSE
							-- string case
							IF @dataType = 'varchar' OR @dataType = 'char'
								BEGIN
									-- get a random value from the values in the referenced table
									DECLARE @getStringQuery NVARCHAR(200)
									SET @getStringQuery = N'SELECT TOP 1 @stringValue = ['  + @referencedColumn + '] FROM ' + @referencedTable + ' T WHERE ' +
									@columnName + ' = T.' + @columnName + ' ORDER BY NEWID()'
									EXEC sp_executesql @getStringQuery, N'@stringValue VARCHAR(50) OUTPUT', @stringValue OUTPUT
									SET @insertQuery = @insertQuery + '''' + @stringValue + ''','
								END
					END
				ELSE
				    --PRINT 'No FK'
					-- not a foreign key, does not depend on another table
					BEGIN
						IF @dataType = 'int'
							BEGIN
								-- generate a random number
								SET @intValue = FLOOR(RAND() * 1000) + 1
								SET @insertQuery = @insertQuery + CAST(@intValue AS NVARCHAR(10)) + ','
							END
						ELSE
							IF @dataType = 'varchar' OR @dataType = 'char'
								BEGIN
									-- generate a random string
									EXEC generateRandomString @stringValue OUTPUT
									SET @insertQuery = @insertQuery + '''' + @stringValue + '''' + ','
								END
							ELSE
								BEGIN
									SET @insertQuery = @insertQuery + 'NULL' + ','
								END
					END

				-- if the column has a primary key, create a query t check its validity
				-- this will also check for multicolumn primary keys
				IF EXISTS(
					SELECT *
					FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE
					WHERE TABLE_NAME = @tableName AND COLUMN_NAME = @columnName AND CONSTRAINT_NAME LIKE 'PK%')
					BEGIN
						SET @hasPK = 1
						IF @dataType = 'varchar'OR @dataType = 'char'
							BEGIN
								SET @checkIfPKQuery = @checkIfPKQuery + @columnName + '=''' + @stringValue + ''' AND '
							END
						IF @dataType = 'int'
							BEGIN
								SET @checkIfPKQuery = @checkIfPKQuery + @columnName + '=' + CAST(@intValue AS VARCHAR(10)) + ' AND '
							END
					END
			END
			FETCH NEXT FROM dataCursor INTO @columnName, @dataType
		END
		-- insert only if the primary key is valid
		--PRINT @hasPK
		IF @hasPK = 1
			BEGIN
				PRINT 'In PK=1'
				SET @checkIfPKQuery = LEFT(@checkIfPKQuery, LEN(@checkIfPKQuery) - 4)
				PRINT @checkIfPKQuery
				DECLARE @outputPK INT
				EXEC sp_executesql @checkIfPKQuery, N'@outputPK INT OUTPUT', @outputPK OUTPUT
				PRINT @outputPK
				IF @outputPK = NULL OR @outputPK = 0
					BEGIN
						SET @insertQuery = LEFT(@insertQuery, LEN(@insertQuery) - 1) + ')'
						PRINT @insertQuery
						EXEC (@insertQuery)
						SET @numberOfRows = @numberOfRows - 1
					
					END
			END
		ELSE
			-- in this case there is no primary key
			BEGIN 
				PRINT 'In PK=0'
				SET @insertQuery = LEFT(@insertQuery, LEN(@insertQuery) - 1) + ')'
				EXEC (@insertQuery)
				SET @numberOfRows = @numberOfRows - 1
			
			END
	END
	CLOSE dataCursor
	DEALLOCATE dataCursor

END


