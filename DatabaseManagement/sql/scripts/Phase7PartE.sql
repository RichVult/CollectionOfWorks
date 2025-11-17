use maristcms;

drop procedure if exists swap_and_remove_user;
delimiter $$

create procedure swap_and_remove_user(
    in old_id int,
    in new_id int
)
begin
  declare cnt_old int default 0;
  declare cnt_new int default 0;

  start transaction;

  select count(*) into cnt_old
    from users
    where user_id = old_id;

  select count(*) into cnt_new
    from users
    where user_id = new_id;

  if cnt_old = 1 and cnt_new = 1 then
    update inventory
      set primary_user_id = new_id
      where primary_user_id = old_id;

    delete from users
      where user_id = old_id;
    commit;
  else
    rollback;
    signal sqlstate '45000'
      set message_text = 'either old_id or new_id does not exist.';
  end if;
end$$

delimiter ;


