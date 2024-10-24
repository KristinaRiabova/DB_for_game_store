
-- Таблица игроков
CREATE TABLE IF NOT EXISTS Players (
    player_id VARCHAR(36) PRIMARY KEY,
    nickname VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN DEFAULT TRUE
) COMMENT 'Содержит информацию об игроках';

-- Таблица игр
CREATE TABLE IF NOT EXISTS Games (
    game_id VARCHAR(36) PRIMARY KEY,
    game_name VARCHAR(100) NOT NULL UNIQUE,
    genre VARCHAR(50) NOT NULL,
    release_year INT CHECK (release_year >= 1980 AND release_year <= YEAR(CURRENT_DATE)),
    description TEXT
) COMMENT 'Список доступных игр';

-- Таблица турниров
CREATE TABLE IF NOT EXISTS Tournaments (
    tournament_id VARCHAR(36) PRIMARY KEY,
    tournament_name VARCHAR(100) NOT NULL UNIQUE,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    prize_pool DECIMAL(10, 2) NOT NULL CHECK (prize_pool > 0)
) COMMENT 'Информация о турнирах';

-- Таблица игровых сессий
CREATE TABLE IF NOT EXISTS Game_Sessions (
    session_id VARCHAR(36) PRIMARY KEY,
    game_id VARCHAR(36),
    session_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    duration_minutes INT NOT NULL,
    FOREIGN KEY (game_id) REFERENCES Games (game_id) ON DELETE CASCADE
) COMMENT 'Записывает данные о проведенных игровых сессиях';

-- Таблица many-to-many для игроков и игровых сессий
CREATE TABLE IF NOT EXISTS Player_Sessions (
    player_id VARCHAR(36),
    session_id VARCHAR(36),
    score INT NOT NULL CHECK (score >= 0),
    PRIMARY KEY (player_id, session_id),
    FOREIGN KEY (player_id) REFERENCES Players (player_id) ON DELETE CASCADE,
    FOREIGN KEY (session_id) REFERENCES Game_Sessions (session_id) ON DELETE CASCADE
) COMMENT 'Связывает игроков с игровыми сессиями и хранит их очки';

-- Таблица игр в турнире (many-to-many)
CREATE TABLE IF NOT EXISTS Tournament_Games (
    tournament_id VARCHAR(36),
    game_id VARCHAR(36),
    PRIMARY KEY (tournament_id, game_id),
    FOREIGN KEY (tournament_id) REFERENCES Tournaments (tournament_id) ON DELETE CASCADE,
    FOREIGN KEY (game_id) REFERENCES Games (game_id) ON DELETE CASCADE
) COMMENT 'Связывает турниры с играми';
