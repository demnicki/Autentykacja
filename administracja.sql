CREATE CLUSTER obsluga_arkuszy (id NUMBER);

CREATE INDEX i_obsluga_arkuszy ON CLUSTER obsluga_arkuszy;

GRANT EXECUTE ON sys.dbms_crypto TO WKSP_KURS;