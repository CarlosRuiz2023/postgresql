select --json_agg(comment_id)
    /*json_build_object(
     'user',
     "comments".user_id,
     'comment',
     "comments"."content"
     )*/
    json_agg(
        json_build_object(
            'user',
            "comments".user_id,
            'comment',
            "comments"."content"
        )
    )
from comments
where comment_parent_id = 1;
create or replace function comment_replies(id integer) returns json as $$
declare result json;
begin
select json_agg(
        json_build_object(
            'user',
            "comments".user_id,
            'comment',
            "comments"."content"
        )
    ) into result
from comments
where comment_parent_id = id;
return result;
end;
$$ language plpgsql;
select a.*,
    comment_replies(a.post_id) as replies
from comments a
where comment_parent_id is null;