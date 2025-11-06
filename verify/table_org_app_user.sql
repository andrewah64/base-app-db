do $$
begin
        assert(select true
                 from pg_tables
                where schemaname = 'app_data'
                  and tablename  = 'org_app_user');
end$$;
