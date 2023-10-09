USE cobis
GO

DECLARE 
@w_incidencia   VARCHAR(100),
@w_fecha_gen   DATETIME,
@w_batch   VARCHAR(100),
@w_sarta   VARCHAR(100),
@w_sarta_batch   VARCHAR(100),
@w_enlace VARCHAR(100),
@w_parametro   VARCHAR(100),
@w_tabla1  VARCHAR(100),
@w_tabla2  VARCHAR(100),
@w_query  VARCHAR(1000),
@w_tipo    CHAR

SELECT 
@w_batch        = 'ba_batch',
@w_sarta        = 'ba_sarta',
@w_sarta_batch  = 'ba_sarta_batch',
@w_enlace       = 'ba_enlace',
@w_parametro    = 'ba_parametro',

--/////////////////////// ESTA VALOR ES LA CLAVE PARA RESTAURAR
                          @w_incidencia    = '96016',   -- **************
--/////////////////////// ESTA VALOR ES LA CLAVE PARA RESTAURAR

@w_fecha_gen    = getdate()


DELETE FROM cobis..ba_tablas_respaldo 
WHERE clave     = @w_incidencia
AND   fecha_gen = @w_fecha_gen 

SELECT 
@w_batch        = @w_batch       + '_' + @w_incidencia,
@w_sarta        = @w_sarta       + '_' + @w_incidencia,
@w_sarta_batch  = @w_sarta_batch + '_' + @w_incidencia,
@w_enlace       = @w_enlace      + '_' + @w_incidencia,
@w_parametro    = @w_parametro   + '_' + @w_incidencia


-- RESPALDO DE INFORMACION
SELECT @w_tipo         = 'R'
insert into cobis..ba_tablas_respaldo values (@w_tipo, @w_fecha_gen, @w_incidencia, 'INICIO',      'INICIO')
insert into cobis..ba_tablas_respaldo values (@w_tipo, @w_fecha_gen, @w_incidencia, @w_batch,      'cobis..ba_batch ')
insert into cobis..ba_tablas_respaldo values (@w_tipo, @w_fecha_gen, @w_incidencia, @w_sarta,      'cobis..ba_sarta ')
insert into cobis..ba_tablas_respaldo values (@w_tipo, @w_fecha_gen, @w_incidencia, @w_sarta_batch,'cobis..ba_sarta_batch ')
insert into cobis..ba_tablas_respaldo values (@w_tipo, @w_fecha_gen, @w_incidencia, @w_enlace,     'cobis..ba_enlace ')
insert into cobis..ba_tablas_respaldo values (@w_tipo, @w_fecha_gen, @w_incidencia, @w_parametro,  'cobis..ba_parametro')
insert into cobis..ba_tablas_respaldo values (@w_tipo, @w_fecha_gen, @w_incidencia, 'FIN',         'FIN')

SELECT @w_query = '', @w_tabla1 = '', @w_tabla2 = ''
WHILE 1=1
BEGIN
	SELECT TOP 1 
		@w_tabla1 = tabla1,
		@w_tabla2 = tabla2
	FROM cobis..ba_tablas_respaldo
	WHERE tabla1 > @w_tabla1
	AND  clave   = @w_incidencia
	AND tabla1 NOT IN ('INICIO', 'FIN')
	AND tipo      = @w_tipo
	AND fecha_gen = @w_fecha_gen
	ORDER BY fecha_gen, tabla1
	
	IF @@ROWCOUNT = 0 
	BEGIN
		PRINT ' <<termino RESTAURACION>>'
		BREAK
	END

	BEGIN TRY
		BEGIN TRANSACTION
		-- elimino datos 
		SELECT @w_query = 'delete from ' + @w_tabla2
		PRINT ' TABLA: ' +  @w_tabla1 + '        QUERY: ====>> ' + @w_query
		execute(@w_query)
		IF @@ERROR <> 0
		BEGIN
			PRINT ' error al eliminar informacion'
		ENd
	
	    -- restauro la data
		SELECT @w_query = 'insert into  ' + @w_tabla2 + ' select * from ' + @w_tabla1
		PRINT ' TABLA: ' +  @w_tabla1 + '        QUERY: ====>> ' + @w_query
		
		execute(@w_query)
		COMMIT
		
	END TRY
	BEGIN CATCH
		ROLLBACK
		PRINT '=======> Fallo Proceso en: ======> ****    ' + @w_query
		break
	END CATCH
END

SELECT * FROM ba_tablas_respaldo 
WHERE fecha_gen = @w_fecha_gen



GO


