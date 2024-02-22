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