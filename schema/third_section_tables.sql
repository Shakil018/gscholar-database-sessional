-- 10
CREATE TABLE publication (
  pub_id INTEGER,
  name   VARCHAR2(100) NOT NULL,
  url    VARCHAR2(100) NOT NULL UNIQUE,
  CONSTRAINT publication_pk PRIMARY KEY(pub_id)
);
-- 11
CREATE TABLE journal (
  pub_id INTEGER,
  volume INTEGER,
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
  publisher_name VARCHAR2(100) NOT NULL,
  edition_        INTEGER NOT NULL UNIQUE,
  CONSTRAINT book_pk PRIMARY KEY(pub_id),
  CONSTRAINT book_fk FOREIGN KEY(pub_id)
    REFERENCES publication(pub_id) ON DELETE CASCADE
); 
-- 14
CREATE TABLE patent (
  pub_id         INTEGER,
  patent_office  VARCHAR2(100) NOT NULL,
  CONSTRAINT patent_pk PRIMARY KEY(pub_id),
  CONSTRAINT patent_fk FOREIGN KEY(pub_id)
    REFERENCES publication(pub_id) ON DELETE CASCADE
); 
-- 15
CREATE TABLE miscellaneous (
  pub_id        INTEGER,
  description_  VARCHAR2(100) NOT NULL,
  CONSTRAINT misc_pk PRIMARY KEY(pub_id),
  CONSTRAINT misc_fk FOREIGN KEY(pub_id)
  REFERENCES publication(pub_id) ON DELETE CASCADE
); 
-- 16
CREATE TABLE patented_by (
  doc_id         INTEGER,
  pub_id         INTEGER,
  patent_no      VARCHAR2(100),
  application_no VARCHAR2(100),
  CONSTRAINT patented_by_pk PRIMARY KEY(doc_id, pub_id),
  CONSTRAINT patented_by_fk FOREIGN KEY(doc_id) 
    REFERENCES document(doc_id),
  CONSTRAINT patented_by_fk2 FOREIGN KEY(pub_id)
    REFERENCES patent(pub_id)
);
-- second_section_tables