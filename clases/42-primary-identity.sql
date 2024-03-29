create table "users"(
    "user_id" serial primary key,
    "username" varchar
);
create table "users2"(
    "user_id" integer generated by default as IDENTITY primary key,
    "username" varchar
);
create table "users3"(
    "user_id" integer generated always as IDENTITY primary key,
    "username" varchar
);
create table "users4"(
    "user_id" integer generated always as IDENTITY (start with 100 INCREMENT by 2),
    "username" varchar
);
-- Llave compuesta
create table usersDual (id1 int, id2 int, primary key (id1, id2));
-- Llaves uuid
select gen_random_uuid();
create extension if not exists "uuid-ossp";
drop extension "uuid-ossp";