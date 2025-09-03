create table if not exists app_data.api_app_user
(
        aur_id      bigint                                              not null
,       aur_tkn_dn  interval                 default interval '2 hours' not null
,       aur_enabled boolean                  default true               not null
,       cby         name                     default current_user       not null
,       cts         timestamp with time zone default now()              not null
,       uby         name                     default current_user       not null
,       uts         timestamp with time zone default now()              not null
,       constraint pk_aaur        primary key (aur_id)
,       constraint ck_aaur_tkn_dn check       (aur_tkn_dn between '0 hours' and '12 hours')
);
