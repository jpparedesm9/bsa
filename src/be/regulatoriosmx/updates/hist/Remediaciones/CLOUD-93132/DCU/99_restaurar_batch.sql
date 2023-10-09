USE cobis
GO

DECLARE 
@w_fecha VARCHAR(100),
@w_fecha_gen   DATETIME,
@w_fecha_sys   DATETIME,
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
                          @w_fecha_gen    = '2018/01/01 16:02:03',   -- **************
--/////////////////////// ESTA VALOR ES LA CLAVE PARA RESTAURAR

@w_fecha_sys    = getdate()



SELECT @w_fecha = '_' + replace(replace(convert(VARCHAR, @w_fecha_gen, 112),' ',''),':','') + '_' +
	   replace(replace(convert(VARCHAR, @w_fecha_gen, 108),' ',''),':','')


SELECT 
@w_batch        = @w_batch        + @w_fecha,
@w_sarta        = @w_sarta        + @w_fecha,
@w_sarta_batch  = @w_sarta_batch  + @w_fecha,
@w_enlace       = @w_enlace       + @w_fecha,
@w_parametro    = @w_parametro    + @w_fecha


-- RESPALDO DE INFORMACION
SELECT @w_tipo         = 'R'
insert into cobis..ba_tabla_tmp values (@w_tipo, @w_fecha_sys, @w_fecha_gen, 'INICIO',      'INICIO')
insert into cobis..ba_tabla_tmp values (@w_tipo, @w_fecha_sys, @w_fecha_gen, @w_batch,      'cobis..ba_batch ')
insert into cobis..ba_tabla_tmp values (@w_tipo, @w_fecha_sys, @w_fecha_gen, @w_sarta,      'cobis..ba_sarta ')
insert into cobis..ba_tabla_tmp values (@w_tipo, @w_fecha_sys, @w_fecha_gen, @w_sarta_batch,'cobis..ba_sarta_batch ')
insert into cobis..ba_tabla_tmp values (@w_tipo, @w_fecha_sys, @w_fecha_gen, @w_enlace,     'cobis..ba_enlace ')
insert into cobis..ba_tabla_tmp values (@w_tipo, @w_fecha_sys, @w_fecha_gen, @w_parametro,  'cobis..ba_parametro')

insert into cobis..ba_tabla_tmp values (@w_tipo, @w_fecha_sys, @w_fecha_gen, 'FIN',         'FIN')

SELECT @w_query = '', @w_tabla1 = '', @w_tabla2 = ''
WHILE 1=1
BEGIN
	SELECT TOP 1 
		@w_tabla1 = tabla1,
		@w_tabla2 = tabla2
	FROM cobis..ba_tabla_tmp
	WHERE tabla1 > @w_tabla1
	AND fecha_gen = @w_fecha_gen
	AND fecha_sys = @w_fecha_sys
	AND tabla1 NOT IN ('INICIO', 'FIN')
	AND tipo      = @w_tipo
	ORDER BY tabla1
	
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

SELECT * FROM ba_tabla_tmp WHERE fecha_gen = @w_fecha_gen
	AND fecha_sys = @w_fecha_sys



GO


