create table app_data.oidc_scope
(
        ocs_id bigint                    generated always as identity not null
,       ocs_nm text                                                   not null
,       cby    name                      default current_user         not null
,       cts    timestamp with time zone  default now()                not null
,       uby    name                      default current_user         not null
,       uts    timestamp with time zone  default now()                not null
,       constraint pk_ocs    primary key (ocs_id)
,       constraint uk_ocs_nm unique      (ocs_nm)
);
