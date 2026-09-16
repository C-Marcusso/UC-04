CREATE DATABASE PizzariaDB;
GO

USE PizzariaDB;
GO

CREATE TABLE dbo.Clientes
(
	id INTEGER IDENTITY(1,1) NOT NULL PRIMARY KEY, 
	nome VARCHAR(100) NOT NULL,
	telefone VARCHAR(20) NOT NULL UNIQUE,
	endereco VARCHAR(255) NULL,
);
GO

INSERT INTO dbo.Clientes (nome, telefone, endereco) VALUES
('Thiago Santos da Costa', '1199999999', 'Congonhas 454'),
('Caio Marc', '11944444444', 'Igapó 25'); 
GO

SELECT * FROM dbo.Clientes