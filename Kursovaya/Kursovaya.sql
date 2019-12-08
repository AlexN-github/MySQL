#Создаем базу КИНОПОИСК
#Создаем таблицы:
#1.ЖАНРЫ
#2.СТРАНЫ
#2.ГОРОДА
#3.ФИЛЬМЫ
#4.АКТЕРЫ
#5.ПРОДЮССЕРЫ
#6.ФИЛЬМОГРАФИЯ ПРОДЮССЕРОВ
#7.ФИЛЬМОГРАФИЯ АКТЕРОВ
#8.ПОЛЬЗОВАТЕЛИ
#9.РЕЙТИНГИ
#10.ИЗБРАННЫЕ ФИЛЬМЫ ПОЛЬЗОВАТЕЛЯ
#11.РЕЦЕНЗИИ
#12.ТРЕЙЛЕРЫ
#13.КИНОТЕАТРЫ
#14.ПРОКАТЫ ФИЛЬМОВ

drop database if exists kinopoisk;
create database kinopoisk;

use kinopoisk;
DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название страны'
) COMMENT = 'Страны';
DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название города',
  country_id BIGINT unsigned,
  INDEX (country_id) COMMENT 'Индекс для связи таблицей countries',
  FOREIGN KEY (country_id) REFERENCES countries(id) on delete cascade on update cascade
) COMMENT = 'Города';

DROP TABLE IF EXISTS genre;
CREATE TABLE genre (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) COMMENT 'Название жанра'
) COMMENT = 'Жанры фильмов';

DROP TABLE IF EXISTS films;
CREATE TABLE films (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название фильма',
  created_at DATETIME COMMENT 'Дата выпуска',
  rental_date DATETIME COMMENT 'Дата проката',
  country_id BIGINT UNSIGNED NOT NULL,
  genre_id BIGINT UNSIGNED NOT NULL,
  cost BIGINT UNSIGNED NOT NULL,
  INDEX (country_id) COMMENT 'Индекс для связи таблицей countries',
  INDEX (genre_id) COMMENT 'Индекс для связи таблицей жанры',
  FOREIGN KEY (country_id) REFERENCES countries(id) on delete cascade on update cascade,
  FOREIGN KEY (genre_id) REFERENCES genre(id) on delete cascade on update cascade
) COMMENT = 'Фильмы';

DROP TABLE IF EXISTS actors;
CREATE TABLE actors (
  id SERIAL PRIMARY KEY,
  firstname VARCHAR(50) COMMENT 'Имя',
  lastname VARCHAR(50) COMMENT 'Фамилия',
  birthday_at DATE COMMENT 'Дата рождения',
  country_id BIGINT UNSIGNED  COMMENT 'Родился в стране',
  INDEX (country_id) COMMENT 'Индекс для связи таблицей countries',
  FOREIGN KEY (country_id) REFERENCES countries(id) on delete cascade on update cascade
) COMMENT = 'Актеры';

DROP TABLE IF EXISTS producers;
CREATE TABLE producers (
  id SERIAL PRIMARY KEY,
  firstname VARCHAR(50) COMMENT 'Имя',
  lastname VARCHAR(50) COMMENT 'Фамилия',
  birthday_at DATE COMMENT 'Дата рождения',
  country_id BIGINT UNSIGNED  COMMENT 'Родился в стране',
  INDEX (country_id) COMMENT 'Индекс для связи таблицей countries',
  FOREIGN KEY (country_id) REFERENCES countries(id) on delete cascade on update cascade
) COMMENT = 'Режиссеры';

DROP TABLE IF EXISTS producer_filmography;
CREATE TABLE producer_filmography (
#  id SERIAL PRIMARY KEY,
  film_id BIGINT UNSIGNED NOT NULL,
  prod_id BIGINT UNSIGNED NOT NULL,
#  INDEX index_of_film_id (film_id) COMMENT 'Индекс для связи таблиwей films',
#  INDEX index_of_prod_id (prod_id) COMMENT 'Индекс для связи таблицей actors',
  INDEX (film_id) COMMENT 'Индекс для связи таблиwей films',
  INDEX (prod_id) COMMENT 'Индекс для связи таблицей actors',
  primary key (film_id, prod_id),
  FOREIGN KEY (film_id) REFERENCES films(id) on delete cascade on update cascade,
  FOREIGN KEY (prod_id) REFERENCES producers(id) on delete cascade on update cascade
) COMMENT = 'Фильмография режиссеров';

DROP TABLE IF EXISTS actor_filmography;
CREATE TABLE actor_filmography (
#  id SERIAL PRIMARY KEY,
  film_id BIGINT UNSIGNED NOT NULL,
  actor_id BIGINT UNSIGNED NOT NULL,
  index (film_id) COMMENT 'Индекс для связи таблиwей films',
  index (actor_id) COMMENT 'Индекс для связи таблицей actors',
  primary key (film_id, actor_id),
  FOREIGN KEY (film_id) REFERENCES films(id) on delete cascade on update cascade,
  FOREIGN KEY (actor_id) REFERENCES actors(id) on delete cascade on update cascade
) COMMENT = 'Фильмография актеров';

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  firstname VARCHAR(50) COMMENT 'Имя',
  lastname VARCHAR(50) COMMENT 'Фамилия',
  email VARCHAR(120) UNIQUE,
  phone BIGINT, 
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Пользователи';

DROP TABLE IF EXISTS ratings;
CREATE TABLE ratings (
#  id SERIAL PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  film_id BIGINT UNSIGNED NOT NULL,
  rating INT unsigned  COMMENT 'Рейтинг фильма',
  index (user_id) COMMENT 'Индекс для связи таблицей users',
  index (film_id) COMMENT 'Индекс для связи таблицей films',
  primary key (user_id, film_id),
  FOREIGN KEY (user_id) REFERENCES users(id) on delete cascade on update cascade,
  FOREIGN KEY (film_id) REFERENCES films(id) on delete cascade on update cascade
) COMMENT = 'Рейтинги';

DROP TABLE IF EXISTS user_favorit_films;
CREATE TABLE user_favorit_films (
 # id SERIAL PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  film_id BIGINT UNSIGNED NOT NULL,
  index (user_id) COMMENT 'Индекс для связи таблицей users',
  index (film_id) COMMENT 'Индекс для связи таблицей films',
  primary key (user_id, film_id),
  FOREIGN KEY (user_id) REFERENCES users(id) on delete cascade on update cascade,
  FOREIGN KEY (film_id) REFERENCES films(id) on delete cascade on update cascade
) COMMENT = 'Избранные фильмы пользователя';

DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews (
  id SERIAL PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  film_id BIGINT UNSIGNED NOT NULL,
  review TEXT,
  date_at DATE COMMENT 'Дата рецензии',
  index (film_id) COMMENT 'Индекс для связи таблицей films',
  index (user_id) COMMENT 'Индекс для связи таблицей users',
  FOREIGN KEY (user_id) REFERENCES users(id) on delete cascade on update cascade,
  FOREIGN KEY (film_id) REFERENCES films(id) on delete cascade on update cascade
) COMMENT = 'Рецензии';

DROP TABLE IF EXISTS tralers;
CREATE TABLE tralers (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название трелера',
  film_id BIGINT UNSIGNED NOT NULL,
  size INT unsigned,
  body text,
  index (film_id) COMMENT 'Индекс для связи таблицей films',
  FOREIGN KEY (film_id) REFERENCES films(id) on delete cascade on update cascade
) COMMENT = 'Трелеры';

DROP TABLE IF EXISTS cinemas;
CREATE TABLE cinemas (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название кинотеатра',
  country_id BIGINT UNSIGNED,
  city_id BIGINT UNSIGNED,
  index (country_id) COMMENT 'Индекс для связи таблицей countries',
  index (city_id) COMMENT 'Индекс для связи таблицей cities',
  FOREIGN KEY (country_id) REFERENCES countries(id) on delete cascade on update cascade,
  FOREIGN KEY (city_id) REFERENCES cities(id) on delete cascade on update cascade
#  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) COMMENT = 'Кинотеатры';

DROP TABLE IF EXISTS rentals_films;
CREATE TABLE rentals_films (
  id SERIAL PRIMARY KEY,
  film_id BIGINT UNSIGNED NOT NULL,
  cinema_id BIGINT UNSIGNED NOT NULL, 
  rental_fee BIGINT UNSIGNED COMMENT 'Сбор от проката в этом кинотеатре',
  index (film_id) COMMENT 'Индекс для связи таблицей films',
  index (cinema_id) COMMENT 'Индекс для связи таблицей films',
  FOREIGN KEY (film_id) REFERENCES films(id) on delete cascade on update cascade,
  FOREIGN KEY (cinema_id) REFERENCES cinemas(id) on delete cascade on update cascade
) COMMENT = 'Прокаты фильмов';

#############################################################
#############################################################
#Создаем View
#1. Кассовые сборы по фильмам
drop view if exists sum_rentals;
create view sum_rentals as	
select f.name, f.rental_date, sum(rf.rental_fee)as sum_rentals
	from rentals_films as rf
		join films as f
			on f.id = rf.film_id
	group by f.id
	order by f.rental_date;

#2. Топ 3 самых прибыльных кинотеатров
drop view if exists top3_cinemas;
create view top3_cinemas as	
select c.name, sum(rf.rental_fee) as sum_rental_fee
	from cinemas as c
		join rentals_films as rf
			on c.id = rf.cinema_id
	group by c.id
	order by sum_rental_fee desc
	limit 3;

#3. Топ 3 самых популярных жанров
drop view if exists top3_genre;
create view top3_genre as	
select g.name, avg(r.rating) as sum_rating
	from films as f
		join ratings as r
			on f.id = r.film_id
		join genre as g
			on f.genre_id=g.id
	group by f.id
	order by sum_rating desc
	limit 3;


#############################################################
#############################################################
#Создаем Function
#1. Узнать сумму проката по конкретному фильму в конкретном городе
drop function if exists get_SumRentalsAtCity;
DELIMITER //
CREATE FUNCTION get_SumRentalsAtCity(FilmName varchar(255),CityName varchar(255)) RETURNS bigint
    DETERMINISTIC
    COMMENT 'Узнать сумму проката по конкретному фильму в конкретном городе'
begin
 DECLARE result bigint;
 SET result= (select rf.rental_fee #f.name, cities.name, 
 from rentals_films as rf
 	join
 		cinemas as c
 			on c.id = rf.cinema_id
 	join
 		cities
 			on c.city_id = cities.id
 	join
 		films as f
 			on f.id = rf.film_id
 	where
 		f.name = FilmName and
 		cities.name = CityName);
 
 RETURN result; 
END//

DELIMITER ;


#############################################################
#############################################################
#Создаем Procedure
#1. Подобрать пользователю фильмы интересующих его жанров (жанры получаем из избранных)

drop procedure if exists get_podgorka_films;
DELIMITER //
CREATE PROCEDURE get_podgorka_films(user_id bigint)
    COMMENT 'Подбирает фильмы для пользователя исходя его предпочтений по жанрам'
    NOT DETERMINISTIC
	select f2.Name
		from users as u
		join user_favorit_films as uff
			on u.id = uff.user_id
		join films as f
			on uff.film_id = f.id
		join films as f2
			on f.genre_id = f2.genre_id
		where u.id = user_id
    //
DELIMITER ;

#2. Узнать жанр, в котором чаще всего снимается актер
drop procedure if exists get_ActorGenre;
DELIMITER //
CREATE PROCEDURE get_ActorGenre(actor_id bigint)
    NOT DETERMINISTIC
    COMMENT 'Узнать жанр, в котором чаще всего снимается актер'
select a.firstname, a.lastname, g.name, count(g.name) as count_films
	from actors as a
	join actor_filmography as af
		on a.id = af.actor_id
	join films as f
		on af.film_id = f.id
	join genre as g
		on f.genre_id = g.id
	where a.id = actor_id
	group by g.name
	order by count_films desc
	Limit 1;
//

DELIMITER ;

#2. Узнать жанр, в котором чаще всего снимает режисер
drop procedure if exists get_ProducerGenre;
DELIMITER //
CREATE PROCEDURE get_ProducerGenre(Producer_id bigint)
    NOT DETERMINISTIC
    COMMENT 'Узнать жанр, в котором чаще всего снимает режисер'
select p.firstname, p.lastname, g.name, count(g.name) as count_films
	from Producers as p
	join Producer_filmography as pf
		on p.id = pf.prod_id
	join films as f
		on pf.film_id = f.id
	join genre as g
		on f.genre_id = g.id
	where p.id = Producer_id
	group by g.name
	order by count_films desc
	Limit 1;
//

DELIMITER ;



############################################################
############################################################
#РАЗДЕЛ НАПОЛНЕНИЯ ДАННЫХ

#Наполняем таблицу ЖАНРЫ
INSERT INTO `genre` (`name`) VALUES 
('аниме'),
('биографический'),
('боевик'),
('вестерн'),
('военный'),
('детектив'),
('детский'),
('документальный'),
('драма'),
('исторический'),
('кинокомикс'),
('комедия'),
('концерт'),
('короткометражный'),
('криминал'),
('мелодрама'),
('мистика'),
('музыка'),
('мультфильм'),
('мюзикл'),
('научный'),
('приключения'),
('реалити-шоу'),
('семейный'),
('спорт'),
('ток-шоу'),
('триллер'),
('ужасы'),
('фантастика'),
('фильм-нуар'),
('фэнтези'),
('эротика');
#Наполняем таблицу СТРАНЫ
INSERT INTO `countries` (`name`) VALUES 
('Австралия'),
('США'),
('Германия'),
('Италия'),
('Франция'),
('Россия'),
('Дания'),
('Уругвай'),
('Япония'),
('Китай');
#Наполняем таблицу СТРАНЫ
INSERT INTO `cities` (`name`,`country_id`) VALUES 
('City1',1),
('City2',2),
('City3',3),
('City4',4),
('City5',5),
('City6',6),
('City7',7),
('City8',8),
('City9',9),
('City10',10);
#Наполняем таблицу ФИЛЬМЫ
INSERT INTO `films` (`name`,`created_at`,`country_id`,`genre_id`,`cost`,`rental_date`) VALUES 
('Film1', '2019-03-11', 3, 9, 51654920, '2019-02-11'),
('Film2', '2018-03-31', 1, 1, 304999901, '2018-02-28'),
('Film3', '2019-04-14', 6, 2, 572278056, '2019-03-14'),
('Film4', '2018-03-30', 7, 2, 859426359, '2018-02-28'),
('Film5', '2018-03-01', 8, 8, 652021703, '2018-02-01'),
('Film6', '2018-04-24', 6, 4, 100009914, '2018-03-24'),
('Film7', '2019-02-04', 9, 5, 92648149, '2019-01-04'),
('Film8', '2019-11-01', 4, 3, 695859779, '2019-10-01'),
('Film9', '2018-06-02', 1, 3, 166131480, '2018-05-02'),
('Film10', '2019-03-11', 3, 6, 895601659, '2019-02-11'),
('Film11', '2019-02-22', 1, 5, 233986246, '2019-01-22'),
('Film12', '2019-02-20', 3, 3, 480683335, '2019-01-20'),
('Film13', '2019-09-22', 2, 2, 237369133, '2019-08-22'),
('Film14', '2019-11-27', 7, 9, 696787565, '2019-10-27'),
('Film15', '2018-06-20', 7, 5, 257128272, '2018-05-20'),
('Film16', '2018-03-08', 6, 5, 190956085, '2018-02-08'),
('Film17', '2018-06-23', 5, 5, 453977194, '2018-05-23'),
('Film18', '2018-12-21', 6, 6, 913271440, '2018-11-21'),
('Film19', '2019-08-22', 9, 7, 112573328, '2019-07-22'),
('Film20', '2019-02-11', 4, 8, 3201681, '2019-01-11'),
('Film21', '2019-05-21', 3, 7, 285757213, '2019-04-21'),
('Film22', '2018-04-23', 8, 8, 29752497, '2018-03-23'),
('Film23', '2019-02-14', 4, 6, 223747847, '2019-01-14'),
('Film24', '2018-03-07', 9, 1, 511530793, '2018-02-07'),
('Film25', '2018-12-25', 6, 8, 33976014, '2018-11-25'),
('Film26', '2018-02-20', 7, 8, 314470080, '2018-01-20'),
('Film27', '2018-12-21', 9, 9, 747313973, '2018-11-21'),
('Film28', '2019-04-15', 3, 2, 734405271, '2019-03-15'),
('Film29', '2018-12-25', 2, 9, 462608747, '2018-11-25'),
('Film30', '2019-11-14', 7, 8, 674415576, '2019-10-14');
#Наполняем таблицу АКТЕРЫ
INSERT INTO `actors` (`firstname`,`lastname`,`birthday_at`,`country_id`) VALUES 
('Jerrell', 'Stanton', '1972-06-11',1),
('Golden', 'Wisozk', '2010-05-22',2),
('Elisa', 'Balistreri', '1994-07-26',4),
('Reed', 'Bogan', '1961-04-13',4),
('Gwendolyn', 'McClure', '1994-06-03',8),
('Luz', 'Bailey', '1997-12-30',1),
('Alyce', 'Toy', '1963-12-30',9),
('Oma', 'Ortiz', '2002-02-08',7),
('Valentine', 'Goldner', '1997-02-02',6),
('Rasheed', 'Ebert', '2008-08-09',6);
#Наполняем таблицу ПРОДЮССЕРЫ
INSERT INTO `producers` (`firstname`,`lastname`,`birthday_at`,`country_id`) VALUES 
('Celestino', 'Cruickshank', '2010-08-15',4),
('Hayley', 'Vandervort', '1967-01-26',4),
('Royal', 'DuBuque', '2006-11-14',8),
('Adrian', 'Mills', '1972-09-15',9),
('Roosevelt', 'Tromp', '2008-05-17',10),
('Miguel', 'Watsica', '1976-10-02',3),
('Gregory', 'Jenkins', '1956-05-27',7),
('Kristina', 'Jast', '1987-09-28',3),
('Ozella', 'Hauck', '1967-01-14',2),
('Emmet', 'Hammes', '2000-05-24',5);
#Наполняем таблицу ФИЛЬМОГРАФИЯ ПРОДЮССЕРОВ
INSERT INTO `producer_filmography` (`film_id`,`prod_id`) VALUES 
('19', '3'),('18', '1'),('22', '9'),('7', '4'),('8', '3'),('3', '1'),('15', '1'),
('27', '3'),('30', '1'),('24', '1'),('24', '8'),('2', '3'),('21', '8'),('15', '4'),
('19', '4'),('11', '7'),('20', '1'),('12', '1'),('18', '6'),('4', '6'),('23', '5'),
('12', '8'),('22', '8'),('23', '1'),('14', '2'),('5', '1'),('24', '7'),('3', '6'),
('13', '2'),('16', '2'),('17', '1'),('25', '4'),('24', '9'),('8', '1'),('28', '7'),
('4', '7'),('26', '7'),('7', '5'),('22', '5'),('21', '2'),('28', '5'),('24', '4'),
('18', '7'),('19', '7'),('14', '4'),('9', '2'),('29', '3'),('20', '8'),('27', '5'),
('29', '2'),('18', '5'),('17', '4'),('3', '9'),('23', '9'),('19', '5'),('29', '9'),
('7', '8'),('21', '6'),('27', '7'),('19', '2');
#Наполняем таблицу ФИЛЬМОГРАФИЯ АКТЕРОВ
INSERT INTO `actor_filmography` (`film_id`,`actor_id`) VALUES 
('19', '3'),('18', '1'),('22', '9'),('7', '4'),('8', '3'),('3', '1'),('15', '1'),
('27', '3'),('30', '1'),('24', '1'),('24', '8'),('2', '3'),('21', '8'),('15', '4'),
('19', '4'),('11', '7'),('20', '1'),('12', '1'),('18', '6'),('4', '6'),('23', '5'),
('12', '8'),('22', '8'),('23', '1'),('14', '2'),('5', '1'),('24', '7'),('3', '6'),
('13', '2'),('16', '2'),('17', '1'),('25', '4'),('24', '9'),('8', '1'),('28', '7'),
('4', '7'),('26', '7'),('7', '5'),('22', '5'),('21', '2'),('28', '5'),('24', '4'),
('18', '7'),('19', '7'),('14', '4'),('9', '2'),('29', '3'),('20', '8'),('27', '5'),
('29', '2'),('18', '5'),('17', '4'),('3', '9'),('23', '9'),('19', '5'),('29', '9'),
('7', '8'),('21', '6'),('27', '7'),('19', '2');
#Наполняем таблицу ПОЛЬЗОВАТЕЛИ
INSERT INTO `users` (`firstname`, `lastname`, `email`, `phone`, `birthday_at`) VALUES 
('Reuben', 'Nienow', 'arlo50@example.org', '9374071116', '1998-05-14'),
('Frederik', 'Upton', 'terrence.cartwright@example.org', '9127498182', '1966-12-30'),
('Unique', 'Windler', 'rupert55@example.org', '9921090703', '1953-01-05'),
('Norene', 'West', 'rebekah29@example.net', '9592139196', '1991-11-04'),
('Frederick', 'Effertz', 'von.bridget@example.net', '9909791725', '1967-05-19'),
('Victoria', 'Medhurst', 'sstehr@example.net', '9456642385', '1957-07-26'),
('Austyn', 'Braun', 'itzel.beahan@example.com', '9448906606', '1964-01-05'),
('Jaida', 'Kilback', 'johnathan.wisozk@example.com', '9290679311', '1950-08-11'),
('Mireya', 'Orn', 'missouri87@example.org', '9228624339', '2009-06-09'),
('Jordyn', 'Jerde', 'edach@example.com', '9443126821', '1997-08-25'),
('Thad', 'McDermott', 'shaun.ferry@example.org', '9840726982', '2005-06-10'),
('Aiden', 'Runolfsdottir', 'doug57@example.net', '9260442904', '2011-07-04'),
('Bernadette', 'Haag', 'lhoeger@example.net', '9984574866', '2001-04-29'),
('Dedric', 'Stanton', 'tconsidine@example.org', '9499932439', '1985-11-25'),
('Clare', 'Wolff', 'effertz.laverna@example.org', '9251665331', '1985-07-26'),
('Lina', 'Macejkovic', 'smitham.demarcus@example.net', '9762021357', '1964-04-01'),
('Jerrell', 'Stanton', 'deja00@example.com', '9191103792', '1972-06-11'),
('Golden', 'Wisozk', 'frida19@example.com', '9331565437', '2010-05-22'),
('Elisa', 'Balistreri', 'romaine27@example.org', '9372983850', '1994-07-26'),
('Reed', 'Bogan', 'zhyatt@example.com', '9924753974', '1961-04-13'),
('Gwendolyn', 'McClure', 'zluettgen@example.net', '9745046704', '1994-06-03'),
('Luz', 'Bailey', 'tillman.iliana@example.org', '9881942174', '1997-12-30'),
('Alyce', 'Toy', 'russel.ewell@example.com', '9754884857', '1963-12-30'),
('Oma', 'Ortiz', 'jailyn.feest@example.com', '9339073755', '2002-02-08'),
('Valentine', 'Goldner', 'matteo.wiza@example.net', '9803404650', '1997-02-02'),
('Rasheed', 'Ebert', 'brenden32@example.net', '9924275184', '2008-08-09'),
('Misael', 'Lakin', 'benjamin.hilpert@example.com', '9619165091', '1969-08-25'),
('Shaun', 'Fritsch', 'wwiegand@example.org', '9231898080', '1983-05-04'),
('Katarina', 'Sipes', 'jenifer.gislason@example.net', '9348426774', '1981-12-09'),
('Newton', 'Koss', 'beatty.river@example.org', '9574058915', '1953-09-19'),
('Selmer', 'Quitzon', 'ztromp@example.net', '9363178382', '2010-03-05'),
('Margarete', 'Koepp', 'idell70@example.net', '9743498718', '1952-01-03'),
('Donavon', 'Bauch', 'michele.lakin@example.com', '9229739697', '1982-03-04'),
('Ashlynn', 'Cummerata', 'weber.tatyana@example.net', '9710902090', '1977-05-14'),
('Fletcher', 'Lang', 'mona94@example.com', '9502246403', '1970-06-27'),
('Amiya', 'Leuschke', 'mathilde.macejkovic@example.com', '9461791942', '1961-01-18'),
('Terrance', 'West', 'ebert.magnus@example.org', '9381729082', '1945-04-09'),
('Keara', 'Kiehn', 'audie.franecki@example.net', '9796576345', '1973-02-13'),
('Wyatt', 'Olson', 'jarvis92@example.org', '9212459514', '1956-05-24'),
('Paula', 'Shields', 'casey.bayer@example.org', '9410763172', '1953-01-01'),
('Ivah', 'Bernier', 'paris15@example.com', '9283284370', '1977-04-07'),
('Liza', 'Howe', 'hadley72@example.org', '9926888657', '2011-11-09'),
('Kevon', 'Gerhold', 'fhilll@example.com', '9398761644', '2001-06-05'),
('Hermina', 'Lubowitz', 'amalia.reichel@example.org', '9213914905', '1999-07-12'),
('Cara', 'Quigley', 'hailee.beier@example.net', '9287811077', '1994-10-31'),
('Kian', 'Weimann', 'tankunding@example.net', '9168462586', '1958-06-14'),
('Madelynn', 'Hahn', 'pleffler@example.org', '9598242802', '2007-11-06'),
('Hassie', 'Monahan', 'lowe.amelia@example.net', '9765846197', '2012-07-10'),
('Taryn', 'Kuvalis', 'aschneider@example.net', '9533355262', '2009-04-02'),
('Hollis', 'Padberg', 'cathryn40@example.net', '9163727209', '1964-02-29'),
('Henriette', 'Lindgren', 'allie.witting@example.com', '9891313707', '1964-11-05'),
('Keven', 'DuBuque', 'durward83@example.com', '9613848114', '1990-04-02'),
('Chaz', 'Yundt', 'stamm.bret@example.net', '9763350438', '1950-03-15'),
('Rosalee', 'Dickens', 'concepcion.conn@example.net', '9675063949', '2011-04-27'),
('Kip', 'Schoen', 'ibeer@example.com', '9987381304', '1977-06-14'),
('Louie', 'Spencer', 'tkessler@example.com', '9938579943', '2007-11-13'),
('Priscilla', 'Daniel', 'barrett12@example.com', '9886578202', '1968-05-20'),
('Dean', 'Satterfield', 'orin69@example.net', '9160120629', '1991-08-09'),
('Prudence', 'Shields', 'sleffler@example.net', '9414604655', '1948-06-26'),
('Elaina', 'Buckridge', 'bartell.einar@example.net', '9916593682', '1984-12-25'),
('Monserrat', 'O\'Conner', 'linda58@example.com', '9519551625', '1962-04-10'),
('Ramona', 'Davis', 'abbigail68@example.net', '9484610686', '1983-03-07'),
('Eldridge', 'Wilkinson', 'callie.wuckert@example.org', '9532811737', '1949-10-03'),
('Emanuel', 'Reinger', 'loyal.herzog@example.org', '9659591995', '1988-06-27'),
('Janis', 'Stamm', 'nils93@example.org', '9905318598', '1980-02-29'),
('Nannie', 'Streich', 'chelsea01@example.com', '9412172452', '1960-04-03'),
('Elva', 'Sawayn', 'modesta.haley@example.com', '9803009959', '1982-07-12'),
('Ava', 'Nolan', 'mmarvin@example.com', '9428224970', '1948-03-16'),
('Westley', 'Predovic', 'urunolfsdottir@example.net', '9247233922', '2012-11-23'),
('Antonina', 'Ferry', 'jamaal.farrell@example.com', '9902477849', '1998-12-26'),
('Jeffery', 'Lowe', 'noemie38@example.org', '9803133328', '1988-02-20'),
('Cesar', 'Schmitt', 'johnathan.waelchi@example.org', '9330339588', '1956-12-15'),
('Letha', 'Beatty', 'reynold.feil@example.net', '9636262160', '1953-07-28'),
('Benton', 'Rogahn', 'jbeer@example.net', '9490216855', '2009-04-29'),
('Braden', 'Shields', 'zemlak.foster@example.com', '9114981748', '1950-10-11'),
('Luther', 'Turcotte', 'zturner@example.com', '9292137540', '1997-08-03'),
('Patricia', 'Gleason', 'benny76@example.net', '9148879590', '1961-02-02'),
('Delta', 'Kerluke', 'terry.antone@example.org', '9667864529', '1945-03-18'),
('Thurman', 'Rutherford', 'isaiah.gerlach@example.net', '9994148720', '1991-01-09'),
('Willie', 'Fritsch', 'rolando45@example.org', '9512440690', '2004-08-22'),
('Letitia', 'Marks', 'bosco.sage@example.net', '9546163253', '1955-07-20'),
('Ada', 'Kuvalis', 'emmanuelle.hegmann@example.org', '9251017068', '1992-05-12'),
('Josie', 'Kunde', 'kaley.rolfson@example.net', '9285157694', '1986-11-10'),
('Harmony', 'Lesch', 'velda32@example.org', '9627960545', '2009-09-08'),
('Kelsie', 'Olson', 'xheidenreich@example.net', '9548492646', '2009-06-23'),
('Lucile', 'Rolfson', 'dbartell@example.net', '9258387168', '1954-02-07'),
('Celestino', 'Cruickshank', 'flavio.hammes@example.com', '9686686728', '2010-08-15'),
('Hayley', 'Vandervort', 'cartwright.seamus@example.com', '9228109837', '1967-01-26'),
('Royal', 'DuBuque', 'jswift@example.org', '9295312277', '2006-11-14'),
('Adrian', 'Mills', 'gail.lockman@example.net', '9491584055', '1972-09-15'),
('Roosevelt', 'Tromp', 'gutkowski.janiya@example.com', '9910853104', '2008-05-17'),
('Miguel', 'Watsica', 'hassan.kuphal@example.org', '9824696112', '1976-10-02'),
('Gregory', 'Jenkins', 'weimann.richard@example.com', '9860971258', '1956-05-27'),
('Kristina', 'Jast', 'jennifer27@example.com', '9133161481', '1987-09-28'),
('Ozella', 'Hauck', 'idickens@example.com', '9773438197', '1967-01-14'),
('Emmet', 'Hammes', 'qcremin@example.org', '9694110645', '2000-05-24'),
('Eleonore', 'Ward', 'antonietta.swift@example.com', '9397815776', '2008-12-22'),
('Lori', 'Koch', 'damaris34@example.net', '9192291407', '1989-09-19'),
('Sam', 'Kuphal', 'telly.miller@example.net', '9917826312', '2001-01-20'),
('Pearl', 'Prohaska', 'xeichmann@example.net', '9136605713', '1947-01-04');
#Наполняем таблицу РЕЙТИНГИ
INSERT INTO `ratings` (`user_id`,`film_id`,rating) VALUES 
('39', '26', '1'),('5', '16', '2'),('17', '14', '6'),('94', '1', '5'),('40', '8', '8'),('59', '17', '5'),
('59', '27', '8'),('60', '2', '4'),('31', '9', '8'),('88', '28', '9'),('70', '3', '9'),('70', '11', '4'),
('24', '18', '8'),('35', '9', '7'),('40', '5', '2'),('7', '21', '8'),('75', '24', '5'),('58', '15', '3'),
('47', '6', '2'),('52', '6', '2'),('31', '13', '2'),('47', '25', '4'),('3', '11', '6'),('2', '25', '9'),
('84', '24', '6'),('69', '13', '3'),('3', '6', '7'),('46', '1', '8'),('71', '23', '7'),('32', '11', '9'),
('47', '21', '5'),('82', '18', '5'),('93', '5', '5'),('73', '4', '2'),('1', '12', '9'),('71', '13', '6'),
('28', '8', '3'),('28', '2', '8'),('6', '9', '8'),('50', '20', '5'),('72', '13', '5'),('15', '18', '5'),
('60', '23', '8'),('93', '3', '9'),('51', '11', '8'),('9', '17', '1'),('88', '14', '1'),('15', '10', '2'),
('63', '29', '3'),('43', '23', '4'),('47', '14', '5'),('8', '24', '4'),('25', '2', '7'),('99', '4', '6'),
('95', '7', '2'),('26', '19', '6'),('71', '12', '8'),('75', '28', '1'),('82', '7', '4'),('44', '1', '2');
#Наполняем таблицу ИЗБРАННЫЕ ФИЛЬМЫ ПОЛЬЗОВАТЕЛЯ
INSERT INTO `user_favorit_films` (`user_id`,`film_id`) VALUES 
('12', '20'),('55', '8'),('54', '29'),('26', '7'),('32', '1'),('67', '25'),('31', '11'),('25', '29'),
('21', '4'),('56', '6'),('7', '28'),('46', '22'),('64', '19'),('12', '9'),('61', '18'),('77', '13'),
('22', '2'),('95', '23'),('27', '11'),('41', '15'),('54', '6'),('96', '6'),('72', '4'),('29', '13'),
('73', '17'),('65', '24'),('76', '21'),('57', '23'),('81', '18'),('14', '29'),('68', '2'),('44', '12'),
('33', '28'),('33', '21'),('5', '14'),('76', '3'),('47', '4'),('26', '9'),('2', '24'),('83', '24'),
('95', '13'),('7', '3'),('42', '24'),('79', '19'),('91', '14'),('44', '18'),('7', '15'),('68', '15'),
('42', '10'),('28', '25'),('81', '2'),('20', '1'),('98', '9'),('9', '17'),('5', '10'),('15', '2'),
('83', '4'),('4', '8'),('21', '13'),('56', '7');
#Наполняем таблицу РЕЦЕНЗИИ
INSERT INTO `reviews` (`user_id`,`film_id`,`review`,`date_at`) VALUES 
('47', '22', 'Это рецензия на фильм', '2019-11-22'),
('27', '16', 'Это рецензия на фильм', '2015-10-12'),
('29', '11', 'Это рецензия на фильм', '2015-07-18'),
('6', '29', 'Это рецензия на фильм', '2012-07-22'),
('9', '23', 'Это рецензия на фильм', '2015-06-28'),
('53', '9', 'Это рецензия на фильм', '2018-01-03'),
('58', '1', 'Это рецензия на фильм', '2018-12-23'),
('62', '19', 'Это рецензия на фильм', '2018-02-12'),
('42', '12', 'Это рецензия на фильм', '2018-04-23'),
('91', '18', 'Это рецензия на фильм', '2019-05-22'),
('80', '4', 'Это рецензия на фильм', '2015-03-06'),
('61', '16', 'Это рецензия на фильм', '2011-07-19'),
('34', '28', 'Это рецензия на фильм', '2016-05-11'),
('93', '29', 'Это рецензия на фильм', '2014-09-03'),
('52', '12', 'Это рецензия на фильм', '2011-06-16'),
('77', '11', 'Это рецензия на фильм', '2015-03-31'),
('81', '26', 'Это рецензия на фильм', '2015-08-17'),
('20', '25', 'Это рецензия на фильм', '2014-09-11'),
('44', '22', 'Это рецензия на фильм', '2013-10-27'),
('23', '5', 'Это рецензия на фильм', '2010-04-25'),
('63', '25', 'Это рецензия на фильм', '2010-07-29'),
('65', '15', 'Это рецензия на фильм', '2017-12-28'),
('32', '25', 'Это рецензия на фильм', '2019-11-12'),
('85', '18', 'Это рецензия на фильм', '2016-12-27'),
('10', '12', 'Это рецензия на фильм', '2013-04-06'),
('9', '14', 'Это рецензия на фильм', '2015-05-07'),
('43', '28', 'Это рецензия на фильм', '2017-09-19'),
('18', '13', 'Это рецензия на фильм', '2014-04-05'),
('33', '20', 'Это рецензия на фильм', '2011-04-12'),
('69', '11', 'Это рецензия на фильм', '2013-08-30');
#Наполняем таблицу ТРЕЙЛЕРЫ
INSERT INTO `tralers` (`name`,`film_id`,`size`) VALUES 
('TralerName1', '13', '3999709'),('TralerName2', '13', '63456395'),('TralerName3', '4', '40562676'),
('TralerName4', '14', '37488882'),('TralerName5', '7', '31594227'),('TralerName6', '16', '52135550'),
('TralerName7', '21', '56552914'),('TralerName8', '25', '51910404'),('TralerName9', '14', '94151146'),
('TralerName10', '16', '71533722'),('TralerName11', '2', '20233202'),('TralerName12', '26', '44643161'),
('TralerName13', '11', '89739173'),('TralerName14', '13', '43919643'),('TralerName15', '2', '93135204'),
('TralerName16', '20', '92191430'),('TralerName17', '6', '95896391'),('TralerName18', '10', '97634566'),
('TralerName19', '7', '53022712'),('TralerName20', '10', '53380906'),('TralerName21', '5', '74286378'),
('TralerName22', '21', '50054541'),('TralerName23', '26', '8885084'),('TralerName24', '25', '96964914'),
('TralerName25', '20', '17151706'),('TralerName26', '15', '81027663'),('TralerName27', '9', '19492364'),
('TralerName28', '28', '37437885'),('TralerName29', '12', '1028820'),('TralerName30', '9', '23012721'),
('TralerName31', '10', '9926926'),('TralerName32', '23', '33213771'),('TralerName33', '21', '93020408'),
('TralerName34', '16', '12407359'),('TralerName35', '21', '39889191'),('TralerName36', '19', '95078596'),
('TralerName37', '22', '51912413'),('TralerName38', '14', '88430808'),('TralerName39', '11', '13297696'),
('TralerName40', '22', '74291932'),('TralerName41', '25', '38734206'),('TralerName42', '18', '1131431'),
('TralerName43', '17', '39282635'),('TralerName44', '16', '13124057'),('TralerName45', '9', '33590159'),
('TralerName46', '24', '17405504'),('TralerName47', '17', '93521536'),('TralerName48', '16', '33674362'),
('TralerName49', '23', '49157877'),('TralerName50', '24', '49019575');

#Наполняем таблицу КИНОТЕАТРЫ
INSERT INTO `cinemas` (`name`,`country_id`,`city_id`) VALUES 
('Cinema1', '1', '5'),
('Cinema2', '4', '4'),
('Cinema3', '9', '2'),
('Cinema4', '4', '8'),
('Cinema5', '5', '7'),
('Cinema6', '8', '7'),
('Cinema7', '4', '9'),
('Cinema8', '5', '2'),
('Cinema9', '4', '9'),
('Cinema10', '2', '6'),
('Cinema11', '1', '2'),
('Cinema12', '5', '3'),
('Cinema13', '2', '6'),
('Cinema14', '5', '1'),
('Cinema15', '9', '5'),
('Cinema16', '2', '9'),
('Cinema17', '1', '3'),
('Cinema18', '4', '3'),
('Cinema19', '9', '3'),
('Cinema20', '3', '9');
#Наполняем таблицу ПРОКАТЫ ФИЛЬМОВ
INSERT INTO `rentals_films` (`film_id`,`cinema_id`,`rental_fee`) VALUES 
('15', '16', '4087'),
('27', '14', '2156'),
('12', '10', '1703'),
('23', '6', '2718'),
('4', '19', '1518'),
('2', '15', '1750'),
('8', '13', '3899'),
('2', '13', '2035'),
('27', '3', '159'),
('8', '11', '2634'),
('4', '7', '160'),
('18', '11', '922'),
('21', '9', '1954'),
('8', '1', '0'),
('21', '4', '1176'),
('13', '1', '1538'),
('20', '10', '1020'),
('20', '10', '1271'),
('16', '3', '3742'),
('15', '13', '1964');


####################################################
####################################################
####################################################
#Выполняем созданные VIEW/FUNCTION/PROCEDURE

#Кассовые сборы по фильмам
select * from sum_rentals;

#Топ 3 самых прибыльных кинотеатров
select * from top3_cinemas;

#Топ 3 самых популярных жанров
select * from top3_genre;

#Получаес сумму проката по фильму "Film4" в городе "City3"
select `get_SumRentalsAtCity`("Film4","City3") as sum_rental;

#Создаем подборку фильмов на оcнове жанров любимых фильмов для пользователя с ID=4
call get_podgorka_films(4);

#Узнаем жанр, в котором чаще всего снимается актер с ID=2
call get_ActorGenre(2);	

#Узнать жанр, в котором чаще всего снимает режисер
call get_ProducerGenre(2);	
