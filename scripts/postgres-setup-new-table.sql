ALTER SCHEMA :original_schema RENAME TO :copy_schema;
\dn;
CREATE SCHEMA :original_schema AUTHORIZATION :target_username;
\dn;
