/*1. Realizati un pachet care sa contina:

- o functie care returneaza numarul de comenzi încheiate de catre un client al carui id este dat ca parametru. Tratati cazul în care nu exista clientul specificat;

- o procedura care foloseste functia de mai sus pentru a returna primii 3 clienti cu cele mai multe comenzi încheiate.

Sa se apeleze procedura din cadrul pachetului.*/
set serveroutput on
/*create or replace package exercitiul1
is
function
 nr_com(id number) return number;
 procedure top_clienti;
 end; */
 create or replace package body exercitiul1
 is 
 function nr_comenzi(id number) return number
 is
 nrcom number;
 no_comenzi exception;
 nr_client number;
 begin 
 select 1 into nr_client from clienti where id_client=id;
 select count(id_client) into nrcom from comenzi where id_client=id;
 if(nrcom=0) then
 raise no_comenzi;
 else return nrcom;
 end if;
 exception when no_data_found then 
 return 0;
 when no_comenzi then 
 return -1;
 end;
 procedure top_clienti
 is
 cursor c_clienti is select id_client, nume_client, nr_comenzi(id_client) nr_de_comenzi
 from clienti 
 order by nr_de_comenzi desc
 fetch first 3 rows only;
 begin
 for rec_clienti in c_clienti loop
 dbms_output.put_line(rec_clienti.id_client||' '||rec_clienti.nume_client||' '||rec_clienti.nr_de_comenzi);
 end loop;
 end;
 end;
 

begin
exercitiul1.top_clienti;
end;
 
 









/*2. Realizati un pachet de subprograme care sa contina:

- o functie care verifică dacă un anumit id al unei functii există deja în tabela Functii si returnează True atunci când există, False când nu.

- o procedura  care sa adauge o înregistrare noua în tabela Functii. Parametrii procedurii se refera la Informatiile ce trebuie adaugate). Se trateaza cazul în care exista deja o functie cu id-ul introdus, folosind funcția de verificare.

- o  procedura care sa modifice denumirea unei functii. Folosim ca parametri id-ul functiei pentru care actualizam si noua denumire. Se trateaza cazul în care nu se realizeaza modificarea nu are loc din cauza faptului ca id-ul precizat nu se regaseste în tabela (folositi functia).

- o procedura care sa stearga o functie pe baza id-ului primit drept parametru. Se trateaza cazul în care id-ul furnizat nu exista.

Sa se apeleze subprogramele din pachet.*/