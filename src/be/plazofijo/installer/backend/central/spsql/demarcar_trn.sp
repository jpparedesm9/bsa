/************************************************************************/
/*   Stored procedure:     sp_desmarcar_trn                             */
/*   Base de datos:        cob_pfijo                                    */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                            PROPOSITO                                 */
/*   Quitar marca de ya contabilizado a transacciones que no pasaron    */
/*   la validacion contable.                                            */
/************************************************************************/

use cob_pfijo
go
 
if exists (select 1 from sysobjects where name = 'sp_desmarcar_trn')
   drop proc sp_desmarcar_trn
go
 
create proc sp_desmarcar_trn

with encryption

as 

declare
@w_error             int,
@w_sp_name           varchar(20),
@w_mensaje           varchar(255),
@w_fecha_desde       datetime,
@w_fecha_hasta       datetime,
@w_fecha_proceso     datetime,
@w_return            int


/* VARIABLES DE TRABAJO */
select
@w_mensaje         = '',
@w_sp_name         = 'sp_desmarcar_trn'

select @w_fecha_proceso = fc_fecha_cierre
from cobis..ba_fecha_cierre
where fc_producto = 14


/* DETERMINAR EL RANGO DE FECHAS DE LAS TRANSACCIONES QUE SE INTENTARAN CONTABILIZAR */
select  
@w_fecha_desde = isnull(min(co_fecha_ini),'01/01/1900'),
@w_fecha_hasta = isnull(max(co_fecha_ini),'01/01/1900')
from cob_conta..cb_corte
where co_empresa = 1
and   co_estado in ('A','V')

if @w_fecha_desde = '01/01/1900' begin
   select 
   @w_error   = 601078,
   @w_mensaje = 'ERROR: NO EXISTEN PERIODOS DE CORTE ABIERTOS'
end

create table #comprobantes( 
comprobante  int      null,
fecha        datetime null,
mensaje      varchar(60))

create table #comprobantes_conaut( 
cc_comprobante  int      null,
cc_fecha        datetime null,
cc_mensaje      varchar(60))


while @w_fecha_desde <= @w_fecha_hasta begin

   exec @w_return = cob_interfase..sp_iccontable  
        @i_operacion   = 'A',
        @i_producto    = 14,
        @i_fecha_desde = @w_fecha_desde

   insert into #comprobantes
   select * from #comprobantes_conaut

   if @@error <> 0 begin
      select 
      @w_error   = 7200,
      @w_mensaje = 'ERROR AL INSERTAR #COMPROBANTE Cartera'
      goto ERRORFIN
   end

   select @w_fecha_desde = dateadd(dd, 1, @w_fecha_desde)
end


update pf_transaccion set 
tr_estado       = 'ING',
tr_comprobante  = 0,
tr_fecha_cont   = '01/01/1900'
from  #comprobantes
where tr_comprobante = comprobante
and   tr_fecha_mov   = fecha

if @@error <> 0 begin
   select 
   @w_error   = 7200,
   @w_mensaje = 'ERROR AL ACTUALIZAR CA_TRANSACCION'
   goto ERRORFIN
end


return 0


ERRORFIN:

exec sp_errorlog
@s_date      = @w_fecha_proceso,
@i_fecha     = @w_fecha_proceso,
@i_error     = @w_error,
@i_usuario   = 'operador',
@i_tran      = 14000,
@i_cuenta    = 'DESMARCAR_TRN',
@i_descripcion = @w_mensaje,
@i_cta_pagrec  = ''


return @w_error

go