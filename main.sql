-- main.sql
-- Drop and recreate all tables
@"D:/Bits Hyderabad_Campus Diaries/DBMS Project/create_tables.sql"
-- Compile procedures/functions
@"D:/Bits Hyderabad_Campus Diaries/DBMS Project/procedures.sql"

-- Enable output formatting
SET SERVEROUTPUT ON
SET LINESIZE 150
SET PAGESIZE 50

@"D:/Bits Hyderabad_Campus Diaries/DBMS Project/test_queries.sql"
