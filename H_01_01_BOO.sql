DECLARE
    v_year NUMBER :=2024; 
    v_check_year NUMBER;
BEGIN
    v_check_year:= mod(v_year, 4);
    If v_check_year = 0 THEN
    dbms_output.put_line('���������� ��');
    Else 
    dbms_output.put_line('�� ���������� �s�');
 END IF;
 END; 
 /