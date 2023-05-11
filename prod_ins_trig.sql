CREATE OR REPLACE TRIGGER trgp_inventory_insert
AFTER INSERT ON Inventory
FOR EACH ROW
DECLARE

BEGIN
  insval(:new.Product_ID);
END;
/