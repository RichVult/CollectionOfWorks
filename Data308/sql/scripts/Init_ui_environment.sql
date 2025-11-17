-- =========================
-- MaristCMS.sql
-- =========================

-- START MaristCMS.sql 
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
DROP TABLE IF EXISTS Trush;
DROP TABLE IF EXISTS contacts;


SET FOREIGN_KEY_CHECKS=1;

-- Company Table (No dependencies)
CREATE TABLE company (
    company_id INT PRIMARY KEY AUTO_INCREMENT,
    company_name VARCHAR(100) NOT NULL,
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
    fName VARCHAR(50) NOT NULL,
    lName VARCHAR(50) NOT NULL,
    user_password VARCHAR(30) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    home_phone_number VARCHAR(20),
    email VARCHAR(320) UNIQUE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    fax_number VARCHAR(20),
    birth_date DATE,
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
    user_id_recieve INT NOT NULL,
    message_content TEXT,
    FOREIGN KEY (user_id_sent) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id_recieve) REFERENCES users(user_id) ON DELETE CASCADE
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
    admin_password VARCHAR(64) NOT NULL,
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

-- Contacts Table (User-to-User relationships)
CREATE TABLE contacts (
    contact_id INT PRIMARY KEY AUTO_INCREMENT,
    owner_user_id INT NOT NULL,
    contact_user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (owner_user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (contact_user_id) REFERENCES users(user_id) ON DELETE CASCADE
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
DELETE FROM contacts;

SET FOREIGN_KEY_CHECKS = 1;
SET SQL_SAFE_UPDATES = 1;

-- Company -- 
INSERT INTO company (company_name, fax_number, phone_number, email, number_of_employees) VALUES
('Company 1', '123-456-7890', '987-654-3210', 'info@company1.com', 500),
('Company 2', '223-456-7890', '687-654-3210', 'info@company2.com', 1200),
('Company 3', '323-456-7890', '787-654-3210', 'info@company3.com', 300),
('Company 4', '423-456-7890', '887-654-3210', 'info@company4.com', 150),
('Company 5', '523-456-7890', '987-654-3210', 'info@company5.com', 400),
('Company 6', '623-456-7890', '687-654-3210', 'info@company6.com', 1000),
('Company 7', '723-456-7890', '787-654-3210', 'info@company7.com', 700),
('Company 8', '823-456-7890', '887-654-3210', 'info@company8.com', 50),
('Company 9', '923-456-7890', '987-654-3210', 'info@company9.com', 900),
('Company 10', '1023-456-7890', '687-654-3210', 'info@company10.com', 350);

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
INSERT INTO employer (employer_id, employee_type, fax_number, phone_number, number_of_employees, company_id) VALUES
(1, 'Full-Time', '111-222-3333', '444-555-6666', 50, 1),
(2, 'Part-Time', '211-222-3333', '544-555-6666', 120, 2),
(3, 'Contract', '311-222-3333', '644-555-6666', 30, 3),
(4, 'Intern', '411-222-3333', '744-555-6666', 20, 4),
(5, 'Consultant', '511-222-3333', '844-555-6666', 80, 5),
(6, 'Freelance', '611-222-3333', '944-555-6666', 10, 6),
(7, 'Temporary', '711-222-3333', '1044-555-6666', 15, 7),
(8, 'Remote', '811-222-3333', '1144-555-6666', 60, 8),
(9, 'On-Site', '911-222-3333', '1244-555-6666', 100, 9),
(10, 'Manager', '1011-222-3333', '1344-555-6666', 200, 10);

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
INSERT INTO users (fName, lName, user_password, phone_number, home_phone_number, email, gender, fax_number, birth_date, partner_id, employer_id, school_id) VALUES
('John', 'Doe', 'password1', '555-1111', '555-2222', 'user1@example.com', 'Male', '555-3333', '1994-05-20', 1, 1, 1),
('Jane', 'Smith', 'password2', '555-4444', '555-5555', 'user2@example.com', 'Female', '555-6666', '1996-03-10', 2, 2, 2),
('Alex', 'Johnson', 'password3', '555-7777', NULL, 'user3@example.com', 'Other', NULL, NULL, 3, 3, 3),
('Michael', 'Brown', 'password4', '555-8888', '555-9999', 'user4@example.com', 'Male', '555-0000', NULL, 4, 4, 4),
('Sarah', 'Wilson', 'password5', '555-1212', NULL, 'user5@example.com', 'Female', '555-3434', NULL, 5, 5, 5),
('David', 'Taylor', 'password6', '555-5656', '555-7878', 'user6@example.com', 'Male', '555-9090', NULL, 6, 6, 6),
('Emily', 'Anderson', 'password7', '555-2323', '555-4545', 'user7@example.com', 'Female', '555-6767', NULL, 7, 7, 7),
('James', 'Thomas', 'password8', '555-8989', NULL, 'user8@example.com', 'Other', NULL, NULL, 8, 8, 8),
('Lisa', 'Jackson', 'password9', '555-5454', '555-7676', 'user9@example.com', 'Male', '555-9898', NULL, 9, 9, 9),
('Robert', 'White', 'password10', '555-3232', NULL, 'user10@example.com', 'Female', '555-4343', NULL, 10, 10, 10);

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
INSERT INTO message (message_type, message_date, user_id_sent, user_id_recieve, message_content) VALUES
('TEXT', '2024-02-01', 1, 2, 'Hello Jane, how are you?'),
('IMAGE', '2024-02-02', 2, 3, 'Here is the image you requested'),
('VIDEO', '2024-02-03', 3, 4, 'Here is the video you requested'),
('TEXT', '2024-02-04', 4, 5, 'I hope you are doing well'),
('IMAGE', '2024-02-05', 5, 6, 'Here is the updated image'),
('VIDEO', '2024-02-06', 6, 7, 'Here is the updated video'),
('TEXT', '2024-02-07', 7, 8, 'I need to discuss something important'),
('IMAGE', '2024-02-08', 8, 9, 'Here is the new image'),
('VIDEO', '2024-02-09', 9, 10, 'Here is the new video'),
('TEXT', '2024-02-10', 10, 1, 'I will be late for the meeting');

-- IMPORTANT: Insert admin data LAST to avoid deletion by triggers or cascading deletes
ALTER TABLE admin MODIFY COLUMN admin_password VARCHAR(64);
INSERT INTO admin (admin_password, email, phone_number, home_phone_number, employer_id) VALUES
('admin', 'admin@gmail.com', '555-1111', '555-2222', 1),
('adminpass2', 'admin2@company.com', '555-3333', '555-4444', 2),
('adminpass3', 'admin3@company.com', '555-5555', '555-6666', 3),
('adminpass4', 'admin4@company.com', '555-7777', '555-8888', 4),
('adminpass5', 'admin5@company.com', '555-9999', '555-0000', 5),
('adminpass6', 'admin6@company.com', '555-1234', '555-5678', 6),
('adminpass7', 'admin7@company.com', '555-8765', '555-4321', 7),
('adminpass8', 'admin8@company.com', '555-2345', '555-6789', 8),
('adminpass9', 'admin9@company.com', '555-9876', '555-5432', 9),
('adminpass10', 'admin10@company.com', '555-3456', '555-7890', 10),
('adminpassword', 'admin@maristcms.com', '555-0000', '555-1111', 1);

SET SQL_SAFE_UPDATES = 0;

-- Hash existing plaintext admin passwords
UPDATE admin
SET admin_password = SHA2(admin_password, 256)
WHERE CHAR_LENGTH(admin_password) != 64;

SET SQL_SAFE_UPDATES = 1;
-- =========================
-- Phase7PartA.sql
-- =========================

/*
A. Create table of Trush (To examine how many times grant access was successful or not) with the attributes of
    a. FailedAttempts=> tinyInt
    b. SuccessfulAttempt=> tinyInt
    c. username=> with the domain of username column in login table
    d. username would be the primary key
    e. the engine of BLACKHOLE.
*/
CREATE TABLE Trush (
    FailedAttempts TINYINT,
    SuccessfulAttempts TINYINT,
    username VARCHAR(255) NOT NULL,
    PRIMARY KEY (username),
    CONSTRAINT fk_username FOREIGN KEY (username) REFERENCES login(username)
) ENGINE=BLACKHOLE;

-- =========================
-- Phase6PartB.sql
-- =========================

use maristcms;

Delimiter $$

CREATE TRIGGER after_user_delete
AFTER DELETE ON users FOR EACH ROW
BEGIN
    -- delete messages where user is sender or receiver
    DELETE FROM message 
    WHERE user_id_sent = OLD.user_id OR user_id_recieve = OLD.user_id;

    -- deletes child's records
    DELETE FROM child 
    WHERE user_id = OLD.user_id;

    -- deletes user records
    DELETE FROM records 
    WHERE user_id = OLD.user_id;

    -- deletes partner 
    DELETE FROM partner 
    WHERE user_id = OLD.user_id;

    -- deletes for employee locations
    DELETE FROM employer_has_locations 
    WHERE employer_id = OLD.employer_id;

    -- deletes info for employee
    DELETE FROM employer 
    WHERE employer_id = OLD.employer_id;
    
    -- deletes from admin if they even are one 
    DELETE FROM admin 
    WHERE employer_id = OLD.employer_id;
END $$
DELIMITER ;

-- =========================
-- Phase5 PartC.sql
-- =========================

use maristcms;

-- alter the admin table to modify the password column (if needed)
alter table admin modify column admin_password varchar(255);

-- 3 users
insert ignore into admin (email, admin_password)-- i put the insert ingore becasue there was some weird problem with the duplication of info idk 
values
('admin1@example.com', sha2('password123', 256)),
('admin2@example.com', sha2('thisismypas', 256)),
('admin3@example.com', sha2('helloworld1', 256));

delimiter //

drop procedure if exists validateuserlogin;
create procedure validateuserlogin(
    in p_email varchar(255),
    in p_password varchar(255),
    out p_result varchar(50)
)
begin
    declare hashed_input varchar(255);
    declare stored_password varchar(255);

    set hashed_input = sha2(p_password, 256);

    -- gets the stored password from admin table
    select admin_password into stored_password 
    from admin 
    where admin_email = p_email;

    if stored_password = hashed_input then
        set p_result = 'access granted';
    else
        set p_result = 'access rejected';
    end if;
end //

delimiter ;

DELIMITER $$
CREATE TRIGGER before_insert_users_hash_password
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    IF CHAR_LENGTH(NEW.user_password) != 64 THEN
        SET NEW.user_password = SHA2(NEW.user_password, 256);
    END IF;
END $$
DELIMITER ; 

-- Trigger to hash admin password before insert (similar to users)
DELIMITER $$
CREATE TRIGGER before_insert_admins_hash_password
BEFORE INSERT ON admin
FOR EACH ROW
BEGIN
    IF CHAR_LENGTH(NEW.admin_password) != 64 THEN
        SET NEW.admin_password = SHA2(NEW.admin_password, 256);
    END IF;
END $$
DELIMITER ;

-- =========================
-- Phase6 PartA.sql
-- =========================

use maristcms;

SELECT * FROM users;
-- Turn off safty permissions in order to fix the users table.
-- ALL PASSWORDS NEEDED TO BE STORED IN HASHED FORM
SET SQL_SAFE_UPDATES = 0;
ALTER TABLE users
MODIFY COLUMN user_password VARCHAR(64);
UPDATE users 
SET user_password = SHA2(user_password, 256)
WHERE LENGTH(user_password) < 64;

-- SELECT * FROM login;
-- SHOW COLUMNS from login;
-- SELECT * FROM admin;
-- Check Pass Procedure
DELIMITER $$
-- Recieves 3 inputs: Email, Password, New Password
-- Purpose:The purpose of this stored procedure is to securely update a user's password by verifying the provided current password,
--  and if valid, updating it to a new hashed password, or displaying an error message if the current password is incorrect.
DROP PROCEDURE IF EXISTS validateUpdatePassword;
CREATE PROCEDURE validateUpdatePassword ( 
	IN email VARCHAR(255),
	IN password VARCHAR(255), 
	IN newPassword VARCHAR(255)
    )
    BEGIN
    -- Stores whether or not the inputted password matches the one in the login table
		DECLARE knowsOldPassword INT;
		
        SELECT COUNT(*) INTO knowsOldPassword FROM login l where l.email = email AND l.user_password = SHA2(password,256);
        
-- If a match is found, update the password
    IF knowsOldPassword > 0 THEN
        UPDATE login 
        SET user_password = SHA2(newPassword, 256) 
        WHERE email = email;
        
        SELECT 'The password has been updated successfully.' AS Message;
    ELSE
        SELECT 'The provided password is not valid.' AS Message;
    END IF;
	END $$
    
    DELIMITER ;
    
    -- VERIFICATION
    -- CALL validateUpdatePassword('user1@example.com', 'password1', 'userPassword1'); 
    

-- =========================
-- UserSummaryTable.sql
-- =========================

USE maristcms;
-- #Count of total users#
-- select * from users;
-- select count(u.user_id) as "Total Users" from users u;
-- #average age of users#
-- select AVG(DISTINCT YEAR(CURDATE()) - YEAR(u.birth_date) - (RIGHT(CURDATE(), 5) < RIGHT(u.birth_date, 5))) AS "Average User Age" from users u;
-- #Total companies#
-- select count(c.company_id) as "Total Companies" from company c;
-- #Total employers#
-- select count(e.employer_id) as "Total Employers" from employer e;
-- #Total messages#
-- select count(m.message_id) as "Total Messages Sent" from message m;
-- #Total message recipients#
-- select * from message_recipients;
-- select count(distinct(mr.recipient_id)) as "Total Message Recipients" from message_recipients mr;
-- #Total records#
-- select * from records;
-- select count(r.record_type) as "Total Records" from records r;
-- #Total Schools#
-- select * from school;
-- select count(distinct(s.school_id)) as "Total Schools" from school s;
-- #Total Children#
-- select * from child;
-- select count(c.child_id) as "Total Children" from child c;
-- #Total Partners#
-- select * from partner;
-- select count(p.partner_id) as "Total Partners" from partner p;
-- #Total Locations#
-- select * from locations;
-- select count(l.location_id) as "Total Locations" from locations l;
-- #Total employer-location relationships#
-- select count(*) as "Employers With Locations" from employer_has_locations;
#Select summary statement#
-- SELECT 
-- 	(SELECT AVG(YEAR(CURDATE()) - YEAR(u.birth_date) - (RIGHT(CURDATE(), 5) < RIGHT(u.birth_date, 5))) 
-- 	FROM users u) AS "Average User Age", 
-- 	COUNT(DISTINCT u.user_id) AS "Users", 
--     COUNT(DISTINCT c.company_id) AS "Total Companies",
--     COUNT(DISTINCT e.employer_id) AS "Total Employers",
--     COUNT(DISTINCT m.message_id) AS "Total Messages Sent",
--     COUNT(DISTINCT mr.recipient_id) AS "Total Message Recipients",
--     COUNT(DISTINCT r.record_id) AS "Total Records",
--     COUNT(DISTINCT s.school_id) AS "Total Schools",
--     COUNT(DISTINCT ch.child_id) AS "Total Children",
--     COUNT(DISTINCT p.partner_id) AS "Total Partners",
--     COUNT(DISTINCT l.location_id) AS "Total Locations",
--     COUNT(DISTINCT el.employer_id) AS "Employers With Locations"
--     FROM users u
--     LEFT JOIN employer e ON u.employer_id = e.employer_id
--     LEFT JOIN company c ON e.company_id = c.company_id
--     LEFT JOIN locations l ON e.employer_id = l.employer_id
--     LEFT JOIN message m ON u.user_id = m.user_id_sent
--     LEFT JOIN message_recipients mr ON m.message_id = mr.message_id
--     LEFT JOIN records r ON u.user_id = r.user_id
--     LEFT JOIN school s ON u.school_id = s.school_id
--     LEFT JOIN child ch ON u.user_id = ch.user_id
--     LEFT JOIN partner p ON u.user_id = p.user_id
--     LEFT JOIN employer_has_locations el ON l.location_id = el.location_id;
--     
DROP VIEW IF EXISTS UserSummary;
CREATE VIEW UserSummary AS
	SELECT 
		(SELECT AVG(YEAR(CURDATE()) - YEAR(u.birth_date) - (RIGHT(CURDATE(), 5) < RIGHT(u.birth_date, 5))) 
		FROM users u) AS "Average User Age", 
		COUNT(DISTINCT u.user_id) AS "Users", 
		COUNT(DISTINCT c.company_id) AS "Total Companies",
		COUNT(DISTINCT e.employer_id) AS "Total Employers",
		COUNT(DISTINCT m.message_id) AS "Total Messages Sent",
		COUNT(DISTINCT mr.recipient_id) AS "Total Message Recipients",
		COUNT(DISTINCT r.record_id) AS "Total Records",
		COUNT(DISTINCT s.school_id) AS "Total Schools",
		COUNT(DISTINCT ch.child_id) AS "Total Children",
		COUNT(DISTINCT p.partner_id) AS "Total Partners",
		COUNT(DISTINCT l.location_id) AS "Total Locations",
		COUNT(DISTINCT el.employer_id) AS "Employers With Locations"
		FROM users u
		LEFT JOIN employer e ON u.employer_id = e.employer_id
		LEFT JOIN company c ON e.company_id = c.company_id
		LEFT JOIN locations l ON e.employer_id = l.employer_id
		LEFT JOIN message m ON u.user_id = m.user_id_sent
		LEFT JOIN message_recipients mr ON m.message_id = mr.message_id
		LEFT JOIN records r ON u.user_id = r.user_id
		LEFT JOIN school s ON u.school_id = s.school_id
		LEFT JOIN child ch ON u.user_id = ch.user_id
		LEFT JOIN partner p ON u.user_id = p.user_id
		LEFT JOIN employer_has_locations el ON l.location_id = el.location_id;

-- CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'AdminPass123';
-- GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, INDEX, ALTER ON MaristCMS.* TO 'admin_user'@'localhost';
-- CREATE USER 'regular_user'@'localhost' IDENTIFIED BY 'UserPass123';
-- GRANT SELECT, INSERT, UPDATE ON MaristCMS.users TO 'regular_user'@'localhost';
-- GRANT SELECT ON MaristCMS.records TO 'regular_user'@'localhost';
-- GRANT SELECT ON UserSummary TO 'admin_user'@'localhost';

SELECT * FROM UserSummary;

-- =========================
-- Phase4Scripts.sql
-- =========================

USE MaristCMS;

DROP VIEW IF EXISTS login;
DROP VIEW IF EXISTS contact;
DROP VIEW IF EXISTS adminDashboard;

CREATE VIEW login AS
SELECT email,user_password FROM users;

CREATE VIEW contact AS 
SELECT gender,phone_number,email FROM users; -- add their name once/if users get names

CREATE VIEW adminDashboard AS
SELECT user_id, email FROM users; -- add their name once/if users get names

-- =========================
-- Phase3 part C.sql
-- =========================

/*Part a*/
-- update contacts 
-- set phone_number = '123-456-7890' 
-- where contact_id = 1;
-- show tables;
/*Part b*/
-- insert into contacts (contact_id, first_name, last_name, email, phone,is_email_verified,is_phone_verified) 
-- values (5,'Alice','Smith', 'alice@gmail.com', '123-456-7890', 1, 0) 
-- on duplicate key update email = 'alice1@gmail.com';
-- select * from contacts where contact_id = 5;

/*Part c*/
/*
create table user_credentials (
    user_id int primary key,
    username varchar(50),
    password_hash varchar(255)
);
alter table user_credentials
add column last_activity timestamp default current_timestamp on update current_timestamp;

update user_credentials 
set username = 'updated_user' 
where user_id = 1;

select * from user_credentials 
*/

DELIMITER $$
CREATE TRIGGER before_update_admins_hash_password
BEFORE UPDATE ON admin
FOR EACH ROW
BEGIN
    IF CHAR_LENGTH(NEW.admin_password) != 64 THEN
        SET NEW.admin_password = SHA2(NEW.admin_password, 256);
    END IF;
END $$
DELIMITER ;
