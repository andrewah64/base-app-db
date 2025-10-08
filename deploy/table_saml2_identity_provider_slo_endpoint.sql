create table if not exists app_data.saml2_identity_provider_slo_endpoint
(
        slo_id        bigint                   generated always as identity not null
,       idp_id        bigint                                                not null
,       slo_url       text                                                  not null
,       bnd_id        bigint                                                not null
,       slo_enabled   boolean                  default false                not null
,       cby           text                     default current_user         not null
,       cts           timestamp with time zone default now()                not null
,       uby           text                     default current_user         not null
,       uts           timestamp with time zone default now()                not null
,       constraint pk_slo     primary key (slo_id)
,       constraint uk_slo     unique      (idp_id, slo_url, bnd_id)
,       constraint ck_slo_url check       (length(trim(slo_url)) > 0)
);
