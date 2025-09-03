do $$
begin
        assert((select count(*) from app_data.tenant) = (select count(*) from app_data.web_app_user_passkey_config));
end $$
