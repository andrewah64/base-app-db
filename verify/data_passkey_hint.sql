do $$
begin
        assert((select count(*) from app_data.passkey_hint) > 0);
end $$
