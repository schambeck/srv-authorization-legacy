CREATE TABLE IF NOT EXISTS user_account_role
(
    id   character varying(255) NOT NULL,
    role character varying(255) NOT NULL
);

ALTER TABLE ONLY user_account_role
    ADD CONSTRAINT user_account_role_pkey PRIMARY KEY (id);

ALTER TABLE ONLY user_account_role
    ADD CONSTRAINT uk_6044sxgwx7e02symm69mjnfth UNIQUE (role);
