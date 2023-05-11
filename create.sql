drop table Lives_in;
drop table Located_in;
drop table Orders;
Drop table Customer;
drop table Inventory;
drop table Customer_Address;
drop table Warehouse_Address;
drop view Customer_Lives_in;
drop view Inventory_Warehouse_Address;


CREATE TABLE Customer
(
  Customer_ID VARCHAR(30) NOT NULL,--Username is Customer_ID
  Customer_Name VARCHAR(30) NOT NULL,
  Date_of_Birth DATE NOT NULL,
  Customer_Password VARCHAR(30) NOT NULL,
  Date_of_Signup DATE NOT NULL,
  Date_of_Last_Purchase DATE NOT NULL,
  Customer_Status VARCHAR(30) NOT NULL,
  check (Customer_Status in ('Active','Inactive')),
  PRIMARY KEY (Customer_ID)
);

CREATE TABLE Inventory
(
  Product_ID NUMBER(5) NOT NULL,
  Product_Name VARCHAR(30) NOT NULL,--Dove
  Cost_Price NUMERIC(6,2) NOT NULL,
  Prod_Type VARCHAR(50) NOT NULL,--Soap
  Manufacture_Date DATE NOT NULL,
  Expiry_Date DATE NOT NULL,
  PRIMARY KEY (Product_ID)
);

CREATE TABLE Customer_Address
(
  Address_ID Number(5) NOT NULL,
  Customer_Address VARCHAR(50) NOT NULL,
  Customer_Pincode NUMBER(6) NOT NULL,
  PRIMARY KEY (Address_ID)
);

CREATE TABLE Warehouse_Address
(
  Warehouse_ID NUMBER(5) NOT NULL,
  Warehouse_Address VARCHAR(50) NOT NULL,
  Warehouse_PinCode NUMBER NOT NULL,
  PRIMARY KEY (Warehouse_ID)
);

CREATE TABLE Lives_in
(
  Contact NUMBER(10) NOT NULL,
  Customer_ID VARCHAR(30) NOT NULL,
  Address_ID Number(5) NOT NULL,
  PRIMARY KEY (Customer_ID, Address_ID),
  FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) ON DELETE CASCADE,
  FOREIGN KEY (Address_ID) REFERENCES Customer_Address(Address_ID) ON DELETE CASCADE
);

CREATE TABLE Located_in
(
  Quantity NUMBER(10) NOT NULL,
  Warehouse_ID NUMBER(5) NOT NULL,
  Product_ID NUMBER(5) NOT NULL,
  PRIMARY KEY (Warehouse_ID, Product_ID),
  FOREIGN KEY (Warehouse_ID) REFERENCES Warehouse_Address(Warehouse_ID) ON DELETE CASCADE,
  FOREIGN KEY (Product_ID) REFERENCES Inventory(Product_ID) ON DELETE CASCADE
);

CREATE TABLE Orders
(
  Transaction_ID NUMBER(10) NOT NULL,
  Transaction_Date DATE NOT NULL,
  Transaction_Time DATE NOT NULL,
  Quantity_of_Sale NUMBER(5) NOT NULL,
  Selling_Price NUMERIC(6,2) NOT NULL,
  Final_Cost NUMERIC(6,2) NOT NULL,
  Method_Of_Payment VARCHAR(25) NOT NULL,
  Order_Staus VARCHAR(25) NOT NULL,
  Customer_ID VARCHAR(30) NOT NULL,
  Warehouse_ID NUMBER NOT NULL,
  Address_ID Number(5) NOT NULL,
  Product_ID NUMBER NOT NULL,
  PRIMARY KEY (Transaction_ID),
  FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) ON DELETE CASCADE,
  FOREIGN KEY (Warehouse_ID) REFERENCES Warehouse_Address(Warehouse_ID) ON DELETE CASCADE,
  FOREIGN KEY (Address_ID) REFERENCES Customer_Address(Address_ID) ON DELETE CASCADE,
  FOREIGN KEY (Product_ID) REFERENCES Inventory(Product_ID) ON DELETE CASCADE,
  check(Method_Of_Payment in('UPI','COD','Debit Card','Credit Card','Net Banking') and Order_Staus in('Fulfilled','Ordered','Shipped','Cancelled'))
);



--Customer
INSERT INTO Customer(Customer_ID, Customer_Name, Date_of_Birth, Customer_Password, Date_of_Signup, Date_of_Last_Purchase, Customer_Status)
VALUES ('C001', 'John Doe', TO_DATE('15-JUN-90', 'DD-MON-YY'), 'johndoe123', TO_DATE('01-JAN-21', 'DD-MON-YY'), TO_DATE('01-APR-23', 'DD-MON-YY'), 'Active');

INSERT INTO Customer(Customer_ID, Customer_Name, Date_of_Birth, Customer_Password, Date_of_Signup, Date_of_Last_Purchase, Customer_Status)
VALUES ('C002', 'Jane Smith', TO_DATE('22-SEP-95', 'DD-MON-YY'), 'janesmith456', TO_DATE('15-FEB-21', 'DD-MON-YY'), TO_DATE('01-MAY-23', 'DD-MON-YY'), 'Active');

INSERT INTO Customer(Customer_ID, Customer_Name, Date_of_Birth, Customer_Password, Date_of_Signup, Date_of_Last_Purchase, Customer_Status)
VALUES ('C003', 'Tom Wilson', TO_DATE('08-APR-87', 'DD-MON-YY'), 'tomwilson789', TO_DATE('31-DEC-20', 'DD-MON-YY'), TO_DATE('15-MAR-23', 'DD-MON-YY'), 'Inactive');

INSERT INTO Customer(Customer_ID, Customer_Name, Date_of_Birth, Customer_Password, Date_of_Signup, Date_of_Last_Purchase, Customer_Status)
VALUES ('C004', 'Emily Davis', TO_DATE('17-NOV-98', 'DD-MON-YY'), 'emilydavis101', TO_DATE('22-MAR-21', 'DD-MON-YY'), TO_DATE('30-APR-23', 'DD-MON-YY'), 'Active');

INSERT INTO Customer(Customer_ID, Customer_Name, Date_of_Birth, Customer_Password, Date_of_Signup, Date_of_Last_Purchase, Customer_Status)
VALUES ('C005', 'David Lee', TO_DATE('10-AUG-92', 'DD-MON-YY'), 'davidlee222', TO_DATE('10-JAN-21', 'DD-MON-YY'), TO_DATE('05-MAY-23', 'DD-MON-YY'), 'Inactive');


--Inventory
INSERT INTO Inventory (Product_ID, Product_Name, Cost_Price, Prod_Type, Manufacture_Date, Expiry_Date)
VALUES (1, 'Dove Soap', 50.00, 'Soap', TO_DATE('2022-01-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));

INSERT INTO Inventory (Product_ID, Product_Name, Cost_Price, Prod_Type, Manufacture_Date, Expiry_Date)
VALUES (2, 'Colgate Toothpaste', 25.00, 'Toothpaste', TO_DATE('2022-01-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));

INSERT INTO Inventory (Product_ID, Product_Name, Cost_Price, Prod_Type, Manufacture_Date, Expiry_Date)
VALUES (3, 'Maggi Noodles', 20.00, 'Noodles', TO_DATE('2022-01-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));

INSERT INTO Inventory (Product_ID, Product_Name, Cost_Price, Prod_Type, Manufacture_Date, Expiry_Date)
VALUES (4, 'Tata Tea', 10.00, 'Tea', TO_DATE('2022-01-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));

INSERT INTO Inventory (Product_ID, Product_Name, Cost_Price, Prod_Type, Manufacture_Date, Expiry_Date)
VALUES (5, 'Lays Chips', 15.00, 'Chips', TO_DATE('2022-01-01', 'YYYY-MM-DD'), TO_DATE('2022-12-31', 'YYYY-MM-DD'));

--Customer_Address
INSERT INTO Customer_Address (Address_ID, Customer_Address, Customer_Pincode)
VALUES (1, '123 Main St', 560001);

INSERT INTO Customer_Address (Address_ID, Customer_Address, Customer_Pincode)
VALUES (2, '456 Park Ave', 560002);

INSERT INTO Customer_Address (Address_ID, Customer_Address, Customer_Pincode)
VALUES (3, '789 Broadway', 560003);

INSERT INTO Customer_Address (Address_ID, Customer_Address, Customer_Pincode)
VALUES (4, '111 State St', 560004);

INSERT INTO Customer_Address (Address_ID, Customer_Address, Customer_Pincode)
VALUES (5, '222 Market St', 560005);


--Warehouse_Address
INSERT INTO Warehouse_Address (Warehouse_ID, Warehouse_Address, Warehouse_PinCode)
VALUES (1, '10th Cross Road', 560001);

INSERT INTO Warehouse_Address (Warehouse_ID, Warehouse_Address, Warehouse_PinCode)
VALUES (2, '5th Main Road', 560002);

INSERT INTO Warehouse_Address (Warehouse_ID, Warehouse_Address, Warehouse_PinCode)
VALUES (3, '3rd Block', 560003);

INSERT INTO Warehouse_Address (Warehouse_ID, Warehouse_Address, Warehouse_PinCode)
VALUES (4, '1st Avenue', 560004);

INSERT INTO Warehouse_Address (Warehouse_ID, Warehouse_Address, Warehouse_PinCode)
VALUES (5, '7th Street', 560005); 


--Lives_in
INSERT INTO Lives_in (Contact, Customer_ID, Address_ID) VALUES (1234567890, 'C001', 1);

INSERT INTO Lives_in (Contact, Customer_ID, Address_ID) VALUES (2345678901, 'C002', 2);

INSERT INTO Lives_in (Contact, Customer_ID, Address_ID) VALUES (3456789012, 'C003', 3);

INSERT INTO Lives_in (Contact, Customer_ID, Address_ID) VALUES (4567890123, 'C004', 4);

INSERT INTO Lives_in (Contact, Customer_ID, Address_ID) VALUES (5678901234, 'C005', 5);


--Located_in
INSERT INTO Located_in (Quantity, Warehouse_ID, Product_ID) VALUES (100, 1, 1);

INSERT INTO Located_in (Quantity, Warehouse_ID, Product_ID) VALUES (200, 2, 2);

INSERT INTO Located_in (Quantity, Warehouse_ID, Product_ID) VALUES (150, 3, 3);

INSERT INTO Located_in (Quantity, Warehouse_ID, Product_ID) VALUES (50, 4, 4);

INSERT INTO Located_in (Quantity, Warehouse_ID, Product_ID) VALUES (75, 5, 5);


--Orders
INSERT INTO Orders (Transaction_ID, Transaction_Date, Transaction_Time, Quantity_of_Sale, Selling_Price, Final_Cost, Method_Of_Payment, Order_Staus, Customer_ID, Warehouse_ID, Address_ID, Product_ID)
VALUES (1, TO_DATE('2023-05-10', 'YYYY-MM-DD'), TO_DATE('12:00:00', 'HH24:MI:SS'), 3, 50.00, 150.00, 'Debit Card', 'Ordered', 'C003', 1, 1, 1);

INSERT INTO Orders (Transaction_ID, Transaction_Date, Transaction_Time, Quantity_of_Sale, Selling_Price, Final_Cost, Method_Of_Payment, Order_Staus, Customer_ID, Warehouse_ID, Address_ID, Product_ID)
VALUES (2, TO_DATE('2023-05-09', 'YYYY-MM-DD'), TO_DATE('11:00:00', 'HH24:MI:SS'), 1, 25.00, 25.00, 'COD', 'Fulfilled', 'C004', 2, 3, 2);

INSERT INTO Orders (Transaction_ID, Transaction_Date, Transaction_Time, Quantity_of_Sale, Selling_Price, Final_Cost, Method_Of_Payment, Order_Staus, Customer_ID, Warehouse_ID, Address_ID, Product_ID)
VALUES (3, TO_DATE('2023-05-08', 'YYYY-MM-DD'), TO_DATE('10:00:00', 'HH24:MI:SS'), 5, 30.00, 150.00, 'Credit Card', 'Shipped', 'C003', 3, 5, 3);

INSERT INTO Orders (Transaction_ID, Transaction_Date, Transaction_Time, Quantity_of_Sale, Selling_Price, Final_Cost, Method_Of_Payment, Order_Staus, Customer_ID, Warehouse_ID, Address_ID, Product_ID)
VALUES (4, TO_DATE('2023-05-07', 'YYYY-MM-DD'), TO_DATE('15:00:00', 'HH24:MI:SS'), 2, 20.00, 40.00, 'Net Banking', 'Fulfilled', 'C001', 4, 4, 4);

INSERT INTO Orders (Transaction_ID, Transaction_Date, Transaction_Time, Quantity_of_Sale, Selling_Price, Final_Cost, Method_Of_Payment, Order_Staus, Customer_ID, Warehouse_ID, Address_ID, Product_ID)
VALUES (5, TO_DATE('2023-05-06', 'YYYY-MM-DD'), TO_DATE('14:00:00', 'HH24:MI:SS'), 1, 15.00, 15.00, 'COD', 'Cancelled', 'C002', 5, 2, 5);


Select * from Customer;
Select * from Inventory;
Select * from Customer_Address;
Select * from Warehouse_Address;
Select * from Lives_in;
Select * from Located_in;
Select * from Orders;


CREATE VIEW Inventory_Warehouse_Address AS
SELECT i.Product_ID, i.Product_Name, i.Cost_Price, i.Prod_Type, i.Manufacture_Date, i.Expiry_Date,
       l.Quantity, w.Warehouse_ID, w.Warehouse_Address, w.Warehouse_PinCode
FROM Inventory i
JOIN Located_in l ON i.Product_ID = l.Product_ID
JOIN Warehouse_Address w ON l.Warehouse_ID = w.Warehouse_ID;

Select * from Inventory_Warehouse_Address;

CREATE VIEW Customer_Lives_in AS
SELECT c.Customer_ID AS customer_id, c.Customer_Name AS customer_name, c.Date_of_Birth AS date_of_birth, c.Customer_Password AS customer_password, c.Date_of_Signup AS date_of_signup, c.Date_of_Last_Purchase AS date_of_last_purchase, c.Customer_Status AS customer_status,
       la.Address_ID AS address_id, la.Customer_Address AS customer_address, la.Customer_Pincode AS customer_pincode,
       li.Contact AS contact
FROM Customer c
JOIN Lives_in li ON c.Customer_ID = li.Customer_ID
JOIN Customer_Address la ON li.Address_ID = la.Address_ID;

Select * from Customer_Lives_in;
