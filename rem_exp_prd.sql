CREATE OR REPLACE TRIGGER remove_expired_inventory
BEFORE INSERT ON Orders
FOR EACH ROW
BEGIN
  FOR i IN (SELECT * FROM Inventory)
  LOOP
    IF i.Expiry_Date < TRUNC(SYSDATE) THEN
       DELETE FROM Located_in WHERE Product_ID = i.Product_ID;
      DELETE FROM Inventory WHERE Product_ID = i.Product_ID;
   
    END IF;
  END LOOP;
END;
/