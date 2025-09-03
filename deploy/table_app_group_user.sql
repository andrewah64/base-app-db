create table if not exists app_data.app_group_user
(
        grp_id bigint not null
,       aur_id bigint not null
,       cby    name                     default current_user         not null
,       cts    timestamp with time zone default now()                not null
,       uby    name                     default current_user         not null
,       uts    timestamp with time zone default now()                not null
,       constraint pk_aug primary key (grp_id, aur_id)
);
