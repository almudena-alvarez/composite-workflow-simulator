DROP SCHEMA $original_schema CASCADE;
\dn;
ALTER SCHEMA $copySchema RENAME TO $original_schema;
\dn;
