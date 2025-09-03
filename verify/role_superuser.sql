do $$
begin
        assert((select count(*) from app_data.app_user where aur_nm = 'superuser') = (select count(distinct aur_nm) from app_data.app_user where aur_nm = 'superuser') * (select count(*) from app_data.tenant));
end$$
