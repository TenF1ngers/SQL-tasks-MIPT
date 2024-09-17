CREATE OR REPLACE VIEW v_used_size_per_user AS
WITH table_sizes AS (
  SELECT 
    c.relname AS table_name,
    n.nspname AS schema_name,
    pg_catalog.pg_get_userbyid(c.relowner) AS table_owner,
    pg_catalog.pg_total_relation_size(c.oid) AS table_size
  FROM pg_catalog.pg_class c
    LEFT JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace
  WHERE 
    n.nspname NOT LIKE 'pg_%'
    AND n.nspname != 'information_schema'
    AND c.relkind = 'r'
), schema_user_sizes AS (
  SELECT 
    n.nspname AS schema_name,
    pg_catalog.pg_get_userbyid(c.relowner) AS table_owner,
    pg_size_pretty(sum(pg_catalog.pg_total_relation_size(c.oid))) AS used_per_schema_user_total_size
  FROM pg_catalog.pg_class c
    LEFT JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace
  WHERE 
    n.nspname NOT LIKE 'pg_%'
    AND n.nspname != 'information_schema'
    AND c.relkind = 'r'
  GROUP BY 1, 2
), user_sizes AS (
  SELECT 
    pg_catalog.pg_get_userbyid(c.relowner) AS table_owner,
    pg_size_pretty(sum(pg_catalog.pg_total_relation_size(c.oid))) AS used_user_total_size
  FROM pg_catalog.pg_class c
  WHERE 
    c.relkind = 'r'
  GROUP BY 1
)
SELECT 
  ts.table_owner, 
  ts.schema_name, 
  ts.table_name, 
  pg_size_pretty(ts.table_size) AS table_size,
  sus.used_per_schema_user_total_size,
  us.used_user_total_size
FROM 
  table_sizes ts
  LEFT JOIN schema_user_sizes sus ON ts.table_owner = sus.table_owner AND ts.schema_name = sus.schema_name
  LEFT JOIN user_sizes us ON ts.table_owner = us.table_owner;
