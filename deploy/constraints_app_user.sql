alter table if exists app_data.app_user add constraint fk_aur_lng foreign key (lng_id) references app_data.language  (lng_id);
alter table if exists app_data.app_user add constraint fk_aur_tnt foreign key (tnt_id) references app_data.tenant    (tnt_id);
