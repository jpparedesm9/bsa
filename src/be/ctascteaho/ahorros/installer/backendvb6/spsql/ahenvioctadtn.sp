
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
/*      FECHA           AUTOR           RAZON                           */
/*      25/May/2016     A Enriquez      Emision Inicial	                */ 
/************************************************************************/

USE [cob_ahorros]
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
	@i_filial			int = null,
	@i_fecha_proceso	datetime,
	@i_ejecucion		varchar(2),                  -- P
	@i_path_archivo     varchar(30) = null,          --Directorio de Salida
	@i_usuario			varchar(10),
	@i_contrasena       varchar(10),
	@i_server			varchar(15),

--Parámetros para regístro de log ejecución 
   
   	@t_show_version     bit = 0,
    @i_sarta            int = null,
    @i_batch            int = null,
    @i_secuencial       int = null,
    @i_corrida          int = null,
    @i_intento          int = null,
    @o_registros        int  = 0 output
)	
AS
	DECLARE

	@w_retorno			int,
	@w_retorno_ej		int,
	@w_sp_name			varchar(30),
	@o_fecha_fin		datetime,
    @o_fecha_aux		datetime,
	@o_fecha_sig		datetime,
	@o_anio_tmp			int,
	@o_mes_tmp			int,
	@o_dia_tmp			int,
	@o_anio				int,
	@o_mes				int,
	@o_dia				int,
	@oficina_inicial	int,
	@oficina_final		int,
	@w_vista			varchar(64),
	@w_archivo			varchar(32),
	@w_comando			varchar(500),
	@return_value		int

	
	select @w_sp_name = 'sp_aherrbatch'

	if @t_show_version = 1
	begin
		 print 'Stored procedure: %1/ Version: %2/'+ @w_sp_name + '4.0.0.0'
		return 0
	end
	
	select @w_archivo = 'ahenvioctadtn.lis'        
    select @w_vista   = 'vw_ahenvioctadtn'

	

	--/****************************************************/
	--/*Validar si la fecha ingresada es habil			*/
	--/****************************************************/
	EXEC	@return_value = cob_remesas..sp_fecha_habil
			@i_fecha		=	@i_fecha_proceso,
			@i_oficina		=	1,
			@i_efec_dia		=	'S',
			@i_finsemana	=	'N',
			@w_dias_ret		=	1,
			@o_fecha_sig	=	@o_fecha_aux OUTPUT

	SELECT	@o_fecha_sig	=	@o_fecha_aux
	SELECT	'Return Value'	=	@return_value

	/****************************************************/
	/* 			                                        */
	/****************************************************/
	EXEC	@return_value	=  cobis..sp_datepart
			@i_fecha		=	@o_fecha_aux,
			@o_anio			=	@o_anio_tmp OUTPUT,
			@o_mes			=	@o_mes_tmp OUTPUT,
			@o_dia			=	@o_dia_tmp OUTPUT

	SELECT	'Return Value' = @return_value
	SELECT	'Return Value' = @o_anio_tmp
	SELECT	'Return Value' = @o_mes_tmp
	SELECT	'Return Value' = @o_dia_tmp

	
	if @i_ejecucion = 'P'
	/****************************************************/
	/* 	Encuentra el fin del trimestre                  */
	/****************************************************/
	begin
			
		EXEC	@return_value = sp_fecha_fin_periodo
				@i_fecha     = @i_fecha_proceso,
				@i_periodo   = 3,
				@o_fecha_fin = @o_fecha_fin OUTPUT

		SELECT	@o_fecha_fin as N'@o_fecha_fin'
		SELECT @i_fecha_proceso = @o_fecha_fin
		SELECT	'Return Value' = @return_value
		
    end

	

	/****************************************************/
	/* 			                                        */
	/****************************************************/
	EXEC	@return_value	=  cobis..sp_datepart
			@i_fecha		=	@i_fecha_proceso,
			@o_anio			=	@o_anio OUTPUT,
			@o_mes			=	@o_mes OUTPUT,
			@o_dia			=	@o_dia OUTPUT

	SELECT	'Return Value' = @return_value
	SELECT	'Return Value' = @o_anio
	SELECT	'Return Value' = @o_mes
	SELECT	'Return Value' = @o_dia



	if @o_mes % 3  = 0 and @o_mes <> @o_mes_tmp
	begin
	   set @oficina_inicial = 1
	   
	   /* Oficina Máxima*/
	   set @oficina_final = (select max(of_oficina)  from cobis..cl_oficina)
	    
        select @w_comando = 'select of_nombre, ah_cta_banco ,substring(ah_nombre,1,40),	tn_saldo_inicial,tn_remuneracion,tn_fecha_envio'           
		select @w_comando =  @w_comando + ' from cob_ahorros..ah_cuenta, cob_remesas..re_tesoro_nacional ,cobis..cl_oficina'
		select @w_comando =  @w_comando + ' where ah_oficina = of_oficina and ah_cta_banco = tn_cuenta  and ah_ced_ruc = tn_ced_ruc' 
		select @w_comando =  @w_comando + ' and ah_filial = 1 and ah_moneda = 0 and tn_estado = ''P'''
  	    select @w_comando =  @w_comando + ' and ah_oficina >= ' +  convert (varchar,@oficina_inicial ) + 'and  ah_oficina <=' + convert (varchar, @oficina_final  )
		select @w_comando =  @w_comando + ' and tn_fecha_proceso = ''' + convert(varchar(8), @i_fecha_proceso,112) + '''' 
		select @w_comando =  @w_comando + ' order by ah_oficina'
		
      	exec(@w_comando)

	    select @w_comando = 'bcp cob_ahorros..' + @w_vista + ' out ' +  @i_path_archivo + @w_archivo +' -U '+ @i_usuario +' -P '+ @i_contrasena +' -S '+ @i_server + ' -c' 
	    exec @w_retorno = master..xp_cmdshell @w_comando ,no_output

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
	drop view vw_ahenvioctadtn	
   end 
GO

