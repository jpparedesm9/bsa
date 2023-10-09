use cobis
go

SET NOCOUNT ON
GO

declare
	@w_id	int

--Asignacion de id segun la tabla ree_ien_transaction_type
select @w_id = codigo from cobis..cl_tabla where tabla = 'ree_ien_transaction_type'

IF @w_id IS NULL
	PRINT 'ERROR: No existe catálogo ree_ien_transaction_type. Revisar la instalación de Integration Engine'
ELSE
BEGIN
	DELETE FROM cobis..cl_catalogo
	WHERE tabla = @w_id 
	AND codigo IN ('DSMBL', 'COBRO', 'DSMBLCK', 'PGRFR')

	INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)
	VALUES (@w_id, 'DSMBL', 'DESEMBOLSO DE CREDITO', 'V')

	INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)
	VALUES (@w_id, 'COBRO', 'COBRO DE CUOTA DE CREDITO', 'V')

	INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)
	VALUES (@w_id, 'DSMBLCK', 'CHECK DESEMBOLSO DE CREDITO', 'V')

	INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)
	VALUES (@w_id, 'PGRFR', 'PAGO REFERENCIADO', 'V')

	PRINT 'Datos insertados correctamente'
END

go


SET NOCOUNT OFF
GO
