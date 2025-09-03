alter table if exists app_data.home_page add constraint fk_hpg_pg foreign key (pg_id) references app_data.page (pg_id);
