 /***********************************************************************/
/*   Archivo:             camestop.sp                                   */
/*   Stored procedure:    sp_cambio_estado_op                           */
/*   Base de datos:       cob_cartera                                   */
/*   Producto:            Credito y Cartera                             */
/*   Disenado por:        Fabian de la Torre                            */
/*   Fecha de escritura:  31/08/1999                                    */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   "MACOSA".                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                           PROPOSITO                                  */
/*   Maneja los cambios de estado de las operaciones: invocacion interna*/
/************************************************************************/
/*                               CAMBIOS                                */
/*      FECHA          AUTOR            CAMBIO                          */
/*      DIC-07-2016    Raul Altamirano  Emision Inicial - Version MX    */
/************************************************************************/  

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_cambio_estado_op')
   drop proc sp_cambio_estado_op
go

SET ANSI_NULLS ON
go

create proc sp_cambio_estado_op(
   @s_user           login,
   @s_term           varchar(30),
   @s_date           datetime,
   @s_ofi            smallint,
   @i_banco          cuenta,
   @i_fecha_proceso  datetime,
   @i_estado_ini     int = null, 
   @i_estado_fin     int = null,
   @i_tipo_cambio    char(1),
   @i_front_end      char(1) = 'N',
   @i_en_linea       char(1),
   @i_cambio_EstCobranza  char(1) = 'N',
   @o_msg            varchar(100) = null out  )

as
declare
   @w_error             int,
   @w_moneda            tinyint,
   @w_moneda_local      tinyint,
   @w_estado_actual     tinyint,
   @w_num_dec           smallint,
   @w_moneda_nac        smallint,
   @w_num_dec_mn        smallint,
   @w_toperacion        catalogo,
   @w_oficina           int,
   @w_operacionca       int,
   @w_gerente           int,
   @w_est_suspenso      tinyint,
   @w_edad              tinyint,
   @w_garantia          char(1), 
   @w_reestructuracion  char(1), 
   @w_calificacion      char(1), 
   @w_est_castigado     tinyint,
   @w_est_anulado       tinyint,
   @w_fecha_ult_proceso datetime,
   @w_estado_op         tinyint

   
select @w_moneda_local = pa_tinyint
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'MLO'


/* ESTADOS DE CARTERA */
exec @w_error = sp_estados_cca
@o_est_castigado  = @w_est_castigado out,
@o_est_anulado    = @w_est_anulado   out

if @w_error <> 0 return @w_error


-- DATOS DEL PRESTAMO
select 
@w_toperacion        = op_toperacion,
@w_moneda            = op_moneda,
@w_estado_actual     = op_estado,
@w_oficina           = op_oficina,
@w_operacionca       = op_operacion,
@w_gerente           = op_oficial,
@w_edad              = op_edad,
@w_garantia          = op_gar_admisible,    
@w_reestructuracion  = op_reestructuracion, 
@w_calificacion      = op_calificacion,     
@w_fecha_ult_proceso = op_fecha_ult_proceso
from   ca_operacion
where  op_banco      = @i_banco

-- MANEJO DE DECIMALES PARA LA MONEDA DE LA OPERACION
-- MANEJO DE DECIMALES
exec @w_error  = sp_decimales
@i_moneda       = @w_moneda,
@o_decimales    = @w_num_dec out,
@o_mon_nacional = @w_moneda_nac out,
@o_dec_nacional = @w_num_dec_mn out



if @i_tipo_cambio = 'A' --CAMBIO AUTOMATICO
begin
   exec @w_error = sp_cambio_estado_automatico
   @s_user          = @s_user,
   @s_term          = @s_term,
   @s_date          = @s_date,
   @s_ofi           = @s_ofi,
   @i_toperacion    = @w_toperacion,
   @i_oficina       = @w_oficina,
   @i_banco         = @i_banco,
   @i_operacionca   = @w_operacionca,
   @i_moneda        = @w_moneda,
   @i_fecha_proceso = @i_fecha_proceso,
   @i_en_linea      = @i_en_linea,
   @i_gerente       = @w_gerente,
   @i_estado_ini    = @w_estado_actual,
   @i_moneda_nac    = @w_moneda_nac
   
   if @w_error <> 0 return @w_error
   
   if  @@error <> 0 
   begin
      PRINT 'error ejecutando sp  sp_cambio_estado_automatico  @i_banco  ' + cast (@i_banco as varchar)
      return 708201
   end
end
else if @i_tipo_cambio = 'M' --CAMBIO MANUAL
begin
   exec @w_error = sp_cambio_estado_manual
   @s_user          = @s_user,
   @s_term          = @s_term,
   @s_date          = @s_date,
   @s_ofi           = @s_ofi,
   @i_toperacion    = @w_toperacion,
   @i_oficina       = @w_oficina,
   @i_banco         = @i_banco,
   @i_operacionca   = @w_operacionca,
   @i_moneda        = @w_moneda,
   @i_fecha_proceso = @i_fecha_proceso,
   @i_en_linea      = @i_en_linea,
   @i_gerente       = @w_gerente,
   @i_estado_ini    = @w_estado_actual,
   @i_estado_fin    = @i_estado_fin,
   @i_moneda_nac    = @w_moneda_nac
   
   if @w_error <> 0 return @w_error
   
   if  @@error <> 0 
   begin
      PRINT 'error ejecutando sp  sp_cambio_estado_manual  @i_banco  ' + cast (@i_banco as varchar)
      return 708201
   end
end


if @i_estado_fin in (@w_est_castigado, @w_est_anulado)
begin
   update ca_operacion
   set    op_fecha_ult_mov = @w_fecha_ult_proceso
   where  op_operacion = @w_operacionca
   
   if @@error <> 0 return 710001
end

return 0

go

