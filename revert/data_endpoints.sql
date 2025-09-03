do $$
begin
        delete from app_data.endpoint_log_level;

        delete from app_data.atn_db_role;

        delete from app_data.atn_endpoint;

        delete from app_data.endpoint_db_role;

        delete from app_data.page_endpoint;

        delete from app_data.endpoint;

        delete from app_data.endpoint_path;

        delete from app_data.handler;

        delete from app_data.web_db_role;

        delete from app_data.api_db_role;

        delete from app_data.db_role;

        commit;
end $$
