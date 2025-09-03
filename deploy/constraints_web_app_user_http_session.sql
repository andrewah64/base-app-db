alter table if exists app_data.web_app_user_http_session add constraint fk_wauhs_waur foreign key (aur_id) references app_data.web_app_user (aur_id);
