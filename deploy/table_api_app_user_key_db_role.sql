create table if not exists app_data.api_app_user_key_db_role
(
        aauk_id bigint                                        not null
,       dbrl_id bigint                                        not null
,       cby     text                     default current_user not null
,       cts     timestamp with time zone default now()        not null
,       uby     text                     default current_user not null
,       uts     timestamp with time zone default now()        not null
,       constraint pk_aaukdr primary key (aauk_id, dbrl_id)
);
