create table if not exists app_data.oidc_client
(
        occ_id            bigint                   generated always as identity not null
,       tnt_id            bigint                                                not null
,       ocp_id            bigint                                                not null
,       occ_enabled       boolean                  default true                 not null
,       occ_url           text                                                  not null
,       occ_client_id     text                                                  not null
,       occ_client_secret text                                                  not null
,       ep_id             bigint                                                not null
,       cby               text                     default current_user         not null
,       cts               timestamp with time zone default now()                not null
,       uby               text                     default current_user         not null
,       uts               timestamp with time zone default now()                not null
,       constraint pk_occ               primary key (occ_id)
,       constraint uk_occ               unique      (tnt_id, ocp_id)
,       constraint uk_occ_url           unique      (tnt_id, occ_url)
,       constraint ck_occ_url           check       (length(trim(occ_url))           > 0)
,       constraint ck_occ_client_id     check       (length(trim(occ_client_id))     > 0)
,       constraint ck_occ_client_secret check       (length(trim(occ_client_secret)) > 0)
);
