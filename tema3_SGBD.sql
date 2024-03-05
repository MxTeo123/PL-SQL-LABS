--1
create or replace procedure ieftinire(p_pret in number, p_numar out number)
is 
e exception;
begin
update produs
set pret = 0.9*pret
where pret >p_pret;
if sql%found then 
p_numar := sql%rowcount;
else
raise e;
end if;
exception
when e then
p_numar := 0;
end;

declare
nr_produse number;
begin
ieftinire(&id, nr_produse);
if nr_produse != 0 then
DBMS_OUTPUT.PUT_LINE('am modificat pretul pentru ' || nr_produse ||' produse');
else
DBMS_OUTPUT.PUT_LINE('Pretul nu s a putu modifica!');
end if;
end;

--2
create or replace function categorii(p_id produs.id_produs%type)
return varchar2
is
v_pret produs.pret%type;
begin
select pret into v_pret from produs where id_produs = p_id;
if v_pret<300 then
return 'ieftin';
elsif v_pret between 300 and 500 then
return 'produs scumput';
else return 'produs scump';
end if;
exception
when no_data_found then
return 'nu exista produsul';
end;

declare 
v_func varchar2(32767); 
begin 
v_func := categorii(&id); 
dbms_output.put_line(v_func); 
end;
/

--3
create or replace function tip_comanda(p_id rand_comanda.id_comanda%type)
return varchar2
is
v_cantitate rand_comanda.cantitate%type;
begin
select cantitate into v_cantitate from rand_comanda where id_comanda = p_id;
if v_cantitate<2 then
return 'comanda simpla';
elsif v_cantitate <4 then
return 'comanda mica';
else return 'comanda mare';
end if;
exception
when no_data_found then
return 'nu exista produsul';
end;

declare 
v_func varchar2(32767); 
begin 
v_func := tip_comanda(&id); 
dbms_output.put_line(v_func); 
end;
/

--4
create or replace procedure ieftinire(p_pret in number, p_numar out number)
is 
e exception;
begin
update produs
set pret = 0.9*pret
where pret >p_pret;
if sql%found then 
p_numar := sql%rowcount;
else
raise e;
end if;
exception
when e then
p_numar := 0;
end;

--5
create or replace procedure print_contact(p_id NUMBER)
is
  r_contact client%ROWTYPE;
begin
  select *
  into r_contact
  from client
  where id_client = p_id;
    dbms_output.put_line( r_contact.nume || ' ' ||r_contact.prenume || ' ' || r_contact.mail ||' '|| r_contact.nr_tel );
    end;

exec print_contact(&id);

--6
create or replace function pretul_comenzii(p_id rand_comanda.id_comanda%type) 
  return varchar2 
is 
  v_pret rand_comanda.pret%type; 
begin 
select pret into v_pret from rand_comanda where id_comanda = p_id; 
if v_pret < 500 then 
return 'comanda ieftina'; 
elsif v_pret < 1000 then 
return 'comanda medie'; 
else 
return 'comanda scumpa'; 
end if; 
exception 
when no_data_found then 
return 'nu exista produsul'; 
end;
/


declare 
v_func varchar2(32767); 
begin 
v_func := pretul_comenzii(&id); 
dbms_output.put_line(v_func); 
end;
/


