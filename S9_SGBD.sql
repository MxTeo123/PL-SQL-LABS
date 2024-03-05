set serveroutput on;
--1.      Realizaţi o procedură afiseaza_angajati în care să declaraţi un cursor pentru a selecta numele, funcţia şi data angajării salariaţilor din tabela Angajaţi. Parcurgeţi fiecare rând al cursorului şi, în cazul în care data angajării depăşeşte 01-AUG-2010, afişaţi informaţiile preluate. Apelaţi procedura.
create or replace procedure afiseaza_angajati
is
cursor c is select nume,id_functie,data_angajare from angajati;
v_nume angajati.nume%type;
v_functie angajati.id_functie%type;
v_data angajati.data_angajare%type;
begin
open c;
loop
fetch c into v_nume,v_functie, v_data;
if v_data > to_date('01-08-2010','dd-mm-yyyy')
then
dbms_output.put_line(v_nume ||' ' || v_functie ||' '||v_data);
end if;
exit when c%notfound;
end loop;
exception when no_data_found
then dbms_output.put_line('eroare');
close c;
end;
execute afiseaza_angajati;


--2.      Realizaţi o funcţie vechime_angajat (p_cod angajati.id_angajat%type) care să returneze vechimea angajatului (calculată drept diferenţă între data actuală şi cea a angajării) care are codul primit ca parametru. Trataţi excepţiile apărute. Apelaţi funcţia dintr-un bloc PL/SQL şi utilizaţi un cursor pentru a parcurge toţi angajaţii.
create or replace function vechime_angajati(p_cod angajati.id_angajat%type) return number
is 
v_vechime number;
begin
select round((sysdate-data_angajare)/365) into v_vechime from angajati
where id_angajat=p_cod;
return v_vechime;
exception when no_data_found then return -1;
end;
 
declare 
cursor c is select id_angajat from angajati;
begin
for i in c loop
dbms_output.put_line('angajatul cu id ul '||i.id_angajat||'are o vechime de '||vechime_angajati(i.id_angajat)||' ani');
exit when c%notfound;
end loop;
end;


--3.      Realizaţi o procedură vechime_angajat_proc (p_cod  IN angajati.id_angajat %type, p_vechime OUT number) care să calculeze vechimea angajatului care are codul primit ca parametru. Trataţi excepţiile apărute. Apelaţi procedura dintr-un bloc PL/SQL şi utilizaţi un cursor pentru a parcurge toţi angajaţii.
create or replace function vechime_angajat(p_cod angajati.id_angajat%type) return number
is
v_vechime number;
begin
select round((sysdate-data_angajare)/365) into v_vechime from angajati
where id_angajat=p_cod;
return v_vechime;
exception when no_data_found then return -1;
end;

declare
cursor c is select id_angajat from angajati;
begin
for i in c loop
dbms_output.put_line('angajatul cu id ul '||i.id_angajat||' '||'are o vechime de' ||vechime_angajat(i.id_angajat)||'ani');
exit when c%notfound;
end loop;
end;
--4.      Realizaţi o procedură vechime_angajat_proc2 care să calculeze vechimea fiecărui angajat (înregistrările se vor parcurge printr-un cursor). Trataţi excepţiile apărute. Testaţi procedura.
create or replace procedure vechime_angajat_proc2
is
cursor c is select nume, round((sysdate-data_angajare)/365)as vechime from angajati;
begin
for i in c loop
dbms_output.put_line(i.nume||' '||i.vechime);
exit when c% notfound; 
end loop;
exception when no_data_found
then dbms_output.put_line('eroare');
end;
execute vechime_angajat_proc2;
--5.      Realizaţi o procedură prin care să se returneze data încheierii şi valoarea celei mai recente comenzi: info_comanda_recenta (p_data OUT comenzi.data%type, p_valoare OUT number)
create or replace function info_comanda_recenta (p_data OUT comenzi.data%type, p_valoare OUT number) 
is
v_incheiere number;
v_recenta number;
