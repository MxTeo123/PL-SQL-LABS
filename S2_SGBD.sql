-- la inceputul fiecarei sesiuni de lucru vom rula
-- ( in afara blocurilor pl/sql)
-- comanda "set serveroutput on"

-- pachetul dbms.output pentru a afisa

/*Folosind blocuri PL/SQL rezolva?i urm?toarele exerci?ii

1. S? se creeze tabela Ang, care sa preia campurile id, nume, prenume, salariul, comision, data_angajare din tabela Angajati.
2. S? se adauge un nou angajat ?n tabela nou creat?, ale c?rui date sunt citite de la tastatur?
3. Ad?uga?i o noua coloan? ?Email? in tabela Ang. Folositi o variabil? local?.
4. S? se m?reasc? cu 20% salariul unui angajat al c?rui id este citit de la tastatur?. 
5. Folosind o variabila globala, preluati si afisati salariul unui angajat al carui id il citim de la tastatura. In continuare realizati un alt bloc PL/SQL prin care sa afisam numele angajatului cu salariul respectiv*/

-- 1
begin
execute immediate 'create table Ang as select id_angajat, nume, prenume, salariul, comision, data_angajare from angajati';
end;
/
desc Ang;

-- 2
declare
v_id Ang.id_angajat%type := &id;
v_nume Ang.nume%type := '&nume_angajat';
v_salariul Ang.salariul%type := &salariu_angajat;
begin
insert into Ang (id_angajat,nume,salariul) VALUES (v_id, v_nume, v_salariul);
end;
/
select * from Ang order by id_angajat;

-- 3
declare
comanda varchar2(40) := 'alter table Ang add email varchar2(40)';
begin
execute immediate comanda;
end;
/
desc Ang;

-- 4
declare
v_id Ang.id_angajat%type := &id;
begin
update Angajati set salariul = 1.2*salariul where id_angajat = v_id;
end;

-- 5
declare
v_id Ang.id_angajat%type := &id;
v_salariu Ang.salariul%type := select salariul from Angajati where id_angajat = id;
begin
DBMS_OUTPUT.PUT_LINE(v_salariu);
declare
v_nume Ang.nume%type := select nume from Angajati where salariul = v_salariu;
begin
DBMS_OUTPUT.PUT_LINE(v_nume);
end;
end;





















