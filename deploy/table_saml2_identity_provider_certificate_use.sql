create table app_data.saml2_identity_provider_certificate_use
(
        cru_id bigint                    generated always as identity not null
,       cru_nm text                                                   not null
,       cby    name                      default current_user         not null
,       cts    timestamp with time zone  default now()                not null
,       uby    name                      default current_user         not null
,       uts    timestamp with time zone  default now()                not null
,       constraint pk_cru    primary key (cru_id)
,       constraint uk_cru_nm unique      (cru_nm)
,       constraint ck_cru_nm check       (cru_nm = trim(cru_nm) and length(trim(cru_nm)) > 0)
);
