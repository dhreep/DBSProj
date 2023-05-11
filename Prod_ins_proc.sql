-- -- Heres a stored procedure for updating the Inventory, Located_in, and Warehouse_Address tables as per your requirements. This procedure is written in PL/SQL for Oracle databases.

-- -- sql
-- CREATE OR REPLACE PROCEDURE update_inventory
-- IS
--   v_option NUMBER;
--   v_product_id NUMBER(5);
--   v_product_name VARCHAR2(30);
--   v_cost_price NUMERIC(6,2);
--   v_prod_type VARCHAR2(50);
--   v_manufacture_date DATE;
--   v_expiry_date DATE;
--   v_warehouse_id NUMBER(5);
--   v_quantity NUMBER(10);
--   v_warehouse_address VARCHAR2(50);
--   v_warehouse_pincode NUMBER;
-- BEGIN
--   LOOP
--     DBMS_OUTPUT.PUT_LINE('Menu>');
--     DBMS_OUTPUT.PUT_LINE('1. Insert new product into Inventory');
--     DBMS_OUTPUT.PUT_LINE('2. Exit');
--     DBMS_OUTPUT.PUT_LINE('Enter your option (1 or 2)> ');
--     v_option := &option;

--     EXIT WHEN v_option = 2;

--     IF v_option = 1 THEN
--       DBMS_OUTPUT.PUT_LINE('Enter Product ID> ');
--       v_product_id := &product_id;
--       DBMS_OUTPUT.PUT_LINE('Enter Product Name> ');
--       v_product_name := '&product_name';
--       DBMS_OUTPUT.PUT_LINE('Enter Cost Price> ');
--       v_cost_price := &cost_price;
--       DBMS_OUTPUT.PUT_LINE('Enter Product Type> ');
--       v_prod_type := '&prod_type';
--       DBMS_OUTPUT.PUT_LINE('Enter Manufacture Date (YYYY-MM-DD)> ');
--       v_manufacture_date := TO_DATE('&manufacture_date', 'YYYY-MM-DD');
--       DBMS_OUTPUT.PUT_LINE('Enter Expiry Date (YYYY-MM-DD)> ');
--       v_expiry_date := TO_DATE('&expiry_date', 'YYYY-MM-DD');

--       INSERT INTO Inventory (Product_ID, Product_Name, Cost_Price, Prod_Type, Manufacture_Date, Expiry_Date)
--       VALUES (v_product_id, v_product_name, v_cost_price, v_prod_type, v_manufacture_date, v_expiry_date);

--       DBMS_OUTPUT.PUT_LINE('Enter Warehouse ID> ');
--       v_warehouse_id := &warehouse_id;
--       DBMS_OUTPUT.PUT_LINE('Enter Quantity> ');
--       v_quantity := &quantity;

--       DECLARE
--         v_count NUMBER;
--       BEGIN
--         SELECT COUNT(*) INTO v_count FROM Warehouse_Address WHERE Warehouse_ID = v_warehouse_id;

--         IF v_count = 0 THEN
--           DBMS_OUTPUT.PUT_LINE('Enter Warehouse Address> ');
--           v_warehouse_address := '&warehouse_address';
--           DBMS_OUTPUT.PUT_LINE('Enter Warehouse Pincode> ');
--           v_warehouse_pincode := &warehouse_pincode;

--           INSERT INTO Warehouse_Address (Warehouse_ID, Warehouse_Address, Warehouse_PinCode)
--           VALUES (v_warehouse_id, v_warehouse_address, v_warehouse_pincode);
--         END IF;

--         SELECT COUNT(*) INTO v_count FROM Located_in WHERE Warehouse_ID = v_warehouse_id AND Product_ID = v_product_id;

--         IF v_count = 0 THEN
--           INSERT INTO Located_in (Quantity, Warehouse_ID, Product_ID)
--           VALUES (v_quantity, v_warehouse_id, v_product_id);
--         ELSE
--           UPDATE Located_in
--           SET Quantity = Quantity + v_quantity
--           WHERE Warehouse_ID = v_warehouse_id AND Product_ID = v_product_id;
--         END IF;
--       END;
--     END IF;
--   END LOOP;
-- END update_inventory;
-- /


-- -- To execute the procedure, run the following command>


-- -- EXEC update_inventory;


-- -- This procedure provides a menu-driven interface for inserting new products into the Inventory table. It prompts the user for the required information and updates the Located_in and Warehouse_Address tables accordingly. If the Warehouse_ID does not exist in the Warehouse_Address table, it creates a new entry in both the Warehouse_Address and Located_in tables. If the Warehouse_ID exists, it updates the Located_in table.

-- CREATE OR REPLACE PROCEDURE update_inventory AS
--   choice NUMBER;
--   product_id NUMBER(5);
--   product_name VARCHAR2(30);
--   cost_price NUMBER(6,2);
--   prod_type VARCHAR2(50);
--   manufacture_date DATE;
--   expiry_date DATE;
--   warehouse_id NUMBER(5);
--   quantity NUMBER(10);
--   warehouse_address VARCHAR2(50);
--   warehouse_pincode NUMBER;
-- BEGIN
--   LOOP
--     -- Display menu
--     DBMS_OUTPUT.PUT_LINE('1. Insert new product into inventory');
--     DBMS_OUTPUT.PUT_LINE('2. Update product quantity in warehouse');
--     DBMS_OUTPUT.PUT_LINE('3. Exit');
--     DBMS_OUTPUT.PUT_LINE('Enter choice> ');
--     -- Read user input
--     choice := TO_NUMBER(READ_LINE());
--     IF choice = 1 THEN
--       -- Read product details
--       DBMS_OUTPUT.PUT_LINE('Enter product ID> ');
--       product_id := TO_NUMBER(READ_LINE());
--       DBMS_OUTPUT.PUT_LINE('Enter product name> ');
--       product_name := READ_LINE();
--       DBMS_OUTPUT.PUT_LINE('Enter cost price> ');
--       cost_price := TO_NUMBER(READ_LINE());
--       DBMS_OUTPUT.PUT_LINE('Enter product type> ');
--       prod_type := READ_LINE();
--       DBMS_OUTPUT.PUT_LINE('Enter manufacture date (YYYY-MM-DD)> ');
--       manufacture_date := TO_DATE(READ_LINE(), 'YYYY-MM-DD');
--       DBMS_OUTPUT.PUT_LINE('Enter expiry date (YYYY-MM-DD)> ');
--       expiry_date := TO_DATE(READ_LINE(), 'YYYY-MM-DD');
--       -- Insert product into inventory
--       INSERT INTO Inventory (Product_ID, Product_Name, Cost_Price, Prod_Type, Manufacture_Date, Expiry_Date)
--       VALUES (product_id, product_name, cost_price, prod_type, manufacture_date, expiry_date);
--       -- Read warehouse ID and quantity
--       DBMS_OUTPUT.PUT_LINE('Enter warehouse ID> ');
--       warehouse_id := TO_NUMBER(READ_LINE());
--       DBMS_OUTPUT.PUT_LINE('Enter quantity> ');
--       quantity := TO_NUMBER(READ_LINE());
--       -- Check if warehouse exists
--       SELECT COUNT(*) INTO quantity FROM Warehouse_Address WHERE Warehouse_ID = warehouse_id;
--       IF quantity = 0 THEN
--         -- Read warehouse address and pincode
--         DBMS_OUTPUT.PUT_LINE('Enter warehouse address> ');
--         warehouse_address := READ_LINE();
--         DBMS_OUTPUT.PUT_LINE('Enter warehouse pincode> ');
--         warehouse_pincode := TO_NUMBER(READ_LINE());
--         -- Insert warehouse into Warehouse_Address
--         INSERT INTO Warehouse_Address (Warehouse_ID, Warehouse_Address, Warehouse_PinCode)
--         VALUES (warehouse_id, warehouse_address, warehouse_pincode);
--       END IF;
--       -- Insert product into Located_in
--       INSERT INTO Located_in (Quantity, Warehouse_ID, Product_ID)
--       VALUES (quantity, warehouse_id, product_id);
--     ELSIF choice = 2 THEN
--       -- Read product ID, warehouse ID, and quantity
--       DBMS_OUTPUT.PUT_LINE('Enter product ID> ');
--       product_id := TO_NUMBER(READ_LINE());
--       DBMS_OUTPUT.PUT_LINE('Enter warehouse ID> ');
--       warehouse_id := TO_NUMBER(READ_LINE());
--       DBMS_OUTPUT.PUT_LINE('Enter quantity> ');
--       quantity := TO_NUMBER(READ_LINE());
--       -- Check if Located_in entry exists
--       SELECT COUNT(*) INTO quantity FROM Located_in WHERE Warehouse_ID = warehouse_id AND Product_ID = product_id;
--       IF quantity = 0 THEN
--         -- Insert new Located_in entry
--         INSERT INTO Located_in (Quantity, Warehouse_ID, Product_ID)
--         VALUES (quantity, warehouse_id, product_id);
--       ELSE
--         -- Update Located_in entry
--         UPDATE Located_in SET Quantity = Quantity + quantity
--         WHERE Warehouse_ID = warehouse_id AND Product_ID = product_id;
--       END IF;
--     ELSIF choice = 3 THEN
--       -- Exit loop
--       EXIT;
--     ELSE
--       -- Invalid choice
--       DBMS_OUTPUT.PUT_LINE('Invalid choice');
--     END IF;
--   END LOOP;
-- END;
-- /
SET SERVEROUTPUT ON;
DECLARE
  v_choice NUMBER;
  v_product_id NUMBER(5);
  v_product_name VARCHAR2(30);
  v_cost_price NUMERIC(6,2);
  v_prod_type VARCHAR2(50);
  v_manufacture_date DATE;
  v_expiry_date DATE;
  v_warehouse_id NUMBER(5);
  v_quantity NUMBER(10);
  v_count NUMBER;
BEGIN
  LOOP
    DBMS_OUTPUT.PUT_LINE('Menu>');
    DBMS_OUTPUT.PUT_LINE('1. Insert new product');
    DBMS_OUTPUT.PUT_LINE('2. Exit');
    DBMS_OUTPUT.PUT_LINE('Enter your choice> ');
    ACCEPT v_choice NUMBER PROMPT 'Enter the table name >'

    EXIT WHEN v_choice = 2;

    IF v_choice = 1 THEN
      DBMS_OUTPUT.PUT_LINE('Enter Product ID> ');
      ACCEPT v_product_id NUMBER Prompt 'Enter product id >'
      DBMS_OUTPUT.PUT_LINE('Enter Product Name> ');
      ACCEPT v_product_name NUMBER Prompt 'Enter product name >'
      DBMS_OUTPUT.PUT_LINE('Enter Cost Price> ');
      ACCEPT v_cost_price NUMBER Prompt 'Enter cost price >'
      DBMS_OUTPUT.PUT_LINE('Enter Product Type> ');
      ACCEPT v_prod_type NUMBER Prompt 'Enter product type >'
      DBMS_OUTPUT.PUT_LINE('Enter Manufacture Date (YYYY-MM-DD)> ');
      ACCEPT v_manufacture_date date Prompt 'Enter manufacturing date >'
      DBMS_OUTPUT.PUT_LINE('Enter Expiry Date (YYYY-MM-DD)> ');
      ACCEPT v_expiry_date date Prompt 'Enter expiry date >'

      INSERT INTO Inventory VALUES (v_product_id, v_product_name, v_cost_price, v_prod_type, v_manufacture_date, v_expiry_date);

      DBMS_OUTPUT.PUT_LINE('Enter Warehouse ID> ');
      ACCEPT v_warehouse_id NUMBER Prompt 'Enter warehouse id >'
      DBMS_OUTPUT.PUT_LINE('Enter Quantity> ');
      ACCEPT v_quantity NUMBER Prompt 'Enter product quantity >'

      SELECT COUNT(*) INTO v_count FROM Warehouse_Address WHERE Warehouse_ID = v_warehouse_id;

      IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Enter Warehouse Address> ');
        INSERT INTO Warehouse_Address (Warehouse_ID, Warehouse_Address, Warehouse_PinCode) VALUES (v_warehouse_id, 'manipal', 210905);
      END IF;

      SELECT COUNT(*) INTO v_count FROM Located_in WHERE Warehouse_ID = v_warehouse_id AND Product_ID = v_product_id;

      IF v_count = 0 THEN
        INSERT INTO Located_in VALUES (v_quantity, v_warehouse_id, v_product_id);
      ELSE
        UPDATE Located_in SET Quantity = Quantity + v_quantity WHERE Warehouse_ID = v_warehouse_id AND Product_ID = v_product_id;
      END IF;

      COMMIT;
      DBMS_OUTPUT.PUT_LINE('Product inserted successfully.');
    END IF;
  END LOOP;
END;
/

