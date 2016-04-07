
--
-- Statistiques globales pour l'administrateur
-- Mise à jour à la fin de chaque questionnaire (on recalcule les statistiques seulement
-- si endedAt a changé, car cela signifie que l'on a terminé un questionnaire)
--
CREATE OR REPLACE TRIGGER global_stats_trigger AFTER UPDATE ON answers_sets
BEGIN
	UPDATE statistics
	SET value = nb_parties_jouees(), updatedAt = SYSDATE
	WHERE type = 'admin' AND label = 'nb_parties_jouees';

	UPDATE statistics
	SET value = nb_reponses(), updatedAt = SYSDATE
	WHERE type = 'admin' AND label = 'nb_reponses';
	
	UPDATE statistics
	SET value = nb_reponses_correctes(), updatedAt = SYSDATE
	WHERE type = 'admin' AND label = 'nb_reponses_correctes';

	UPDATE statistics
	SET value = nb_reponses_fausses(), updatedAt = SYSDATE
	WHERE type = 'admin' AND label = 'nb_reponses_fausses';

	UPDATE statistics
	SET value = pourcentage_reponses_correctes(), updatedAt = SYSDATE
	WHERE type = 'admin' AND label = 'pourcentage_reponses_correctes';

	UPDATE statistics
	SET value = temps_reponse_moyen(), updatedAt = SYSDATE
	WHERE type = 'admin' AND label = 'temps_reponse_moyen';
END;
/

--
-- Statistiques spécifiques à un utilisateur
-- Fonctionne de la même manière que les statistiques administrateur mais pour
-- un seul set donné.
--
CREATE OR REPLACE TRIGGER specific_stats_trigger AFTER UPDATE ON answers_sets
DECLARE
	set_id VARCHAR2(100);
BEGIN
	SELECT id INTO set_id FROM answers_sets WHERE rowid = (SELECT MAX(rowid) from answers_sets);
	
	INSERT INTO statistics VALUES (statistics_sequence.NextVal, set_id, 'user', 'nb_reponses', set_nb_reponses(set_id), SYSDATE, null);
	INSERT INTO statistics VALUES (statistics_sequence.NextVal, set_id, 'user', 'nb_reponses_correctes', set_nb_reponses_correctes(set_id), SYSDATE, null);
	INSERT INTO statistics VALUES (statistics_sequence.NextVal, set_id, 'user', 'nb_reponses_fausses', set_nb_reponses_fausses(set_id), SYSDATE, null);
	INSERT INTO statistics VALUES (statistics_sequence.NextVal, set_id, 'user', 'pourcentage_correctes', set_pourcentage_correctes(set_id), SYSDATE, null);
	INSERT INTO statistics VALUES (statistics_sequence.NextVal, set_id, 'user', 'temps_reponse', set_temps_reponse(set_id), SYSDATE, null);
END;