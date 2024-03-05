
SET SERVEROUTPUT ON
--1
--afisarea produselor cu pret mai mare de 500
declare
CURSOR c1 is select * from rand_comanda;
begin
for i in c1 loop
if i.pret>500 then
DBMS_OUTPUT.PUT_LINE(i.id_produs||' '|| i.pret);
end if;
end loop;
end;
/



--2
--metoda de plata a unui client cu id ul de la tastatura
declare
cursor c1 is select * from comanda;
v_id comanda.id_comanda%type:=&id;
begin
for i in c1 loop
if v_id=i.id_comanda then
DBMS_OUTPUT.PUT_LINE(i.id_comanda||' '||i.metoda_plata );
end if;
end loop;
end;

--3
--primele 5 produse cu pret mai mare de 200
declare
contor number;
cursor c1 is select * from produs;
begin
for i in c1 loop
if i.pret >200 then 
contor:=contor+1;
DBMS_OUTPUT.PUT_LINE(i.nume||' '||i.descriere );
exit when contor=5;
end if;
end loop;
end;
/

--4
--comenzi cu mai mult de 2 produse
declare
cursor c1 is select* from rand_comanda;
v_cant rand_comanda.cantitate%type;
begin
for i in c1  loop
if i.cantitate >=2 then
DBMS_OUTPUT.PUT_LINE('comanda are '|| i.cantitate||' produse in valoare de '||i.pret ||'lei');
end if;
end loop;
end;
/

--5
--determinarea numelui unui client in functie de id
declare
cursor c1 is select * from client;
v_id client.id_client%type:=&id;
begin
for i in c1 loop
if v_id=i.id_client then 
DBMS_OUTPUT.PUT_LINE('persoana cu id-ul ' || i.id_client ||' are numele '|| i.nume);
end if;
end loop;
end;



--6
--10% reducere la produsele mai scumpe de 500
declare
cursor c1 is select * from produs;
v_pret produs.pret%type;
begin
for i in c1 loop
if i.pret>500 then
v_pret:=i.pret*0.9;
update produs set pret=v_pret where id_produs=i.id_produs;
end if;
end loop;
end;
/
rollback;


