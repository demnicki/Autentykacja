/* Podstawowa forma. */

DECLARE
	z_czy_udany BOOLEAN;
	z_token_sesji VARCHAR2(100 CHAR);
BEGIN
		autentykacja.log_uzytk(
			a_login_email => 'adam@wp.pl',
			a_ip => '111',
			a_agent => 'kom',
			w_czy_udany => z_czy_udany,
			w_token_sesji => z_token_sesji
		);
	IF z_czy_udany THEN
		dbms_output.put_line('Udało się');
	ELSE
		dbms_output.put_line('Nie udało się');
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

