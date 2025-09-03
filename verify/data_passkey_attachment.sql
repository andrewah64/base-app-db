do $$
begin
        assert((select count(*) from app_data.passkey_attachment) > 0);
end $$
