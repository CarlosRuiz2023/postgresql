-- Triggers (Disparadores)
select *
from countries;
select *
from "countries_bk";
create function SP_Test() returns Trigger as $$ begin
insert into countries_bk
values (old.country_id, old.country_name, old.region_id);
return new;
end $$ language plpgsql;
create trigger TR_Update before
update on countries for each row execute procedure SP_Test();
create or replace function greet_employee(employee_name varchar) returns varchar as $$ -- Declare
    begin return 'Hola ' || employee_name;
end;
$$ language plpgsql;
select first_name,
    greet_employee(first_name)
from employees;
create or replace function max_raise(empl_id int) returns numeric(8, 2) as $$
declare possible_raise numeric(8, 2);
begin
select max_salary - salary into possible_raise
from employees
    inner join jobs on jobs.job_id = employees.job_id
where employee_id = empl_id;
return possible_raise;
end;
$$ language plpgsql;
create or replace function max_raise_2(empl_id int) returns numeric(8, 2) as $$
declare possible_raise numeric(8, 2);
employee_job_id int;
current_salary numeric(8, 2);
job_max_salary numeric(8, 2);
begin -- Tomar el puesto de trabajo y el salario
select job_id,
    salary into employee_job_id,
    current_salary
from employees
where employee_id = empl_id;
-- Tomar el max salary, acorde a su job
select max_salary into job_max_salary
from jobs
where job_id = employee_job_id;
-- Calculos
possible_raise = job_max_salary - current_salary;
return possible_raise;
end;
$$ language plpgsql;
-- funcion con ifs
create or replace function max_raise_2(empl_id int) returns numeric(8, 2) as $$
declare possible_raise numeric(8, 2);
employee_job_id int;
current_salary numeric(8, 2);
job_max_salary numeric(8, 2);
begin -- Tomar el puesto de trabajo y el salario
select job_id,
    salary into employee_job_id,
    current_salary
from employees
where employee_id = empl_id;
-- Tomar el max salary, acorde a su job
select max_salary into job_max_salary
from jobs
where job_id = employee_job_id;
-- Calculos
possible_raise = job_max_salary - current_salary;
if (possible_raise < 0) THEN raise exception 'Persona con salario mayor max_salary: %',
empl_id;
possible_raise = 0;
end if;
return possible_raise;
end;
$$ language plpgsql;
-- Uso de rowTypes
create or replace function max_raise_2(empl_id int) returns numeric(8, 2) as $$
declare possible_raise numeric(8, 2);
selected_employee employees %rowtype;
selected_job jobs %rowtype;
begin -- Tomar el puesto de trabajo y el salario
select *
from employees into selected_employee
where employee_id = empl_id;
-- Tomar el max salary, acorde a su job
select *
from jobs into selected_job
where job_id = selected_employee.job_id;
-- Calculos
possible_raise = selected_job.max_salary - selected_employee.salary;
if (possible_raise < 0) THEN raise exception 'Persona con salario mayor max_salary: id:%, %',
selected_employee.employee_id,
selected_employee.first_name;
-- possible_raise = 0;
end if;
return possible_raise;
end;
$$ language plpgsql;
-- regresando una tabla
create or replace function country_region() returns table (
        id character(2),
        name varchar(40),
        region varchar(25)
    ) as $$ begin return query
select country_id,
    country_name,
    region_name
from countries
    inner join regions on countries.region_id = regions.region_id;
end;
$$ language plpgsql;
-- logs de sesiones
create or replace function create_session_log() returns trigger as $$ begin
insert into "session" (user_id, last_login)
values (new.id, now());
return new;
end;
$$ language plpgsql;
create or replace trigger create_session_trigger
after
update on "user" for each row execute procedure create_session_log();
call user_login('Melissa', '123456');
-- trigger q se activa solo si cambia cierto valor de la tabla
create or replace trigger create_session_trigger
after
update on "user" for each row
    when (
        old.last_login is distinct
        from new.last_login
    ) execute procedure create_session_log();