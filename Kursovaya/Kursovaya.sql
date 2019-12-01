use kinopoisk;

DROP TABLE IF EXISTS films;
CREATE TABLE films (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название фильма',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) COMMENT = 'Фильмы';

DROP TABLE IF EXISTS actors;
CREATE TABLE actors (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя актера',
  birthday_at DATE COMMENT 'Дата рождения'
) COMMENT = 'Актеры';

DROP TABLE IF EXISTS producer;
CREATE TABLE producer (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя режисера',
  birthday_at DATE COMMENT 'Дата рождения'
) COMMENT = 'Режиссеры';

DROP TABLE IF EXISTS producer_filmography;
CREATE TABLE producer_filmography (
  id SERIAL PRIMARY KEY,
  film_id INT UNSIGNED,
  prod_id INT unsigned,
  KEY index_of_film_id (film_id) COMMENT 'Индекс для связи таблиwей films',
  KEY index_of_prod_id (prod_id) COMMENT 'Индекс для связи таблицей actors'
) COMMENT = 'Фильмография режиссеров';

DROP TABLE IF EXISTS actor_filmography;
CREATE TABLE actor_filmography (
  id SERIAL PRIMARY KEY,
  film_id INT UNSIGNED,
  actor_id INT unsigned,
  KEY index_of_film_id (film_id) COMMENT 'Индекс для связи таблиwей films',
  KEY index_of_actor_id (actor_id) COMMENT 'Индекс для связи таблицей actors'
) COMMENT = 'Фильмография актеров';

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя пользователя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Пользователи';

DROP TABLE IF EXISTS ratings;
CREATE TABLE ratings (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  film_id INT unsigned,
  rating INT unsigned  COMMENT 'Рейтинг фильма',
  KEY index_of_film_id (user_id) COMMENT 'Индекс для связи таблицей users',
  KEY index_of_user_id (film_id) COMMENT 'Индекс для связи таблицей films'
) COMMENT = 'Рейтинги';

DROP TABLE IF EXISTS user_favorit_films;
CREATE TABLE user_favorit_films (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  film_id INT unsigned,
  KEY index_of_film_id (user_id) COMMENT 'Индекс для связи таблицей users',
  KEY index_of_user_id (film_id) COMMENT 'Индекс для связи таблицей films'
) COMMENT = 'Рейтинги';

DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  film_id INT unsigned,
  review TEXT,
  KEY index_of_film_id (film_id) COMMENT 'Индекс для связи таблицей films',
  KEY index_of_user_id (user_id) COMMENT 'Индекс для связи таблицей users'
) COMMENT = 'Рецензии';

DROP TABLE IF EXISTS tralers;
CREATE TABLE tralers (
  id SERIAL PRIMARY KEY,
  film_id INT unsigned,
  KEY index_of_film_id (film_id) COMMENT 'Индекс для связи таблицей films'
) COMMENT = 'Трелеры';

DROP TABLE IF EXISTS cinemas;
CREATE TABLE cinemas (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название кинотеатра',
  country VARCHAR(100) COMMENT 'Название кинотеатра',
  sity VARCHAR(100) COMMENT 'Название кинотеатра'
#  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) COMMENT = 'Кинотеатры';

DROP TABLE IF EXISTS rentals_films;
CREATE TABLE rentals_films (
  id SERIAL PRIMARY KEY,
  film_id INT unsigned,
  date_at DATE COMMENT 'Дата проката',
  rental_fee FLOAT UNSIGNED COMMENT 'Сбор от проката',
  KEY index_of_film_id (film_id) COMMENT 'Индекс для связи таблицей films'
) COMMENT = 'Прокаты фильмов';

