--consulta 3


select distinct hospede.nome, sum((hospedagem.datasaida - hospedagem.dataentrada) * valordiaria) as "Valor Total",

case

	when sum((hospedagem.datasaida - hospedagem.dataentrada) * valordiaria) between 0 and 1000 then

		'E'

	when sum((hospedagem.datasaida - hospedagem.dataentrada) * valordiaria) between 1000.1 and 3000 then

		'D'

	when sum((hospedagem.datasaida - hospedagem.dataentrada) * valordiaria) between 3000.1 and 7000 then

		'C'

	when sum((hospedagem.datasaida - hospedagem.dataentrada) * valordiaria) between 7000.1 and 10000 then

		'B'

	when sum((hospedagem.datasaida - hospedagem.dataentrada) * valordiaria) > 10000 then

		'A'

end classe

from hospedagem, hospede	

where hospede.codhospede = hospedagem.codhospede and

EXTRACT(YEAR FROM dataentrada) = 2010 and

( (hospede.cidade like 'A%' or hospede.cidade like '%M') or

hospede.nome like 'Fabio%')and

hospedagem.datasaida - hospedagem.dataentrada <=30

group by nome



