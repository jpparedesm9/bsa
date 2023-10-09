/************************************************************************/
/*  Archivo               : rptliquidez.sp                              */
/*  Stored procedure      : sp_rptliquidez                              */
/*  Base de datos         : cob_pfijo                                   */
/*  Producto              : Plazo Fijo                                  */
/*  Disenado por          : ALF                                         */
/*  Fecha de documentacion: 24/Mar/10                                   */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'COBISCORP'                                                         */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de COBISCORP o su representante.              */
/*                          PROPOSITO                                   */
/*  reporte de liquidez, almacena datos en la tabla                     */
/*  cob_externos..re_liquidez_plazos                                    */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA           AUTOR              RAZON                            */ 
/*  24-Mar-2010     ALF                Emision Inicial                  */
/*  05-Ene-2017     N. Martillo        Ajustes VBatch                   */
/************************************************************************/ 
use cob_pfijo
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select name from sysobjects where name = 'sp_rptliquidez')
   drop proc sp_rptliquidez
go

create proc sp_rptliquidez (
   	   @i_param1           varchar(255)
)
with encryption
as

declare	@w_sp_name            varchar(30),
        @w_msg                varchar(240),
        @w_error              int,
        @w_retorno            int,
        @w_retorno_ej         int,
        @w_error_msg          varchar(250),
        @w_fecha_proceso      datetime
        
select @w_sp_name   = 'sp_rptliquidez',
       @w_fecha_proceso = convert(datetime, @i_param1)

delete cob_externos..re_liquidez_plazos
where lp_producto = 14
  and lp_fecha    = @w_fecha_proceso

select @w_error = @@error

if @w_error != 0
begin
     select @w_retorno_ej = 14000,
            @w_error_msg = '[' + @w_sp_name + '] ' + 'Error al eliminar datos en cob_externos..re_liquidez_plazos'
     goto ERROR    
end

begin tran

insert into cob_externos..re_liquidez_plazos
      (lp_producto, 
       lp_tipo_prod, 
       lp_tipo_persona, 
       lp_banda, 
       lp_desde, 
       lp_hasta, 
       lp_estado, 
       lp_sector, 
       lp_valor_cap, 
       lp_valor_int, 
       lp_fecha)
select op_producto,      
       op_toperacion,
       case en_subtipo
          when 'P' then 'C'
          else 'R'
       end,
       rb_banda,
       rb_desde,
       rb_hasta,
       case 
         when op_estado in ('XACT','ACT') then 1
         when op_estado = 'VEN'           then 2
       end,
       null,
       sum(op_monto),
       sum(op_int_ganado),
       @w_fecha_proceso
from cob_pfijo..pf_operacion a,     
     cobis..cl_ente,
     cob_externos..re_rango_banda
where op_estado in ('ACT','XACT','VEN')
  and op_ente   = en_ente
  and datediff(dd,@w_fecha_proceso,op_fecha_ven) between rb_desde and rb_hasta
group by op_producto,      
       op_toperacion,
       case en_subtipo
          when 'P' then 'C'
          else 'R'
       end,
       rb_banda,
       rb_desde,
       rb_hasta,
       case 
         when op_estado in ('XACT','ACT') then 1
         when op_estado = 'VEN'           then 2
       end

select @w_error = @@error

if @w_error != 0 
begin
     rollback tran
     select @w_retorno_ej = 14000,
            @w_error_msg = '[' + @w_sp_name + '] ' + 'Error al registrar datos en cob_externos..re_liquidez_plazos'
     goto ERROR
end

commit tran

return 0

ERROR:

exec @w_retorno     = cob_pfijo..sp_errorlog
     @i_fecha       = @w_fecha_proceso, 
     @i_error       = @w_retorno_ej, 
     @i_usuario     = 'OPERADOR',
     @i_tran        = 14000, 
     @i_tran_name   = @w_sp_name, 
     @i_rollback    = 'N',
     @i_cuenta      = 'sp_rptliquidez', 
     @i_descripcion = @w_error_msg

if @w_retorno > 0
    return @w_retorno
else
    return @w_retorno_ej 
go

