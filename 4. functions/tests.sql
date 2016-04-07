
SET serveroutput ON;

--
-- Nombre de parties jouées
--
DECLARE
BEGIN
	dbms_output.put_line('nb_parties_jouees = ' || nb_parties_jouees());
	dbms_output.put_line('nb_reponses = ' || nb_reponses());
	dbms_output.put_line('nb_reponses_correctes = ' || nb_reponses_correctes());
	dbms_output.put_line('nb_reponses_fausses = ' || nb_reponses_fausses());
	dbms_output.put_line('pourcentage_reponses_correctes = ' || pourcentage_reponses_correctes());
	dbms_output.put_line('temps_reponse_moyen = ' || temps_reponse_moyen());
END;