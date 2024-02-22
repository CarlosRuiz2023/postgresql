do $$ begin if EXISTS(
    select country_name
    from countries
    where country_name = 'Argentina'
) THEN Raise Notice 'El pais ha sido encontrado';
ELSE Raise Notice 'El pais no ha sido encontrado';
end if;
end $$