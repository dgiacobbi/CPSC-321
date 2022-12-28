
/**********************************************************************
 * NAME: David Giacobbi
 * CLASS: CPSC 321-01
 * DATE: 9/22/22
 * HOMEWORK: HW-1
 * DESCRIPTION: This file creates the following relations for HW-1, specifying attributes, constraints, and keys.
 **********************************************************************/


-- Drop table statements
DROP TABLE IF EXISTS PricePlan;
DROP TABLE IF EXISTS VehicleType; 
DROP TABLE IF EXISTS AllowedPlan; 
DROP TABLE IF EXISTS DefaultPlan;
DROP TABLE IF EXISTS Vehicle;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Trip;

-- PricePlan provides a list of different pricing plans for the vehicle rental service.
-- It includes the incremental charges that are summed in the final bill for the customer.
CREATE TABLE PricePlan(
    plan_name VARCHAR(50) UNIQUE,
    price_per_min INT UNSIGNED NOT NULL, -- in cents
    unlock_price INT UNSIGNED NOT NULL,-- in cents
    rate_start_min INT UNSIGNED NOT NULL, -- minutes after vehicle is unlocked before charges start
    PRIMARY KEY (plan_name)
);

-- VehicleType provides the specifications for each kind of vehicle on the market.
CREATE TABLE VehicleType(
    vt_id INT UNSIGNED NOT NULL,
    form_factor ENUM("e-scooter", "e-bike"), -- vehicle classification
    make VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    trim_level VARCHAR(50) NOT NULL,
    alt_name VARCHAR(50), -- optional
    max_spd DECIMAL(3,1) UNSIGNED, -- optional
    max_range DECIMAL(3,1) UNSIGNED NOT NULL, -- range in miles
    weight DECIMAL(3,1) UNSIGNED, -- optional, in pounds
    PRIMARY KEY (vt_id)
);

-- AllowedPlan has a list of all available pricing plans for each of the vehicle types.
CREATE TABLE AllowedPlan(
    vt_id INT UNSIGNED NOT NULL,
    price_plan VARCHAR(50) NOT NULL,
    PRIMARY KEY (vt_id, price_plan),
    FOREIGN KEY (vt_id)
        REFERENCES VehicleType(vt_id),
    FOREIGN KEY (price_plan)
        REFERENCES PricePlan(plan_name)    
);

-- DefaultPlan has a base plan that is given to each vehicle type, unless the consumer picks a different one
CREATE TABLE DefaultPlan(
    vt_id INT UNSIGNED NOT NULL,
    price_plan VARCHAR(50) NOT NULL,
    PRIMARY KEY (vt_id),
    FOREIGN KEY (vt_id, price_plan)
        REFERENCES AllowedPlan(vt_id, price_plan)
);

-- Vehicle provides location and circulation details about each specific vehicle recorded by the database
CREATE TABLE Vehicle(
    v_id INT UNSIGNED NOT NULL,
    vt_id INT UNSIGNED NOT NULL,
    in_circ BOOLEAN NOT NULL, -- in circulation
    is_reserved BOOLEAN NOT NULL,
    is_disabled BOOLEAN NOT NULL, -- available for use or not
    lat DECIMAL(8,6) NOT NULL, -- latitude
    lon DECIMAL(9,6) NOT NULL, -- longitude
    cur_fuel_pct DECIMAL(4,2) UNSIGNED NOT NULL, -- percentage of fuel left
    cur_range DECIMAL(4,2) UNSIGNED NOT NULL, -- range in miles
    PRIMARY KEY (v_id),
    FOREIGN KEY (vt_id)
        REFERENCES VehicleType(vt_id),
    CONSTRAINT lat CHECK (lat <= 90 && lat >= -90),
    CONSTRAINT lon CHECK (lon <= 180 && lon >= -180),
    CONSTRAINT cur_fuel_pct CHECK (cur_fuel_pct <= 100 && cur_fuel_pct >= 0)
);

-- Customer has a record of any customers who have used the provided vehicles in the past
CREATE TABLE Customer(
    c_id INT UNSIGNED NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    PRIMARY KEY (c_id)
);

-- Trip has a record of any trips taken on a vehicle. Additionally is has GPS and pricing information
-- about the transaction that occurred.
CREATE TABLE Trip(
    t_id INT UNSIGNED NOT NULL,
    c_id INT UNSIGNED NOT NULL,
    v_id INT UNSIGNED NOT NULL,
    price_plan VARCHAR(50) NOT NULL,
    start_dtime DATETIME NOT NULL, -- start of ride time
    end_dtime DATETIME NOT NULL, -- end of ride time
    start_lat DECIMAL(8,6) NOT NULL, -- start latitude
    start_lon DECIMAL(9,6) NOT NULL, -- start longitude
    end_lat DECIMAL(8,6) NOT NULL, -- end latitude
    end_lon DECIMAL(9,6) NOT NULL, -- end longitude
    PRIMARY KEY (t_id),
    FOREIGN KEY (c_id)
        REFERENCES Customer(c_id),
    FOREIGN KEY (v_id)
        REFERENCES Vehicle(v_id),
    FOREIGN KEY (price_plan)
        REFERENCES PricePlan(plan_name),  
    CONSTRAINT start_lat CHECK (start_lat <= 90 && start_lat >= -90),
    CONSTRAINT start_lon CHECK (start_lon <= 180 && start_lon >= -180),
    CONSTRAINT end_lat CHECK (end_lat <= 90 && end_lat >= -90),
    CONSTRAINT end_lon CHECK (end_lon <= 180 && end_lon >= -180)
);