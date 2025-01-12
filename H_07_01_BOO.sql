
SELECT 
    d.department_id, 
    d.department_name, 
    COUNT(e.employee_id) AS employee_count
FROM departments d
LEFT JOIN employees e ON  d.department_id = e.department_id
WHERE (e.department_id = :p_department_id OR :p_department_id IS NULL)
GROUP BY d.department_id, d.department_name;







