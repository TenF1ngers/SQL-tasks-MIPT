CREATE OR REPLACE FUNCTION count_non_volatile_days(input_nm TEXT)
 RETURNS INTEGER AS
$$
DECLARE
	count NUMERIC := 0;
	row_data RECORD;
	answer NUMERIC := 0;
BEGIN
	FOR row_data IN (SELECT * FROM coins) LOOP
		IF row_data.full_nm = input_nm THEN
		  count := count + 1;
		END IF;
  	END LOOP;

	IF count = 0 THEN
		RAISE NOTICE 'Crypto currency with name % is absent in database!', input_nm;
		RAISE EXCEPTION '02000';
	END IF;
	
	FOR row_data IN (SELECT * FROM coins c WHERE c.full_nm = input_nm) LOOP
		IF row_data.high_price = row_data.low_price THEN
			answer := answer + 1;
		END IF;
	END LOOP;
	
	RETURN answer;
END;
$$ LANGUAGE plpgsql;
