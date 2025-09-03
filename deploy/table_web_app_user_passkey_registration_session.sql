create table if not exists app_data.web_app_user_passkey_registration_session
(
    tnt_id bigint                                        not null
,   aur_nm text                                          not null
,   prs_js bytea                                         not null
,   cby    name                     default current_user not null
,   cts    timestamp with time zone default now()        not null
,   uby    name                     default current_user not null
,   uts    timestamp with time zone default now()        not null
,   constraint pk_prs    primary key (tnt_id, aur_nm)
,   constraint ck_prs_nm check       (length(trim(aur_nm)) > 0 and (aur_nm = lower(trim(aur_nm))))
);
