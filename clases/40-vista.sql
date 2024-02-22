-- Vista
create view View_datafrompersona as
select country_id,
    country_name
from countries;
select *
from View_datafrompersona;