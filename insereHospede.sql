create or replace function insereHospede(qntHospedes int, idadeMin int, idadeMax int) returns varchar(50) as
$$
declare
_idadeMin int := 19;
_idadeMax int := 64;
_qntHospedes int := qntHospedes;
_retorno varchar(50) := '';
i int := 1;
_nome varchar (50) := '';
_sobrenome varchar (90) := '';
_data date;
_nomeCompleto varchar (100) := '';
_cidade varchar (50) := '';

begin
for i in 1.. _qntHospedes loop
	if idadeMin >= _idadeMin and idadeMax <= _idadeMax then
		select nomes.nome into _nome from nomes order by random() limit 1;
		select sobrenome into _sobrenome from sobrenomes order by random() limit 1;
		_nomeCompleto = _nome || ' ' || _sobrenome;
		select datas_de_nascimento into _data from datas_de_nascimento order by random() limit 1;
		select cidades.nome into _cidade from cidades order by random() limit 1;
		
		insert into hospede (nome, cidade, datanascimento) values (_nomeCompleto, _cidade, _data);
		_retorno = 'Hóspede Cadastrado.';
	else
		raise exception 'Erro ao inserir! Idade mínima ou máxima inválidas!';
	end if;
end loop;
return _retorno;
end;

$$ language plpgsql;

