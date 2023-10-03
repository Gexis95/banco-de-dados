--DDL Linguaguem de Definição de Dados (interagir com a tabela)

--Comando para seleção
	SELECT * FROM produtos ORDER BY id ASC;


--Criação de tabela
	CREATE TABLE produtos(
		id INT PRIMARY KEY NOT NULL,
		nome VARCHAR(255),
		preco DECIMAL(10,2)
);


--Excluir uma tabela
	DROP TABLE produtos;


--Alterar tabela, adiciona coluna
	ALTER TABLE produtos ADD descricao TEXT;
--Excluir coluna
	ALTER TABLE produtos DROP descricao;


--DML - Linguagem de Manipulação de Dados(Interagir com a Linha)

--Inserir dados na tabela
	INSERT INTO produtos(id, nome, preco) VALUES
		(1, 'Nescau Radical', 8.00), (2, 'Yakult Activia', 4.00),
		(3, 'Alpino Amargo', 8.00), (4, 'Miojo Monica', 1.75);


--Alterar dados na tebela
	UPDATE produtos SET preco = 15.00 WHERE id=1;
	UPDATE produtos SET nome = 'Toddy' WHERE nome LIKE 'Nescau Radical';
	UPDATE produtos SET descricao = 'Armazenar em ambiente gelado' WHERE id=2 or id=3;
	UPDATE produtos SET descricao = 'promocao' WHERE preco < 5.00;


--Deletar dados de uma tabela
	DELETE FROM produtos WHERE nome LIKE 'Alpino amargo';
	DELETE FROM produtos WHERE id= 1


--Comandos DQL (Linguagem de consulta de dados)
--Selecionar todos(*) produtos, ordene ascendente
	SELECT * FROM produtos ORDER BY ASC;

--Ordernar pelo preço crescente(menor para maior)
	SELECT * FROM produtos ORDER BY preco ASC;

--Ordernar pelo preço decrescente(maior para menor)
	SELECT * FROM produtos ORDER BY preco DESC;

--Selecionar Colunas
	SELECT nome, preco FROM produtos ORDER BY id;

--Selecionar produtos maiores que  4,00R$
	SELECT preco, nome FROM produtos WHERE preco > 4.00;

--Selecionar produto mais caro
	SELECT MAX(preco) AS maior_valor FROM  produtos;
	SELECT preco, nome FROM produtos ORDER BY preco DESC LIMIT 1;

--Simulando busca por nome exato
	SELECT * FROM produtos WHERE nome LIKE 'Nescau Radical';

--Busca pelos primeiros caracteres, o resto não importa
	SELECT * FROM produtos WHERE nome LIKE 'A%';

--Busca pelos ultimos caracteres, o resto não importa
	SELECT * FROM produtos WHERE nome LIKE '%a';

--Busca em qualquer parte do nome
	SELECT * FROM produtos WHERE nome LIKE '%a%';
	
	
									------------------PARTE 2------------------
									
--Criando tabela Funcionário
CREATE TABLE funcionario(
	id SERIAL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	data_nasc DATE,
	sexo CHAR(1), 
	salario DECIMAL (10,2),
 	ativo BOOLEAN
);

SELECT * FROM funcionario;

INSERT INTO funcionario (nome, data_nasc, sexo, salario, ativo) VALUES
('Bob', '1990-05-15', 'M', 2000.00, true),
('Augusto', '1970-04-01', 'M', 1500.00, false),
('Joanir', '2000-01-01', 'F', 1800.00, true),
('Elisa', '1995-10-02', 'F', 1900.00, true);

--Seleciona os funcionarios que nasceream após 01/01/1992 (as datas são invertidas no sql)
SELECT * FROM funcionario WHERE data_nasc > '1992-01-01';

--Seleciona funcionarios em um período
SELECT nome, data_nasc FROM funcionarios 
WHERE data_nasc BETWEEN '1990-01-01' AND '1997-01-01'

--Contabilizar
SELECT sexo, COUNT(*) AS total_pessoas, AVG(salario)
AS media_salarial FROM funcionario GROUP BY sexo;


									------------------ATIVIDADES------------------
									
--1.Criar uma tabela "clientes" com campos para ID, Nome e email.
--2.Adicionar uma coluna "telefone" à tabela "Clientes" usando ALTER TABLE.
--3.Remover a coluna "email" da tabela "clientes" usando ALTER TABLE.
--4.Criar uma tabela "itens" com campos para ID, nome e preço.
--5.Inserir um novo cliente na tabela "clientes" INSERT.
--6.Inserir 3 novos produtos na tabela"itens" INSERT.
--7.Atualizar o nome de um cliente na tabela "clientes" UPDATE.
--8.Atualizar o preço de um item na tabela "itens" UPDATE.
--9.Excluir um cliente da tabela "clientes" DELETE.
--10.Excluir um item da tabela "itens" DELETE.


--(1)R:
CREATE TABLE clientes(
	id SERIAL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	email VARCHAR (255)
);

--(2)R:
ALTER TABLE clientes ADD telefone DECIMAL(20);

--(3)R:
ALTER TABLE clientes DROP email;

--(4)R:
CREATE TABLE itens(
	id SERIAL PRIMARY KEY,
	nome VARCHAR(255),
	preco DECIMAL(10,2)
);

--(5)R:
INSERT INTO clientes (nome, telefone) VALUES
	('romario', 4499952346), ('nelson', 40028922);

--(6)R:
INSERT INTO itens(nome, preco) VALUES
	('doritos', 07.99), ('baunilha', 23.50),
	('sucrilhos', 11.49);

--(7)R:
UPDATE clientes SET nome = 'gabriel' WHERE nome LIKE 'romario';

--(8)R:
UPDATE itens SET preco = 15.00 where id=2;

--(9)R:
DELETE FROM clientes WHERE id=1;

--(10)R:
DELETE FROM itens WHERE ID=2;

							 		------------------PARTE4------------------
							--Entendendo relacionamento entre tabelas no banco de dados--
							
--Criação das tabelas
CREATE TABLE estados(
	id_estado SERIAL PRIMARY KEY,
	nome_estado VARCHAR(50) NOT NULL,
	sigla CHAR(2)
);

CREATE TABLE cidades(
	id_cidade SERIAL PRIMARY KEY,				--PK chave primaria primary key
	nome_cidade VARCHAR(50) NOT NULL,
	cep varchar(20),
	id_estado INT REFERENCES estados(id_estado)	--FK chave estrangeira foreing key
);

--Inserindo dados nas tabelas
INSERT INTO estados(id_estado, nome_estado, sigla) VALUES
	(1, 'Paraná', 'PR'), (2, 'São Paulo', 'SP'),
	(3, 'Minas Gerais', 'MG');
	
INSERT INTO cidades (id_cidade, nome_cidade, cep, id_estado) VALUES
	(10, 'Nova Londrina', '87970-000', 1),
	(11, 'Marilena', '87960-000', 1),
	(12, 'Itaúna', '87980-000', 1),
	(13, 'Primavera', '19273-000', 2),
	(14, 'Rosana', '19274-000', 2),
	(15, 'Cachoeira da Prata', '35765-000', 3);
	

--Selecionar todas as cidades e seus estados
SELECT cidades.nome_cidade, estados.nome_estado
FROM estados INNER JOIN cidades 
ON cidades.id_estado = estados.id_estado;

--Selecionar todas as cidades do paraná
SELECT cidades.nome_cidade, estados.sigla
FROM estados INNER JOIN cidades
ON cidades.id_estado = estados.id_estado
WHERE estados.sigla LIKE 'PR'
ORDER BY cidades.nome_cidade ASC;

--Seleciona os estados com mais cidades
SELECT estados.nome_estado, COUNT(cidades.id_cidade) AS total_cidades
FROM estados INNER JOIN cidades
ON estados.id_estado = cidades.id_estado
GROUP BY estados.nome_estado
ORDER BY  total_cidades DESC;

--Criação de tabela para relacionamento de cidade-estado
CREATE TABLE pessoa(
	id_pessoa SERIAL PRIMARY KEY,
	nome_pessoa VARCHAR(60),
	data_nascimento DATE,
	sexo CHAR(1),
	estado_civil VARCHAR(60),
	profissao VARCHAR(60),
	id_cidade INT REFERENCES cidades(id_cidade)
);

INSERT INTO pessoa (id_pessoa, nome_pessoa, data_nascimento, sexo, estado_civil, profissao, id_cidade) VALUES
	(1, 'Marcele', '2000-01-01', 'f', 'solteira', 'Arquiteta', 10),
	(2, 'Ananias', '1980-02-20', 'm', 'casado', 'Carpinteiro', 10),
	(3, 'Silvio', '1950-10-10', 'm', 'casado', 'Dublador', 11),
	(4, 'Léo', '2001-01-02', 'm', 'casado', 'Entregador', 11),
	(5, 'Chris', '1990-05-05', 'm', 'solteiro', 'Fisiculturista', 12),
	(6, 'Ana', '1997-04-01', 'f', 'solteira', 'Cantora', 13),
	(7, 'Jaime', '1970-03-01', 'm', 'casado', 'Carteiro', 14),
	(8, 'Alice', '2002-01-10', 'f', 'solteira', 'Advogada', 15),
	(9, 'Valentina', '1995-05-03', 'f', 'solteira', 'Zootecnista', 15),
	(10, 'Laura', '1998-05-09', 'f', 'solteira', 'Balconista', 15);
	
SELECT pessoa.nome_pessoa, cidades.nome_cidade, estados.nome_estado
FROM pessoa INNER JOIN cidades
ON pessoa.id_cidade = cidades.id_cidade
INNER JOIN estados
ON cidades.id_estado = estados.id_estado;

--Seleciona pessoas do Estado do Paraná
SELECT pessoa.nome_pessoa, estados.nome_estado, cidades.nome_cidade
FROM estados INNER JOIN cidades
ON estados.id_estado = cidades.id_estado
INNER JOIN pessoa
ON cidades.id_cidade = pessoa.id_cidade
WHERE estados.nome_estado LIKE 'Paraná'; 

--Selecione o nome da pessoa, profissão e qual cidade pertence
SELECT pessoa.nome_pessoa, cidades.nome_cidade, pessoa.profissao
FROM pessoa INNER JOIN cidades
ON pessoa.id_cidade = cidades.id_cidade;

--Seleciona a cidade com mais homem/mulher
SELECT cidades.nome_cidade, COUNT(*) AS Quantidade
FROM cidades INNER JOIN pessoa
ON cidades.id_cidade = pessoa.id_cidade
WHERE pessoa.sexo = 'm'
GROUP BY cidades.id_cidade
ORDER BY Quantidade desc;

									------------------ATIVIDADES------------------
									
--1.Selecione todas as pessoas
--2.Selecione todas as pessoas do sexo masculino "m"
--3.Selecione todas as pessoas que estão solteiras
--4.Selecione as pessoas e suas profissões
--5.Selecione as pessoas que nasceram entre 1980 e 2000
--6.Selecione as pessoas que são do Estado de São Paulo


--(1)R:
--forma lenta
SELECT * FROM pessoa;
--forma rápida
SELECT pessoa.nome_pessoa FROM pessoa;

--(2)R:
SELECT pessoa.nome_pessoa FROM pessoa WHERE pessoa.sexo = 'm';

--(3)R:
SELECT pessoa.nome_pessoa, pessoa.estado_civil FROM pessoa WHERE estado_civil LIKE 'solteir%';

--(4)R:
SELECT pessoa.nome_pessoa, pessoa.profissao FROM pessoa;

--(5)R:
SELECT pessoa.nome_pessoa, pessoa.data_nascimento FROM pessoa
WHERE pessoa.data_nascimento BETWEEN '1980-01-01' AND '2000-01-01';

--(6)R:
SELECT pessoa.nome_pessoa, estados.nome_estado
FROM estados INNER JOIN cidades
ON estados.id_estado = cidades.id_estado
INNER JOIN pessoa
ON cidades.id_cidade = pessoa.id_cidade
WHERE estados.nome_estado LIKE 'São Paulo'; 

--forma do luiz
SELECT pessoa.nome_pessoa, estados.nome_estado
FROM pessoa INNER JOIN cidades
ON pessoa.id_cidade = cidades.id_cidade
INNER JOIN estados
ON cidades.id_estado = estados.id_estado
WHERE estados.nome_estado LIKE 'São Paulo'