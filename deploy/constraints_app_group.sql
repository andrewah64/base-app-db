alter table if exists app_data.app_group add constraint fk_grp_tnt foreign key (tnt_id) references app_data.tenant (tnt_id);
