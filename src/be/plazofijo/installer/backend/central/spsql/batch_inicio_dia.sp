/*bt_india.sp*/
/************************************************************************/
/*      Archivo:                bt_india.sp                             */
/*      Stored procedure:       sp_batch_inicio_dia                     */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Miryam Davila                           */
/*      Fecha de documentacion: 24/Oct/94                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este script crea los procedimientos para las Actualizaciones    */
/*      de inicio de dia del modulo de Plazo Fijo.                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA        AUTOR              RAZON                           */
/*      25-Nov-94    Juan Lam           Creacion                        */
/*      16-Nov-2005  N. Silva           Indentacion                     */                                                 
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_batch_inicio_dia' and type = 'P')
   drop proc sp_batch_inicio_dia
go
create proc sp_batch_inicio_dia (
@s_ssn                  int         = NULL,
@s_user                 login       = NULL,
@s_term                 varchar(30) = NULL,
@s_date                 datetime    = NULL,
@s_srv                  varchar(30) = NULL,
@s_lsrv                 varchar(30) = NULL,
@s_ofi                  smallint    = NULL,
@s_rol                  smallint    = NULL,
@t_debug                char(1)     = NULL,
@t_file                 varchar(10) = NULL,
@t_trn                  int         = NULL,
@i_fin_dia          	char(1)     = 'N',
@i_fecha_proceso 	    datetime    = NULL)
with encryption
as
declare 
        @w_sp_name              descripcion,
        @w_return               int,
        @w_error                int,
	@w_ssn			int,
        @w_secuencial           int,
        @w_fecha_hoy_char       varchar(10), 
	@w_fecha_hoy            datetime,
	@w_rc_fecha_inicio_dia  datetime,
	@w_rc_fecha_final_dia   datetime,
	@w_rc_fecha_fin_mes     datetime,
	@w_fecha_proceso        datetime,
	@w_formato_fecha        int,
        @w_mensaje              descripcion,
	@w_confirma             char(1),
	@w_pago_interes         char(1),
        @w_instruccion          char(1)


/*---------*/
/*  DEBUG  */
/*---------*/
select @w_sp_name       = 'sp_batch_inicio_dia',
       @s_user          = isnull(@s_user,'sa'),
       @s_term          = isnull(@s_term,'CONSOLA'),
       @i_fecha_proceso = isnull(@i_fecha_proceso,@s_date),  
       @s_date          = @i_fecha_proceso,
       @s_srv           = isnull(@s_srv,@@servername),
       @s_lsrv          = isnull(@s_lsrv,@@servername),
       @s_ofi           = 99,
       @s_rol           = 1,
       @t_debug         ='N',
       @t_file          ='SQR',
       @t_trn           = 14999

       
----------------------------
-- Obtener formato de fecha
----------------------------
select @w_formato_fecha = pa_int 
  from cobis..cl_parametro 
 where pa_nemonico = 'FORF' 
   and pa_producto = 'PFI'

select @w_error = 0, @w_mensaje = ''

-------------------------------------------------
-- Obtener parametros de la tabla pf_reg_control
-------------------------------------------------
select @w_rc_fecha_final_dia   =  rc_fecha_final_dia,
       @w_rc_fecha_inicio_dia  =  rc_fecha_inicio_dia,
       @w_rc_fecha_fin_mes     =  rc_fecha_fin_mes
  from pf_reg_control

select @w_rc_fecha_final_dia  = convert(datetime,convert(varchar,@w_rc_fecha_final_dia,101)),
       @w_rc_fecha_inicio_dia = convert(datetime,convert(varchar,@w_rc_fecha_inicio_dia,101)),
       @w_rc_fecha_fin_mes    = convert(datetime,convert(varchar,@w_rc_fecha_fin_mes,101)),
       @w_fecha_proceso       = convert(datetime,convert(varchar,@i_fecha_proceso,101))


if @w_rc_fecha_inicio_dia  <> @w_rc_fecha_final_dia
begin
  print 'FECHA CONTROL FIN DE DIA INDICA QUE NO SE EJECUTO EL CIERRE'
  select @w_error = 149024
  goto ERROR
end

if @w_rc_fecha_inicio_dia  >= @w_fecha_proceso
begin
  print 'FECHA DE INICIO CONTROL, MAYOR QUE FECHA DE PROCESO (FECHA DE PROCESO INCORRECTA)'
  select @w_error = 149025
  goto ERROR
end

if @w_rc_fecha_final_dia >= @w_fecha_proceso 
begin
  print 'FECHA DE FIN DIA CONTROL, MAYOR QUE FECHA DE PROCESO (FECHA DE PROCESO INCORRECTA)'
  select @w_error = 149026
  goto ERROR
end

select @w_fecha_hoy = dateadd( dd,1,@w_rc_fecha_inicio_dia)

while @w_fecha_hoy <= @w_fecha_proceso
begin
	select 	@w_confirma     = 'S',
		@w_pago_interes = 'S',
        	@w_instruccion  = 'S'

        --------------------------------------------------
	-- Llamada a proceso de confirmacion de depositos
	--------------------------------------------------        
        select @w_fecha_hoy_char = convert(varchar(10),@w_fecha_hoy,101)

	CONFIRMACION:
	---------------------------------------------------------------
	--CONFIRMACION DE DEPOSITOS EN ESTADO XACT
	---------------------------------------------------------------
	--I. CVA Jun-14-06 implementacion para obtener seqnos del kernel
	exec @w_ssn = ADMIN...rp_ssn
	select @w_secuencial = @w_ssn
	--F. CVA Jun-14-06 implementacion para obtener seqnos del kernel
       

select @t_debug = 'S' 

IF @t_debug = 'S' print 'sp_batch_levanta_bloqueo_canje'	


	exec @w_return = sp_batch_levanta_bloqueo_canje  
		@s_ssn           = @w_secuencial,
		@s_user          = @s_user,
		@s_term          = @s_term,
		@s_date          = @s_date, 
		@s_srv           = @s_srv,
		@s_lsrv          = @s_lsrv, 
		@s_ofi           = @s_ofi,
		@s_rol           = @s_rol,
		@t_debug         = @t_debug, 
		@t_file          = @t_file, 
		@t_from          = @w_sp_name

IF @t_debug = 'S' print 'sp_batch_confirma  '	


	exec @w_return = sp_batch_confirma  
		@s_ssn           = @w_secuencial,
		@s_user          = @s_user,
		@s_term          = @s_term,
		@s_date          = @s_date, 
		@s_srv           = @s_srv,
		@s_lsrv          = @s_lsrv, 
		@s_ofi           = @s_ofi,
		@s_rol           = @s_rol,
		@t_debug         = @t_debug, 
		@t_file          = @t_file, 
		@t_from          = @w_sp_name,
		@t_trn           = 14924 , 
		@i_fecha_proceso = @w_fecha_hoy_char,
		@i_en_linea      = 'N' 
	if @w_return <> 0
        begin
             print 'bt_india.sp ERROR EN SP_BATCH_CONFIRMA'
	     select @w_error =  @w_return,
                    @w_mensaje = 'bt_india.sp ERROR SP_BATCH_CONFIRMA',
		    @w_confirma = 'N'
             goto ERROR
        end



	PAGO_INTERES:
	---------------------------------------------------------------
	--PAGO DE INTERES Y DISIMUNICION AUTOMATICA PARA BONOS
	---------------------------------------------------------------
	--I. CVA Jun-14-06 implementacion para obtener seqnos del kernel
	exec @w_ssn = ADMIN...rp_ssn
	select @w_secuencial = @w_ssn
	--F. CVA Jun-14-06 implementacion para obtener seqnos del kernel


   	exec    @w_return = sp_inicio_de_dia
        	@s_ssn           = @w_secuencial,
        	@s_user          = @s_user,
        	@s_term          = @s_term, 
        	@s_date          = @s_date,
        	@s_srv           = @s_srv, 
        	@s_lsrv          = @s_lsrv, 
        	@s_ofi           = @s_ofi,  
        	@s_rol           = @s_rol,
        	@t_debug         = @t_debug,
        	@t_file          = @t_file,
        	@t_from          = @w_sp_name,
        	@t_trn           = 14999 ,
        	@i_fecha_proceso = @w_fecha_hoy_char,
        	@i_formato_fecha = @w_formato_fecha, 
        	@i_en_linea      = 'N'
   	if @w_return <> 0
   	begin
		print 'bt_india.sp ERROR EN SP_INICIO_DE_DIA '
      		select @w_error   = @w_return,
             	       @w_mensaje = 'bt_india.sp ERROR SP_INICIO_DE_DIA',
		       @w_pago_interes = 'N'
      		goto ERROR
   	end


        ------------------------------------------------------------
   	-- PROCESO CANCELACION DE CAPITAL POR CONCEPTO DE EMBARGO --
   	------------------------------------------------------------

	print '@i_fecha_proceso  ' + cast ( @i_fecha_proceso as varchar)
	print '@w_fecha_hoy_char ' + cast (@w_fecha_hoy_char as varchar)

        exec @w_return = sp_embargo_cap
	     @s_ssn           = @w_secuencial, 	
	     @s_user          = @s_user,
	     @s_term          = @s_term, 				
	     @s_date          = @s_date, 
	     @s_srv           = @s_srv,						
	     @s_lsrv          = @s_lsrv, 
	     @s_ofi           = @s_ofi, 						
	     @s_rol           = @s_rol,
	     @t_debug         = @t_debug, 				
	     @t_file          = @t_file, 
	     @t_from          = @w_sp_name,				
             @i_fecha_proceso = @w_fecha_hoy_char

	if @w_return <> 0 
	begin
          print 'bt_india.sp ERROR EN CAN-EMB SP_BATCH_INICIO_DIA  '
	  select @w_error = @w_return,
                 @w_mensaje = 'bt_india.sp ERROR CAN-EMB SP_BTACH_INICIO_DIA',
		 @w_instruccion = 'N'
	  goto ERROR
	end


	exec 	@s_ssn = ADMIN...rp_ssn
	exec 	@w_return=sp_batch_emision_cheque
	     	@s_ssn           = @s_ssn,
	     	@s_user          = @s_user,
	     	@s_term          = @s_term,
	     	@s_date          = @s_date, 
     		@s_srv           = @s_srv,
     		@s_lsrv          = @s_lsrv,
     		@s_rol           = @s_rol,
     		@s_ofi           = @s_ofi, 
     		@t_debug         = @t_debug, 
     		@t_file          = @t_file,
     		@t_from          = @w_sp_name,
     		@t_trn           = 14955 ,
     		@i_fecha_proceso = @w_fecha_hoy_char,
     		@i_formato_fecha = 101,
     		@i_en_linea      = 'N'

	if @w_return <> 0 
	begin
          	print 'bt_india.sp ERROR EN batch-emic-cheque SP_BATCH_INICIO_DIA  '
     		select @w_mensaje = 'Error devuelto por sp_batch_emision_cheque SP_BTACH_INICIO_DIA'
     		select @w_error   = @w_return
     		goto ERROR
	end


IF @t_debug = 'S' print 'sp_batch_accionsgt INI'	


	INSTRUCCION:
        --------------------------------------------
   	-- Proceso para Instrucciones en Operaciones
   	---------------------------------------------
	--I. CVA Jun-14-06 implementacion para obtener seqnos del kernel
	exec @w_ssn = ADMIN...rp_ssn
	select @w_secuencial = @w_ssn
	--F. CVA Jun-14-06 implementacion para obtener seqnos del kernel

   	exec @w_return = sp_batch_accionsgt 
	     @s_ssn           = @w_secuencial, 	
	     @s_user          = @s_user,
	     @s_term          = @s_term, 				
	     @s_date          = @s_date, 
	     @s_srv           = @s_srv,						
	     @s_lsrv          = @s_lsrv, 
	     @s_ofi           = @s_ofi, 						
	     @s_rol           = @s_rol,
	     @t_debug         = @t_debug, 				
	     @t_file          = @t_file, 
	     @t_from          = @w_sp_name,				
	     @t_trn           = 14925 , 
	     @i_fecha_proceso = @w_fecha_hoy_char,
	     @i_oficina       = 'T',
	     @i_ciudad        = 'T',
	     @i_hora          = 0,
	     @i_en_linea      = 'N'
	if @w_return <> 0 
	begin
          print 'bt_india.sp ERROR EN SP_BATCH_ACCIONSGT'
	  select @w_error = @w_return,
                 @w_mensaje = 'bt_india.sp ERROR SP_BATCH_ACCIONSGT',
		 @w_instruccion = 'N'
	  goto ERROR
	end

IF @t_debug = 'S' print 'sp_batch_accionsgt FIN '	


   SECUENCIA:
   update pf_reg_control 
      set rc_fecha_inicio_dia = @w_fecha_hoy

   if @w_fecha_hoy < @w_fecha_proceso
   begin
        print 'bt_india.sp ANTES DE FINDIA  ===> FECHA_HOY '+ cast( @w_fecha_hoy as varchar) +'FECHA_PROCESO '  + cast( @w_fecha_proceso as varchar) 

	--I. CVA Jun-14-06 implementacion para obtener seqnos del kernel
	exec @w_ssn = ADMIN...rp_ssn
	select @w_secuencial = @w_ssn
	--F. CVA Jun-14-06 implementacion para obtener seqnos del kernel
    

IF @t_debug = 'S' print 'sp_batch_fin_dia'	

      exec @w_return = sp_batch_fin_dia 
           @s_ssn           = @w_secuencial, 
           @s_user          = @s_user,
           @s_term          = @s_term, 
           @s_date          = @s_date,
           @s_srv           = @s_srv, 
           @s_lsrv          = @s_lsrv, 
           @s_ofi           = @s_ofi,
           @s_rol           = @s_rol,
           @t_debug         = @t_debug,
           @t_file          = @t_file,
           @t_trn           = 14999 , 
           @i_fecha_proceso = @w_fecha_hoy_char,
           @i_batch_inidia  = 'S',
           @i_en_linea      = 'N'
      if @w_return <> 0
      begin
         print 'bt_india.sp ERROR EN SP_BATCH_FIN_DIA'
         select @w_error = @w_return,
                @w_mensaje = 'ERROR SP_BATCH_FIN_DIA'
         goto ERROR
      end
   end
  
   --I.CVA Jun-14-06 Proceso implementado para d¡as no laborables
   if @i_fin_dia = 'S' and @w_fecha_hoy = @w_fecha_proceso
   begin
	print '-----BATCH DE FIN DIA PARA DIAS NO LABORABLES --------'
        print 'BT_INDIA.SP EJECUTANDO FIN DIA fecha %1!' + cast( @w_fecha_proceso  as varchar) 

	--I. CVA Jun-14-06 implementacion para obtener seqnos del kernel
	exec @w_ssn = ADMIN...rp_ssn
	select @w_secuencial = @w_ssn
	--F. CVA Jun-14-06 implementacion para obtener seqnos del kernel
    
      exec @w_return = sp_batch_fin_dia 
           @s_ssn           = @w_secuencial, 
           @s_user          = @s_user,
           @s_term          = @s_term, 
           @s_date          = @s_date,
           @s_srv           = @s_srv, 
           @s_lsrv          = @s_lsrv, 
           @s_ofi           = @s_ofi,
           @s_rol           = @s_rol,
           @t_debug         = @t_debug,
           @t_file          = @t_file,
           @t_trn           = 14999 , 
           @i_fecha_proceso = @w_fecha_hoy_char,
           @i_batch_inidia  = 'S', 
           @i_en_linea      = 'N'
      if @w_return <> 0
      begin
	 print 'bt_india.sp ERROR EN SP_BATCH_FIN_DIA'
         select @w_error = @w_return,
                @w_mensaje = 'ERROR SP_BATCH_FIN_DIA'
         goto ERROR
      end
   end
   --F.CVA Jun-14-06 Proceso implementado para d¡as no laborables

   select @w_fecha_hoy = dateadd( dd,1,@w_fecha_hoy)

   print 'BT_INDIA.SP CAMBIA FECHA_HOY ' + cast( @w_fecha_hoy as varchar) 


end

return 0

ERROR:  

  exec sp_errorlog @i_fecha       = @s_date,
                   @i_error       = @w_error, 
                   @i_usuario     = @s_user,
                   @i_tran        = @t_trn,
                   @i_descripcion = @w_mensaje,
                   @i_cuenta      = ' '

/******************

  --Error en primer proceso se Inicio de Dia
  if @w_confirma = 'N'
  begin
     select @w_confirma = 'S'
     goto PAGO_INTERES
  end

  --Error en segundo proceso de Inicio de Dia
  if @w_pago_interes = 'N'
  begin
     select @w_pago_interes = 'S'
     goto INSTRUCCION
  end

  --Error en tercer proceso de Inicio de Dia
  if @w_instruccion = 'N'
  begin
    select @w_instruccion = 'S'
    goto  SECUENCIA
  end
********************************/

  return 0 --No enviar error al Visual Batch
go

