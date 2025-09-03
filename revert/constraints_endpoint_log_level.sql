alter table if exists app_data.endpoint_log_level drop constraint fk_ell_tnt;
alter table if exists app_data.endpoint_log_level drop constraint fk_ell_ep;
alter table if exists app_data.endpoint_log_level drop constraint fk_ell_lvl;
