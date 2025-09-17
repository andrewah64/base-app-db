create or replace function web_core_auth_s2c_tnt_inf.ref_inf
(
        refcursor
,       p_tnt_id app_data.tenant.tnt_id%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
                  select
                         key
                       , id
                       , value
                    from (
                             select
                                    'aum'      key
                                  , aum.aum_id id
                                  , aum.aum_nm value
                               from
                                         app_data.atn_method           aum
                                    join app_data.web_atn_saml2_method asm on aum.aum_id = asm.aum_id
                         )
                order by
                         key    asc
                       , value  asc
                       ;

        return $1;
end;
$$
language plpgsql
security definer;
