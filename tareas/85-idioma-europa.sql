

-- ¿Cuál es el idioma (y código del idioma) oficial más hablado por diferentes países en Europa?
select code from continent where name= 'Europe';
select
    count(*),
    c.code,
    c."name"
from
    country a
    inner join countrylanguage b on a.code = b.countrycode
    inner join language c on b.languagecode = c.code
where
    continent = (
        select
            code
        from
            continent
        where
            name = 'Europe'
    )
    and b.isofficial = true
group by
    c."name",
    c.code
order by
    count(*) desc
limit
    1;
-- Listado de todos los países cuyo idioma oficial es el más hablado de Europa
-- (no hacer subquery, tomar el código anterior)
select
    *
from
    country a
    inner join countrylanguage b on a.code = b.countrycode
where
    a.continent = 5
    and isofficial = true
    and b.languagecode = 135;