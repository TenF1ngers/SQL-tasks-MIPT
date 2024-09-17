CREATE OR REPLACE VIEW v_first_level_partition_info AS
SELECT
  parent_nsp.nspname AS parent_schema,
  parent_class.relname AS parent_table,
  child_nsp.nspname AS child_schema,
  child_class.relname AS child_table
FROM
  pg_inherits
  INNER JOIN pg_class parent_class ON pg_inherits.inhparent = parent_class.oid
  INNER JOIN pg_namespace parent_nsp ON parent_class.relnamespace = parent_nsp.oid
  INNER JOIN pg_class child_class ON pg_inherits.inhrelid = child_class.oid
  INNER JOIN pg_namespace child_nsp ON child_class.relnamespace = child_nsp.oid
WHERE
  NOT EXISTS (
    SELECT 1
    FROM pg_inherits i2
    WHERE i2.inhparent = parent_class.oid
      AND i2.inhrelid <> pg_inherits.inhrelid
  )
  AND parent_nsp.nspname = 'public'
  AND child_nsp.nspname = 'public';
