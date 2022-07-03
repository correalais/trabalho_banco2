SELECT 
	cidade, COALESCE(SUM((datasaida - dataentrada) * valordiaria), 0) AS "Valor Investido"
FROM hospede, hospedagem
WHERE
	hospedagem.codhospede = hospede.codhospede
AND 
	COALESCE(datasaida - dataentrada, 0) <= 90

GROUP BY cidade
ORDER BY "Valor Investido" desc