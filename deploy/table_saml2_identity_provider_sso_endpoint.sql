create table if not exists app_data.saml2_identity_provider_sso_endpoint
(
        sso_id        bigint                   generated always as identity not null
,       idp_id        bigint                                                not null
,       sso_url       text                                                  not null
,       bnd_id        bigint                                                not null
,       sso_enabled   boolean                  default false                not null
,       cby           text                     default current_user         not null
,       cts           timestamp with time zone default now()                not null
,       uby           text                     default current_user         not null
,       uts           timestamp with time zone default now()                not null
,       constraint pk_sso     primary key (sso_id)
,       constraint uk_sso     unique      (idp_id, sso_url, bnd_id)
,       constraint ck_sso_url check       (length(trim(sso_url)) > 0)
);
