create or replace function insereAtendente(qntAtendentes int) returns varchar(50) as
$$
declare
_qntAtendentes int := qntAtendentes;
_retorno varchar(50) := '';
i int := 1;
_nome varchar (50) := '';
_nomeCompleto varchar (100) := '';
_sobrenome varchar (50) := '';

begin
for i in 1.. _qntAtendentes loop
		select nomes.nome into _nome from nomes order by random() limit 1;
		select sobrenome into _sobrenome from sobrenomes order by random() limit 1;
		_nomeCompleto = _nome || ' ' || _sobrenome;
		
		insert into atendente (codsuperior, nome) values (1, _nomeCompleto);
		_retorno = 'Atendente Cadastrado.';
	
end loop;
return _retorno;
end;

$$ language plpgsql;


