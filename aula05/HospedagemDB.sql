CREATE DATABASE HospedagemDB;
GO

USE HospedagemDB;
GO

CREATE TABLE Cliente
(
	id INTEGER IDENTITY(1,1) CONSTRAINT PK_Clientes PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	rg VARCHAR(20) NOT NULL CONSTRAINT UQ_Clientes_RG UNIQUE,
	endereco VARCHAR(100) NOT NULL,
	bairro VARCHAR(100) NOT NULL,
	cidade VARCHAR(100) NOT NULL,
	estado VARCHAR(100) NOT NULL,
	cep VARCHAR(100) NOT NULL,
	nascimento DATE NOT NULL
);
GO

CREATE TABLE Hospedagem
(
	id INTEGER IDENTITY(1,1) PRIMARY KEY,
	chale_id INTEGER
	estado
	data_inicio
	data_fim
	qtd_pessoas
	desconto
	valor_final
);
GO

CREATE TABLE Chale
(
	
);
GO

CREATE TABLE Telefone
(
	
);
GO

CREATE TABLE Hospedagem_Serviço
(
	
);
GO

CREATE TABLE 
(
	
);
GO

CREATE TABLE 
(
	
);
GO

CREATE TABLE 
(
	
);
GO