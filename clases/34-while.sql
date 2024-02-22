do $$
declare x int := (
        SELECT count(*)
        from countries
    );
y int := 0;
begin while(y < x) Loop Raise Notice 'Tecnobinaria, vuelta # %',
y;
y := y + 1;
end loop;
end $$