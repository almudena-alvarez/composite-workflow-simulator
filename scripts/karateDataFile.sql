CREATE TABLE :original_schema.first (
	user_id serial PRIMARY KEY,
	username VARCHAR ( 50 ) UNIQUE NOT NULL,
	password VARCHAR ( 50 ) NOT NULL,
	email VARCHAR ( 255 ) UNIQUE NOT NULL
);

CREATE TABLE :original_schema.second (
	user_id serial PRIMARY KEY,
	username VARCHAR ( 50 ) UNIQUE NOT NULL,
	password VARCHAR ( 50 ) NOT NULL,
	email VARCHAR ( 255 ) UNIQUE NOT NULL
);

CREATE TABLE :original_schema.third (
	user_id serial PRIMARY KEY,
	username VARCHAR ( 50 ) UNIQUE NOT NULL,
	password VARCHAR ( 50 ) NOT NULL,
	email VARCHAR ( 255 ) UNIQUE NOT NULL
);


INSERT INTO :original_schema.first VALUES
(6, 'je', 'je', 'je@as.com'),
(7, 'ja', 'ja', 'ja@bc.com'),
(8, 'ji', 'ji', 'ji@df.com');


INSERT INTO :original_schema.second VALUES
(6, 'ja', 'ja', 'ja@as.com'),
(7, 'je', 'je', 'je@bc.com'),
(8, 'ji', 'ji', 'ji@df.com');


INSERT INTO :original_schema.third VALUES
(6, 'je', 'je', 'je@as.com'),
(7, 'ja', 'ja', 'ja@bc.com'),
(8, 'ji', 'ji', 'ji@df.com');
