alter table if exists app_data.api_atn_method add constraint fk_aam_aum  foreign key (aum_id)  references app_data.atn_method (aum_id);
