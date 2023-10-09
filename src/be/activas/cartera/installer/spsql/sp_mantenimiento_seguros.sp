/*************************************************************/
/*   ARCHIVO:         	sp_mantenimiento_seguros.sp          */
/*   NOMBRE LOGICO:   	sp_mantenimiento_seguros.sp          */
/*   PRODUCTO:        		CARTERA                          */
/*************************************************************/
/*                     IMPORTANTE                            */
/*   Esta aplicacion es parte de los  paquetes bancarios     */
/*   propiedad de MACOSA S.A.                                */
/*   Su uso no autorizado queda  expresamente  prohibido     */
/*   asi como cualquier alteracion o agregado hecho  por     */
/*   alguno de sus usuarios sin el debido consentimiento     */
/*   por escrito de MACOSA.                                  */
/*   Este programa esta protegido por la ley de derechos     */
/*   de autor y por las convenciones  internacionales de     */
/*   propiedad intelectual.  Su uso  no  autorizado dara     */
/*   derecho a MACOSA para obtener ordenes  de secuestro     */
/*   o  retencion  y  para  perseguir  penalmente a  los     */
/*   autores de cualquier infraccion.                        */
/*************************************************************/
/*                     PROPOSITO                             */
/*   Este procedimiento permite actualizar el tipo de seguro */
/*   de seguro por cada uno de los clientes                  */
/*************************************************************/
/*                     MODIFICACIONES                        */
/*   FECHA         AUTOR               RAZON                 */
/*   10-Dic-2019   DCU                 Req. 126891           */
/*   09-Oct-2020   ACH                 ERR. 147494           */
/*   03/Mar/2021   SRO                 Req #147999           */
/*   11/Jun/2022   SRO                 Req #185234           */
/*   11/Abr/2023   KVI                 Req.203379-nuevo campo*/
/*************************************************************/
use cob_cartera
go


IF OBJECT_ID ('dbo.sp_mantenimiento_seguros') IS NOT NULL
   DROP PROCEDURE dbo.sp_mantenimiento_seguros
GO

CREATE PROCEDURE sp_mantenimiento_seguros (	
   @s_ssn            int           = null,
   @s_srv            varchar(30)   = null,
   @s_term           descripcion   = null,
   @s_rol            smallint      = null,
   @s_lsrv           varchar(30)   = null,
   @s_sesn           int           = null,
   @s_org            char(1)       = null,
   @s_org_err        int           = null,
   @s_error          int           = null,
   @s_sev            tinyint       = null,
   @s_msg            descripcion   = null,
   @s_user           varchar(14)   = null, 
   @t_rty            char(1)       = null,
   @t_trn            int           = null,
   @t_debug          char(1)       = 'N',
   @t_file           varchar(14)   = null,
   @t_from           varchar(30)   = null,
   @i_tramite        int           = null,
   @i_cliente        int           = null,
   @i_tipo_seguro    catalogo      = null,
   @i_grupo          int           = null,
   @i_operacion      char(1)       = null,
   @i_producto       varchar(20)   = 'GRUPAL',   
   @i_plazo_asis_med int           = null       -- Req.203379  
)
as 

declare
@w_fecha_proceso        datetime,
@w_error                int,
@w_sp_name              varchar(30),
@w_banco                cuenta,
@w_msg                  varchar(100),
@w_operacion            int                

print '@i_tramite:'+convert(varchar(50),@i_tramite)
print '@i_cliente:'+convert(varchar(50),@i_cliente)
PRINT '@i_operacion:' +@i_operacion
--Fecha proceso y cálculo de fecha de vencimiento del pago
select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso

if @i_operacion = 'I'
begin
   select @i_tipo_seguro = ltrim(rtrim(@i_tipo_seguro))
   
   if exists(select 1
          from cob_cartera..ca_seguro_externo
          where se_cliente = @i_cliente
          and   se_tramite = @i_tramite)
   begin
      
      update cob_cartera..ca_seguro_externo set
      se_tipo_seguro    = @i_tipo_seguro,
	  se_usuario        = @s_user,
	  se_terminal       = @s_term,
	  se_plazo_asis_med = @i_plazo_asis_med  -- Req.203379 
      where se_cliente  = @i_cliente
      and   se_tramite  = @i_tramite 
      
      if @@error <> 0
      begin
         select @w_error = 724681, -- ERROR EN ACTUALIZAR
                @w_msg   = 'Error al actualizar en la tabla de seguros'
         goto ERROR
      end    
   end          
   else begin
      if @i_producto = 'GRUPAL' begin
	  
         select top 1 
         @w_banco         = op_banco,
         @w_operacion     = op_operacion            
         from cob_credito..cr_tramite_grupal,
         cob_cartera..ca_operacion    
         where tg_tramite = @i_tramite
         and   op_banco   = tg_referencia_grupal
      end else begin
	  
         select 
         @w_banco         = op_banco,
         @w_operacion     = op_operacion
         from ca_operacion
         where op_tramite = @i_tramite	 
      end 

      insert into cob_cartera..ca_seguro_externo (
      se_operacion       , se_banco            , se_cliente    ,
      se_fecha_ini       , se_fecha_ult_intento, se_monto      ,      
      se_estado          , se_tramite          , se_grupo      ,
      se_monto_pagado    , se_forma_pago       , se_tipo_seguro,
	  se_usuario         , se_terminal         , se_plazo_asis_med) -- Req.203379  
      values(
      @w_operacion       , @w_banco            , @i_cliente    ,
      @w_fecha_proceso   , null                , 0             ,
      'C'                , @i_tramite          , @i_grupo      ,
      0                  , null                , @i_tipo_seguro,
	  @s_user            ,@s_term              , @i_plazo_asis_med) -- Req.203379  
      
      if @@error <> 0
      begin
         select @w_error = 724682, -- ERROR EN INSERTAR,
                @w_msg   = 'Error al insertar en la tabla de seguros'
         goto ERROR
      end 
                             
   end
end
if @i_operacion = 'Q' begin --Obtiene tipo de seguro por tramite y cliente

   select se_tipo_seguro, 
          se_plazo_asis_med   -- Req.203379  
   from  cob_cartera..ca_seguro_externo 
   where se_tramite = @i_tramite 
   and   se_cliente = @i_cliente
   
end

return 0

ERROR:
 begin --Devolver mensaje de Error
        exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = @w_error,
             @i_msg   = @w_msg
        return @w_error
 end
go

