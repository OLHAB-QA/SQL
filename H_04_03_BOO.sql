create or replace PACKAGE util_2 AS
    FUNCTION get_sum_price_sales(p_table IN VARCHAR2) RETURN NUMBER;
    PROCEDURE to_log(p_message IN VARCHAR2);
END util_2;






create or replace PACKAGE BODY util_2 AS

    PROCEDURE to_log(p_message IN VARCHAR2) IS
    BEGIN
    
        INSERT INTO logs (id, appl_proc, message, log_date)
        VALUES (logs_seq.NEXTVAL, 'util.get_sum_price_sales', p_message, SYSDATE);
        COMMIT;
    END to_log;

    FUNCTION get_sum_price_sales(p_table IN VARCHAR2) RETURN NUMBER IS
        v_dynamic_sql VARCHAR2(500);
        v_sum NUMBER;
    BEGIN

        IF p_table NOT IN ('products', 'products_old') THEN
            to_log('Неприпустиме значення! Очікується products або products_old');
            RAISE_APPLICATION_ERROR(-20001, 'Неприпустиме значення! Очікується products або products_old');
        END IF;

        v_dynamic_sql := 'SELECT SUM(price_sales) FROM hr.' || p_table;

        EXECUTE IMMEDIATE v_dynamic_sql INTO v_sum;

        RETURN v_sum;
    END get_sum_price_sales;

END util_2;
