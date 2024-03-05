--tema 2

set serveroutput on

--1)sa se modifice pretul produsului dupa id

declare
p_excep exception;
v_id produs.id_produs%type:=&id;
begin
update produs set pret=pret*1.05 where id_produs=v_id;
if sql%found then
DBMS_OUTPUT.PUT_LINE('produsul cu id-ul '|| v_id ||'a fost modificat cu succes');
else
raise p_excep;
end if;
exception 
when p_excep then
DBMS_OUTPUT.PUT_LINE('id introdus gresit');
end;








--2) sa se verifice daca exista un client cu id ul dat de la tastatura
declare
v_id client.id_client%type:=&id;
begin
select id_client into v_id from client
where id_client=v_id;
DBMS_OUTPUT.PUT_LINE('Client gasit');
exception
when others then
DBMS_OUTPUT.PUT_LINE('Clientul nu a fost gasit!');
end;


--3)
declare
v_idcom comanda.id_comanda%type:=&idcom;
v_idcl comanda.id_client%type:=&idcl;
v_metoda comanda.metoda_plata%type:=&met;
begin
insert into comanda(id_comanda, id_client, metoda_plata) values(v_idcom, v_idcl, v_metoda);
exception 
when others then
DBMS_OUTPUT.PUT_LINE('Un camp sau mai multe au fost introduse gresit!');
end;



--4)sa se adauge un produs nou
declare
begin
insert into produs(id_produs, nume, pret) values(NULL, 'Navigatie passat', 500);
exception
when others then
DBMS_OUTPUT.PUT_LINE('Eroare! id-ul nu poate fi null!');
end;
select* from produs;





