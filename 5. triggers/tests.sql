INSERT INTO answers_sets VALUES(answers_sets_sequence.nextval, 1, SYSDATE, null);
UPDATE answers_sets SET endedAt = SYSDATE;