/* Ustalanie adresu URL zwrotnego zapytania, dla portali Facebook i Google. */

SELECT apex_authentication.get_callback_url FROM dual;

/* Link do polityki prywatniści firmy Oracle.

https://www.oracle.com/legal/privacy/privacy-policy.html
*/

/* Proces autentykacji użytkownika, dla ramki wewnętrznej. */

/* Kontent dynamiczny wyświetlenia adresu e-mail użytkownika. */

DECLARE
o_komunikatu CHAR(50 CHAR) := '<p>Twój adres e-mail (login) to: <b>';
z_komunikatu CHAR(10 CHAR) := '</b>.</p>';
BEGIN
htp.p(o_komunikatu||apex_application.g_user||z_komunikatu);
END;

/* Kontent dynamiczny wyświetlenia adresu IP użytkownika. */
DECLARE
o_komunikatu CHAR(50 CHAR) := '<p>Twój adres IP to: <b>';
z_komunikatu CHAR(10 CHAR) := '</b>.</p>';
BEGIN
htp.p(o_komunikatu||owa_util.get_cgi_env('REMOTE_ADDR')||z_komunikatu);
END;

/* Kontent dynamiczny wyświetlenia nazwy przeglądarki internetowej użytkownika. */
DECLARE
o_komunikatu CHAR(50 CHAR) := '<p>Przeglądarka internetowa użytkownika to: <b>';
z_komunikatu CHAR(10 CHAR) := '</b>.</p>';
BEGIN
htp.p(o_komunikatu||autentykacja.przegl(owa_util.get_cgi_env('HTTP_USER_AGENT'))||z_komunikatu);
END;

/* Kontent dynamiczny wyświetlenia systemu operacyjnego użytkownika. */
DECLARE
o_komunikatu CHAR(50 CHAR) := '<p>System operacyjny użytkownika to: <b>';
z_komunikatu CHAR(10 CHAR) := '</b>.</p>';
BEGIN
htp.p(o_komunikatu||autentykacja.sys_op(owa_util.get_cgi_env('HTTP_USER_AGENT'))||z_komunikatu);
END;

/* Kontent dynamiczny wyświetlenia języka systemowego użytkownika. */
DECLARE
o_komunikatu CHAR(50 CHAR) := '<p>Preferowany język użytkownika to: <b>';
z_komunikatu CHAR(10 CHAR) := '</b>.</p>';
BEGIN
htp.p(o_komunikatu||autentykacja.jezyk(owa_util.get_cgi_env('HTTP_ACCEPT_LANGUAGE'))||z_komunikatu);
END;