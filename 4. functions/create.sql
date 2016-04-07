
--
-- Global : Nombre de parties jouées
--
CREATE OR REPLACE FUNCTION nb_parties_jouees RETURN INTEGER IS
	nb_parties_jouees INTEGER;
BEGIN
	SELECT COUNT(*) INTO nb_parties_jouees FROM answers_sets;
	RETURN nb_parties_jouees;
END;
/

--
-- Global : Nombre total de réponses
--
CREATE OR REPLACE FUNCTION nb_reponses RETURN INTEGER IS
	nb_reponses INTEGER;
BEGIN
	SELECT COUNT(*) INTO nb_reponses FROM answers;
	RETURN nb_reponses;
END;
/

--
-- Global : Nombre de réponses correctes
--
CREATE OR REPLACE FUNCTION nb_reponses_correctes RETURN INTEGER IS
	nb_reponses_correctes INTEGER;
BEGIN
	SELECT COUNT(a.id) INTO nb_reponses_correctes
	FROM answers a
	JOIN proposals p ON a.proposal_id = p.id
	WHERE p.isCorrect = 1;

	RETURN nb_reponses_correctes;
END;
/

--
-- Global : Nombre de réponses fausses
--
CREATE OR REPLACE FUNCTION nb_reponses_fausses RETURN INTEGER IS
	nb_reponses_fausses INTEGER;
BEGIN
	SELECT COUNT(a.id) INTO nb_reponses_fausses
	FROM answers a
	JOIN proposals p ON a.proposal_id = p.id
	WHERE p.isCorrect = 0;

	RETURN nb_reponses_fausses;
END;
/

--
-- Global : Pourcentage de réponses correctes par rapport au total de réponses
--
CREATE OR REPLACE FUNCTION pourcentage_reponses_correctes RETURN NUMBER IS
	pourcentage_reponses_correctes NUMBER;
	total INTEGER;
BEGIN
	total := nb_reponses();

	IF total > 0 THEN
		pourcentage_reponses_correctes := nb_reponses_correctes() / total;
	ELSE
		pourcentage_reponses_correctes := 0;
	END IF;

	RETURN pourcentage_reponses_correctes;
END;
/

--
-- Global : Temps moyen de réponse à un questionnaire
--
CREATE OR REPLACE FUNCTION temps_reponse_moyen RETURN NUMBER IS
	temps_reponse_moyen NUMBER;
BEGIN
	SELECT AVG((endedAt - startedAt) * 1440) INTO temps_reponse_moyen FROM answers_sets;
	RETURN temps_reponse_moyen;
END;
/




--
-- Spécifique : Nombre total de réponses dans le set
--
CREATE OR REPLACE FUNCTION set_nb_reponses(sid VARCHAR) RETURN NUMBER IS
	set_nb_reponses NUMBER;
BEGIN
	SELECT COUNT(*) INTO set_nb_reponses FROM answers WHERE set_id = sid;
	RETURN set_nb_reponses;
END;
/

--
-- Spécifique : Nombre de réponses correctes dans le set
--
CREATE OR REPLACE FUNCTION set_nb_reponses_correctes(sid VARCHAR) RETURN NUMBER IS
	set_nb_reponses_correctes NUMBER;
BEGIN
	SELECT COUNT(a.id) INTO set_nb_reponses_correctes
	FROM answers a
	JOIN proposals p ON a.proposal_id = p.id
	WHERE a.set_id = sid AND p.isCorrect = 1;

	RETURN set_nb_reponses_correctes;
END;
/

--
-- Spécifique : Nombre de réponses fausses dans le set
--
CREATE OR REPLACE FUNCTION set_nb_reponses_fausses(sid VARCHAR) RETURN NUMBER IS
	set_nb_reponses_fausses NUMBER;
BEGIN
	SELECT COUNT(a.id) INTO set_nb_reponses_fausses
	FROM answers a
	JOIN proposals p ON a.proposal_id = p.id
	WHERE a.set_id = sid AND p.isCorrect = 0;

	RETURN set_nb_reponses_fausses;
END;
/

--
-- Spécifique : Pourcentage de réponses correctes dans le set
--
CREATE OR REPLACE FUNCTION set_pourcentage_correctes(sid VARCHAR) RETURN NUMBER IS
	set_pourcentage_correctes NUMBER;
	total INTEGER;
BEGIN
	total := set_nb_reponses(sid);

	IF total > 0 THEN
		set_pourcentage_correctes := set_nb_reponses_correctes(sid) / total;
	ELSE
		set_pourcentage_correctes := 0;
	END IF;

	RETURN set_pourcentage_correctes;
END;
/

--
-- Spécifique : Temps de réponse du set
--
CREATE OR REPLACE FUNCTION set_temps_reponse(sid VARCHAR) RETURN NUMBER IS
	set_temps_reponse NUMBER;
BEGIN
	SELECT (endedAt - startedAt) * 1440 INTO set_temps_reponse FROM answers_sets WHERE id = sid;
	RETURN set_temps_reponse;
END;