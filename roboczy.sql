/* Podstawowa forma. */

DECLARE
	z_id_uzytk uzytkownicy.id%TYPE;
	z_czy_udany BOOLEAN;
BEGIN
	autentykacja.odswiez_token_sesji(
		a_token_sesji => 'd',
		w_id_uzytk => z_id_uzytk,
		w_czy_udany => z_czy_udany
	);
	IF z_czy_udany THEN
		dbms_output.put_line('ID Użytkownika to: '||z_id_uzytk);
	ELSE
		dbms_output.put_line('Nie udało się.');
	END IF;
EXCEPTION
	WHEN others THEN
		 dbms_output.put_line('Nie udało się');
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

