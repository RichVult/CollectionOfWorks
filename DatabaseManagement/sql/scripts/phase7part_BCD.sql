use maristcms;

-- Part B--
CREATE TABLE Inventory (
  itemID        INT             PRIMARY KEY,
  item          VARCHAR(255),
  contactName   VARCHAR(255),
  Availability  INT,
  primaryUser   VARCHAR(320)
) ENGINE=MYISAM;

-- Since MYISAM doesnt support foreign keys, delimeter to ensure the email matches the login table before insertion.
DROP TRIGGER trg_inventory_insert;
DELIMITER //
CREATE TRIGGER trg_inventory_insert
BEFORE INSERT ON Inventory
FOR EACH ROW
BEGIN
  IF (SELECT COUNT(*) FROM login WHERE email = NEW.primaryUser) = 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Invalid primaryUser: not found in login';
  END IF;
END;
//
DELIMITER ;

-- Part C --
-- Three inserts into Trush (engine=BLACKHOLE)
INSERT INTO Trush (FailedAttempts, SuccessfulAttempts, username) VALUES
  (2, 5, 'alice'),
  (0, 3, 'bob'),
  (1, 1, 'charlie');

-- Three inserts into Inventory (engine=MYISAM)
INSERT INTO Inventory (itemID, item, contactName, Availability, primaryUser) VALUES
  (1, 'Laptop',   'Alice Smith',   10, 'user1@example.com'),
  (2, 'Projector','Bob Jones',     5,  'user2@example.com'),
  (3, 'Camera',   'Charlie Brown', 2,  'user3@example.com');


-- Part D --

SELECT
	t.FailedAttempts,
    t.SuccessfulAttempts,
    t.Username,
    i.itemID,
    i.item,
    i.ContactName,
    i.Availability
FROM Trush t
JOIN Inventory i ON t.username=i.primaryUser;

-- Part D-- 

-- Since the Trush Table uses a blackhole engine, a join statement is useless.
-- The blackhole engine writes and immediately erases data.
-- So selecting any columns on a joined select or not, because there are no matching columns, 
-- returns zero rows no matter if there is data in the inventory table.
-- SELECT t.username, i.itemID, i.contactName
-- FROM Trush AS t
-- JOIN Inventory AS i
--   ON t.username = i.primaryUser;
-- If Trush used an innoDB or MYISAM engine the join statement would return the matching columns.
-- The only thing preventing data from appearing is the choice of engine.

