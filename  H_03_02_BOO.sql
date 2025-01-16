CREATE OR REPLACE FUNCTION get_dep_name(p_employee_id IN NUMBER) RETURN VARCHAR2 IS
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
/



---перевірка 
----не правильний варіант,не вистачає until ,так як ми функцію і процедуру видалили 
SELECT  em.employee_id,
        em.first_name,
        em.last_name,
        em.job_id,
        get_job_title(p_employee_id => em.employee_id) as job_title,
        get_dep_name(p_employee_id => em.employee_id) as department_name
FROM employees em;


---првильно!!!
SELECT  em.employee_id,
        em.first_name,
        em.last_name,
        em.job_id,
        olxga_h7p.util_1.get_job_title(p_employee_id => em.employee_id) as job_title,
        olxga_h7p.util_1.get_dep_name(p_employee_id => em.employee_id) as department_name
FROM hr.employees em;
