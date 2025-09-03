create table if not exists app_data.endpoint_log_level
(
    ell_id   bigint                    generated always as identity not null
,   tnt_id   bigint                                                 not null
,   ep_id    bigint                                                 not null
,   lvl_id   bigint                                                 not null
,   cby      name                      default current_user         not null
,   cts      timestamp with time zone  default now()                not null
,   uby      name                      default current_user         not null
,   uts      timestamp with time zone  default now()                not null
,   constraint pk_ell primary key (ell_id)
,   constraint uk_ell unique      (tnt_id, ep_id)
);
