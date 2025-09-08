create table if not exists app_data.saml2_identity_provider_metadata_endpoint
(
        mde_id        bigint                   generated always as identity not null
,       idp_id        bigint                                                not null
,       mde_url       text                                                  not null
,       mde_enabled   boolean                  default true                 not null
,       cby           text                     default current_user         not null
,       cts           timestamp with time zone default now()                not null
,       uby           text                     default current_user         not null
,       uts           timestamp with time zone default now()                not null
,       constraint pk_mde     primary key (mde_id)
,       constraint uk_mde     unique      (idp_id, mde_url)
,       constraint ck_mde_url check       (length(trim(mde_url)) > 0)
);
