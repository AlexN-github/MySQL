################################
#Задание1
sadd 192.168.0.1 user1
sadd 192.168.0.1 user2
sadd 192.168.0.2 user3
sadd 192.168.0.3 user4
sass 192.168.0.1 user4
sadd 192.168.0.1 user4
sadd 192.168.0.2 user2
smembers 192.168.0.1


################################
#Задание2
select 2
set user1 user1@mail.ru
set user2 user2@mail.ru
set user3 user3@mail.ru
set user4 user4@mail.ru
set user5 user5@mail.ru

#Получаем email пользователя
get user4

#Получаем hash таблицу
hset users:1 name "name1"
hset users:1 name "n1@n.ru"
hset users:2 name "name2"
hset users:2 name "n2@n.ru"
hset users:3 name "name3"
hset users:3 name "n3@n.ru"

hvals users:1
hkeys users:1


################################
#Задание3
db.shop.insert(
{ 
	"id":1,
	"name":"Intel Core i3-8100",
	"description":"Процессор для настольных персональных компьютеров, основанных на платформе Intel.",
	"price":7890,
	"catalog_id":1,
	"creates_at":"2019-11-24 10:00:00",
	"update_at":"2019-11-24 10:00:00"
})
db.shop.insert(
{ 
	"id":2,
	"name":"Intel Core i5-7400",
	"description":"Процессор для настольных персональных компьютеров, основанных на платформе Intel.",
	"price":12700,
	"catalog_id":1,
	"creates_at":"2019-11-24 10:00:00",
	"update_at":"2019-11-24 10:00:00"
})
db.shop.insert(
{ 
	"id":3,
	"name":"Gigabyte H310M S2H",
	"description":"Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX",
	"price":4790,
	"catalog_id":2,
	"creates_at":"2019-11-24 10:00:00",
	"update_at":"2019-11-24 10:00:00"
})

db.shop.insert(
{ 
	"id":1,
	"name":"Процессоры"
})
db.shop.insert(
{ 
	"id":2,
	"name":"Материнские платы"
})
