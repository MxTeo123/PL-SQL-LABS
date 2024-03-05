/*INTR UN BLOC PL/SQL ACTUALIZATI SALARIUL UNUI ANG AL CARUI ID IL CITIM DE LA 
TASTATURA, in functie de nr de comenzi intermediate de acesta astfel.
Daca angajatul a intermediat intre 4 si 8 comenzi, are o crestere de 10 procente
Daca a intermediat mai mult de 8 comenzim cresterea e de 20 de procente
Altfel, nu i se modifica salariul
Afisati numele si salariul initial, identificati si afisati nr de comenzi aferent
angajatului, realizati actualkizarea si apoi afisati noul salariu primit de 
angajatul respectiv*/

SET SERVEROUTPUT ON

DECLARE
v_id angajati.id_angajat%type:=&id;
v_nume angajati.nume%type;
v_salariul angajati.salariul%type;
v_nrcom number;

BEGIN 
SELECT nume, salariul INTO v_nume, v_salariul FROM Angajati where id_angajat=v_id;
DBMS_OUTPUT.PUT_LINE('Angajatul '||v_nume||' are salariul initial '||v_salariul);

SELECT count(id_Angajat) INTO v_nrcom FROM Comenzi WHERE id_angajat=v_id; 
DBMS_OUTPUT.PUT_LINE('Angajatul a intermediat '||v_nrcom||' comenzi');

IF v_nrcom between 4 and 8 then
v_salariul:=v_salariul*1.1;
ELSIF v_nrcom>8 then
v_salariul:=v_salariul*1.2;
END IF;

update Angajati
set salariul=v_salariul
where id_angajat=v_id;

DBMS_OUTPUT.PUT_LINE(v_salariul);
END;



/*intr un bloc plsql sa se parcurga toti angajatii cu id_angajat de la 100 la 110,
afisand numele si salariul acestora(exemplificati utilizand toate cele 3 
structuri repetitive)*/

--LOOP
DECLARE
v_id angajati.id_angajat%type:=100;
v_nume angajati.nume%type;
v_salariul angajati.salariul%type;
begin
loop
Select nume, salariul into v_nume, v_salariul from angajati where id_angajat=v_id;
DBMS_OUTPUT.PUT_LINE(v_id||''||v_nume||''||v_salariul);
v_id:=v_id+1;
exit when v_id>110;
end loop;
end;

--while loop


DECLARE
v_id angajati.id_angajat%type:=100;
v_nume angajati.nume%type;
v_salariul angajati.salariul%type;
begin
while v_id<=110 loop
Select nume, salariul into v_nume, v_salariul from angajati where id_angajat=v_id;
DBMS_OUTPUT.PUT_LINE(v_id||''||v_nume||''||v_salariul);
v_id:=v_id+1;
exit when v_id>110;
end loop;
end;

--TEMA: CU FOR



/*intr un bloc pls ql sa se parcurga toti an, afisand  numele si sal acestora
(Exemplificati utilizand toate cele 3 structuri repetitive)*/

--FOR

DECLARE
v_nume angajati.nume%type;
v_salariul angajati.salariul%type;
v_idmin angajati.id_angajat%type;
v_idmax angajati.id_angajat%type;

BEGIN

select MIN(ID_ANGAJAT),MAX(id_angajat) INTO v_idmin, v_idmax FROM Angajati;
FOR v_id in v_idmin..v_idmax loop
Select nume, salariul into v_nume, v_salariul from Angajati where id_angajat=v_id;
DBMS_OUTPUT.PUT_LINE(v_id||''||v_nume||v_salariul);
end loop;
end;

--tema 
--pas 1stergem angajat cu id 110
--pas 2 de afisat lista ang ramasi nume 


declare
v_id angajati.id_angajat%type:=100;
begin
delete from angajati
where v_id=110;
end;
/

