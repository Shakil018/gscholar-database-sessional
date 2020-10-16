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
-- fifth_section_tables