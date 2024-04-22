/* Ustalanie adresu URL zwrotnego zapytania, dla portali Facebook i Google. */

SELECT apex_authentication.get_callback_url FROM dual;

/* Link do polityki prywatni�ci firmy Oracle.

https://www.oracle.com/legal/privacy/privacy-policy.html
*/

/* Proces autentykacji u�ytkownika, dla ramki wewn�trznej. */

/* Kontent dynamiczny wy�wietlenia adresu e-mail u�ytkownika. */

DECLARE
o_komunikatu CHAR(50 CHAR) := '<p>Tw�j adres e-mail (login) to: <b>';
z_komunikatu CHAR(10 CHAR) := '</b>.</p>';
BEGIN
htp.p(o_komunikatu||apex_application.g_user||z_komunikatu);
END;

/* Kontent dynamiczny wy�wietlenia adresu IP u�ytkownika. */
DECLARE
o_komunikatu CHAR(50 CHAR) := '<p>Tw�j adres IP to: <b>';
z_komunikatu CHAR(10 CHAR) := '</b>.</p>';
BEGIN
htp.p(o_komunikatu||owa_util.get_cgi_env('REMOTE_ADDR')||z_komunikatu);
END;

/* Kontent dynamiczny wy�wietlenia nazwy przegl�darki internetowej u�ytkownika. */
DECLARE
o_komunikatu CHAR(50 CHAR) := '<p>Przegl�darka internetowa u�ytkownika to: <b>';
z_komunikatu CHAR(10 CHAR) := '</b>.</p>';
BEGIN
htp.p(o_komunikatu||autentykacja.przegl(owa_util.get_cgi_env('HTTP_USER_AGENT'))||z_komunikatu);
END;

/* Kontent dynamiczny wy�wietlenia systemu operacyjnego u�ytkownika. */
DECLARE
o_komunikatu CHAR(50 CHAR) := '<p>System operacyjny u�ytkownika to: <b>';
z_komunikatu CHAR(10 CHAR) := '</b>.</p>';
BEGIN
htp.p(o_komunikatu||autentykacja.sys_op(owa_util.get_cgi_env('HTTP_USER_AGENT'))||z_komunikatu);
END;

/* Kontent dynamiczny wy�wietlenia j�zyka systemowego u�ytkownika. */
DECLARE
o_komunikatu CHAR(50 CHAR) := '<p>Preferowany j�zyk u�ytkownika to: <b>';
z_komunikatu CHAR(10 CHAR) := '</b>.</p>';
BEGIN
htp.p(o_komunikatu||autentykacja.jezyk(owa_util.get_cgi_env('HTTP_ACCEPT_LANGUAGE'))||z_komunikatu);
END;