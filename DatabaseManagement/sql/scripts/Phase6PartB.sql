use maristcms;

Delimiter $$

create trigger after_user_delete
after delete on `User` for each row
begin
    -- delete messages where user is sender or receiver
    delete from `Message` 
    where `UserID Sent` = old.UserID or `UserID Recieved` = old.UserID;

    -- deletes child's records
    delete from `Child` 
    where `User_UserID` = old.UserID;

    -- deletes user records
    delete from `Records` 
    where `UserID` = old.UserID;

    -- deletes partner 
    delete from `Partner` 
    where `Partner_PartnerID` = old.UserID;

    -- deletes for employee locations
    delete from `Employer_has_Locations` 
    where `Employer_User_UserID` = old.UserID;

    -- deletes info for employee
    delete from `Employer` 
    where `User_UserID` = old.UserID;
    
    -- deletes from admin if they even are one 
    delete from `Admin` 
    where `UserID` = old.UserID;
    end $$ 

Delimiter ;
