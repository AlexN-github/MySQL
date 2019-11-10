select distinct u.name 
from orders as o
	join
      users as u on u.id = o.user_id 