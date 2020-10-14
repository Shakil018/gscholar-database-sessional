-- beginning
-- 1
CREATE TABLE person (
  person_id  INTEGER,
  first_name VARCHAR2(50) NOT NULL,
  last_name  VARCHAR2(50) NOT NULL,
  CONSTRAINT person_pk PRIMARY KEY (person_id)
);
-- 2
CREATE TABLE user_ ( 
  person_id INTEGER CONSTRAINT person_user_pk PRIMARY KEY,
  user_name VARCHAR2(50) NOT NULL UNIQUE,
  pass_hash VARCHAR2(100) NOT NULL,
  creation_time DATE DEFAULT SYSDATE,
  CONSTRAINT person_user_fk FOREIGN KEY(person_id) 
    REFERENCES person(person_id) ON DELETE CASCADE 
); 
-- 3
CREATE TABLE researcher ( 
  person_id INTEGER CONSTRAINT person_researcher_pk PRIMARY KEY,
  specialization VARCHAR2(100) NOT NULL,
  url VARCHAR2(100) NOT NULL UNIQUE,
  label VARCHAR2(100),  -- may be NULL, duplicate
  CONSTRAINT person_researcher_fk FOREIGN KEY (person_id)
    REFERENCES person(person_id) ON DELETE CASCADE
); 
-- 4
CREATE TABLE selected_co_authors ( 
  researcher1_id INTEGER,
  researcher2_id INTEGER,
  CONSTRAINT selected_co_authors_pk PRIMARY KEY(researcher1_id, researcher2_id), 
  CONSTRAINT selected_co_authors_fk FOREIGN KEY(researcher1_id) 
    REFERENCES researcher(person_id),
  CONSTRAINT selected_co_authors_fk2 FOREIGN KEY(researcher2_id)
    REFERENCES researcher(person_id)
);
-- 5
CREATE TABLE friend_of (
  person1_id INTEGER,
  person2_id INTEGER,
  CONSTRAINT friend_of_pk PRIMARY KEY(person1_id, person2_id),
  CONSTRAINT friend_of_fk FOREIGN KEY(person1_id)
    REFERENCES person(person_id),
  CONSTRAINT friend_of_fk2 FOREIGN KEY(person2_id)
    REFERENCES person(person_id)
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
-- 7
CREATE TABLE affiliation (
  affiliation_id INTEGER,
  name           VARCHAR2(100) NOT NULL,
  adress         VARCHAR2(100) NOT NULL,
  url            VARCHAR2(100) UNIQUE,
  TYPE           VARCHAR2(100),
  CONSTRAINT affiliation_pk PRIMARY KEY(affiliation_id)
);
-- 8
CREATE TABLE aff_with (
  person_id      INTEGER,
  affiliation_id INTEGER,
  designation    VARCHAR2(100),
  CONSTRAINT aff_with_pk PRIMARY KEY(person_id, affiliation_id),
  CONSTRAINT aff_with_fk FOREIGN KEY(person_id) 
    REFERENCES person(person_id) ON DELETE CASCADE,
  CONSTRAINT aff_with2 FOREIGN KEY(affiliation_id)
    REFERENCES affiliation(affiliation_id) ON DELETE CASCADE
);
-- second_section_tables
