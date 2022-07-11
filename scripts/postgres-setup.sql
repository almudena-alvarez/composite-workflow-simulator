CREATE SCHEMA esq_almu_dena AUTHORIZATION postgres_user;


CREATE TABLE esq_almu_dena.first (
	user_id serial PRIMARY KEY,
	username VARCHAR ( 50 ) UNIQUE NOT NULL,
	password VARCHAR ( 50 ) NOT NULL,
	email VARCHAR ( 255 ) UNIQUE NOT NULL
);

CREATE TABLE esq_almu_dena.second (
	user_id serial PRIMARY KEY,
	username VARCHAR ( 50 ) UNIQUE NOT NULL,
	password VARCHAR ( 50 ) NOT NULL,
	email VARCHAR ( 255 ) UNIQUE NOT NULL
);

CREATE TABLE esq_almu_dena.third (
	user_id serial PRIMARY KEY,
	username VARCHAR ( 50 ) UNIQUE NOT NULL,
	password VARCHAR ( 50 ) NOT NULL,
	email VARCHAR ( 255 ) UNIQUE NOT NULL
);

INSERT INTO esq_almu_dena.first VALUES
(0, 'as', 'as', 'as@as.com'),
(1, 'bc', 'bc', 'bc@bc.com'),
(2, 'df', 'df', 'df@df.com');


INSERT INTO esq_almu_dena.second VALUES
(0, 'as', 'as', 'as@as.com'),
(1, 'bc', 'bc', 'bc@bc.com'),
(2, 'df', 'df', 'df@df.com');


INSERT INTO esq_almu_dena.third VALUES
(0, 'as', 'as', 'as@as.com'),
(1, 'bc', 'bc', 'bc@bc.com'),
(2, 'df', 'df', 'df@df.com');


\dn
\dt esq_almu_dena.*
