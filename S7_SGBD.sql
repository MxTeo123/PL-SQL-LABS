--1. Realizati o procedura PL/SQL prin intermediul careia sa mariti cu 20% salariul angajatilor comisionati, care au intermediat minim 3 comenzi intr-un an transmis ca parametru. Returnati numarul de angajati pentru care se realizeaza aceasta actualizare, sau tratati in mod corespunzator o exceptie daca nu exista nici un angajat pentru care se modifica salariul. Apelati procedura si afisati numarul de angajati carora li s-a modificat salariul.
set serveroutput on

create or replace procedure marire_salariu(p_an in number, p_nr out number)
is 
e1 exception;
begin 
update angajati 
set salariul=1.2*salariul
where comision is not null and
id_angajat in (select id_angajat from comenzi
where extract(year from data)=p_an
group by id_angajat
having count(id_comanda)>=3);

if sql%found then
p_nr:=sql%rowcount;
else
raise e1;
end if;
exception when e1 then
p_nr:=0;
end;

declare
nr_angajati  number;
begin
marire_salariu(&an, nr_angajati);
if nr_angajati!=0 then 
DBMS_OUTPUT.PUT_LINE('Am acordat mariri pentru ' ||nr_angajati);
else 
DBMS_OUTPUT.PUT_LINE('nu au fost indeplinite cerintele pt marire');
end if;
end;


--2. Realizati o functie PL/SQL care sa returneze categoria in care se incadreaza un angajat al carui id este transmis ca parametru. Angajatii cu salariul mai mic de 3000 sunt in categoria 'junior', cei cu salariul intre 3000 and 7000 'mid-level;, iar cei cu salariul peste 7000 sunt incadrati la 'senior'. Tratati exceptia care apare daca angajatul pentru care se face verificarea nu exista (returnam un mesaj corespunzator).
create or replace function categorii(p_id angajati.id_angajat%type)
return varchar2
is
v_sal angajati.salariul%type;
begin 
select salariul into v_sal from angajati where id_angajat=p_id;
if v_sal<3000 then return 'junior';
elsif v_sal between 3000 and 7000 then
return 'mid-level';
else return 'senior';
end if;
exception 
when no_data_found then 
return 'nu exista angajatul';
end;

begin
DBMS_OUTPUT.PUT_LINE(categorii(&id));
end;


--3. Realizati o functie PL/SQL care sa returneze numele complet al angajatului dat ca parametru.

-- sa se realizeze folosind schema proprie de proiect cel putin 5 subprograme(functii si proceduri)
--in care sa utilizati cat mai multe dintre elementele discutate pana 

--test 18 mai!