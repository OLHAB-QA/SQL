DECLARE
  v_def_percent VARCHAR2(30);
  v_percent VARCHAR2(5);
BEGIN

     FOR cc IN (
            SELECT 
                 first_name || ' ' || last_name AS emp_name, 
                 commission_pct * 100 AS percent_of_salary, 
                 manager_id
            FROM employees
            WHERE department_id = 80
            ORDER BY first_name )  LOOP
    
    IF cc.manager_id = 100 THEN
      dbms_output.put_line('Співробітник - ' || cc.emp_name || ', процент до зарплати на зараз заборонений');
      CONTINUE;
    END IF;
    
    
    IF cc.percent_of_salary BETWEEN 10 AND 20 THEN
      v_def_percent := 'мінімальний';
    ELSIF cc.percent_of_salary BETWEEN 25 AND 30 THEN
      v_def_percent := 'середній';
    ELSIF cc.percent_of_salary BETWEEN 35 AND  40 THEN
      v_def_percent := 'максимальний';
    ELSE
      v_def_percent := 'недоступний'; 
    END IF;
    
    v_percent := CONCAT(cc.percent_of_salary, '%');
    
    DBMS_OUTPUT.PUT_LINE('Співробітник - ' || cc.emp_name || '; процент до зарплати - ' || v_percent || '; опис процента - ' || v_def_percent);
  END LOOP;
END;
/

