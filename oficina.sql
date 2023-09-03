CREATE DATABASE Oficina;
USE Oficina;

DROP DATABASE Oficina;

-- VEICULO
CREATE TABLE Veiculo(
	idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    Placa CHAR(7) NOT NULL,
    idRevisao INT,
    CONSTRAINT placa_idVeiculo UNIQUE (idVeiculo, Placa),
    CONSTRAINT fk_conserto FOREIGN KEY (idVeiculo) REFERENCES Conserto(idConserto),
    CONSTRAINT fk_revisao FOREIGN KEY (idRevisao) REFERENCES Revisao(idRevisao);
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
CREATE TABLE DonoVeiculo(
	idDonoVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    cpf CHAR(11) NOT NULL,
    endereco VARCHAR(45),
    fone CHAR(11),
    CONSTRAINT fk_idClientes_pf FOREIGN KEY (idDonoVeiculo) REFERENCES Clientes(idClientes),
    CONSTRAINT fk_clinte_pf FOREIGN KEY (idClientePf) REFERENCES Clientes(idClientes),
    CONSTRAINT fk_veiculo_pf FOREIGN KEY (idDonoVeiculo) REFERENCES Veiculo(idVeiculo);
);

DESC DonoVeiculo;

-- MECANICO
CREATE TABLE Mecanico(
	idMecanico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    endereco VARCHAR(45) NOT NULL,
    Especialidade VARCHAR(45) NOT NULL
);

DESC Mecanico;

-- CONSERTO
CREATE TABLE Conserto(
	idConserto INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(45) NOT NULL
);

DESC Conserto;

-- Revisao
CREATE TABLE Revisao(
	idRevisao INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(45) NOT NULL
);

DESC Revisao;

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
    dataEmissao DATE,
    valorServiço FLOAT NOT NULL,
    valorPeça FLOAT NOT NULL,
    valorTotal FLOAT NOT NULL,
    status ENUM('AGUARDANDO', 'EM ANDAMENTO', 'CONCLUIDO', 'CANCELADO'),
    dataconclusao DATE
);

SELECT * FROM Ordem_Servico ORDER BY dataEmissao;
SELECT * FROM Ordem_Servico ORDER BY valorTotal;
DESC Ordem_Servico;

-- preços
CREATE TABLE Preco(
	idPreco INT AUTO_INCREMENT PRIMARY KEY,
    CONSTRAINT fk_referencia_precos FOREIGN KEY (idPreco) REFERENCES Ordem_Servico(idOrdem_Servico)
);

DESC Preco;

-- Autorizacao do cliente (status)
CREATE TABLE Autorizacao(
	idAutorizacao INT AUTO_INCREMENT PRIMARY KEY,
	Autorizado BOOL DEFAULT FALSE,
    CONSTRAINT fk_Autorizacao_cliente FOREIGN KEY (idAutorizacao) REFERENCES Clientes(idClientes),
    CONSTRAINT fk_Autorizacao_veiculo FOREIGN KEY (idAutorizacao) REFERENCES Veiculo(idVeiculo),
    CONSTRAINT fk_Autorizacao_Ordem_Servico FOREIGN KEY (idAutorizacao) REFERENCES Ordem_Servico(idOrdem_Servico)
);

DESC Autorizacao;

-- peças
CREATE TABLE Pecas(
	idPecas INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(45),
    valor FLOAT NOT NULL
);

DESC Pecas;

-- Ordem peças
CREATE TABLE Ordem_Pecas(
	idOrdem_Pecas INT AUTO_INCREMENT PRIMARY KEY,
	CONSTRAINT fk_pecas FOREIGN KEY (idOrdem_Pecas) REFERENCES Pecas(idPecas),
    CONSTRAINT fk_os_pecas FOREIGN KEY (idOrdem_Pecas) REFERENCES Ordem_Servico(idOrdem_Servico)
);

DESC Ordem_Pecas;
