CREATE DATABASE EstacionamentoDB;
GO

USE EstacionamentoDB;
GO

CREATE TABLE Clientes (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(20) NULL
);
GO

CREATE TABLE Vagas (
    id INT IDENTITY(1,1) PRIMARY KEY,
    localizacao VARCHAR(50) NOT NULL,
    tipo VARCHAR(20) NULL
);
GO

CREATE TABLE Veiculos (
    id INT IDENTITY(1,1) PRIMARY KEY,
    cliente_id INT NOT NULL,
    placa VARCHAR(10) NOT NULL UNIQUE,
    modelo VARCHAR(50) NULL,
    cor VARCHAR(30) NULL,
    CONSTRAINT FK_Veiculo_Cliente
        FOREIGN KEY (cliente_id) REFERENCES Clientes (id)
        ON DELETE CASCADE
);
GO

CREATE TABLE RegistrosEstacionamento (
    id INT IDENTITY(1,1) PRIMARY KEY,
    veiculo_id INT NOT NULL,
    vaga_id INT NOT NULL,
    data_hora_entrada DATETIME NOT NULL,
    data_hora_saida DATETIME NULL,
    valor_total DECIMAL(10,2) NULL,
    CONSTRAINT FK_Registro_Veiculo
        FOREIGN KEY (veiculo_id) REFERENCES Veiculos (id),
    CONSTRAINT FK_Registro_Vaga
        FOREIGN KEY (vaga_id) REFERENCES Vagas (id)
);
GO

-- 1. INSERTS PARA A TABELA: Clientes (5 registros)
INSERT INTO Clientes (nome, cpf, telefone) VALUES
('André Silva', '11122233344', '11988887777'),
('Beatriz Souza', '22233344455', '11977776666'),
('Carlos Oliveira', '33344455566', '11966665555'),
('Daniela Lima', '44455566677', '11955554444'),
('Eduardo Santos', '55566677788', '11944443333');
GO

-- 2. INSERTS PARA A TABELA: Vagas (10 registros)
INSERT INTO Vagas (localizacao, tipo) VALUES
('Subsolo A - 01', 'Carro'),
('Subsolo A - 02', 'Carro'),
('Subsolo A - 03', 'Moto'),
('Subsolo A - 04', 'Idoso'),
('Subsolo B - 01', 'Carro'),
('Subsolo B - 02', 'Carro'),
('Subsolo B - 03', 'PCD'),
('Subsolo B - 04', 'Moto'),
('Piso Térreo - 01', 'Carro'),
('Piso Térreo - 02', 'Carro');
GO

-- 3. INSERTS PARA A TABELA: Veiculos (8 registros)
-- Mapeados para os IDs de clientes gerados (1 a 5)
INSERT INTO Veiculos (cliente_id, placa, modelo, cor) VALUES
(1, 'ABC1D23', 'Chevrolet Onix', 'Preto'),
(1, 'XYZ9W87', 'Honda CB 300', 'Vermelho'), -- André tem 2 veículos
(2, 'MNO3K45', 'Hyundai HB20', 'Branco'),
(3, 'QWE4R56', 'Toyota Corolla', 'Prata'),
(3, 'LJK1Z22', 'Yamaha Fazer', 'Azul'),     -- Carlos tem 2 veículos
(4, 'POI9U88', 'Fiat Uno', 'Quadrado'),
(5, 'ZXC7V66', 'Jeep Compass', 'Cinza'),
(5, 'KJH5G44', 'Ford Ka', 'Vermelho');      -- Eduardo tem 2 veículos
GO

-- 4. INSERTS PARA A TABELA: RegistrosEstacionamento (8 registros)
-- Mapeados para os IDs de veículos (1 a 8) e vagas (1 a 10)
INSERT INTO RegistrosEstacionamento (veiculo_id, vaga_id, data_hora_entrada, data_hora_saida, valor_total) VALUES
(1, 1, '2026-09-23 08:00:00', '2026-09-23 12:00:00', 20.00),
(2, 3, '2026-09-23 09:15:00', '2026-09-23 10:15:00', 5.00),
(3, 2, '2026-09-23 10:00:00', '2026-09-23 18:00:00', 40.00),
(4, 4, '2026-09-23 13:30:00', '2026-09-23 15:30:00', 12.00),
(5, 8, '2026-09-23 14:00:00', NULL, NULL), -- Veículo ainda estacionado
(6, 5, '2026-09-23 16:20:00', '2026-09-23 17:20:00', 8.00),
(7, 7, '2026-09-23 17:00:00', NULL, NULL), -- Veículo ainda estacionado
(8, 6, '2026-09-23 19:00:00', '2026-09-23 21:30:00', 15.00);
GO

-- CONSULTAS
SELECT * FROM Clientes;
SELECT * FROM RegistrosEstacionamento;
SELECT * FROM Vagas;
SELECT * FROM Veiculos;



/*
EstacionamentoDB:

 

- Crie uma procedure sp_RegistrarEntradaVeiculo
- Parâmetros: @placa, @vaga_id, @registro_id INT OUTPUT
- Deve buscar o id do veiculo pela placa informada e registrar a entrada com data/hora atual
- O parametro para buscar data e hora atual é o "GATEDATE()"
*/


-- Declaração de variável
DECLARE @idRegistro INT;

-- Chamada da Storage Procedure
EXEC sp_RegistrarEntradaVeiculo
	@placa = 'ABC1D23',
	@vaga_id = 1,
	@registro_id = @idRegistro OUT;

SELECT * FROM Clientes;


-- Correção

CREATE OR ALTER PROCEDURE sp_RegistrarEntradaVeiculo
	@placa VARCHAR(100),
	@vaga_id INT,
	@registro_id INT OUT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @veiculo_id INT;
	SELECT @veiculo_id = id FROM Veiculos WHERE placa = @placa;

	IF @veiculo_id IS NULL
	BEGIN
		RAISERROR('Veículo com esta placa não encontrado', 16, 1);
		RETURN;
	END

	INSERT INTO RegistroEstacionamento (veiculo_id, vagas_id, data_hora_entrada)
	VALUES (@veiculo_id, @vaga_id, GetDate());

	SET @registro_id = SCOPE_IDENTITY();
