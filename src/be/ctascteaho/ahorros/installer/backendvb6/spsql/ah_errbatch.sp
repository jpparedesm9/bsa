
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
/************************************************************************/

USE [cob_ahorros]
GO

if object_id('sp_aherrbatch') is not null
begin
  drop procedure sp_aherrbatch
  if object_id('sp_aherrbatch') is not null
    print 'FAILED DROPPING PROCEDURE sp_aherrbatch'  
end

go

create procedure  sp_aherrbatch

    --Parámetros para regístro de log ejecución 
   
    @t_show_version     bit = 0,
    @i_path_archivo     varchar(30) = null,    --Directorio de Salida
    @i_fecha_desde      datetime,
    @i_fecha_hasta      datetime,

	@i_usuario			varchar(10),
	@i_contrasena       varchar(10),
	@i_server			varchar(15),
   
   --Parametros para registro de log ejecución 
    @i_sarta            int = null,
    @i_batch            int = null,
    @i_secuencial       int = null,
    @i_corrida          int = null,
    @i_intento          int = null,
    @o_registros        int  = 0 output
	
AS 
    
	declare

	@w_retorno      int,
	@w_retorno_ej   int,
	@w_sp_name      varchar(30),
	@w_vista        varchar(64),
	@w_comando      varchar(255),
	@w_archivo      varchar(32),
	@w_path_sapp    varchar(32)

	select @w_sp_name = 'sp_aherrbatch'

	if @t_show_version = 1
	begin
		 print 'Stored procedure: %1/ Version: %2/'+ @w_sp_name + '4.0.0.0'
		return 0
	end
	
	select @w_archivo = 'aherrbatch.lis'        
    select @w_vista   = 'vw_ah_errorlog'

	if exists (select 1 from sysobjects where name = @w_vista and type = 'V')   
	begin
		drop view vw_ah_errorlog
	end

	/*Creando vista  Procesa las transacciones monetarias de la oficina activa */   
	
	select @w_comando = 'create view vw_ah_errorlog as select er_fecha_proc ,er_error,er_usuario,er_tran,er_cuenta,er_descripcion,er_programa,er_cta_pagrec'
	select @w_comando = @w_comando + ' from cob_ahorros..ah_errorlog where er_fecha_proc >= '''+ convert(varchar(8), @i_fecha_desde,112) +'''' 
	select @w_comando = @w_comando + ' and er_fecha_proc <= ''' + convert(varchar(8), @i_fecha_hasta,112) + ''''
	exec(@w_comando)

	
	if not exists (select 1 from sysobjects where name = 'vw_ah_errorlog' and type = 'V')
	begin
		exec @w_retorno_ej = cobis..sp_ba_error_log
			@i_sarta        = @i_sarta,
			@i_batch        = @i_batch,
			@i_secuencial   = @i_secuencial,
			@i_corrida      = @i_corrida,
			@i_intento      = @i_intento,
			@i_error        = @w_retorno,
			@i_detalle      = 'Error create view vw_ah_errorlog'

    if @w_retorno_ej > 0
    begin
        return @w_retorno_ej
    end
    else
        return @w_retorno
	end    

	--Obtener bcp de la tabla

    select @w_comando = null
	select @w_comando = 'bcp cob_ahorros..' + @w_vista + ' out ' +  @i_path_archivo + @w_archivo +' -U '+ @i_usuario +' -P '+ @i_contrasena +' -S '+ @i_server + ' -c' --     -b1000 -t -e ../listados/'  + @w_archivo + '.err > ../listados/' + @w_archivo + '.out'
	exec @w_retorno = master..xp_cmdshell @w_comando,no_output

	if @w_retorno > 0
    begin
    exec @w_retorno_ej = cobis..sp_ba_error_log
        @i_sarta        = @i_sarta,
        @i_batch        = @i_batch,
        @i_secuencial   = @i_secuencial,
        @i_corrida      = @i_corrida,
        @i_intento      = @i_intento,
        @i_error        = @w_retorno,
        @i_detalle      = 'Error ejecucion de bcp'

    if @w_retorno_ej > 0
    begin
        return @w_retorno_ej
    end
	  
    return @w_retorno    
end

