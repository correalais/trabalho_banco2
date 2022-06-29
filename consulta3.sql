create or replace function consulta3() returns table (NomeHospede varchar (50), precoTotalDias decimal(9,2), classe varchar (100)) as
$$
declare
soma decimal (9,2) := 0;
tempo int := 0;
idadeData int := 0;
classe varchar (10) := '';
qtdHospede bigint := 0;
i int := 0;
nome varchar (50) := '';

begin

	for hospedes in select distinct * from hospede loop
		for hospedagens in select distinct * from hospedagem loop
		--select  into soma from hospedagens;

		if (hospedagens.datasaida - hospedagens.dataentrada) * hospedagens.valordiaria between 0 and 1000 then
			classe = 'E';
			insert into consulta_3 (nomehospede, precototaldias, classe) values (hospedes.nome, (hospedagens.datasaida - hospedagens.dataentrada) * hospedagens.valordiaria, classe);
		elsif (hospedagens.datasaida - hospedagens.dataentrada) * hospedagens.valordiaria between 1001 and 3000 then
		classe = 'D';
			insert into consulta_3 (nomehospede, precototaldias, classe) values (hospedes.nome, (hospedagens.datasaida - hospedagens.dataentrada) * hospedagens.valordiaria, classe);
		
		end if;
	end loop;
	end loop;
return query select * from consulta_3;
end;
$$ language plpgsql;

select distinct * from consulta3()

select * from consulta_3
create table consulta_3 (
	nomehospede varchar(50) not null,
	precototaldias decimal(10,2) not null,
	classe varchar (5)
)	

drop table consulta_3

