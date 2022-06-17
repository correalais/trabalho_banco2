create or replace function consulta1() returns table (NomeHospede varchar (50), NomeAtendente varchar (50), numQuarto int, precoTotal decimal(9,2)) as
$$
declare
soma decimal (9,2) := 0;
idade int := 0;
tempo int := 0;

begin
	select (hospedagem.dataentrada - hospede.datanascimento)/365 into idade from hospedagem, hospede where hospedagem.codhospede = hospede.codhospede;
	select (hospedagem.datasaida - hospedagem.dataentrada) * valordiaria into soma from hospedagem, hospede where hospedagem.codhospede = hospede.codhospede;
	select hospedagem.datasaida - hospedagem.dataentrada into tempo from hospedagem, hospede where hospedagem.codhospede = hospede.codhospede;

	if tempo > 0 and idade > 21 then
		return query select hospede.nome, atendente.nome, hospedagem.numquarto, soma 
		from hospede, atendente, hospedagem
		where hospedagem.codhospede = hospede.codhospede and
		hospedagem.codatendente = atendente.codatendente;
	else
		raise exception 'Problemas';

	end if;

end;
$$ language plpgsql;

