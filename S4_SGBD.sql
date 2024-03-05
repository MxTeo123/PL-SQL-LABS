set serveroutput on;

--1. S? se ?tearg? din tabela comenzi toate comenzile plasate �ntr-o modalitate introdus? prin intermediul unei variabile de substitu?ie. 
--Afi?a?i num?rul de comenzi care au fost ?terse folosind o variabil? de mediu.

accept g_modalitate prompt 'Introduceti modalitatea de plasare a comenzii'
variable g_nrsters varchar2(100)

begin 
delete from comenzi where modalitate = '&g_modalitate';
:g_nrsters := to_Char(SQL%rowcount) || ' comenzi sterse';
end;
/

print g_nrsters
rollback

--2. S? se afi?eze primele 10 comenzi care au cele mai multe produse comandate. 
--�n acest caz �nregistr?rile vor fi ordonate descresc?tor �n func?ie de num?rul produselor comandate.
--Facem in mod explicit folosind un cursor explicit

declare cursor c1 is select c.id_comanda, count(id_produs) nr_produse
                  from comenzi c, rand_comenzi rc
                  where c.id_comanda = rc.id_comanda
                  group by c.id_comanda
                  order by nr_produse desc;
vrec_comanda c1%rowtype;
begin
if not c1%isopen then
    open c1;
end if;
loop
    fetch c1 into vrec_comanda;
    exit when c1%notfound or c1%rowcount > 10;
    dbms_output.put_line('Comanda cu id-ul: ' || vrec_comanda.id_comanda || ' are ' || vrec_comanda.nr_produse || ' produse ');
    end loop;
close c1;
end;
/


--3. Utiliza?i un bloc PL/SQL pentru a afi?a pentru fiecare departament (id, denumire) valoarea total? a salariilor platite angaja?ilor.

declare
cursor dep_cursor is select d.id_departament, denumire_departament, sum(salariul) sal_total
              from departamente d, angajati a
              where d.id_departament = a.id_departament
              group by denumire_departament, d.id_departament;
begin
for dep_rec in dep_cursor
 loop
    dbms_output.put_line('Departamentul cu id-ul: ' || dep_rec.id_departament || ' plateste ' || dep_rec.sal_total || ' in salarii ');
end loop;
end;
/

--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!RESTUL TEMA!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

--Sa se realizeze 6 blocuri PL/SQL in care sa exemplificati utilizarea structurilor fundamentale(if, case, for, etc.) si cursori
--Asta e parte din proiect
--Sa includa descrierea si schema bazei de date(ca in primul semestru), enuntul rezolvarii, codul rezolvarii si printscreen cu rezultatul

--4. Realiza?i un bloc PL/SQL care sa afi?eze informa?ii despre angaja?i ?i num?rul de comenzi intermediat de ace?tia

--5. S? se creeze un bloc PL/SQL prin care s? se afi?eze pentru fiecare angajat ( id, nume) detalii cu privire la comenzile intermediate de c?tre acesta.

