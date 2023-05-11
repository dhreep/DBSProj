drop table Lives_in;
drop table Located_in;
drop table Orders;
Drop table Customer;
drop table Inventory;
drop table Customer_Address;
drop table Warehouse_Address;


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
  FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
  FOREIGN KEY (Address_ID) REFERENCES Customer_Address(Address_ID)
);

CREATE TABLE Located_in
(
  Quantity NUMBER(10) NOT NULL,
  Warehouse_ID NUMBER(5) NOT NULL,
  Product_ID NUMBER(5) NOT NULL,
  PRIMARY KEY (Warehouse_ID, Product_ID),
  FOREIGN KEY (Warehouse_ID) REFERENCES Warehouse_Address(Warehouse_ID),
  FOREIGN KEY (Product_ID) REFERENCES Inventory(Product_ID)
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
  FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
  FOREIGN KEY (Warehouse_ID) REFERENCES Warehouse_Address(Warehouse_ID),
  FOREIGN KEY (Address_ID) REFERENCES Customer_Address(Address_ID),
  FOREIGN KEY (Product_ID) REFERENCES Inventory(Product_ID),
  check(Method_Of_Payment in('UPI','COD','Debit Card','Credit Card','Net Banking') and Order_Staus in('Fulfilled','Ordered','Shipped','Cancelled'))
);