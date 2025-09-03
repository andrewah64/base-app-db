create or replace function web_core_unauth_ssn_aur_reg.pky_inf
(
        refcursor
,       p_tnt_id  app_data.app_user.tnt_id%type
,       p_aur_nm  app_data.app_user.aur_nm%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             with
                  aur
               as (
                      select
                             aur.aur_id
                        from
                             app_data.app_user aur
                       where
                             aur.tnt_id = p_tnt_id
                         and aur.aur_nm = p_aur_nm
                  )
             select
                    pky.pky_credential_id
                  , pky.pky_public_key
                  , pky.pky_attestation_type
                  , kat.pat_nm
                  , pky.pky_user_present
                  , pky.pky_user_verified
                  , pky.pky_backup_eligible
                  , pky.pky_backup_state
                  , pky.pky_aaguid
                  , pky.pky_sign_count
                  , pky.pky_clone_warning
                  , pky.pky_attachment
                  , pky.pky_client_data_json
                  , pky.pky_client_data_hash
                  , pky.pky_authenticator_data
                  , pky.pky_public_key_algorithm
                  , pky.pky_object
               from
                               aur                           aur
                          join app_data.web_app_user_passkey pky on aur.aur_id = pky.aur_id
                    cross join (
                                   select
                                          coalesce(array_agg(pat.pat_nm order by pat.pat_nm asc), array[]::text[]) pat_nm
                                     from
                                               aur                                                   aur
                                          join app_data.web_app_user_passkey                         pky on aur.aur_id = pky.aur_id
                                          join app_data.web_app_user_passkey_authenticator_transport kat on pky.pky_id = kat.pky_id
                                          join app_data.passkey_authenticator_transport              pat on kat.pat_id = pat.pat_id
                               ) kat
              where
                    pky.pky_enabled = true
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
