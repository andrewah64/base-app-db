do $$
begin
        assert((select count(*) from app_data.passkey_attestation) > 0);
end $$
