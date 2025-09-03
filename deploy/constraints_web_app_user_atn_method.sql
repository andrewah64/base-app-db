alter table if exists app_data.web_app_user_atn_method add constraint fk_wauam_waur foreign key (aur_id) references app_data.web_app_user  (aur_id);
alter table if exists app_data.web_app_user_atn_method add constraint fk_wauam_wam foreign key (aum_id) references app_data.web_atn_method (aum_id);
