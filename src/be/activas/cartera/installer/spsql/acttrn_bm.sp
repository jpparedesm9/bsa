/************************************************************************/
/*   Archivo:              acttrn_bm.sp                                 */
/*   Stored procedure:     sp_actualizacion_trn_bm                      */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         Xavier Maldonado                             */
/*   Fecha de escritura:   Mar-2004                                     */
/************************************************************************/
/*   IMPORTANTE                                                         */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/*   PROPOSITO                                                          */
/*   Procedimiento que realiza la actualizacion de transacciones        */
/*   que no fueron contabilizadas                                       */
/*                                                                      */
/*                       CAMBIOS                                        */
/*    FECHA             AUTOR          CAMBIO                           */
/*    01ABR2005         F.QUINTERO     INDICES TABLAS TEMPORALES        */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_actualizacion_trn_bm')
   drop proc sp_actualizacion_trn_bm
go

create proc sp_actualizacion_trn_bm
    @i_fecha_proceso     datetime

as
declare 
   @w_error        int,
   @w_return       int,
   @w_sp_name      varchar(32),
   @w_descripcion  descripcion

print 'Localizaci�n de transacciones erradas'
select tot_banco       er_banco,
       tot_secuencial  er_secuencial
into   #erradas
from   cob_cartera..ca_transaccion_bancamia, 
       cob_ccontable..cco_error_conaut, 
       cob_cartera..ca_totales_trn_bm
where  ec_empresa = 1
and    ec_producto = 7
and    tot_total = convert(int,ec_tran_modulo)
and    tr_banco = tot_banco
--and    tr_estado = 'PVA'

if @@error != 0
begin
   select @w_descripcion = 'acttrn.sp Error en Actualizacion a estado ING - PASO 1'
   select @w_error = 710508
   goto ERROR
end

create nonclustered index erradas_1 on #erradas(er_banco, er_secuencial)

print 'Localizaci�n de transacciones ok'

select tr_banco         ok_banco,
       tr_secuencial    ok_secuencial
into   #correctas
from   cob_cartera..ca_transaccion_bancamia
where  tr_estado = 'PVA'

if @@error != 0
begin
   select @w_descripcion = 'acttrn.sp Error en Actualizacion a estado ING - PASO 2'
   select @w_error = 710508
   goto ERROR
end

create nonclustered index correctas_1 on #correctas(ok_banco, ok_secuencial)

delete #correctas
from   #correctas, #erradas
where  ok_banco = er_banco
and    ok_secuencial = er_secuencial

if @@error != 0
begin
   select @w_descripcion = 'acttrn.sp Error en Actualizacion a estado ING - PASO 3'
   select @w_error = 710508
   goto ERROR
end

print 'Iniciar actualizaci�n'

BEGIN TRAN
   -- ACTUALIZACION DE LAS TRANSACCIONES QUE  NO CONTABILIZARON
   update cob_cartera..ca_transaccion_bancamia
   set    tr_estado = 'ING'
   from   #erradas--(index erradas_1)
   where  tr_banco = er_banco
   and    tr_secuencial = er_secuencial
   
   if @@error != 0
   begin
      select @w_descripcion = 'acttrn.sp Error en Actualizacion a estado ING'
      select @w_error = 710508
      goto ERROR
   end
   
   -- ACTUALIZACION DEL  MONTO CONTABILIZADO A LAS TRANSACCIONES QUE NO GENERARON ERROR
   
   update cob_cartera..ca_det_trn_bancamia
   set    dtr_monto_cont = dtr_monto_mn
   from   #correctas--(index correctas_1)
   where  dtr_banco = ok_banco
   and    dtr_secuencial = ok_secuencial
   
   if @@error != 0
   begin
      select @w_descripcion = 'acttrn.sp  Error en Actualizacion del monto contabilizado'
      select @w_error = 710509
      goto ERROR
   end
   
   -- ACTUALIZACION DE LAS TRANSACCIONES  A ESTADO CON
   
   update cob_cartera..ca_transaccion_bancamia
   set    tr_estado = 'CON'
   from   #correctas--(index correctas_1)
   where  tr_banco = ok_banco
   and    tr_secuencial = ok_secuencial
   
   if @@error != 0
   begin
      select @w_descripcion = 'acttrn.sp  Error en Actualizacion a estado CON'
      select @w_error = 710510
      goto ERROR
   end

COMMIT TRAN

return 0


ERROR:
if @w_error != 0
begin
   while @@trancount > 0 rollback tran

   insert into ca_errorlog
         (er_fecha_proc,      er_error,      er_usuario,
          er_tran,            er_cuenta,     er_descripcion,
          er_anexo)
   values(@i_fecha_proceso,   @w_error,      'operador',
          0,                  '',            @w_descripcion,
          '')
   return @w_error  
end


go
