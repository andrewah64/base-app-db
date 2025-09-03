do $$
begin
        insert into app_data.api_db_role (dbrl_id)
        select dbrl_id
          from app_data.db_role
         where dbrl_nm like 'role_api%'
             ;
end $$
