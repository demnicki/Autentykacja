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
END kurs_walut;