CREATE OR REPLACE TRIGGER Inventory_Warehouse_Address_trigger
INSTEAD OF INSERT ON Inventory_Warehouse_Address
FOR EACH ROW
DECLARE
v_Cust_ID NUMBER(5);
  v_Quantity NUMBER(10);
  v_Warehouse_ID NUMBER(5);
  v_wh_exist Number(10);
BEGIN
  SELECT count(Product_ID) INTO v_wh_exist FROM Inventory WHERE Product_ID = :new.Product_ID;
  IF v_wh_exist = 0 THEN
    INSERT INTO Inventory (Product_ID, Product_Name, Cost_Price, Prod_Type, Manufacture_Date, Expiry_Date)
    VALUES (:new.Product_ID, :new.Product_Name, :new.Cost_Price, :new.Prod_Type, :new.Manufacture_Date, :new.Expiry_Date);
  END IF;
--   SELECT Quantity, Warehouse_ID INTO v_Quantity, v_Warehouse_ID FROM Located_in WHERE Product_ID = :new.Product_ID;
  SELECT count(Warehouse_ID) INTO v_wh_exist FROM warehouse_address WHERE warehouse_id = :new.warehouse_id;
  IF v_wh_exist = 0 THEN
    INSERT INTO Warehouse_Address (Warehouse_ID, Warehouse_Address, Warehouse_PinCode)
    VALUES (:new.Warehouse_ID, :new.Warehouse_Address, :new.Warehouse_PinCode);
    v_Quantity := 0;
  ELSE
    SELECT Quantity INTO v_Quantity FROM Located_in WHERE Product_ID = :new.Product_ID;
  END IF;
  
  IF v_Quantity = 0 THEN
    INSERT INTO Located_in (Quantity, Warehouse_ID, Product_ID)
    VALUES (:new.Quantity, :new.Warehouse_ID, :new.Product_ID);
  ELSE
    UPDATE Located_in SET Quantity = Quantity + :new.Quantity WHERE Product_ID = :new.Product_ID;
  END IF;
END;
/