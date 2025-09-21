create table if not exists app_data.saml2_service_provider_certificate_pair
(
        spc_id      bigint                   generated always as identity not null
,       tnt_id      bigint                                                not null
,       spc_nm      text                                                  not null
,       spc_cn_nm   text                                                  not null
,       spc_org_nm  text                                                  not null
,       spc_enc_crt bytea                                                 not null
,       spc_enc_pvk bytea                                                 not null
,       spc_sgn_crt bytea                                                 not null
,       spc_sgn_pvk bytea                                                 not null
,       spc_inc_ts  timestamp with time zone                              not null
,       spc_exp_ts  timestamp with time zone                              not null
,       spc_enabled boolean                  default false                not null
,       cby         text                     default current_user         not null
,       cts         timestamp with time zone default now()                not null
,       uby         text                     default current_user         not null
,       uts         timestamp with time zone default now()                not null
,       constraint pk_spc            primary key (spc_id)
,       constraint uk_spc            unique      (tnt_id, spc_nm)
,       constraint ck_spc_nm         check       (length(trim(spc_nm))     > 0)
,       constraint ck_spc_cn_nm      check       (length(trim(spc_cn_nm))  > 0)
,       constraint ck_spc_org_nm     check       (length(trim(spc_org_nm)) > 0)
,       constraint ck_spc_inc_exp_ts check       (spc_inc_ts <= spc_exp_ts)
);
