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
#ADMIN VIEW#
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

GRANT SELECT ON UserSummary TO 'admin_user'@'localhost';

SELECT * FROM UserSummary;
    
    
    
