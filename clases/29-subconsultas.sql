select sum(total)
from (
        select count(*) as total,
            substring(email, POSITION('@' in email) + 1) as domain,
            'Charly' as name,
            37 as age
        from users
        group by substring(email, POSITION('@' in email) + 1)
        having count(*) > 1
        order by substring(email, POSITION('@' in email) + 1) ASC
    ) as email_domains;