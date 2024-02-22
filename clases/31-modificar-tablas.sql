insert into continent (name)
select distinct continent
from country
order by continent asc;
alter table country
alter column continent TYPE int4 using continent::integer;