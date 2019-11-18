#Задание№1
START TRANSACTION;
INSERT INTO sample.users (name, birthday_at, created_at, updated_at)
	select u.name, u.birthday_at, u.created_at, u.updated_at 
		from shop.users as u
		where u.id =1;
COMMIT;

#Задание№2
use shop;
drop view if exists prod_view;
CREATE VIEW prod_view AS 
	select p.name as prod_name, c.name as cat_name
		from products as p, catalogs as c
		where p.catalog_id = c.id;

#Задание№3
use shop;
drop table if exists tb_create_at;
CREATE TABLE tb_create_at (
  id SERIAL PRIMARY KEY,
  created_at DATETIME
);
INSERT INTO tb_create_at (created_at) VALUES
  ('2018-08-01'),
  ('2018-08-04'),
  ('2018-08-16'),
  ('2018-08-17'),
  ('2018-08-19'),
  ('2018-08-21'),
  ('2018-08-22');
 
SELECT `x`.sequence_date, IF(`x`.sequence_date in (select created_at from tb_create_at),1,0) as `flag`
  FROM (SELECT DATE_ADD('2018-08-01', INTERVAL `n`.`id` - 1 day) as sequence_date
          FROM (SELECT  @N := @N +1 AS id 
					FROM mysql.help_relation , (SELECT @N:=0) dum LIMIT 31) `n`
  WHERE DATE_ADD('2018-01-01', INTERVAL `n`.`id` -1 DAY) <= '2018-12-30' ) x;
       
#Задание№4
use shop;
select created_at
into @search_date
from (select * 
		from tb_create_at as t1
		order by t1.created_at desc		
		limit 5) as t2
order by t2.created_at
limit 1;
delete from tb_create_at as tb
	where tb.created_at < @search_date;
	

 
         