-- Secuencias
create sequence sec_Indice start with 1 increment by 20 minvalue 1 maxvalue 100 cycle;
alter sequence sec_Indice start with 10 increment by 30 minvalue 10 maxvalue 200 restart 10 no cycle;
drop sequence sec_indice;
select *
from sec_Indice;
select nextval('sec_indice');
select currval('user_sequence'),
    nextval('user_sequence'),
    currval('user_sequence');
create table users6 (
    "user_id" INTEGER PRIMARY KEY default nextval('user_sequence'),
    "username" varchar
);