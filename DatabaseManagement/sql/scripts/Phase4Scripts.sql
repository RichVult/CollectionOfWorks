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
