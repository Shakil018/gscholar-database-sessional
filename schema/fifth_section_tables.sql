-- 25
CREATE TABLE specialization (
  researcher_id INTEGER,
  topic         VARCHAR2(100),
  CONSTRAINT specialization_pk PRIMARY KEY(researcher_id, topic),
  CONSTRAINT specialization_fk FOREIGN KEY(researcher_id)
    REFERENCES researcher(person_id) ON DELETE CASCADE
);
-- 26
CREATE TABLE labels (
  researcher_id INTEGER,
  label         VARCHAR2(100),
  CONSTRAINT labels_pk PRIMARY KEY(researcher_id, label),
  CONSTRAINT labels_fk FOREIGN KEY(researcher_id)
    REFERENCES researcher(person_id) ON DELETE CASCADE
);
-- 27
CREATE TABLE document_categories (
  doc_id   INTEGER,
  category VARCHAR2(100),
  CONSTRAINT document_categories_pk PRIMARY KEY(doc_id, category),
  CONSTRAINT document_categories_fk FOREIGN KEY(doc_id)
    REFERENCES document(doc_id) ON DELETE CASCADE
);
-- 28
CREATE TABLE discussion_keywords(
  discussion_id  INTEGER,
  keyword        VARCHAR2(100),
  CONSTRAINT discussion_keywords_pk PRIMARY KEY(discussion_id, keyword),
  CONSTRAINT discussion_keywords_fk FOREIGN KEY(discussion_id)
    REFERENCES discussion(post_id) ON DELETE CASCADE
);

COMMIT;
-- end