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
