do $$
begin
        assert((select count(*)
                  from pg_indexes
                 where schemaname = 'app_data'
                   and tablename  = 'log_level'
                   and indexname  = 'uk_lvl_aur_dflt') = 1);

        assert((select count(*)
                  from pg_indexes
                 where schemaname = 'app_data'
                   and tablename  = 'log_level'
                   and indexname  = 'uk_lvl_ep_dflt')  = 1);
end$$;
