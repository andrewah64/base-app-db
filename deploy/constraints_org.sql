alter table if exists app_data.org add constraint fk_org_tnt foreign key (tnt_id) references app_data.tenant (tnt_id);
