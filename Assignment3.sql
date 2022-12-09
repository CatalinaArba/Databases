
/*g. create / drop a table.*/
CREATE OR ALTER PROCEDURE USPAddMembershipCard
AS
	CREATE TABLE MembershipCard
	(membershipCardId CHAR(10),
	customerID CHAR(10) ,
	loyaltyPoints INT,
	CONSTRAINT membershipCardPrimaryKey PRIMARY KEY (membershipCardId)
	)
EXEC USPAddMembershipCard

go 
CREATE OR ALTER PROCEDURE USPRemoveMembershipCard
AS
	DROP TABLE MembershipCard

EXEC USPRemoveMembershipCard

/*a)Modify the type of a cloumn*/
go 
CREATE OR ALTER PROCEDURE USPAlterSalaryInShopAssistentFromIntToDecimal
AS
	ALTER TABLE ShopAssistent
	ALTER COLUMN Salary DECIMAL(10,2);
GO
EXEC USPAlterSalaryInShopAssistentFromIntToDecimal;
GO

CREATE OR ALTER PROCEDURE USPAlterSalaryInShopAssistentFromDecimalToInt
AS
	ALTER TABLE ShopAssistent
	ALTER COLUMN Salary INT;
GO
EXEC USPAlterSalaryInShopAssistentFromDecimalToInt;
GO

/*b. add / remove a column;*/
CREATE OR ALTER PROCEDURE USPAlterAddDateToModifications
AS
	ALTER TABLE Modifications
	ADD  DateOfModification Date
GO
EXEC USPAlterAddDateToModifications
GO
CREATE OR ALTER PROCEDURE USPAlterRemoveDateToModifications
AS
	ALTER TABLE Modifications
	DROP COLUMN DateOfModification
GO
EXEC USPAlterRemoveDateToModifications
GO

/*c. add / remove a DEFAULT constraint;*/

CREATE OR ALTER PROCEDURE USPAddDefaultConstraintOnShippingCost
AS
	ALTER TABLE Shipping
	ADD CONSTRAINT defaultShippingCost
	DEFAULT(25) FOR shippingCost
GO
EXEC USPAddDefaultConstraintOnShippingCost
GO

CREATE OR ALTER PROCEDURE USPRemoveDefaultConstraintOnShippingCost
AS
	ALTER TABLE Shipping  DROP CONSTRAINT defaultShippingCost
GO
EXEC USPRemoveDefaultConstraintOnShippingCost
GO


/*d. add / remove a primary key;*/
CREATE OR ALTER PROCEDURE USPRemovePKForMemebershipCard
AS
	ALTER TABLE MembershipCard
	DROP CONSTRAINT membershipCardPrimaryKey
		
GO
EXEC USPRemovePKForMemebershipCard
GO

CREATE OR ALTER PROCEDURE USPAddPKForMemebershipCard
AS
	ALTER TABLE MembershipCard
	ADD CONSTRAINT membershipCardPrimaryKey PRIMARY KEY (membershipCardId) 
GO
EXEC USPAddPKForMemebershipCard
GO

/*e. add / remove a candidate key;*/
CREATE OR ALTER PROCEDURE USPAddUCForCustomers
AS
	ALTER TABLE Customers
	ADD CONSTRAINT unique_mail UNIQUE (Fname,Lname,gmail);
GO
EXEC USPAddUCForCustomers
GO

CREATE OR ALTER PROCEDURE USPRemoveUCForCustomers
AS
	ALTER TABLE Customers
	DROP CONSTRAINT unique_mail
GO
EXEC USPRemoveUCForCustomers
GO

/*f. add / remove a foreign key;*/
CREATE OR ALTER PROCEDURE USPAddFKShopIdForModification
AS
	ALTER TABLE MembershipCard
	ADD CONSTRAINT customerIdForeignKey FOREIGN KEY(customerID ) REFERENCES Customers(customerID);
GO
EXEC USPAddFKShopIdForModification
GO

CREATE OR ALTER PROCEDURE USPRemoveFKShopIdForModification
AS
	ALTER TABLE MembershipCard
	DROP CONSTRAINT customerIdForeignKey
GO
EXEC USPRemoveFKShopIdForModification
GO




CREATE TABLE versionTable (
	version INT
)

INSERT INTO versionTable 
VALUES
	(0)

CREATE TABLE procedureTable (
	initial_version INT,
	final_version INT,
	procedure_name VARCHAR(MAX),
	PRIMARY KEY (initial_version, final_version)
)

INSERT INTO procedureTable
VALUES
	(0, 1, 'USPAddMembershipCard'),
	(1, 0, 'USPRemoveMembershipCard'),
	(1, 2, 'USPAlterSalaryInShopAssistentFromIntToDecimal'),
	(2, 1, 'USPAlterSalaryInShopAssistentFromDecimalToInt'),
	(2, 3, 'USPAlterAddDateToModifications'), 
	(3, 2, 'USPAlterRemoveDateToModifications'),
	(3, 4, 'USPAddDefaultConstraintOnShippingCost'),
	(4, 3, 'USPRemoveDefaultConstraintOnShippingCost'),
	(4, 5, 'USPRemovePKForMemebershipCard'),
	(5, 4, 'USPAddPKForMemebershipCard'),
	(5, 6, 'USPAddUCForCustomers'),
	(6, 5, 'USPRemoveUCForCustomers'),
	(6, 7, 'USPAddFKShopIdForModification'),
	(7, 6, 'USPRemoveFKShopIdForModification')
	


 GO
CREATE OR ALTER PROCEDURE goToVersion(@newVersion INT) 
AS
	DECLARE @current_version INT
	DECLARE @procedureName VARCHAR(MAX)
	SELECT @current_version = version FROM versionTable

	IF (@newVersion > (SELECT MAX(final_version) FROM procedureTable) OR @newVersion < 0)
		RAISERROR ('Bad version', 10, 1)
	ELSE
	BEGIN
		IF @newVersion = @current_version
			PRINT('You are already on this version!');
		ELSE
		BEGIN
			IF @current_version > @newVersion
			BEGIN
				WHILE @current_version > @newVersion 
					BEGIN
						SELECT @procedureName = procedure_name FROM procedureTable WHERE initial_version = @current_version AND final_version = @current_version-1
						PRINT('Executing ' + @procedureName);
						EXEC (@procedureName)
						SET @current_version = @current_version - 1
					END
			END

			IF @current_version < @newVersion
			BEGIN
				WHILE @current_version < @newVersion 
					BEGIN
						SELECT @procedureName = procedure_name FROM procedureTable WHERE initial_version = @current_version AND final_version = @current_version+1
						PRINT('Executing ' + @procedureName);
						EXEC (@procedureName)
						SET @current_version = @current_version + 1
					END
			END

			UPDATE versionTable SET version = @newVersion
		END
	END

EXEC goToVersion 1


SELECT *
FROM versionTable

SELECT *
FROM procedureTable