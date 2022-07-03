SELECT COALESCE
	(SUM((datasaida - dataentrada) * valordiaria), 0) AS Soma,
	EXTRACT(YEAR FROM datasaida) AS Ano,
	EXTRACT(MONTH FROM datasaida) AS Mês,
	(SELECT UPPER 
	 	(nome) from atendente where codatendente = 1) AS "Nome Superior" 
FROM 
	hospedagem, atendente
WHERE
	hospedagem.codatendente = atendente.codatendente
AND 
	atendente.codsuperior = 1  
AND
	EXTRACT(MONTH FROM datasaida) <> 6 
AND 
	EXTRACT(MONTH FROM datasaida) <> 7
AND 
	EXTRACT(YEAR FROM datasaida) = 2010
AND 
	datasaida - dataentrada <= 10
	
GROUP BY hospedagem.datasaida, atendente.nome
ORDER BY Mês, Ano, datasaida ASC
