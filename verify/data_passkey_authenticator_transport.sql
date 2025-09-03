do $$
begin
        assert((select count(*) from app_data.passkey_authenticator_transport) > 0);
end $$
