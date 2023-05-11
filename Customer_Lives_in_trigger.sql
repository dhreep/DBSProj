CREATE OR REPLACE TRIGGER Customer_Lives_in_trigger
INSTEAD OF INSERT ON Customer_Lives_in
FOR EACH ROW
DECLARE
  v_Customer_ID VARCHAR(30);
  v_Quantity NUMBER(10);
  v_Address_ID Number(5);
  v_wh_exist Number(10);
BEGIN
  SELECT count(Customer_ID) INTO v_wh_exist FROM Customer WHERE Customer_ID = :new.Customer_ID;
  IF v_wh_exist = 0 THEN
    INSERT INTO Customer (Customer_ID, Customer_Name, Date_of_Birth, Customer_Password, Date_of_Signup, Date_of_Last_Purchase, Customer_Status)
    VALUES (:new.Customer_ID, :new.Customer_Name, :new.Date_of_Birth, :new.Customer_Password, :new.Date_of_Signup, :new.Date_of_Last_Purchase, :new.Customer_Status);
  END IF;
--   SELECT Quantity, Warehouse_ID INTO v_Quantity, v_Warehouse_ID FROM Located_in WHERE Product_ID = :new.Product_ID;
  SELECT count(Address_ID) INTO v_wh_exist FROM Customer_Address WHERE Address_ID = :new.Address_ID;
  IF v_wh_exist = 0 THEN
    INSERT INTO Customer_Address (Address_ID, Customer_Address, Customer_Pincode) VALUES
    (:new.address_id, :new.Customer_Address, :new.Customer_Pincode);
    v_Quantity := 0;
  END IF;
  select count(Contact) into v_wh_exist FROM Lives_in where Address_ID = :new.Address_ID and Customer_ID = :new.Customer_ID;
  IF v_wh_exist = 0 THEN
    INSERT INTO Lives_in (Contact, Customer_ID, Address_ID) VALUES (:new.Contact, :new.Customer_ID,:new.Address_id);
  ELSE
    UPDATE Lives_in SET Contact = :new.Contact where Address_ID = :new.Address_ID and Customer_ID = :new.Customer_ID;
  END IF;
END;
/