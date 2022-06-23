create or replace function consulta5() returns table(Atendente VARCHAR(50), QtdAtendimentos bigint, Supervisor VARCHAR(50))
AS
$$
declare
supervisor VARCHAR(50) := '';
begin
	select nome into supervisor from atendente
	where codatendente = 1;
	return query SELECT atendente.nome, COUNT(hospedagem.codatendente), supervisor FROM atendente, hospedagem
		WHERE atendente.codatendente = hospedagem.codatendente
		AND current_date - datasaida <= 30
		GROUP BY atendente.nome, hospedagem.codatendente;

end;
$$ language plpgsql;

