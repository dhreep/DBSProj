

--Retrieve the details of all the products that are out of stock in a particular warehouse 3.
-- SELECT i.Product_Name, i.Prod_Type
-- FROM Inventory i
-- LEFT JOIN Located_in l ON i.Product_ID = l.Product_ID
-- WHERE l.Warehouse_ID = 3 AND (l.Quantity IS NULL OR l.Quantity = 0);

INSERT INTO Orders(Transaction_ID, Transaction_Date, Transaction_Time, Quantity_of_Sale, Selling_Price, Final_Cost, Method_Of_Payment, Order_Staus, Customer_ID, Warehouse_ID, Address_ID, Product_ID)
VALUES (6, TO_DATE('10-MAY-23', 'DD-MON-YY'), TO_DATE('15:30:00', 'HH24:MI:SS'), 5, 10.50, 52.50, 'UPI', 'Ordered', 'C005', 1, 1, 1);


INSERT INTO Inventory (Product_ID, Product_Name, Cost_Price, Prod_Type, Manufacture_Date, Expiry_Date)
VALUES (6, 'Dove Soap', 50.00, 'Soap', TO_DATE('2022-01-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));

INSERT INTO Orders (Transaction_ID, Transaction_Date, Transaction_Time, Quantity_of_Sale, Selling_Price, Final_Cost, Method_Of_Payment, Order_Staus, Customer_ID, Warehouse_ID, Address_ID, Product_ID)
VALUES (6, TO_DATE('2023-05-06', 'YYYY-MM-DD'), TO_DATE('14:00:00', 'HH24:MI:SS'), 5, 15.00, 15.00, 'COD', 'Cancelled', 'C005', 5, 2, 5);


--Inventory_Warehouse_Address
CREATE VIEW Inventory_Warehouse_Address AS
SELECT i.Product_ID, i.Product_Name, i.Cost_Price, i.Prod_Type, i.Manufacture_Date, i.Expiry_Date,
       l.Quantity, w.Warehouse_ID, w.Warehouse_Address, w.Warehouse_PinCode
FROM Inventory i
JOIN Located_in l ON i.Product_ID = l.Product_ID
JOIN Warehouse_Address w ON l.Warehouse_ID = w.Warehouse_ID;

--Demo Query
INSERT INTO Inventory_Warehouse_Address (Product_ID, Product_Name, Cost_Price, Prod_Type, Manufacture_Date, Expiry_Date, Quantity, Warehouse_ID, Warehouse_Address, Warehouse_PinCode)
VALUES (12345, 'Lux', 50.00, 'Soap', TO_DATE('2022-04-01', 'YYYY-MM-DD'), TO_DATE('2022-06-30', 'YYYY-MM-DD'), 100, 10001, '123 Main Street', 12345);


--Customer_Lives_in
CREATE VIEW Customer_Lives_in AS
SELECT c.Customer_ID AS customer_id, c.Customer_Name AS customer_name, c.Date_of_Birth AS date_of_birth, c.Customer_Password AS customer_password, c.Date_of_Signup AS date_of_signup, c.Date_of_Last_Purchase AS date_of_last_purchase, c.Customer_Status AS customer_status,
       la.Address_ID AS address_id, la.Customer_Address AS customer_address, la.Customer_Pincode AS customer_pincode,
       li.Contact AS contact
FROM Customer c
JOIN Lives_in li ON c.Customer_ID = li.Customer_ID
JOIN Customer_Address la ON li.Address_ID = la.Address_ID;

--Demo Query
INSERT INTO Customer_Lives_in (Customer_ID, Customer_Name, Date_of_Birth, Customer_Password, Date_of_Signup, Date_of_Last_Purchase, Customer_Status, Contact, Address_ID, Customer_Address, Customer_Pincode)
VALUES ('C021', 'Johan Doe', TO_DATE('1980-01-01', 'YYYY-MM-DD'), 'password123', TO_DATE('2022-01-01', 'YYYY-MM-DD'), TO_DATE('2022-05-01', 'YYYY-MM-DD'), 'Active', '9876543210', '1', '123 Main Street', '123456');




