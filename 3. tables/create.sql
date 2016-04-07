
CREATE TABLE users (
	id INT PRIMARY KEY,
	login VARCHAR2(30) NOT NULL UNIQUE,
	password VARCHAR2(30) NOT NULL,
	firstname VARCHAR2(30) NOT NULL,
	lastname VARCHAR2(30) NOT NULL,
	isAdmin INT,
	createdAt DATE
);

CREATE TABLE questionnaires (
	id INT PRIMARY KEY,
	user_id INT,
	title VARCHAR2(30),

	CONSTRAINT questionnaire_user FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE questions (
	id INT PRIMARY KEY,
	label VARCHAR2(200)
);

CREATE TABLE questionnaires_questions (
	id INT PRIMARY KEY,
	questionnaire_id INT,
	question_id INT,
	weight INT,

	CONSTRAINT qq_questionnaire FOREIGN KEY (questionnaire_id) REFERENCES questionnaires(id),
	CONSTRAINT qq_question FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE proposals (
	id INT PRIMARY KEY,
	question_id INT,
	label VARCHAR2(50),
	weight INT,
	isCorrect INT,

	CONSTRAINT proposition_question FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE answers_sets (
	id VARCHAR2(100) PRIMARY KEY,
	questionnaire_id INT,
	startedAt DATE,
	endedAt DATE,

	CONSTRAINT answer_set_questionnaire FOREIGN KEY (questionnaire_id) REFERENCES questionnaires(id)
);

CREATE TABLE answers (
	id INT PRIMARY KEY,
	set_id VARCHAR2(100),
	question_id INT,
	proposal_id INT,
	answeredAt DATE,

	CONSTRAINT answer_set FOREIGN KEY (set_id) REFERENCES answers_sets(id),
	CONSTRAINT answer_question FOREIGN KEY (question_id) REFERENCES questions(id),
	CONSTRAINT answer_proposal FOREIGN KEY (proposal_id) REFERENCES proposals(id)
);

CREATE TABLE statistics (
	id INT PRIMARY KEY,
	set_id VARCHAR2(100),
	type VARCHAR2(30),			-- "admin" ou "user"
	label VARCHAR2(30),			-- admin : nb_partie_joue, nb_reponse_correcte,
											-- nb_reponse_fausse, ratio_reponse, nb_question_repondu,
											-- temps_reponse_moyen
								-- user  : nb_reponse_correcte, nb_reponse_fausse, ratio_reponse,
											-- temps_reponse_total, temps_reponse_moyen
	value NUMBER(6,2),
	createdAt DATE,
	updatedAt DATE
);

CREATE TABLE phones OF phoneObject (id PRIMARY KEY);