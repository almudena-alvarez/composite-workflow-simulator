ALTER SCHEMA $original_schema RENAME TO $copySchema;
\dn;
CREATE SCHEMA $original_schema AUTHORIZATION $p_target_username;
