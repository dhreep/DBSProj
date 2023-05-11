CREATE OR REPLACE TRIGGER update_customer_status
Before INSERT OR UPDATE ON Orders
FOR EACH ROW
DECLARE
  last_order_date DATE;
  three_months_ago DATE := add_months(sysdate, -3);
  CURSOR customer_cur IS SELECT * FROM Customer for update;
  customer_rec Customer%ROWTYPE;  
BEGIN
  -- Check if the customer exists in the Customer table
  SELECT MAX(Transaction_Date) INTO last_order_date
  FROM Orders
  WHERE Customer_ID = :NEW.Customer_ID;   
    -- Update the customer's date of last purchase
    UPDATE Customer
    SET Date_of_Last_Purchase = sysdate
    WHERE Customer_ID = :NEW.Customer_ID;
   OPEN customer_cur;
  LOOP
    FETCH customer_cur INTO customer_rec;
    EXIT WHEN customer_cur%NOTFOUND;
    IF customer_rec.Date_of_Last_Purchase >= three_months_ago THEN
      UPDATE Customer SET Customer_Status = 'Active'
      WHERE CURRENT OF customer_cur;
    ELSE
      UPDATE Customer SET Customer_Status = 'Inactive'
      WHERE CURRENT OF customer_cur;
    END IF;
  END LOOP;
  CLOSE customer_cur;
END;
/
