/* Typy danych do pakietu "Kurs walut". */

CREATE OR REPLACE TYPE t_o_kurs_walut AS OBJECT
(
   k_data_zmiany DATE,
   k_kurs_zmiany NUMBER(6, 4)
);

CREATE OR REPLACE TYPE t_t_kurs_walut AS TABLE OF t_o_kurs_walut;

CREATE OR REPLACE TYPE t_o_gen_wykres AS OBJECT
(
   k_imie   VARCHAR2(250 CHAR),
   k_liczba NUMBER(6, 2)
);

CREATE OR REPLACE TYPE t_t_gen_wykres AS TABLE OF t_o_gen_wykres;