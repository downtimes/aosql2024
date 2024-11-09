-- Solution with sub queries
SELECT city
FROM (
    SELECT 
        city, 
        SUM(naughty_nice_score) AS nn,
        ROW_NUMBER() OVER (PARTITION BY country ORDER BY SUM(naughty_nice_score)) AS rn
    FROM Children
    WHERE child_id IN (
         SELECT child_id 
         FROM Christmaslist
    )
    GROUP BY city
    HAVING COUNT(city) >= 5 
)
WHERE rn <= 3
ORDER BY nn DESC;

-- Solution with CTE
WITH Preprocessed AS (
    SELECT 
        city,
        SUM(naughty_nice_score) AS nn,
        ROW_NUMBER() OVER (PARTITION BY country ORDER BY SUM(naughty_nice_score)) AS rn
    FROM Children c
    INNER JOIN Christmaslist l ON c.child_id == l.child_id
    GROUP BY city
    HAVING COUNT(city) >= 5 
)
SELECT city
FROM Preprocessed
WHERE rn <= 3
ORDER BY nn DESC;
