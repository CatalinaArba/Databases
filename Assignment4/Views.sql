-- VIEWS

--a table with a single-column primary key and no foreign keys;
GO
CREATE OR ALTER VIEW customersWithYahooAddress AS
	SELECT C.customerID
	FROM Customers C
	WHERE C.gmail LIKE '%yahoo.com'


--a view with a SELECT statement that operates on at least 2 different tables and contains at least one JOIN operator;
GO
CREATE OR ALTER VIEW shopsAndTransactions AS
	SELECT S.shopName, T.transactionID
	FROM Shop S INNER JOIN Transactions T 
	ON t.shopID=s.shopID

--a view with a SELECT statement that has a GROUP BY clause, operates on at least 2 different tables and contains at least one JOIN operator.
GO
CREATE OR ALTER VIEW groupTransactionsByClothingDesigns  AS
	SELECT CD.clothingDesignID, COUNT(*) AS ClothingDesignsTransactions
	FROM Transactions T
	INNER JOIN TransactionsDetails TD ON t.transactionID=TD.transactionDetailID
	INNER JOIN ClothingDesigns CD ON CD.clothingDesignID=TD.clothingDesignID
	GROUP BY CD.clothingDesignID