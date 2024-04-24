CREATE OR REPLACE PACKAGE autentykacja
IS
	TYPE tablica_agenta IS TABLE OF VARCHAR2(100 CHAR) INDEX BY VARCHAR2(100 CHAR);

	PROCEDURE utworzenie_nowego_uzytk(
		a_login_email IN VARCHAR2,
		a_nazwa_uzytk IN VARCHAR2,
		a_ip          IN VARCHAR2,
		a_agent       IN VARCHAR2,
		w_czy_udany   OUT BOOLEAN,
		w_token_sesji OUT CHAR
	);

	PROCEDURE log_uzytk(
		a_login_email IN VARCHAR2,
		a_ip          IN VARCHAR2,
		a_agent       IN VARCHAR2,
		w_czy_udany   OUT BOOLEAN,
		w_token_sesji OUT CHAR
	);

	FUNCTION uzytk(a_login_email VARCHAR2) RETURN BOOLEAN;

	FUNCTION autent_arkusza(a_id NUMBER, a_haslo VARCHAR2) RETURN BOOLEAN;

	FUNCTION zaszyfr_post(a_tresc VARCHAR2, a_klucz VARCHAR2) RETURN VARCHAR2;

	FUNCTION deszyfr_post(a_tresc VARCHAR2, a_klucz VARCHAR2) RETURN VARCHAR2;

	FUNCTION sys_op(a_wartosc VARCHAR2) RETURN VARCHAR2;

	FUNCTION przegl(a_wartosc VARCHAR2) RETURN VARCHAR2;

	FUNCTION jezyk(a_wartosc VARCHAR2) RETURN VARCHAR2;
END autentykacja;