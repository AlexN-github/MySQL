#Задание №1
use shop;
drop procedure if exists hello;
delimiter //
CREATE PROCEDURE hello ()
begin
     set @a = HOUR(NOW());
     SELECT case 
		  when (0 <= @a) && (@a < 6) then 'Доброй ночи'	
		  when (6 <= @a) && (@a < 12) then 'Доброе утро'	
		  when (12 <= @a) && (@a < 18) then 'Добрый день'
		  when (18 <= @a) && (@a < 24) then 'Добрый вечер'
	     end as hello;
end//
	
call hello();






#Задание №2
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




#Задание №2
use shop;
drop procedure if exists fib;
delimiter //
CREATE PROCEDURE fib(n INT)
begin
  DECLARE m INT default 0;
  DECLARE k INT DEFAULT 1;
  DECLARE i INT;
  DECLARE tmp INT;

  SET m=0;
  SET k=1;
  SET i=1;

  WHILE (i<=n) DO
    SET tmp=m+k;
    SET m=k;
    SET k=tmp;
    SET i=i+1;
  END WHILE;
  select m;
 end//
 
 call fib(10)
