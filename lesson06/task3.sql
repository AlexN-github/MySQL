use vk;

select IF(gender = "f","female","male") as gender_win
from 
	(select p.gender,Count(*) as count_likes
	from likes as l 
			left join 
		 users as u on l.user_id = u.id 
		 	inner join
		 profiles as p on u.id = p.user_id	
	where 
    	  p.gender = "f"
      	union
	select p.gender,Count(*)
	from likes as l 
			left join 
		 users as u on l.user_id = u.id 
		 	inner join
		 profiles as p on u.id = p.user_id
	where 
   	   p.gender = "m") as res
order by count_likes desc
limit 1