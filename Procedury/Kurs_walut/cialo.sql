CREATE OR REPLACE PACKAGE BODY kurs_walut
IS
	PROCEDURE pobierz_nbp(
		tablica_json OUT JSON_ARRAY_T
	)
		IS
			data_obecna   VARCHAR2(10 CHAR);
			data_ostatnia VARCHAR2(10 CHAR);
			obiekt_json   JSON_OBJECT_T;
		BEGIN
			SELECT to_char(current_timestamp - interval '30' day, 'RRRR-MM-DD'), to_char(current_timestamp, 'RRRR-MM-DD') INTO data_ostatnia, data_obecna FROM dual;
			obiekt_json := json_object_t(apex_web_service.make_rest_request(
			    p_url => kurs_walut.o_url||data_ostatnia||'/'||data_obecna||kurs_walut.z_url,
				p_http_method => 'GET'));
			tablica_json := json_array_t(obiekt_json.get('rates'));
		EXCEPTION
			WHEN others THEN
				tablica_json := json_array_t('[]');
	END pobierz_nbp;

	FUNCTION kurs_eur RETURN t_t_kurs_walut PIPELINED AS
		t_json        JSON_ARRAY_T;
		o_json        JSON_OBJECT_T;
		z_data_zmiany DATE;
		z_kurs_zmiany NUMBER(6, 4);
	BEGIN
		kurs_walut.pobierz_nbp(
			tablica_json => t_json
		);
		IF t_json.get_size = 0 THEN
			PIPE ROW(t_o_kurs_walut(sysdate , 0.0));
			RETURN;
		ELSIF t_json.get_size > 0 THEN
			FOR i IN 0..t_json.get_size - 1 LOOP
				o_json := json_object_t(t_json.get(i));
				z_data_zmiany := o_json.get_date('effectiveDate');
				z_kurs_zmiany := o_json.get_number('mid');
				PIPE ROW(t_o_kurs_walut(z_data_zmiany, z_kurs_zmiany));	
			END LOOP;
			RETURN;
		END IF;
		RETURN;
	EXCEPTION
		WHEN others THEN
			PIPE ROW(t_o_kurs_walut(sysdate , 0.0));
			RETURN;
	END kurs_eur;

	FUNCTION gen_wykres(tablica CLOB) RETURN t_t_gen_wykres PIPELINED AS
		t_json   JSON_ARRAY_T;
		o_json   JSON_OBJECT_T;
		z_imie   VARCHAR2(250 CHAR);
		z_liczba NUMBER(6, 2);
	BEGIN
		t_json := json_array_t(tablica);
		IF t_json.get_size = 0 THEN
			PIPE ROW(t_o_gen_wykres('Pusta tablica', 0));	
			RETURN;
		ELSIF t_json.get_size > 0 THEN
			FOR i IN 0..t_json.get_size - 1 LOOP
				o_json := json_object_t(t_json.get(i));
				z_imie := o_json.get_string('imie');
				z_liczba := o_json.get_number('liczba');
				PIPE ROW(t_o_gen_wykres(z_imie, z_liczba));	
			END LOOP;
			RETURN;
		END IF;
	EXCEPTION
		WHEN others THEN
			PIPE ROW(t_o_gen_wykres('Pusta tablica', 0));	
			RETURN;
	END gen_wykres;
END kurs_walut;