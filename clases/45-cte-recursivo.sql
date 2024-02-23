-- nombre de la tabla en memoria
-- campos que vamos a tener
with recursive countdown(val) as (
    -- initializacion => el primer nivel, o valores iniciales.
    -- values(5) or 
    select 5 as val
    union
    -- query recursivo
    select val -1
    from countdown
    where val > 1
) -- select de los campos
select *
from countdown;
with recursive multiplication_table(base, val, result) as (
    -- init
    values(5, 1, 5) --
    select 5 as base,
        1 as val,
        5 as result
    union
    -- recursiva
    select 5 as base,
        val + 1,
        (val + 1) * base
    from multiplication_table
    where val < 10
)
select * with recursive multiplication_table(base, val, result) as (
        -- init
        values(5, 1, 5) --     select
            --         5 as base,
            --         1 as val,
            --         5 as result
        union
        -- recursiva
        select 5 as base,
            val + 1,
            (val + 1) * base
        from multiplication_table
        where val < 10
    )
select *
from multiplication_table;
from multiplication_table;
with recursive bosses as (
    -- init
    select id,
        name,
        reports_to
    from employees
    where id = 7
    union
    -- recursive
    select employees.id,
        employees.name,
        employees.reports_to
    from employees
        inner join bosses on bosses.id = employees.reports_to
)
select *
from bosses;
with recursive bosses as (
    -- init
    select id,
        name,
        reports_to,
        1 as depth
    from employees
    where id = 1
    union
    -- recursive
    select employees.id,
        employees.name,
        employees.reports_to,
        depth + 1
    from employees
        inner join bosses on bosses.id = employees.reports_to
    where depth < 3
)
select *
from bosses;
with recursive bosses as (
    -- init
    select id,
        name,
        reports_to,
        1 as depth
    from employees
    where id = 1
    union
    -- recursive
    select employees.id,
        employees.name,
        employees.reports_to,
        depth + 1
    from employees
        inner join bosses on bosses.id = employees.reports_to
    where depth < 3
)
select bosses.*,
    employees.name as reports_to_name
from bosses
    left join employees on employees.id = bosses.reports_to
order by depth;