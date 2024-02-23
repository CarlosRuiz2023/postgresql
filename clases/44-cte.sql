-- Common table expression
with posts_week_2024 as (
    SELECT date_trunc('week'::text, posts.created_at) AS weeks,
        count(DISTINCT posts.post_id) AS number_of_posts,
        sum(claps.counter) AS total_claps,
        count(*) AS number_of_clap
    FROM (
            posts
            JOIN claps ON ((claps.post_id = posts.post_id))
        )
    GROUP BY (date_trunc('week'::text, posts.created_at))
    ORDER BY (date_trunc('week'::text, posts.created_at)) DESC
)
select *
from posts_week_2024
where weeks between '2024-01-01' and '2024-12-31'
    and total_claps >= 600;
with claps_per_post as(
    select post_id,
        sum(counter)
    from claps
    group by post_id
),
posts_from_2023 as (
    select *
    from posts
    where created_at between '2023-01-01' and '2023-12-31'
)
select *
from claps_per_post
where claps_per_post.post_id in (
        select post_id
        from posts_from_2023
    );