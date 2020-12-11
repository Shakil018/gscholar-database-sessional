-- maintenance.add_documents

DECLARE
  TEMP_DOC_ID NUMBER;
    TEMP_IS_PATENT NUMBER;
    TEMP_FIRST_PAGE NUMBER;
    TEMP_LAST_PAGE NUMBER;
BEGIN

  TEMP_DOC_ID := %(doc_id)s;
    TEMP_IS_PATENT := %(is_patent)s;

    IF %(first_page)s <> -1 AND %(last_page)s <> -1 THEN
        TEMP_FIRST_PAGE := %(first_page)s;
        TEMP_LAST_PAGE := %(last_page)s;
    ELSE
        TEMP_FIRST_PAGE := NULL;
        TEMP_LAST_PAGE := NULL;
    END IF;


  for r in (select column_value as var_id from table (id_table ({}) ) )
  loop
    INSERT INTO TEMP_WRITTEN_BY VALUES(R.VAR_ID, TEMP_DOC_ID);
        dbms_output.put_line(R.VAR_ID);
    end loop;


  INSERT INTO DOCUMENT(DOC_ID, TITLE, DESCRIPTIONS, URL, EPRINT, DOI, UPLOAD_TIME, FIRST_PAGE, LAST_PAGE, IS_PATENT)
  VALUES(TEMP_DOC_ID, %(title)s, %(descriptions)s, %(url)s, %(eprint)s, %(doi)s, %(pub_date)s, TEMP_FIRST_PAGE, TEMP_LAST_PAGE, %(is_patent)s );


  for r in (select column_value as var_id from table (id_table ({}) ) )
  loop
    INSERT INTO PUBLISHED_BY(DOC_ID, PUB_ID, PUBLICATION_DATE) VALUES(TEMP_DOC_ID, R.VAR_ID, %(pub_date)s);
        dbms_output.put_line(R.VAR_ID);

        IF TEMP_IS_PATENT=1 THEN
        INSERT INTO PATENTED_BY(DOC_ID, PUB_ID, PATENT_NO, APPLICATION_NO)
            VALUES(TEMP_DOC_ID, R.VAR_ID, %(patent_no)s, %(appl_no)s);
      END IF;

    end loop;

    for r in (select column_value as var_id from table (id_table ({}) ) )
  loop
    INSERT INTO cites(citer_id, citee_id)
        VALUES(TEMP_DOC_ID, R.VAR_ID);
        dbms_output.put_line(R.VAR_ID);
    end loop;


  INSERT INTO WRITTEN_BY SELECT * FROM TEMP_WRITTEN_BY;




  COMMIT;

  DELETE FROM TEMP_WRITTEN_BY;

END;
 
 
 -- maintenance.add_new_researcher
 DECLARE
  TEMP_PERSON_ID NUMBER;
BEGIN
  TEMP_PERSON_ID := PERSON_ID_GENERATOR.NEXTVAL;
  INSERT INTO PERSON(PERSON_ID, FIRST_NAME, LAST_NAME, IS_USER, IS_RESEARCHER, IS_ADMIN, IS_AUTO_GENERATED)
    VALUES(TEMP_PERSON_ID, %(first_name)s, %(last_name)s, 0, 1, 0, 1);



  INSERT INTO RESEARCHER(PERSON_ID) VALUES(TEMP_PERSON_ID);
  INSERT INTO RESEARCHER_SETTING(RESEARCHER_ID, AUTO_UPDATE, IS_PUBLIC) VALUES(TEMP_PERSON_ID, 0, 0);

  AFF_HANDLE(TEMP_PERSON_ID, %(institute)s, %(designation)s);

  COMMIT;
END;

-- maintenance.add_new_publication
DECLARE
  TEMP_PUB_CATEGORY VARCHAR2(200);
  TEMP_PUB_ID NUMBER;
BEGIN
  TEMP_PUB_CATEGORY := %(category)s;
  TEMP_PUB_ID := PUB_ID_GENERATOR.NEXTVAL;

  INSERT INTO PUBLICATION(PUB_ID, NAME, URL, PUB_TYPE, PUBLICATION_DATE)
    VALUES(TEMP_PUB_ID, %(name)s, %(url)s, %(category)s, %(pub_date)s);

  IF LOWER(TEMP_PUB_CATEGORY) LIKE LOWER('conference') THEN
    INSERT INTO CONFERENCE_PROCEEDINGS(PUB_ID, CONFERENCE_TOPIC) VALUES(TEMP_PUB_ID, %(conf_topic)s);

  ELSIF LOWER(TEMP_PUB_CATEGORY) LIKE LOWER('journal') THEN
    INSERT INTO JOURNAL(PUB_ID, VOLUME, ISSUE) VALUES(TEMP_PUB_ID, %(volume)s, %(issue)s);

  ELSIF LOWER(TEMP_PUB_CATEGORY) LIKE LOWER('book') THEN
    INSERT INTO BOOK(PUB_ID, PUBLISHER_NAME, EDITION_) VALUES(TEMP_PUB_ID, %(publisher_name)s, %(edition)s);

  ELSIF LOWER(TEMP_PUB_CATEGORY) LIKE LOWER('miscellaneous') THEN
    INSERT INTO MISCELLANEOUS(PUB_ID, DESCRIPTION_) VALUES(TEMP_PUB_ID, %(descriptions)s);

  ELSIF LOWER(TEMP_PUB_CATEGORY) LIKE LOWER('patent') THEN
    INSERT INTO PATENT_OFFICE(PUB_ID, OFFICE_NAME, LOCATION, EMAIL, PHONE)
        VALUES(TEMP_PUB_ID, %(office_name)s, %(location)s, %(email)s, %(phone)s);

  END IF;

  COMMIT;

END;

-- metrics.query.calculate_h_index

DECLARE
    TYPE citations_t IS VARRAY(1000000) OF INTEGER;
    nums citations_t := citations_t(%s);                
    buckets citations_t := citations_t();
    cnt INTEGER := 0;
    hindex INTEGER := 0;
BEGIN
    FOR i IN 1..(nums.count + 1) LOOP
        buckets.extend();
        buckets(i) := 0;
    END LOOP;

    FOR i IN 1..nums.count LOOP
        IF nums(i) >= nums.count THEN
            buckets(nums.count+1) := buckets(nums.count+1) + 1;
        ELSE
            buckets(nums(i)+1) := buckets(nums(i)+1) + 1;
        END IF;
    END LOOP;

    FOR i IN reverse 1..(nums.count + 1) LOOP
        cnt := cnt + buckets(i);
        IF cnt >= (i - 1) THEN
            hindex := i - 1;
            EXIT;

        END IF;
    END LOOP;

    dbms_output.put_line(hindex);

:answer := hindex;

END;
 
 -- metrics.query.calculate_i10_index
 DECLARE
    TYPE citations_t IS VARRAY(1000000) OF INTEGER;
    nums citations_t := citations_t(%s);
    i10_index INTEGER := 0;
BEGIN
    FOR i IN 1..nums.count LOOP
        IF nums(i) >= 10 THEN
            i10_index := i10_index + 1;
        ELSE
            EXIT;
        END IF;
    END LOOP;

    -- dbms_output.put_line(i10_index);

    :answer := i10_index;
END;

-- my_profile.query.submit_selected_docs
DECLARE
    DOC_COUNT NUMBER;
BEGIN
FOR CURSOR_DOC_ID IN ({})
    SELECT COUNT(RESEARCHER_ID) INTO DOC_COUNT FROM WRITTEN_BY WHERE RESEARCHER_ID = %(user_id)s AND DOC_ID = CURSOR_DOC_ID;

    IF DOC_COUNT=0 THEN
        INSERT INTO WRITTEN_BY VALUES( %(user_id)s, CURSOR_DOC_ID );
        COMMIT;
    END IF;
END LOOP;
END;

-- 


DECLARE
BEGIN
    AFF_HANDLE(%(person_id)s, %(institute)s, %(designation)s);
END;

--
DECLARE
  ECOUNT NUMBER;
BEGIN
  SELECT COUNT(PERSON_ID) INTO ECOUNT FROM PERSON WHERE EMAIL LIKE %(email)s;

  IF ECOUNT = 0 THEN
    UPDATE PERSON SET EMAIL = %(email)s WHERE PERSON_ID = %(person_id)s;
    UPDATE PERSON SET FIRST_NAME = %(first_name)s, LAST_NAME = %(last_name)s, IS_RESEARCHER = 1 WHERE PERSON_ID = %(person_id)s;

    INSERT INTO RESEARCHER(PERSON_ID, INTERESTS, HOMEPAGE) VALUES(%(person_id)s, %(interests)s, %(homepage)s);
        INSERT INTO RESEARCHER_SETTING(RESEARCHER_ID) VALUES (%(person_id)s);
    AFF_HANDLE(%(person_id)s, %(institute)s, %(designation)s);
    COMMIT;
  END IF;

END;

--
DECLARE
  ECOUNT NUMBER;
BEGIN
  SELECT COUNT(PERSON_ID) INTO ECOUNT FROM PERSON WHERE EMAIL LIKE %(email)s;

  IF ECOUNT = 0 THEN
    UPDATE PERSON SET EMAIL = %(email)s WHERE PERSON_ID = %(person_id)s;
    UPDATE PERSON SET FIRST_NAME = %(first_name)s, LAST_NAME = %(last_name)s, IS_RESEARCHER = 1 WHERE PERSON_ID = %(person_id)s;

        UPDATE RESEARCHER SET INTERESTS = %(interests)s, HOMEPAGE = %(homepage)s WHERE PERSON_ID = %(person_id)s;

    AFF_HANDLE(%(person_id)s, %(institute)s, %(designation)s);
    COMMIT;
  END IF;

END;

--
DECLARE
  DOC_COUNT NUMBER;
BEGIN
  SELECT COUNT(RESEARCHER_ID) INTO DOC_COUNT FROM WRITTEN_BY WHERE RESEARCHER_ID = %(user_id)s AND DOC_ID = %(paper_id)s;

    IF DOC_COUNT=0 THEN
    INSERT INTO WRITTEN_BY VALUES( %(user_id)s, %(paper_id)s );
    COMMIT;
    END IF;
END;

