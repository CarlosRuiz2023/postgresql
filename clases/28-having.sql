select count(*),
    substring(email, POSITION('@' in email) + 1) as domain
from users
group by substring(email, POSITION('@' in email) + 1)
having count(*) > 1
order by substring(email, POSITION('@' in email) + 1) ASC;