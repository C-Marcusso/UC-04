USE EstacionamentoDB;
GO

SELECT * FROM RegistrosEstacionamento;

EXEC sp_RegistrarSaidaVeiculo
	@registro_id = 7