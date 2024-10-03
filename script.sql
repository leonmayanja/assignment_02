-- Task 1
-- Create new PDB and user
CREATE PLUGGABLE DATABASE plsql_class2024db ADMIN USER le_plsqlauca IDENTIFIED BY password;

-- Task 2
-- Create PDB to be dropped
CREATE PLUGGABLE DATABASE le_to_delete_pdb ADMIN USER pdbadmin IDENTIFIED BY password;
-- Close PDB
ALTER PLUGGABLE DATABASE le_plsqlauca CLOSE IMMEDIATE;
-- Get correct directory path
SELECT directory_name, directory_path FROM dba_directories;
-- Unplug the PDB
ALTER PLUGGABLE DATABASE le_plsqlauca UNPLUG INTO '/path_to_xml/your_pdb_name.xml';
-- Drop the PDB including its associated datafiles
DROP PLUGGABLE DATABASE le_plsqlauca INCLUDING DATAFILES;
-- Verify the PDB has been dropped
SELECT name, open_mode FROM v$pdbs;

-- Task 3
Ensure that you are connected to the database. Use the command below to do so.
sqlplus le_plsqlauca/password@//localhost:1521/plsql_class2024db

Check if you are connected to the root container
show con_name
If not, I run the query below.
ALTER SESSION SET CONTAINER = CDB$ROOT;

-- Ensure HTTP/HTTPS port for OEM is enabled
SELECT DBMS_XDB_CONFIG.gethttpsport() AS https_port,
DBMS_XDB_CONFIG.gethttpport() AS http_port FROM dual;

If the ports return 0, it means they are not enabled.

-- Enable the HTTPS or HTTP port
BEGIN
	DBMS_XDB_CONFIG.SETHTTPPORT(8080);
	DBMS_XDB_CONFIG.SETHTTPSPORT(8443); -- Optional for HTTPS
END;
-- Check the port settings again
SELECT DBMS_XDB_CONFIG.gethttpsport() AS https_port,
DBMS_XDB_CONFIG.gethttpport() AS http_port FROM dual;

The ports now return 8080 and 8443 meaning that they are now enabled.
-- Restart the database
SHUTDOWN IMMEDIATE;
STARTUP;

Use this URL to access Oracle Enterprise Manager
https://localhost:8443/em

