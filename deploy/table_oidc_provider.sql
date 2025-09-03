create table app_data.oidc_provider
(
        ocp_id     bigint                    generated always as identity not null
,       ocp_nm     text                                                   not null
,       cby        name                      default current_user         not null
,       cts        timestamp with time zone  default now()                not null
,       uby        name                      default current_user         not null
,       uts        timestamp with time zone  default now()                not null
,       constraint pk_ocp     primary key (ocp_id)
,       constraint uk_ocp_nm  unique      (ocp_nm)
,       constraint ck_ocp_nm  check       (ocp_nm = lower(ocp_nm))
);
