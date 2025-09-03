do $$
begin
        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema = 'app_data' and table_name = 'middleware_chain'    and constraint_name = 'fk_ep_mwc');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema = 'app_data' and table_name = 'http_request_method' and constraint_name = 'fk_ep_hrm');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema = 'app_data' and table_name = 'handler'             and constraint_name = 'fk_ep_hdlr');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema = 'app_data' and table_name = 'endpoint_path'       and constraint_name = 'fk_ep_epp');
end $$
