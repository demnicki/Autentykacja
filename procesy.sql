/* Ustalanie adresu URL zwrotnego zapytania, dla portali Facebook i Google. */

SELECT apex_authentication.get_callback_url FROM dual;

/* Link do polityki prywatniœci firmy Oracle.

https://www.oracle.com/legal/privacy/privacy-policy.html
*/

/* Proces autentykacji u¿ytkownika, dla ramki wewnêtrznej. */

/* Kontent dynamiczny wyœwietlenia adresu e-mail u¿ytkownika. */

DECLARE
o_komunikatu CHAR(50 CHAR) := '<p>Twój adres e-mail (login) to: <b>';
z_komunikatu CHAR(10 CHAR) := '</b>.</p>';
BEGIN
htp.p(o_komunikatu||apex_application.g_user||z_komunikatu);
END;

/* Kontent dynamiczny wyœwietlenia adresu IP u¿ytkownika. */
DECLARE
o_komunikatu CHAR(50 CHAR) := '<p>Twój adres IP to: <b>';
z_komunikatu CHAR(10 CHAR) := '</b>.</p>';
BEGIN
htp.p(o_komunikatu||owa_util.get_cgi_env('REMOTE_ADDR')||z_komunikatu);
END;

/* Kontent dynamiczny wyœwietlenia nazwy przegl¹darki internetowej u¿ytkownika. */
DECLARE
o_komunikatu CHAR(50 CHAR) := '<p>Przegl¹darka internetowa u¿ytkownika to: <b>';
z_komunikatu CHAR(10 CHAR) := '</b>.</p>';
BEGIN
htp.p(o_komunikatu||autentykacja.przegl(owa_util.get_cgi_env('HTTP_USER_AGENT'))||z_komunikatu);
END;

/* Kontent dynamiczny wyœwietlenia systemu operacyjnego u¿ytkownika. */
DECLARE
o_komunikatu CHAR(50 CHAR) := '<p>System operacyjny u¿ytkownika to: <b>';
z_komunikatu CHAR(10 CHAR) := '</b>.</p>';
BEGIN
htp.p(o_komunikatu||autentykacja.sys_op(owa_util.get_cgi_env('HTTP_USER_AGENT'))||z_komunikatu);
END;

/* Kontent dynamiczny wyœwietlenia jêzyka systemowego u¿ytkownika. */
DECLARE
o_komunikatu CHAR(50 CHAR) := '<p>Preferowany jêzyk u¿ytkownika to: <b>';
z_komunikatu CHAR(10 CHAR) := '</b>.</p>';
BEGIN
htp.p(o_komunikatu||autentykacja.jezyk(owa_util.get_cgi_env('HTTP_ACCEPT_LANGUAGE'))||z_komunikatu);
END;