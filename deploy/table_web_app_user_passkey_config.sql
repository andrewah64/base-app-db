create table if not exists app_data.web_app_user_passkey_config
(
        tnt_id               bigint                                        not null
,       aukc_aur_nm_min_len  int                      default 1            not null
,       aukc_aur_nm_max_len  int                      default 1            not null
,       aukc_enabled         boolean                  default true         not null
,       pka_id               bigint                                        not null
,       pkt_id               bigint                                        not null
,       pdc_id               bigint                                        not null
,       puv_reg_id           bigint                                        not null
,       puv_atn_id           bigint                                        not null
,       cby                  text                     default current_user not null
,       cts                  timestamp with time zone default now()        not null
,       uby                  text                     default current_user not null
,       uts                  timestamp with time zone default now()        not null
,       constraint pk_aukc                primary key (tnt_id)
,       constraint ck_aukc_aur_nm_min_len check       (aukc_aur_nm_min_len >= 1 and aukc_aur_nm_min_len <= aukc_aur_nm_max_len)
,       constraint ck_aukc_aur_nm_max_len check       (aukc_aur_nm_max_len >= 1 and aukc_aur_nm_max_len >= aukc_aur_nm_min_len)
);
