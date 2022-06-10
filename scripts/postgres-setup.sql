CREATE SCHEMA esq_oasis AUTHORIZATION postgres_user;


CREATE TABLE esq_oasis.first (
	user_id serial PRIMARY KEY,
	username VARCHAR ( 50 ) UNIQUE NOT NULL,
	password VARCHAR ( 50 ) NOT NULL,
	email VARCHAR ( 255 ) UNIQUE NOT NULL
);

CREATE TABLE esq_oasis.second (
	user_id serial PRIMARY KEY,
	username VARCHAR ( 50 ) UNIQUE NOT NULL,
	password VARCHAR ( 50 ) NOT NULL,
	email VARCHAR ( 255 ) UNIQUE NOT NULL
);

CREATE TABLE esq_oasis.third (
	user_id serial PRIMARY KEY,
	username VARCHAR ( 50 ) UNIQUE NOT NULL,
	password VARCHAR ( 50 ) NOT NULL,
	email VARCHAR ( 255 ) UNIQUE NOT NULL
);

INSERT INTO esq_oasis.first VALUES
(0, 'as', 'as', 'as@as.com'),
(1, 'bc', 'bc', 'bc@bc.com'),
(2, 'df', 'df', 'df@df.com');


INSERT INTO esq_oasis.second VALUES
(0, 'as', 'as', 'as@as.com'),
(1, 'bc', 'bc', 'bc@bc.com'),
(2, 'df', 'df', 'df@df.com');


INSERT INTO esq_oasis.third VALUES
(0, 'as', 'as', 'as@as.com'),
(1, 'bc', 'bc', 'bc@bc.com'),
(2, 'df', 'df', 'df@df.com');
