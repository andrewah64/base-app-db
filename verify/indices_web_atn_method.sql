do $$
begin
        assert((select count(*)
                  from pg_indexes
                 where schemaname = 'app_data'
                   and tablename  = 'web_atn_method'
                   and indexname  in ( 'uk_wam_ocp', 'uk_wam_pw' , 'uk_wam_pky' ) ) = 3);
end$$;
