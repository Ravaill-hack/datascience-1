DROP TABLE IF EXISTS customers;

DO $$
DECLARE
	instructions TEXT;
BEGIN
	SELECT string_agg(format('SELECT * FROM %I', table_name),' UNION ALL ')
	INTO instructions
	FROM information_schema.tables
	WHERE table_schema = 'public'
		AND table_name LIKE 'data_202%_%';

	EXECUTE 'CREATE TABLE customers AS ' || instructions;
END $$;