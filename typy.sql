/* Typy danych do pakietu "Kurs walut". */

CREATE OR REPLACE TYPE t_o_kurs_walut AS OBJECT
(
   k_data_zmiany DATE,
   k_kurs_zmianu NUMBER(3, 4)
);

CREATE OR REPLACE TYPE t_t_kurs_walut AS TABLE OF t_o_kurs_walut;