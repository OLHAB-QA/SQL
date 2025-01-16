CREATE OR REPLACE PACKAGE util AS
    PROCEDURE check_work_time; 
    PROCEDURE add_new_jobs;
END util;



CREATE OR REPLACE PACKAGE BODY util AS
   PROCEDURE check_work_time IS
        v_day_of_week NUMBER;
    BEGIN
        SELECT TO_CHAR(SYSDATE, 'D') INTO v_day_of_week FROM DUAL;
        IF v_day_of_week IN (6, 7) THEN
            raise_application_error(-20205, 'Ви можете вносити зміни лише у робочі дні.');
        END IF;
    END check_work_time;

    PROCEDURE add_new_jobs IS
    BEGIN
        check_work_time; 
        dbms_output.put_line('Додано нове завдання');
    END add_new_jobs;

END util;




BEGIN
    util.add_new_jobs;
END;
