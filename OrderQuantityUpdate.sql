CREATE OR REPLACE TRIGGER update_warehouse_qty
Before INSERT ON orders
FOR EACH ROW
BEGIN
  UPDATE located_in
  SET quantity = quantity - :new.quantity_of_sale
  WHERE warehouse_id = :new.warehouse_id
  AND product_id = :new.product_id;
END;
/
