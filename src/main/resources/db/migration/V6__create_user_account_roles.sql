CREATE TABLE IF NOT EXISTS user_account_roles
(
    user_account_id character varying(255) NOT NULL,
    roles_id        character varying(255) NOT NULL
);

ALTER TABLE ONLY user_account_roles
    ADD CONSTRAINT user_account_roles_pkey PRIMARY KEY (user_account_id, roles_id);

ALTER TABLE ONLY user_account_roles
    ADD CONSTRAINT fkpacca51k3kkqoqs0nbmyugdt2 FOREIGN KEY (user_account_id) REFERENCES user_account (id);

ALTER TABLE ONLY user_account_roles
    ADD CONSTRAINT fkpcym6uv9vnni6jivyk9wu71hs FOREIGN KEY (roles_id) REFERENCES user_account_role (id);
