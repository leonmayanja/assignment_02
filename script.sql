-- Task 1: Create new PDB and user
-- Connect to the CDB
sqlplus sys as sysdba

CREATE PLUGGABLE DATABASE plsql_class2024db
ADMIN USER le_plsqlauca IDENTIFIED BY password;

-- Task 2: Create and Delete a Pluggable Database
-- Create a PDB to be dropped
CREATE PLUGGABLE DATABASE le_to_delete_pdb 
ADMIN USER pdbadmin IDENTIFIED BY password;

-- Close the PDB
ALTER PLUGGABLE DATABASE le_to_delete_pdb CLOSE IMMEDIATE;

-- Get the correct directory path
SELECT directory_name, directory_path 
FROM dba_directories;

-- Unplug the PDB
ALTER PLUGGABLE DATABASE le_to_delete_pdb
UNPLUG INTO 'C:\app\oraclebase\admin\orcl\dpdump\pdb_metadata.xml';


-- Drop the PDB including its associated datafiles
DROP PLUGGABLE DATABASE le_to_delete_pdb INCLUDING DATAFILES;

-- Verify the PDB has been dropped
SELECT name, open_mode 
FROM v$pdbs;

-- Task 3: Configure Oracle Enterprise Manager (OEM)
-- Ensure that you are connected to the database
-- Check if you are connected to the root container
SHOW CON_NAME;

-- If not, set the session to the root container
ALTER SESSION SET CONTAINER = CDB$ROOT;

-- Ensure HTTP/HTTPS port for OEM is enabled
SELECT DBMS_XDB_CONFIG.gethttpsport() AS https_port,
       DBMS_XDB_CONFIG.gethttpport() AS http_port 
FROM dual;

-- If the ports return 0, they are not enabled
-- Enable the HTTPS or HTTP port
BEGIN
    DBMS_XDB_CONFIG.SETHTTPPORT(8080);
    DBMS_XDB_CONFIG.SETHTTPSPORT(5500);
END;

-- Check the port settings again
SELECT DBMS_XDB_CONFIG.gethttpsport() AS https_port,
       DBMS_XDB_CONFIG.gethttpport() AS http_port 
FROM dual;

-- The ports should now return 8080 and 5500, meaning they are enabled
-- Restart the database
SHUTDOWN IMMEDIATE;
STARTUP;

-- Access Oracle Enterprise Manager using this URL:
-- https://localhost:5500/em
