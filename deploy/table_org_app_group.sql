create table if not exists app_data.org_app_group
(
        oag_id bigint                   generated always as identity not null
,       org_id bigint                                                not null
,       grp_id bigint                                                not null
,       cby    text                     default current_user         not null
,       cts    timestamp with time zone default now()                not null
,       uby    text                     default current_user         not null
,       uts    timestamp with time zone default now()                not null
,       constraint pk_oag primary key (oag_id)
,       constraint uk_oag unique      (org_id, grp_id)
);
