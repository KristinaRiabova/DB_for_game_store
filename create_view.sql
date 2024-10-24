
CREATE VIEW game_ratings AS
SELECT 
    g.title AS game_title,
    c.category_name,
    AVG(r.rating) AS average_rating
FROM 
    games g
LEFT JOIN 
    reviews r ON g.game_id = r.game_id
JOIN 
    categories c ON g.category_id = c.category_id
GROUP BY 
    g.title, c.category_name;
