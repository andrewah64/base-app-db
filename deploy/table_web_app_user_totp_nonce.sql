create table if not exists app_data.web_app_user_totp_nonce
(
        aur_id     bigint                   not null
,       nnc_nonce  text                     not null
,       nnc_exp_ts timestamp with time zone not null
,       constraint pk_nnc primary key (aur_id)
,       constraint uk_nnc unique      (nnc_nonce)
);
