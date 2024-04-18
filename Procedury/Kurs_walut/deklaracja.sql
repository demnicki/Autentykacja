/* Adres URL do hurtowni danych NBP kursu euro.:
https://api.nbp.pl/api/exchangerates/rates/a/eur/2024-01-01/2024-01-31/?format=json
*/
CREATE OR REPLACE PACKAGE kurs_walut
IS
	o_url VARCHAR2(100 CHAR) := 'https://api.nbp.pl/api/exchangerates/rates/a/eur/';
	z_url VARCHAR2(50 CHAR) := '/?format=json';
	PROCEDURE pobierz_nbp(
		tablica_json OUT JSON_ARRAY_T
	);
END kurs_walut;