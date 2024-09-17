CREATE OR REPLACE FUNCTION serial_generator(beg INTEGER, endd INTEGER)
  RETURNS TABLE (serial_generator INTEGER) AS
$$
DECLARE
  i INTEGER := beg;
BEGIN
	CREATE TEMPORARY TABLE temp_table (
		serial_generator INTEGER
	);
 
  FOR i IN beg..(endd - 1) LOOP
    EXECUTE 'INSERT INTO temp_table (serial_generator) VALUES (' || i || ')';
  END LOOP;

  RETURN QUERY
  SELECT *
  FROM temp_table;
END;
$$
LANGUAGE plpgsql;
