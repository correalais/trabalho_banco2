SELECT 
	cidade, COALESCE(SUM((datasaida - dataentrada) * valordiaria), 0) AS "Valor Investido"
	
FROM hospede, hospedagem
WHERE
	hospedagem.codhospede = hospede.codhospede
AND 
	COALESCE(datasaida - dataentrada, 0) <= 90
	
AND (SELECT * FROM calculaDiaria())

GROUP BY cidade, datasaida
ORDER BY "Valor Investido" desc

------------------------------------

create or replace function calculaDiaria()  returns boolean as
$$
declare
data_saida date;

begin
select datasaida into data_saida from hospede, hospedagem where hospedagem.codhospede = hospede.codhospede;
if data_saida is not null then
	perform (CURRENT_DATE - dataentrada)  * valordiaria from hospede, hospedagem where hospedagem.codhospede = hospede.codhospede;
	return true;
else
	return false;
end if;
end;
$$
language plpgsql;

select * from calculaDiaria()