#Задание №1
drop user if exists 'shop'@'localhost';
drop user if exists 'shop_read'@'localhost';
CREATE USER 'shop'@'localhost' IDENTIFIED WITH sha256_password BY 'pass';
CREATE USER 'shop_read'@'localhost' IDENTIFIED WITH sha256_password BY 'pass';

GRANT ALL ON shop.* TO 'shop'@'localhost';
GRANT SELECT  ON shop.* TO 'shop_read'@'localhost';




#Задание №2
use shop;
drop table if exists accounts;
CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  `password` VARCHAR(255)
) ;

INSERT INTO accounts
  (name, `password`)
VALUES
  ('alex', 'pass1'),
  ('john', 'pass2'),
  ('ivan', 'pass3');
 
 
drop view if exists accounts_view;
CREATE VIEW accounts_view AS 
	select *
		from accounts;
	
drop user if exists 'user_read'@'localhost';
CREATE USER 'user_read'@'localhost' IDENTIFIED WITH sha256_password BY 'pass';

GRANT select ON shop.accounts_view TO 'user_read'@'localhost';



 