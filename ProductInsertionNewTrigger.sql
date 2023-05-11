CREATE OR REPLACE TRIGGER trg_inventory_insert
AFTER INSERT ON Inventory
FOR EACH ROW
DECLARE
  warehouse_id_input Warehouse_Address.Warehouse_ID%TYPE;
  quantity_input Located_in.Quantity%TYPE;
  is_warehouse_exists NUMBER;
  warehouse_address_input Warehouse_Address.Warehouse_Address%TYPE;
  warehouse_pincode_input Warehouse_Address.Warehouse_PinCode%TYPE;
BEGIN
  -- Prompt the user for warehouse id and quantity
  ACCEPT warehouse_id_input Prompt 'Enter warehouse ID';
  ACCEPT quantity_input Prompt 'Enter Quantity';
  
  -- Check if warehouse exists
  SELECT COUNT(*) INTO is_warehouse_exists FROM Warehouse_Address WHERE Warehouse_ID = warehouse_id_input;
  
  IF is_warehouse_exists = 1 THEN
    INSERT INTO Located_in VALUES (quantity_input, warehouse_id_input, :new.Product_ID);
    -- Update located_in table with quantity
    UPDATE Located_in
    SET Quantity = Quantity + quantity_input
    WHERE Warehouse_ID = warehouse_id_input AND Product_ID = :new.Product_ID;
  ELSE
    -- Insert into Warehouse_Address and Located_in table
    INSERT INTO Warehouse_Address VALUES (warehouse_id_input, warehouse_address_input, warehouse_pincode_input);
    
    INSERT INTO Located_in VALUES (quantity_input, warehouse_id_input, :new.Product_ID);
  END IF;
END;
/
