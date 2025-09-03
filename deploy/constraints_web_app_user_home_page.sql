alter table if exists app_data.web_app_user_home_page add constraint fk_wauhp_waur foreign key (aur_id) references app_data.web_app_user (aur_id);
alter table if exists app_data.web_app_user_home_page add constraint fk_wauhp_hpg  foreign key (pg_id)  references app_data.home_page    (pg_id);
