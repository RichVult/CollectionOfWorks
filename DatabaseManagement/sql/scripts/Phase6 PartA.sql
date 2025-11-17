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
    
