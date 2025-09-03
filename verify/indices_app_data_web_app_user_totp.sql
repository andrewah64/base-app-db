do $$
begin
        assert((select count(*)
                  from pg_indexes
                 where schemaname = 'app_data'
                   and tablename  = 'web_app_user_totp'
                   and indexname  = 'uk_otp_enabled') = 1);
end$$;
