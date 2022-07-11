ALTER SCHEMA :original_schema RENAME TO :copySchema;
\dn;
CREATE SCHEMA :original_schema AUTHORIZATION :target_username;
