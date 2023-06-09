--Customer_Lives_In
@"C:\Users\Dhruv Bajaj\Desktop\DBSMainPROJ\DBSPROJ\Customer_Lives_in_trigger.sql"
select * from Lives_in;
select * from customer;
select * from customer_address;
select * from Customer_Lives_In;
commit;
INSERT INTO Customer_Lives_in (Customer_ID, Customer_Name, Date_of_Birth, Customer_Password, Date_of_Signup, Date_of_Last_Purchase, Customer_Status, Contact, Address_ID, Customer_Address, Customer_Pincode)
VALUES ('C021', 'Johan Doe', TO_DATE('1980-01-01', 'YYYY-MM-DD'), 'password123', TO_DATE('2022-01-01', 'YYYY-MM-DD'), TO_DATE('2022-05-01', 'YYYY-MM-DD'), 'Active', '9876543210', '1', '123 Main Street', '123456');
select * from Lives_in;
select * from customer;
select * from customer_address;
rollback;



--Inventory_Warehouse_Address
@"C:\Users\Dhruv Bajaj\Desktop\DBSMainPROJ\DBSPROJ\Inventory_Warehouse_Address_trigger.sql"
commit;
select * from Inventory;
select * from Located_in;
select * from Warehouse_Address;
select * from Inventory_Warehouse_Address;
INSERT INTO Inventory_Warehouse_Address (Product_ID, Product_Name, Cost_Price, Prod_Type, Manufacture_Date, Expiry_Date, Quantity, Warehouse_ID, Warehouse_Address, Warehouse_PinCode)
VALUES (12345, 'Lux', 50.00, 'Soap', TO_DATE('2022-04-01', 'YYYY-MM-DD'), TO_DATE('2022-06-30', 'YYYY-MM-DD'), 100, 10001, '123 Main Street', 12345);
select * from Inventory;
select * from Located_in;
select * from Warehouse_Address;
select * from Inventory_Warehouse_Address;
rollback;



--Warehouse Quantity Update
@"C:\Users\Dhruv Bajaj\Desktop\DBSMainPROJ\DBSPROJ\OrderQuantityUpdate.sql"
commit;
select * from located_in;
INSERT INTO Orders (Transaction_ID, Transaction_Date, Transaction_Time, Quantity_of_Sale, Selling_Price, Final_Cost, Method_Of_Payment, Order_Staus, Customer_ID, Warehouse_ID, Address_ID, Product_ID)
VALUES (6, TO_DATE('2023-05-06', 'YYYY-MM-DD'), TO_DATE('14:00:00', 'HH24:MI:SS'), 5, 15.00, 15.00, 'COD', 'Cancelled', 'C005', 5, 2, 5);
select * from located_in;
rollback;



--Order Cancellation Trigger
@"C:\Users\Dhruv Bajaj\Desktop\DBSMainPROJ\DBSPROJ\Cancelled_Order_Trig.sql"
commit;
select * from orders;
UPDATE Orders SET Order_Staus = 'Cancelled' WHERE Transaction_ID = 4;
UPDATE Orders SET Order_Staus = 'Cancelled' WHERE Transaction_ID = 3;
select * from orders;
rollback;



--Customer Status Update
@"C:\Users\Dhruv Bajaj\Desktop\DBSMainPROJ\DBSPROJ\CustomerStatusUpdate.sql"
commit;
select * from customer;
INSERT INTO Orders (Transaction_ID, Transaction_Date, Transaction_Time, Quantity_of_Sale, Selling_Price, Final_Cost, Method_Of_Payment, Order_Staus, Customer_ID, Warehouse_ID, Address_ID, Product_ID)
VALUES (6, TO_DATE('2023-05-06', 'YYYY-MM-DD'), TO_DATE('14:00:00', 'HH24:MI:SS'), 5, 15.00, 15.00, 'COD', 'Cancelled', 'C005', 5, 2, 5);
select * from customer;
rollback;



--Expired Inventory Removal
@"C:\Users\Dhruv Bajaj\Desktop\DBSMainPROJ\DBSPROJ\rem_exp_prd.sql"
commit;
select * from Inventory;
INSERT INTO Orders (Transaction_ID, Transaction_Date, Transaction_Time, Quantity_of_Sale, Selling_Price, Final_Cost, Method_Of_Payment, Order_Staus, Customer_ID, Warehouse_ID, Address_ID, Product_ID)
VALUES (8, TO_DATE('2023-05-06', 'YYYY-MM-DD'), TO_DATE('14:00:00', 'HH24:MI:SS'), 5, 15.00, 15.00, 'COD', 'Cancelled', 'C005', 5, 2, 2);
select * from Inventory;
rollback;