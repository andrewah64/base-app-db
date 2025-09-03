create table if not exists app_data.web_app_user_passkey_login_session
(
    aur_id        bigint                                        not null
,   pls_challenge text                                          not null
,   pls_js        bytea                                         not null
,   cby           name                     default current_user not null
,   cts           timestamp with time zone default now()        not null
,   uby           name                     default current_user not null
,   uts           timestamp with time zone default now()        not null
,   constraint pk_pls    primary key (aur_id, pls_challenge)
);
