/************************************************************************/
/*   Archivo:             conciliar_corresponsal_accion.sp              */
/*   Stored procedure:    sp_conciliar_corresponsal_accion              */
/*   Base de datos:       cob_cartera                                   */
/*   Producto:            Cartera                                       */
/*   Disenado por:        Raymundo Picazo                               */
/*   Fecha de escritura:  Abr.09.                                       */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                              PROPOSITO                               */
/*   Etracion de informacion de los diferentescorresponsales para       */
/*    para obtener una consiliacion                                     */
/************************************************************************/
/*                               MODIFICACIONES                         */
/*  FECHA              AUTOR          CAMBIO                            */
/*  MAR-2019       Raymundo Picazo                                      */
/*                                                                      */
/************************************************************************/ 


use cob_conta_super
go
 

IF OBJECT_ID ('dbo.sp_conciliar_corresponsal_acc') IS NOT NULL
	DROP PROCEDURE dbo.sp_conciliar_corresponsal_acc
GO

CREATE proc sp_conciliar_corresponsal_acc(  
   @s_user                 login, 
   @s_date                 datetime,
   @i_registros            varchar(255),  
   @i_observacion          varchar(255),  
   @i_accion               char(2)             -- Aclarado (AC) / Aplicado (AP) / Reversado (RV) 
)

AS

declare
@w_return			      int,
@w_error			      int,
@w_trn_code               int,
@w_mensaje                varchar(150),
@w_sp_name                varchar(64),
@w_msg                    varchar(255),
@w_commit                 char(1),
@w_corresponsal           varchar (25),
@w_referencia             varchar(25),
@w_estado_no_conci        char(1),
@w_tipo_trn               char(2), 
@w_reverso                char(1),
@w_razon_no_conci         char(2),
@w_relacionados           int,
@w_fecha_reg              datetime,
@w_fecha_valor            datetime,
@w_monto                  money,
@w_archivo                varchar(255),
@w_registro_temp          varchar(255),
@w_valor_reg              varchar(255),
@w_co_ejecutar            char(1),
@w_pos                    int,
@w_delimitador            char(1),
@w_accion                 char(1),
@w_trn_reverso            int,
@w_id_trn_corresp         int,
@w_id_trn_corresp_s       varchar(20),
@w_trn_reverso_s          varchar(20),
@w_fecha_valor_s		  varchar(20),
@w_sp_gen_corresponsal    varchar(50),
@w_monto_archivo		  money



SELECT 
@w_commit = 'N',
@w_estado_no_conci = 'S',
@w_error   = 708199,
@w_co_ejecutar = 'N'

select @w_relacionados = next value for sb_conciliacion_corresponsal_sq

-- ACCION: ACLARAR SIN ACCION 
if @i_accion = 'AC' begin 
   SET @w_delimitador = ';'
   SET @w_registro_temp = @i_registros --+ @w_delimitador
   SET @w_pos = charindex(@w_delimitador,@w_registro_temp)

   if @@TRANCOUNT = 0 begin
      begin tran  
	  select  @w_commit = 'S'
   end
       
   
   WHILE (@w_pos <> 0)
   BEGIN
      SET @w_valor_reg = substring(@w_registro_temp,1,@w_pos - 1)     
      SET @w_registro_temp = substring(@w_registro_temp,@w_pos+1,len(@w_registro_temp))
      SET @w_pos = charindex(@w_delimitador,@w_registro_temp)

	  select
	  @w_corresponsal      =  co_corresponsal
	  from sb_conciliacion_corresponsal 
      where co_id = @w_valor_reg and co_estado_conci = 'N'
	  
	  if @@ROWCOUNT = 0  begin 
	     select 
		 @w_msg     = 'ERROR NO EXISTE REGISTRO O YA ESTA CONCILIADO',
		 @w_error   = 710002
		 goto ERROR_FIN
	  end
	  
      UPDATE sb_conciliacion_corresponsal SET 
      co_relacionados     = @w_relacionados,
      co_estado_conci     = @w_estado_no_conci,			
      co_accion_conci     = @i_accion,
      co_usuario_conci    = @s_user,
      co_observaciones    = @i_observacion,
      co_fecha_conci      = @s_date,
	  co_estado_trn		  = 'P'
      WHERE co_id = @w_valor_reg 
	  
	  if @@ERROR != 0 begin 
	     select 
		 @w_msg = 'ERROR AL ACTUALIAR EL REGISTRO DE LA TABLA cb_correspomsal',
		 @w_error   = 710002
		 goto ERROR_FIN
	  end
	     
   end

   if @w_commit = 'S' begin 
      commit tran 
	  select @w_commit = 'N'
   end

   return 0
end


select 
@w_corresponsal      =  co_corresponsal,
@w_id_trn_corresp    =  co_id_trn_corresp,
@w_referencia        =  co_referencia_pago,
@w_tipo_trn          =  co_tipo_trn, 
@w_reverso           =  co_reverso,
@w_trn_reverso       =  co_trn_reverso,
@w_razon_no_conci    =  co_razon_no_conci, 
@w_fecha_reg         =  co_fecha_registro,
@w_fecha_valor       =  co_fecha_valor,
@w_monto             =  co_monto,
@w_archivo           =  co_archivo
from sb_conciliacion_corresponsal 
where co_id = @i_registros and co_estado_conci = 'N'


	  
if @@ROWCOUNT = 0  begin 
   select 
   @w_msg = 'ERROR NO EXISTE REGISTRO O YA ESTA CONCILIADO',
   @w_error   = 710002
   goto ERROR_FIN
end

select @w_sp_gen_corresponsal = co_sp_generacion_ref    
    from  cob_cartera..ca_corresponsal 
    where co_nombre        = @w_corresponsal 

-- ACCION: APLICAR TRANSACCION FALTANTE 
if @i_accion = 'AP' begin 
   
    -- PAGO DE PRESTAMOS HUERFANO EN COBIS
    if @w_razon_no_conci = 'C' begin 
       select @w_msg = 'ERROR: Este pago ya fue aplicado en COBIS'
       goto ERROR_FIN	  
    end

	if @w_reverso = 'S' and @w_tipo_trn  = 'GL' and @w_razon_no_conci = 'A' begin 
       select @w_msg = 'ERROR: COBIS NO PERMITE el reverso de garantías'
	   goto ERROR_FIN 
    end

	if @w_reverso = 'S' select @w_accion = 'R', @w_id_trn_corresp = @w_trn_reverso 
	if @w_reverso = 'N' select @w_accion = 'I', @w_trn_reverso = 0 
end


-- ACCION REVERSAR TRANSACCION LSOBRANDE 
if @i_accion = 'RV' begin 
   
   --PAGO DE PRESTAMOS HUERFANOS EN ARCHIVO 
   if @w_razon_no_conci = 'A' begin 
      select @w_msg = 'ERROR: Este pago no está aplicado en COBIS'
      goto ERROR_FIN         
   end

   if @w_reverso = 'N' and @w_tipo_trn  = 'GL' and @w_razon_no_conci = 'C' begin 
      select @w_msg = 'ERROR: COBIS NO PERMITE el reverso de garantía'
	  goto ERROR_FIN 
    end

   if @w_reverso = 'S' and @w_tipo_trn  = 'GL' and @w_razon_no_conci = 'C' begin 
      select @w_msg = 'ERROR: No aplica, COBIS no tiene una funcionalidad de reverso de pagos de garantías'
	  goto ERROR_FIN       
   end

   if @w_reverso = 'N' select @w_accion = 'R', @w_id_trn_corresp = @w_trn_reverso
   if @w_reverso = 'S' begin 
      select @w_trn_reverso_s =  cob_cartera.dbo.LlenarI(convert(varchar(20),@w_trn_reverso), '0', 8)
	  
      select
      @w_referencia       = co_referencia,
      @w_id_trn_corresp   = co_trn_id_corresp,    
      @w_monto            = co_monto,
      @w_fecha_valor      = co_fecha_valor
	  from cob_cartera..ca_corresponsal_trn
	  where co_monto = @w_monto and co_trn_id_corresp = @w_trn_reverso_s
      select @w_accion = 'I', @w_trn_reverso = 0
   end
   else
   begin	  
	  
	  exec @w_error 		= @w_sp_gen_corresponsal
	  @i_es_conciliacion 	= 'S',
	  @i_trn_corresp		= @w_id_trn_corresp,
	  @i_fecha_valor        = @w_fecha_valor,
	  @i_monto_pago		    = @w_monto,
	  @o_fecha_archivo    	= @w_fecha_valor_s 		out,	  
	  @o_trn_corresponsal	= @w_id_trn_corresp_s 	out,
	  @o_monto_archivo      = @w_monto_archivo      out
	  
	  select @w_monto = @w_monto_archivo
   end
end
else
begin
	exec @w_error 			= @w_sp_gen_corresponsal
	  @i_es_conciliacion 	= 'S',
	  @i_trn_corresp		= @w_id_trn_corresp,
	  @i_fecha_valor        = @w_fecha_valor,
	  @i_monto              = @w_monto,
	  @o_fecha_archivo    	= @w_fecha_valor_s 		out,	  
	  @o_trn_corresponsal	= @w_id_trn_corresp_s 	out,
	  @o_monto_archivo      = @w_monto_archivo      out
	  
	  select @w_monto = @w_monto_archivo
end

if @w_referencia = '' begin
   select 
   @w_error = 701085,
   @w_msg  = 'NO SE INGRESO CODIGO DE REFERENCIA '  
   goto ERROR_FIN
end

EXECUTE  @w_error  =  cob_cartera..sp_pagos_corresponsal 
@s_date            = @s_date,
@s_user            = @s_user,
@s_ofi             = 1101,
@s_rol             = 3,
@i_operacion       = 'I',-- (B)atch, (S)ervicio, (C)onciliacion manual , (I) Insercion
@i_referencia      = @w_referencia, -- no obligatorio para batch
@i_corresponsal    = @w_corresponsal, --'OPEN_PAY', -- no obligatorio para batch
@i_trn_id_corresp  = @w_id_trn_corresp_s,
@i_moneda          = 0, -- obligatoria para el servicio
@i_fecha_valor     = @w_fecha_reg, -- obligatoria para el servicio
@i_status_srv      = NULL, -- obligatoria para el servicio
@i_accion          = @w_accion,  
@i_observacion     = 'ok ', -- obligatoria para la conciliacion
@i_monto_pago      = @w_monto, --monto del pago
@i_fecha_pago      = @w_fecha_valor_s, --fecha de pago
@i_archivo_pago    = @w_archivo,
@o_msg             = @w_msg
         
if @w_error <> 0 begin
   select 
   @w_error = @w_error,
   @w_msg  = 'NO SE INSERTO EL REGISTRO PAGO CORRESPONSAL'   
   goto ERROR_FIN
end		                              

UPDATE sb_conciliacion_corresponsal SET 
co_secuencial       = @w_relacionados,
co_estado_conci     = @w_estado_no_conci,			
co_accion_conci     = @i_accion,
co_usuario_conci    = @s_user,
co_observaciones    = @i_observacion,
co_fecha_conci      = @s_date,
co_estado_trn		= 'P'
WHERE co_id = @i_registros

return 0

ERROR_FIN:

if @w_commit = 'S' begin 
   ROLLBACK tran 
   select @w_commit = 'N'
end

exec cob_ahorros..sp_errorlog 
@i_fecha       = @s_date,
@i_error       = @w_error,
@i_usuario     = @s_user,
@i_tran        = @w_trn_code,
@i_descripcion = @w_msg,
@i_programa    = @w_sp_name

exec cobis..sp_cerror 
@t_debug = 'N', 
@t_file  = null,
@t_from  = @w_sp_name,
@i_num   = @w_error,
@i_msg   = @w_msg
return @w_error 

GO