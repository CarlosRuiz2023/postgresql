create extension pgcrypto;
insert into "user" (username, password)
values('Melissa', crypt('123456', gen_salt('bf')));
select count(*)
from "user"
where username = 'Charly'
    and password = crypt('123456', password);
create or replace procedure user_login(user_name varchar, user_password varchar) as $$
declare was_found boolean;
begin
select count(*) into was_found
from "user"
where username = user_name
    and password = crypt(user_password, password);
if(was_found = false) THEN
insert into session_failed (username, "when")
values(user_name, now());
commit;
raise exception 'Usuario y contraseña no son correctos';
end if;
update "user"
set last_login = now()
where username = user_name;
commit;
raise notice 'Usuario encontrado %',
was_found;
end;
$$ language plpgsql;
call user_login('Charly', '123456 ');