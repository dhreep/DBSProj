--Write a query to fetch the details of all the customers along with their transaction history.
SELECT C.Customer_ID, C.Customer_Name, O.Transaction_ID, O.Transaction_Date, O.Transaction_Time, O.Quantity_of_Sale, O.Selling_Price, O.Final_Cost, O.Method_Of_Payment, O.Order_Staus
FROM Customer C
JOIN Orders O ON C.Customer_ID = O.Customer_ID;

--Write a query to fetch the details of all the customers who have not made any purchases yet.
SELECT C.Customer_ID, C.Customer_Name
FROM Customer C
WHERE NOT EXISTS (
    SELECT 1 FROM Orders O WHERE C.Customer_ID = O.Customer_ID
);

--Write a query to fetch the details of all the customers who made a purchase on or after 1st January 2023.
SELECT C.Customer_ID, C.Customer_Name, O.Transaction_Date
FROM Customer C
JOIN Orders O ON C.Customer_ID = O.Customer_ID
WHERE O.Transaction_Date >= TO_DATE('01-JAN-23', 'DD-MON-YY');

--Write a query to fetch the details of all the customers who made a purchase from a warehouse located in pincode 123456.
SELECT C.Customer_ID, C.Customer_Name, O.Transaction_Date
FROM Customer C
JOIN Orders O ON C.Customer_ID = O.Customer_ID
JOIN Warehouse_Address W ON O.Warehouse_ID = W.Warehouse_ID
WHERE W.Warehouse_PinCode = 123456;

--Write a query to fetch the details of all the products that have not been sold yet.
SELECT I.Product_ID, I.Product_Name, I.Cost_Price, I.Prod_Type, I.Manufacture_Date, I.Expiry_Date
FROM Inventory I
WHERE NOT EXISTS (
    SELECT 1 FROM Orders O WHERE I.Product_ID = O.Product_ID
);

--Write a query to fetch the details of all the products that have been sold at least once.

SELECT DISTINCT I.Product_ID, I.Product_Name, I.Cost_Price, I.Prod_Type, I.Manufacture_Date, I.Expiry_Date
FROM Inventory I
JOIN Orders O ON I.Product_ID = O.Product_ID;


--Write a query to fetch the details of all the products that are currently in stock in a warehouse located in pincode 123456.
SELECT I.Product_ID, I.Product_Name, I.Cost_Price, I.Prod_Type, I.Manufacture_Date, I.Expiry_Date, L.Quantity
FROM Inventory I
JOIN Located_in L ON I.Product_ID = L.Product_ID
JOIN Warehouse_Address W ON L.Warehouse_ID = W.Warehouse_ID
WHERE W.Warehouse_PinCode = 123456;

--Write a query to fetch the details of all the customers who live in the same address.

SELECT C1.Customer_ID, C1.Customer_Name, C2.Customer_ID, C2.Customer_Name, CA.Customer_Address, CA.Customer_Pincode
FROM Customer C1
JOIN Lives_in L1 ON C1.Customer_ID = L1.Customer_ID
JOIN Customer_Address CA ON L1.Address_ID = CA.Address_ID
JOIN Lives_in L2 ON CA.Address_ID = L2.Address_ID
JOIN Customer C2 ON L2.Customer_ID = C2.Customer_ID
WHERE C1.Customer_ID <> C2.Customer_ID;

--Query to find the details of all the customers who have made purchases:

SELECT *
FROM Customer
WHERE Customer_ID IN (SELECT DISTINCT Customer_ID FROM Orders);


--Query to find the total revenue generated from each method of payment:

SELECT Method_Of_Payment, SUM(Final_Cost) AS Revenue
FROM Orders
GROUP BY Method_Of_Payment;


--Query to find the total quantity of each product sold:

SELECT Product_Name, SUM(Quantity_of_Sale) AS Total_Quantity
FROM Inventory
JOIN Orders ON Inventory.Product_ID = Orders.Product_ID
GROUP BY Product_Name

--Query to find the address of the warehouse with the largest inventory:

SELECT Warehouse_Address, Warehouse_PinCode
FROM Warehouse_Address
WHERE Warehouse_ID = (
  SELECT Warehouse_ID
  FROM Located_in
  GROUP BY Warehouse_ID
  ORDER BY SUM(Quantity) DESC
  FETCH FIRST ROW ONLY
);

--Query to find the customer who has made the most purchases:

SELECT Customer.Customer_Name, COUNT(*) AS Num_Purchases
FROM Orders
JOIN Customer ON Orders.Customer_ID = Customer.Customer_ID
GROUP BY Customer.Customer_Name
ORDER BY Num_Purchases DESC
FETCH FIRST ROW ONLY;


--Retrieve the details of all the products that are out of stock in a particular warehouse 3.
-- SELECT i.Product_Name, i.Prod_Type
-- FROM Inventory i
-- LEFT JOIN Located_in l ON i.Product_ID = l.Product_ID
-- WHERE l.Warehouse_ID = 3 AND (l.Quantity IS NULL OR l.Quantity = 0);

INSERT INTO Orders(Transaction_ID, Transaction_Date, Transaction_Time, Quantity_of_Sale, Selling_Price, Final_Cost, Method_Of_Payment, Order_Staus, Customer_ID, Warehouse_ID, Address_ID, Product_ID)
VALUES (6, TO_DATE('10-MAY-23', 'DD-MON-YY'), TO_DATE('15:30:00', 'HH24:MI:SS'), 5, 10.50, 52.50, 'UPI', 'Ordered', 'C005', 1, 1, 1);


INSERT INTO Inventory (Product_ID, Product_Name, Cost_Price, Prod_Type, Manufacture_Date, Expiry_Date)
VALUES (6, 'Dove Soap', 50.00, 'Soap', TO_DATE('2022-01-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));