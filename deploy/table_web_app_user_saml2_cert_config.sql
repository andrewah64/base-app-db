create table if not exists app_data.web_app_user_saml2_cert_config
(
        tnt_id      bigint                                             not null
,       s2g_crt_cn  text                                               not null
,       s2g_crt_org text                                               not null
,       cby         text                     default current_user      not null
,       cts         timestamp with time zone default now()             not null
,       uby         text                     default current_user      not null
,       uts         timestamp with time zone default now()             not null
,       constraint pk_s2g         primary key (tnt_id)
,       constraint ck_s2g_crt_cn  check       (length(trim(s2g_crt_cn))  > 0 and s2g_crt_cn  = trim(s2g_crt_cn))
,       constraint ck_s2g_crt_org check       (length(trim(s2g_crt_org)) > 0 and s2g_crt_org = trim(s2g_crt_org))
);
