INSERT INTO Store(storeID, storeName, storeLocation) VALUES('1','Iulius Mall','Cluj-Napoca')
INSERT INTO Store(storeID, storeName, storeLocation) VALUES('2','VIVO','Floresti')
INSERT INTO Store(storeID, storeName, storeLocation) VALUES('3','Palas','Iasi')
INSERT INTO Store(storeID, storeName, storeLocation) VALUES('4','Palas','Bucuresti')
INSERT INTO Store(storeID, storeName, storeLocation) VALUES('5','Afi','Bucuresti')

INSERT INTO ShopAssistent(shopAssistentID,shopID,FName,LName,salary) VALUES ('1','1','Ana','Popescu',1400)
INSERT INTO ShopAssistent(shopAssistentID,shopID,FName,LName,salary) VALUES ('2','1','Georgiana','Ionescu',12000)
INSERT INTO ShopAssistent(shopAssistentID,shopID,FName,LName,salary) VALUES ('3','3','Maria','Pop',7000)
INSERT INTO ShopAssistent(shopAssistentID,shopID,FName,LName,salary) VALUES ('4','4','Cristina','Moldovan',4000)
INSERT INTO ShopAssistent(shopAssistentID,shopID,FName,LName,salary) VALUES ('5','4','Luiza','Crisan',3800)
INSERT INTO ShopAssistent(shopAssistentID,shopID,FName,LName,salary) VALUES ('6','10','Luiza','Crisan',3800)

ALTER TABLE Customers ADD age int;
INSERT INTO Customers(customerID,FName,LName,telephone,gmail) VALUES ('1','George','Istrate','07411811771','george@yahoo.com')
INSERT INTO Customers(customerID,FName,LName,telephone,gmail) VALUES ('2','Mihai','Popescu','07414411771','mihai@yahoo.com')
INSERT INTO Customers(customerID,FName,LName,telephone,gmail) VALUES ('3','Cristi','Morar','07422811771','cristi@yahoo.com')
INSERT INTO Customers(customerID,FName,LName,telephone,gmail) VALUES ('4','Alex','Anisia','07416711771','alex@gmail.com')
INSERT INTO Customers(customerID,FName,LName,telephone,gmail) VALUES ('5','Dan','Beldean','07411818971','dan@gmail.com')

INSERT INTO Transactions(transactionID,customerID,shopID) VALUES('1','1','1')
INSERT INTO Transactions(transactionID,customerID,shopID) VALUES('2','1','2')
INSERT INTO Transactions(transactionID,customerID,shopID) VALUES('3','2','1')
INSERT INTO Transactions(transactionID,customerID,shopID) VALUES('4','2','2')
INSERT INTO Transactions(transactionID,customerID,shopID) VALUES('5','3','2')

INSERT INTO ClothingDesigns(clothingDesignID,pieceType,gender,price) VALUES('1','bluza','F',300)
INSERT INTO ClothingDesigns(clothingDesignID,pieceType,gender,price) VALUES('2','maieu','F',50)
INSERT INTO ClothingDesigns(clothingDesignID,pieceType,gender,price) VALUES('3','rochie','F',89)
INSERT INTO ClothingDesigns(clothingDesignID,pieceType,gender,price) VALUES('4','pantaloni','M',130)
INSERT INTO ClothingDesigns(clothingDesignID,pieceType,gender,price) VALUES('5','cravata','M',200)
INSERT INTO ClothingDesigns(clothingDesignID,pieceType,gender,price) VALUES('6','cravata2','M',400)
INSERT INTO ClothingDesigns(clothingDesignID,pieceType,gender,price) VALUES('7','cravata3','M',650)

INSERT INTO TransactionsDetails(transactionDetailID,transactionID,clothingDesignID) VALUES('1','1','1')
INSERT INTO TransactionsDetails(transactionDetailID,transactionID,clothingDesignID) VALUES('2','1','2')
INSERT INTO TransactionsDetails(transactionDetailID,transactionID,clothingDesignID) VALUES('3','2','2')
INSERT INTO TransactionsDetails(transactionDetailID,transactionID,clothingDesignID) VALUES('4','3','3')
INSERT INTO TransactionsDetails(transactionDetailID,transactionID,clothingDesignID) VALUES('5','4','4')
INSERT INTO TransactionsDetails(transactionDetailID,transactionID,clothingDesignID) VALUES('6','5','4')

INSERT INTO StockOfClothing(stockID,shopID,clothingDesignID,numberOfPieces) VALUES('1','1','1',10)
INSERT INTO StockOfClothing(stockID,shopID,clothingDesignID,numberOfPieces) VALUES('2','1','2',5)
INSERT INTO StockOfClothing(stockID,shopID,clothingDesignID,numberOfPieces) VALUES('3','2','3',6)
INSERT INTO StockOfClothing(stockID,shopID,clothingDesignID,numberOfPieces) VALUES('4','2','4',9)
INSERT INTO StockOfClothing(stockID,shopID,clothingDesignID,numberOfPieces) VALUES('5','3','5',11)
INSERT INTO StockOfClothing(stockID,shopID,clothingDesignID,numberOfPieces) VALUES('6','2','1',5)

INSERT INTO Modifications(modificationID,shopAssistentID,stockID,startNumberOfPieces,endNumberOfPieces) VALUES ('1','1','1',7,10)
INSERT INTO Modifications(modificationID,shopAssistentID,stockID,startNumberOfPieces,endNumberOfPieces) VALUES ('6','2','1',5,7)
INSERT INTO Modifications(modificationID,shopAssistentID,stockID,startNumberOfPieces,endNumberOfPieces) VALUES ('7','1','1',2,5)
INSERT INTO Modifications(modificationID,shopAssistentID,stockID,startNumberOfPieces,endNumberOfPieces) VALUES ('2','2','1',1,2)
INSERT INTO Modifications(modificationID,shopAssistentID,stockID,startNumberOfPieces,endNumberOfPieces) VALUES ('3','2','2',2,5)
INSERT INTO Modifications(modificationID,shopAssistentID,stockID,startNumberOfPieces,endNumberOfPieces) VALUES ('4','3','5',12,11)
INSERT INTO Modifications(modificationID,shopAssistentID,stockID,startNumberOfPieces,endNumberOfPieces) VALUES ('5','3','6',10,5)

INSERT INTO Shipping(shippingID,transactionID,shippingCost,destination) VALUES ('1','1',10,'Campia Turzii')
INSERT INTO Shipping(shippingID,transactionID,shippingCost,destination) VALUES ('2','2',10,'Cluj Napoca')
INSERT INTO Shipping(shippingID,transactionID,shippingCost,destination) VALUES ('3','3',15,'Turda')
INSERT INTO Shipping(shippingID,transactionID,shippingCost,destination) VALUES ('4','4',25,'Dej')
INSERT INTO Shipping(shippingID,transactionID,shippingCost,destination) VALUES ('5','5',5,'Sibiu')

UPDATE ShopAssistent SET Age=15 WHERE shopAssistentID<>'1'
UPDATE ShopAssistent SET Age=21 WHERE (shopAssistentID='2' OR shopAssistentID='3')
UPDATE ShopAssistent SET Age=30 WHERE FName='Cristina' AND shopID='4'
UPDATE ShopAssistent SET Age=28 WHERE shopAssistentID='5'

UPDATE Transactions SET transactionDate='2022-10-25' WHERE transactionID<='2'
UPDATE Transactions SET transactionDate='2022-11-11' WHERE transactionID<'1'
UPDATE Transactions SET transactionDate='2022-03-05' WHERE transactionID='3'
UPDATE Transactions SET transactionDate='2022-10-31' WHERE transactionID='4'
UPDATE Transactions SET transactionDate='2022-07-01' WHERE transactionID>'4'

UPDATE Customers SET Age=28 WHERE customerID='1'
UPDATE Customers SET Age=11 WHERE customerID='2'
UPDATE Customers SET Age=20 WHERE customerID='3'
UPDATE Customers SET Age=30 WHERE customerID='4'
UPDATE Customers SET Age=19 WHERE customerID='5'

DELETE FROM Store WHERE storeID is NULL
DELETE FROM Store WHERE storeID>3 and storeName='Palas'
DELETE FROM Store WHERE storeName like '%i'
DELETE FROM ClothingDesigns WHERE price  in( 500,600)
DELETE FROM ClothingDesigns WHERE price  between 600 and 800
DELETE FROM ShopAssistent WHERE shopID='6'




/*a. 2 queries with the union operation; use UNION [ALL] and OR;
1. Find the ids and the name of the shop assistents that work at Zara and made a modification aboutmaieu or bluza*/

SELECT A.ShopAssistentID, A.FName, A.LName
FROM ShopAssistent A,Modifications M,Shop S,StockOfClothing SC,ClothingDesigns CD
WHERE S.shopName='Zara' and S.shopID=A.shopID and M.stockID=SC.stockID and SC.clothingDesignID=CD.clothingDesignID and CD.pieceType='bluza'
UNION
SELECT A2.ShopAssistentID, A2.FName, A2.LName
FROM Modifications M2,ShopAssistent A2,Shop S2,StockOfClothing SC2,ClothingDesigns CD2
WHERE S2.shopName='Zara' and A2.ShopID=S2.shopID and M2.stockID=SC2.stockID and SC2.clothingDesignID=CD2.clothingDesignID and CD2.pieceType='maieu'


SELECT DISTINCT A.ShopAssistentID, A.FName, A.LName
FROM ShopAssistent A,Modifications M,Shop S,StockOfClothing SC,ClothingDesigns CD
WHERE S.shopName='Zara' and S.shopID=A.shopID and M.stockID=SC.stockID and SC.clothingDesignID=CD.clothingDesignID and (CD.pieceType='bluza' or CD.pieceType='maieu')


/*2.Find all the shop  name and the shop assistents names that are in Iulius Mall and have a illigal salary(<1500 ron or >9000 ron)*/
SELECT S.shopName, A.FName, A.LName,A.salary
FROM Shop S,ShopAssistent A,Store ST
WHERE ST.storeName='Iulius Mall' and S.storeID=ST.storeID and A.salary<1500 and A.shopID=S.shopID
UNION
SELECT S2.shopName, A2.FName, A2.LName,A2.salary
FROM Shop S2,ShopAssistent A2,Store ST2
WHERE ST2.storeName='Iulius Mall'and S2.storeID=ST2.storeID and A2.salary>9000 and A2.shopID=S2.shopID


SELECT S.shopName, A.FName, A.LName,A.salary
FROM Shop S,ShopAssistent A,Store ST
WHERE ST.storeName='Iulius Mall' and S.storeID=ST.storeID  and A.shopID=S.shopID and (A.salary<1500 or a.salary>9000)

/*b. 2 queries with the intersection operation; use INTERSECT and IN;
1.Find all customers that made a transaction in the shop Zara and Bershka*/
SELECT C.customerID, C.FName, C.LName
FROM Transactions T,  Customers C, Shop S
WHERE T.customerID=C.customerID and S.shopName='Zara' and S.shopID=T.shopID
INTERSECT 
SELECT C2.customerID,  C2.FName, C2.LName
FROM Transactions T2,Shop S2,Customers C2
WHERE T2.customerID=C2.customerID and S2.shopName='Bershka' and S2.shopID=T2.shopID

SELECT C.customerID, C.FName, C.LName
FROM Transactions T, Customers C, Shop S
WHERE T.customerID=C.customerID and S.shopName='Bershka' and S.shopID=T.shopID and C.customerID  IN
(SELECT C2.customerID
FROM Transactions T2,Shop S2,Customers C2
WHERE T2.customerID=C2.customerID and S2.shopName='Zara'  and S2.shopID=T2.shopID)


/*2.All customers that have at least 2 transactions*/
SELECT  C2.customerID,C2.FName,C2.LName, COUNT(T2.transactionID) AS NrOfTransactions
FROM Customers C2, Transactions T2
WHERE C2.customerID=T2.customerID 
GROUP BY C2.customerID,C2.FName,C2.LName
HAVING COUNT(*) > 1;

/*3.All the negative modification that are made by a shop assistent that works in Zara */
SELECT M.modificationID,  A.shopAssistentID, A.FName, A.LName, M.startNumberOfPieces, M.endNumberOfPieces
FROM ShopAssistent A, Modifications M, Shop S
WHERE M.shopAssistentID=A.shopAssistentID and S.shopID=A.shopAssistentID and S.shopName='Zara'
INTERSECT
SELECT M2.modificationID,A2.shopAssistentID, A2.FName, A2.LName,  M2.startNumberOfPieces, M2.endNumberOfPieces
FROM ShopAssistent A2, Modifications M2, Shop S2
WHERE M2.shopAssistentID=A2.shopAssistentID and S2.shopID=A2.shopAssistentID and M2.startNumberOfPieces>M2.endNumberOfPieces


SELECT M.modificationID,  A.shopAssistentID, A.FName, A.LName, M.startNumberOfPieces, M.endNumberOfPieces
FROM ShopAssistent A, Modifications M, Shop S
WHERE M.shopAssistentID=A.shopAssistentID and S.shopID=A.shopAssistentID and S.shopName='Zara' and M.modificationID IN(
SELECT M2.modificationID
FROM ShopAssistent A2, Modifications M2, Shop S2
WHERE M2.shopAssistentID=A2.shopAssistentID and S2.shopID=A2.shopAssistentID and M2.startNumberOfPieces>M2.endNumberOfPieces)


/*2 queries with the difference operation; use EXCEPT and NOT IN;*/
/*1. Find all the ids and names of the shop assistents that have a salary bigger then 3900 ron and that did not introduces any modification */
SELECT A.shopAssistentID,A.FName,A.LName
FROM ShopAssistent A
WHERE A.salary>3900
EXCEPT
SELECT A2.shopAssistentID,A2.FName,A2.LName
FROM ShopAssistent A2, Modifications M2
WHERE A2.shopAssistentID=M2.shopAssistentID

SELECT A.shopAssistentID,A.FName,A.LName
FROM ShopAssistent A
WHERE A.salary>3900 and A.shopAssistentID NOT IN (SELECT A2.shopAssistentID
FROM ShopAssistent A2, Modifications M2
WHERE A2.shopAssistentID=M2.shopAssistentID)

/*2. Find the shops that have a transaction but that do not have any shop assistent hired*/
SELECT DISTINCT S.shopID
FROM Shop S, Transactions T
WHERE T.shopID=S.shopID
EXCEPT 
SELECT DiSTINCT S2.shopID
FROM Shop S2, ShopAssistent A2
WHERE S2.shopID=A2.shopID

SELECT DISTINCT S.shopID
FROM Shop S, Transactions T
WHERE T.shopID=S.shopID and S.shopID NOT IN (SELECT DISTINCT S2.shopID
FROM Shop S2, ShopAssistent A2
WHERE S2.shopID=A2.shopID)

/*d. 4 queries with INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL JOIN (one query per operator); one query will join at least 3 tables, while another one will join at least two many-to-many relationships;*/
/*1 All the stock of clothing from 'Zara' that have a stock of 'bluze', includeing also the one that are in zara but does't have a stock of blouse and the one that are not in zara but keep a stock of blouse and also the one that doesn't keep blouse and is not Zara
-3 tablse:clothing designs-stock of clothing- shop*/
SELECT */*S.shopName, S.shopID,CD.clothingDesignID,CD.pieceType*/
FROM StockOfClothing SC
LEFT JOIN ClothingDesigns CD on SC.clothingDesignID=CD.clothingDesignID and CD.pieceType='bluza'
LEFT JOIN Shop S on S.shopID=SC.shopID and S.shopName='Zara'

/*2)find all the shop's shop assistents, including shops that don't have any shop assistent*/
SELECT *
FROM Shop S FULL JOIN ShopAssistent A  on S.shopID=A.shopID

/*3)find all the customers' transaction, including the customers that didn't make a transaction*/
SELECT *
FROM Customers C FULL JOIN Transactions T on C.customerID=T.customerID


/*SELECT *
FROM Modifications M
RIGHT JOIN StockOfClothing S on M.stockID=S.stockID
RIGHT JOIN ShopAssistent A  on A.shopAssistentID=M.shopAssistentID

SELECT *
FROM StockOfClothing SOC
FULL JOIN Shop SH on SH.shopID=SOC.shopID
INNER JOIN ClothingDesigns CD on CD.clothingDesignID=SOC.clothingDesignID
INNER JOIN TransactionsDetails TD on TD.clothingDesignID=CD.clothingDesignID*/


/*4)All the customers that made a blouse transaction in shop ZARA*/
/*2 many to many relationships
1)customer-transaction-shop
2)transaction- transaction details-clothing design*/
SELECT *
FROM Customers C
INNER JOIN(Select t.customerID, t.transactionID
			From Transactions t INNER JOIN Shop s ON  t.shopID=s.shopID and s.shopName='Zara') o
ON c.customerID=o.customerID
INNER JOIN(Select td.transactionID
			FROM TransactionsDetails td INNER JOIN  ClothingDesigns cd ON td.clothingDesignID=cd.clothingDesignID and cd.pieceType='bluza') x
on x.transactionID=o.transactionID

/*e. 2 queries with the IN operator and a subquery in the WHERE clause; in at least one case, the subquery must include a subquery in its own WHERE clause;*/
/*1. All the clothing designs that have a stock value bigger then 5 */
SELECT C.clothingDesignID
FROM ClothingDesigns C
WHERE C.clothingDesignID in(SELECT S.clothingDesignID 
									FROM StockOfClothing S
									WHERE S.numberOfPieces>5)

/*2. The cheapest price for every gender of a product that was modified with a number of items smaller then 25)*/

SELECT C.gender, MIN(C.price)AS minimumPrice
FROM ClothingDesigns C
WHERE C.clothingDesignID in (SELECT s.clothingDesignID
					FROM StockOfClothing S
					WHERE S.stockID IN (SELECT  M.stockID
											FROM Modifications M
											WHERE M.endNumberOfPieces<25))
GROUP BY C.gender

/*f. 2 queries with the EXISTS operator and a subquery in the WHERE clause;*/
/*1. find top 3 the cheapest clothing design piece that were sold in a transaction */
SELECT TOP 3 *
FROM ClothingDesigns C
WHERE EXISTS (SELECT *
			FROM TransactionsDetails T
			WHERE T.clothingDesignID=c.clothingDesignID)
ORDER BY C.price


/*2.find the top 2 smallest salary of a shop assistent that made a modification*/

SELECT TOP 2 *
FROM ShopAssistent A
WHERE EXISTS( SELECT *
				FROM Modifications M
				WHERE M.shopAssistentID=A.shopAssistentID)
ORDER BY A.salary

/*g. 2 queries with a subquery in the FROM clause;*/
/*1.Find the name of the clients that made a transaction in the black friday period*/
SELECT DISTINCT C.customerID, C.FName, C.LName
FROM Customers C INNER JOIN
	(SELECT *
	FROM Transactions T
	WHERE T.transactionDate BETWEEN '2022-10-20' AND '2022-11-10') bf
ON bf.customerID=C.customerID 

/*2. Find the shops and the stocks of clothing where it is neccesary a stock refill(value is smaller then 10)*/
SELECT   *
FROM Shop S INNER JOIN(
	SELECT * 
	FROM StockOfClothing SC
	WHERE SC.numberOfPieces<10) sc
ON S.shopID=sc.shopID
ORDER BY S.shopName DESC



/*h. 4 queries with the GROUP BY clause, 3 of which also contain the HAVING clause;
2 of the latter will also have a subquery in the HAVING clause; use the aggregation operators: COUNT, SUM, AVG, MIN, MAX;*/

/*1.Find the name and average start value of the modification where the shop assistents that made at least 2 modifications about stock with id 1*/
SELECT A.FName,A.LName, AVG(M.startNumberOfPieces)
FROM ShopAssistent A, Modifications M
WHERE A.shopAssistentID=M.shopAssistentID AND M.stockID='1'
GROUP BY A.shopAssistentID,A.FName, A.LName
HAVING COUNT(*)>1

/*2. Find the name of the oldest shop asisstent from every shop from iulius mall that hea st least 1 shop asisstent
subquery in the HAVING clause,MAX*/
SELECT A.shopID,MAX(A.Age)as Age
FROM ShopAssistent A
GROUP BY A.shopID
HAVING 0<(SELECT COUNT(*)
			FROM Shop S
			WHERE S.shopID=A.shopID and S.storeID='1')


/*3. Find every customer with a yahoo email adress that made at least 1 transaction in iulius mall
this query is correct but group by is not used correctly (c.customer id is the primary key)*/
SELECT C.customerID
FROM Customers C
WHERE C.gmail LIKE '%yahoo.com'
GROUP BY C.customerID
HAVING 0<(SELECT COUNT(*)
		FROM Transactions T
		WHERE T.customerID=C.customerID  and T.shopID='1')

/*4 for every shop from iulius mall from find the minimum number of pieces of a stock*/

SELECT SC.shopID,MIN(SC.numberOfPieces) as minimumNrOfPieces
FROM StockOfClothing SC
GROUP BY SC.shopID
HAVING 0<(SELECT COUNT(*)
		FROM Shop S
		WHERE S.shopID=SC.shopID and S.storeID='1')






/*i. 4 queries using ANY and ALL to introduce a subquery in the WHERE clause (2 queries per operator); 
rewrite 2 of them with aggregation operators, and the other 2 with IN / [NOT] IN.*/
/*1.Find the name of top 5 shop assistents with the salary grater then any salary from shop asisstent from Stradivarius*/
SELECT TOP 5 A.FName,A.LName,A.salary
FROM ShopAssistent A
WHERE A.salary> ANY
	(SELECT A2.salary
	FROM ShopAssistent A2
	WHERE A2.shopID LIKE '4')
ORDER BY A.salary

SELECT TOP 5 A.FName,A.LName,A.salary
FROM ShopAssistent A
WHERE A.salary>
	(SELECT MIN(A2.salary)
	FROM ShopAssistent A2
	WHERE A2.shopID LIKE '4')
ORDER BY A.salary

/*2.Find the name of top 5 shop assistents with the salary grater then ALL salary from shop asisstent from Stradivarius*/
SELECT TOP 5 A.FName,A.LName,A.salary
FROM ShopAssistent A
WHERE A.salary> ALL
	(SELECT A2.salary
	FROM ShopAssistent A2
	WHERE A2.shopID LIKE '4')
ORDER BY A.salary

SELECT TOP 5 A.FName,A.LName,A.salary
FROM ShopAssistent A
WHERE A.salary>
	(SELECT MAX(A2.salary)
	FROM ShopAssistent A2
	WHERE A2.shopID LIKE '4')
ORDER BY A.salary

/*3. Find the name of the Shop Assistents that have a different last name then any of the customers.*/
SELECT  A.FName,A.LName
FROM ShopAssistent A
WHERE A.LName <> ALL
	(SELECT C.LName
	FROM Customers C)

SELECT  A.FName,A.LName
FROM ShopAssistent A
WHERE A.LName NOT IN
	(SELECT C.LName
	FROM Customers C)

/*4. Find the name of the shop asisstents that have the same age with any of the customers.*/

SELECT S.shopAssistentID,S.FName,S.LName,S.Age
FROM ShopAssistent S
WHERE S.Age=ANY (SELECT C.age
				FROM Customers C)

SELECT S.shopAssistentID,S.FName,S.LName,S.Age
FROM ShopAssistent S
WHERE S.Age IN(SELECT C.age
				FROM Customers C)

/*Arithmetic expression*/
/*1)cu cat s-a modificat fiecare modificare*/
SELECT M.modificationID,M.endNumberOfPieces-M.startNumberOfPieces
FROM Modifications M 
WHERE M.shopAssistentID='1'

/*2)Cati ani mai are fiecare shop assistent pana la pensionare*/
SELECT A.shopAssistentID,65-A.Age as AniRamasiPanaLaPensionare
FROM ShopAssistent A
WHERE A.shopID='1'

/*3)taxele pentru fiecare produs */
SELECT CD.clothingDesignID,CD.price*0.24 as Taxe
FROM ClothingDesigns CD

