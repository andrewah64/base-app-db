create table if not exists app_data.oidc_provider_scope
(
        ocp_id bigint                                        not null
,       ocs_id bigint                                        not null
,       cby    text                     default current_user not null
,       cts    timestamp with time zone default now()        not null
,       uby    text                     default current_user not null
,       uts    timestamp with time zone default now()        not null
,       constraint pk_ocps   primary key (ocp_id, ocs_id)
);
