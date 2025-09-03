create table if not exists app_data.web_app_user_passkey_authenticator_transport
(
        pky_id bigint                                        not null
,       pat_id bigint                                        not null
,       cby    text                     default current_user not null
,       cts    timestamp with time zone default now()        not null
,       uby    text                     default current_user not null
,       uts    timestamp with time zone default now()        not null
,       constraint pk_kat primary key (pky_id, pat_id)
);
