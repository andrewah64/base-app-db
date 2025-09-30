create table app_data.saml2_endpoint_binding
(
        bnd_id bigint                    generated always as identity not null
,       bnd_nm text                                                   not null
,       cby    name                      default current_user         not null
,       cts    timestamp with time zone  default now()                not null
,       uby    name                      default current_user         not null
,       uts    timestamp with time zone  default now()                not null
,       constraint pk_bnd    primary key (bnd_id)
,       constraint uk_bnd_nm unique      (bnd_nm)
,       constraint ck_bnd_nm check       (length(trim(bnd_nm)) > 0 and bnd_nm = trim(bnd_nm))
);
