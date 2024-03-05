
set serveroutput on;


--1)Realizați un bloc PL/SQL pentru a afișa data de începere a ocupării funcției curente a unui anumit angajat, al cărui ID este citit de la tastatura. Dacă angajatul nu a mai avut și alte funcții afișați data angajării. 
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

--2)Folosind un bloc Pl/SQL afișați numărul de angajați ai firmei care au fost angajați în fiecare an în intervalul 2016-2022. Dacă într-un an au fost angajate maxim 3 persoane, afișați numărul și mesajul 'An neproductiv'; altfel afișați numărul împreună cu mesajul - an productiv. În cazul în care într-un an nu a fost angajată nici o persoană invocați o excepție, care se va trata corespunzător (mesajul 'În anul YYYY nu s-au făcut angajări').

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




--3)Într-un bloc PL/SQL afişaţi informaţii despre top 3 comenzi care au cea mai mare valoare.

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



--4)Într-un bloc PL/SQL Afişaţi informaţii despre primii 5 agenţi angajaţi în firmă (se va realiza filtrarea în funcţie de câmpul Data_Angajare). 

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


--5) Intr-un bloc Pl/SQL afisati numele unui angajat, al carui id este citit de la tastatura. De asemenea, calculați numarul de comenzi gestionate de catre angajatul respectiv. Afisati numele angajatului , iar daca acesta exista și s-a ocupat de comenzi, afișați numarul acestora. Dacă angajatul nu există, tratați excepția cu o rutină de tratare corespunzătoare, iar dacă angajatul nu s-a ocupat de nici o comandă, invocați o excepție, care se va trata corespunzător. Tratați orice altă excepție cu o rutină de tratare corespunzătoare.
--    Creaţi o tabela numita Mesaje, având un câmp unic, de tip Varchar2. În continuare, realizați un bloc PL/SQL pentru a selecta codul comenzilor încheiate într-un an citit de la tastatur[.
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

--6) Dacă interogarea returnează mai mult de o valoare pentru numărul comenzii, trataţi excepţia cu o rutină de tratare corespunzătoare şi inseraţi în tabela MESAJE mesajul “Atenţie! In anul YYYY s-au încheiat mai multe comenzi!”.
    /*Dacă interogarea nu returnează nici o valoare pentru numărul comenzii, trataţi excepţia cu o rutină de tratare corespunzătoare şi inseraţi în tabela Mesaje mesajul “Atenţie! In anul YYYY nu s-au încheiat comenzi!”.
    Dacă se returnează o singura linie, introduceţi în tabela Mesaje numărul comenzii.
    Trataţi orice altă excepţie cu o rutină de tratare corespunzătoare şi inseraţi în tabela MESAJE mesajul “A apărut o altă eroare!”.*/

--7) Realizați un bloc PL/SQL în care să exemplificați lucrul cu excepții definite de utilizator folosind funcția RAISE_APPLICATION_ERROR()
