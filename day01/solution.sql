-- Learned how to query with json data.
-- Learned how to do conditional logic.
SELECT 
    name, 
    w.wishes ->> 'first_choice' as primary_wish, 
    w.wishes ->> 'second_choice' as backup_wish, 
    -- Unclear if the next 2 fields are needed or not??
    w.wishes ->> '$.colors[0]' as favorite_color,
    json_array_length(w.wishes, '$.colors') as color_count,
    CASE 
        WHEN t.difficulty_to_make == 1 THEN 'Simple Gift'
        WHEN t.difficulty_to_make == 2 THEN 'Moderate Gift'
        WHEN t.difficulty_to_make >= 3 THEN 'Complex Gift' 
    END AS gift_complexity,
    CASE t.category
        WHEN 'outdoor' THEN 'Outside Workshop'
        WHEN 'educational' THEN 'Learning Workshop'
        ELSE 'General Workshop'
    END AS workshop_assignment
FROM children c
-- Unclear if each child should only be allowed one wish_list, but which one??
-- In my input I have 2 children named Abbey with 2 whish_lists each.
INNER JOIN wish_lists w ON c.child_id == w.child_id
INNER JOIN toy_catalogue t ON w.wishes ->> 'first_choice' == t.toy_name
ORDER BY name ASC
LIMIT 5;