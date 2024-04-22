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
		t_json JSON_ARRAY_T;
		o_json JSON_OBJECT_T;
	BEGIN
		kurs_walut.pobierz_nbp(
			tablica_json => t_json
		);
		IF t_json.get_size = 0 THEN
			PIPE ROW(t_o_kurs_walut(sysdate , 0.0));
			RETURN;

		ELSIF t_json.get_size > 0 THEN
			FOR i IN 1..t_json.get_size LOOP
				o_json := TREAT (t_json.get(i) AS JSON_OBJECT_T);
				PIPE ROW(t_o_kurs_walut(to_date(o_json.get('effectiveDate').to_string, 'RRRR-MM-DD'), o_json.get('mid').to_number));			
			END LOOP;
			RETURN;
		END IF;
		RETURN;
	EXCEPTION
		WHEN others THEN
			PIPE ROW(t_o_kurs_walut(sysdate , 0.0));
			RETURN;
	END kurs_eur;
END kurs_walut;