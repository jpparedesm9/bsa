/************************************************************************/
/*      Archivo           :  sp_ahvaltmp                             	*/
/*      Base de datos     :  cob_ahorros                                */
/*      Producto          :  Cuentas de Ahorros                         */
/*      Disenado por      :  Andres Enriquez                            */
/*      Fecha de escritura:  30/May/2016                                */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      proceso que realiza la validacion de la creacion de las tablas 	*/
/*		y sus indices													*/
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR               RAZON                       */
/*      23/May/2016     A Enriquez      	Emision Inicial	            */
/*      18/Jul/2016     Pedro Montenegro    Modificación nombres  		*/
/*                                      	parametros y llamada a      */
/*											sp sp_errorlog				*/
/*      29/Jul/2016     Tania Baidal        Se cambia nombre de inac a  */
/*                                          inac4                       */
/************************************************************************/

USE cob_ahorros
GO

if object_id('sp_ahvaltmp') is not null
begin
	drop procedure sp_ahvaltmp
	if object_id('sp_ahvaltmp') is not null
		print 'FAILED DROPPING PROCEDURE sp_ahvaltmp'
end

go

create procedure sp_ahvaltmp
(
	@t_show_version     bit 		= 0,
	@i_param1           int,			    --@i_filial
	@i_param2           datetime,			--@i_fecha_proceso
	@i_param3           varchar(50)--,		--@i_path_archivo
	
	--@i_param4           varchar(10),     		--@i_usuario
	--@i_param5           varchar(10),     		--@i_contrasena
	--@i_param6           varchar(15),     		--@i_server
	--Parametros para registro de log ejecución 
	----@i_sarta             int = null,
	----@i_batch             int = null,
	----@i_secuencial        int = null,
	----@i_corrida           int = null,
	----@i_intento           int = null,
)
AS 
DECLARE
	@w_existe       	char(1),
	@w_sp_name      	varchar (500),
	@w_existe_ind   	char(1),
	@w_mensaje      	varchar (500),
	@w_ntabla			varchar(100),
	@w_nbase			varchar(100),
	@w_id           	int ,
	@w_ind          	int,
	@w_codigo       	int,
	@w_archivo      	varchar(50), 
	@w_comando      	varchar(255),
	@w_tabla        	varchar(255),
	@w_retorno      	int,
	@w_retorno_ej   	int,
	
	@w_fila_0			int,
	@w_no_fila_0		int,
	
	@w_error			int,
	@w_trn_code			int,
	@w_msg				mensaje,

	@w_sql				nvarchar(500),
	@w_parametros		nvarchar(500),
	@w_contador       	int,
	
	@w_filial       	int,
	@w_fecha_proceso	datetime,
	@w_path_archivo 	varchar(50)

select 	@w_filial 		= @i_param1,
		@w_fecha_proceso= @i_param2,
		@w_path_archivo = @i_param3

select 	@w_sp_name 	= 'sp_ahvaltmp',
		@w_tabla 	= 'ah_valida_temporales'

if @t_show_version = 1
begin
	print 'Stored Procedure = ' + @w_sp_name + ' Version = ' + '4.0.0.0'
	return 0
end

if not exists (select 1 from cobis..cl_filial where fi_filial = @w_filial)
begin
	select 	@w_error 	= 101002,
			@w_msg		= null
	goto ERRORFIN
end

if not exists(select 1 from cob_ahorros..sysobjects where name = 'ah_valida_temporales')
begin
	create table ah_valida_temporales 
	(
		tabla varchar (500)
	)
	
	if (@@error > 0)
	begin
		select 	@w_error 	= 357020,
				@w_msg		= 'ERROR AL CREAR LA TABLA ah_valida_temporales'
		goto ERRORFIN
	end 
end
else
begin
	truncate table ah_valida_temporales
	
	if (@@error > 0)
	begin
		select 	@w_error 	= 288503,
				@w_msg		= 'ERROR AL ELIMINAR TABLA ah_valida_temporales'
		goto ERRORFIN
	end 
end

if exists(select 1 
			from tempdb..sysobjects 
			where upper(name) like upper('%ListadoTablasTemp%'))
begin
	drop table #ListadoTablasTemp
	
	if (@@error > 0)
	begin
		select 	@w_error 	= 357021,
				@w_msg		= 'ERROR AL ELIMINAR LA TABLA #ListadoTablasTemp'
		goto ERRORFIN
	end 
end

create table #ListadoTablasTemp
(
	identificador	int identity,
	base			varchar(100),
	tabla			varchar(100)
)

if (@@error > 0)
begin
	select 	@w_error 	= 357020,
			@w_msg		= 'ERROR AL CREAR LA TABLA #ListadoTablasTemp'
	goto ERRORFIN
end 

BEGIN
	SET NOCOUNT ON;

	select 	@w_codigo	= 1,
			@w_mensaje 	= null 

	select 	@w_archivo = 'ahvaltmp.lis'

	insert into #ListadoTablasTemp (base, tabla) values ('tempdb', 'pint4')

	if (@@error > 0)
	begin
		select 	@w_error 	= 263500,
				@w_msg		= NULL
		goto ERRORFIN
	end 

	insert into #ListadoTablasTemp (base, tabla) values ('tempdb', 'pe_tipo_atributo')

	if (@@error > 0)
	begin
		select 	@w_error 	= 263500,
				@w_msg		= NULL
		goto ERRORFIN
	end 

	insert into #ListadoTablasTemp (base, tabla) values ('tempdb', 'cslm4')

	if (@@error > 0)
	begin
		select 	@w_error 	= 263500,
				@w_msg		= NULL
		goto ERRORFIN
	end
	
	insert into #ListadoTablasTemp (base, tabla) values ('tempdb', 'inac4')

	if (@@error > 0)
	begin
		select 	@w_error 	= 263500,
				@w_msg		= NULL
		goto ERRORFIN
	end 

	insert into #ListadoTablasTemp (base, tabla) values ('cob_ahorros', 'ah_cuenta_batch')

	if (@@error > 0)
	begin
		select 	@w_error 	= 263500,
				@w_msg		= NULL
		goto ERRORFIN
	end 

	select @w_fila_0 = isnull(min(identificador), 0) from #ListadoTablasTemp
	select @w_no_fila_0 = isnull(max(identificador), 0) from #ListadoTablasTemp

	if (@w_fila_0 > 0)
	begin
		while @w_fila_0 <= @w_no_fila_0
		begin
			select @w_mensaje = null
			select 	@w_nbase 	= base,
					@w_ntabla 	= tabla
				from #ListadoTablasTemp
				where identificador = @w_fila_0

			select 	@w_sql = 'SELECT @w_contador = isnull(count(*), 0) FROM ' + @w_nbase + '..sysobjects where name = ' + char(39) + @w_ntabla + char(39),
					@w_parametros = '@w_contador int OUTPUT'
            
			EXECUTE sp_executesql @w_sql, @w_parametros, @w_contador OUTPUT

			if (@@error > 0)
			begin
				select 	@w_error 	= 357022,
						@w_msg		= 'ERROR AL CONSULTAR EXISTENCIA DE OBJETO (' + @w_nbase + '..' + @w_ntabla + ')'
				goto ERRORFIN
			end 

			if @w_contador > 0
			begin
				select 	@w_sql = 'SELECT @w_contador = isnull(count(*), 0) FROM ' + @w_nbase + '..sysobjects a, ' + @w_nbase + '..sysindexes b where a.id = b.id and a.name = ' + char(39) + @w_ntabla + char(39) + ' and b.name is not null',
						@w_parametros = '@w_contador int OUTPUT'

				EXECUTE sp_executesql @w_sql, @w_parametros, @w_contador OUTPUT

				if (@@error > 0)
				begin
					select 	@w_error 	= 357022,
							@w_msg		= 'ERROR AL CONSULTAR EXISTENCIA DE INDICE PARA (' + @w_nbase + '..' + @w_ntabla + ')'
					goto ERRORFIN
				end 

				if @w_contador = 0
				begin
					select @w_mensaje = 'LA TABLA TEMPORAL ' +  @w_nbase + '..' + @w_ntabla +  ' NO POSEE INDICE'
				end
			end
			else
			begin
				select  @w_mensaje = 'LA TABLA TEMPORAL ' + @w_nbase + '..' + @w_ntabla + ' NO EXISTE'
			end

			---insert tabla de Mensajes
			if (@w_mensaje is not null)
			begin
				insert into ah_valida_temporales values (@w_mensaje)

				if (@@error > 0)
				begin
					select 	@w_error 	= 263500,
							@w_msg		= 'ERROR AL INGRESAR EN TABLA ah_valida_temporales'
					goto ERRORFIN
				end 
			end
			
			select @w_fila_0 = @w_fila_0 + 1
			select @w_existe = 'N'
		end
	end
	 
	--Obtener bcp de la tabla

    select @w_comando = null
	--select @w_comando = 'bcp cob_ahorros..' + @w_tabla + ' out ' +  @w_path_archivo + @w_archivo +' -U '+ @w_usuario +' -P '+ @w_contrasena +' -S '+ @w_server + ' -c' --     -b1000 -t -e ../listados/'  + @w_archivo + '.err > ../listados/' + @w_archivo + '.out'
	select @w_comando = 'bcp cob_ahorros..' + @w_tabla + ' out ' +  @w_path_archivo + @w_archivo + ' -T -c'
	
	if @w_comando is null
    begin
		select 	@w_error 	= 357025,
				@w_msg		= NULL
		goto ERRORFIN   
	end
	
	exec @w_retorno = master..xp_cmdshell @w_comando,no_output
	
	if @w_retorno > 0
    begin
		select 	@w_error 	= 357023,
				@w_msg		= 'ERROR AL EJECUTAR BCP DE LA TABLA (' + @w_tabla + ')'
		goto ERRORFIN
	end
END

truncate table cob_ahorros..ah_acumulador1

if (@@error > 0)
begin
	select 	@w_error 	= 288503,
			@w_msg		= 'ERROR AL ELIMINAR TABLA ah_acumulador1'
	goto ERRORFIN
end 

truncate table cob_ahorros..ah_saldos_rep1

if (@@error > 0)
begin
	select 	@w_error 	= 288503,
			@w_msg		= 'ERROR AL ELIMINAR TABLA ah_saldos_rep1'
	goto ERRORFIN
end 

truncate table cob_ahorros..ah_saldo_diario1

if (@@error > 0)
begin
	select 	@w_error 	= 288503,
			@w_msg		= 'ERROR AL ELIMINAR TABLA ah_saldo_diario1'
	goto ERRORFIN
end 

truncate table cob_ahorros..ah_tran_servicio1

if (@@error > 0)
begin
	select 	@w_error 	= 288503,
			@w_msg		= 'ERROR AL ELIMINAR TABLA ah_tran_servicio1'
	goto ERRORFIN
end 

truncate table cob_ahorros..ah_acumulador2

if (@@error > 0)
begin
	select 	@w_error 	= 288503,
			@w_msg		= 'ERROR AL ELIMINAR TABLA ah_acumulador2'
	goto ERRORFIN
end 

truncate table cob_ahorros..ah_saldos_rep2

if (@@error > 0)
begin
	select 	@w_error 	= 288503,
			@w_msg		= 'ERROR AL ELIMINAR TABLA ah_saldos_rep2'
	goto ERRORFIN
end 

truncate table cob_ahorros..ah_saldo_diario2

if (@@error > 0)
begin
	select 	@w_error 	= 288503,
			@w_msg		= 'ERROR AL ELIMINAR TABLA ah_saldo_diario2'
	goto ERRORFIN
end 

truncate table cob_ahorros..ah_tran_servicio2

if (@@error > 0)
begin
	select 	@w_error 	= 288503,
			@w_msg		= 'ERROR AL ELIMINAR TABLA ah_tran_servicio2'
	goto ERRORFIN
end 

truncate table cob_ahorros..ah_acumulador3

if (@@error > 0)
begin
	select 	@w_error 	= 288503,
			@w_msg		= 'ERROR AL ELIMINAR TABLA ah_acumulador3'
	goto ERRORFIN
end 

truncate table cob_ahorros..ah_saldos_rep3

if (@@error > 0)
begin
	select 	@w_error 	= 288503,
			@w_msg		= 'ERROR AL ELIMINAR TABLA ah_saldos_rep3'
	goto ERRORFIN
end 

truncate table cob_ahorros..ah_saldo_diario3

if (@@error > 0)
begin
	select 	@w_error 	= 288503,
			@w_msg		= 'ERROR AL ELIMINAR TABLA ah_saldo_diario3'
	goto ERRORFIN
end 

truncate table cob_ahorros..ah_tran_servicio3

if (@@error > 0)
begin
	select 	@w_error 	= 288503,
			@w_msg		= 'ERROR AL ELIMINAR TABLA ah_tran_servicio3'
	goto ERRORFIN
end 

truncate table cob_ahorros..ah_acumulador4

if (@@error > 0)
begin
	select 	@w_error 	= 288503,
			@w_msg		= 'ERROR AL ELIMINAR TABLA ah_acumulador4'
	goto ERRORFIN
end 

truncate table cob_ahorros..ah_saldos_rep4

if (@@error > 0)
begin
	select 	@w_error 	= 288503,
			@w_msg		= 'ERROR AL ELIMINAR TABLA ah_saldos_rep4'
	goto ERRORFIN
end 

truncate table cob_ahorros..ah_saldo_diario4

if (@@error > 0)
begin
	select 	@w_error 	= 288503,
			@w_msg		= 'ERROR AL ELIMINAR TABLA ah_saldo_diario4'
	goto ERRORFIN
end 

truncate table cob_ahorros..ah_tran_servicio4

if (@@error > 0)
begin
	select 	@w_error 	= 288503,
			@w_msg		= 'ERROR AL ELIMINAR TABLA ah_tran_servicio4'
	goto ERRORFIN
end 

truncate table cob_ahorros..re_error_batch

if (@@error > 0)
begin
	select 	@w_error 	= 288503,
			@w_msg		= 'ERROR AL ELIMINAR TABLA re_error_batch'
	goto ERRORFIN
end 

return 0

ERRORFIN:

exec sp_errorlog
	@i_fecha       = @w_fecha_proceso,
	@i_error       = @w_error,
	@i_usuario     = 'batch',
	@i_tran        = @w_trn_code,
	@i_descripcion = @w_msg,
	@i_programa    = @w_sp_name

return 1

GO
