do $$
begin
        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema = 'app_data' and table_name = 'api_app_user' and constraint_name = 'fk_aauam_aaur');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema = 'app_data' and table_name = 'api_atn_method' and constraint_name = 'fk_aauam_aam');

end $$
