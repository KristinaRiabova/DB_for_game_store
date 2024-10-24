DELIMITER $$


CREATE PROCEDURE AddGame(
    IN p_title VARCHAR(255),
    IN p_release_year INT,
    IN p_category_id INT
)
BEGIN
    INSERT INTO games (title, release_year, category_id) 
    VALUES (p_title, p_release_year, p_category_id);
END$$

DELIMITER ;
