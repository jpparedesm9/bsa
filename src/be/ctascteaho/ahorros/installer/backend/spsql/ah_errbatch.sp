/************************************************************************/
/*      Archivo           :  aherrbatch.sp  	                        */
/*      Base de datos     :  cob_ahorros                                */
/*      Producto          :  Cuentas de Ahorro                          */
/*      Disenado por      :  Andres Enriquez                            */
/*      Fecha de escritura:  23/May/2016                                */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "COBISCORP", representantes exclusivos para el Ecuador de la   	*/
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Emite el diario de operaciones monetarias por oficina           */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR           RAZON                           */
/*      23/May/2016     A Enriquez      Emision Inicial	                */ 
/*      18/Jul/2016     T Baidal        Modificación nombres parametros */
/*                                      y llamada a sp sp_errorlog      */
/************************************************************************/

USE cob_ahorros
GO

if object_id('sp_aherrbatch') is not null
begin
	drop procedure sp_aherrbatch
	if object_id('sp_aherrbatch') is not null
		print 'FAILED DROPPING PROCEDURE sp_aherrbatch'  
end

go

create procedure sp_aherrbatch
(
	--Parámetros para regístro de log ejecución    
	@t_show_version     bit = 0,
	
	@i_param1         	int, 			--@i_filial
	--@i_param1           datetime,     --@i_fecha_proceso
	@i_param2           datetime,       --@i_fecha_desde
	@i_param3           datetime,       --@i_fecha_hasta
	@i_param4           varchar(100) 	--@i_path_archivo Directorio de Salida

	--Parametros para registro de log ejecución 
	----@i_sarta            int = null,
	----@i_batch            int = null,
	----@i_secuencial       int = null,
	----@i_corrida          int = null,
	----@i_intento          int = null,
)
AS
declare
	@w_retorno       int,
    @w_retorno_ej    int,
    @w_sp_name       varchar(30),
    @w_tabla         varchar(64),
    @w_comando       varchar(500),
    @w_archivo       varchar(32),
    @w_path_sapp     varchar(32),

    @w_fecha_proceso datetime,    --@i_fecha_proceso
	@w_fecha_desde   datetime,    --@i_fecha_desde
    @w_fecha_hasta   datetime,    --@i_fecha_hasta
    @w_path_archivo  varchar(100), --@i_path_archivo 
	@w_path_s_app    varchar(100),
	
	@w_error		 int,
	@w_trn_code		 int,
	@w_msg			 mensaje,
	
    @w_filial		 int = null  --@i_filial

select 	@w_sp_name 		= 'sp_aherrbatch', 
		@w_filial 		= @i_param1,
		--@w_fecha_proceso= @i_param1, 
		@w_fecha_desde 	= @i_param2, 
		@w_fecha_hasta 	= @i_param3,
		@w_path_archivo = @i_param4

if @t_show_version = 1
begin
	print 'Stored Procedure = ' + @w_sp_name + ' Version = ' + '4.0.0.0'
	return 0
end

select @w_path_s_app = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'S_APP'

if @w_path_s_app is null begin
    select @w_error = 999999, @w_msg = 'NO EXISTE PARAMETRO GENERAL S_APP'
    goto ERRORFIN
end


if not exists (select 1 from cobis..cl_filial where fi_filial = @w_filial)
begin
	select 	@w_error 	= 101002,
			@w_msg		= null
	goto ERRORFIN
end
	
select @w_archivo = 'aherrbatch.lis'        
select @w_tabla   = 'vw_ah_errorlog'

if exists (select 1 from sysobjects where name = @w_tabla and type = 'V')   
begin
	drop view vw_ah_errorlog
		
	if (@@error > 0)
	begin
		select 	@w_error 	= 357021,
				@w_msg		= 'ERROR AL ELIMINAR LA VISTA vw_ah_errorlog'
		goto ERRORFIN
	end 
end

select	@w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

/*Creando vista  Procesa las transacciones monetarias de la oficina activa */   
select @w_comando = 'create view vw_ah_errorlog as '
select @w_comando = @w_comando + ' select er_fecha_proc, er_usuario, er_error, er_tran, er_cuenta, er_cta_pagrec, er_programa, er_descripcion'
select @w_comando = @w_comando + ' from cob_ahorros..ah_errorlog '
select @w_comando = @w_comando + ' where er_fecha_proc >= ' + char(39) + convert(varchar(8), @w_fecha_desde,112) + char(39)
select @w_comando = @w_comando + ' and er_fecha_proc <= ' + char(39) + convert(varchar(8), @w_fecha_hasta,112) + char(39)

exec(@w_comando)

--Obtener bcp de la tabla

select @w_comando = null
--select @w_comando = 'bcp cob_ahorros..' + @w_tabla + ' out ' +  @w_path_archivo + @w_archivo +' -U '+ @w_usuario +' -P '+ @w_contrasena +' -S '+ @w_server + ' -c' --     -b1000 -t -e ../listados/'  + @w_archivo + '.err > ../listados/' + @w_archivo + '.out'
select @w_comando = @w_path_s_app + 's_app bcp -auto -login cob_ahorros..' + @w_tabla + ' out ' +  @w_path_archivo + @w_archivo + ' -T -c -e '+ @w_path_archivo + @w_archivo + '.err -config '+ @w_path_s_app + 's_app.ini'

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

go
