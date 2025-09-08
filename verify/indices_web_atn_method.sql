do $$
begin
        assert((select count(*)
                  from pg_indexes
                 where schemaname = 'app_data'
                   and tablename  = 'web_atn_method'
                   and indexname  in ( 'uk_wam_ocp', 'uk_wam_pw' , 'uk_wam_pky' , 'uk_wam_s2i' , 'uk_wam_s2s', 'uk_wam_s2u' )) = 6);
end$$;
