CREATE SCHEMA esq_workflow AUTHORIZATION postgres_user;


CREATE TABLE esq_workflow.first (
	user_id serial PRIMARY KEY,
	username VARCHAR ( 50 ) UNIQUE NOT NULL,
	password VARCHAR ( 50 ) NOT NULL,
	email VARCHAR ( 255 ) UNIQUE NOT NULL
);

CREATE TABLE esq_workflow.second (
	user_id serial PRIMARY KEY,
	username VARCHAR ( 50 ) UNIQUE NOT NULL,
	password VARCHAR ( 50 ) NOT NULL,
	email VARCHAR ( 255 ) UNIQUE NOT NULL
);

CREATE TABLE esq_workflow.third (
	user_id serial PRIMARY KEY,
	username VARCHAR ( 50 ) UNIQUE NOT NULL,
	password VARCHAR ( 50 ) NOT NULL,
	email VARCHAR ( 255 ) UNIQUE NOT NULL
);

INSERT INTO esq_workflow.first VALUES
(0, 'as', 'as', 'as@as.com'),
(1, 'bc', 'bc', 'bc@bc.com'),
(2, 'df', 'df', 'df@df.com');


INSERT INTO esq_workflow.second VALUES
(0, 'as', 'as', 'as@as.com'),
(1, 'bc', 'bc', 'bc@bc.com'),
(2, 'df', 'df', 'df@df.com');


INSERT INTO esq_workflow.third VALUES
(0, 'as', 'as', 'as@as.com'),
(1, 'bc', 'bc', 'bc@bc.com'),
(2, 'df', 'df', 'df@df.com');


\dn
\dt esq_workflow.*
