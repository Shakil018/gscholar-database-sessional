-- add eemail, type of person

ALTER TABLE PERSON
ADD (
	email        VARCHAR2(500) UNIQUE,
	is_reseacher NUMBER DEFAULT 0 NOT NULL CHECK (is_reseacher BETWEEN 0 and 1),
	is_user      NUMBER DEFAULT 1 NOT NULL CHECK (is_user BETWEEN 0 and 1)
);

-- is_deleted for recovery
ALTER TABLE USER_
ADD (
	is_deleted NUMBER CHECK (is_deleted BETWEEN 0 and 1)
);

-- publication type
ALTER TABLE PUBLICATION
ADD (
	pub_type VARCHAR2(100)
);
-- add post type
ALTER TABLE POSTS
ADD (
	is_discussion NUMBER CHECK (is_discussion BETWEEN 0 and 1)
);


ALTER TABLE DOCUMENT
ADD (
	is_patent NUMBER CHECK (is_patent BETWEEN 0 and 1),	
);


-- 
CREATE TABLE user_setting (
  user_id               INTEGER,
  
  is_any_lang           INTEGER DEFAULT 1 NOT NULL CHECK (is_any_lang BETWEEN 0 and 1),
  use_search_activity   INTEGER DEFAULT 1 NOT NULL CHECK (use_search_activity BETWEEN 0 and 1),
  include_patents       INTEGER DEFAULT 1 NOT NULL CHECK (include_patents BETWEEN 0 and 1), 
  open_in_new_window    INTEGER DEFAULT 1 NOT NULL CHECK (open_in_new_window BETWEEN 0 and 1),  
  show_citation_link    INTEGER DEFAULT 1 NOT NULL CHECK (show_citation_link BETWEEN 0 and 1),
  
  CONSTRAINT account_setting_pk PRIMARY KEY (user_id),
  CONSTRAINT account_setting_fk FOREIGN KEY(user_id) 
    REFERENCES user_(person_id) ON DELETE CASCADE
);


CREATE TABLE researcher_setting (
  researcher_id INTEGER,
  auto_update   INTEGER DEFAULT 1 NOT NULL CHECK (auto_update BETWEEN 0 and 1),
  is_public     INTEGER DEFAULT 1 NOT NULL CHECK (is_public BETWEEN 0 and 1),

  CONSTRAINT researcher_setting_pk PRIMARY KEY (researcher_id),
  CONSTRAINT researcher_setting_fk FOREIGN KEY(researcher_id) 
    REFERENCES researcher(person_id) ON DELETE CASCADE
);


-- langugage is complicated
CREATE TABLE laguages (
	lang_id         INTEGER,
	english_name    VARCHAR2(100) NOT NULL,
	ISO_639_1_Code  VARCHAR2(100),
	CONSTRAINT laguages_pk PRIMARY KEY(lang_id)
);

-- document is_patent
ALTER TABLE DOCUMENT
ADD (
	lang_id NUMBER,
	CONSTRAINT doc_lang FOREIGN KEY(lang_id) 
    REFERENCES laguages(lang_id) ON DELETE CASCADE
);


CREATE TABLE user_language (
	user_id         INTEGER,
	lang_id         INTEGER,
	
	CONSTRAINT user_language_pk PRIMARY KEY (user_id, lang_id),
	CONSTRAINT user_language_fk FOREIGN KEY(user_id) 
    REFERENCES user_(person_id) ON DELETE CASCADE,
	CONSTRAINT user_language_fk2 FOREIGN KEY(lang_id)
    REFERENCES laguages(lang_id) ON DELETE CASCADE
);

-- add results per page
ALTER TABLE user_setting
ADD (
	results_per_page INTEGER DEFAULT 10 NOT NULL
);








