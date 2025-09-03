do $$
begin
        assert((select count(*) from app_data.passkey_discoverable_credential) > 0);
end $$
