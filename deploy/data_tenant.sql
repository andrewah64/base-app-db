do $$
begin
        insert into app_data.tenant (tnt_nm, tnt_prtc, tnt_fqdn, tnt_port)
        select 'tenant-1', 'https', 'tenant1.localhost', 8080
         where not exists (select null 
                             from app_data.tenant t
                            where t.tnt_nm = 'tenant-1');

        insert into app_data.tenant (tnt_nm, tnt_prtc, tnt_fqdn, tnt_port)
        select 'tenant-2', 'https', 'tenant2.localhost', 8080
         where not exists (select null 
                             from app_data.tenant t
                            where t.tnt_nm = 'tenant-2');

        insert into app_data.tenant (tnt_nm, tnt_prtc, tnt_fqdn, tnt_port)
        select 'tenant-3', 'https', 'localhost', 8080
         where not exists (select null 
                             from app_data.tenant t
                            where t.tnt_nm = 'tenant-3');

end $$
