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
	z_tablica_json JSON_ARRAY_T;
BEGIN
	kurs.walut.pobierz_nbp(tablica_json => z_tablica_json);
	dbms_output.put_line(z_tablica_json.to_string);
EXCEPTION
	WHEN others THEN
		 dbms_output.put_line('Błąd.');
END;

