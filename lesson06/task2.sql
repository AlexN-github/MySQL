use vk;

select Count(*)
from users as u,media as m,likes as l,profiles as p
where u.id = m.user_id and
      m.id = l.media_id and
      u.id = p.user_id and
      timestampdiff(year,p.birthday,now()) < 10