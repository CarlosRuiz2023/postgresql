-- Fechas y Tiempos
select now(),
    CURRENT_DATE,
    CURRENT_TIME,
    date_part('hours', now()) as hours,
    date_part('minutes', now()) as minutes,
    date_part('seconds', now()) as seconds,
    date_part('days', now()) as days,
    date_part('months', now()) as months,
    date_part('years', now()) as years;
-- Intervalos sumas
select max(hire_date),
    max(hire_date) + interval '1 days' as days,
    max(hire_date) + interval '1 month' as months,
    max(hire_date) + interval '1 year' as years,
    max(hire_date) + interval '1.1 year' as aniomes,
    max(hire_date) + interval '1 year' + interval '1 days' as aniodia,
    date_part('year', now()),
    MAKE_INTERVAL(years := date_part('year', now())::INTEGER),
    max(hire_date) + MAKE_INTERVAL(years := 23)
from employees;
-- Intervalos restas
select hire_date,
    MAKE_INTERVAL (
        years := 2024 - EXTRACT(
            years
            from hire_date
        )::integer
    ) as manual,
    MAKE_INTERVAL (
        years := date_part('years', CURRENT_DATE)::INTEGER - EXTRACT(
            years
            from hire_date
        )::integer
    ) as computed
from employees;