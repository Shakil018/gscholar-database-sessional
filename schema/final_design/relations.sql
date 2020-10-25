-- 4
CREATE TABLE selected_co_authors ( 
  researcher1_id INTEGER,
  researcher2_id INTEGER,
  CONSTRAINT selected_co_authors_pk PRIMARY KEY(researcher1_id, researcher2_id), 
  CONSTRAINT selected_co_authors_fk FOREIGN KEY(researcher1_id)
    REFERENCES researcher(person_id) ON DELETE CASCADE,
  CONSTRAINT selected_co_authors_fk2 FOREIGN KEY(researcher2_id)
    REFERENCES researcher(person_id) ON DELETE CASCADE
);
-- 5
CREATE TABLE friend_of (
  person1_id INTEGER,
  person2_id INTEGER,
  CONSTRAINT friend_of_pk PRIMARY KEY(person1_id, person2_id),
  CONSTRAINT friend_of_fk FOREIGN KEY(person1_id)
    REFERENCES person(person_id) ON DELETE CASCADE,
  CONSTRAINT friend_of_fk2 FOREIGN KEY(person2_id)
    REFERENCES person(person_id) ON DELETE CASCADE
);
-- 6
CREATE TABLE follows (
  researcher_id INTEGER,
  user_id      INTEGER,
  CONSTRAINT follows_pk PRIMARY KEY(researcher_id, user_id),
  CONSTRAINT follows_fk FOREIGN KEY(researcher_id) 
    REFERENCES person(person_id) ON DELETE CASCADE,
  CONSTRAINT follows_fk2 FOREIGN KEY(user_id)
    REFERENCES person(person_id) ON DELETE CASCADE
);
-- 8
CREATE TABLE aff_with (
  person_id      INTEGER,
  affiliation_id INTEGER,
  designation    VARCHAR2(100),
  CONSTRAINT aff_with_pk PRIMARY KEY(person_id, affiliation_id),
  CONSTRAINT aff_with_fk FOREIGN KEY(person_id)
    REFERENCES researcher(person_id) ON DELETE CASCADE,
  CONSTRAINT aff_with_fk2 FOREIGN KEY(affiliation_id)
    REFERENCES affiliation(affiliation_id) ON DELETE CASCADE
);
-- 16
CREATE TABLE patented_by (
  doc_id         INTEGER,
  pub_id         INTEGER,
  patent_no      VARCHAR2(100),
  application_no VARCHAR2(100),
  CONSTRAINT patented_by_pk PRIMARY KEY(doc_id, pub_id),
  CONSTRAINT patented_by_fk FOREIGN KEY(doc_id) 
    REFERENCES document(doc_id) ON DELETE CASCADE,
  CONSTRAINT patented_by_fk2 FOREIGN KEY(pub_id)
    REFERENCES patent_office(pub_id)
);
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
-- 26
CREATE TABLE labels (
  researcher_id INTEGER,
  label_id      INTEGER,
  CONSTRAINT labels_pk PRIMARY KEY(researcher_id, label_id),
  CONSTRAINT labels_fk FOREIGN KEY(researcher_id)
    REFERENCES researcher(person_id) ON DELETE CASCADE,
  CONSTRAINT labels_fk2 FOREIGN KEY(label_id)
    REFERENCES labels_unique(label_id) ON DELETE CASCADE
);
-- end
COMMIT;
EXIT;