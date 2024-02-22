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