CREATE OR REPLACE PACKAGE BODY autentykacja
IS
	PROCEDURE utworzenie_nowego_uzytk(
		a_login_email IN VARCHAR2,
		a_nazwa_uzytk IN VARCHAR2,
		w_czy_udany OUT BOOLEAN,
		w_token_sesji OUT CHAR
	)
	IS
	BEGIN
		NULL;
	EXCEPTION
			WHEN others THEN
			NULL;
	END utworzenie_nowego_uzytk;

	PROCEDURE log_uzytk(
		a_login_email IN VARCHAR2,
		w_czy_udany OUT BOOLEAN,
		w_token_sesji OUT CHAR
	)
	IS
	BEGIN
		NULL;
	EXCEPTION
			WHEN others THEN
			NULL;
	END log_uzytk;

	FUNCTION uzytk(a_login_email VARCHAR2) RETURN BOOLEAN
	IS

	BEGIN
		RETURN FALSE;
	END uzytk;

	FUNCTION autent_arkusza(a_id NUMBER, a_haslo VARCHAR2) RETURN BOOLEAN
	IS

	BEGIN
		RETURN FALSE;
	END autent_arkusza;

	FUNCTION zaszyfr_post(a_tresc VARCHAR2, a_klucz VARCHAR2) RETURN VARCHAR2
	IS

	BEGIN
		RETURN 'Coœ tam.';
	END zaszyfr_post;

	FUNCTION deszyfr_post(a_tresc VARCHAR2, a_klucz VARCHAR2) RETURN VARCHAR2
	IS

	BEGIN
		RETURN 'Coœ tam.';
	END deszyfr_post;

	FUNCTION sys_op(a_wartosc VARCHAR2) RETURN VARCHAR2
	IS
		tablica autentykacja.tablica_agenta;
		indeks  VARCHAR2(100 CHAR);
		wynik   VARCHAR2(200 CHAR) := 'System nieznany';
	BEGIN
		tablica('windows NT 10.0') := 'Windows 10/11';
		tablica('windows NT 6.3')  := 'Windows 8.1';
	    tablica('windows nt 6.2')  := 'Windows 8';
	    tablica('windows nt 6.1')  := 'Windows 7';
	    tablica('macintosh')       := 'Mac OS X';
	    tablica('mac_powerpc')     := 'Mac OS 9';
	    tablica('linux')           := 'Linux';
	    tablica('ubuntu')          := 'Ubuntu';
	    tablica('iphone')          := 'iPhone';
	    tablica('ipod')            := 'iPod';
	    tablica('ipad')            := 'iPad';
	    tablica('android')         := 'Android';
	    tablica('webos')           := 'Mobile';
		indeks := tablica.FIRST;
		WHILE (indeks IS NOT NULL) LOOP
			IF regexp_count(lower(a_wartosc), lower(indeks)) > 0 THEN
				 wynik := tablica(indeks);
			END IF;
			indeks := tablica.NEXT(indeks);
		END LOOP;
		RETURN wynik;
	END sys_op;

	FUNCTION przegl(a_wartosc VARCHAR2) RETURN VARCHAR2
	IS
		tablica autentykacja.tablica_agenta;
		indeks  VARCHAR2(100 CHAR);
		wynik   VARCHAR2(200 CHAR);
	BEGIN
		wynik := a_wartosc;
	    tablica('safari')         := 'Safari';
	    tablica('postmanruntime') := 'PostMan';
		tablica('msie')           := 'Internet Explorer';
		tablica('firefox')        := 'Firefox';
	    tablica('chrome')         := 'Chrome';
	    tablica('edge')           := 'Edge';
	    tablica('opera')          := 'Opera';
		IF regexp_count(lower(a_wartosc), 'safari') > 0 THEN
			wynik := 'Safari';
	        tablica.DELETE('safari');
	        indeks := tablica.FIRST;
			WHILE (indeks IS NOT NULL) LOOP
				IF regexp_count(lower(a_wartosc), lower(indeks)) > 0 THEN
					wynik := tablica(indeks);
				END IF;
				indeks := tablica.NEXT(indeks);
			END LOOP;
		ELSIF regexp_count(lower(a_wartosc), 'postmanruntime') > 0 THEN
			wynik := 'PostMan';
		END IF; 
	    RETURN wynik;
	END przegl;

	FUNCTION jezyk(a_wartosc VARCHAR2) RETURN VARCHAR2
	IS
		tablica autentykacja.tablica_agenta;
		indeks  VARCHAR2(100 CHAR);
		wynik   VARCHAR2(200 CHAR) := 'Jêzyk nieznany';
	BEGIN
		tablica('en-') := 'J. angielski';
		tablica('pl-') := 'J. polski';
	    tablica('de-') := 'J. niemiecki';
	    tablica('es-') := 'J. hiszpañski';
	    tablica('ru-') := 'J. rosyjski';
		tablica('ua-') := 'J. ukraiñski';
		indeks := tablica.FIRST;
		WHILE (indeks IS NOT NULL) LOOP
			IF regexp_count(lower(a_wartosc), lower(indeks)) > 0 THEN
				 wynik := tablica(indeks);
			END IF;
			indeks := tablica.NEXT(indeks);
		END LOOP;
		RETURN wynik;
	END jezyk;
END autentykacja;