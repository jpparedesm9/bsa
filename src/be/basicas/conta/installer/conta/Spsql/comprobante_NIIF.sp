/************************************************************************/
/*      Archivo:                comprobante_NIIF.sp                     */
/*      Base de datos:          cob_conta                               */
/*      Producto:               contabilidad                            */
/*      Disenado por:           jose Molano                             */
/*      Fecha de escritura:     05/21/2014                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA".                                                       */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*  extraer los saldos, para comprobante de interface de saldo          */
/*  iniciales para NIIF                                                 */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA          AUTOR                    RAZON                       */
/*  Mayo/21/2014   Jose Molano           Creacion Inicial NR 429        */
/************************************************************************/

use cob_conta
go

if exists(select 1 from cob_conta..sysobjects where name = 'sp_niif_comprobante_inicial' and type = 'P') 
   drop proc sp_niif_comprobante_inicial
go

create proc sp_niif_comprobante_inicial 
as
declare
@w_registro   int,
@w_oficina    smallint,
@w_diferencia money,
@w_credito    money

select @w_registro   = 0
select @w_oficina    = 0
select @w_diferencia = 0
select @w_credito    = 0

truncate table cob_externos..ex_int_comprobantes
if @@error <> 0 begin
   print 'Error al borrar tabla cob_externos..ex_int_comprobantes'
   goto final
end

select distinct of_oficina
into #oficina
from cob_conta..cb_oficina
where of_movimiento = 'S'

select cu_cuenta
into #cuentas_tercero
from cob_conta..cb_cuenta
where substring (cu_cuenta,1,2) in ('13','26')
and   cu_movimiento = 'S'
and   cu_cuenta  in (select cp_cuenta from cob_conta..cb_cuenta_proceso where cp_proceso in (6003, 6095))

insert into #cuentas_tercero
select cu_cuenta
from cob_conta..cb_cuenta
where substring (cu_cuenta,1,4) in ('2115')
and   cu_movimiento = 'S'
and   cu_cuenta  in (select cp_cuenta from cob_conta..cb_cuenta_proceso where cp_proceso in (6003, 6095))

insert into #cuentas_tercero
select cu_cuenta
from cob_conta..cb_cuenta
where substring (cu_cuenta,1,6) in ('250505', '250520')
and   cu_movimiento = 'S'
and   cu_cuenta  in (select cp_cuenta from cob_conta..cb_cuenta_proceso where cp_proceso in (6003, 6095))

delete #cuentas_tercero
where substring (cu_cuenta, 1,4) in ('1625','1645','1655','1698')

select cuenta = cu_cuenta
into #cuentas_gnral
from cob_conta..cb_cuenta
where substring(cu_cuenta,1,1) not in ('6','8')
and   cu_movimiento = 'S'

delete #cuentas_gnral
from #cuentas_tercero,
     #cuentas_gnral
where cu_cuenta = cuenta

while 1 = 1 begin

   begin tran
   
   select @w_registro = count(1)
   from cob_externos..ex_int_comprobantes
   
   if @w_registro is null
      select @w_registro = 0

   select 
   @w_oficina = of_oficina
   from #oficina
   if @@rowcount = 0 begin
      break
   end
   
   delete #oficina
   where of_oficina = @w_oficina
   if @@error <> 0 begin
      rollback tran
      print 'Error al borrar #oficina'
      goto final
   end
   
   insert into cob_externos..ex_int_comprobantes
   select 
   st_empresa,
   '20131231',
   'comprobante' = 1,
   '2013/12/31',
   0,
   'CARGA INICIAL BANCAMIA 2013',
   st_cuenta,
   st_oficina,
   0,
   isnull((select isnull(en_ced_ruc, '99') from cobis..cl_ente where en_ente = st_ente),99),
   'COP',
   (select cu_nombre from cob_conta..cb_cuenta where cu_cuenta = st_cuenta),
   row_number() over(order by st_ente) + @w_registro,
   case when sum(st_saldo) > 0 then abs(sum(st_saldo)) else 0 end,
   case when sum(st_saldo) < 0 then abs(sum(st_saldo)) else 0 end,
   case when sum(st_saldo) > 0 then abs(sum(st_saldo)) else 0 end,
   case when sum(st_saldo) < 0 then abs(sum(st_saldo)) else 0 end,
   case when isnull((select en_tipo_ced from cobis..cl_ente where en_ente = st_ente), '') = '' then '0' else 'CI' end,
   case when isnull((select en_tipo_ced from cobis..cl_ente where en_ente = st_ente), '') = '' then '99' else '01' end,
   '2014/01/01',
   isnull((select en_tipo_ced from cobis..cl_ente where en_ente = st_ente), '99')
   from cob_conta_tercero..ct_saldo_tercero
   where st_periodo = 2013
   and   st_corte   = 366
   and   st_saldo  <> 0
   and   st_oficina = @w_oficina
   and   st_cuenta in (select cu_cuenta from #cuentas_tercero)
   group by st_ente, st_oficina, st_cuenta, st_empresa, st_periodo
   order by st_oficina
   if @@ERROR <> 0 begin
      print 'Error al insertar en ex_int_comprobantes'
      rollback tran
      goto final
   end
   
   select @w_registro = count(1)
   from cob_externos..ex_int_comprobantes
   
   insert into cob_externos..ex_int_comprobantes
   select 
   hi_empresa,
   '20131231',
   'comprobante' = 1,
   '2013/12/31',
   0,
   'CARGA INICIAL BANCAMIA 2013',
   hi_cuenta,
   hi_oficina,
   0,
   '99',
   'COP',
   (select cu_nombre from cob_conta..cb_cuenta where cu_cuenta = hi_cuenta),
   row_number() over(order by hi_cuenta) + @w_registro,
   case when sum(hi_saldo) > 0 then abs(sum(hi_saldo)) else 0 end,
   case when sum(hi_saldo) < 0 then abs(sum(hi_saldo)) else 0 end,
   case when sum(hi_saldo) > 0 then abs(sum(hi_saldo)) else 0 end,
   case when sum(hi_saldo) < 0 then abs(sum(hi_saldo)) else 0 end,
   '0',
   '99',
   '0000/00/00',
   '99'
   from cob_conta_his..cb_hist_saldo,
        cob_conta..cb_cuenta
   where hi_corte      = 366
   and   hi_periodo    = 2013
   and   hi_oficina    = @w_oficina
   and   hi_area       > 0
   and   hi_cuenta in (select cuenta from #cuentas_gnral)
   and   hi_saldo     <> 0
   and   hi_cuenta     = cu_cuenta
   and   cu_movimiento = 'S'
   group by hi_empresa, hi_periodo, hi_cuenta, hi_oficina
   if @@ERROR <> 0 begin
      print 'Error al insertar en ex_int_comprobantes (1)'
      rollback tran
      goto final
   end

   if @@TRANCOUNT > 0 begin
      commit tran
   end
end

select @w_diferencia = sum(ic_Debe_local - ic_Haber_local)
from cob_externos..ex_int_comprobantes
where substring(ic_Codigo_cuenta,1,1) in ('1','2','3')

select 
@w_credito = ic_Haber_local
from cob_externos..ex_int_comprobantes
where substring(ic_Codigo_cuenta,1,2) in ('36')
and   ic_Codigo_centro_costo = 4069
and   ic_Haber_local          > 0

if (@w_credito + @w_diferencia) > 0 begin
   update cob_externos..ex_int_comprobantes set
   ic_Haber_local      = ic_Haber_local + (@w_diferencia),
   ic_Haber_imputacion = ic_Haber_imputacion + (@w_diferencia)
   where substring(ic_Codigo_cuenta,1,2) in ('36')
   and   ic_Codigo_centro_costo = 4069
   and  ic_Haber_local          > 0
   if @@ERROR <> 0 begin
      print 'Error al actualizar final (1)'
      rollback tran
      goto final
   end
end
   
if @@TRANCOUNT > 0 begin
   commit tran
end

final:

return 0
go
