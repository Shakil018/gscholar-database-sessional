/* ref: https://www.techonthenet.com/oracle/primary_keys.php */

-- CREATE TABLE Student_3
-- (
-- ID INTEGER,
-- NAME VARCHAR2(256) NOT NULL,
-- MARKS INTEGER,
-- GENDER CHAR(10),
-- CONSTRAINT student_3_pk PRIMARY KEY (ID)
-- );

-- student with section
CREATE TABLE Student_4 (
	ID INTEGER,
	NAME VARCHAR2(256) NOT NULL,
	MARKS INTEGER,
	GENDER CHAR(10),
	SECTION_ID VARCHAR2(256),
	CONSTRAINT student_4_pk PRIMARY KEY (ID),
	CONSTRAINT section_fk FOREIGN KEY (SECTION_ID) REFERENCES section(SECTION_ID)
);

-- make the section first
-- CREATE TABLE section (
-- 	SECTION_ID VARCHAR2(256),
-- 	NAME VARCHAR2(256) NOT NULL,
-- 	CONSTRAINT section_pk PRIMARY KEY (SECTION_ID)
-- );