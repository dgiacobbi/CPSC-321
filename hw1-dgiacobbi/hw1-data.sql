
/**********************************************************************
 * NAME: David Giacobbi
 * CLASS: CPSC 321-01
 * DATE: 9/22/22
 * HOMEWORK: HW-1
 * DESCRIPTION: This file populates the schema for HW-1 with at least two instances of data input.
                It also displays the tables to the terminal after insertion.
 **********************************************************************/

-- Delete any old data logged
DELETE FROM PricePlan;
DELETE FROM VehicleType; 
DELETE FROM AllowedPlan; 
DELETE FROM DefaultPlan;
DELETE FROM Vehicle;
DELETE FROM Customer;
DELETE FROM Trip;

-- Insert statements
INSERT INTO PricePlan VALUES
    ("Basic", 28, 52, 2),
    ("Deluxe", 16, 90, 0);

INSERT INTO VehicleType VALUES
    (834669, "e-scooter", "Bird", "EZ-Scoot", "GT8", "ScooterBird GT8", 24.4, 36.7, 43.5),
    (779356, "e-bike", "Tesla", "Model B", "TRX3", "Tesla Model B", 36.8, 14.9, 31.1);

INSERT INTO AllowedPlan VALUES
    (779356, "Basic"),
    (834669, "Basic"),
    (834669, "Deluxe");

INSERT INTO DefaultPlan VALUES
    (779356, "Basic"),
    (834669, "Basic");

INSERT INTO Vehicle VALUES
    (287, 779356, true, false, false, 12.567432, -100.738602, 7.78, 3.8),
    (895, 834669, true, true, false, -8.223095, 64.355423, 87.88, 29.9);

INSERT INTO Customer VALUES
    (4479, "Jeremy", "Curry", "jc34@hotmail.com"),
    (6682, "Bethany", "Stone", "stone-boss@yahoo.com");

INSERT INTO Trip VALUES
    (85674392, 4479, 895, "Basic", '2018:08:26 17:06:22', '2018:08:26 19:17:01', 12.443573, 10.888924, 11.673234, -1.998357),
    (10398273, 6682, 895, "Deluxe", '2020:03:04 08:35:58', '2020:03:04 12:04:21', 88.221232, -170.883745, 84.795423, -173.845329),
    (03945764, 6682, 287, "Basic", '2021:06:21 10:22:43', '2021:06:21 18:34:52', -34.882353, -6.223454, -21.342354, -7.234345),
    (56729484, 4479, 287, "Basic", '2022:08:18 14:34:09', '2022:08:18 19:22:33', 45.885632, 123.105973, 48.293456, 120.338534);

-- DefaultPlan Broken Foreign Key Test
-- INSERT INTO DefaultPlan VALUES
--     (779356, "Ultimate");

-- VehicleType Broken Foreign Key Test
-- INSERT INTO VehicleType VALUES
--      (234095, "e-car", "Toyota", "Prius", "ER2", "Toyota Hybrid", 65.2, 88.2, 90.3);

-- Vehicle Broken Foreign Key Test
-- INSERT INTO Vehicle VALUES
--     (763, 779256, true, false, false, 56.234956, -170.287354, 280.23, 45.33);

-- Add select statements (to print tables)
SELECT * FROM PricePlan;
SELECT * FROM VehicleType;
SELECT * FROM AllowedPlan;
SELECT * FROM DefaultPlan;
SELECT * FROM Vehicle;
SELECT * FROM Customer;
SELECT * FROM Trip;