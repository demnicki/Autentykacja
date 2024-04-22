CREATE OR REPLACE PACKAGE BODY autentykacja
IS
	FUNCTION sys_op(wartosc VARCHAR2) RETURN VARCHAR2
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
			IF regexp_count(lower(wartosc), lower(indeks)) > 0 THEN
				 wynik := tablica(indeks);
			END IF;
			indeks := tablica.NEXT(indeks);
		END LOOP;
		RETURN wynik;
	END sys_op;

	FUNCTION przegl(wartosc VARCHAR2) RETURN VARCHAR2
	IS
		tablica autentykacja.tablica_agenta;
		indeks  VARCHAR2(100 CHAR);
		wynik   VARCHAR2(200 CHAR);
	BEGIN
		wynik := wartosc;
	    tablica('safari')         := 'Safari';
	    tablica('postmanruntime') := 'PostMan';
		tablica('msie')           := 'Internet Explorer';
		tablica('firefox')        := 'Firefox';
	    tablica('chrome')         := 'Chrome';
	    tablica('edge')           := 'Edge';
	    tablica('opera')          := 'Opera';
		IF regexp_count(lower(wartosc), 'safari') > 0 THEN
			wynik := 'Safari';
	        tablica.DELETE('safari');
	        indeks := tablica.FIRST;
			WHILE (indeks IS NOT NULL) LOOP
				IF regexp_count(lower(wartosc), lower(indeks)) > 0 THEN
					wynik := tablica(indeks);
				END IF;
				indeks := tablica.NEXT(indeks);
			END LOOP;
		ELSIF regexp_count(lower(wartosc), 'postmanruntime') > 0 THEN
			wynik := 'PostMan';
		END IF; 
	    RETURN wynik;
	END przegl;

	FUNCTION jezyk(wartosc VARCHAR2) RETURN VARCHAR2
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
			IF regexp_count(lower(wartosc), lower(indeks)) > 0 THEN
				 wynik := tablica(indeks);
			END IF;
			indeks := tablica.NEXT(indeks);
		END LOOP;
		RETURN wynik;
	END jezyk;
END autentykacja;