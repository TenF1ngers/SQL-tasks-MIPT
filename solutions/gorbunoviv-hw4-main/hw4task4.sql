CREATE OR REPLACE VIEW v_rec_level_partition_info AS
WITH RECURSIVE cte_partitions AS (
  SELECT
    parent_nsp.nspname AS parent_schema,
    parent_class.relname AS parent_table,
    child_nsp.nspname AS child_schema,
    child_class.relname AS child_table,
    1 AS part_level
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
    AND child_nsp.nspname = 'public'
  UNION ALL
  SELECT
    parent_nsp.nspname,
    parent_class.relname,
    child_nsp.nspname,
    child_class.relname,
    part_level + 1
  FROM
    cte_partitions
    INNER JOIN pg_inherits ON cte_partitions.child_table::regclass = pg_inherits.inhparent::regclass
    INNER JOIN pg_class parent_class ON pg_inherits.inhparent = parent_class.oid
    INNER JOIN pg_namespace parent_nsp ON parent_class.relnamespace = parent_nsp.oid
    INNER JOIN pg_class child_class ON pg_inherits.inhrelid = child_class.oid
    INNER JOIN pg_namespace child_nsp ON child_class.relnamespace = child_nsp.oid
  WHERE
    parent_nsp.nspname = 'public'
    AND child_nsp.nspname = 'public'
)
SELECT *
FROM cte_partitions;
