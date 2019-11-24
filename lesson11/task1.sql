#Задание1

use shop;
DROP TABLE IF exists logs;
CREATE TABLE logs (
	id SERIAL PRIMARY KEY,
    id_PK INT UNSIGNED,
	table_name VARCHAR(25),
	field_name VARCHAR(25),
    created_at DATETIME DEFAULT NOW()
);

drop trigger if exists tr_logs_write_users;
drop trigger if exists tr_logs_write_catalogs;
drop trigger if exists tr_logs_write_products;
delimiter //
CREATE TRIGGER tr_logs_write_users After insert ON users
FOR EACH ROW BEGIN
  INSERT INTO logs
	  (id_PK, table_name, field_name)
  VALUES
  	  (NEW.id, 'users', NEW.name);
END//

CREATE TRIGGER tr_logs_write_catalogs After insert ON catalogs
FOR EACH ROW BEGIN
  INSERT INTO logs
	  (id_PK, table_name, field_name)
  VALUES
  	  (NEW.id, 'catalogs', NEW.name);
END//

CREATE TRIGGER tr_logs_write_products After insert ON products
FOR EACH ROW BEGIN
  INSERT INTO logs
	  (id_PK, table_name, field_name)
  VALUES
  	  (NEW.id, 'products', NEW.name);
END//

delimiter ;

### Test

INSERT INTO users (name, birthday_at) VALUES
  ('Сергей', '1995-10-15');

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i7-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 8890.00, 1);

INSERT INTO catalogs VALUES
  (NULL, 'Блоки питания');


