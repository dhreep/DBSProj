CREATE OR REPLACE TRIGGER cancel_order_trigger
BEFORE UPDATE OF Order_Staus ON Orders
FOR EACH ROW
BEGIN
  IF :OLD.Order_Staus = 'Fulfilled' AND :NEW.Order_Staus = 'Cancelled' THEN
  RAISE_APPLICATION_ERROR(-20001, 'Cannot cancel the order as its already been delivered.');
  END IF;
END;
/