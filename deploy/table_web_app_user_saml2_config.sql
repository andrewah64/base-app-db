create table if not exists app_data.web_app_user_saml2_config
(
        tnt_id        bigint                                        not null
,       aum_id        bigint                                        not null
,       s2c_entity_id text                                          not null
,       s2c_enc_crt   text                                          not null
,       s2c_sgn_crt   text                                          not null
,       cby           text                     default current_user not null
,       cts           timestamp with time zone default now()        not null
,       uby           text                     default current_user not null
,       uts           timestamp with time zone default now()        not null
,       constraint pk_s2c           primary key (tnt_id)
,       constraint ck_s2c_entity_id check       (length(trim(s2c_entity_id)) > 0)
,       constraint ck_s2c_enc_crt   check       (length(trim(s2c_enc_crt))   > 0)
,       constraint ck_s2c_sgn_crt   check       (length(trim(s2c_sgn_crt))   > 0)
);
