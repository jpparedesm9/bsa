/************************************************************************/
/*   Archivo:             pf_rep_ven_cdt.sp                             */
/*   Stored procedure:    sp_pf_rep_ven_cdt                             */
/*   Base de datos:       cob_pfijo                                     */
/*   Producto:            pfijo                                         */
/*   Disenado por:        Edwin Jimenez                                 */
/*   Fecha de escritura:  14 de Abril de 2015                           */
/************************************************************************/
/*                             IMPORTANTE                               */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBISCORP'. Su uso no autorizado queda expresamente prohibido asi */
/*   como cualquier alteracion o agregado hecho por alguno de sus       */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                             PROPOSITO                                */
/*   próximos vencimientos de CDT´s mes a mes en monto y en cantidad    */
/*   y refleja los vencimientos por  regional, zona y oficina           */
/************************************************************************/
/*                              CAMBIOS                                 */
/*   FECHA              AUTOR             CAMBIOS                       */
/*   14/Abr/2014        EDWIN JIMENEZ    Emision Inicial ORS 1165       */
/************************************************************************/

use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

if exists (select 1 from sysobjects where name = 'sp_pf_rep_ven_cdt')
   drop proc sp_pf_rep_ven_cdt
go

create proc sp_pf_rep_ven_cdt(
@i_param1         datetime)
with encryption
as
declare
@w_fecha          datetime,
@w_return         int,
@w_msg            varchar(140),
@w_error          int,
@w_rango1         int,
@w_rango2         int,
@w_rango3         int,
@w_rango4         int,
@w_rango5         int,
@w_rango6         int,
@w_rango7         int

/*Fecha de Proceso*/
select @w_fecha = fp_fecha
from cobis..ba_fecha_proceso

/*Validacion Fecha para Tipo de Reporte*/
if @i_param1 is not null
   select @w_fecha = isnull(@i_param1,@w_fecha)
   
select @w_rango1 = cobis..cl_catalogo.valor
from cobis..cl_catalogo, cobis..cl_tabla 
where cobis..cl_tabla.tabla in ('pf_rangos_reporte_vencimientos')
  and cobis..cl_tabla.codigo = cobis..cl_catalogo.tabla
  and cobis..cl_catalogo.codigo = 1

select @w_rango2 = cobis..cl_catalogo.valor
from cobis..cl_catalogo, cobis..cl_tabla 
where cobis..cl_tabla.tabla in ('pf_rangos_reporte_vencimientos')
  and cobis..cl_tabla.codigo = cobis..cl_catalogo.tabla
  and cobis..cl_catalogo.codigo = 2

select @w_rango3 = cobis..cl_catalogo.valor
from cobis..cl_catalogo, cobis..cl_tabla 
where cobis..cl_tabla.tabla in ('pf_rangos_reporte_vencimientos')
  and cobis..cl_tabla.codigo = cobis..cl_catalogo.tabla
  and cobis..cl_catalogo.codigo = 3

select @w_rango4 = cobis..cl_catalogo.valor
from cobis..cl_catalogo, cobis..cl_tabla 
where cobis..cl_tabla.tabla in ('pf_rangos_reporte_vencimientos')
  and cobis..cl_tabla.codigo = cobis..cl_catalogo.tabla
  and cobis..cl_catalogo.codigo = 4
  
select @w_rango5 = cobis..cl_catalogo.valor
from cobis..cl_catalogo, cobis..cl_tabla 
where cobis..cl_tabla.tabla in ('pf_rangos_reporte_vencimientos')
  and cobis..cl_tabla.codigo = cobis..cl_catalogo.tabla
  and cobis..cl_catalogo.codigo = 5
  
select @w_rango6 = cobis..cl_catalogo.valor
from cobis..cl_catalogo, cobis..cl_tabla 
where cobis..cl_tabla.tabla in ('pf_rangos_reporte_vencimientos')
  and cobis..cl_tabla.codigo = cobis..cl_catalogo.tabla
  and cobis..cl_catalogo.codigo = 6  

select @w_rango7 = cobis..cl_catalogo.valor
from cobis..cl_catalogo, cobis..cl_tabla 
where cobis..cl_tabla.tabla in ('pf_rangos_reporte_vencimientos')
  and cobis..cl_tabla.codigo = cobis..cl_catalogo.tabla
  and cobis..cl_catalogo.codigo = 7  

if exists (select 1 from sysobjects where name = 'pf_reporte_venc_cab')
   drop table pf_reporte_venc_cab

create table pf_reporte_venc_cab(
rvc_mes            varchar(64),
rvc_regional       varchar(64),
rvd_nom_regional   varchar(64),
rvc_zona           varchar(64),
rvc_nom_zona       varchar(64),
rvc_oficina        varchar(64),
rvc_nom_oficina    varchar(64),
rvc_cant_rang1     varchar(64),
rvc_val_rang1      varchar(64),
rvc_cant_rang2     varchar(64),
rvc_val_rang2      varchar(64),
rvc_cant_rang3     varchar(64),
rvc_val_rang3      varchar(64),
rvc_cant_rang4     varchar(64),
rvc_val_rang4      varchar(64),
rvc_cantidad       varchar(64),
rvc_monto          varchar(64))

if exists (select 1 from sysobjects where name = 'pf_reporte_venc_det')
   drop table pf_reporte_venc_det

create table pf_reporte_venc_det(
rvd_mes            varchar(24),
rvd_regional       int,
rvd_nom_regional   varchar(64),
rvd_zona           int,
rvd_nom_zona       varchar(64),
rvd_oficina        int,
rvd_nom_oficina    varchar(64),
rvd_cant_rang1     int,
rvd_val_rang1      money,
rvd_cant_rang2     int,
rvd_val_rang2      money,
rvd_cant_rang3     int,
rvd_val_rang3      money,
rvd_cant_rang4     int,
rvd_val_rang4      money,
rvd_cantidad       int,
rvd_monto          money)
 
select 
mes  = datepart(mm, op_fecha_ven),
regional = (select of_regional from cobis..cl_oficina where of_oficina = op_oficina),
zona     = (select of_zona from cobis..cl_oficina where of_oficina = op_oficina),
oficina  = op_oficina,
'CANTIDAD_RANGO1' = convert(int, 0),
'VALOR_RANGO1'    = convert(money, 0),
'CANTIDAD_RANGO2' = convert(int, 0),
'VALOR_RANGO2'    = convert(money, 0),
'CANTIDAD_RANGO3' = convert(int, 0),
'VALOR_RANGO3'    = convert(money, 0),
'CANTIDAD_RANGO4' = convert(int, 0),
'VALOR_RANGO4'    = convert(money, 0),
cantidad = count(1),
monto    = sum(op_monto)
into #cdt
from cob_pfijo..pf_operacion
where op_estado = 'ACT'
and   op_fecha_ven <= @w_fecha --'12/31/2015'
and   op_oficina  <> 28
group by datepart(mm, op_fecha_ven), op_oficina

select 
mes1      = datepart(mm, op_fecha_ven),
cantidad1 = count(1),
monto1    = sum(op_monto),
regional1 = (select of_regional from cobis..cl_oficina where of_oficina = op_oficina),
zona1     = (select of_zona from cobis..cl_oficina where of_oficina = op_oficina),
oficina1  = op_oficina
into #s1
from cob_pfijo..pf_operacion
where op_estado = 'ACT'
and   op_monto >= @w_rango1 --50000
and   op_monto <= @w_rango2 --500000
and   op_fecha_ven <= @w_fecha --'12/31/2015'
group by op_oficina, datepart(mm, op_fecha_ven)

update #cdt set
CANTIDAD_RANGO1 = cantidad1,
VALOR_RANGO1    = monto1 
from #s1
where regional1 = regional
and   zona1     = zona
and   oficina1  = oficina
and   mes1      = mes

select 
mes1       = datepart(mm, op_fecha_ven),
cantidad1 = count(1),
monto1    = sum(op_monto),
regional1 = (select of_regional from cobis..cl_oficina where of_oficina = op_oficina),
zona1     = (select of_zona from cobis..cl_oficina where of_oficina = op_oficina),
oficina1  = op_oficina
into #s2
from cob_pfijo..pf_operacion
where op_estado = 'ACT'
and   op_monto >= @w_rango3 --500001
and   op_monto <= @w_rango4 --5000000
and   op_fecha_ven <= @w_fecha --'12/31/2015'
group by op_oficina, datepart(mm, op_fecha_ven)

update #cdt set
CANTIDAD_RANGO2 = cantidad1,
VALOR_RANGO2    = monto1 
from #s2
where regional1 = regional
and   zona1     = zona
and   oficina1  = oficina
and   mes1      = mes

select 
mes1       = datepart(mm, op_fecha_ven),
cantidad1 = count(1),
monto1    = sum(op_monto),
regional1 = (select of_regional from cobis..cl_oficina where of_oficina = op_oficina),
zona1     = (select of_zona from cobis..cl_oficina where of_oficina = op_oficina),
oficina1  = op_oficina
into #s3
from cob_pfijo..pf_operacion
where op_estado = 'ACT'
and   op_monto >= @w_rango5  --5000001
and   op_monto <= @w_rango6  --50000000
and   op_fecha_ven <= @w_fecha --'12/31/2015'
group by op_oficina, datepart(mm, op_fecha_ven)

update #cdt set
CANTIDAD_RANGO3 = cantidad1,
VALOR_RANGO3    = monto1 
from #s3
where regional1 = regional
and   zona1     = zona
and   oficina1  = oficina
and   mes1      = mes

select 
mes1       = datepart(mm, op_fecha_ven),
cantidad1 = count(1),
monto1    = sum(op_monto),
regional1 = (select of_regional from cobis..cl_oficina where of_oficina = op_oficina),
zona1     = (select of_zona from cobis..cl_oficina where of_oficina = op_oficina),
oficina1  = op_oficina
into #s4
from cob_pfijo..pf_operacion
where op_estado = 'ACT'
and   op_monto >= @w_rango7 --50000001
and   op_fecha_ven <= @w_fecha --'12/31/2015'
group by op_oficina, datepart(mm, op_fecha_ven)

update #cdt set
CANTIDAD_RANGO4 = cantidad1,
VALOR_RANGO4    = monto1 
from #s4
where regional1 = regional
and   zona1     = zona
and   oficina1  = oficina
and   mes1      = mes

insert into pf_reporte_venc_cab values (
'MES',
'REGIONAL',
'NOMBRE REGIONAL',
'ZONA',
'NOMBRE ZONA',
'OFICINA',
'NOMBRE OFICINA',
('CANT_' + cast(@w_rango1 as varchar) +'_'+ cast(@w_rango2 as varchar)),
('MONT_' + cast(@w_rango1 as varchar) +'_'+ cast(@w_rango2 as varchar)),
('CANT_' + cast(@w_rango3 as varchar) +'_'+ cast(@w_rango4 as varchar)),
('MONT_' + cast(@w_rango3 as varchar) +'_'+ cast(@w_rango4 as varchar)),
('CANT_' + cast(@w_rango5 as varchar) +'_'+ cast(@w_rango6 as varchar)),
('MONT_' + cast(@w_rango5 as varchar) +'_'+ cast(@w_rango6 as varchar)),
('CANT_' + cast(@w_rango7 as varchar)),
('MONT_' + cast(@w_rango7 as varchar)),
'CANTIDAD',
'MONTO')

if @@error <> 0 begin
   select
   @w_error = 720205,
   @w_msg   = '[pf_reporte_venc_cab] ERROR INSERTANDO INFORMACION TABLA DE REPORTE CAB'
   goto ERROR
end

insert into pf_reporte_venc_det
select 
mes = case when mes = 1 then 'ENERO' 
           when mes = 2 then 'FEBRERO'
           when mes = 3 then 'MARZO'
           when mes = 4 then 'ABRIL'
           when mes = 5 then 'MAYO'
           when mes = 6 then 'JUNIO'
           when mes = 7 then 'JULIO'
           when mes = 8 then 'AGOSTO'
           when mes = 9 then 'SEPTIEMBRE'
           when mes = 10 then 'OCTUBRE'
           when mes = 11 then 'NOVIEMBRE'
           when mes = 12 then 'DICIEMBRE'
      end,
regional,
nom_regional = (select of_nombre from cobis..cl_oficina where of_oficina = regional),
zona,
nom_zona     = (select of_nombre from cobis..cl_oficina where of_oficina = zona),
oficina,
nom_oficina  = (select of_nombre from cobis..cl_oficina where of_oficina = oficina),
CANTIDAD_RANGO1,
VALOR_RANGO1,
CANTIDAD_RANGO2,
VALOR_RANGO2,
CANTIDAD_RANGO3,
VALOR_RANGO3,
CANTIDAD_RANGO4,
VALOR_RANGO4,
cantidad,
monto
from #cdt

if @@error <> 0 begin
   select
   @w_error = 720205,
   @w_msg   = '[pf_reporte_venc_det] ERROR INSERTANDO INFORMACION TABLA DE REPORTE DET'
   goto ERROR
end

/*Generacion BCP*/
exec @w_return = cobis..sp_genera_bcp
@i_bd                = 'cob_pfijo',
@i_tabla_cabecera    = 'pf_reporte_venc_cab',
@i_tabla_detalle     = 'pf_reporte_venc_det',
@i_arch_salida       = 'REPORTE_VENC_CDT_',
@i_batch             = 14087

if @w_return <> 0 begin
   rollback tran
   select
   @w_error = @w_return,
   @w_msg   = '[sp_pf_rep_ven_cdt] ERROR GENERANDO REPORTE PFIJO'
   goto ERROR
end

return 0

ERROR:
exec cobis..sp_errorlog
@i_fecha      = @w_fecha,
@i_error      = @w_error,
@i_usuario    = 'op_batch',
@i_tran       = 747,
@i_tran_name  = @w_msg,
@i_rollback   = 'N'

return @w_error
go
