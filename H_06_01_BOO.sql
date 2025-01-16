CREATE  TABLE interbank_index_ua_history (
    record_date DATE PRIMARY KEY,        
    id_api VARCHAR2(50),              
    interest_rate NUMBER(10, 4),         
    special CHAR(1)                      
);


--SET DEFINE OFF;--



CREATE OR REPLACE VIEW interbank_index_ua_v AS
SELECT 
    TO_DATE(json_value(value, '$.dt'), 'DD.MM.YYYY') AS record_date,  
    json_value(value, '$.id_api') AS id_api,                         
    TO_NUMBER(json_value(value, '$.value')) AS interest_rate,       
    json_value(value, '$.special') AS special                       
FROM 
    JSON_TABLE(
        SYS.GET_NBU('https://bank.gov.ua/NBU_uonia?id_api=UONIA_UnsecLoansDepo&json'),
        '$[*]' COLUMNS (
            dt VARCHAR2(20) PATH '$.dt',           
            id_api VARCHAR2(50) PATH '$.id_api',  
            value VARCHAR2(20) PATH '$.value',     
            special VARCHAR2(1) PATH '$.special'  
        )
    ) value;
    
    
    
    
    
    CREATE OR REPLACE PROCEDURE download_ibank_index_ua IS
BEGIN
    INSERT INTO interbank_index_ua_history (record_date, id_api, interest_rate, special)
    SELECT
        record_date,
        id_api,
        interest_rate,
        special
    FROM
        interbank_index_ua_v
    WHERE NOT EXISTS (
        SELECT 1 
        FROM interbank_index_ua_history 
        WHERE interbank_index_ua_history.record_date = interbank_index_ua_v.record_date
    );
END;
/





BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
        job_name        => 'JOB_DOWNLOAD_IBANK_INDEX',
        job_type        => 'PLSQL_BLOCK',
        job_action      => 'BEGIN download_ibank_index_ua; END;',
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'FREQ=DAILY; BYHOUR=9;',
        enabled         => TRUE
    );
END;
/



