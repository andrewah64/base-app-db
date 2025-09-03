create table if not exists app_data.web_app_user_passkey
(
        pky_id                   bigint generated always as identity                      not null 
,       aur_id                   bigint                                                   not null
,       pky_enabled              boolean                             default true         not null
,       pky_credential_id        bytea                                                    not null
,       pky_public_key           bytea                                                    not null
,       pky_attestation_type     text                                                     not null
,       pky_user_present         boolean                                                  not null
,       pky_user_verified        boolean                                                  not null
,       pky_backup_eligible      boolean                                                  not null
,       pky_backup_state         boolean                                                  not null
,       pky_aaguid               bytea                                                    not null
,       pky_sign_count           integer                                                  not null
,       pky_clone_warning        boolean                                                  not null
,       pky_attachment           text                                                     not null
,       pky_client_data_json     bytea                                                    not null
,       pky_client_data_hash     bytea                                                    not null
,       pky_authenticator_data   bytea                                                    not null
,       pky_public_key_algorithm integer                                                  not null
,       pky_object               bytea                                                    not null
,       cby                      text                                default current_user not null
,       cts                      timestamp with time zone            default now()        not null
,       uby                      text                                default current_user not null
,       uts                      timestamp with time zone            default now()        not null
,       constraint pk_pky            primary key (pky_id)
);
