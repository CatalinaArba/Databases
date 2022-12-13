--TESTS

--TEST1
--  a table with no foreign key and a single-column primary key
-- -- a view with a SELECT statement operating on one table
EXEC addViewToViewsTable 'customersWithYahooAddress'
EXEC addTestToTestsTable 'Test1'
EXEC addTableToTablesTable 'Customers'
EXEC connectTestToTableInTestTablesTable 'Customers', 'Test1', 2, 1
EXEC connectTestToViewInTestViewTable 'customersWithYahooAddress', 'Test1'

--TEST 2
--2 table with a single-column primary key and at least one foreign key;
--a view with a SELECT statement that operates on at least 2 different tables and contains at least one JOIN operator;
EXEC addViewToViewsTable 'shopsAndTransactions'
EXEC addTestToTestsTable 'Test2'
EXEC addTableToTablesTable 'Shop'
EXEC connectTestToTableInTestTablesTable 'Shop', 'Test2', 2, 1
EXEC addTableToTablesTable 'Transactions'
EXEC connectTestToTableInTestTablesTable 'Transactions', 'Test2', 2,2
EXEC  connectTestToViewInTestViewTable 'shopsAndTransactions', 'Test2'

--TEST -
--2 table with a single-column primary key and at least one foreign key;
--1 a table with a multicolumn primary key,
--a view with a SELECT statement that has a GROUP BY clause, operates on at least 2 different tables and contains at least one JOIN operator.
EXEC addViewToViewsTable 'groupTransactionsByClothingDesigns'
EXEC addTestToTestsTable 'Test3'
EXEC addTableToTablesTable 'Transactions'
EXEC connectTestToTableInTestTablesTable 'Transactions', 'Test3', 2, 1
EXEC addTableToTablesTable 'ClothingDesigns'
EXEC connectTestToTableInTestTablesTable 'ClothingDesigns', 'Test3', 2, 2
--EXEC addTableToTablesTable 'TransactionsDetails'
EXEC connectTestToTableInTestTablesTable 'TransactionsDetails', 'Test3', 2, 3
EXEC connectTestToViewInTestViewTable 'groupTransactionsByClothingDesigns', 'Test3'



EXEC runAllTests


DELETE FROM TestRuns

DELETE FROM TestRunTables
DELETE FROM Tests
DELETE FROM TestTables
DELETE FROM TestViews
DELETE FROM Views
DELETE FROM Tables
DELETE FROM TestRunViews

SELECT *
FROM [Tests]

SELECT *
FROM [TestTables]

SELECT *
FROM [Customers]