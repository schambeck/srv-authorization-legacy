CREATE TABLE IF NOT EXISTS user_account
(
    id       character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    username character varying(255) NOT NULL
);

ALTER TABLE ONLY user_account
    ADD CONSTRAINT user_account_pkey PRIMARY KEY (id);
