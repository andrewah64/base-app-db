create table if not exists app_data.org_app_user
(
        oau_id bigint                   generated always as identity not null
,       org_id bigint                                                not null
,       aur_id bigint                                                not null
,       cby    text                     default current_user         not null
,       cts    timestamp with time zone default now()                not null
,       uby    text                     default current_user         not null
,       uts    timestamp with time zone default now()                not null
,       constraint pk_oau primary key (oau_id)
,       constraint uk_oau unique      (org_id, aur_id)
);
