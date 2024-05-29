/* Tester dla API Narodowego Banku Polskiego .*/

DECLARE
	t_json JSON_ARRAY_T;
	o_json JSON_OBJECT_T;
	z_k_data_zmiany DATE;
	z_k_kurs_zmianu NUMBER(6, 4);
BEGIN
	kurs_walut.pobierz_nbp(
			tablica_json => t_json
		);
	dbms_output.put_line('długość tablicy: '||t_json.get_size);
	FOR i IN 1..t_json.get_size-1 LOOP
		o_json := json_object_t(t_json.get(i));
		dbms_output.put_line('Wartość pojedyńczego JSONa'||o_json.stringify);
		z_k_data_zmiany := o_json.get_date('effectiveDate');
		z_k_kurs_zmianu := o_json.get_number('mid');
        /* INSERT INTO testowa(k_data_zmiany, k_kurs_zmianu) VALUES (to_date(o_json.get_string('effectiveDate'), 'RRRR-MM-DD'), to_number(o_json.get_string('mid')); */
		dbms_output.put_line('k_data_zmiany: '||o_json.get_string('effectiveDate')||' k_kurs_zmianu: '||z_k_kurs_zmianu);
	END LOOP;
	COMMIT;
END;