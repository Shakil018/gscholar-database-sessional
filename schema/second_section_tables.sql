-- 9
CREATE TABLE document (
  doc_id       INTEGER,
  title        VARCHAR2(500) NOT NULL,
  descriptions CLOB,
  url          VARCHAR2(500),
  eprint       VARCHAR2(500),
  doi          VARCHAR2(500),
  upload_time  DATE DEFAULT SYSDATE,
  first_page   VARCHAR2(100),
  last_page    VARCHAR2(100),
  -- category    VARCHAR2(100),
  CONSTRAINT document_pk PRIMARY KEY(doc_id)
);
-- third_section_tables for publiction
-- 17
CREATE TABLE published_by (
  doc_id           INTEGER,
  pub_id           INTEGER,
  publication_date DATE DEFAULT SYSDATE,
  -- more attribute
  CONSTRAINT published_by_pk PRIMARY KEY(doc_id, pub_id),
  CONSTRAINT published_by_fk FOREIGN KEY(doc_id)
    REFERENCES document(doc_id),
  CONSTRAINT published_by_fk2 FOREIGN KEY(pub_id)
    REFERENCES publication(pub_id)
);
-- 18
CREATE TABLE cites (
  citer_id INTEGER,
  citee_id INTEGER,
  CONSTRAINT cites_pk PRIMARY KEY(citer_id, citee_id),
  CONSTRAINT cites_fk FOREIGN KEY(citer_id)
    REFERENCES document(doc_id) ON DELETE CASCADE,
  CONSTRAINT cites_fk2 FOREIGN KEY(citee_id)
    REFERENCES document(doc_id) ON DELETE CASCADE
);
-- 19
CREATE TABLE written_by (
  researcher_id INTEGER,
  doc_id        INTEGER,
  CONSTRAINT written_by_pk PRIMARY KEY(researcher_id, doc_id),
  CONSTRAINT written_by_fk FOREIGN KEY(doc_id)
    REFERENCES document(doc_id) ON DELETE CASCADE,
  CONSTRAINT written_by_fk2 FOREIGN KEY(researcher_id)
    REFERENCES researcher(person_id)
);
-- 20
CREATE TABLE library (
  library_id  INTEGER,
  user_id     INTEGER,
  update_time DATE DEFAULT SYSDATE,
  CONSTRAINT library_pk PRIMARY KEY(library_id),
  CONSTRAINT library_fk FOREIGN KEY(user_id)
    REFERENCES user_(person_id) ON DELETE CASCADE
);

-- 21
CREATE TABLE contains (
  document_id INTEGER,
  library_id  INTEGER,
  CONSTRAINT contains_pk PRIMARY KEY(document_id, library_id),
  CONSTRAINT contains_fk FOREIGN KEY(document_id)
    REFERENCES document(doc_id) ON DELETE CASCADE,
  CONSTRAINT contains_fk2 FOREIGN KEY(library_id)
    REFERENCES library(library_id) ON DELETE CASCADE
);
-- fourth_section_table