/************************************************************************/
/*   Archivo:             trans.sp                                      */
/*   Stored procedure:    sp_transaccion                                */
/*   Base de datos:       cob_cartera                                   */
/*   Producto:            Cartera                                       */
/*   Disenado por:        Fabian de la Torre                            */
/*   Fecha de escritura:  Feb 1999                                      */
/************************************************************************/
/*            IMPORTANTE                                                */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA',                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*            PROPOSITO                                                 */
/*   Reversa las transacciones y los montos les pone por (-1)           */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA               AUTOR                 RAZON                 */
/*      05/12/2016          R. Sánchez            Modif. Apropiación    */
/*      02/02/2022          D. Cumbal             Moficacion IFRS 177628*/
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_transaccion')
   drop proc sp_transaccion
go

---INC. 117737 NOV.17.2014 PAgosNormales

create proc sp_transaccion
   @s_user              login,
   @s_term              descripcion,
   @s_ofi               smallint,
   @s_date              datetime,
   @i_secuencial_retro  int,
   @i_operacion         char(1),     --(F)Fecha Valor (R)Reversa
   @i_observacion       varchar(62) = '',
   @i_operacionca       int,
   @i_fecha_retro       datetime,
   @i_es_atx            char(1)  = 'N'
as

declare 
   @w_return                  int,
   @w_tran                    varchar(10),
   @w_sec_ref                 int,
   @w_op_moneda               tinyint,
   @w_moneda_uvr              tinyint,
   @w_decimales               tinyint,
   @w_forma_reversa           catalogo
   
set ansi_warnings off

if exists (select 1 from cob_cartera_his..ca_transaccion
where tr_operacion = @i_operacionca
and   tr_secuencial >= @i_secuencial_retro)
   return 710494 
   
   
-- CODIGO DE MONEDA UVR
select @w_moneda_uvr = pa_tinyint 
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'MUVR' 

select @s_date = fc_fecha_cierre
from   cobis..ba_fecha_cierre
where  fc_producto = 7

select @w_op_moneda = op_moneda
from   ca_operacion
where  op_operacion = @i_operacionca

exec sp_decimales
@i_moneda    = @w_op_moneda,
@o_decimales = @w_decimales out

-- REVERSION DE LAS TRANSACCIONES DISTINTAS DE CMO, PRV, RPA, PAG

insert into ca_transaccion(
tr_secuencial,       tr_fecha_mov,        tr_toperacion,
tr_moneda,           tr_operacion,        tr_tran,
tr_en_linea,         tr_banco,            tr_dias_calc,
tr_ofi_oper,         tr_ofi_usu,          tr_usuario,
tr_terminal,         tr_fecha_ref,        tr_secuencial_ref,
tr_estado,           tr_observacion,      tr_gerente,
tr_gar_admisible,    tr_reestructuracion,
tr_calificacion,     tr_fecha_cont,       tr_comprobante)
select 
-1 * tr_secuencial,  @s_date,             tr_toperacion,
tr_moneda,           tr_operacion,        tr_tran,
tr_en_linea,         tr_banco,            tr_dias_calc,
tr_ofi_oper,         tr_ofi_usu,          @s_user, -- LAS REVERSAS SE HARAN CON LA MISMA OFICINA DE LA TRANSACCION ORIGINAL
@s_term,             tr_fecha_ref,        tr_secuencial,
'ING',               tr_observacion,      tr_gerente,
tr_gar_admisible,    tr_reestructuracion,
tr_calificacion,     @s_date,             tr_comprobante
from   ca_transaccion
where  tr_operacion   = @i_operacionca
and    tr_secuencial >= @i_secuencial_retro
and    tr_estado      = 'CON'
and    tr_tran       not in ('RPA', 'PRV', 'CMO','TRC','MIG','CGR', 'TCO')
and    tr_secuencial <> 0

if @@error <> 0 begin
   PRINT 'trans.sp Error Insertando en ca_transaccion No.1'
   return 710001
end

insert into ca_det_trn(
dtr_secuencial,     dtr_operacion,    dtr_dividendo,
dtr_concepto,       dtr_estado,       dtr_periodo,
dtr_codvalor,       dtr_monto,        dtr_monto_mn,
dtr_moneda,         dtr_cotizacion,   dtr_tcotizacion,
dtr_afectacion,     dtr_cuenta,       dtr_beneficiario, dtr_monto_cont)
select 
-1*dtr_secuencial,  dtr_operacion, dtr_dividendo,
dtr_concepto,
dtr_estado,         dtr_periodo,                  dtr_codvalor,
dtr_monto,          dtr_monto_mn,                 dtr_moneda,
dtr_cotizacion,     isnull(dtr_tcotizacion,''),   dtr_afectacion,
dtr_cuenta,         dtr_beneficiario,             0
from   ca_transaccion, ca_det_trn 
where  tr_operacion    = @i_operacionca
and    tr_secuencial  >= @i_secuencial_retro
and    tr_estado       = 'CON'
and    tr_tran         not in ('RPA', 'PRV', 'CMO','TRC','CGR','MIG','TCO')
and    tr_secuencial   = dtr_secuencial
and    tr_operacion    = dtr_operacion
and    tr_secuencial  <> 0

if @@error <> 0 begin
   PRINT 'trans.sp Error Insertando en ca_det_trn No. 1'
   return 710001
end

select tr_secuencial, tr_operacion, tr_tran, tr_fecha_ref, tr_fecha_mov
into #trans_est_rev
from   ca_transaccion
where  tr_operacion   = @i_operacionca
and    tr_secuencial >= @i_secuencial_retro
and    tr_estado      = 'CON'
and    tr_tran        = 'EST'
and    tr_secuencial <> 0

create table #dividendo_his(
dih_secuencial   int,
dih_fecha_ref    datetime,
dih_operacion    int,
dih_dividendo    int,
dih_estado       int,
dih_fecha_ven    datetime)


insert into #dividendo_his(
dih_secuencial  ,  dih_fecha_ref   ,
dih_operacion   ,  dih_dividendo   ,
dih_estado      ,  dih_fecha_ven   )
select
dih_secuencial  * (-1), tr_fecha_mov,
dih_operacion   ,  dih_dividendo   ,
dih_estado      ,  dih_fecha_ven   
from cob_cartera..ca_dividendo_his,
     #trans_est_rev
where dih_operacion  = tr_operacion
and   dih_secuencial = tr_secuencial

if (select count(1) from #dividendo_his)= 0   
begin 
   insert into #dividendo_his(
   dih_secuencial  ,  dih_fecha_ref   ,
   dih_operacion   ,  dih_dividendo   ,
   dih_estado      ,  dih_fecha_ven   )
   select
   dih_secuencial  * (-1), tr_fecha_mov,
   dih_operacion   ,  dih_dividendo   ,
   dih_estado      ,  dih_fecha_ven   
   from cob_cartera_his..ca_dividendo_his,
        #trans_est_rev
   where dih_operacion  = tr_operacion
   and   dih_secuencial = tr_secuencial
end
/* 
Se realiza la actualizacion para que el sp_caconta tome los valores de las cuentas exigibles 
siempre y cuando  el dividendo haya estado vencido cuando se realizo el cambio de estado.
*/
update ca_det_trn set
dtr_codvalor = dtr_codvalor + 1
from #dividendo_his
where dih_operacion  = dtr_operacion
and   dih_secuencial = dtr_secuencial
and   dih_dividendo  = dtr_dividendo 
and   dih_estado     = 2  
and   dtr_codvalor%10= 0 
and   dtr_codvalor > = 10000

/* BORRADO DE TRANSACCIONS PRV NO CONTABILIZADAS */
delete ca_transaccion_prv with (rowlock)
where tp_fecha_ref     >= @i_fecha_retro
and   tp_operacion      = @i_operacionca
and   tp_estado         = 'ING'
and   tp_secuencial_ref  = 0

if @@error <> 0  return 710003

/* BORRADO DE TRANSACCIONS PRV NO CONTABILIZADAS ASOCIADAS A LAS TRANSACCIONES QUE ESTAMOS REVERSANDO */
delete ca_transaccion_prv with (rowlock)
where tp_operacion       = @i_operacionca
and   tp_estado          = 'ING'
and   tp_secuencial_ref >= @i_secuencial_retro

if @@error <> 0  return 710003


insert into ca_transaccion_prv with (rowlock) (
tp_fecha_mov,           tp_operacion,        tp_fecha_ref,
tp_secuencial_ref,      tp_estado,           tp_dividendo,
tp_concepto,            tp_codvalor,         tp_monto,
tp_secuencia,           tp_comprobante,      tp_ofi_oper)
select 
@s_date,                tp_operacion,        tp_fecha_mov,
-999,                  'ING',                tp_dividendo,
tp_concepto,            tp_codvalor,         tp_monto * -1,
tp_secuencia,           tp_comprobante,      tp_ofi_oper
from ca_transaccion_prv
where tp_fecha_ref     >= @i_fecha_retro
and   tp_operacion      = @i_operacionca
and   tp_estado         = 'CON'
and   abs(tp_monto)    >= 0.01
and   tp_secuencial_ref = 0

if @@error <> 0  return 708165
            
update ca_transaccion_prv set 
tp_estado = 'RV'
where tp_fecha_ref      >= @i_fecha_retro
and   tp_operacion       = @i_operacionca
and   tp_secuencial_ref  = 0

if @@error <> 0 return 708165


/* EN CASO DE EXISTIR, REVERSAR TRANSACCIONES PRV'S ASOCIADAS A LA TRANSACCION PRINCIPAL */   
insert into ca_transaccion_prv with (rowlock)(
tp_fecha_mov,           tp_operacion,        tp_fecha_ref,
tp_secuencial_ref,      tp_estado,           tp_dividendo,
tp_concepto,            tp_codvalor,         tp_monto,
tp_secuencia,           tp_comprobante,      tp_ofi_oper)
select 
@s_date,                tp_operacion,        tp_fecha_mov,
-1*tp_secuencial_ref,   'ING',               tp_dividendo,
tp_concepto,            tp_codvalor,         tp_monto * -1,
tp_secuencia,           tp_comprobante,      tp_ofi_oper
from ca_transaccion_prv
where tp_operacion      = @i_operacionca
and   tp_estado         = 'CON'
and   tp_secuencial_ref >= @i_secuencial_retro
and   abs(tp_monto)    >= 0.01

if @@error <> 0 return 708165
      
update ca_transaccion_prv set
tp_estado = 'RV'
where tp_operacion       = @i_operacionca
and   tp_secuencial_ref >= @i_secuencial_retro

if @@error <> 0 return 710002


      
-- MONEDA UVR, CORRECCION MONETARIA
if @w_moneda_uvr = @w_op_moneda begin

   insert into ca_det_trn(
   dtr_secuencial,     dtr_operacion,     dtr_dividendo,
   dtr_concepto,
   dtr_estado,         dtr_periodo,       dtr_codvalor,
   dtr_monto,          dtr_monto_mn,      dtr_moneda,
   dtr_cotizacion,     dtr_tcotizacion,   dtr_afectacion,
   dtr_cuenta,         dtr_beneficiario,  dtr_monto_cont)
   select 
   -1*dtr_secuencial,  dtr_operacion,     dtr_dividendo,
   dtr_concepto,
   dtr_estado,         dtr_periodo,       dtr_codvalor,
   dtr_monto_cont,     dtr_monto_cont,    dtr_moneda,
   dtr_cotizacion,     dtr_tcotizacion,   dtr_afectacion,
   dtr_cuenta,         dtr_beneficiario,  0
   from   ca_transaccion, ca_det_trn 
   where  tr_operacion    = @i_operacionca
   and    tr_secuencial  >= @i_secuencial_retro
   and    tr_tran         = 'CMO'
   and    tr_secuencial   = dtr_secuencial
   and    tr_operacion    = dtr_operacion
   
   if @@error <> 0  begin
      PRINT 'trans.sp Error Insertando en ca_det_trn No. 3'
      return 710001
   end
   
   -- GENERAR TRANSACCIONES DE REVERSA
   insert into ca_transaccion(
   tr_secuencial,      tr_fecha_mov,    tr_toperacion,
   tr_moneda,          tr_operacion,    tr_tran,
   tr_en_linea,        tr_banco,        tr_dias_calc,
   tr_ofi_oper,        tr_ofi_usu,      tr_usuario,
   tr_terminal,        tr_fecha_ref,    tr_secuencial_ref,
   tr_estado,          tr_observacion,  tr_gerente,
   tr_calificacion,    tr_gar_admisible,tr_fecha_cont,
   tr_comprobante,     tr_reestructuracion)
   select 
   -1 * tr_secuencial, @s_date,         tr_toperacion,
   tr_moneda,          tr_operacion,    tr_tran, 
   tr_en_linea,        tr_banco,        tr_dias_calc,
   tr_ofi_oper,        tr_ofi_usu,      @s_user, -- LAS REVERSAS SE HARAN CON LA MISMA OFICINA DE LA
                                                 -- TRANSACCION ORIGINAL
   @s_term,            tr_fecha_ref,    tr_secuencial, 
   'ING',              tr_observacion,  tr_gerente,
   tr_calificacion,    tr_gar_admisible,@s_date,
   tr_comprobante,   tr_reestructuracion
   from   ca_transaccion 
   where  tr_operacion   =  @i_operacionca
   and    tr_secuencial  >= @i_secuencial_retro
   and    tr_tran        =  'CMO'
   and    tr_estado      <>  'RV'
   
   if @@error <> 0  begin
      PRINT 'trans.sp Error Insertando en ca_transaccion No. 3 @i_secuencial_retro' + CAST(@i_secuencial_retro AS VARCHAR)
      return 710001
   end
   
end -- FIN MONEDA UVR

-- ACTUALIZAR LAS TRANSACCIONES COMO REVERSADAS
update ca_transaccion set
tr_estado      = 'RV',
tr_observacion = isnull(ltrim(rtrim(tr_observacion)), ' ') + ' RAZON REVERSO: ' + isnull(ltrim(rtrim(@i_observacion)),'')
where  tr_operacion   = @i_operacionca
and    tr_secuencial >= @i_secuencial_retro
and    tr_tran       not in ('RPA', 'MIG', 'TCO')
and    tr_estado     in ('CON','ING', 'ANU', 'NCO')

if @@error <> 0  return 710002


-- EN CASO DE REVERSA DE UN PAGO, ELIMINAR EL RPA
if @i_operacion = 'R' begin

   select 
   @w_tran    = tr_tran,
   @w_sec_ref = tr_secuencial_ref
   from   ca_transaccion
   where  tr_operacion  = @i_operacionca 
   and    tr_secuencial = @i_secuencial_retro
   
   if @w_tran = 'RPA' begin
      print 'NO SE PUEDE REVERTIR UNA TRANSACCION RPA DE FORMA DIRECTA'
      return  708166
   end

   if @w_tran = 'RES' begin

      /* ELIMINAR REGISTRO DE CAMBIO DE FECHA */
      delete ca_cambio_fecha
      where cf_operacion  = @i_operacionca
      and   cf_secuencial = @i_secuencial_retro

      if @@error <> 0 return 710003

   end

   
   if @w_tran = 'DES' begin

      update ca_det_trn set
      dtr_concepto = cp_producto_reversa,
      dtr_codvalor = cp_codvalor
      from   ca_producto
      where  dtr_operacion  = @i_operacionca
      and    dtr_secuencial = -@i_secuencial_retro
      and    dtr_concepto   = cp_producto
      and    dtr_codvalor   < 1000 -- SOLO PARA MEDIOS DE PAGO, DEFECTO 6858
      
      if @@error <> 0  return  708166
   end
   
   if @w_tran   = 'PAG' 
   begin
   
      delete ca_abono_fng
      where af_operacion  = @i_operacionca

      if @@error <> 0 return 710003

      insert into ca_transaccion (
      tr_secuencial,     tr_fecha_mov,   tr_toperacion,
      tr_moneda,         tr_operacion,   tr_tran,
      tr_en_linea,       tr_banco,       tr_dias_calc,
      tr_ofi_oper,       tr_ofi_usu,     tr_usuario,
      tr_terminal,       tr_fecha_ref,   tr_secuencial_ref,
      tr_estado,         tr_observacion, tr_gerente,
      tr_gar_admisible,  tr_reestructuracion,
      tr_calificacion,   tr_fecha_cont,   tr_comprobante)
      select 
      -1*tr_secuencial,  @s_date,        tr_toperacion,
      tr_moneda,         tr_operacion,   tr_tran,
      tr_en_linea,       tr_banco,       tr_dias_calc,
      tr_ofi_oper,       tr_ofi_usu,     @s_user, 
      @s_term,           tr_fecha_ref,   tr_secuencial,
      'ING',             tr_observacion, tr_gerente,
      tr_gar_admisible,  tr_reestructuracion,
      tr_calificacion,   @s_date,        tr_comprobante
      from   ca_transaccion
      where  tr_operacion  = @i_operacionca
      and    tr_secuencial = @w_sec_ref
      and    tr_estado     = 'CON'
      
      if @@error <> 0 begin
         PRINT 'trans.sp Error Insertando en ca_transaccion No. 4'
         return 710001
      end
      
      insert into ca_det_trn (
      dtr_secuencial,      dtr_operacion,               dtr_dividendo,
      dtr_concepto,
      dtr_estado,          dtr_periodo,                 dtr_codvalor,
      dtr_monto,           dtr_monto_mn,                dtr_moneda,
      dtr_cotizacion,      dtr_tcotizacion,             dtr_afectacion,
      dtr_cuenta,          dtr_beneficiario,            dtr_monto_cont )
      select 
      -1*dtr_secuencial,   dtr_operacion,               dtr_dividendo,
      dtr_concepto,
      dtr_estado,          dtr_periodo,                 dtr_codvalor,
      dtr_monto,           dtr_monto_mn,                dtr_moneda,
      dtr_cotizacion,      isnull(dtr_tcotizacion,''),  dtr_afectacion,
      dtr_cuenta,          dtr_beneficiario,            0
      from   ca_transaccion, ca_det_trn
      where  tr_operacion  = @i_operacionca
      and    tr_secuencial = @w_sec_ref
      and    tr_secuencial = dtr_secuencial
      and    tr_operacion  = dtr_operacion
      and    tr_estado     = 'CON'
      
      if @@error <> 0  begin
         PRINT 'trans.sp Error Insertando en ca_det_trn No. 4'
         return 708165
      end
      
      update ca_transaccion set
      tr_estado = 'RV',
      tr_observacion = isnull(@i_observacion,'')
      where  tr_operacion = @i_operacionca 
      and    tr_secuencial = @w_sec_ref
      
      if @@error <> 0 return 710492
      
      if @i_es_atx = 'N' begin
         update ca_det_trn set
         dtr_concepto = cp_producto_reversa,
         dtr_codvalor = (select cp_codvalor from ca_producto where  cp_producto = orig.cp_producto_reversa)
         from   ca_producto orig
         where  dtr_operacion  = @i_operacionca
         and    dtr_secuencial = -@w_sec_ref
         and    dtr_concepto   = cp_producto
         and    dtr_codvalor    < 1000
         
         if @@error <> 0 return 710002
         
      end
      
   end   -- solo para reverso de pagos
      
end

return 0

go
