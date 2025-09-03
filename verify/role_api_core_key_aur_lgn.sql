do $$
begin
        assert((select count(*) from app_data.db_role where dbrl_nm = 'role_api_core_key_aur_lgn') = 1);
end $$
