alter table country
add primary key(code);
alter table country
add check(surfacearea >= 0);
select distinct continent
from country;
alter table country drop constraint "country_continent_check";
alter table country
add check(
        (continent = 'South America'::text)
        or (continent = 'Oceania'::text)
        or (continent = 'North America'::text)
        or (continent = 'Europe'::text)
        or (continent = 'Asia'::text)
        or (continent = 'Antarctica'::text)
        or (continent = 'Africa'::text)
        or (continent = 'Hola'::text)
    );
create unique index "country_continent" on country (country);
select *
from country
where continent = 'Africa';
create unique index "unique_name_countrycode_district" on city (name, countrycode, district);
create index "unique_district" on city (district);
alter table city
add constraint fk_country_code foreign key (countrycode) REFERENCES country(code) on delete cascade;