alter table if exists app_data.api_app_user_atn_method add constraint fk_aauam_aaur foreign key (aur_id) references app_data.api_app_user  (aur_id);
alter table if exists app_data.api_app_user_atn_method add constraint fk_aauam_aam foreign key (aum_id) references app_data.api_atn_method (aum_id);
