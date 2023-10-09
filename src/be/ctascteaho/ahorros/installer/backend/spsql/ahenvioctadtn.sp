
/************************************************************************/
/*      Archivo           :  ah_envioctadtn.sp                          */
/*      Base de datos     :  cob_ahorros                                */
/*      Producto          :  Cuentas Ahorros                            */
/*      Disenado por      :  Andres Enríquez                            */
/*      Fecha de escritura:  18-Mayo-2010                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "COBISCORP", representantes exclusivos para el Ecuador.         */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de COBISCORP o su representante.          */
/************************************************************************/
/*                              PROPOSITO                               */
/*																        */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR           	RAZON                       */
/*      25/May/2016     A Enriquez      	Emision Inicial	            */ 
/*      18/Jul/2016     Pedro Montenegro    Modificación nombres  		*/
/*                                      	parametros y llamada a      */
/*											sp sp_errorlog				*/
/************************************************************************/

USE cob_ahorros
GO

if object_id('sp_ah_envioctadtn') is not null
begin
	drop procedure sp_ah_envioctadtn
	if object_id('sp_ah_envioctadtn') is not null
		print 'FAILED DROPPING PROCEDURE sp_ah_envioctadtn'  
end

go

create procedure  sp_ah_envioctadtn
(
	--Parámetros para regístro de log ejecución 
	@t_show_version		bit = 0,
	@i_param1         	int, 				--@i_filial
	@i_param2         	datetime,           --@i_fecha_proceso
	@i_param3         	varchar(2),         --@i_ejecucion     -- P
	@i_param4         	varchar(100) 		--@i_path_archivo  --Directorio de Salida
	--@i_param5         	varchar(10),        --@i_usuario
	--@i_param6         	varchar(10),        --@i_contrasena
	--@i_param7         	varchar(15),        --@i_server
	---@i_sarta            int = null,
	---@i_batch            int = null,
	---@i_secuencial       int = null,
	---@i_corrida          int = null,
	---@i_intento          int = null,
)	
AS
DECLARE
	@w_retorno			int,
	@w_retorno_ej		int,
	@w_sp_name			varchar(30),
	@w_fecha_fin		datetime,
    @w_fecha_aux		datetime,
	@w_fecha_sig		datetime,
	@w_anio_tmp			int,
	@w_mes_tmp			int,
	@w_dia_tmp			int,
	@w_anio				int,
	@w_mes				int,
	@w_dia				int,
	@w_oficina_inicial	int,
	@w_oficina_final	int,
	@w_tabla			varchar(64),
	@w_archivo			varchar(32),
	@w_comando			varchar(500),
	@w_return_value		int,
	
	@w_error			int,
	@w_trn_code			int,
	@w_msg				mensaje,
	
    @w_filial           int = null,  --@i_filial
    @w_fecha_proceso    datetime,    --@i_fecha_proceso
    @w_ejecucion        varchar(2),  --@i_ejecucion     -- P
    @w_path_archivo     varchar(100) --@i_path_archivo  --Directorio de Salida
   
	
select 	@w_sp_name 		= 'sp_ah_envioctadtn', 
		@w_filial 		= @i_param1,
		@w_fecha_proceso= @i_param2,
		@w_ejecucion 	= @i_param3, 
		@w_path_archivo = @i_param4

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

select @w_archivo = 'ahenvioctadtn.lis'
select @w_tabla   = 'ah_ahenvioctadtn_tmp'

--/****************************************************/
--/*Validar si la fecha ingresada es habil			*/
--/****************************************************/
EXEC	@w_return_value = cob_remesas..sp_fecha_habil
		@i_fecha		=	@w_fecha_proceso,
		@i_oficina		=	1,
		@i_efec_dia		=	'S',
		@i_finsemana	=	'N',
		@w_dias_ret		=	1,
		@o_fecha_sig	=	@w_fecha_aux OUTPUT

if (@w_return_value > 0)
begin
	select 	@w_error 	= @w_return_value,
			@w_msg		= null
	goto ERRORFIN
end
		
--SELECT	@o_fecha_sig	=	@o_fecha_aux
--SELECT	'Return Value'	=	@return_value

/****************************************************/
/* 			                                        */
/****************************************************/
EXEC	@w_return_value	=  cobis..sp_datepart
		@i_fecha		=	@w_fecha_aux,
		@o_anio			=	@w_anio_tmp OUTPUT,
		@o_mes			=	@w_mes_tmp OUTPUT,
		@o_dia			=	@w_dia_tmp OUTPUT

if (@w_return_value > 0)
begin
	select 	@w_error 	= @w_return_value,
			@w_msg		= null
	goto ERRORFIN
end
--SELECT	'Return Value' = @return_value
--SELECT	'Return Value' = @o_anio_tmp
--SELECT	'Return Value' = @o_mes_tmp
--SELECT	'Return Value' = @o_dia_tmp

/****************************************************/
/* 	Encuentra el fin del trimestre                  */
/****************************************************/
if @w_ejecucion = 'P'
begin
	EXEC	@w_return_value = sp_fecha_fin_periodo
			@i_fecha     	= @w_fecha_proceso,
			@i_periodo   	= 3,
			@o_fecha_fin 	= @w_fecha_fin OUTPUT
	
	if (@w_return_value > 0)
	begin
		select 	@w_error 	= @w_return_value,
				@w_msg		= null
		goto ERRORFIN
	end
	
	--SELECT	@o_fecha_fin as N'@o_fecha_fin'
	SELECT 	@w_fecha_proceso = @w_fecha_fin
	--SELECT	'Return Value' = @return_value
end

/****************************************************/
/* 			                                        */
/****************************************************/
EXEC	@w_return_value	=  cobis..sp_datepart
		@i_fecha		=	@w_fecha_proceso,
		@o_anio			=	@w_anio OUTPUT,
		@o_mes			=	@w_mes OUTPUT,
		@o_dia			=	@w_dia OUTPUT

if (@w_return_value > 0)
begin
	select 	@w_error 	= @w_return_value,
			@w_msg		= null
	goto ERRORFIN
end
	
--SELECT	'Return Value' = @return_value
--SELECT	'Return Value' = @o_anio
--SELECT	'Return Value' = @o_mes
--SELECT	'Return Value' = @o_dia

if not exists(select 1 from cob_ahorros..sysobjects where name = 'ah_ahenvioctadtn_tmp')
begin
	create table ah_ahenvioctadtn_tmp 
	(
		cta_banco 		char(16),
		ofi_nombre 		char(64),
		cta_nombre 		char(60),
		saldo_inicial	money,
		remuneracion	money,
		fecha_envio		datetime		
	)
	
	if (@@error > 0)
	begin
		select 	@w_error 	= 357020,
				@w_msg		= 'ERROR AL CREAR LA TABLA ah_ahenvioctadtn_tmp'
		goto ERRORFIN
	end 
end
else
begin
	truncate table ah_ahenvioctadtn_tmp
	
	if (@@error > 0)
	begin
		select 	@w_error 	= 288503,
				@w_msg		= 'ERROR AL ELIMINAR TABLA ah_ahenvioctadtn_tmp'
		goto ERRORFIN
	end 
end

if @w_mes % 3  = 0 and @w_mes <> @w_mes_tmp
begin
	select @w_oficina_inicial = 1
	   
	/* Oficina Máxima*/
	select @w_oficina_final = (select max(of_oficina) from cobis..cl_oficina)

	--select @w_comando = 'select ah_cta_banco, of_nombre, substring(ah_nombre, 1, 40), tn_saldo_inicial, tn_remuneracion, tn_fecha_envio'           
	--select @w_comando =  @w_comando + ' from cob_ahorros..ah_cuenta, cob_remesas..re_tesoro_nacional, cobis..cl_oficina'
	--select @w_comando =  @w_comando + ' where ah_oficina = of_oficina and ah_cta_banco = tn_cuenta and ah_ced_ruc = tn_ced_ruc' 
	--select @w_comando =  @w_comando + ' and ah_filial = 1 and ah_moneda = 0 and tn_estado = ''P'''
	--select @w_comando =  @w_comando + ' and ah_oficina >= ' +  convert (varchar, @w_oficina_inicial) + 'and  ah_oficina <=' + convert (varchar, @w_oficina_final)
	--select @w_comando =  @w_comando + ' and tn_fecha_proceso = ''' + convert(varchar(8), @w_fecha_proceso, 112) + '''' 
	--select @w_comando =  @w_comando + ' order by ah_oficina'
	
	insert into cob_ahorros..ah_ahenvioctadtn_tmp
	select ah_cta_banco, of_nombre, substring(ah_nombre, 1, 40), tn_saldo_inicial, tn_remuneracion, tn_fecha_envio          
		from cob_ahorros..ah_cuenta, cob_remesas..re_tesoro_nacional, cobis..cl_oficina
		where ah_oficina = of_oficina 
		and ah_cta_banco = tn_cuenta 
		and ah_ced_ruc = tn_ced_ruc
		and ah_filial = 1 
		and ah_moneda = 0 
		and tn_estado = 'P'
		and ah_oficina >= @w_oficina_inicial 
		and ah_oficina <= @w_oficina_final
		and tn_fecha_proceso = @w_fecha_proceso
		order by ah_oficina

	if (@@error > 0)
	begin
		select 	@w_error 	= 263500,
				@w_msg		= 'ERROR AL INGRESAR EN TABLA ah_ahenvioctadtn_tmp'
		goto ERRORFIN
	end 
	--exec(@w_comando)

	--select @w_comando = 'bcp cob_ahorros..' + @w_tabla + ' out ' +  @w_path_archivo + @w_archivo +' -U '+ @w_usuario +' -P '+ @w_contrasena +' -S '+ @w_server + ' -c' 
	select @w_comando = 'bcp cob_ahorros..' + @w_tabla + ' out ' +  @w_path_archivo + @w_archivo + ' -T -c'

	if @w_comando is null
    begin
		select 	@w_error 	= 357025,
				@w_msg		= NULL
		goto ERRORFIN   
	end
	
	exec @w_retorno = master..xp_cmdshell @w_comando, no_output

	if @w_retorno > 0
    begin
		select 	@w_error 	= 357023,
				@w_msg		= 'ERROR AL EJECUTAR BCP DE LA TABLA (' + @w_tabla + ')'
		goto ERRORFIN   
	end
end
else
begin
	print  'ESTE PROCESO SE EJECUTA TRIMESTRALMENTE'
end

RETURN 0

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
