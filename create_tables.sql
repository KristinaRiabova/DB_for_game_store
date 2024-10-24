



CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique ID for each category',
    category_name VARCHAR(50) NOT NULL UNIQUE COMMENT 'Category name'
);


CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique ID for each user',
    username VARCHAR(50) NOT NULL UNIQUE COMMENT 'Username',
    email VARCHAR(100) NOT NULL UNIQUE COMMENT 'User email',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'User creation date'
);


CREATE INDEX idx_user_email ON users(email);


CREATE TABLE games (
    game_id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique ID for each game',
    title VARCHAR(255) NOT NULL UNIQUE COMMENT 'Game title',
    release_year INT COMMENT 'Game release year',
    category_id INT COMMENT 'Category ID of the game',
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);


CREATE INDEX idx_game_title ON games(title);


CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique ID for each order',
    user_id INT COMMENT 'User who made the order',
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Order date',
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique ID for each review',
    game_id INT COMMENT 'Game ID for the review',
    user_id INT COMMENT 'User who wrote the review',
    rating INT CHECK (rating BETWEEN 1 AND 5) COMMENT 'Rating from 1 to 5',
    review_text TEXT COMMENT 'Text of the review',
    FOREIGN KEY (game_id) REFERENCES games(game_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


CREATE TABLE game_categories (
    game_id INT COMMENT 'Game ID',
    category_id INT COMMENT 'Category ID',
    PRIMARY KEY (game_id, category_id),
    FOREIGN KEY (game_id) REFERENCES games(game_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);


CREATE INDEX idx_game_category ON games(category_id);
