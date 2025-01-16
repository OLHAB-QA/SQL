create or replace PACKAGE UTIL_1 AS
    FUNCTION get_job_title(p_employee_id IN NUMBER) RETURN VARCHAR2 ;
    FUNCTION get_dep_name(p_employee_id IN NUMBER) RETURN VARCHAR2;
    PROCEDURE del_jobs(p_job_id IN VARCHAR2);
    PROCEDURE check_work_time;
    PROCEDURE add_new_jobs;
    PROCEDURE del_jobs(
        p_job_id IN VARCHAR2,
        po_result OUT VARCHAR2);
   END util_1;
   
   
   
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
        
       
    
PROCEDURE check_work_time IS
        v_day_of_week NUMBER;
        BEGIN
            SELECT TO_CHAR(SYSDATE, 'D') INTO v_day_of_week FROM DUAL;
            IF v_day_of_week IN (6, 7) THEN
                RAISE_APPLICATION_ERROR(-20205, 'Ви можете вносити зміни лише у робочі дні.');
            END IF;
        END check_work_time;

PROCEDURE add_new_jobs IS
        BEGIN
            check_work_time;
            DBMS_OUTPUT.PUT_LINE('Додано нове завдання');
        END add_new_jobs;
        
    
    
PROCEDURE del_jobs(
          p_job_id IN VARCHAR2,
          po_result OUT VARCHAR2) IS
          v_delete_no_data_found EXCEPTION; 
        BEGIN
            check_work_time;

        BEGIN
            DELETE FROM JOBS
            WHERE JOB_ID = p_job_id;

            IF SQL%ROWCOUNT = 0 THEN
                RAISE v_delete_no_data_found;
            END IF;

            COMMIT;

            po_result := 'Посада ' || p_job_id || ' успішно видалена';
        EXCEPTION
           
            WHEN v_delete_no_data_found THEN
                RAISE_APPLICATION_ERROR(-20004, 'Посада ' || p_job_id || ' не існує');
        END;

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK; 
            RAISE;    
    END del_jobs;


END UTIL_1;