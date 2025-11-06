create table if not exists app_data.org_group_user
(
        oag_id bigint                                        not null
,       oau_id bigint                                        not null
,       cby    text                     default current_user not null
,       cts    timestamp with time zone default now()        not null
,       uby    text                     default current_user not null
,       uts    timestamp with time zone default now()        not null
,       constraint pk_ogu    primary key (oag_id, oau_id)
);
