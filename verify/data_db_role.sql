do $$
begin
        assert((select count(*)
                  from app_data.db_role) = (select count(*)
                                              from information_schema.enabled_roles
                                             where role_name like 'role%'));
end $$
