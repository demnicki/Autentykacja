/* Tester dla API Narodowego Banku Polskiego .*/

DECLARE
	o_json JSON_ARRAY_T;
BEGIN
	kurs_walut.pobierz_nbp(
			tablica_json => o_json
		);
	dbms_output.put_line(o_json.stringify);
EXCEPTION
	WHEN others THEN
		 dbms_output.put_line('Błąd.');
END;