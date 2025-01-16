DECLARE
 v_employee_id hr.employees.employee_id%TYPE := 110;
  v_job_id  hr.employees.job_id%TYPE;
   v_job_title  hr.jobs.job_title%TYPE;

BEGIN
           
      
         SELECT  job_id
         into v_job_id
         from HR.employees em
         where em.employee_id=v_employee_id;
          
         SELECT job_title
    INTO v_job_title
    FROM hr.jobs J
    WHERE J.job_id = v_job_id;
     dbms_output.put_line('Посада співробітника ' || v_job_title);
  END;
  /
  
  
  
 --- select em.employee_id, j.*
     ----    fROM hr.employees em
    ----      JOIN hr.jobs j
     ----   ON em.job_id = j.job_id;
    
