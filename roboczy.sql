/* Podstawowa forma. */

DECLARE

BEGIN
	SAVEPOINT aa;

	COMMIT;
	dbms_output.put_line('');
EXCEPTION
	WHEN others THEN
		ROLLBACK TO aa;
		 dbms_output.put_line('');
END;

/* Praca nad ....*/

DECLARE
	t_json JSON_ARRAY_T;
	o_json JSON_OBJECT_T;
BEGIN
	kurs_walut.pobierz_nbp(
			tablica_json => t_json
		);
	FOR i IN 1..t_json.get_size LOOP
				o_json := TREAT (t_json.get(i) AS JSON_OBJECT_T);
				dbms_output.put_line(o_json.get('effectiveDate').to_string||' '||o_json.get('mid').to_string);			
			END LOOP;
EXCEPTION
	WHEN others THEN
		 dbms_output.put_line('Błąd.');
END;

