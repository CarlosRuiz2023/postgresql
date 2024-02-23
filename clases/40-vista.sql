-- Vista
create view View_datafrompersona as
select country_id,
    country_name
from countries;
create or replace view comments_per_week as
select date_trunc('week', posts.created_at) as weeks,
    count(distinct posts.post_id) as number_of_posts,
    sum(claps.counter) as total_claps,
    count(*) as number_of_clap
from posts
    inner join claps on claps.post_id = posts.post_id
group by weeks
order by weeks desc;
create materialized view comments_per_week_mat as
select date_trunc('week', posts.created_at) as weeks,
    count(distinct posts.post_id) as number_of_posts,
    sum(claps.counter) as total_claps,
    count(*) as number_of_clap
from posts
    inner join claps on claps.post_id = posts.post_id
group by weeks
order by weeks desc;
refresh materialized view comments_per_week_mat;
alter view comments_per_week
rename to posts_per_week;
alter materialized view comments_per_week_mat
rename to posts_per_week_mat;