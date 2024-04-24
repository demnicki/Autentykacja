CREATE OR REPLACE PACKAGE BODY autentykacja
IS
	PROCEDURE utworzenie_nowego_uzytk(
		a_login_email IN VARCHAR2,
		a_nazwa_uzytk IN VARCHAR2,
		a_ip          IN VARCHAR2,
		a_agent       IN VARCHAR2,
		w_czy_udany   OUT BOOLEAN,
		w_token_sesji OUT CHAR
	)
	IS
		z_id          uzytkownicy.id%TYPE;
		z_token_sesji uzytkownicy.token_sesji%TYPE;
	BEGIN
		w_czy_udany := FALSE;
		w_token_sesji := 'Pusty.';
		IF (instr(a_login_email, '@') != 0) AND (instr(a_login_email, '.') != 0) THEN
			z_token_sesji := substr(dbms_random.string('A', dbms_random.value(32, 32)), 0, 32);
			INSERT INTO uzytkownicy (email, nazwa_uzytkownika, typ_uprawnien, token_sesji, czas_wyg_sesji) VALUES
				(a_login_email, a_nazwa_uzytk, 'c', z_token_sesji, current_timestamp + interval '20' minute);
			COMMIT;
			SELECT id INTO z_id FROM uzytkownicy WHERE email = a_login_email;
			INSERT INTO logi (id_uzytk, czy_udany, ip, agent) VALUES
				(z_id, 't', a_ip, a_agent);
			COMMIT;
			w_czy_udany := TRUE;
			w_token_sesji := z_token_sesji;
		END IF;
	EXCEPTION
			WHEN others THEN
			ROLLBACK;
			w_czy_udany := FALSE;
			w_token_sesji := 'Pusty.';
	END utworzenie_nowego_uzytk;

	PROCEDURE log_uzytk(
		a_login_email IN VARCHAR2,
		a_ip          IN VARCHAR2,
		a_agent       IN VARCHAR2,
		w_czy_udany   OUT BOOLEAN,
		w_token_sesji OUT CHAR
	)
	IS
		z_id          uzytkownicy.id%TYPE;
		z_token_sesji uzytkownicy.token_sesji%TYPE;
		z_n           NUMBER(1);
	BEGIN
		w_czy_udany := FALSE;
		w_token_sesji := 'Pusty.';
		SELECT count(id) INTO z_n FROM uzytkownicy WHERE email = a_login_email;
		IF z_n = 1 THEN
			z_token_sesji := substr(dbms_random.string('A', dbms_random.value(32, 32)), 0, 32);
			SELECT id INTO z_id FROM uzytkownicy WHERE email = a_login_email;
			UPDATE uzytkownicy SET token_sesji = z_token_sesji, czas_wyg_sesji = current_timestamp + interval '20' minute WHERE id = z_id;
			INSERT INTO logi (id_uzytk, czy_udany, ip, agent) VALUES
				(z_id, 't', a_ip, a_agent);
			COMMIT;
			w_czy_udany := TRUE;
			w_token_sesji := z_token_sesji;
		END IF;
	EXCEPTION
		WHEN others THEN
			ROLLBACK;
			w_czy_udany := FALSE;
			w_token_sesji := 'Pusty.';
	END log_uzytk;

	FUNCTION uzytk(a_login_email VARCHAR2) RETURN BOOLEAN
	IS
		z_n NUMBER(1);
	BEGIN
		SELECT count(id) INTO z_n FROM uzytkownicy WHERE email = a_login_email;
		IF z_n = 1 THEN
			RETURN TRUE;
		ELSE
			RETURN FALSE;
		END IF;
	END uzytk;

	FUNCTION autent_arkusza(a_id NUMBER, a_haslo VARCHAR2) RETURN BOOLEAN
	IS
		z_haslo ewidencja_arkuszy.haslo%TYPE;
		z_n NUMBER(1);

	BEGIN
		SELECT count(id) INTO z_n FROM ewidencja_arkuszy WHERE id = a_id;
		IF z_n = 1 THEN 
			SELECT haslo INTO z_haslo FROM ewidencja_arkuszy WHERE id = a_id;
			IF a_haslo = z_haslo THEN
				RETURN TRUE;
			ELSE
				RETURN FALSE;
			END IF;
		ELSE
			RETURN FALSE;
		END IF;
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