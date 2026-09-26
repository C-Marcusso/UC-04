CREATE DATABASE PizzariaDB;
GO

USE PizzariaDB;
GO

CREATE TABLE Clientes 
(
	id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	telefone VARCHAR(20) NOT NULL UNIQUE,
	endereco VARCHAR(255) NULL
); 
GO

-- 2 CLIENTES
INSERT INTO Clientes (nome, telefone, endereco) VALUES
('Fulano', '1199887755', 'Rua X'),
('Carlos', '5500998877', 'Tv ZZ');

SELECT * FROM Clientes

USE PizzariaDB;
GO

-- STORAGE PROCEDURE
-- Procedure para cadastrar clientes
CREATE OR ALTER PROCEDURE dbo.sp_CadastrarCliente
	@nome VARCHAR(100),
	@telefone VARCHAR(20),
	@endereco VARCHAR(255) = NULL, 
	@novoId INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

-- Validação
	IF EXISTS (SELECT 1 FROM Clientes WHERE telefone = @telefone)
	BEGIN
		RAISERROR('Telefone já cadastrado', 16, 1);
		RETURN;
	END

	INSERT INTO Clientes (nome, telefone, endereco)
	VALUES (@nome, @telefone, @endereco);

	SET @novoId = SCOPE_IDENTITY();
END;
GO

USE PizzariaDB;
GO

-- Declaração de variável
DECLARE @idGerado INT;

-- Chamada da Storage Procedure
EXEC sp_CadastrarCliente
	@nome = 'Felipe Marins',
	@telefone = '11988888888',
	@endereco = 'Rua que sobe e desce que ninguém conhece, 999',
	@novoId = @idGerado OUT;

SELECT * FROM Clientes;
