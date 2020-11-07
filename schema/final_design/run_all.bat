cmd /c "sqlplus gscholar/123@orcl @drop_all_tables.sql"
cmd /c "sqlplus gscholar/123@orcl @entities.sql"
cmd /c "sqlplus gscholar/123@orcl @relations.sql"
cmd /c "sqlplus gscholar/123@orcl @patch_1_settings.sql"
