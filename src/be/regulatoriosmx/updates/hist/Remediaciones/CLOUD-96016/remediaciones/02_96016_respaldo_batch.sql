USE cobis
GO

/* -- 
drop table ba_tablas_respaldo  
-- */
IF NOT EXISTS(SELECT 1 FROM sysobjects WHERE name = 'ba_tablas_respaldo')
BEGIN
	CREATE TABLE dbo.ba_tablas_respaldo
	(
	tipo      CHAR (1) NULL,
	fecha_gen DATETIME NULL,
	clave     VARCHAR (1000) NULL,
	tabla1    VARCHAR (1000) NULL,
	tabla2    VARCHAR (1000) NULL
	)

	CREATE INDEX idx_1 ON ba_tablas_respaldo (fecha_gen)
end	
go	

DECLARE 
@w_fecha       VARCHAR(100),
@w_fecha_gen   DATETIME,
@w_incidencia  VARCHAR(100),
@w_batch       VARCHAR(100),
@w_sarta       VARCHAR(100),
@w_sarta_batch VARCHAR(100),
@w_enlace      VARCHAR(100),
@w_parametro   VARCHAR(100),
@w_tabla1      VARCHAR(100),
@w_tabla2      VARCHAR(100),
@w_query       VARCHAR(1000),
@w_tipo        CHAR

SELECT 
@w_batch        = 'cobis..ba_batch',
@w_sarta        = 'cobis..ba_sarta',
@w_sarta_batch  = 'cobis..ba_sarta_batch',
@w_enlace       = 'cobis..ba_enlace',
@w_parametro    = 'cobis..ba_parametro',
--/////////////////////// ESTA VALOR ES LA CLAVE PARA RESTAURAR
                          @w_incidencia    = '96016',   -- **************
--/////////////////////// ESTA VALOR ES LA CLAVE PARA RESTAURAR
@w_fecha_gen    = getdate()

	
	SELECT 
	@w_batch        = @w_batch        + '_' + @w_incidencia,
	@w_sarta        = @w_sarta        + '_' + @w_incidencia,
	@w_sarta_batch  = @w_sarta_batch  + '_' + @w_incidencia,
	@w_enlace       = @w_enlace       + '_' + @w_incidencia,
	@w_parametro    = @w_parametro    + '_' + @w_incidencia
	
	-- RESPALDO DE INFORMACION
	SELECT @w_tipo         = 'C'
	
	insert into cobis..ba_tablas_respaldo values (@w_tipo, @w_fecha_gen, @w_incidencia, 'INICIO',      'INICIO')
	insert into cobis..ba_tablas_respaldo values (@w_tipo, @w_fecha_gen, @w_incidencia, @w_batch,      'SELECT * INTO '+ @w_batch +       ' FROM cobis..ba_batch ')
	insert into cobis..ba_tablas_respaldo values (@w_tipo, @w_fecha_gen, @w_incidencia, @w_sarta,      'SELECT * INTO '+ @w_sarta +       ' FROM cobis..ba_sarta ')
	insert into cobis..ba_tablas_respaldo values (@w_tipo, @w_fecha_gen, @w_incidencia, @w_sarta_batch,'SELECT * INTO '+ @w_sarta_batch + ' FROM cobis..ba_sarta_batch ')
	insert into cobis..ba_tablas_respaldo values (@w_tipo, @w_fecha_gen, @w_incidencia, @w_enlace,     'SELECT * INTO '+ @w_enlace +      ' FROM cobis..ba_enlace ')
	insert into cobis..ba_tablas_respaldo values (@w_tipo, @w_fecha_gen, @w_incidencia, @w_parametro,  'SELECT * INTO '+ @w_parametro +   ' FROM cobis..ba_parametro')
	insert into cobis..ba_tablas_respaldo values (@w_tipo, @w_fecha_gen, @w_incidencia, 'FIN',         'FIN')
	
	
	SELECT @w_query = '', @w_tabla1 = '', @w_tabla2 = ''
	WHILE 1=1
	BEGIN
		SELECT TOP 1 
			@w_tabla1 = tabla1,
			@w_tabla2 = tabla2
		FROM cobis..ba_tablas_respaldo
		WHERE tabla1 > @w_tabla1
		AND fecha_gen = @w_fecha_gen
		AND clave     = @w_incidencia
		AND tipo      = @w_tipo
		AND tabla1 NOT IN ('INICIO', 'FIN')
		ORDER BY tabla1
		
		IF @@ROWCOUNT = 0 
		BEGIN
			PRINT ' *<<*termino RESPALDO*>>*'
			BREAK
		END

        /* BORRADO DE LAS TABLAS DE RESPALDO */
		SELECT @w_query = 'drop table ' + @w_tabla1
		BEGIN TRY
			execute(@w_query)
		END TRY
		BEGIN CATCH
			PRINT '=======> No existe : ======> ****    ' + @w_query
		END CATCH

		/* RESPALDO DE LAS TABLAS */		
		SELECT @w_query = @w_tabla2
		PRINT ' TABLA: ' + @w_tabla1 + replicate(' ', 40- len(@w_tabla1)) + '        QUERY: ====>> ' + @w_query
		BEGIN TRY
			BEGIN TRANSACTION
			execute(@w_query)
			COMMIT
		END TRY
		BEGIN CATCH
			ROLLBACK
			PRINT '=======> Fallo Proceso en: ======> ****    ' + @w_query
			
			break
		END CATCH
		
		
	END


	SELECT * FROM ba_tablas_respaldo WHERE fecha_gen = @w_fecha_gen


GO


