-- Drop and recreate the schema
DROP SCHEMA IF EXISTS soccer CASCADE;
CREATE SCHEMA soccer;

-- dim_nationality table
CREATE TABLE soccer.dim_nationality
(
    -- Unique identifier for each nationality
    nationality_id   SERIAL PRIMARY KEY,
    -- Name of the nationality (e.g. "Brazilian", "English", etc.)
    nationality_name VARCHAR(50),
    -- Continent where the nationality is located (e.g. "South America", "Europe", etc.)
    continent        VARCHAR(50),
    -- Region within the continent where the nationality is located (e.g. "South America - Brazil", etc.)
    region           VARCHAR(50),
    -- Primary language spoken by the nationality
    language         VARCHAR(50),
    -- Estimated population of the nationality
    population       INT,
    -- GDP per capita of the nationality
    gdp_per_capita   DECIMAL(10, 2),
    -- FIFA ranking of the nationality
    fifa_ranking     INT,
    -- Number of Olympic medals won by the nationality
    olympic_medals   INT,
    -- National sport of the nationality
    national_sport   VARCHAR(50)
);

-- dim_match_season table
CREATE TABLE soccer.dim_match_season
(
    -- Unique identifier for each match season
    season_id           SERIAL PRIMARY KEY,
    -- Name of the match season (e.g. "2022-2023", etc.)
    season_name         VARCHAR(50),
    -- Start date of the match season
    start_date          DATE,
    -- End date of the match season
    end_date            DATE,
    -- Number of matchdays in the match season
    number_of_matchdays INT
);

INSERT INTO soccer.dim_match_season (season_name, start_date, end_date, number_of_matchdays)
VALUES ('2020-2021', '2020-08-01', '2021-05-23', 38),
       ('2021-2022', '2021-08-14', '2022-05-22', 38),
       ('2022-2023', '2022-07-31', '2023-05-28', 38),
       ('2019-2020', '2019-08-17', '2020-07-26', 38),
       ('2018-2019', '2018-08-11', '2019-05-19', 38),
       ('2017-2018', '2017-08-12', '2018-05-13', 38),
       ('2016-2017', '2016-08-13', '2017-05-21', 38),
       ('2015-2016', '2015-08-08', '2016-05-15', 38),
       ('2014-2015', '2014-08-09', '2015-05-23', 38),
       ('2013-2014', '2013-08-17', '2014-05-19', 38),
       ('2012-2013', '2012-08-18', '2013-05-05', 38),
       ('2011-2012', '2011-08-14', '2012-05-13', 38),
       ('2010-2011', '2010-08-07', '2011-05-22', 38),
       ('2009-2010', '2009-08-16', '2010-05-23', 38),
       ('2008-2009', '2008-08-09', '2009-05-17', 38),
       ('2007-2008', '2007-08-11', '2008-05-18', 38),
       ('2006-2007', '2006-08-18', '2007-05-27', 38),
       ('2005-2006', '2005-08-13', '2006-05-14', 38),
       ('2004-2005', '2004-08-07', '2005-05-22', 38),
       ('2003-2004', '2003-08-16', '2004-05-23', 38),
       ('2002-2003', '2002-08-17', '2003-05-18', 38);

-- dim_referee table
CREATE TABLE soccer.dim_referee
(
    -- Unique identifier for each referee
    referee_id          SERIAL PRIMARY KEY,
    -- Name of the referee
    referee_name        VARCHAR(50),
    -- Foreign key referencing the nationality of the referee
    nationality_id      INT REFERENCES soccer.dim_nationality (nationality_id),
    -- Date of birth of the referee
    birth_date          DATE,
    -- Number of years of experience as a referee
    years_of_experience INT,
    -- Year the referee received their FIFA badge
    fifa_badge_year     INT,
    -- Specialization of the referee (e.g. "Elite", "International", etc.)
    specialization      VARCHAR(50),
    -- Languages spoken by the referee
    languages_spoken    VARCHAR(100),
    -- Fitness level of the referee (e.g. "High", "Medium", etc.)
    fitness_level       VARCHAR(20),
    -- Notable tournaments refereed by the referee
    notable_tournaments VARCHAR(200)
);

-- dim_coach table
CREATE TABLE soccer.dim_coach
(
    -- Unique identifier for each coach
    coach_id                SERIAL PRIMARY KEY,
    -- Name of the coach
    coach_name              VARCHAR(50),
    -- Foreign key referencing the nationality of the coach
    nationality_id          INT REFERENCES soccer.dim_nationality (nationality_id),
    -- Date of birth of the coach
    birth_date              DATE,
    -- Coaching style of the coach (e.g. "Tactical", "Passive", etc.)
    coaching_style          VARCHAR(50),
    -- Preferred formation of the coach (e.g. "4-4-2", "4-3-3", etc.)
    preferred_formation     VARCHAR(20),
    -- Number of years of experience as a coach
    years_of_experience     INT,
    -- Number of trophies won by the coach
    trophies_won            INT,
    -- Coaching licenses held by the coach
    coaching_licenses       VARCHAR(100),
    -- Previous teams coached by the coach
    previous_teams          VARCHAR(200),
    -- Playing career position of the coach (e.g. "Midfielder", "Striker", etc.)
    playing_career_position VARCHAR(50)
);

-- dim_player_position table
CREATE TABLE soccer.dim_player_position
(
    -- Unique identifier for each player position
    position_id              SERIAL PRIMARY KEY,
    -- Name of the player position (e.g. "Goalkeeper", "Defender", etc.)
    position_name            VARCHAR(50),
    -- Category of the player position (e.g. "Defensive", "Midfield", etc.)
    position_category        VARCHAR(20),
    -- Typical role description of the player position
    typical_role_description TEXT,
    -- Key attributes of the player position (e.g. "Speed", "Agility", etc.)
    key_attributes           VARCHAR(200),
    -- Defensive responsibility of the player position (e.g. "High", "Medium", etc.)
    defensive_responsibility INT,
    -- Offensive responsibility of the player position (e.g. "High", "Medium", etc.)
    offensive_responsibility INT,
    -- Average distance covered by a player in this position
    average_distance_covered DECIMAL(5, 2),
    -- Tactical importance of the player position (e.g. "High", "Medium", etc.)
    tactical_importance      VARCHAR(20)
);

-- dim_player table
CREATE TABLE soccer.dim_player
(
    -- Unique identifier for each player
    player_id            SERIAL PRIMARY KEY,
    -- Name of the player
    player_name          VARCHAR(50),
    -- Foreign key referencing the player position of the player
    position_id          INT REFERENCES soccer.dim_player_position (position_id),
    -- Foreign key referencing the nationality of the player
    nationality_id       INT REFERENCES soccer.dim_nationality (nationality_id),
    -- Date of birth of the player
    birth_date           DATE,
    -- Height of the player in meters
    height               DECIMAL(5, 2),
    -- Weight of the player in kilograms
    weight               DECIMAL(5, 2),
    -- Preferred foot of the player (e.g. "Left", "Right", "Both", etc.)
    preferred_foot       VARCHAR(10),
    -- Market value of the player
    market_value         DECIMAL(12, 2),
    -- Expiration date of the player's contract
    contract_expiry_date DATE,
    -- Number of international caps won by the player
    international_caps   INT,
    -- Number of goals scored by the player
    goals_scored         INT,
    -- Number of assists made by the player
    assists              INT,
    -- Number of yellow cards received by the player
    yellow_cards         INT,
    -- Number of red cards received by the player
    red_cards            INT
);

-- dim_team table
CREATE TABLE soccer.dim_team
(
    -- Unique identifier for each team
    team_id                SERIAL PRIMARY KEY,
    -- Name of the team
    team_name              VARCHAR(50),
    -- Foreign key referencing the coach of the team
    coach_id               INT REFERENCES soccer.dim_coach (coach_id),
    -- Name of the team's home stadium
    home_stadium           VARCHAR(50),
    -- Year the team was founded
    founded_year           INT,
    -- Foreign key referencing the player of the team
    player_id              INT REFERENCES soccer.dim_player (player_id),
    -- Color of the team's jersey
    team_color             VARCHAR(20),
    -- Name of the team's mascot
    mascot                 VARCHAR(50),
    -- League the team plays in
    league                 VARCHAR(50),
    -- Last season's position of the team
    last_season_position   INT,
    -- Value of the team
    team_value             DECIMAL(12, 2),
    -- Number of social media followers
    social_media_followers INT,
    -- Rating of the team's academy
    academy_rating         VARCHAR(20)
);

-- dim_opponent_team table
CREATE TABLE soccer.dim_opponent_team
(
    -- Unique identifier for each opponent team
    opponent_id   SERIAL PRIMARY KEY,
    -- Name of the opponent team
    team_name     VARCHAR(50),
    -- Country of the opponent team
    country       VARCHAR(50),
    -- Continent of the opponent team
    continent     VARCHAR(50),
    -- League the opponent team plays in
    league        VARCHAR(50),
    -- Name of the opponent team's home stadium
    home_stadium  VARCHAR(50),
    -- Name of the opponent team's coach
    coach_name    VARCHAR(50),
    -- Ranking of the opponent team
    team_ranking  INT,
    -- Star player of the opponent team
    star_player   VARCHAR(50),
    -- Playing style of the opponent team
    playing_style VARCHAR(50)
);

-- dim_match_venue_type table
CREATE TABLE soccer.dim_match_venue_type
(
    -- Unique identifier for each match venue type
    venue_type_id           SERIAL PRIMARY KEY,
    -- Description of the match venue type (e.g. "Stadium", "Arena", etc.)
    venue_type_description  VARCHAR(50),
    -- Typical capacity range of the match venue type (e.g. "10,000 - 50,000", etc.)
    typical_capacity_range  VARCHAR(50),
    -- Common facilities of the match venue type (e.g. "Food", "Drink", etc.)
    common_facilities       TEXT,
    -- Historical significance of the match venue type (e.g. "National monument", etc.)
    historical_significance TEXT
);

-- dim_venue table
CREATE TABLE soccer.dim_venue
(
    -- Unique identifier for each venue
    venue_id            SERIAL PRIMARY KEY,
    -- Name of the venue
    venue_name          VARCHAR(50),
    -- City where the venue is located
    city                VARCHAR(50),
    -- Capacity of the venue
    capacity            INT,
    -- Foreign key referencing the match venue type of the venue
    venue_type_id       INT REFERENCES soccer.dim_match_venue_type (venue_type_id),
    -- Year the venue was built
    year_built          INT,
    -- Type of surface used on the venue
    surface_type        VARCHAR(50),
    -- Type of roof used on the venue
    roof_type           VARCHAR(50),
    -- Record attendance at the venue
    record_attendance   INT,
    -- Longitude of the venue
    longitude           DECIMAL(9, 6),
    -- Latitude of the venue
    latitude            DECIMAL(9, 6),
    -- Elevation of the venue
    elevation           INT,
    -- Average temperature at the venue
    average_temperature DECIMAL(5, 2)
);

-- dim_weather_condition table
CREATE TABLE soccer.dim_weather_condition
(
    -- Unique identifier for each weather condition
    weather_id            SERIAL PRIMARY KEY,
    -- Description of the weather condition (e.g. "Sunny", "Rainy", etc.)
    condition_description VARCHAR(20),
    -- Temperature range of the weather condition (e.g. "20 - 30°C", etc.)
    temperature_range     VARCHAR(20),
    -- Wind speed range of the weather condition (e.g. "1 - 5 mph", etc.)
    wind_speed_range      VARCHAR(20),
    -- Probability of precipitation in the weather condition (e.g. "10 - 20%", etc.)
    precipitation_chance  VARCHAR(20),
    -- Humidity range of the weather condition (e.g. "30 - 50%", etc.)
    humidity_range        VARCHAR(20)
);

-- dim_match_type table
CREATE TABLE soccer.dim_match_type
(
    -- Unique identifier for each match type
    match_type_id          SERIAL PRIMARY KEY,
    -- Description of the match type (e.g. "Group Stage", "Knockout", etc.)
    match_type_description VARCHAR(50),
    -- Importance level of the match type (e.g. "High", "Medium", etc.)
    importance_level       VARCHAR(50),
    -- Typical audience size for the match type
    typical_audience_size  VARCHAR(50),
    -- Prize money for the match type
    prize_money            DECIMAL(12, 2),
    -- Impact of the match type on qualification
    qualification_impact   VARCHAR(50)
);

-- dim_match_official table
CREATE TABLE soccer.dim_match_official
(
    -- Unique identifier for each match official
    official_id         SERIAL PRIMARY KEY,
    -- Name of the match official
    official_name       VARCHAR(50),
    -- Nationality of the match official
    nationality         VARCHAR(50),
    -- Role of the match official (e.g. "Referee", "Assistant Referee", etc.)
    role                VARCHAR(50),
    -- Number of years of experience as a match official
    years_of_experience INT,
    -- Notable tournaments officiated by the match official
    notable_tournaments VARCHAR(200),
    -- Fitness level of the match official (e.g. "High", "Medium", etc.)
    fitness_level       VARCHAR(20)
);

-- dim_match_attendance_level table
CREATE TABLE soccer.dim_match_attendance_level
(
    -- Unique identifier for each match attendance level
    attendance_level_id          SERIAL PRIMARY KEY,
    -- Description of the match attendance level (e.g. "Full House", "Half Full", etc.)
    attendance_level_description VARCHAR(50),
    -- Percentage of capacity for the match attendance level
    percentage_of_capacity       VARCHAR(20),
    -- Typical atmosphere for the match attendance level (e.g. "Electric", "Quiet", etc.)
    typical_atmosphere           VARCHAR(50),
    -- Impact of the match attendance level on ticket price (e.g. "High", "Medium", etc.)
    ticket_price_impact          VARCHAR(50)
);

-- dim_match_outcome_type table
CREATE TABLE soccer.dim_match_outcome_type
(
    -- Unique identifier for each match outcome type
    outcome_type_id          SERIAL PRIMARY KEY,
    -- Description of the match outcome type (e.g. "Regulation Time", "Extra Time", etc.)
    outcome_type_description VARCHAR(50),
    -- Regulation time minutes for the match outcome type
    regulation_time_minutes  INT,
    -- Extra time format for the match outcome type (e.g. "2 x 15 minutes", etc.)
    extra_time_format        VARCHAR(50),
    -- Penalty shootout format for the match outcome type (e.g. "5 penalties", etc.)
    penalty_shootout_format  VARCHAR(50)
);

-- dim_match_time_of_day table
CREATE TABLE soccer.dim_match_time_of_day
(
    -- Unique identifier for each match time of day
    time_of_day_id          SERIAL PRIMARY KEY,
    -- Description of the match time of day (e.g. "Morning", "Afternoon", etc.)
    time_of_day_description VARCHAR(50),
    -- Typical start time for the match time of day
    typical_start_time      TIME,
    -- Lighting conditions for the match time of day (e.g. "Daylight", "Artificial", etc.)
    lighting_conditions     VARCHAR(50),
    -- Expected temperature for the match time of day (e.g. "Warm", "Cool", etc.)
    expected_temperature    VARCHAR(20)
);

-- dim_match_pitch_condition table
CREATE TABLE soccer.dim_match_pitch_condition
(
    -- Unique identifier for each match pitch condition
    pitch_condition_id          SERIAL PRIMARY KEY,
    -- Description of the match pitch condition (e.g. "Dry", "Wet", etc.)
    pitch_condition_description VARCHAR(50),
    -- Grass length for the match pitch condition (e.g. "Short", "Long", etc.)
    grass_length                VARCHAR(20),
    -- Moisture level for the match pitch condition (e.g. "Dry", "Wet", etc.)
    moisture_level              VARCHAR(20),
    -- Maintenance frequency for the match pitch condition (e.g. "Daily", "Weekly", etc.)
    maintenance_frequency       VARCHAR(50)
);

INSERT INTO soccer.dim_nationality (nationality_id, nationality_name, continent, region, language, population,
                                    gdp_per_capita, fifa_ranking, olympic_medals, national_sport)
VALUES (1, 'Afghanistan', 'Asia', 'South Asia', 'Pashto', 33.4, 440, 157, 1, 'Jump Rope'),
       (2, 'Albania', 'Europe', 'Southern Europe', 'Albanian', 2.8, 4300, 112, 26, 'Handball'),
       (3, 'Algeria', 'Africa', 'North Africa', 'Arabic', 43.8, 2740, 23, 95, 'Football'),
       (4, 'Andorra', 'Europe', 'Southern Europe', 'Catalan', 0.07, 25000, 175, 1, 'Football'),
       (5, 'Angola', 'Africa', 'Sub-Saharan Africa', 'Portuguese', 33.7, 3940, 135, 39, 'Football'),
       (6, 'Antigua and Barbuda', 'North America', 'Caribbean', 'English', 0.1, 44000, 144, 12, 'Cricket'),
       (7, 'Argentina', 'South America', 'South America', 'Spanish', 45.6, 10410, 8, 151, 'Football'),
       (8, 'Armenia', 'Asia', 'Western Asia', 'Armenian', 3.1, 3920, 100, 15, 'Judo'),
       (9, 'Australia', 'Oceania', 'Australia and Oceania', 'English', 25.9, 51890, 4, 180, 'Cricket'),
       (10, 'Austria', 'Europe', 'Central Europe', 'German', 8.9, 43400, 23, 38, 'Football'),
       (11, 'Azerbaijan', 'Asia', 'Western Asia', 'Azerbaijani', 10.1, 3820, 118, 7, 'Wrestling'),
       (12, 'Bahamas', 'North America', 'Caribbean', 'English', 0.4, 29400, 182, 5, 'Swimming'),
       (13, 'Bahrain', 'Asia', 'Western Asia', 'Arabic', 1.6, 28300, 125, 12, 'Horse Riding'),
       (14, 'Bangladesh', 'Asia', 'South Asia', 'Bengali', 166.3, 2090, 194, 2, 'Football'),
       (15, 'Barbados', 'North America', 'Caribbean', 'English', 0.3, 22200, 150, 10, 'Cricket'),
       (16, 'Belarus', 'Europe', 'Eastern Europe', 'Belarusian', 9.4, 3940, 83, 23, 'Football'),
       (17, 'Belgium', 'Europe', 'Western Europe', 'Dutch', 11.5, 44900, 3, 116, 'Football'),
       (18, 'Belize', 'North America', 'Central America', 'English', 0.4, 3940, 149, 2, 'Football'),
       (19, 'Benin', 'Africa', 'Sub-Saharan Africa', 'French', 12.2, 1300, 135, 6, 'Football'),
       (20, 'Bhutan', 'Asia', 'South Asia', 'Dzongkha', 0.8, 3400, 188, 1, 'Archery');

INSERT INTO soccer.dim_referee (referee_id, referee_name, nationality_id, birth_date, years_of_experience,
                                fifa_badge_year, specialization, languages_spoken, fitness_level, notable_tournaments)
VALUES (1, 'John Smith', 1, '1980-01-01', 10, 2010, 'UEFA A', 'English, Spanish', 'Good', 'Euro 2012'),
       (2, 'Jane Doe', 2, '1985-06-15', 12, 2015, 'UEFA Elite', 'Spanish, Portuguese', 'Very Good', 'World Cup 2018'),
       (3, 'Bob Brown', 3, '1990-03-20', 8, 2020, 'FIFA International', 'Arabic, French', 'Excellent',
        'Africa Cup of Nations'),
       (4, 'Alice Green', 4, '1995-09-10', 6, 2022, 'UEFA B', 'German, English', 'Good', 'Champions League'),
       (5, 'Mike Davis', 5, '2000-11-25', 4, 2023, 'FIFA Youth', 'English, Italian', 'Very Good', 'Youth World Cup'),
       (6, 'Emily Taylor', 6, '2005-02-15', 2, 2024, 'UEFA C', 'French, Spanish', 'Good', 'Europa League'),
       (7, 'Tom White', 7, '2010-04-01', 1, 2025, 'FIFA Assistant', 'English, German', 'Excellent',
        'World Cup Qualifier'),
       (8, 'Sarah Lee', 8, '2015-08-20', 0, 2026, 'UEFA D', 'Spanish, Portuguese', 'Good', 'UEFA Nations League'),
       (9, 'David Kim', 9, '1992-10-10', 14, 2027, 'FIFA International', 'English, Chinese', 'Very Good',
        'Olympic Games'),
       (10, 'Kate Chen', 10, '1998-01-15', 11, 2028, 'UEFA A', 'German, French', 'Excellent', 'Euro 2020'),
       (11, 'Olivia Patel', 11, '2002-06-25', 9, 2029, 'UEFA Elite', 'English, Hindi', 'Good',
        'Champions League Final'),
       (12, 'Benjamin Hall', 12, '2006-09-10', 7, 2030, 'FIFA International', 'Arabic, French', 'Very Good',
        'World Cup Semifinal'),
       (13, 'Sophia Rodriguez', 13, '2010-04-01', 5, 2031, 'UEFA B', 'Spanish, English', 'Good', 'Europa League Final'),
       (14, 'Liam Brown', 14, '2014-11-25', 3, 2032, 'FIFA Youth', 'English, Italian', 'Excellent',
        'Youth World Cup Final'),
       (15, 'Ava Martin', 15, '2018-02-15', 1, 2033, 'UEFA C', 'French, Spanish', 'Good', 'UEFA Nations League Final'),
       (16, 'Jordan Lee', 16, '2022-06-20', 0, 2034, 'FIFA Assistant', 'English, German', 'Very Good',
        'World Cup Qualifier'),
       (17, 'Isabella Garcia', 17, '2024-08-20', 0, 2035, 'UEFA D', 'Spanish, Portuguese', 'Good',
        'Europa League Qualifier'),
       (18, 'Caleb Kim', 18, '2025-04-10', 0, 2036, 'FIFA International', 'English, Chinese', 'Excellent',
        'Champions League Qualifier'),
       (19, 'Evelyn White', 19, '2026-01-15', 0, 2037, 'UEFA A', 'German, French', 'Good', 'Euro Qualifier'),
       (20, 'Mason Hall', 20, '2027-06-25', 0, 2038, 'FIFA International', 'Arabic, French', 'Very Good',
        'World Cup Qualifier'),
       (21, 'John Smith', 1, '1975-06-12', 10, 2015, 'FIFA', 'English', 'Good', 'Wimbledon'),
       (22, 'Jane Doe', 2, '1980-09-15', 8, 2018, 'UEFA', 'Spanish', 'Excellent', 'Champions League'),
       (23, 'Mike Johnson', 3, '1965-02-27', 15, 2005, 'FIFA', 'English', 'Fair', 'World Cup'),
       (24, 'Sarah Lee', 4, '1985-07-02', 12, 2012, 'UEFA', 'Chinese', 'Good', 'Europa League'),
       (25, 'Robert Brown', 5, '1972-03-14', 13, 2008, 'FIFA', 'American', 'Good', 'MLS Cup'),
       (26, 'Emily Taylor', 6, '1982-08-20', 11, 2010, 'UEFA', 'French', 'Good', 'FA Cup'),
       (27, 'David White', 7, '1968-11-18', 14, 2002, 'FIFA', 'English', 'Good', 'Premier League'),
       (28, 'Katherine Brown', 8, '1990-04-05', 9, 2015, 'UEFA', 'English', 'Fair', 'Torneo Internazionale'),
       (29, 'Alexander Davis', 9, '1976-01-03', 10, 2013, 'FIFA', 'Russian', 'Good', 'Europa League'),
       (30, 'Cynthia Martin', 10, '1988-10-17', 8, 2017, 'UEFA', 'Brazilian', 'Good', 'Copa América');

INSERT INTO soccer.dim_coach (coach_id, coach_name, nationality_id, birth_date, coaching_style, preferred_formation,
                              years_of_experience, trophies_won, coaching_licenses, previous_teams,
                              playing_career_position)
VALUES (1, 'John Smith', 1, '1960-01-01', 'Defensive', '4-4-2', 20, 5, 'UEFA A, UEFA Elite',
        'Manchester United, Barcelona', 'Defender'),
       (2, 'Jane Doe', 2, '1965-06-15', 'Attacking', '4-3-3', 18, 3, 'UEFA B, UEFA Elite', 'Real Madrid, Bayern Munich',
        'Forward'),
       (3, 'Bob Brown', 3, '1970-03-20', 'Balanced', '3-5-2', 15, 2, 'FIFA International',
        'Paris Saint-Germain, Juventus', 'Midfielder'),
       (4, 'Alice Green', 4, '1975-09-10', 'Defensive', '4-2-3-1', 12, 1, 'UEFA C, UEFA D', 'Liverpool, Chelsea',
        'Defender'),
       (5, 'Mike Davis', 5, '1980-11-25', 'Attacking', '4-3-3', 10, 0, 'FIFA Youth', 'Manchester City, Arsenal',
        'Forward'),
       (6, 'Emily Taylor', 6, '1985-02-15', 'Balanced', '4-1-4-1', 8, 0, 'UEFA A', 'Barcelona, Real Madrid',
        'Midfielder'),
       (7, 'Tom White', 7, '1990-04-01', 'Defensive', '4-4-2', 6, 0, 'FIFA International',
        'Paris Saint-Germain, Bayern Munich', 'Defender'),
       (8, 'Sarah Lee', 8, '1995-08-20', 'Attacking', '4-3-3', 5, 0, 'UEFA B', 'Liverpool, Chelsea', 'Forward'),
       (9, 'David Kim', 9, '2000-10-10', 'Balanced', '3-5-2', 3, 0, 'FIFA International', 'Manchester United, Juventus',
        'Midfielder'),
       (10, 'Kate Chen', 10, '2005-01-15', 'Defensive', '4-2-3-1', 2, 0, 'UEFA A', 'Real Madrid, Paris Saint-Germain',
        'Defender'),
       (11, 'Olivia Patel', 11, '2010-06-25', 'Attacking', '4-3-3', 1, 0, 'UEFA Elite', 'Barcelona, Liverpool',
        'Forward'),
       (12, 'Benjamin Hall', 12, '2015-09-10', 'Balanced', '4-1-4-1', 0, 0, 'FIFA International',
        'Manchester City, Bayern Munich', 'Midfielder'),
       (13, 'Sophia Rodriguez', 13, '2020-04-01', 'Defensive', '4-4-2', 0, 0, 'UEFA C', 'Chelsea, Arsenal', 'Defender'),
       (14, 'Liam Brown', 14, '2025-11-25', 'Attacking', '4-3-3', 0, 0, 'FIFA Youth', 'Liverpool, Real Madrid',
        'Forward'),
       (15, 'Ava Martin', 15, '2030-02-15', 'Balanced', '4-1-4-1', 0, 0, 'UEFA A', 'Barcelona, Paris Saint-Germain',
        'Midfielder'),
       (16, 'Jordan Lee', 16, '2035-06-20', 'Defensive', '4-2-3-1', 0, 0, 'FIFA International',
        'Manchester United, Juventus', 'Defender'),
       (17, 'Isabella Garcia', 17, '2040-08-20', 'Attacking', '4-3-3', 0, 0, 'UEFA B', 'Real Madrid, Liverpool',
        'Forward'),
       (18, 'Caleb Kim', 18, '2045-04-10', 'Balanced', '3-5-2', 0, 0, 'FIFA International',
        'Paris Saint-Germain, Bayern Munich', 'Midfielder'),
       (19, 'Evelyn White', 19, '2050-01-15', 'Defensive', '4-4-2', 0, 0, 'UEFA A', 'Chelsea, Arsenal', 'Defender'),
       (20, 'Mason Hall', 20, '2055-06-25', 'Attacking', '4-3-3', 0, 0, 'UEFA Elite', 'Manchester City, Barcelona',
        'Forward');


INSERT INTO soccer.dim_player_position (position_id, position_name, position_category, typical_role_description,
                                        key_attributes, defensive_responsibility, offensive_responsibility,
                                        average_distance_covered, tactical_importance)
VALUES (1, 'Goalkeeper', 'Goalkeeper', 'Prevent the opponent from scoring', 'Speed, Agility, Reflexes', 9, 1, 20.5,
        'High'),
       (2, 'Defender', 'Defender', 'Protect the goal and defend against opponents', 'Strength, Speed, Positioning', 8,
        2, 22.1, 'High'),
       (3, 'Midfielder', 'Midfielder', 'Support the defense, create scoring opportunities',
        'Speed, Agility, Passing ability', 6, 8, 24.3, 'Medium'),
       (4, 'Forward', 'Forward', 'Score goals, create scoring opportunities', 'Speed, Agility, Finishing ability', 2, 9,
        26.1, 'High');

INSERT INTO soccer.dim_player (player_id, player_name, position_id, nationality_id, birth_date, height, weight,
                               preferred_foot, market_value, contract_expiry_date, international_caps, goals_scored,
                               assists, yellow_cards, red_cards)
VALUES (1, 'John Smith', 2, 1, '1980-01-01', 184, 75, 'Right', 1000000, '2025-06-30', 50, 10, 10, 5, 1),
       (2, 'Jane Doe', 3, 2, '1985-06-15', 180, 70, 'Left', 800000, '2024-12-31', 40, 15, 12, 4, 0),
       (3, 'Bob Brown', 2, 3, '1990-03-20', 185, 80, 'Right', 1200000, '2027-03-31', 30, 20, 18, 6, 2),
       (4, 'Alice Green', 4, 4, '1995-09-10', 170, 60, 'Left', 600000, '2025-09-30', 20, 25, 15, 3, 0),
       (5, 'Mike Davis', 3, 5, '2000-11-25', 185, 75, 'Right', 900000, '2027-11-30', 10, 10, 8, 2, 1),
       (6, 'Emily Taylor', 2, 6, '2005-02-15', 180, 70, 'Left', 700000, '2029-03-31', 5, 5, 3, 1, 0),
       (7, 'Tom White', 3, 7, '1992-04-01', 185, 80, 'Right', 1100000, '2028-04-30', 25, 15, 12, 4, 1),
       (8, 'Sarah Lee', 4, 8, '2000-08-20', 170, 60, 'Left', 800000, '2026-08-31', 15, 20, 10, 3, 0),
       (9, 'David Kim', 2, 9, '2005-10-10', 180, 70, 'Right', 900000, '2030-10-30', 10, 10, 8, 2, 1),
       (10, 'Kate Chen', 3, 10, '2010-01-15', 185, 75, 'Left', 1000000, '2032-01-31', 5, 5, 3, 1, 0),
       (11, 'Olivia Patel', 2, 11, '2015-06-25', 180, 70, 'Right', 900000, '2034-06-30', 10, 10, 8, 2, 1),
       (12, 'Benjamin Hall', 3, 12, '2020-09-10', 185, 80, 'Left', 1000000, '2036-09-30', 25, 25, 20, 5, 2),
       (13, 'Sophia Rodriguez', 4, 13, '2025-04-01', 170, 60, 'Left', 1000000, '2038-04-30', 10, 10, 8, 2, 1),
       (14, 'Liam Brown', 2, 14, '2030-11-25', 180, 70, 'Right', 900000, '2040-11-30', 5, 5, 3, 1, 0),
       (15, 'Ava Martin', 3, 15, '2035-02-15', 185, 75, 'Left', 1000000, '2042-02-28', 10, 10, 8, 2, 1),
       (16, 'Jordan Lee', 2, 16, '2040-06-20', 180, 70, 'Right', 1000000, '2044-06-30', 25, 25, 20, 5, 2),
       (17, 'Isabella Garcia', 4, 17, '2045-08-20', 170, 60, 'Left', 1000000, '2047-08-31', 10, 10, 8, 2, 1),
       (18, 'Caleb Kim', 3, 18, '2050-04-10', 185, 80, 'Left', 1000000, '2052-04-30', 5, 5, 3, 1, 0),
       (19, 'Evelyn White', 2, 19, '2055-01-15', 180, 70, 'Right', 900000, '2057-01-31', 10, 10, 8, 2, 1),
       (20, 'Mason Hall', 3, 20, '2056-06-25', 185, 75, 'Left', 1000000, '2058-06-30', 25, 25, 20, 5, 2);

INSERT INTO soccer.dim_team (team_id, team_name, coach_id, home_stadium, founded_year, player_id, team_color, mascot,
                             league, last_season_position, team_value, social_media_followers, academy_rating)
VALUES (1, 'Manchester United', 1, 'Old Trafford', 1878, 1, 'Red', 'Devil', 'Premier League', 1, 1000000000, 10000000,
        'Excellent'),
       (2, 'Barcelona', 2, 'Camp Nou', 1899, 2, 'Blue', 'Blaugrana', 'La Liga', 2, 500000000, 5000000, 'Good'),
       (3, 'Bayern Munich', 3, 'Allianz Arena', 1900, 3, 'Red', 'BVB', 'Bundesliga', 3, 200000000, 2000000,
        'Very Good'),
       (4, 'Real Madrid', 4, 'Santiago Bernabéu', 1902, 4, 'White', 'Galacticos', 'La Liga', 4, 150000000, 1500000,
        'Excellent'),
       (5, 'Liverpool', 5, 'Anfield', 1892, 5, 'Red', 'Reds', 'Premier League', 5, 80000000, 800000, 'Good'),
       (6, 'Juventus', 6, 'Allianz Stadium', 1897, 6, 'Black', 'Juve', 'Serie A', 6, 300000000, 3000000, 'Very Good'),
       (7, 'Paris Saint-Germain', 7, 'Parc des Princes', 2012, 7, 'Red', 'PSG', 'Ligue 1', 7, 400000000, 4000000,
        'Excellent'),
       (8, 'Chelsea', 8, 'Köln Arena', 1905, 8, 'Blue', 'Blues', 'Premier League', 8, 50000000, 500000, 'Good'),
       (9, 'Arsenal', 9, 'Emirates Stadium', 1886, 9, 'Red', 'Gunners', 'Premier League', 9, 200000000, 2000000,
        'Very Good'),
       (10, 'Manchester City', 10, 'Etihad Stadium', 1880, 10, 'Blue', 'Citizens', 'Premier League', 10, 150000000,
        1500000, 'Excellent'),
       (11, 'Tottenham Hotspur', 11, 'Tottenham Stadium', 1882, 11, 'White', 'Spurs', 'Premier League', 11, 30000000,
        300000, 'Good'),
       (12, 'Leeds United', 12, 'Elland Road', 1919, 12, 'White', 'Whites', 'EFL Championship', 12, 5000000, 500000,
        'Very Good'),
       (13, 'Middlesbrough', 13, 'Riverside Stadium', 1876, 13, 'Red', 'Boro', 'EFL Championship', 13, 30000000, 300000,
        'Good'),
       (14, 'Fiorentina', 14, 'Stadio Artemio Franchi', 1926, 14, 'Red', 'Viola', 'Serie A', 14, 100000000, 1000000,
        'Excellent'),
       (15, 'Roma', 15, 'Stadio Olimpico', 1927, 15, 'Red', 'Giallorossi', 'Serie A', 15, 150000000, 1500000,
        'Very Good'),
       (16, 'AC Milan', 16, 'San Siro', 1908, 16, 'Red', 'Rossoneri', 'Serie A', 16, 200000000, 2000000, 'Excellent'),
       (17, 'Inter Milan', 17, 'San Siro', 1908, 17, 'Blue', 'Nerazzurri', 'Serie A', 17, 300000000, 3000000,
        'Very Good'),
       (18, 'Atletico Madrid', 18, 'Wanda Metropolitano', 1903, 18, 'Red', 'Rojiblancos', 'La Liga', 18, 100000000,
        1000000, 'Excellent'),
       (19, 'Benfica', 19, 'Estádio da Luz', 1904, 19, 'Red', 'Eagles', 'Primeira Liga', 19, 50000000, 500000, 'Good'),
       (20, 'PSV Eindhoven', 20, 'Philips Stadion', 1913, 20, 'Orange', 'Fenoms', 'Eredivisie', 20, 20000000, 200000,
        'Very Good');


INSERT INTO soccer.dim_opponent_team (opponent_id, team_name, country, continent, league, home_stadium, coach_name,
                                      team_ranking, star_player, playing_style)
VALUES (1, 'Paris PSG', 'France', 'Europe', 'Ligue 1', 'Parc des Princes', 'Mauricio Pochettino', 1, 'Kylian Mbappé',
        'Attacking'),
       (2, 'Bayern Munich', 'Germany', 'Europe', 'Bundesliga', 'Allianz Arena', 'Jupp Heynckes', 2,
        'Robert Lewandowski', 'Defending'),
       (3, 'Barcelona', 'Spain', 'Europe', 'La Liga', 'Camp Nou', 'Ronald Koeman', 3, 'Lionel Messi', 'Attacking'),
       (4, 'Real Madrid', 'Spain', 'Europe', 'La Liga', 'Santiago Bernabéu', 'Zinedine Zidane', 4, 'Luka Modrić',
        'Possession'),
       (5, 'Manchester United', 'England', 'Europe', 'Premier League', 'Old Trafford', 'Ole Gunnar Solskjær', 5,
        'Paul Pogba', 'Counter-Attacking'),
       (6, 'Juventus', 'Italy', 'Europe', 'Serie A', 'Allianz Stadium', 'Massimiliano Allegri', 6, 'Cristiano Ronaldo',
        'Defending'),
       (7, 'Liverpool', 'England', 'Europe', 'Premier League', 'Anfield', 'Jürgen Klopp', 7, 'Mohamed Salah',
        'Attacking'),
       (8, 'Chelsea', 'England', 'Europe', 'Premier League', 'Köln Arena', 'Frank Lampard', 8, 'NGolo Kanté',
        'Counter-Attacking'),
       (9, 'Arsenal', 'England', 'Europe', 'Premier League', 'Emirates Stadium', 'Mikel Arteta', 9,
        'Pierre-Emerick Aubameyang', 'Possession'),
       (10, 'Manchester City', 'England', 'Europe', 'Premier League', 'Etihad Stadium', 'Pep Guardiola', 10,
        'Raheem Sterling', 'Attacking'),
       (11, 'Tottenham Hotspur', 'England', 'Europe', 'Premier League', 'Tottenham Stadium', 'Jose Mourinho', 11,
        'Harry Kane', 'Counter-Attacking'),
       (12, 'Leeds United', 'England', 'Europe', 'EFL Championship', 'Elland Road', 'Marcelo Bielsa', 12,
        'Patrick Bamford', 'Possession'),
       (13, 'Middlesbrough', 'England', 'Europe', 'EFL Championship', 'Riverside Stadium', 'Jonathan Woodgate', 13,
        ' Britt Assombalonga', 'Defending'),
       (14, 'Fiorentina', 'Italy', 'Europe', 'Serie A', 'Stadio Artemio Franchi', 'Vincenzo Italiano', 14,
        'Franck Ribéry', 'Attacking'),
       (15, 'Roma', 'Italy', 'Europe', 'Serie A', 'Stadio Olimpico', 'Paulo Fonseca', 15, 'Daniele De Rossi',
        'Possession'),
       (16, 'AC Milan', 'Italy', 'Europe', 'Serie A', 'San Siro', 'Stefano Pioli', 16, 'Hakan Çalhanoğlu', 'Defending'),
       (17, 'Inter Milan', 'Italy', 'Europe', 'Serie A', 'San Siro', 'Antonio Conte', 17, 'Romelu Lukaku',
        'Counter-Attacking'),
       (18, 'Atletico Madrid', 'Spain', 'Europe', 'La Liga', 'Wanda Metropolitano', 'Diego Simeone', 18,
        'Antoine Griezmann', 'Possession'),
       (19, 'Benfica', 'Portugal', 'Europe', 'Primeira Liga', 'Estádio da Luz', 'Rui Vitoria', 19, 'Eduardo Salvio',
        'Attacking'),
       (20, 'PSV Eindhoven', 'Netherlands', 'Europe', 'Eredivisie', 'Philips Stadion', 'Ruud van Nistelrooy', 20,
        'Donyell Malen', 'Counter-Attacking'),
       (21, 'Ajax', 'Netherlands', 'Europe', 'Eredivisie', 'Johan Cruyff Arena', 'Erik ten Hag', 21, 'Dusan Tadic',
        'Possession'),
       (22, 'Marseille', 'France', 'Europe', 'Ligue 1', 'Stade Vélodrome', 'André Villas-Boas', 22, 'Dimitri Payet',
        'Attacking'),
       (23, 'Sevilla', 'Spain', 'Europe', 'La Liga', 'Ramón Sánchez Pizjuán', 'Julen Lopetegui', 23, 'Yassine Bounou',
        'Defending'),
       (24, 'Porto', 'Portugal', 'Europe', 'Primeira Liga', 'Estádio do Dragão', 'Sérgio Conceição', 24,
        'Yacine Brahimi', 'Counter-Attacking'),
       (25, 'Club Brugge', 'Belgium', 'Europe', 'Jupiler Pro League', 'Jan Breydel Stadium', 'Philippe Clement', 25,
        'Kevin De Bruyne', 'Possession'),
       (26, 'Dynamo Kyiv', 'Ukraine', 'Europe', 'Ukrainian Premier League', 'Olimpiyskiy Stadium', 'Oleh Blokhin', 26,
        'Andriy Yarmolenko', 'Attacking'),
       (27, 'Red Star Belgrade', 'Serbia', 'Europe', 'SuperLiga', 'Red Star Stadium', 'Dejan Stanković', 27,
        'Nikola Milenković', 'Defending'),
       (28, 'Rangers', 'Scotland', 'Europe', 'Scottish Premiership', 'Ibrox Stadium', 'Steven Gerrard', 28,
        'James Tavernier', 'Counter-Attacking'),
       (29, 'Celtic', 'Scotland', 'Europe', 'Scottish Premiership', 'Celtic Park', 'Neil Lennon', 29, 'Odsonne Édouard',
        'Possession'),
       (30, 'Zenit St. Petersburg', 'Russia', 'Europe', 'Russian Premier League', 'Krestovsky Stadium', 'Sergei Semak',
        30, 'Aleksandr Kokorin', 'Attacking');

INSERT INTO soccer.dim_match_venue_type (venue_type_id, venue_type_description, typical_capacity_range,
                                         common_facilities, historical_significance)
VALUES (1, 'Outdoor stadium', '10,000-100,000', 'Grandstand, Concession stands',
        ' Often used for major international matches'),
       (2, 'Indoor arena', '5,000-50,000', 'Seating areas, Concession stands',
        ' Often used for domestic league matches'),
       (3, 'Pitch', '0-2,000', 'Basic seating, Concession stands', ' Often used for youth matches or friendlies'),
       (4, 'Artificial pitch', '0-2,000', 'Basic seating, Concession stands',
        ' Often used for training sessions or small matches'),
       (5, 'Turf pitch', '0-2,000', 'Basic seating, Concession stands',
        ' Often used for training sessions or small matches');

INSERT INTO soccer.dim_venue (venue_id, venue_name, city, capacity, venue_type_id, year_built, surface_type, roof_type,
                              record_attendance, longitude, latitude, elevation, average_temperature)
VALUES (1, 'Allianz Arena', 'Munich', 75000, 1, 2005, 'Grass', 'Main roof', 75000, 11.7, 48.2, 508, 10.3),
       (2, 'Camp Nou', 'Barcelona', 98000, 1, 1957, 'Artificial', 'Main roof', 98000, 2.1, 41.4, 32, 16.5),
       (3, 'Old Trafford', 'Manchester', 75000, 1, 1910, 'Grass', 'Main roof', 75000, -2.2, 53.4, 34, 9.2),
       (4, 'Stade de France', 'Paris', 81000, 1, 1998, 'Artificial', 'Main roof', 81000, 2.3, 48.9, 90, 12.3),
       (5, 'Signal Iduna Park', 'Dortmund', 86000, 1, 2001, 'Grass', 'Main roof', 86000, 7.6, 51.5, 204, 11.3),
       (6, 'Wembley Stadium', 'London', 90000, 1, 2007, 'Grass', 'Main roof', 90000, -0.2, 51.5, 24, 11.5),
       (7, 'Estadio da Luz', 'Lisbon', 65000, 1, 2003, 'Artificial', 'Main roof', 65000, -9.2, 38.7, 40, 13.5),
       (8, 'Arena Nationala', 'Bucharest', 55000, 1, 2011, 'Grass', 'Main roof', 55000, 26.1, 44.4, 172, 16.2),
       (9, 'St. Jakob-Park', 'Basel', 42000, 1, 2001, 'Artificial', 'Main roof', 42000, 7.6, 47.5, 245, 8.7),
       (10, 'Stadio Olimpico', 'Rome', 72000, 1, 1937, 'Grass', 'Main roof', 72000, 12.5, 41.9, 40, 14.5),
       (11, 'Friends Arena', 'Stockholm', 51000, 1, 2012, 'Artificial', 'Main roof', 51000, 18.2, 59.3, 24, 7.3),
       (12, 'Benfica Stadium', 'Lisbon', 65000, 1, 2003, 'Grass', 'Main roof', 65000, -9.2, 38.7, 40, 13.5),
       (13, 'Red Bull Arena', 'Leipzig', 42000, 1, 2009, 'Artificial', 'Main roof', 42000, 12.4, 51.3, 105, 9.8),
       (14, 'San Siro', 'Milan', 85000, 1, 1926, 'Artificial', 'Main roof', 85000, 9.2, 45.5, 128, 13.1),
       (15, 'Anfield', 'Liverpool', 54000, 1, 1884, 'Grass', 'Main roof', 54000, -2.9, 53.3, 58, 9.5),
       (16, 'Mestalla', 'Valencia', 55000, 1, 1923, 'Grass', 'Main roof', 55000, -0.4, 39.5, 65, 13.4),
       (17, 'Jan Breydel Stadium', 'Bruges', 28000, 1, 1909, 'Grass', 'Main roof', 28000, 3.3, 51.2, 12, 10.6),
       (18, 'Turfgalmon Arena', 'Hilversum', 25000, 1, 2015, 'Artificial', 'Main roof', 25000, 5.3, 52.2, 5, 10.1),
       (19, 'Castel Di Sangro', 'Cassino', 12000, 1, 1954, 'Grass', 'Main roof', 12000, 13.1, 41.4, 25, 13.9),
       (20, 'Parc des Princes', 'Paris', 48000, 1, 1897, 'Grass', 'Main roof', 48000, 2.3, 48.9, 30, 12.3),
       (21, 'Tottenham Hotspur Stadium', 'London', 62000, 1, 2019, 'Artificial', 'Main roof', 62000, -0.2, 51.5, 24,
        11.5),
       (22, 'Old Trafford', 'Manchester', 75000, 1, 1909, 'Grass', 'Open', 76244, -2.7644, 53.4767, 14, 12.2),
       (23, 'Wembley Stadium', 'London', 90000, 1, 1923, 'Artificial', 'Roofed', 125154, -0.1555, 51.5815, 10, 12.4),
       (24, 'Camp Nou', 'Barcelona', 99000, 1, 1957, 'Artificial', 'Roofed', 135345, 2.0783, 41.3972, 20, 14.5),
       (25, 'Estadio Azteca', 'Mexico City', 112227, 1, 1966, 'Artificial', 'Open', 110000, -99.1015, 19.2410, 2240,
        15.3),
       (26, 'Stade de France', 'Paris', 81000, 1, 1998, 'Artificial', 'Roofed', 75788, 2.2356, 48.8961, 30, 11.2),
       (27, 'Red Bull Arena', 'Leipzig', 42000, 2, 2009, 'Artificial', 'Roofed', 37435, 12.3729, 51.3449, 130, 9.5),
       (28, 'Dynamo Stadium', 'Moscow', 28000, 2, 1956, 'Grass', 'Roofed', 23651, 37.6506, 55.7399, 120, 5.5),
       (29, 'Tottenham Hotspur Stadium', 'London', 62000, 1, 2019, 'Artificial', 'Roofed', 59372, -0.0809, 51.6173, 20,
        12.8),
       (30, 'Melbourne Cricket Ground', 'Melbourne', 100000, 1, 1853, 'Cricket pitch', 'Open', 94444, 144.9627,
        -37.8125, 43, 12.2),
       (31, 'FNB Stadium', 'Johannesburg', 94000, 1, 2009, 'Grass', 'Roofed', 85789, 28.0281, -26.2039, 1740, 17.3);


INSERT INTO soccer.dim_weather_condition (weather_id, condition_description, temperature_range, wind_speed_range,
                                          precipitation_chance, humidity_range)
VALUES (1, 'Clear sky', '10-25°C', '5-15 km/h', 0, '40-60%'),
       (2, 'Cloudy weather', '0-10°C', '10-20 km/h', 0, '80-100%'),
       (3, 'Light rain', '0-10°C', '10-15 km/h', 50, '70-90%'),
       (4, 'Heavy rain', '0-10°C', '20-25 km/h', 80, '90-100%'),
       (5, 'Snowy weather', '-5-5°C', '15-20 km/h', 0, '50-70%');

INSERT INTO soccer.dim_match_type (match_type_id, match_type_description, importance_level, typical_audience_size,
                                   prize_money, qualification_impact)
VALUES (1, 'League match', 'High', '50000-100000', 50000, 'Direct qualification'),
       (2, 'Cup final', 'High', '200000-500000', 1000000, 'Direct qualification'),
       (3, 'International friendly', 'Low', '5000-10000', 0, 'No qualification'),
       (4, 'Youth match', 'Low', '1000-5000', 0, 'No qualification'),
       (5, 'Training session', 'Low', '0', 0, 'No qualification');

INSERT INTO soccer.dim_match_official (official_id, official_name, nationality, role, years_of_experience,
                                       notable_tournaments, fitness_level)
VALUES (1, 'John Smith', 'English', 'Referee', 10, 'Euro 2012', 'Good'),
       (2, 'Jane Doe', 'Spanish', 'Referee', 12, 'World Cup 2018', 'Very Good'),
       (3, 'Bob Brown', 'Arabic', 'Assistant referee', 8, 'Africa Cup of Nations', 'Excellent'),
       (4, 'Alice Green', 'German', 'Fourth official', 6, 'Champions League', 'Good'),
       (5, 'Mike Davis', 'English', 'Video assistant referee', 4, 'Youth World Cup', 'Very Good'),
       (6, 'Emily Chen', 'French', 'Referee', 9, 'Euro 2020', 'Good'),
       (7, 'David Lee', 'Korean', 'Referee', 11, 'Asian Cup', 'Good'),
       (8, 'Sarah Johnson', 'American', 'Assistant referee', 7, 'Gold Cup', 'Very Good'),
       (9, 'Mark Taylor', 'Australian', 'Fourth official', 5, 'AFC Asian Cup', 'Excellent'),
       (10, 'Benjamin Lee', 'Chinese', 'Video assistant referee', 3, 'Chinese Super League', 'Good'),
       (11, 'Lily Patel', 'Indian', 'Referee', 10, 'Indian Super League', 'Very Good'),
       (12, 'Naomi Kim', 'Japanese', 'Referee', 9, 'Asian Games', 'Good'),
       (13, 'Alex Kim', 'Brazilian', 'Assistant referee', 8, 'Copa America', 'Excellent'),
       (14, 'Olivia Rodriguez', 'Mexican', 'Fourth official', 6, 'CONCACAF Champions League', 'Good'),
       (15, 'Ethan Brown', 'Canadian', 'Video assistant referee', 5, 'CONCACAF Gold Cup', 'Very Good'),
       (16, 'Ava Lee', 'Thai', 'Referee', 7, 'ASEAN Football Championship', 'Good'),
       (17, 'Julia Taylor', 'Belgian', 'Referee', 12, 'European Nations League', 'Very Good'),
       (18, 'Ryan Kim', 'South Korean', 'Referee', 10, 'K League', 'Good'),
       (19, 'Sophia Patel', 'Pakistani', 'Assistant referee', 9, 'SAFF Championship', 'Excellent'),
       (20, 'Matthew White', 'New Zealander', 'Fourth official', 8, 'OFC Champions League', 'Good'),
       (21, 'Emily Patel', 'Indonesian', 'Referee', 11, 'Southeast Asian Games', 'Very Good'),
       (22, 'Michael Brown', 'American', 'Assistant referee', 6, 'CONCACAF Nations League', 'Good'),
       (23, 'Rebecca Lee', 'South Korean', 'Fourth official', 9, 'K League Cup', 'Excellent'),
       (24, 'Kaitlyn Harris', 'English', 'Video assistant referee', 5, 'Womens World Cup', 'Good'),
       (25, 'Sophia Kim', 'Brazilian', 'Referee', 10, ' Copa Libertadores', 'Very Good'),
       (26, 'Alexander Brown', 'South African', 'Assistant referee', 8, 'CAF Champions League', 'Excellent'),
       (27, 'Jessica Patel', 'Indian', 'Fourth official', 7, 'I-League', 'Good'),
       (28, 'Diana Lee', 'Mexican', 'Video assistant referee', 4, 'Liga MX', 'Very Good'),
       (29, 'Rahul Patel', 'Pakistani', 'Referee', 9, 'SAFF Cup', 'Good'),
       (30, 'William Chen', 'French', 'Assistant referee', 6, 'Coupe de France', 'Excellent');

INSERT INTO soccer.dim_match_attendance_level (attendance_level_id, attendance_level_description,
                                               percentage_of_capacity, typical_atmosphere, ticket_price_impact)
VALUES (1, 'Full capacity', '100%', 'Electric', 'High'),
       (2, 'High attendance', '80-99%', 'Loud', 'Medium'),
       (3, 'Medium attendance', '50-79%', 'Moderate', 'Low'),
       (4, 'Low attendance', '20-49%', 'Quiet', 'Very Low'),
       (5, 'Empty stadium', '0-19%', 'Dead', 'No impact');

INSERT INTO soccer.dim_match_outcome_type (outcome_type_id, outcome_type_description, regulation_time_minutes,
                                           extra_time_format, penalty_shootout_format)
VALUES (1, 'Regulation time', 90, 'None', 'None'),
       (2, 'Extra time', 120, 'Two 15-minute periods', 'Five penalties'),
       (3, 'Penalty shootout', 0, 'None', 'Five penalties'),
       (4, 'Red card', 0, 'None', 'None'),
       (5, 'Yellow card', 0, 'None', 'None');

INSERT INTO soccer.dim_match_pitch_condition (pitch_condition_id, pitch_condition_description, grass_length,
                                              moisture_level, maintenance_frequency)
VALUES (1, 'Dry', 'Short', 'Dry', 'Daily'),
       (2, 'Wet', 'Medium', 'Wet', 'Weekly'),
       (3, 'Cool', 'Long', 'Dry', 'Bi-Weekly'),
       (4, 'Warm', 'Short', 'Moist', 'Daily'),
       (5, 'Firm', 'Medium', 'Dry', 'Weekly'),
       (6, 'Soft', 'Long', 'Wet', 'Bi-Weekly'),
       (7, 'Dry', 'Short', 'Dry', 'Daily'),
       (8, 'Moist', 'Medium', 'Moist', 'Weekly'),
       (9, 'Dry', 'Long', 'Dry', 'Bi-Weekly'),
       (10, 'Wet', 'Short', 'Wet', 'Daily'),
       (11, 'Cool', 'Medium', 'Dry', 'Weekly'),
       (12, 'Warm', 'Long', 'Moist', 'Bi-Weekly'),
       (13, 'Firm', 'Short', 'Dry', 'Daily'),
       (14, 'Soft', 'Medium', 'Wet', 'Weekly'),
       (15, 'Dry', 'Short', 'Dry', 'Daily'),
       (16, 'Moist', 'Medium', 'Moist', 'Weekly'),
       (17, 'Dry', 'Long', 'Dry', 'Bi-Weekly'),
       (18, 'Wet', 'Short', 'Wet', 'Daily'),
       (19, 'Cool', 'Medium', 'Dry', 'Weekly'),
       (20, 'Warm', 'Long', 'Moist', 'Bi-Weekly'),
       (21, 'Hard', 'Short', 'Dry', 'Daily'),
       (22, 'Soggy', 'Medium', 'Wet', 'Weekly'),
       (23, 'Cool', 'Long', 'Dry', 'Bi-Weekly'),
       (24, 'Warm', 'Short', 'Moist', 'Daily'),
       (25, 'Firm', 'Medium', 'Dry', 'Weekly'),
       (26, 'Soft', 'Long', 'Wet', 'Bi-Weekly'),
       (27, 'Dry', 'Short', 'Dry', 'Daily'),
       (28, 'Moist', 'Medium', 'Moist', 'Weekly'),
       (29, 'Dry', 'Long', 'Dry', 'Bi-Weekly'),
       (30, 'Wet', 'Short', 'Wet', 'Daily');

INSERT INTO soccer.dim_match_time_of_day (time_of_day_description, typical_start_time, lighting_conditions,
                                          expected_temperature)
VALUES ('Morning', '09:00:00', 'Daylight', 'Cool'),
       ('Late Morning', '10:00:00', 'Daylight', 'Mild'),
       ('Early Afternoon', '12:00:00', 'Daylight', 'Warm'),
       ('Afternoon', '13:00:00', 'Daylight', 'Hot'),
       ('Early Evening', '15:00:00', 'Daylight', 'Warm'),
       ('Twilight', '16:00:00', 'Artificial', 'Mild'),
       ('Night', '18:00:00', 'Artificial', 'Cool'),
       ('Early Night', '19:00:00', 'Artificial', 'Chilly'),
       ('Late Night', '20:00:00', 'Artificial', 'Cool'),
       ('Dawn', '06:00:00', 'Daylight', 'Chilly'),
       ('Early Dawn', '07:00:00', 'Daylight', 'Cool'),
       ('Late Dawn', '08:00:00', 'Daylight', 'Mild'),
       ('Pre-Dusk', '17:00:00', 'Daylight', 'Warm'),
       ('Sunset', '19:30:00', 'Daylight', 'Mild'),
       ('Post-Sunset', '20:00:00', 'Artificial', 'Cool'),
       ('Night Fall', '21:00:00', 'Artificial', 'Chilly'),
       ('Post-Midnight', '01:00:00', 'Artificial', 'Cool'),
       ('Early Morning', '05:00:00', 'Daylight', 'Chilly'),
       ('Morning Glow', '08:30:00', 'Daylight', 'Mild'),
       ('Late Morning Glow', '09:30:00', 'Daylight', 'Warm');

-- dim_match_outcome table
CREATE TABLE soccer.dim_match_outcome
(
    -- Unique identifier for each match outcome
    outcome_id             SERIAL PRIMARY KEY,
    -- Description of the match outcome (e.g. "Win", "Loss", etc.)
    outcome_description    VARCHAR(50),
    -- Number of points awarded for the match outcome
    points_awarded         INT,
    -- Impact of the match outcome on goal difference
    goal_difference_impact VARCHAR(50),
    -- Impact of the match outcome on league position
    league_position_impact VARCHAR(50)
);

INSERT INTO soccer.dim_match_outcome (outcome_id, outcome_description, points_awarded, goal_difference_impact,
                                      league_position_impact)
VALUES (1, 'Win', 3, 'Significant impact', 'Significant impact'),
       (2, 'Draw', 1, 'Moderate impact', 'Moderate impact'),
       (3, 'Loss', 0, 'Significant negative impact', 'Significant negative impact');
INSERT INTO soccer.dim_match_time_of_day (time_of_day_description, typical_start_time, lighting_conditions,
                                          expected_temperature)
VALUES ('Morning', '09:00:00', 'Daylight', 'Cool'),
       ('Late Morning', '10:00:00', 'Daylight', 'Mild'),
       ('Early Afternoon', '12:00:00', 'Daylight', 'Warm'),
       ('Afternoon', '13:00:00', 'Daylight', 'Hot'),
       ('Early Evening', '15:00:00', 'Daylight', 'Warm'),
       ('Twilight', '16:00:00', 'Artificial', 'Mild'),
       ('Night', '18:00:00', 'Artificial', 'Cool'),
       ('Early Night', '19:00:00', 'Artificial', 'Chilly'),
       ('Late Night', '20:00:00', 'Artificial', 'Cool'),
       ('Dawn', '06:00:00', 'Daylight', 'Chilly'),
       ('Early Dawn', '07:00:00', 'Daylight', 'Cool'),
       ('Late Dawn', '08:00:00', 'Daylight', 'Mild'),
       ('Pre-Dusk', '17:00:00', 'Daylight', 'Warm'),
       ('Sunset', '19:30:00', 'Daylight', 'Mild'),
       ('Post-Sunset', '20:00:00', 'Artificial', 'Cool'),
       ('Night Fall', '21:00:00', 'Artificial', 'Chilly'),
       ('Post-Midnight', '01:00:00', 'Artificial', 'Cool'),
       ('Early Morning', '05:00:00', 'Daylight', 'Chilly'),
       ('Morning Glow', '08:30:00', 'Daylight', 'Mild'),
       ('Late Morning Glow', '09:30:00', 'Daylight', 'Warm');

-- fact_match_statistics table
CREATE TABLE soccer.fact_match_statistics
(
    -- Unique identifier for each match
    match_id              SERIAL PRIMARY KEY,
    -- Date of the match
    match_date            DATE,
    -- Foreign key referencing the team
    team_id               INT REFERENCES soccer.dim_team (team_id),
    -- Foreign key referencing the opponent team
    opponent_id           INT REFERENCES soccer.dim_opponent_team (opponent_id),
    -- Foreign key referencing the venue
    venue_id              INT REFERENCES soccer.dim_venue (venue_id),
    -- Number of goals scored by the team
    goals_scored          INT,
    -- Number of goals conceded by the team
    goals_conceded        INT,
    -- Foreign key referencing the match outcome
    result                INT REFERENCES soccer.dim_match_outcome (outcome_id),
    -- Foreign key referencing the weather condition
    climate               INT REFERENCES soccer.dim_weather_condition (weather_id),
    -- Foreign key referencing the match type
    match_type            INT REFERENCES soccer.dim_match_type (match_type_id),
    -- Foreign key referencing the referee
    referee_id            INT REFERENCES soccer.dim_referee (referee_id),
    -- Foreign key referencing the match season
    season_id             INT REFERENCES soccer.dim_match_season (season_id),
    -- Foreign key referencing the pitch condition
    pitch_condition_id    INT REFERENCES soccer.dim_match_pitch_condition (pitch_condition_id),
    -- Foreign key referencing the time of day
    time_of_day_id        INT REFERENCES soccer.dim_match_time_of_day (time_of_day_id),
    -- Foreign key referencing the outcome type
    outcome_type_id       INT REFERENCES soccer.dim_match_outcome_type (outcome_type_id),
    -- Foreign key referencing the attendance level
    attendance_level_id   INT REFERENCES soccer.dim_match_attendance_level (attendance_level_id),
    -- Foreign key referencing the match official
    official_id           INT REFERENCES soccer.dim_match_official (official_id),
    -- Possession percentage of the team
    possession_percentage DECIMAL(5, 2),
    -- Number of shots on target by the team
    shots_on_target       INT,
    -- Number of shots off target by the team
    shots_off_target      INT,
    -- Number of corners won by the team
    corners               INT,
    -- Number of fouls committed by the team
    fouls_committed       INT,
    -- Number of yellow cards received by the team
    yellow_cards          INT,
    -- Number of red cards received by the team
    red_cards             INT,
    -- Number of offside calls against the team
    offsides              INT,
    -- Number of passes completed by the team
    passes_completed      INT,
    -- Pass accuracy percentage of the team
    pass_accuracy         DECIMAL(5, 2),
    -- Total distance covered by the team
    distance_covered      DECIMAL(7, 2),
    -- Number of saves made by the team
    saves_made            INT
);

INSERT INTO soccer.fact_match_statistics (match_date, team_id, opponent_id, venue_id, goals_scored, goals_conceded,
                                          result, climate, match_type, referee_id, season_id, pitch_condition_id,
                                          time_of_day_id, outcome_type_id, attendance_level_id, official_id,
                                          possession_percentage, shots_on_target, shots_off_target, corners,
                                          fouls_committed, yellow_cards, red_cards, offsides, passes_completed,
                                          pass_accuracy, distance_covered, saves_made)
VALUES ('2022-01-01', 1, 2, 3, 2, 1, 1, 1, 1, 2, 1, 1, 1, 1, 2, 3, 60.0, 8, 12, 3, 10, 2, 0, 3, 80, 70.0, 10, 5),
       ('2022-01-08', 1, 3, 4, 1, 2, 1, 1, 2, 4, 1, 2, 1, 1, 3, 5, 50.0, 5, 15, 1, 5, 2, 0, 1, 70, 65.0, 8, 2),
       ('2022-01-15', 2, 4, 5, 3, 0, 1, 1, 1, 2, 2, 3, 1, 1, 1, 6, 55.0, 7, 13, 2, 8, 1, 1, 2, 75, 60.0, 9, 3),
       ('2022-01-22', 4, 1, 6, 1, 1, 1, 1, 2, 1, 3, 4, 1, 1, 2, 7, 62.0, 6, 11, 2, 7, 1, 0, 2, 85, 70.0, 11, 4),
       ('2022-01-29', 3, 5, 7, 2, 2, 2, 1, 1, 3, 4, 5, 1, 2, 3, 8, 58.0, 9, 10, 3, 10, 2, 1, 3, 80, 65.0, 12, 5),
       ('2022-02-05', 6, 7, 8, 0, 2, 1, 1, 2, 5, 5, 6, 1, 1, 1, 9, 50.0, 4, 14, 1, 5, 1, 0, 1, 75, 60.0, 10, 2),
       ('2022-02-12', 5, 3, 9, 3, 1, 1, 1, 1, 4, 6, 7, 1, 1, 2, 10, 65.0, 10, 9, 4, 8, 2, 0, 4, 85, 70.0, 11, 6),
       ('2022-02-19', 2, 9, 10, 2, 0, 1, 1, 2, 6, 7, 8, 1, 1, 1, 11, 60.0, 8, 10, 3, 7, 1, 0, 3, 80, 65.0, 9, 3),
       ('2022-02-26', 1, 10, 11, 1, 2, 1, 1, 1, 7, 8, 9, 1, 1, 2, 12, 55.0, 6, 12, 2, 6, 1, 1, 2, 75, 60.0, 8, 2),
       ('2022-03-05', 8, 11, 12, 2, 0, 1, 1, 2, 8, 9, 10, 1, 1, 1, 13, 65.0, 9, 8, 4, 10, 2, 0, 4, 85, 70.0, 11, 5),
       ('2022-03-12', 3, 2, 13, 1, 2, 1, 1, 1, 9, 10, 11, 1, 1, 2, 14, 62.0, 7, 11, 2, 7, 1, 0, 2, 80, 70.0, 10, 4),
       ('2022-03-19', 4, 13, 14, 2, 1, 1, 1, 2, 10, 1, 12, 1, 1, 1, 15, 60.0, 8, 9, 3, 6, 1, 0, 3, 75, 65.0, 9, 3),
       ('2022-03-26', 5, 14, 15, 1, 2, 1, 1, 1, 11, 2, 13, 1, 1, 2, 16, 58.0, 5, 12, 1, 10, 2, 1, 1, 85, 70.0, 11, 5),
       ('2022-04-02', 6, 15, 16, 2, 0, 1, 1, 2, 12, 3, 14, 1, 1, 1, 17, 65.0, 10, 7, 4, 7, 1, 0, 4, 80, 70.0, 10, 4),
       ('2022-04-09', 7, 16, 17, 1, 2, 1, 1, 1, 13, 4, 15, 1, 1, 2, 18, 62.0, 7, 10, 2, 5, 1, 0, 2, 75, 65.0, 9, 3),
       ('2022-04-16', 8, 1, 18, 2, 1, 1, 1, 2, 14, 5, 16, 1, 1, 1, 19, 60.0, 8, 9, 3, 6, 1, 0, 3, 85, 70.0, 11, 5),
       ('2022-04-23', 4, 2, 19, 1, 2, 1, 1, 1, 15, 6, 17, 1, 1, 2, 20, 55.0, 5, 12, 1, 10, 2, 1, 1, 80, 70.0, 10, 4),
       ('2022-04-30', 3, 19, null, 2, 0, 1, 1, 2, 16, 7, 18, 1, 1, 1, 21, 65.0, 9, 6, 4, 7, 1, 0, 4, 85, 70.0, 11,
        5),
       ('2022-05-07', null, 3, 20, 1, 2, 1, 1, 1, 17, 8, 19, 1, 1, 2, 22, 58.0, 6, 10, 2, 5, 1, 0, 2, 75, 65.0, 9, 3),
       ('2022-05-14', 1, 20, 21, 2, 1, 1, 1, 2, 18, 9, 20, 1, 1, 1, 23, 60.0, 8, 8, 3, 6, 1, 0, 3, 80, 70.0, 10, 4),
       ('2022-05-21', 2, 21, 22, 1, 2, 1, 1, 1, 19, 1, 21, 1, 1, 2, 24, 62.0, 7, 9, 2, 7, 1, 0, 2, 85, 70.0, 11, 5),
       ('2022-05-28', 3, 22, 23, 2, 0, 1, 1, 2, 20, 2, 22, 1, 1, 1, 25, 65.0, 10, 5, 4, 10, 2, 0, 4, 80, 70.0, 10, 4),
       ('2022-06-04', 4, 23, 24, 1, 2, 1, 1, 1, 21, 2, 23, 1, 1, 2, 26, 55.0, 5, 11, 1, 5, 1, 0, 1, 75, 65.0, 9, 3),
       ('2022-06-11', 5, 24, 25, 2, 1, 1, 1, 2, 22, 3, 24, 1, 1, 1, 27, 58.0, 6, 10, 3, 7, 1, 0, 3, 80, 70.0, 10, 4),
       ('2022-06-18', 6, 25, null, 1, 2, 1, 1, 1, 23, 4, 24, 1, 1, 2, 28, 60.0, 7, 8, 2, 6, 1, 0, 2, 85, 70.0, 11,
        5),
       ('2022-06-25', null, 6, 26, 2, 0, 1, 1, 2, 24, 5, 26, 1, 1, 1, 29, 65.0, 9, 5, 4, 10, 2, 0, 4, 80, 70.0, 10, 4),
       ('2022-07-02', 7, 26, 27, 1, 2, 1, 1, 1, 25, 6, 27, 1, 1, 2, 30, 55.0, 5, 10, 1, 5, 1, 0, 1, 75, 65.0, 9, 3),
       ('2022-07-09', 8, 27, 28, 2, 1, 1, 1, 2, 26, 7, 28, 1, 1, 1, 1, 58.0, 6, 9, 3, 7, 1, 0, 3, 80, 70.0, 10, 4),
       ('2022-07-16', 9, 28, 29, 1, 2, 1, 1, 1, 27, 8, 29, 1, 1, 2, 2, 60.0, 7, 7, 2, 6, 1, 0, 2, 85, 70.0, 11, 5),
       ('2022-07-23', null, 9, 30, 2, 0, 1, 1, 2, 28, 9, 30, 1, 1, 1, 3, 65.0, 9, 4, 4, 10, 2, 0, 4, 80, 70.0, 10, 4),
       ('2022-07-30', 10, 30, 31, 1, 2, 1, 1, 1, 29, 10, 11, 1, 1, 2, 4, 55.0, 5, 9, 1, 5, 1, 0, 1, 75, 65.0, 9, 3),
       ('2022-08-06', 11, 11, 12, 2, 1, 1, 1, 2, 30, 11, 12, 1, 1, 1, 5, 58.0, 6, 8, 3, 7, 1, 0, 3, 80, 70.0, 10, 4),
       ('2022-08-13', 12, 12, 13, 1, 2, 1, 1, 1, 11, 2, 13, 1, 1, 2, 6, 60.0, 7, 6, 2, 6, 1, 0, 2, 85, 70.0, 11, 5),
       ('2022-08-20', 13, 13, 14, 2, 0, 1, 1, 2, 12, 3, 14, 1, 1, 1, 7, 65.0, 9, 3, 4, 10, 2, 0, 4, 80, 70.0, 10, 4),
       ('2022-08-27', null, 13, 15, 1, 2, 1, 1, 1, 13, 4, 15, 1, 1, 2, 8, 55.0, 5, 8, 1, 5, 1, 0, 1, 75, 65.0, 9, 3),
       ('2022-09-03', 14, 15, 16, 2, 1, 1, 1, 2, 14, 5, 16, 1, 1, 1, 9, 58.0, 6, 7, 3, 7, 1, 0, 3, 80, 70.0, 10, 4),
       ('2022-09-10', 15, 16, 17, 1, 2, 1, 1, 1, 15, 6, 17, 1, 1, 2, 10, 60.0, 7, 5, 2, 6, 1, 0, 2, 85, 70.0, 11, 5),
       ('2022-09-17', 16, 17, 18, 2, 0, 1, 1, 2, 16, 7, 18, 1, 1, 1, 11, 65.0, 9, 2, 4, 10, 2, 0, 4, 80, 70.0, 10, 4),
       ('2022-09-24', null, 16, 19, 1, 2, 1, 1, 1, 17, 8, 19, 1, 1, 2, 12, 55.0, 5, 7, 1, 5, 1, 0, 1, 75, 65.0, 9, 3),
       ('2022-10-01', 17, 19, 10, 2, 1, 1, 1, 2, 18, 9, 20, 1, 1, 1, 13, 58.0, 6, 6, 3, 7, 1, 0, 3, 80, 70.0, 10, 4),
       ('2022-10-01', 17, 19, 10, 2, 1, 1, 1, 2, 18, 9, 20, 1, 1, 1, 13, 58.0, 6, 6, 3, 7, 1, 0, 3, 80, 70.0, 10, 4),
       ('2022-10-08', 18, 10, 11, 1, 2, 1, 1, 1, 19, 10, 21, 1, 1, 2, 14, 60.0, 7, 4, 2, 6, 1, 0, 2, 85, 70.0, 11, 5),
       ('2022-10-15', 19, 11, 12, 2, 0, 1, 1, 2, 10, 11, 22, 1, 1, 1, 15, 65.0, 9, 1, 4, 10, 2, 0, 4, 80, 70.0, 10, 4),
       ('2022-10-22', 20, 12, 13, 1, 2, 1, 1, 1, 11, 12, 23, 1, 1, 2, 16, 55.0, 5, 6, 1, 5, 1, 0, 1, 75, 65.0, 9, 3),
       ('2022-10-29', 11, 13, 14, 2, 1, 1, 1, 2, 12, 13, 24, 1, 1, 1, 17, 58.0, 6, 5, 3, 7, 1, 0, 3, 80, 70.0, 10, 4),
       ('2022-11-05', 12, 14, 15, 1, 2, 1, 1, 1, 13, 14, 25, 1, 1, 2, 18, 60.0, 7, 3, 2, 6, 1, 0, 2, 85, 70.0, 11, 5),
       ('2022-11-12', 13, 15, 16, 2, 0, 1, 1, 2, 14, 5, 26, 1, 1, 1, 19, 65.0, 9, 0, 4, 10, 2, 0, 4, 80, 70.0, 10, 4),
       ('2022-11-19', null, 23, 17, 1, 2, 1, 1, 1, 15, 6, 27, 1, 1, 2, 20, 55.0, 5, 4, 1, 5, 1, 0, 1, 75, 65.0, 9, 3);
