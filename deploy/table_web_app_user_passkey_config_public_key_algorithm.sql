create table if not exists app_data.web_app_user_passkey_config_public_key_algorithm
(
        tnt_id bigint                                        not null
,       pkg_id bigint                                        not null
,       cby    text                     default current_user not null
,       cts    timestamp with time zone default now()        not null
,       uby    text                     default current_user not null
,       uts    timestamp with time zone default now()        not null
,       constraint pk_pra primary key (tnt_id, pkg_id)
);
