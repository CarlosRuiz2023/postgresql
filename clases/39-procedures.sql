-- Funciones o Procedimientos Almacenados
select *
from countries;
create or replace function Suma(num1 int, num2 integer) returns integer as $$
select num1 + num2;
$$ language sql;
create function BuscarSalario(varchar) returns Integer as $$
select region_id
from countries
where country_name = $1 $$ language sql;
select Suma(50, 150);
select BuscarSalario('Argentina');
create function InsertarPersonas() returns void as $$
insert into countries_bk
values('AR', 'Prueba', 1);
insert into countries_bk
values('AR', 'Prueba1', 2);
$$ language sql;
select insertarpersonas();
create function buscarinfo (varchar) returns countries as $$
select *
from countries
where country_id = $1 $$ language sql;
select buscarinfo('AU');
-- roolbacks y commits dentro de procedures
create or replace procedure insert_region_proc(int, varchar) as $$ begin
insert into regions(region_id, region_name)
values($1, $2);
raise notice 'Variable 1: %, %',
$1,
$2;
-- rollback;
commit;
end;
$$ language plpgsql;
call insert_region_proc(5, 'Central America');
-- ULTIMO EJEMPLO
create or replace procedure controlled_raise (percentage numeric) as $$
declare real_percentage numeric(8, 2);
total_employees int;
begin real_percentage = percentage / 100;
--5% = 0.05;
-- Mantener el historico
insert into raise_history(
        date,
        employee_id,
        base_salary,
        amount,
        percentage
    )
select CURRENT_DATE as "date",
    employee_id,
    salary,
    max_raise(employee_id) * real_percentage as amount,
    percentage
from employees;
-- Impactar la tabla de empleados
update employees
set salary = max_raise(employee_id) * real_percentage + salary;
commit;
select count(*) into total_employees
from employees;
raise notice 'Afectados % empleados',
total_employees;
end;
$$ language plpgsql;