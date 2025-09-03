alter table if exists app_data.web_atn_method add constraint fk_wam_aum foreign key (aum_id) references app_data.atn_method (aum_id);
