create table if not exists app_data.web_app_user_home_page
(
        aur_id bigint                                        not null
,       pg_id  bigint                                        not null
,       cby    name                     default current_user not null
,       cts    timestamp with time zone default now()        not null
,       uby    name                     default current_user not null
,       uts    timestamp with time zone default now()        not null
,       constraint pk_wauhp primary key (aur_id)
);
