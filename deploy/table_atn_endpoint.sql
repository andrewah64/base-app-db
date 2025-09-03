create table if not exists app_data.atn_endpoint
(
        ep_id  bigint                                        not null
,       cby    text                     default current_user not null
,       cts    timestamp with time zone default now()        not null
,       uby    text                     default current_user not null
,       uts    timestamp with time zone default now()        not null
,       constraint pk_aep    primary key (ep_id)
);
