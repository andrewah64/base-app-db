create table if not exists app_data.app_user_endpoint_log_level
(
    auell_id bigint                    generated always as identity not null
,   aur_id   bigint                                                 not null
,   ep_id    bigint                                                 not null
,   lvl_id   bigint                                                 not null
,   cby      name                      default current_user         not null
,   cts      timestamp with time zone  default now()                not null
,   uby      name                      default current_user         not null
,   uts      timestamp with time zone  default now()                not null
,   constraint pk_auell primary key (auell_id)
,   constraint uk_auell unique      (aur_id, ep_id)
);
