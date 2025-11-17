use elmasri_company;
/*Part a*/
update contacts 
set phone_number = '123-456-7890' 
where contact_id = 1;
show tables;
/*Part b*/
insert into contacts (contact_id, first_name, last_name, email, phone,is_email_verified,is_phone_verified) 
values (5,'Alice','Smith', 'alice@gmail.com', '123-456-7890', 1, 0) 
on duplicate key update email = 'alice1@gmail.com';
select * from contacts where contact_id = 5;
/*Part c*/
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

