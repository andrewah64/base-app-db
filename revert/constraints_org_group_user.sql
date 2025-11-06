alter table app_data.org_group_user if exists drop constraint if exists fk_ogu_oag;
alter table app_data.org_group_user if exists drop constraint if exists fk_ogu_oau;
