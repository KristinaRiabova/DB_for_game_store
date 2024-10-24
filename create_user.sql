

CREATE USER 'admin_user'@'localhost' IDENTIFIED BY '123';
GRANT ALL PRIVILEGES ON *.* TO 'admin_user'@'localhost';


CREATE USER 'game_manager'@'localhost' IDENTIFIED BY '123';
GRANT SELECT, INSERT, UPDATE, DELETE ON games TO 'game_manager'@'localhost';


CREATE USER 'regular_user'@'localhost' IDENTIFIED BY '123';
GRANT SELECT ON games TO 'regular_user'@'localhost';
