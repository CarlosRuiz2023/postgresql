-- Case Youtube
select *,
    case
        when region_id = 1 then 'Como no'
        when region_id = 2 then 'Hora si'
        else 'como crees'
    end as tipo_viaje
from countries;
-- Cases Fernando
select first_name,
    last_name,
    hire_date,
    case
        when hire_date > now() - interval '1 year' then '1 año o menos'
        when hire_date > now() - interval '3 year' then '1 a 3 años'
        when hire_date > now() - interval '6 year' then '3 a 6 años'
        else '+ de 6 años'
    end as rango_antiguedad
from employees
order by hire_date desc;