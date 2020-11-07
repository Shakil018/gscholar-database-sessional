-- entities
-- ---------------------------------------------------------
DROP TABLE person  CASCADE CONSTRAINTS;
DROP TABLE user_  CASCADE CONSTRAINTS;
DROP TABLE researcher  CASCADE CONSTRAINTS;
DROP TABLE affiliation  CASCADE CONSTRAINTS;
DROP TABLE document  CASCADE CONSTRAINTS;
DROP TABLE publication  CASCADE CONSTRAINTS;
DROP TABLE journal  CASCADE CONSTRAINTS;
DROP TABLE conference_proceedings  CASCADE CONSTRAINTS;
DROP TABLE book  CASCADE CONSTRAINTS;
DROP TABLE patent_office  CASCADE CONSTRAINTS;
DROP TABLE miscellaneous  CASCADE CONSTRAINTS;
DROP TABLE library  CASCADE CONSTRAINTS;
DROP TABLE posts  CASCADE CONSTRAINTS;
DROP TABLE discussion  CASCADE CONSTRAINTS;
DROP TABLE reply  CASCADE CONSTRAINTS;
DROP TABLE specialization  CASCADE CONSTRAINTS;
DROP TABLE labels  CASCADE CONSTRAINTS;
DROP TABLE document_categories  CASCADE CONSTRAINTS;
DROP TABLE discussion_keywords  CASCADE CONSTRAINTS;

-- relations
-- ---------------------------------------------------------
DROP TABLE selected_co_authors  CASCADE CONSTRAINTS;
DROP TABLE friend_of  CASCADE CONSTRAINTS;
DROP TABLE follows  CASCADE CONSTRAINTS;
DROP TABLE aff_with  CASCADE CONSTRAINTS;
DROP TABLE patented_by  CASCADE CONSTRAINTS;
DROP TABLE published_by  CASCADE CONSTRAINTS;
DROP TABLE cites  CASCADE CONSTRAINTS;
DROP TABLE written_by  CASCADE CONSTRAINTS;
DROP TABLE contains  CASCADE CONSTRAINTS;

-- patch_1
-- ---------------------------------------------------------
-- ALTER TABLE DOCUMENT DROP COLUMN lang_id;

DECLARE
	type namesarray IS VARRAY(4) OF VARCHAR2(20); 
	table_name namesarray;
BEGIN
	table_name := namesarray(
		'laguages', 'user_setting', 'user_language', 'researcher_setting'
	);
	for i in 1..table_name.count LOOP
		DBMS_OUTPUT.PUT_LINE('Dropping table - ' || table_name(i));
		EXECUTE IMMEDIATE 'DROP TABLE ' || table_name(i) || ' CASCADE CONSTRAINTS';
	END LOOP; 

END;
/


-- ---------------------------------------------------------
EXIT;