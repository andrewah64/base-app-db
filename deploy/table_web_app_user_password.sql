create table if not exists app_data.web_app_user_password
(
        aur_id      bigint                                         not null
,       aur_hsh_pw  text                                           not null
,       cby         text                     default current_user  not null
,       cts         timestamp with time zone default now()         not null
,       uby         text                     default current_user  not null
,       uts         timestamp with time zone default now()         not null
,       constraint pk_aup        primary key (aur_id)
,       constraint ck_aur_hsh_pw check       (length(trim(aur_hsh_pw)) > 0)
);
