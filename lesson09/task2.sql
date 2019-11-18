#������� �1
use shop;
drop procedure if exists hello;
delimiter //
CREATE PROCEDURE hello ()
begin
     set @a = HOUR(NOW());
     SELECT case 
		  when (0 <= @a) && (@a < 6) then '������ ����'	
		  when (6 <= @a) && (@a < 12) then '������ ����'	
		  when (12 <= @a) && (@a < 18) then '������ ����'
		  when (18 <= @a) && (@a < 24) then '������ �����'
	     end as hello;
end//
	
call hello();




#������� �2
use shop;
drop trigger if exists check_update_products;
delimiter //
CREATE TRIGGER check_update_products BEFORE UPDATE ON products
FOR EACH ROW BEGIN
  IF (NEW.name is null  and NEW.description is null or
      old.name is null and NEW.description is null or
      NEW.name is null and old.description is null) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Update canceled';
  END IF;
END//
delimiter ;

UPDATE products as p SET p.description="wd", p.name="wqd"
WHERE p.id=1;

drop trigger if exists check_insert_products;
delimiter //
CREATE TRIGGER check_insert_products BEFORE insert ON products
FOR EACH ROW BEGIN
  IF (NEW.name is null  and NEW.description is null) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert canceled';
  END IF;
END//

INSERT INTO products
  (price, catalog_id)
VALUES
  (7890.00, 1);
