USE [Clothing Store 2]
IF OBJECT_ID(N'dbo.TransactionsDetails', N'U') IS NOT NULL  
   DROP TABLE [dbo].[TransactionsDetails];  
GO
IF OBJECT_ID(N'dbo.Shipping', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Shipping];  
GO
IF OBJECT_ID(N'dbo.Transactions', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Transactions];  
GO
IF OBJECT_ID(N'dbo.Modifications', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Modifications];  
GO
IF OBJECT_ID(N'dbo.StockOfClothing', N'U') IS NOT NULL  
   DROP TABLE [dbo].[StockOfClothing];  
GO
IF OBJECT_ID(N'dbo.ClothingDesigns', N'U') IS NOT NULL  
   DROP TABLE [dbo].[ClothingDesigns];  
GO
IF OBJECT_ID(N'dbo.ShopAssistent', N'U') IS NOT NULL  
   DROP TABLE [dbo].[ShopAssistent];  
GO
IF OBJECT_ID(N'dbo.Shop', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Shop];  
GO
IF OBJECT_ID(N'dbo.Store', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Store];  
GO
IF OBJECT_ID(N'dbo.Customers', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Customers];  
GO


CREATE TABLE Store
(storeID CHAR(10) PRIMARY KEY,
storeName VARCHAR(30),
storeLocation VARCHAR(40),
)


CREATE TABLE Shop
(shopID CHAR(10)PRIMARY KEY,
storeID CHAR(10) FOREIGN KEY REFERENCES Store(storeID),
shopName VARCHAR(30),
)


CREATE TABLE ShopAssistent
(shopAssistentID CHAR(10) PRIMARY KEY,
shopID CHAR(10) FOREIGN KEY REFERENCES Shop(shopID),
FName VARCHAR(15),
LName VARCHAR(15),
salary INT,
)


ALTER TABLE ShopAssistent 
ADD Age int;







CREATE TABLE Customers
(customerID CHAR(10) PRIMARY KEY,
FName VARCHAR(15),
LName VARCHAR(15),
telephone CHAR(11),
gmail VARCHAR(20),
)


CREATE TABLE Transactions
(transactionID CHAR(10) PRIMARY KEY,
customerID CHAR(10) FOREIGN KEY REFERENCES Customers(customerID),
shopID CHAR(10) FOREIGN KEY REFERENCES Shop(ShopID),
)
--ALTER TABLE Transactions ADD transactionDate date





CREATE TABLE ClothingDesigns
(clothingDesignID CHAR(10) PRIMARY KEY,
pieceType VARCHAR(15),
gender CHAR(15),
price INT
)

CREATE TABLE TransactionsDetails
(transactionDetailID CHAR(10) PRIMARY KEY,
transactionID CHAR(10) FOREIGN KEY REFERENCES Transactions(transactionID),
clothingDesignID CHAR(10) FOREIGN KEY REFERENCES ClothingDesigns(clothingDesignID),
)


CREATE TABLE StockOfClothing
(stockID CHAR(10) PRIMARY KEY ,
shopID CHAR(10)FOREIGN KEY REFERENCES Shop(shopID),
clothingDesignID CHAR(10) FOREIGN KEY REFERENCES ClothingDesigns(clothingDesignID),
numberOfPieces INT,
)


CREATE TABLE Modifications
(modificationID CHAR(10) PRIMARY KEY,
shopAssistentID CHAR(10)FOREIGN KEY REFERENCES ShopAssistent(shopAssistentID),
stockID CHAR(10) FOREIGN KEY REFERENCES StockOfClothing(stockID),
startNumberOfPieces INT,
endNumberOfPieces INT,
)


CREATE TABLE Shipping
(shippingID CHAR(10) PRIMARY KEY,
transactionID CHAR(10) FOREIGN KEY REFERENCES Transactions(transactionID),
shippingCost INT,
destination VARCHAR(20),
UNIQUE(transactionID),
)


