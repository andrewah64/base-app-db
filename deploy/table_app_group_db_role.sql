create table if not exists app_data.app_group_db_role
(
        grp_id   bigint                                         not null
,       dbrl_id  bigint                                         not null
,       cby      name                      default current_user not null
,       cts      timestamp with time zone  default now()        not null
,       uby      name                      default current_user not null
,       uts      timestamp with time zone  default now()        not null
,       constraint pk_grpdr primary key (grp_id, dbrl_id)
);
