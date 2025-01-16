CREATE TABLE projects_ext (
    project_id NUMBER,
    project_name VARCHAR2(100),
    department_id NUMBER
)
ORGANIZATION EXTERNAL (
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY FILES_FROM_SERVER
    ACCESS PARAMETERS (
        RECORDS DELIMITED BY NEWLINE
        FIELDS TERMINATED BY ','
        MISSING FIELD VALUES ARE NULL
        (
            project_id     INTEGER EXTERNAL,
            project_name   CHAR(100),
            department_id  INTEGER EXTERNAL
        )
    )
    LOCATION ('PROJECTS.csv')
)
REJECT LIMIT UNLIMITED;



CREATE OR REPLACE VIEW rep_project_dep_v AS
SELECT 
    p.project_name,
    d.department_name,
    COUNT(e.employee_id) AS employee_count,
    COUNT(DISTINCT e.manager_id) AS unique_managers,
    SUM(e.salary) AS total_salary
FROM projects_ext p
JOIN departments d ON p.department_id = d.department_id
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY p.project_name, d.department_name;




DECLARE
    l_file UTL_FILE.FILE_TYPE;
    l_line VARCHAR2(1000);
BEGIN
    l_file := UTL_FILE.FOPEN('FILES_FROM_SERVER', 'TOTAL_PROJ_INDEX_BOO.csv', 'W');

    UTL_FILE.PUT_LINE(l_file, 'Project Name,Department Name,Employee Count,Unique Managers,Total Salary');

    FOR rec IN (SELECT * 
                FROM rep_project_dep_v) LOOP
                  l_line := rec.project_name || ',' || 
                  rec.department_name || ',' || 
                  rec.employee_count || ',' || 
                  rec.unique_managers || ',' || 
                  rec.total_salary;
        UTL_FILE.PUT_LINE(l_file, l_line);
    END LOOP;

    
    UTL_FILE.FCLOSE(l_file);
END;
/