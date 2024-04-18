CREATE TABLE uzytkownicy(
id                NUMBER DEFAULT ON NULL s_uzytkownicy.NEXTVAL NOT NULL,
email             VARCHAR2(250 CHAR) NOT NULL,
nazwa_uzytkownika VARCHAR2(300 CHAR),
data_utworzenia   DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
typ_uprawnien     CHAR(1 CHAR) DEFAULT 'c' NOT NULL,
token_sesji       CHAR(32 CHAR) NOT NULL,
czas_wyg_sesji    DATE,
CONSTRAINT i_id_uzytk PRIMARY KEY (id),
CONSTRAINT i_email_uzytk UNIQUE (email),
CONSTRAINT o_typ_uprawnien CHECK (typ_uprawnien in ('c','p', 'k')),
CONSTRAINT i_token_uzytk UNIQUE (token_sesji)
)CLUSTER obsluga_arkuszy(id);

CREATE TABLE logi(
czas_logu DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
id_uzytk  NUMBER NOT NULL,
czy_udany CHAR(1 CHAR) DEFAULT 'n' NOT NULL,
ip        CHAR (16 CHAR),
agent     VARCHAR2 (100 CHAR),
CONSTRAINT r_logi FOREIGN KEY (id_uzytk) REFERENCES uzytkownicy(id),
CONSTRAINT o_czy_udany CHECK (czy_udany in ('t','n'))
);

CREATE TABLE ewidencja_arkuszy(
id    NUMBER DEFAULT ON NULL s_ewidencja_arkuszy.NEXTVAL NOT NULL,
nazwa VARCHAR2 (1000 CHAR),
haslo VARCHAR2 (2000 CHAR),
opis  CLOB,
CONSTRAINT i_ewid_arkuszy PRIMARY KEY (id)
);

CREATE TABLE tresc_arkuszy(
id         NUMBER DEFAULT ON NULL s_tresc_arkuszy.NEXTVAL NOT NULL,
id_arkusza NUMBER NOT NULL,
id_uzytk   NUMBER NOT NULL,
tresc      CLOB,
CONSTRAINT i_tresc_arkuszy PRIMARY KEY (id),
CONSTRAINT r_tresc_arkuszy_id_arkusza FOREIGN KEY (id_arkusza) REFERENCES ewidencja_arkuszy(id),
CONSTRAINT r_tresc_arkuszy_id_uzytk FOREIGN KEY (id_uzytk) REFERENCES uzytkownicy(id)
);

CREATE TABLE slownik(
id        NUMBER NOT NULL,
komunikat VARCHAR2 (2000 CHAR),
CONSTRAINT i_slownik PRIMARY KEY (id)
)CLUSTER obsluga_arkuszy(id);

CREATE TABLE dziennik_arkuszy(
id             NUMBER DEFAULT ON NULL s_dziennik_arkuszy.NEXTVAL NOT NULL,
id_arkusza     NUMBER NOT NULL,
id_uzytk       NUMBER NOT NULL,
id_slownika    NUMBER NOT NULL,
data_zdarzenia DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
CONSTRAINT i_dziennik_arkuszy PRIMARY KEY (id),
CONSTRAINT r_dziennik_arkuszy_id_arkusza FOREIGN KEY (id_arkusza) REFERENCES ewidencja_arkuszy(id),
CONSTRAINT r_dziennik_arkuszy_id_uzytk FOREIGN KEY (id_uzytk) REFERENCES uzytkownicy(id),
CONSTRAINT r_dziennik_arkuszy_id_slownika FOREIGN KEY (id_slownika) REFERENCES slownik(id)
)CLUSTER obsluga_arkuszy(id);