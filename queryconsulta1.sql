
--consulta 1

SELECT
    T.NOME_HOSPEDE,
    T.NOME_ATENDENTE,
    T.numQuarto,
    T.VALOR
FROM
(
        SELECT
            A.nome AS NOME_HOSPEDE,
            B.nome AS NOME_ATENDENTE,
            C.numQuarto,
            C.valorDiaria * count(C.codHospedagem) AS VALOR
        FROM
            hospede A
            INNER JOIN hospedagem C ON A.codHospede = C.codHospede
            INNER JOIN atendente B ON C.codatendente = B.codAtendente
        WHERE
            C.datasaida IS NOT NULL
            AND DATE_PART('year', current_date) - DATE_PART('year', A.datanascimento) = 21
            AND C.dataEntrada >= (
				SELECT 
					min(dataEntrada)
				FROM
					hospedagem
					INNER JOIN hospede on hospedagem.codHospede = hospede.codHospede
					WHERE
						date_part('year', hospedagem.dataEntrada) - date_part('year', hospede.datanascimento) BETWEEN 40 and 45
				)
			AND c.dataEntrada <=(
				SELECT
					max(dataEntrada)
				FROM
					hospedagem
					INNER JOIN hospede on hospedagem.codHospede = hospede.codHospede
				WHERE
					date_part('year', hospedagem.dataEntrada)- date_part('year', hospede.datanascimento) BETWEEN 40 and 45
			)
        GROUP BY
            A.nome,
            B.nome,
            C.numQuarto,
            C.valorDiaria
    ) T

ORDER BY
    T.VALOR DESC LIMIT 10;
	



     

