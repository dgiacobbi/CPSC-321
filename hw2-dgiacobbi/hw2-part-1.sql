
/**********************************************************************
 * NAME: David Giacobbi
 * CLASS: CPSC 321-01
 * DATE: 10/10/22
 * HOMEWORK: #2
 * DESCRIPTION: This file creates the schema for the CIA World Factbook, 
                including all necessary keys, constraints, and suitable
                data types.
 **********************************************************************/


-- DROP TABLE Statements:
DROP TABLE IF EXISTS Border;
DROP TABLE IF EXISTS City;
DROP TABLE IF EXISTS Province;
DROP TABLE IF EXISTS Country;

-- CREATE TABLE Statements:
-- Country provides general name information and general economic stats
CREATE TABLE Country(
    country_code CHAR(2) NOT NULL,
    country_name VARCHAR(100) NOT NULL,
    gdp INT UNSIGNED NOT NULL, -- gross domestic product per capita
    inflation DECIMAL(4, 1) UNSIGNED NOT NULL, -- percentage
    PRIMARY KEY (country_code),
    CONSTRAINT inflation CHECK (inflation <= 100)
);

-- Province provides geographical info about provinces and their corresponding country
CREATE TABLE Province(
    province_name VARCHAR(100) NOT NULL,
    country_code CHAR(2) NOT NULL,
    area INT UNSIGNED NOT NULL, -- in square kilometers
    PRIMARY KEY (province_name, country_code),
    FOREIGN KEY (country_code)
        REFERENCES Country(country_code)
);

-- City provides relational info about the city's country and province as well as population
CREATE TABLE City(
    city_name VARCHAR(100) NOT NULL,
    province_name VARCHAR(100) NOT NULL,
    country_code CHAR(2) NOT NULL,
    population INT UNSIGNED NOT NULL,
    PRIMARY KEY (city_name, province_name, country_code),
    FOREIGN KEY (province_name, country_code)
        REFERENCES Province(province_name, country_code)
);

-- Border provides the distance of borders between neighboring countries
CREATE TABLE Border(
    country_code_1 CHAR(2) NOT NULL,
    country_code_2 CHAR(2) NOT NULL,
    border_length INT UNSIGNED NOT NULL, -- in kilometers
    PRIMARY KEY (country_code_1, country_code_2),
    FOREIGN KEY (country_code_1)
        REFERENCES Country(country_code),
    FOREIGN KEY (country_code_2)
        REFERENCES Country(country_code)
);

-- INSERT Statements:
INSERT INTO Country VALUES
    ("US", "United States of America", 63543, 8.3),
    ("MX", "Mexico", 8346, 8.7),
    ("CN", "Canada", 43241, 7.6);

INSERT INTO Province VALUES
    -- United States
    ("California", "US", 423971),
    ("Arizona", "US", 295253),
    ("Washington", "US", 184670),

    -- Mexico
    ("Durango", "MX", 123360),
    ("Jalisco", "MX", 78588),
    ("Chihuahua", "MX", 247450),

    -- Canada
    ("Alberta", "CN", 661848),
    ("British Columbia", "CN", 944734),
    ("Ontario", "CN", 1076000);

INSERT INTO City VALUES
    -- California
    ("San Diego", "California", "US", 1415000),
    ("Los Angeles", "California", "US", 3973000),
    ("San Francisco", "California", "US", 874784),

    -- Arizona
    ("Chandler", "Arizona", "US", 257076),
    ("Scottsdale", "Arizona", "US", 254995),
    ("Flagstaff", "Arizona", "US", 73319),

    -- Washington
    ("Spokane", "Washington", "US", 219185),
    ("Seattle", "Washington", "US", 741251),
    ("Wenatchee", "Washington", "US", 34249),

    -- Durango
    ("Santiago Papasquiaro", "Durango", "MX", 26000),
    ("Nazas", "Durango", "MX", 3600),
    ("Suchil", "Durango", "MX", 4100),
    ("Chandler", "Durango", "MX", 257076),

    -- Jalisco
    ("Guadalajara", "Jalisco", "MX", 1400000),
    ("Zapopan", "Jalisco", "MX", 1500000),
    ("Tequila", "Jalisco", "MX", 41000),

    -- Chihuahua
    ("Ciudad Juarez", "Chihuahua", "MX", 1500000),
    ("Delicias", "Chihuahua", "MX", 148045),
    ("Ocampo", "Chihuahua", "MX", 51073),

    -- Alberta
    ("Calgary", "Alberta", "CN", 1300000),
    ("Red Deer", "Alberta", "CN", 100000),
    ("St. Albert", "Alberta", "CN", 68000),

    -- British Columbia
    ("Vancouver", "British Columbia", "CN", 660000),
    ("Victoria", "British Columbia", "CN", 80000),
    ("Delta", "British Columbia", "CN", 100000),

    -- Ontario
    ("Toronto", "Ontario", "CN", 3000000),
    ("Windsor", "Ontario", "CN", 220000),
    ("Ottawa", "Ontario", "CN", 880000),
    ("Spokane", "Ontario", "CN", 400000);

INSERT INTO Border VALUES
    ("US", "CN", 8891),
    ("US", "MX", 3145);

SELECT * FROM Country;
SELECT * FROM Province;
SELECT * FROM City;
SELECT * FROM Border;