DROP TABLE IF EXISTS oauth2_registered_client;
CREATE TABLE IF NOT EXISTS oauth2_registered_client
(
    id                            varchar(100)                            NOT NULL,
    client_id                     varchar(100)                            NOT NULL,
    client_id_issued_at           timestamp     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    client_secret                 varchar(200)  DEFAULT NULL,
    client_secret_expires_at      timestamp     DEFAULT NULL,
    client_name                   varchar(200)                            NOT NULL,
    client_authentication_methods varchar(1000)                           NOT NULL,
    authorization_grant_types     varchar(1000)                           NOT NULL,
    redirect_uris                 varchar(1000) DEFAULT NULL,
    scopes                        varchar(1000)                           NOT NULL,
    client_settings               varchar(2000)                           NOT NULL,
    token_settings                varchar(2000)                           NOT NULL,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS oauth2_authorization;
CREATE TABLE IF NOT EXISTS oauth2_authorization
(
    id                            varchar(100) NOT NULL,
    registered_client_id          varchar(100) NOT NULL,
    principal_name                varchar(200) NOT NULL,
    authorization_grant_type      varchar(100) NOT NULL,
    attributes                    text          DEFAULT NULL,
    state                         varchar(500)  DEFAULT NULL,
    authorization_code_value      text          DEFAULT NULL,
    authorization_code_issued_at  timestamp     DEFAULT NULL,
    authorization_code_expires_at timestamp     DEFAULT NULL,
    authorization_code_metadata   text          DEFAULT NULL,
    access_token_value            text          DEFAULT NULL,
    access_token_issued_at        timestamp     DEFAULT NULL,
    access_token_expires_at       timestamp     DEFAULT NULL,
    access_token_metadata         text          DEFAULT NULL,
    access_token_type             varchar(100)  DEFAULT NULL,
    access_token_scopes           varchar(1000) DEFAULT NULL,
    oidc_id_token_value           text          DEFAULT NULL,
    oidc_id_token_issued_at       timestamp     DEFAULT NULL,
    oidc_id_token_expires_at      timestamp     DEFAULT NULL,
    oidc_id_token_metadata        text          DEFAULT NULL,
    refresh_token_value           text          DEFAULT NULL,
    refresh_token_issued_at       timestamp     DEFAULT NULL,
    refresh_token_expires_at      timestamp     DEFAULT NULL,
    refresh_token_metadata        text          DEFAULT NULL,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS oauth2_authorization_consent;
CREATE TABLE IF NOT EXISTS oauth2_authorization_consent
(
    registered_client_id varchar(100)  NOT NULL,
    principal_name       varchar(200)  NOT NULL,
    authorities          varchar(1000) NOT NULL,
    PRIMARY KEY (registered_client_id, principal_name)
);

DROP TABLE IF EXISTS user_account;
CREATE TABLE user_account
(
    id       character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    username character varying(255) NOT NULL
);

DROP TABLE IF EXISTS user_account_role;
CREATE TABLE user_account_role
(
    id   character varying(255) NOT NULL,
    role character varying(255) NOT NULL
);

DROP TABLE IF EXISTS user_account_roles;
CREATE TABLE user_account_roles
(
    user_account_id character varying(255) NOT NULL,
    roles_id        character varying(255) NOT NULL
);

ALTER TABLE user_account_role
    ADD CONSTRAINT uk_6044sxgwx7e02symm69mjnfth UNIQUE (role);

ALTER TABLE user_account
    ADD CONSTRAINT user_account_pkey PRIMARY KEY (id);

ALTER TABLE user_account_role
    ADD CONSTRAINT user_account_role_pkey PRIMARY KEY (id);

ALTER TABLE user_account_roles
    ADD CONSTRAINT user_account_roles_pkey PRIMARY KEY (user_account_id, roles_id);

ALTER TABLE user_account_roles
    ADD CONSTRAINT fkpacca51k3kkqoqs0nbmyugdt2 FOREIGN KEY (user_account_id) REFERENCES user_account (id);

ALTER TABLE user_account_roles
    ADD CONSTRAINT fkpcym6uv9vnni6jivyk9wu71hs FOREIGN KEY (roles_id) REFERENCES user_account_role (id);
