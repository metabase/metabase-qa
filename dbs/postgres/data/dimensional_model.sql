drop schema if exists soccer cascade;
create schema soccer;

CREATE TABLE soccer.dim_nationality (
    nationality_id SERIAL PRIMARY KEY,
    nationality_name VARCHAR(50)
);

-- Add comments for the table and column
COMMENT ON TABLE soccer.dim_nationality IS 'Dimension table for player nationalities';
COMMENT ON COLUMN soccer.dim_nationality.nationality_id IS 'Unique identifier for each player nationality';
COMMENT ON COLUMN soccer.dim_nationality.nationality_name IS 'Name of the player nationality';

-- Insert sample data
INSERT INTO soccer.dim_nationality (nationality_name)
VALUES
    ('Argentinian'),
    ('Brazilian'),
    ('German'),
    ('Spanish'),
    ('French'),
    ('Italian'),
    ('Portuguese'),
    ('Uruguayan'),
    ('Dutch'),
    ('English'),
    ('Chilean'),
    ('Colombian'),
    ('Mexican'),
    ('Japanese'),
    ('Swedish'),
    ('Russian'),
    ('Croatian'),
    ('Austrian'),
    ('Greek'),
    ('Belgian'),
    ('Turkish'),
    ('Uzbekistani'),
    ('American'),
    ('Costa Rican'),
    ('Iranian'),
    ('Algerian');

CREATE TABLE soccer.dim_referee
(
    referee_id   SERIAL PRIMARY KEY,
    referee_name VARCHAR(50),
    nationality_id INT REFERENCES soccer.dim_nationality(nationality_id)
);

COMMENT ON COLUMN soccer.dim_referee.referee_id IS 'Unique identifier for each referee';
COMMENT ON COLUMN soccer.dim_referee.referee_name IS 'Name of the referee';
COMMENT ON COLUMN soccer.dim_referee.nationality_id IS 'Nationality id of the referee';
COMMENT ON TABLE soccer.dim_referee IS 'Dimension with the list of referees';

INSERT INTO soccer.dim_referee (referee_id, referee_name, nationality_id)
VALUES (1, 'Howard Webb', 10),
       (2, 'Néstor Pitana', 1),
       (3, 'Felix Brych', 3),
       (4, 'Bjorn Kuipers', 9),
       (5, 'Cüneyt Çakır', 21),
       (6, 'Ravshan Irmatov', 22),
       (7, 'Ricardo Montero', 24),
       (8, 'Ravshan Irmatov', 22),
       (9, 'Bobby Madley', 10),
       (10, 'Mark Geiger', 23),
       (11, 'Sandro Ricci', 2),
       (12, 'Ravshan Irmatov', 22),
       (13, 'Wilmar Roldán', 12),
       (14, 'Félix Zwayer', 3),
       (15, 'Sergei Karasev', 16),
       (16, 'Daniele Orsato', 6),
       (17, 'Alireza Faghani', 25),
       (18, 'Mark Clattenburg', 10),
       (19, 'Djamel Haimoudi', 26),
       (20, 'Jonas Eriksson', 15);

CREATE TABLE soccer.dim_coach
(
    coach_id    SERIAL PRIMARY KEY,
    coach_name  VARCHAR(50),
    nationality_id INT REFERENCES soccer.dim_nationality(nationality_id)
);

COMMENT ON COLUMN soccer.dim_coach.coach_id IS 'Unique identifier for each coach';
COMMENT ON COLUMN soccer.dim_coach.coach_name IS 'Name of the coach';
COMMENT ON COLUMN soccer.dim_coach.nationality_id IS 'Nationality of the coach';
COMMENT ON TABLE soccer.dim_coach IS 'Dimension with the list of coaches';

INSERT INTO soccer.dim_coach (coach_name, nationality_id)
VALUES ('Lionel Scaloni', 1),
       ('Tite', 2),
       ('Joachim Löw', 3),
       ('Didier Deschamps', 5),
       ('Roberto Mancini', 6),
       ('Fernando Santos', 7),
       ('Óscar Tabárez', 8),
       ('Frank de Boer', 9),
       ('Gareth Southgate', 10),
       ('Roberto Martínez', 20),
       ('Reinaldo Rueda', 11),
       ('Carlos Queiroz', 7),
       ('Gerardo Martino', 1),
       ('Akira Nishino', 14),
       ('Fernando Batista', 1),
       ('Janne Andersson', 15),
       ('Stanislav Cherchesov', 16),
       ('Zlatko Dalić', 17),
       ('Franco Foda', 18),
       ('John van den Brom', 9);

CREATE TABLE soccer.dim_player_position (
    position_id SERIAL PRIMARY KEY,
    position_name VARCHAR(50)
);

-- Add comments for the table and column
COMMENT ON TABLE soccer.dim_player_position IS 'Dimension table for player positions';
COMMENT ON COLUMN soccer.dim_player_position.position_id IS 'Unique identifier for each player position';
COMMENT ON COLUMN soccer.dim_player_position.position_name IS 'Name of the player position';

-- Insert sample data
INSERT INTO soccer.dim_player_position (position_name)
VALUES
    ('Forward'),
    ('Goalkeeper'),
    ('Defender'),
    ('Midfielder');

CREATE TABLE soccer.dim_player
(
    player_id   SERIAL PRIMARY KEY,
    player_name VARCHAR(50),
    position_id    INT REFERENCES soccer.dim_player_position(position_id),
    nationality_id INT REFERENCES soccer.dim_nationality(nationality_id),
    birth_date  DATE,
    height      DECIMAL(5, 2),
    weight      DECIMAL(5, 2)
);

COMMENT ON COLUMN soccer.dim_player.player_id IS 'Unique identifier for each player';
COMMENT ON COLUMN soccer.dim_player.player_name IS 'Name of the player';
COMMENT ON COLUMN soccer.dim_player.position_id IS 'Position ID of the player on the field';
COMMENT ON COLUMN soccer.dim_player.nationality_id IS 'Key to the nationality of the player';
COMMENT ON COLUMN soccer.dim_player.birth_date IS 'Date of birth of the player';
COMMENT ON COLUMN soccer.dim_player.height IS 'Height of the player in meters';
COMMENT ON COLUMN soccer.dim_player.weight IS 'Weight of the player in kilograms';
COMMENT ON TABLE soccer.dim_player IS 'Dimension with the list of players';

INSERT INTO soccer.dim_player (player_name, position_id, nationality_id, birth_date, height, weight)
VALUES ('Lionel Messi', 1, 1, '1987-06-24', 1.70, 72.0),
       ('Neymar Jr.', 1, 2, '1992-02-05', 1.75, 68.0),
       ('Manuel Neuer', 2, 3, '1986-03-27', 1.93, 92.0),
       ('Sergio Ramos', 3, 4, '1986-03-30', 1.84, 75.0),
       ('Kylian Mbappé', 1, 5, '1998-12-20', 1.78, 73.0),
       ('Giorgio Chiellini', 3, 6, '1984-08-14', 1.87, 85.0),
       ('Cristiano Ronaldo', 1, 7, '1985-02-05', 1.87, 83.0),
       ('Luis Suárez', 1, 8, '1987-01-24', 1.82, 86.0),
       ('Virgil van Dijk', 3, 9, '1991-07-08', 1.93, 92.0),
       ('Harry Kane', 1, 10, '1993-07-28', 1.88, 86.0),
       ('Arturo Vidal', 4, 11, '1987-05-22', 1.80, 74.0),
       ('James Rodríguez', 4, 12, '1991-07-12', 1.80, 75.0),
       ('Hirving Lozano', 1, 13, '1995-07-30', 1.75, 70.0),
       ('Shinji Kagawa', 4, 14, '1989-03-17', 1.75, 68.0),
       ('Giovanni Simeone', 1, 1, '1995-07-05', 1.85, 80.0),
       ('Zlatan Ibrahimović', 1, 15, '1981-10-03', 1.95, 95.0),
       ('Aleksandr Golovin', 4, 16, '1996-05-30', 1.80, 75.0),
       ('Luka Modrić', 4, 17, '1985-09-09', 1.72, 66.0),
       ('David Alaba', 3, 18, '1992-06-24', 1.84, 76.0),
       ('Georgios Samaras', 1, 19, '1985-02-21', 1.91, 82.0);

CREATE TABLE soccer.dim_team
(
    team_id      SERIAL PRIMARY KEY,
    team_name    VARCHAR(50),
    coach_id     INT REFERENCES soccer.dim_coach(coach_id),
    home_stadium VARCHAR(50),
    founded_year INT,
    player_id    INT REFERENCES soccer.dim_player(player_id)
);

COMMENT ON COLUMN soccer.dim_team.team_id IS 'Unique identifier for each team';
COMMENT ON COLUMN soccer.dim_team.team_name IS 'Name of the team';
COMMENT ON COLUMN soccer.dim_team.coach_id IS 'ID of the team coach';
COMMENT ON COLUMN soccer.dim_team.home_stadium IS 'Name of the team''s home stadium';
COMMENT ON COLUMN soccer.dim_team.founded_year IS 'Year the team was founded';
COMMENT ON COLUMN soccer.dim_team.player_id IS 'ID of a player in the team';
COMMENT ON TABLE soccer.dim_team IS 'Dimension with the list of teams';

INSERT INTO soccer.dim_team (team_name, coach_id, home_stadium, founded_year, player_id)
VALUES ('Argentina', 1, 'Estadio Monumental', 1914, 1),
       ('Brazil', 2, 'Maracanã Stadium', 1914, 2),
       ('Germany', 3, 'Allianz Arena', 1900, 3),
       ('Spain', 4, 'Camp Nou', 1900, 4),
       ('France', 5, 'Stade de France', 1900, 5),
       ('Italy', 6, 'San Siro', 1900, 6),
       ('Portugal', 7, 'Estádio da Luz', 1900, 7),
       ('Uruguay', 8, 'Estadio Centenario', 1900,8 ),
       ('Netherlands', 9, 'Johan Cruyff Arena', 1900, 9),
       ('England', 10, 'Wembley Stadium', 1900, 10),
       ('Chile', 11, 'Estadio Nacional', 1900, 11),
       ('Colombia', 12, 'Estadio Metropolitano', 1900, 12),
       ('Mexico', 13, 'Estadio Azteca', 1900, 13),
       ('Japan', 14, 'Saitama Stadium', 1900, 14),
       ('Argentina U-20', 15, 'Estadio Malvinas Argentinas', 1900, 15),
       ('Sweden', 16, 'Friends Arena', 1900, 16),
       ('Russia', 17, 'Luzhniki Stadium', 1900, 17),
       ('Croatia', 18, 'Stadion Maksimir', 1900, 18),
       ('Austria', 19, 'Ernst Happel Stadion', 1900, 19),
       ('Greece', 20, 'Olympic Stadium', 1900, 20);

CREATE TABLE soccer.dim_opponent_team
(
    opponent_id SERIAL PRIMARY KEY,
    team_name   VARCHAR(50),
    country     VARCHAR(50),
    continent   VARCHAR(50)
);

COMMENT ON COLUMN soccer.dim_opponent_team.opponent_id IS 'Unique identifier for each opponent team';
COMMENT ON COLUMN soccer.dim_opponent_team.team_name IS 'Name of the opponent team';
COMMENT ON COLUMN soccer.dim_opponent_team.country IS 'Country of the opponent team';
COMMENT ON COLUMN soccer.dim_opponent_team.continent IS 'Continent of the opponent team';
COMMENT ON TABLE soccer.dim_opponent_team IS 'Dimension with the list of opponent teams';

INSERT INTO soccer.dim_opponent_team (team_name, country, continent)
VALUES ('Brazil', 'Brazil', 'South America'),
       ('Germany', 'Germany', 'Europe'),
       ('Spain', 'Spain', 'Europe'),
       ('France', 'France', 'Europe'),
       ('Italy', 'Italy', 'Europe'),
       ('Portugal', 'Portugal', 'Europe'),
       ('Uruguay', 'Uruguay', 'South America'),
       ('Netherlands', 'Netherlands', 'Europe'),
       ('England', 'England', 'Europe'),
       ('Belgium', 'Belgium', 'Europe'),
       ('Chile', 'Chile', 'South America'),
       ('Colombia', 'Colombia', 'South America'),
       ('Mexico', 'Mexico', 'North America'),
       ('Japan', 'Japan', 'Asia'),
       ('Argentina U-20', 'Argentina', 'South America'),
       ('Sweden', 'Sweden', 'Europe'),
       ('Russia', 'Russia', 'Europe'),
       ('Croatia', 'Croatia', 'Europe'),
       ('Austria', 'Austria', 'Europe'),
       ('Greece', 'Greece', 'Europe');

CREATE TABLE soccer.dim_match_venue_type (
    venue_type_id SERIAL PRIMARY KEY,
    venue_type_description VARCHAR(50)
);

COMMENT ON COLUMN soccer.dim_match_venue_type.venue_type_id IS 'Unique identifier for each venue type';
COMMENT ON COLUMN soccer.dim_match_venue_type.venue_type_description IS 'Description of the venue type (Stadium, Arena, etc.)';
COMMENT ON TABLE soccer.dim_match_venue_type IS 'Dimension with the list of venues';

INSERT INTO soccer.dim_match_venue_type (venue_type_description)
VALUES
    ('Stadium'),
    ('Arena'),
    ('Field'),
    ('Park'),
    ('Coliseum'),
    ('Ground');

CREATE TABLE soccer.dim_venue
(
    venue_id   SERIAL PRIMARY KEY,
    venue_name VARCHAR(50),
    city       VARCHAR(50),
    capacity   INT,
    venue_type_id INT REFERENCES soccer.dim_match_venue_type(venue_type_id)
);

COMMENT ON COLUMN soccer.dim_venue.venue_id IS 'Unique identifier for each venue';
COMMENT ON COLUMN soccer.dim_venue.venue_name IS 'Name of the venue';
COMMENT ON COLUMN soccer.dim_venue.city IS 'City where the venue is located';
COMMENT ON COLUMN soccer.dim_venue.capacity IS 'Seating capacity of the venue';
COMMENT ON COLUMN soccer.dim_venue.venue_type_id IS 'Venue type';
COMMENT ON TABLE soccer.dim_venue IS 'Dimension with the list of venues';

INSERT INTO soccer.dim_venue (venue_name, city, capacity, venue_type_id)
VALUES ('Estadio Monumental', 'Buenos Aires', 67014, 1),
       ('Maracanã Stadium', 'Rio de Janeiro', 78838, 1),
       ('Wembley Stadium', 'London', 90000, 1),
       ('Camp Nou', 'Barcelona', 99354, 1),
       ('San Siro', 'Milan', 80018, 3),
       ('Allianz Arena', 'Munich', 75000, 2),
       ('Santiago Bernabéu', 'Madrid', 81044, 1),
       ('Old Trafford', 'Manchester', 74691, 1),
       ('Stade de France', 'Saint-Denis', 81338, 1),
       ('Stadio Olimpico', 'Rome', 72698, 1),
       ('Estadio Azteca', 'Mexico City', 87107, 1),
       ('Nissan Stadium', 'Yokohama', 72327, 1),
       ('MetLife Stadium', 'East Rutherford', 82500, 1),
       ('Estadio Nacional', 'Santiago', 48655, 1),
       ('Arena Amazonia', 'Manaus', 44990, 2),
       ('Friends Arena', 'Solna', 50000, 2),
       ('Luzhniki Stadium', 'Moscow', 81000, 1),
       ('Stadion Maksimir', 'Zagreb', 35838, 1),
       ('Ernst Happel Stadion', 'Vienna', 50884, 1),
       ('Olympic Stadium', 'Athens', 69764, 1);

CREATE TABLE soccer.dim_match_outcome
(
    outcome_id          SERIAL PRIMARY KEY,
    outcome_description VARCHAR(20)
);

COMMENT ON COLUMN soccer.dim_match_outcome.outcome_id IS 'Unique identifier for each match outcome';
COMMENT ON COLUMN soccer.dim_match_outcome.outcome_description IS 'Description of the match outcome (Win, Loss, Draw)';
COMMENT ON TABLE soccer.dim_match_outcome IS 'Dimension with the list of outcomes';

INSERT INTO soccer.dim_match_outcome (outcome_id, outcome_description)
VALUES (1, 'Win'),
       (2, 'Draw'),
       (3, 'Loss');

CREATE TABLE soccer.dim_weather_condition
(
    weather_id            SERIAL PRIMARY KEY,
    condition_description VARCHAR(20)
);

COMMENT ON COLUMN soccer.dim_weather_condition.weather_id IS 'Unique identifier for each weather condition';
COMMENT ON COLUMN soccer.dim_weather_condition.condition_description IS 'Description of the weather condition during the match';
COMMENT ON TABLE soccer.dim_weather_condition IS 'Dimension with the list of weather conditions';

INSERT INTO soccer.dim_weather_condition (weather_id, condition_description)
VALUES (1, 'Sunny'),
       (2, 'Rainy'),
       (3, 'Cloudy');

CREATE TABLE soccer.dim_match_type
(
    match_type_id          SERIAL PRIMARY KEY,
    match_type_description VARCHAR(20)
);

COMMENT ON COLUMN soccer.dim_match_type.match_type_id IS 'Unique identifier for each match type';
COMMENT ON COLUMN soccer.dim_match_type.match_type_description IS 'Description of the match type (Friendly, Qualifier, etc.)';
COMMENT ON TABLE soccer.dim_match_type IS 'Dimension with the list of match types';

INSERT INTO soccer.dim_match_type (match_type_id, match_type_description)
VALUES (1, 'Friendly'),
       (2, 'World Cup Qualifier'),
       (3, 'Copa America');

CREATE TABLE soccer.dim_match_official (
    official_id SERIAL PRIMARY KEY,
    official_name VARCHAR(50),
    nationality VARCHAR(50)
);

COMMENT ON COLUMN soccer.dim_match_official.official_id IS 'Unique identifier for each match official';
COMMENT ON COLUMN soccer.dim_match_official.official_name IS 'Name of the match official';
COMMENT ON COLUMN soccer.dim_match_official.nationality IS 'Nationality of the match official';
COMMENT ON TABLE soccer.dim_match_official IS 'Dimension with the list of match officials';

INSERT INTO soccer.dim_match_official (official_name, nationality)
VALUES
    ('John Smith', 'English'),
    ('Maria Garcia', 'Spanish'),
    ('Andreas Müller', 'German'),
    ('Elena Petrova', 'Russian'),
    ('José Martinez', 'Argentinian'),
    ('Hiroshi Tanaka', 'Japanese'),
    ('Anna Kowalski', 'Polish'),
    ('Mohammed Ali', 'Egyptian'),
    ('Isabella Silva', 'Brazilian'),
    ('Santiago Fernandez', 'Chilean');

CREATE TABLE soccer.dim_match_attendance_level (
    attendance_level_id SERIAL PRIMARY KEY,
    attendance_level_description VARCHAR(50)
);

COMMENT ON COLUMN soccer.dim_match_attendance_level.attendance_level_id IS 'Unique identifier for each attendance level';
COMMENT ON COLUMN soccer.dim_match_attendance_level.attendance_level_description IS 'Description of the attendance level (Full House, Near Capacity, etc.)';
COMMENT ON TABLE soccer.dim_match_attendance_level IS 'Dimension with the list of attendance levels';

INSERT INTO soccer.dim_match_attendance_level (attendance_level_description)
VALUES
    ('Full House'),
    ('Near Capacity'),
    ('Moderate Attendance'),
    ('Sparse Attendance'),
    ('Low Attendance'),
    ('No Spectators'),
    ('Sold Out'),
    ('Limited Attendance'),
    ('High Attendance'),
    ('Below Average Attendance');

CREATE TABLE soccer.dim_match_outcome_type (
    outcome_type_id SERIAL PRIMARY KEY,
    outcome_type_description VARCHAR(50)
);

COMMENT ON COLUMN soccer.dim_match_outcome_type.outcome_type_id IS 'Unique identifier for each outcome type';
COMMENT ON COLUMN soccer.dim_match_outcome_type.outcome_type_description IS 'Description of the outcome type (Standard Outcome, Extra Time Outcome, etc.)';
COMMENT ON TABLE soccer.dim_match_outcome_type IS 'Dimension with the list of outcomes';

INSERT INTO soccer.dim_match_outcome_type (outcome_type_description)
VALUES
    ('Standard Outcome'),
    ('Extra Time Outcome'),
    ('Penalty Shootout Outcome'),
    ('Abandoned Match'),
    ('Cancelled Match'),
    ('Forfeited Match'),
    ('Incomplete Match'),
    ('Rescheduled Match'),
    ('Walkover Match'),
    ('Tiebreaker Outcome');

CREATE TABLE soccer.dim_match_time_of_day (
    time_of_day_id SERIAL PRIMARY KEY,
    time_of_day_description VARCHAR(50)
);

COMMENT ON COLUMN soccer.dim_match_time_of_day.time_of_day_id IS 'Unique identifier for each time of day';
COMMENT ON COLUMN soccer.dim_match_time_of_day.time_of_day_description IS 'Description of the time of day (Morning, Evening, etc.)';
COMMENT ON TABLE soccer.dim_match_time_of_day IS 'Dimension with the list of times of day';

INSERT INTO soccer.dim_match_time_of_day (time_of_day_description)
VALUES
    ('Morning'),
    ('Afternoon'),
    ('Evening'),
    ('Night'),
    ('Dawn'),
    ('Twilight'),
    ('Late Night'),
    ('Early Morning'),
    ('Midnight'),
    ('Late Afternoon');

CREATE TABLE soccer.dim_match_pitch_condition (
    pitch_condition_id SERIAL PRIMARY KEY,
    pitch_condition_description VARCHAR(50)
);

COMMENT ON COLUMN soccer.dim_match_pitch_condition.pitch_condition_id IS 'Unique identifier for each pitch condition';
COMMENT ON COLUMN soccer.dim_match_pitch_condition.pitch_condition_description IS 'Description of the pitch condition (Excellent, Poor, etc.)';
COMMENT ON TABLE soccer.dim_match_pitch_condition IS 'Dimension with the list of pitch conditions';

INSERT INTO soccer.dim_match_pitch_condition (pitch_condition_description)
VALUES
    ('Excellent'),
    ('Good'),
    ('Fair'),
    ('Poor'),
    ('Waterlogged'),
    ('Muddy'),
    ('Frozen'),
    ('Artificial Turf'),
    ('Dry and Hard'),
    ('Overused');

CREATE TABLE soccer.dim_match_season (
    season_id SERIAL PRIMARY KEY,
    season_name VARCHAR(50)
);

COMMENT ON COLUMN soccer.dim_match_season.season_id IS 'Unique identifier for each season';
COMMENT ON COLUMN soccer.dim_match_season.season_name IS 'Name of the season';
COMMENT ON TABLE soccer.dim_match_season IS 'Dimension with the list of seasons';

INSERT INTO soccer.dim_match_season (season_name)
VALUES
    ('2023/2024'),
    ('2022/2023'),
    ('2021/2022'),
    ('2020/2021'),
    ('2019/2020'),
    ('2018/2019'),
    ('2017/2018'),
    ('2016/2017'),
    ('2015/2016'),
    ('2014/2015');

CREATE TABLE soccer.fact_match_statistics
(
    match_id       SERIAL PRIMARY KEY,
    match_date     DATE,
    team_id        INT REFERENCES soccer.dim_team(team_id),
    opponent_id    INT REFERENCES soccer.dim_opponent_team(opponent_id),
    venue_id       INT REFERENCES soccer.dim_venue(venue_id),
    goals_scored   INT,
    goals_conceded INT,
    result         INT REFERENCES soccer.dim_match_outcome(outcome_id),
    climate        INT REFERENCES soccer.dim_weather_condition(weather_id),
    match_type     INT REFERENCES soccer.dim_match_type(match_type_id),
    referee_id     INT REFERENCES soccer.dim_referee(referee_id),
    season_id      INT REFERENCES soccer.dim_match_season(season_id),
    pitch_condition_id INT REFERENCES soccer.dim_match_pitch_condition(pitch_condition_id),
    time_of_day_id INT REFERENCES soccer.dim_match_time_of_day(time_of_day_id),
    outcome_type_id INT REFERENCES soccer.dim_match_outcome_type(outcome_type_id),
    attendance_level_id INT REFERENCES soccer.dim_match_attendance_level(attendance_level_id),
    official_id INT REFERENCES soccer.dim_match_official(official_id)
);

COMMENT ON COLUMN soccer.fact_match_statistics.match_id IS 'Unique identifier for each match';
COMMENT ON COLUMN soccer.fact_match_statistics.match_date IS 'Date of the match';
COMMENT ON COLUMN soccer.fact_match_statistics.team_id IS 'ID of the team (Argentina)';
COMMENT ON COLUMN soccer.fact_match_statistics.opponent_id IS 'ID of the opponent team';
COMMENT ON COLUMN soccer.fact_match_statistics.venue_id IS 'ID of the match venue';
COMMENT ON COLUMN soccer.fact_match_statistics.goals_scored IS 'Number of goals scored';
COMMENT ON COLUMN soccer.fact_match_statistics.goals_conceded IS 'Number of goals conceded';
COMMENT ON COLUMN soccer.fact_match_statistics.result IS 'Match result (Win, Loss, Draw)';
COMMENT ON COLUMN soccer.fact_match_statistics.climate IS 'Weather condition during the match';
COMMENT ON COLUMN soccer.fact_match_statistics.match_type IS 'Type of the match';
COMMENT ON COLUMN soccer.fact_match_statistics.referee_id IS 'ID of the match referee';
COMMENT ON COLUMN soccer.fact_match_statistics.season_id IS 'Season ID of the match';
COMMENT ON COLUMN soccer.fact_match_statistics.pitch_condition_id IS 'Pitch condition ID of the match';
COMMENT ON COLUMN soccer.fact_match_statistics.time_of_day_id IS 'Time of day ID of the match';
COMMENT ON COLUMN soccer.fact_match_statistics.outcome_type_id IS 'Outcome type ID of the match';
COMMENT ON COLUMN soccer.fact_match_statistics.attendance_level_id IS 'Attendance level ID of the match';
COMMENT ON COLUMN soccer.fact_match_statistics.official_id IS 'The official of the match';
COMMENT ON TABLE soccer.fact_match_statistics IS 'Fact table that has all the data';

INSERT INTO soccer.fact_match_statistics (match_date, team_id, opponent_id, venue_id, goals_scored, goals_conceded, result, climate, match_type, referee_id, season_id, pitch_condition_id, time_of_day_id, outcome_type_id, attendance_level_id, official_id)
VALUES ('2023-08-15', 1,  2, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 1),
       ('2023-07-20', 2, 4, 5, 1, 2, 3, 2, 2, 2, 1, 2, 2, 2, 9, 2),
       ('2023-06-05', 3, 6, 1, 2, 0, 1, 3, 3, 3, 1, 3, 3, 3, 8, 3),
       ('2023-05-18', 4, 7, 3, 1, 1, 2, 1, 1, 4, 1, 4, 4, 4, 7, 4),
       ('2023-05-18', 4, 7, 3, 1, 1, 2, 1, 1, 4, 1, 4, 4, 4, 7, 4),
       ('2023-04-02', 5, 8, 2, 4, 0, 1, 2, 2, 5, 1, 5, 5, 5, 6, 5),
       ('2023-03-15', 6, 9, 5, 0, 2, 3, 3, 3, 6, 1, 6, 6, 6, 5, 6),
       ('2022-11-25', 7, 10, 4, 2, 2, 2, 1, 1, 7, 2, 7, 7, 7, 4, 7),
       ('2022-10-10', 8, 11, 1, 3, 1, 1, 2, 1, 8, 2, 8, 8, 8, 3, 8),
       ('2022-09-03', 9, 12, 3, 1, 1, 2, 3, 2, 9, 2, 9, 9, 9, 2, 9),
       ('2022-08-17', 10, 13, 2, 0, 2, 3, 3, 2, 10, 2, 10, 10, 10, 1, 10),
       ('2022-06-29', 11, 14, 1, 1, 0, 1, 2, 2, 11, 2, 1, 9, 1, 2, 1),
       ('2022-06-14', 12, 15, 4, 2, 1, 1, 1, 3, 12, 2, 2, 8, 2, 3, 2),
       ('2022-05-01', 13, 16, 5, 0, 3, 3, 3, 3, 13, 2, 3, 7, 3, 4, 3),
       ('2022-04-19', 14, 17, 3, 2, 2, 2, 2, 3, 14, 2, 4, 6, 4, 5, 4),
       ('2022-03-05', 15, 18, 2, 3, 1, 1, 1, 1, 15, 2, 5, 5, 5, 6, 5),
       ('2022-02-12', 16, 19, 1, 0, 1, 3, 2, 2, 16, 2, 6, 4, 6, 7, 6),
       ('2022-01-25', 17, 20, 4, 2, 0, 1, 3, 3, 17, 2, 7, 3, 7, 8, 7),
       ('2021-12-10', 18, 1, 5, 1, 1, 2, 1, 2, 18, 3, 8, 2, 8, 9, 8),
       ('2021-11-28', 19, 2, 3, 4, 0, 1, 2, 1, 19, 3, 9, 1, 9, 10, 9),
       ('2021-10-17', 20, 3, 2, 0, 3, 3, 3, 3, 20, 3, 10, 2, 10, 9, 10);