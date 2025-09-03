create table app_data.api_db_role
(
        dbrl_id bigint                                        not null
,       cby     name                     default current_user not null
,       cts     timestamp with time zone default now()        not null
,       uby     name                     default current_user not null
,       uts     timestamp with time zone default now()        not null
,       constraint pk_adbrl primary key (dbrl_id)
);
