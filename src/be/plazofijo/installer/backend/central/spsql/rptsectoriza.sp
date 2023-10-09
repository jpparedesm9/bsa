/************************************************************************/
/*  Archivo               : rptsectoriza.sp                             */
/*  Stored procedure      : sp_rptsectoriza                             */
/*  Base de datos         : cob_pfijo                                   */
/*  Producto              : Plazo Fijo                                  */
/*  Disenado por          : ALF                                         */
/*  Fecha de documentacion: 01/Oct/09                                   */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'COBISCORP'                                                         */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de COBISCORP o su representante.              */
/*                          PROPOSITO                                   */
/*  Este script crea los procedimientos para las transacciones de       */
/*  adicion, modificacion, eliminacion, search y query de las           */
/*  operaciones temporales de plazos fijos.                             */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA           AUTOR              RAZON                            */ 
/*  01-Oct-2009     ALF                Emision Inicial                  */
/*  05-Ene-2017     N. Martillo        Ajustes VBatch                   */         
/************************************************************************/       
use cob_pfijo
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select name from sysobjects where name = 'sp_rptsectoriza')
   drop proc sp_rptsectoriza
go

create proc sp_rptsectoriza (
        @i_param1          varchar(255)
)
with encryption
as
declare @w_sp_name         varchar(20),
        @w_moneda_base     smallint,
        @w_moneda          smallint,
        @w_msg             varchar(240),
        @w_error           int,
        @w_retorno         int,
        @w_retorno_ej      int,
        @w_error_msg       int,
        @w_fecha_proceso   datetime
          
select @w_sp_name = 'sp_rptsectoriza',
       @w_fecha_proceso  = convert(datetime, @i_param1)

select @w_moneda_base = em_moneda_base
from cob_conta..cb_empresa
where em_empresa = 1

select @w_moneda_base = isnull(@w_moneda_base,0)

declare @sectoriza table 
(se_fecha     datetime    null, 
 se_producto  tinyint     null,
 se_codigo    tinyint     null,
 se_sector    varchar(10) null,
 se_valor     money       null
)

create table #cotizacion
(ct_empresa tinyint  null,
 ct_fecha   datetime null,
 ct_moneda  tinyint  null,
 ct_valor   money    null,
 ct_compra  money    null,
 ct_venta   money    null
)


insert into #cotizacion
select 1,
       ct_fecha,
       ct_moneda,
       ct_valor,
       ct_compra,
       ct_venta
from cob_conta..cb_cotizacion a
where ct_fecha   = (select max(ct_fecha) from cob_conta..cb_cotizacion where ct_moneda = a.ct_moneda and ct_fecha <= @w_fecha_proceso) 

if @@rowcount = 0
begin
     select @w_retorno_ej = 14000,
            @w_error_msg = '[' + @w_sp_name + '] ' + 'Error en consulta cob_conta..cb_cotizacion'
     goto ERROR
end

create table #moneda
(op_moneda  tinyint null
)

insert into #moneda  
select distinct op_moneda
from cob_pfijo..pf_operacion
where op_estado in ('ACT','XACT','VEN')

select @w_moneda = -1

while 1 = 1
begin
     set rowcount 1
     select @w_moneda = op_moneda
     from #moneda
     where op_moneda > @w_moneda
     order by op_moneda

     if @@rowcount = 0
        break

     set rowcount 0

     if exists(select ct_moneda from #cotizacion
               where ct_moneda = @w_moneda)
        select @w_moneda = @w_moneda
     else begin
        select @w_retorno_ej = 14000, 
               @w_msg = '['+@w_sp_name+'] ' + 'No existe cotizacion para la moneda: ' + convert(varchar,@w_moneda)
        goto ERROR
     end                   
end

set rowcount 0

begin tran

delete cobis..cl_sectorizacion
where se_fecha    = @w_fecha_proceso
  and se_producto = 14

if @@error <> 0
begin
   rollback tran
   select @w_retorno_ej = 14000, 
          @w_msg = '['+@w_sp_name+'] ' + ' Error al eliminar  datos de cl_sectorizacion'
   goto ERROR  
end

--Capital--
insert into cobis..cl_sectorizacion	
select @w_fecha_proceso,
       14, 
       case 
         when cob_pfijo.dbo.fn_getctacont(op_toperacion,op_plazo_cont,op_moneda,op_estado,op_pignorado,op_grupo_banco) like '2103%'   then 48
         when cob_pfijo.dbo.fn_getctacont(op_toperacion,op_plazo_cont,op_moneda,op_estado,op_pignorado,op_grupo_banco) like '210140%' then 47
       end,       
       case op_estado 
         when 'VEN' then 132 
         else 
             case
               when c_tipspub in (121,123,125) then 132
               else c_tipspub
             end
       end, 
       sum(case op_moneda
             when @w_moneda_base then op_monto
             else round(op_monto * ct_valor,2)
           end)
from cob_pfijo..pf_operacion, 
     #cotizacion,
     cobis..cl_ente
where op_operacion >= 1
  and op_estado    in ('ACT','XACT','VEN')
  and op_toperacion <> 'PPC'  --fro 20120312 
  and op_moneda     = ct_moneda
  and op_ente       = en_ente  
group by case op_estado 
           when 'VEN' then 132 
           else 
               case
                 when c_tipspub in (121,123,125) then 132
                 else c_tipspub
               end
           end, case 
                  when cob_pfijo.dbo.fn_getctacont(op_toperacion,op_plazo_cont,op_moneda,op_estado,op_pignorado,op_grupo_banco) like '2103%'   then 48
                  when cob_pfijo.dbo.fn_getctacont(op_toperacion,op_plazo_cont,op_moneda,op_estado,op_pignorado,op_grupo_banco) like '210140%' then 47
                end
having (case 
          when cob_pfijo.dbo.fn_getctacont(op_toperacion,op_plazo_cont,op_moneda,op_estado,op_pignorado,op_grupo_banco) like '2103%'   then 48
          when cob_pfijo.dbo.fn_getctacont(op_toperacion,op_plazo_cont,op_moneda,op_estado,op_pignorado,op_grupo_banco) like '210140%' then 47
        end) is not null


if @@error <> 0
begin
   rollback tran
   select @w_retorno_ej = 14000, 
          @w_msg = '['+@w_sp_name+'] ' + ' Error al registrar capital en cl_sectorizacion'
   goto ERROR   
end

--Interes--
insert into @sectoriza
select @w_fecha_proceso, 
       14, 
       49, 
       c_tipspub, 
       sum(case op_moneda
             when @w_moneda_base then (op_total_int_ganados - isnull(op_total_int_pagados,0) - isnull(op_prov_pendiente,0))
             else round((op_total_int_ganados - isnull(op_total_int_pagados,0) - isnull(op_prov_pendiente,0)) * ct_valor,2)
           end)
from cob_pfijo..pf_operacion, 
     #cotizacion,
     cobis..cl_ente
where op_operacion >= 1
  and op_estado    in ('ACT','XACT')
  and op_toperacion <> 'PPC'  --fro 20120312 
  and op_moneda     = ct_moneda
  and op_ente       = en_ente  
group by c_tipspub
union
select @w_fecha_proceso, 
       14, 
       49, 
       c_tipspub, 
       sum(case op_moneda
             when @w_moneda_base then (op_total_int_ganados - op_total_int_pagados - isnull(op_prov_pendiente,0) - case when (op_total_int_ganados - op_total_int_pagados) > 0 then isnull(op_total_retencion,0) else 0 end + case when (op_total_int_ganados - op_total_int_pagados) > 0 and op_total_retencion > 0 then isnull(op_total_int_retenido,0) - isnull(op_residuo_prov,0) else 0 end)
             else round((op_total_int_ganados - op_total_int_pagados - isnull(op_prov_pendiente,0) - case when (op_total_int_ganados - op_total_int_pagados) > 0 then isnull(op_total_retencion,0) else 0 end + case when (op_total_int_ganados - op_total_int_pagados) > 0 and op_total_retencion > 0 then isnull(op_total_int_retenido,0) - isnull(op_residuo_prov,0) else 0 end) * ct_valor,2)
           end)
from cob_pfijo..pf_operacion, 
     #cotizacion,
     cobis..cl_ente
where op_operacion >= 1
  and op_estado    in ('VEN')
  and op_toperacion <> 'PPC'  --fro 20120312 
  and op_moneda     = ct_moneda
  and op_ente       = en_ente  
group by c_tipspub

insert into cobis..cl_sectorizacion	
select se_fecha, se_producto, se_codigo, se_sector, sum(se_valor)
from @sectoriza
group by se_fecha, se_producto, se_codigo, se_sector

if @@error <> 0
begin
   rollback tran
   select @w_retorno_ej = 14000, 
          @w_msg = '['+@w_sp_name+'] ' + ' Error al registrar capital en cl_sectorizacion'
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
     @i_cuenta      = 'sp_rptsectoriza', 
     @i_descripcion = @w_error_msg

if @w_retorno > 0
    return @w_retorno
else
    return @w_retorno_ej 
go

