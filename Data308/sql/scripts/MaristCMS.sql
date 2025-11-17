CREATE DATABASE IF NOT EXISTS MaristCMS;
USE MaristCMS;

SET FOREIGN_KEY_CHECKS=0;

-- Drop tables if they already exist
DROP TABLE IF EXISTS employer_has_locations;
DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS records;
DROP TABLE IF EXISTS admin;
DROP TABLE IF EXISTS message;
DROP TABLE IF EXISTS child;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS partner;
DROP TABLE IF EXISTS employer;
DROP TABLE IF EXISTS school;
DROP TABLE IF EXISTS company;
DROP TABLE IF EXISTS message_recipients;

SET FOREIGN_KEY_CHECKS=1;

-- Company Table (No dependencies)
CREATE TABLE company (
    company_id INT PRIMARY KEY AUTO_INCREMENT,
    fax_number VARCHAR(20),
    phone_number VARCHAR(20),
    email VARCHAR(320) UNIQUE NOT NULL,
    number_of_employees INT
);

-- School Table (No dependencies)
CREATE TABLE school (
    school_id INT PRIMARY KEY AUTO_INCREMENT,
    school_name VARCHAR(100) NOT NULL,
    graduation_year INT,
    degree_type VARCHAR(45),
    school_type VARCHAR(45)
);

-- Employer Table (No foreign keys yet)
CREATE TABLE employer (
    employer_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_type VARCHAR(45),
    fax_number VARCHAR(20),
    phone_number VARCHAR(20),
    number_of_employees INT,
    company_id INT
);

-- Partner Table (No foreign keys yet)
CREATE TABLE partner (
    partner_id INT PRIMARY KEY AUTO_INCREMENT,
    partner_name VARCHAR(100) NOT NULL,
    birth_year INT,
    birth_month INT,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    user_id INT -- Add foreign key later
);

-- Users Table (No foreign keys yet)
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_password VARCHAR(30) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    home_phone_number VARCHAR(20),
    email VARCHAR(320) UNIQUE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    fax_number VARCHAR(20),
    age TINYINT,
    birth_year YEAR,
    birth_month TINYINT,
    birth_day TINYINT,
    partner_id INT, -- Foreign key will be added later
    employer_id INT, -- Foreign key will be added later
    school_id INT -- Foreign key will be added later
);

-- Child Table (Depends on users)
CREATE TABLE child (
    child_id INT PRIMARY KEY AUTO_INCREMENT,
    child_name VARCHAR(100) NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    birth_year YEAR,
    birth_month TINYINT,
    age TINYINT,
    user_id INT -- Foreign key will be added later
);

-- Message Table (Depends on users) - Store a message only once even if many recipients
CREATE TABLE message (
    message_id INT PRIMARY KEY AUTO_INCREMENT,
    message_type ENUM('TEXT', 'IMAGE', 'VIDEO') NOT NULL,
    message_date DATE,
    user_id_sent INT NOT NULL,
    FOREIGN KEY (user_id_sent) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Message Recipients Table (Depends on Message and Users) - Matches users to message reciepts
CREATE TABLE message_recipients (
    message_id INT NOT NULL,
    recipient_id INT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE, -- Track if the recipient has read the message
    PRIMARY KEY (message_id, recipient_id),
    FOREIGN KEY (message_id) REFERENCES message(message_id) ON DELETE CASCADE,
    FOREIGN KEY (recipient_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Admin Table (Depends on employer)
CREATE TABLE admin (
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    admin_password VARCHAR(35) NOT NULL,
    email VARCHAR(320) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    home_phone_number VARCHAR(20),
    employer_id INT -- Foreign key will be added later
);

-- Records Table (Depends on users)
CREATE TABLE records (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    record_content TEXT NOT NULL,
    record_type VARCHAR(45),
    record_date DATE,
    user_id INT -- Foreign key will be added later
);

-- Locations Table (Depends on employer)
CREATE TABLE locations (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(320),
    location_address VARCHAR(255),
    phone_number VARCHAR(20),
    employer_id INT -- Foreign key will be added later
);

-- Employer_has_Locations Table (Depends on employer and locations)
CREATE TABLE employer_has_locations (
    employer_id INT NOT NULL,
    location_id INT NOT NULL,
    PRIMARY KEY (employer_id, location_id)
);

-- Insert Data Into Tables --

-- Empty The Tables --
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_SAFE_UPDATES = 0;

DELETE FROM employer_has_locations;
DELETE FROM locations;
DELETE FROM records;
DELETE FROM admin;
DELETE FROM message;
DELETE FROM child;
DELETE FROM users;
DELETE FROM partner;
DELETE FROM employer;
DELETE FROM school;
DELETE FROM company;

SET FOREIGN_KEY_CHECKS = 1;
SET SQL_SAFE_UPDATES = 1;

-- Company -- 
INSERT INTO company (fax_number, phone_number, email, number_of_employees) VALUES
('123-456-7890', '987-654-3210', 'info@company1.com', 500),
('223-456-7890', '687-654-3210', 'info@company2.com', 1200),
('323-456-7890', '787-654-3210', 'info@company3.com', 300),
('423-456-7890', '887-654-3210', 'info@company4.com', 150),
('523-456-7890', '987-654-3210', 'info@company5.com', 400),
('623-456-7890', '687-654-3210', 'info@company6.com', 1000),
('723-456-7890', '787-654-3210', 'info@company7.com', 700),
('823-456-7890', '887-654-3210', 'info@company8.com', 50),
('923-456-7890', '987-654-3210', 'info@company9.com', 900),
('1023-456-7890', '687-654-3210', 'info@company10.com', 350);

-- School --
INSERT INTO school (school_name, graduation_year, degree_type, school_type) VALUES
('Marist College', 2024, 'Bachelor', 'Private'),
('NYU', 2025, 'Master', 'Public'),
('Harvard', 2023, 'PhD', 'Ivy League'),
('Stanford', 2022, 'Bachelor', 'Private'),
('MIT', 2021, 'Master', 'Private'),
('Princeton', 2023, 'PhD', 'Ivy League'),
('Columbia', 2024, 'Bachelor', 'Private'),
('Cornell', 2022, 'Master', 'Private'),
('UCLA', 2021, 'Bachelor', 'Public'),
('Yale', 2023, 'PhD', 'Ivy League');

-- Employer depends on Company --
INSERT INTO employer (employee_type, fax_number, phone_number, number_of_employees, company_id) VALUES
('Full-Time', '111-222-3333', '444-555-6666', 50, 1),
('Part-Time', '211-222-3333', '544-555-6666', 120, 2),
('Contract', '311-222-3333', '644-555-6666', 30, 3),
('Intern', '411-222-3333', '744-555-6666', 20, 4),
('Consultant', '511-222-3333', '844-555-6666', 80, 5),
('Freelance', '611-222-3333', '944-555-6666', 10, 6),
('Temporary', '711-222-3333', '1044-555-6666', 15, 7),
('Remote', '811-222-3333', '1144-555-6666', 60, 8),
('On-Site', '911-222-3333', '1244-555-6666', 100, 9),
('Manager', '1011-222-3333', '1344-555-6666', 200, 10);

-- Partner --
INSERT INTO partner (partner_name, birth_year, birth_month, gender) VALUES
('Alice Johnson', 1985, 5, 'Female'),
('Bob Smith', 1990, 8, 'Male'),
('Charlie Adams', 1992, 12, 'Other'),
('Diana Prince', 1987, 3, 'Female'),
('Ethan Hunt', 1991, 9, 'Male'),
('Felicity Smoak', 1995, 6, 'Female'),
('George Benson', 1988, 7, 'Male'),
('Hannah Montana', 1993, 4, 'Female'),
('Isaac Newton', 1996, 10, 'Male'),
('Jessica Jones', 1989, 11, 'Female');

-- Users depends on Partner, Employer, School -- 
INSERT INTO users (user_password, phone_number, home_phone_number, email, gender, fax_number, age, birth_year, birth_month, birth_day, partner_id, employer_id, school_id) VALUES
('password1', '555-1111', '555-2222', 'user1@example.com', 'Male', '555-3333', 30, 1994, 5, 20, 1, 1, 1),
('password2', '555-4444', '555-5555', 'user2@example.com', 'Female', '555-6666', 28, 1996, 3, 10, 2, 2, 2),
('password3', '555-7777', NULL, 'user3@example.com', 'Other', NULL, 32, 1992, 7, 25, 3, 3, 3),
('password4', '555-8888', '555-9999', 'user4@example.com', 'Male', '555-0000', 35, 1989, 12, 5, 4, 4, 4),
('password5', '555-1212', NULL, 'user5@example.com', 'Female', '555-3434', 40, 1984, 10, 15, 5, 5, 5),
('password6', '555-5656', '555-7878', 'user6@example.com', 'Male', '555-9090', 29, 1995, 6, 30, 6, 6, 6),
('password7', '555-2323', '555-4545', 'user7@example.com', 'Female', '555-6767', 31, 1993, 2, 18, 7, 7, 7),
('password8', '555-8989', NULL, 'user8@example.com', 'Other', NULL, 33, 1991, 4, 8, 8, 8, 8),
('password9', '555-5454', '555-7676', 'user9@example.com', 'Male', '555-9898', 37, 1987, 1, 12, 9, 9, 9),
('password10', '555-3232', NULL, 'user10@example.com', 'Female', '555-4343', 26, 1998, 11, 22, 10, 10, 10);

-- Child depends on Users --
INSERT INTO child (child_name, gender, birth_year, birth_month, age, user_id) VALUES
('Tom', 'Male', 2015, 6, 9, 1),
('Lily', 'Female', 2018, 4, 6, 2),
('Jake', 'Male', 2016, 3, 8, 3),
('Sophie', 'Female', 2014, 2, 10, 4),
('Ethan', 'Male', 2013, 1, 11, 5),
('Emma', 'Female', 2017, 5, 7, 6),
('Lucas', 'Male', 2019, 7, 5, 7),
('Mia', 'Female', 2020, 8, 4, 8),
('Liam', 'Male', 2021, 9, 3, 9),
('Noah', 'Male', 2022, 10, 2, 10);

-- Locations depends on Employer --
INSERT INTO locations (email, location_address, phone_number, employer_id) VALUES
('loc1@company.com', '123 Main St, NY', '555-1111', 1),
('loc2@company.com', '456 Oak St, CA', '555-2222', 2),
('loc3@company.com', '789 Pine St, TX', '555-3333', 3),
('loc4@company.com', '321 Elm St, FL', '555-4444', 4),
('loc5@company.com', '654 Birch St, OH', '555-5555', 5),
('loc6@company.com', '987 Cedar St, IL', '555-6666', 6),
('loc7@company.com', '147 Aspen St, CO', '555-7777', 7),
('loc8@company.com', '258 Redwood St, WA', '555-8888', 8),
('loc9@company.com', '369 Maple St, GA', '555-9999', 9),
('loc10@company.com', '741 Palm St, NV', '555-0000', 10);

-- Employer Has Locations depends on Employer and location
INSERT INTO employer_has_locations (employer_id, location_id) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

-- Records depends on Users --
INSERT INTO records (record_content, record_type, record_date, user_id) VALUES
('User1 record', 'Medical', '2024-02-01', 1),
('User2 record', 'Employment', '2024-02-02', 2),
('User3 record', 'Academic', '2024-02-03', 3),
('User4 record', 'Criminal', '2024-02-04', 4),
('User5 record', 'Medical', '2024-02-05', 5),
('User6 record', 'Employment', '2024-02-06', 6),
('User7 record', 'Academic', '2024-02-07', 7),
('User8 record', 'Criminal', '2024-02-08', 8),
('User9 record', 'Medical', '2024-02-09', 9),
('User10 record', 'Employment', '2024-02-10', 10);

-- Message depends on Users -- 
INSERT INTO message (message_type, message_date, user_id_sent) VALUES
('TEXT', '2024-02-01', 1),
('IMAGE', '2024-02-02', 2),
('VIDEO', '2024-02-03', 3),
('TEXT', '2024-02-04', 4),
('IMAGE', '2024-02-05', 5),
('VIDEO', '2024-02-06', 6),
('TEXT', '2024-02-07', 7),
('IMAGE', '2024-02-08', 8),
('VIDEO', '2024-02-09', 9),
('TEXT', '2024-02-10', 10);

-- Message Recipients depends on Users and Messages
INSERT INTO message_recipients (message_id, recipient_id, is_read) VALUES
(1, 2, FALSE),  -- Message 1 sent to User 2
(1, 3, FALSE),  -- Message 1 sent to User 3
(2, 3, FALSE),  -- Message 2 sent to User 3
(3, 4, FALSE),  -- Message 3 sent to User 4
(4, 5, FALSE),  -- Message 4 sent to User 5
(5, 6, FALSE),  -- Message 5 sent to User 6
(6, 7, FALSE),  -- Message 6 sent to User 7
(7, 8, FALSE),  -- Message 7 sent to User 8
(8, 9, FALSE),  -- Message 8 sent to User 9
(9, 10, FALSE), -- Message 9 sent to User 10
(10, 1, FALSE); -- Message 10 sent to User 1

-- Admin depends on Employer --
INSERT INTO admin (admin_password, email, phone_number, home_phone_number, employer_id) VALUES
('adminpass1', 'admin1@company.com', '555-1111', '555-2222', 1),
('adminpass2', 'admin2@company.com', '555-3333', '555-4444', 2),
('adminpass3', 'admin3@company.com', '555-5555', '555-6666', 3),
('adminpass4', 'admin4@company.com', '555-7777', '555-8888', 4),
('adminpass5', 'admin5@company.com', '555-9999', '555-0000', 5),
('adminpass6', 'admin6@company.com', '555-1234', '555-5678', 6),
('adminpass7', 'admin7@company.com', '555-8765', '555-4321', 7),
('adminpass8', 'admin8@company.com', '555-2345', '555-6789', 8),
('adminpass9', 'admin9@company.com', '555-9876', '555-5432', 9),
('adminpass10', 'admin10@company.com', '555-3456', '555-7890', 10);

-- Add Foreign Key Constraints -- 

ALTER TABLE employer 
    ADD CONSTRAINT FK_employer_company FOREIGN KEY (company_id) REFERENCES company(company_id);

ALTER TABLE partner 
    ADD CONSTRAINT FK_partner_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE;

ALTER TABLE users 
    ADD CONSTRAINT FK_users_partner FOREIGN KEY (partner_id) REFERENCES partner(partner_id) ON DELETE CASCADE,
    ADD CONSTRAINT FK_users_employer FOREIGN KEY (employer_id) REFERENCES employer(employer_id) ON DELETE SET NULL,
    ADD CONSTRAINT FK_users_school FOREIGN KEY (school_id) REFERENCES school(school_id) ON DELETE SET NULL;

ALTER TABLE child 
    ADD CONSTRAINT FK_child_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE;

ALTER TABLE message 
    ADD CONSTRAINT FK_message_sent FOREIGN KEY (user_id_sent) 
    REFERENCES users(user_id) ON DELETE CASCADE;

ALTER TABLE message_recipients 
    ADD CONSTRAINT FK_message_recipient FOREIGN KEY (recipient_id) 
    REFERENCES users(user_id) ON DELETE CASCADE,
    ADD CONSTRAINT FK_message_id FOREIGN KEY (message_id) 
    REFERENCES message(message_id) ON DELETE CASCADE;

ALTER TABLE admin 
    ADD CONSTRAINT FK_admin_employer FOREIGN KEY (employer_id) REFERENCES employer(employer_id) ON DELETE SET NULL;

ALTER TABLE records 
    ADD CONSTRAINT FK_records_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE;

ALTER TABLE locations 
    ADD CONSTRAINT FK_locations_employer FOREIGN KEY (employer_id) REFERENCES employer(employer_id) ON DELETE CASCADE;

ALTER TABLE employer_has_locations 
    ADD CONSTRAINT FK_employer_has_locations_employer FOREIGN KEY (employer_id) REFERENCES employer(employer_id) ON DELETE CASCADE,
    ADD CONSTRAINT FK_employer_has_locations_location FOREIGN KEY (location_id) REFERENCES locations(location_id) ON DELETE CASCADE;

-- Alter Users to properly use 1NF for Birth Date --
SET SQL_SAFE_UPDATES = 0;
ALTER TABLE users 
ADD COLUMN birth_date DATE AFTER birth_day;
UPDATE users 
SET birth_date = STR_TO_DATE(CONCAT(birth_year, '-', birth_month, '-', birth_day), '%Y-%m-%d');
ALTER TABLE users 
DROP COLUMN birth_year, 
DROP COLUMN birth_month, 
DROP COLUMN birth_day;
SET SQL_SAFE_UPDATES = 1;

-- Alter Users to properly use 3NF for Dynamic Age Determination --

UPDATE users 
SET age = YEAR(CURDATE()) - birth_year;

ALTER TABLE users
DROP COLUMN age;
/*
Can use this query below to get dynamic age when needed
SELECT user_id, 
       user_password, 
       phone_number, 
       home_phone_number, 
       email, 
       gender, 
       fax_number, 
       birth_date, 
       (YEAR(CURDATE()) - YEAR(birth_date)) AS age
FROM users;
*/

-- Creating an Admin User - Grant all privileges EXCEPT DROP and TRUNCATE
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'AdminPass123';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, INDEX, ALTER ON MaristCMS.* TO 'admin_user'@'localhost';


/* Examples of Admin Permissions

-- Inserting --
INSERT INTO users (user_password, phone_number, home_phone_number, email, gender, fax_number, age, birth_date, partner_id, employer_id, school_id) 
VALUES ('newpass123', '555-9999', '555-8888', 'newuser@example.com', 'Male', NULL, 27, '1997-06-15', NULL, NULL, NULL);

-- Granting Permissions --
GRANT DELETE ON MaristCMS.users TO 'regular_user'@'localhost';

-- Deleting Records in Database --
DELETE FROM users WHERE email = 'user3@example.com';

*/

-- Creating a Regular User
CREATE USER 'regular_user'@'localhost' IDENTIFIED BY 'UserPass123';
GRANT SELECT, INSERT, UPDATE ON MaristCMS.users TO 'regular_user'@'localhost';
GRANT SELECT ON MaristCMS.records TO 'regular_user'@'localhost';

/* Examples of User Permissions

-- Updating Records --
UPDATE users SET phone_number = '555-1234' WHERE email = 'user1@example.com';

-- Viewing Records --
SELECT * FROM records;

-- Restricted Action - Deleting Records --
DELETE FROM users WHERE email = 'user3@example.com';


*/