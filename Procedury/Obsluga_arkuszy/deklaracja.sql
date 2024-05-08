CREATE OR REPLACE PACKAGE obsluga_arkuszy
IS
	PROCEDURE utworz_arkusz(
		a_token_sesji   IN uzytkownicy.token_sesji%TYPE,
		a_nazwa_arkusza IN ewidencja_arkuszy.nazwa%TYPE,
		a_haslo         IN ewidencja_arkuszy.haslo%TYPE,
		a_opis_arkusza  IN ewidencja_arkuszy.opis%TYPE,
		w_czy_udany     OUT BOOLEAN
	);

	PROCEDURE usun_arkusz(
		a_token_sesji IN uzytkownicy.token_sesji%TYPE,
		a_id_arkusza  IN ewidencja_arkuszy.id%TYPE,
		w_czy_udany   OUT BOOLEAN
	);

	PROCEDURE dodaj_post;

	PROCEDURE edytuj_post;

	PROCEDURE usun_post;

	PROCEDURE gen_pdf;
END obsluga_arkuszy;