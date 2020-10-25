-- 1
CREATE TABLE person (
  person_id  INTEGER,
  first_name VARCHAR2(50) NOT NULL,
  last_name  VARCHAR2(50) NOT NULL,
  CONSTRAINT person_pk PRIMARY KEY (person_id)
);
-- 2
CREATE TABLE user_ ( 
  person_id INTEGER,
  user_name VARCHAR2(50) NOT NULL UNIQUE,
  pass_hash VARCHAR2(100) NOT NULL,
  creation_time DATE DEFAULT SYSDATE,
  CONSTRAINT person_user_pk PRIMARY KEY (person_id),
  CONSTRAINT person_user_fk FOREIGN KEY(person_id) 
    REFERENCES person(person_id) ON DELETE CASCADE 
); 
-- 3
CREATE TABLE researcher (
  person_id INTEGER,
  -- specialization VARCHAR2(100) NOT NULL,
  url VARCHAR2(100) UNIQUE,
  -- label VARCHAR2(100),
  CONSTRAINT person_researcher_pk PRIMARY KEY (person_id),
  CONSTRAINT person_researcher_fk FOREIGN KEY (person_id)
    REFERENCES person(person_id) ON DELETE CASCADE
); 
-- 7
CREATE TABLE affiliation (
  affiliation_id INTEGER,
  name           VARCHAR2(100) NOT NULL,
  address        VARCHAR2(100),
  url            VARCHAR2(100) UNIQUE,
  type           VARCHAR2(100),
  CONSTRAINT affiliation_pk PRIMARY KEY(affiliation_id)
);
-- 9
CREATE TABLE document (
  doc_id       INTEGER,
  title        VARCHAR2(100) NOT NULL,
  descriptions CLOB,
  url          VARCHAR2(100),
  eprint       VARCHAR2(100),
  doi          VARCHAR2(100),
  upload_time  DATE DEFAULT SYSDATE,
  first_page   VARCHAR2(100),
  last_page    VARCHAR2(100),
  -- category    VARCHAR2(100),
  CONSTRAINT document_pk PRIMARY KEY(doc_id)
);
-- 10
CREATE TABLE publication (
  pub_id INTEGER,
  name   VARCHAR2(100) NOT NULL,
  url    VARCHAR2(100) UNIQUE,
  CONSTRAINT publication_pk PRIMARY KEY(pub_id)
);
-- 11
CREATE TABLE journal (
  pub_id INTEGER,
  volume VARCHAR2(100),
  issue  VARCHAR2(100),
  CONSTRAINT journal_pk PRIMARY KEY(pub_id),
  CONSTRAINT journal_fk FOREIGN KEY(pub_id)
    REFERENCES publication(pub_id) ON DELETE CASCADE
);
-- 12
CREATE TABLE conference_proceedings (
  pub_id           INTEGER,
  conference_topic VARCHAR2(100),
  guests           VARCHAR2(100),
  CONSTRAINT conference_proceedings_pk PRIMARY KEY(pub_id),
  CONSTRAINT conference_proceedings_fk FOREIGN KEY(pub_id)
    REFERENCES publication(pub_id) ON DELETE CASCADE
);
-- 13
CREATE TABLE book (
  pub_id         INTEGER,
  publisher_name VARCHAR2(100),
  edition_       VARCHAR2(100) UNIQUE,
  CONSTRAINT book_pk PRIMARY KEY(pub_id),
  CONSTRAINT book_fk FOREIGN KEY(pub_id)
    REFERENCES publication(pub_id) ON DELETE CASCADE
); 
-- 14
CREATE TABLE patent_office (
  pub_id      INTEGER,
  office_name VARCHAR2(100),
  location    VARCHAR2(100),
  email       VARCHAR2(100),
  phone       VARCHAR2(100),
  CONSTRAINT patent_pk PRIMARY KEY(pub_id),
  CONSTRAINT patent_fk FOREIGN KEY(pub_id)
    REFERENCES publication(pub_id) ON DELETE CASCADE
);
-- 15
CREATE TABLE miscellaneous (
  pub_id       INTEGER,
  description_ VARCHAR2(100),
  CONSTRAINT misc_pk PRIMARY KEY(pub_id),
  CONSTRAINT misc_fk FOREIGN KEY(pub_id)
  REFERENCES publication(pub_id) ON DELETE CASCADE
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
-- 22
CREATE TABLE posts (
  post_id    INTEGER,
  person_id  INTEGER,
  string     CLOB,
  timestamp_ TIMESTAMP,
  CONSTRAINT posts_pk PRIMARY KEY(post_id),
  CONSTRAINT posts_fk FOREIGN KEY(person_id)
    REFERENCES person(person_id) ON DELETE CASCADE
);
-- 23
CREATE TABLE discussion (
  post_id INTEGER,
  -- category VARCHAR2(100) NOT NULL,
  CONSTRAINT discussion_pk PRIMARY KEY(post_id),
  CONSTRAINT discussion_fk FOREIGN KEY(post_id)
    REFERENCES posts(post_id) ON DELETE CASCADE
);
-- 24
CREATE TABLE reply (
  post_id       INTEGER,
  discussion_id INTEGER,
  CONSTRAINT reply_pk PRIMARY KEY(post_id, discussion_id),
  CONSTRAINT reply_fk FOREIGN KEY(post_id)
    REFERENCES posts(post_id) ON DELETE CASCADE,
  CONSTRAINT reply_fk2 FOREIGN KEY(discussion_id)
    REFERENCES discussion(post_id) ON DELETE CASCADE
);
-- 25
CREATE TABLE specialization (
  researcher_id INTEGER,
  topic         VARCHAR2(100),
  CONSTRAINT specialization_pk PRIMARY KEY(researcher_id, topic),
  CONSTRAINT specialization_fk FOREIGN KEY(researcher_id)
    REFERENCES researcher(person_id) ON DELETE CASCADE
);
-- 26.0
CREATE TABLE labels_unique (
  label_id INTEGER,
  label_name  VARCHAR2(100),
  CONSTRAINT labels_unique_pk PRIMARY KEY(label_id)
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
-- end
COMMIT;
EXIT;