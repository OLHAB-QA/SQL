CREATE OR REPLACE PROCEDURE del_jobs ( p_job_id IN jobs.job_id%TYPE, 
                                       po_result OUT VARCHAR2)IS
    v_exists NUMBER;
    
BEGIN
    -- Перевірка існування посади
    SELECT COUNT(job_id)
    INTO v_exists
    FROM jobs
    WHERE job_id = p_job_id;

    IF v_exists = 0 THEN
   
        po_result := 'Посада ' || p_job_id || ' не існує';
    ELSE
        
        DELETE FROM jobs
        WHERE job_id = p_job_id;

        
        po_result := 'Посада ' || p_job_id || ' успішно видалена';
    END IF;
    
END del_jobs;
/   



-----створення посади 
DECLARE
v_err VARCHAR2(100);
BEGIN
add_new_jobs(p_job_id => 'IT_QArr1',
p_job_title => 'QA Engineerrr1',
p_min_salary => 3000,
p_max_salary => 10000,
po_err => v_err);
dbms_output.put_line(v_err);
END;
/

----перевірка видалення посади
DECLARE
    v_result VARCHAR2(200);
BEGIN
    DEL_JOBS(P_JOB_ID => 'IT_QArr1',
                PO_RESULT => v_result);
    DBMS_OUTPUT.PUT_LINE(v_result); 
END;
/