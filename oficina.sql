CREATE DATABASE Oficina;
USE Oficina;

DROP DATABASE Oficina;

-- VEICULO
CREATE TABLE Veiculo(
	idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    Placa CHAR(7) NOT NULL,
    idRevisão INT,
    CONSTRAINT placa_idVeiculo UNIQUE (idVeiculo, Placa),
    CONSTRAINT fk_conserto FOREIGN KEY (idVeiculo) REFERENCES Conserto(idConserto),
    CONSTRAINT fk_revisao FOREIGN KEY (idRevisão) REFERENCES Revisao(idRevisão);
);

DESC Veiculo;

-- CLIENTES
CREATE TABLE Clientes(
	idClientes INT AUTO_INCREMENT PRIMARY KEY,
    idVeiculo INT,
    CONSTRAINT fk_veiculo FOREIGN KEY (idVeiculo) REFERENCES Veiculo(idVeiculo)
);

DESC Clientes;

-- PESSOA FISICA
CREATE TABLE PessoaFisica(
	idPessoaFisica INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    cpf CHAR(11) NOT NULL,
    endereco VARCHAR(45),
    fone CHAR(11),
    CONSTRAINT fk_idClientes_pf FOREIGN KEY (idPessoaFisica) REFERENCES Clientes(idClientes),
    CONSTRAINT fk_clinte_pf FOREIGN KEY (idClientePf) REFERENCES Clientes(idClientes),
    CONSTRAINT fk_veiculo_pf FOREIGN KEY (idPessoaFisica) REFERENCES Veiculo(idVeiculo);
);

DESC PessoaFisica;

-- PESSOA JURIDICA
CREATE TABLE PessoaJuridica(
	idPessoaJuridica INT AUTO_INCREMENT PRIMARY KEY,
    cnpj CHAR(15) NOT NULL,
    endereco VARCHAR(45),
    fone CHAR(11),
    CONSTRAINT unique_cnpj_PessoaJuridica UNIQUE (cnpj),
    CONSTRAINT fk_clientes_pj FOREIGN KEY (idPessoaJuridica) REFERENCES Clientes(idClientes),
    CONSTRAINT fk_veiculo_pj FOREIGN KEY (idPessoaJuridica) REFERENCES Veiculo(idVeiculo);
);

DESC PessoaJuridica;

-- CONSERTO
CREATE TABLE Conserto(
	idConserto INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(45) NOT NULL
);

DESC Conserto;

-- REVISÃO
CREATE TABLE Revisão(
	idRevisão INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(45) NOT NULL
);

DESC Revisão;

-- MECANICO
CREATE TABLE Mecanico(
	idMecanico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    endereco VARCHAR(45) NOT NULL,
    Especialidade VARCHAR(45) NOT NULL
);

DESC Mecanico;

-- ORDEM DE SERVIÇO
CREATE TABLE Ordem_Servico(
	idOrdem_Servico INT AUTO_INCREMENT PRIMARY KEY,
    dataEmissao DATE,
    valorServiço FLOAT NOT NULL,
    valorPeça FLOAT NOT NULL,
    valorTotal FLOAT NOT NULL,
    Status ENUM('AGUARDANDO', 'EM ANDAMENTO', 'CONCLUIDO', 'CANCELADO'),
    dataconclusao DATE
);

SELECT * FROM Ordem_Servico ORDER BY dataEmissao;
SELECT * FROM Ordem_Servico ORDER BY valorTotal;
DESC Ordem_Servico;

-- REFERENCIA DE PREÇOS
CREATE TABLE ReferenciaPreços(
	idReferenciaPreços INT AUTO_INCREMENT PRIMARY KEY,
    CONSTRAINT fk_referencia_precos FOREIGN KEY (idReferenciaPreços) REFERENCES Ordem_Servico(idOrdem_Servico)
);

DESC ReferenciaPreços;

-- autorizacao CLIENTE
CREATE TABLE autorizacao(
	idautorizacao INT AUTO_INCREMENT PRIMARY KEY,
	Autorizado BOOL DEFAULT FALSE,
    CONSTRAINT fk_autorizacao_cliente FOREIGN KEY (idautorizacao) REFERENCES Clientes(idClientes),
    CONSTRAINT fk_autorizacao_veiculo FOREIGN KEY (idautorizacao) REFERENCES Veiculo(idVeiculo),
    CONSTRAINT fk_autorizacao_Ordem_Servico FOREIGN KEY (idautorizacao) REFERENCES Ordem_Servico(idOrdem_Servico)
);

DESC autorizacao;

-- PEÇAS
CREATE TABLE Pecas(
	idPecas INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(45),
    valor FLOAT NOT NULL
);

DESC Pecas;

-- OS PEÇAS
CREATE TABLE Ordem_Pecas(
	idOrdem_Pecas INT AUTO_INCREMENT PRIMARY KEY,
	CONSTRAINT fk_pecas FOREIGN KEY (idOrdem_Pecas) REFERENCES Pecas(idPecas),
    CONSTRAINT fk_os_pecas FOREIGN KEY (idOrdem_Pecas) REFERENCES Ordem_Servico(idOrdem_Servico)
);

DESC Ordem_Pecas;

-- Servicos
CREATE TABLE Servicos(
	idServicos INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(45),
    valor FLOAT NOT NULL
);

DESC Servicos;

-- ORDEM DE SERVIÇO
CREATE TABLE Ordem_Servico(
	idOrdem_Servico INT AUTO_INCREMENT PRIMARY KEY,
    CONSTRAINT fk_Servicos FOREIGN KEY (idOrdem_Servico) REFERENCES Servicos(idServicos),
    CONSTRAINT fk_os_Servicos FOREIGN KEY (idOrdem_Servico) REFERENCES Ordem_Servico(idOrdem_Servico)
);

DESC Ordem_Servico;