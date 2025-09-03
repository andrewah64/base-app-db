do $$
begin
        assert((select count(*) from app_data.passkey_user_verification) > 0);
end $$
