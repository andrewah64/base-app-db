do $$
begin
        assert((select count(*) from app_data.passkey_public_key_algorithm) > 0);
end $$
