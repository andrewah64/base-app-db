create table if not exists app_data.app_group
(
        grp_id       bigint                   generated always as identity not null
,       tnt_id       bigint                                                not null
,       grp_nm       text                                                  not null
,       grp_can_del  boolean                  default true                 not null
,       grp_can_edt  boolean                  default true                 not null
,       grp_aur_dflt boolean                  default false                not null
,       cby          name                     default current_user         not null
,       cts          timestamp with time zone default now()                not null
,       uby          name                     default current_user         not null
,       uts          timestamp with time zone default now()                not null
,       constraint pk_grp      primary key (grp_id)
,       constraint uk_grp_nm   unique      (tnt_id, grp_nm)
,       constraint ck_grp_nm   check       (length(trim(grp_nm)) > 0)
);
