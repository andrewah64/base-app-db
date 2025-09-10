create table if not exists app_data.web_app_user_password_config
(
        tnt_id               bigint                                        not null
,       aupc_aur_nm_min_len  int                      default 1            not null
,       aupc_aur_nm_max_len  int                      default 10           not null
,       aupc_aur_pwd_min_len int                      default 1            not null
,       aupc_aur_pwd_max_len int                      default 10           not null
,       aupc_aur_pwd_inc_sym boolean                  default true         not null
,       aupc_aur_pwd_inc_num boolean                  default true         not null
,       aupc_enabled         boolean                  default true         not null
,       aupc_mfa_enabled     boolean                  default true         not null
,       cby                  text                     default current_user not null
,       cts                  timestamp with time zone default now()        not null
,       uby                  text                     default current_user not null
,       uts                  timestamp with time zone default now()        not null
,       constraint pk_aupc                 primary key (tnt_id)
,       constraint ck_aupc_aur_nm_min_len  check       (aupc_aur_nm_min_len  >= 1 and aupc_aur_nm_min_len  <= aupc_aur_nm_max_len)
,       constraint ck_aupc_aur_nm_max_len  check       (aupc_aur_nm_max_len  >= 1 and aupc_aur_nm_max_len  >= aupc_aur_nm_min_len)
,       constraint ck_aupc_aur_pwd_min_len check       (aupc_aur_pwd_min_len >= 1 and aupc_aur_pwd_min_len <= aupc_aur_pwd_max_len)
,       constraint ck_aupc_aur_pwd_max_len check       (aupc_aur_pwd_max_len >= 1 and aupc_aur_pwd_max_len >= aupc_aur_pwd_min_len)
);
