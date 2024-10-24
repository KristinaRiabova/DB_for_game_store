DELIMITER $$

CREATE TRIGGER after_review_insert
AFTER INSERT ON reviews
FOR EACH ROW
BEGIN
    UPDATE reviews
    SET review_text = CONCAT(NEW.review_text, ' - updated')
    WHERE review_id = NEW.review_id;
END$$

DELIMITER ;
