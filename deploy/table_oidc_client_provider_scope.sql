create table if not exists app_data.oidc_client_provider_scope
(
        occ_id bigint                                        not null
,       ocp_id bigint                                        not null
,       ocs_id bigint                                        not null
,       cby    text                     default current_user not null
,       cts    timestamp with time zone default now()        not null
,       uby    text                     default current_user not null
,       uts    timestamp with time zone default now()        not null
,       constraint pk_occps             primary key (occ_id, ocp_id, ocs_id)
);
