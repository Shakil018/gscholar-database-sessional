-- 25
CREATE TABLE specialization(
  person_id INTEGER,
  topic     VARCHAR2(100),
  CONSTRAINT specialization_pk PRIMARY KEY(person_id, topic),
  CONSTRAINT specialization_fk FOREIGN KEY(person_id)
    REFERENCES researcher(person_id)
);
-- 26
CREATE TABLE labels(
  person_id INTEGER,
  label     VARCHAR2(100),
  CONSTRAINT labels_pk PRIMARY KEY(person_id, label),
  CONSTRAINT labels_fk FOREIGN KEY(person_id)
    REFERENCES researcher(person_id)
);
-- 27
CREATE TABLE categories(
  doc_id   INTEGER,
  category VARCHAR2(100),
  CONSTRAINT categories_pk PRIMARY KEY(doc_id, category),
  CONSTRAINT categories_fk FOREIGN KEY(doc_id)
    REFERENCES document(doc_id)
);

COMMIT;
-- end