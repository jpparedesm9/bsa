USE cobis
GO

/* -- 
drop table ba_tabla_tmp  
-- */
IF NOT EXISTS(SELECT 1 FROM sysobjects WHERE name = 'ba_tabla_tmp')
BEGIN
	CREATE TABLE ba_tabla_tmp ( 
	tipo      CHAR,
	fecha_sys DATETIME, 
	fecha_gen  DATETIME , 
	tabla1  VARCHAR(1000) NULL,
	tabla2  VARCHAR(1000) NULL
	)
	CREATE INDEX idx_1 ON ba_tabla_tmp (fecha_gen)
end	
go	

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
                          @w_fecha_gen    = '2018/05/28 20:01:01',   -- **************
--/////////////////////// ESTA VALOR ES LA CLAVE PARA RESTAURAR


@w_fecha_sys    = getdate()

-- controlar que ya existe esta clave de respaldos
IF EXISTS(SELECT 1 FROM ba_tabla_tmp WHERE fecha_gen = @w_fecha_gen)
BEGIN
	print' =======>   **** SE DETIENE PROCESO......<<<<NO CONTINUAR>>>>   ****'
	print' =======>   **** REPORTAR AL RESPONSABLE '

END	
ELSE
BEGIN
	
	SELECT @w_fecha = '_' + replace(replace(convert(VARCHAR, @w_fecha_gen, 112),' ',''),':','') + '_' +
		   replace(replace(convert(VARCHAR, @w_fecha_gen, 108),' ',''),':','')
	
	
	SELECT 
	@w_batch        = @w_batch        + @w_fecha,
	@w_sarta        = @w_sarta        + @w_fecha,
	@w_sarta_batch  = @w_sarta_batch  + @w_fecha,
	@w_enlace       = @w_enlace       + @w_fecha,
	@w_parametro    = @w_parametro    + @w_fecha
	
	
	-- RESPALDO DE INFORMACION
	SELECT @w_tipo         = 'C'
	
	insert into cobis..ba_tabla_tmp values (@w_tipo, @w_fecha_sys, @w_fecha_gen, 'INICIO',      'INICIO')
	insert into cobis..ba_tabla_tmp values (@w_tipo, @w_fecha_sys, @w_fecha_gen, @w_batch,      'SELECT * INTO '+ @w_batch +       ' FROM cobis..ba_batch ')
	insert into cobis..ba_tabla_tmp values (@w_tipo, @w_fecha_sys, @w_fecha_gen, @w_sarta,      'SELECT * INTO '+ @w_sarta +       ' FROM cobis..ba_sarta ')
	insert into cobis..ba_tabla_tmp values (@w_tipo, @w_fecha_sys, @w_fecha_gen, @w_sarta_batch,'SELECT * INTO '+ @w_sarta_batch + ' FROM cobis..ba_sarta_batch ')
	insert into cobis..ba_tabla_tmp values (@w_tipo, @w_fecha_sys, @w_fecha_gen, @w_enlace,     'SELECT * INTO '+ @w_enlace +      ' FROM cobis..ba_enlace ')
	insert into cobis..ba_tabla_tmp values (@w_tipo, @w_fecha_sys, @w_fecha_gen, @w_parametro,  'SELECT * INTO '+ @w_parametro +   ' FROM cobis..ba_parametro')
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
		AND tipo      = @w_tipo
		AND tabla1 NOT IN ('INICIO', 'FIN')
		ORDER BY tabla1
		
		IF @@ROWCOUNT = 0 
		BEGIN
			PRINT ' *<<*termino RESPALDO*>>*'
			BREAK
		END
		
		SELECT @w_query = @w_tabla2
		PRINT ' TABLA: ' +  @w_tabla1 + '        QUERY: ====>> ' + @w_query

		BEGIN TRY
			BEGIN TRANSACTION
			execute(@w_query)
			COMMIT
		END TRY
		BEGIN CATCH
			ROLLBACK
			PRINT '=======> Fal´lo Proceso en: ======> ****    ' + @w_query
			
			break
		END CATCH
		
		
	END
END -- CONTINUAR PROCESO



	
	
	SELECT * FROM ba_tabla_tmp WHERE fecha_gen = @w_fecha_gen
	AND fecha_sys = @w_fecha_sys


GO


