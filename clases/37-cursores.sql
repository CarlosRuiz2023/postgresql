-- Cursores 
do $$
declare registro Record;
Cur_precios Cursor for
select *
from countries
order by country_name asc;
begin Open Cur_precios;
Fetch Cur_precios into registro;
Raise Notice 'Pais: %, Region: %',
registro.country_name,
registro.region_id;
Fetch Cur_precios into registro;
Raise Notice 'Pais: %, Region: %',
registro.country_name,
registro.region_id;
end $$ language plpgsql;
-- Cursores con while
do $$
declare registro Record;
Cur_precios Cursor for
select *
from countries
order by country_name asc;
begin Open Cur_precios;
Fetch Cur_precios into registro;
while(FOUND) loop Raise Notice 'Pais: %, Region: %',
registro.country_name,
registro.region_id;
Fetch Cur_precios into registro;
end loop;
end $$ language plpgsql;
-- Cursores con for
do $$
declare registro Record;
Cur_precios Cursor for
select *
from countries
order by country_name asc;
begin for registro in Cur_precios loop Raise Notice 'Pais: %, Region: %',
registro.country_name,
registro.region_id;
end loop;
end $$ language plpgsql;