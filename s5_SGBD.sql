
set serveroutput on;


--1)Realiza?i un bloc PL/SQL pentru a afi?a data de începere a ocup?rii func?iei curente a unui anumit angajat, al c?rui ID este citit de la tastatura. Dac? angajatul nu a mai avut ?i alte func?ii afi?a?i data angaj?rii. 
declare
v_id angajati.id_angajat%type:=&id;
cursor c1 is select * from angajati;
begin
for i in c1 loop
if v_id=i.id_angajat then
DBMS_OUTPUT.PUT_LINE('angajatul cu id-ul ' || v_id ||' a fost angajat la data de ' || i.data_angajare);
exit;
else
DBMS_OUTPUT.PUT_LINE('nu exista un angajat cu id-ul introdus!');
exit;
end if;
end loop;
end;
/

--2)Folosind un bloc Pl/SQL afi?a?i num?rul de angaja?i ai firmei care au fost angaja?i în fiecare an în intervalul 2016-2022. Dac? într-un an au fost angajate maxim 3 persoane, afi?a?i num?rul ?i mesajul 'An neproductiv'; altfel afi?a?i num?rul împreun? cu mesajul - an productiv. În cazul în care într-un an nu a fost angajat? nici o persoan? invoca?i o excep?ie, care se va trata corespunz?tor (mesajul 'În anul YYYY nu s-au f?cut angaj?ri').

declare
v_an number := 2016;
v_numar number;
begin
loop
select count(id_angajat) into v_numar from angajati where extract(year from data_angajare) = v_an;
if v_numar < 4 then
DBMS_OUTPUT.PUT_LINE('an neproductiv; ' || v_numar);
else
DBMS_OUTPUT.PUT_LINE('an productiv; ' || v_numar);
end if;
v_an := v_an + 1;
exit when v_an = 2022;
end loop;
exception
when others then
DBMS_OUTPUT.PUT_LINE('in anul ' || v_an || ' nu s-a angajat nimeni!');
end;




--3)Într-un bloc PL/SQL afi?a?i informa?ii despre top 3 comenzi care au cea mai mare valoare.

declare
cursor c1 is select id_comanda, id_produs, pret*cantitate pxc from rand_comanda order by 3 desc;
nr number := 0;
begin
for i in c1 loop
DBMS_OUTPUT.PUT_LINE('id comanda:' || i.id_comanda || ', id produs: ' || i.id_produs || ', valoare comanda: ' || i.pxc);
nr := nr + 1;
exit when nr = 3;
end loop;
end;



--4)Într-un bloc PL/SQL Afi?a?i informa?ii despre primii 5 agen?i angaja?i în firm? (se va realiza filtrarea în func?ie de câmpul Data_Angajare). 

declare
cursor c1 is select id_angajat, data_angajare, id_functie, salariul from angajati order by data_angajare;
nr number:=0;
begin
for i in c1 loop
DBMS_OUTPUT.PUT_LINE('id angajat: '||i.id_angajat||' data angajare: '||i.data_angajare||' id-ul functiei: '||i.id_functie||' salariul: '||i.salariul);
nr:=nr+1;
exit when nr=5;
end loop;
end;


--5) Intr-un bloc Pl/SQL afisati numele unui angajat, al carui id este citit de la tastatura. De asemenea, calcula?i numarul de comenzi gestionate de catre angajatul respectiv. Afisati numele angajatului , iar daca acesta exista ?i s-a ocupat de comenzi, afi?a?i numarul acestora. Dac? angajatul nu exist?, trata?i excep?ia cu o rutin? de tratare corespunz?toare, iar dac? angajatul nu s-a ocupat de nici o comand?, invoca?i o excep?ie, care se va trata corespunz?tor. Trata?i orice alt? excep?ie cu o rutin? de tratare corespunz?toare.
--    Crea?i o tabela numita Mesaje, având un câmp unic, de tip Varchar2. În continuare, realiza?i un bloc PL/SQL pentru a selecta codul comenzilor încheiate într-un an citit de la tastatur[.
select* from comenzi;
declare
v_id angajati.id_angajat%type := &id;
v_nume angajati.nume%type;
v_nr number;
ang_except exception;
begin
select count(id_comanda) into v_nr from comenzi where id_angajat = v_id;
select nume into v_nume from angajati where id_angajat = v_id;
if v_nr > 0 then
DBMS_OUTPUT.PUT_LINE(v_nume || ' a gestionat ' || v_nr || ' comenzi');
else
raise ang_except;
end if;
exception
when no_data_found then
DBMS_OUTPUT.PUT_LINE('angajatul cu id specificat nu exista!');
when ang_except then
DBMS_OUTPUT.PUT_LINE('angajatul nu a intermediat comenzi');
when others then
DBMS_OUTPUT.PUT_LINE('alta exceptie');
end;

--6) Dac? interogarea returneaz? mai mult de o valoare pentru num?rul comenzii, trata?i excep?ia cu o rutin? de tratare corespunz?toare ?i insera?i în tabela MESAJE mesajul “Aten?ie! In anul YYYY s-au încheiat mai multe comenzi!”.
    /*Dac? interogarea nu returneaz? nici o valoare pentru num?rul comenzii, trata?i excep?ia cu o rutin? de tratare corespunz?toare ?i insera?i în tabela Mesaje mesajul “Aten?ie! In anul YYYY nu s-au încheiat comenzi!”.
    Dac? se returneaz? o singura linie, introduce?i în tabela Mesaje num?rul comenzii.
    Trata?i orice alt? excep?ie cu o rutin? de tratare corespunz?toare ?i insera?i în tabela MESAJE mesajul “A ap?rut o alt? eroare!”.*/

--7) Realiza?i un bloc PL/SQL în care s? exemplifica?i lucrul cu excep?ii definite de utilizator folosind func?ia RAISE_APPLICATION_ERROR()
