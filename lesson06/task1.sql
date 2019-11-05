use vk;

SET @u_id = 1; #Задаем ID исходного пользователя
#select @u_id;

select u.id, u.firstname, u.lastname, C
from (select 
	  		IF(from_user_id = @u_id,to_user_id,from_user_id) as boltun, #Получаем ID собеседника
	  		id,
	  		Count(id) as C	  		
	  from messages 
      where from_user_id = @u_id or to_user_id = @u_id
      group by boltun
      having C) as a, users as u
where
	  a.id = u.id
limit 1
