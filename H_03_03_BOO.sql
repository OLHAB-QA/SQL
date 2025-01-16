----specification
create or replace PACKAGE UTIL_1 AS
   FUNCTION get_job_title(p_employee_id IN NUMBER) RETURN VARCHAR2 ;
    FUNCTION get_dep_name(p_employee_id IN NUMBER) RETURN VARCHAR2;
    PROCEDURE del_jobs(p_job_id IN VARCHAR2);
END UTIL_1;



----body

create or replace PACKAGE BODY UTIL_1 AS

        FUNCTION get_job_title(p_employee_id IN NUMBER) RETURN VARCHAR2 IS
                              v_job_title jobs.job_title%TYPE;
BEGIN
        SELECT j.job_title
        INTO v_job_title
        FROM employees em
        JOIN jobs j
        ON em.job_id = j.job_id
        WHERE em.employee_id = p_employee_id;
        RETURN v_job_title;
END get_job_title;

    FUNCTION get_dep_name(p_employee_id IN NUMBER) RETURN VARCHAR2 IS
    v_department_name VARCHAR2(100);
BEGIN
    SELECT d.department_name
    INTO v_department_name
    FROM EMPLOYEES em
    JOIN DEPARTMENTS d
    ON em.department_id = d.department_id
    WHERE em.employee_id = p_employee_id;

    RETURN v_department_name;

END get_dep_name;


    PROCEDURE del_jobs(p_job_id IN VARCHAR2)is  
    BEGIN

       DELETE FROM JOBS
        WHERE JOB_ID = P_JOB_ID;

        COMMIT;
    END del_jobs;

END UTIL_1;


----¬»ƒ¿À≈ÕÕﬂ «≤ —¬Œ™Ø —’≈Ã» 
drop PROCEDURE del_jobs;
drop FUNCTION get_dep_name;
drop  FUNCTION get_job_title;


---‚ËÍÎËÍ ÔÓˆÂ‰ÛË
SELECT util_1.get_job_title
FROM dual;


SELECT UTIL_1.get_job_title('QA Engineer7777') 
FROM dual;

SELECT UTIL_1.get_dep_name(100)
FROM dual;

BEGIN
    UTIL_1.del_jobs('IT_PROG');
END;