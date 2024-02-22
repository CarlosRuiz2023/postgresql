alter sequence continent_code_seq RESTART WITH 8;
select code,
    name,
    '123'
from continent
where name like '%America%'
union
select 1,
    'otra cosa',
    name
from continent
where code in (3, 5)
order by name asc;
select a.name as country,
    b."name" as continent
from country a,
    continent b
where a.continent = b.code
order by b.name asc;
select a.name as country,
    b.name as continent
from country a
    inner join continent b on a.continent = b.code
order by a.name asc;
select a.name as country,
    a.continent as continentCode,
    b.name as continentName
from country a
    full outer join continent b on a.continent = b.code
order by a.name desc;
select a.name as country,
    a.continent as continentCode,
    b.name as continentName
from country a
    RIGHT join continent b on a.continent = b.code
where a.continent is null
order by a.name desc;