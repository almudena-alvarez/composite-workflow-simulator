DROP SCHEMA :original_schema CASCADE;
\dn;
ALTER SCHEMA :copy_schema RENAME TO :original_schema;
\dn;
