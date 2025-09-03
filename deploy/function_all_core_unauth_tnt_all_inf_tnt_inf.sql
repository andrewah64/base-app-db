create or replace function all_core_unauth_tnt_all_inf.tnt_inf
(
        refcursor
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select
                    tnt.tnt_id
                  , tnt.tnt_prtc
                  , tnt.tnt_fqdn
                  , tnt.tnt_port
                  , tnt.tnt_prtc || '://' || tnt.tnt_fqdn || ':' || tnt.tnt_port::text tnt_origin
               from
                    app_data.tenant tnt
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
