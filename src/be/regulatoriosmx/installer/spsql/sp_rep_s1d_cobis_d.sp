/************************************************************************/
/*   Archivo:              sp_rep_s1d_cobis_d.sp                        */
/*   Stored procedure:     sp_rep_s1d_cobis_d                           */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Regulatorios                                 */
/*   Disenado por:         Dario Cumbal                                 */
/*   Fecha de escritura:   05/04/2022                                   */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBIS o su representante legal.           */
/************************************************************************/
/*                                   PROPOSITO                          */
/*   Genera archivo de interface S1DQ0140_COBIS_D_AAAAMMDD              */
/*   que contiene informacion de saldos contables de tres meses         */
/*                              CAMBIOS                                 */
/************************************************************************/
/*                          MODIFICACIONES                              */
/* FECHA           AUTOR         DESCRICIPCION                          */
/* 05/04/2022      DCU           Emision inicial.                       */
/************************************************************************/

use [cob_conta_super]
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID ('dbo.sp_rep_s1d_cobis_d') IS NOT NULL
	DROP PROCEDURE dbo.sp_rep_s1d_cobis_d
GO

CREATE proc [dbo].[sp_rep_s1d_cobis_d](
   @i_param1  datetime
)
AS

DECLARE
@w_formato_fecha int,
@w_batch int,
@w_empresa INT,
@w_ruta_arch varchar(255),
@w_nombre_arch varchar(30),
@w_error int,
@w_reporte varchar(24),
@w_sql varchar(5000),
@w_sql_bcp varchar(5000),
@w_msg varchar(150)


declare
@w_sp_name              varchar(30),
@w_fecha_ini            datetime,
@w_fecha_fin            datetime,
@w_corte_ini            int,
@w_periodo_ini          int,
@w_corte_fin            int,
@w_periodo_fin          int,
@w_donde_ini            char(1),
@w_donde_fin            char(1),
@w_fecha_fma            datetime,
@w_corte_fma            int,   --fin mes anterior
@w_periodo_fma          int,
@w_treporte             char(1),
@w_fecha_proceso        datetime,
@w_nom_arch             varchar(255),
@w_cont                 int,
@w_ciudad_nacional      int,
@w_fecha_piv            datetime,
@w_query                varchar(500),
@w_path                 varchar(255),
@w_report_nombre        varchar(100),
@w_destino              varchar(400),
@w_nom_log              varchar(255),
@w_errores              varchar(400),
@w_comando              varchar(400),
@w_s_app                varchar(400),
@w_num_dec              int,
@w_fecha_corte          varchar(10),
@w_fecha_reporte        datetime,
@w_fecha_ini_mes        datetime ,
@w_cambio_periodo       char(1),
@w_periodo_ant          int,
@w_ult_corte_per_ant    int,
@w_proceso_cierre       int,
@w_numero_dias          int,
@w_periodo_anterior     int,
@w_corte_max_ant        int,
@w_fecha_ini_ing_fp     datetime,
@w_fecha_fin_inf_fp     datetime,
@w_comprobante_fp       char(1),
@w_fecha                datetime,
@w_fm_ini_uno           datetime,
@w_fm_ini_dos           datetime,
@w_fm_ini_tres          datetime,
@w_fm_fin_uno           datetime,
@w_fm_fin_dos           datetime,
@w_fm_fin_tres          datetime,
@w_fm_fin_cuatro        datetime,
@w_corte_ini_uno        int,
@w_corte_fin_uno        int,
@w_corte_ini_dos        int,
@w_corte_fin_dos        int,
@w_corte_ini_tres       int,
@w_corte_fin_tres       int,
@w_corte_cuatro         int,
@w_periodo_uno          int,
@w_periodo_dos          int,
@w_periodo_tres         int,
@w_periodo_cuatro       int,
@w_ciudad               int

 
select @w_fecha    = @i_param1
select @w_sp_name = 'sp_rep_s1d_cobis_d'
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
select @w_proceso_cierre  = 6079

--obtiene parametro DISTRITO FERIADO NACIONAL
select @w_ciudad = pa_smallint 
from cobis..cl_parametro 
where pa_nemonico = 'CFN' 
and pa_producto = 'ADM'

--Se resta un día al proceso porque se ejecutará al inicio de día del día siguiente
select @w_fecha  = dateadd(dd,-1, @w_fecha )
	
while exists (select 1 from cobis..cl_dias_feriados where df_fecha = @w_fecha  and df_ciudad = @w_ciudad)
begin
                select @w_fecha  = dateadd(dd,-1, @w_fecha )
end
		 

select @w_fm_fin_uno = @w_fecha
select @w_fm_ini_uno = convert(datetime,convert(varchar(2),month(@w_fecha))+'/01/'+convert(varchar(4),year(@w_fecha)))
select @w_fm_fin_dos = dateadd(dd,-1,@w_fm_ini_uno)
select @w_fm_ini_dos = convert(datetime,convert(varchar(2),month(@w_fm_fin_dos))+'/01/'+convert(varchar(4),year(@w_fm_fin_dos)))
select @w_fm_fin_tres = dateadd(dd,-1,@w_fm_ini_dos) 
select @w_fm_ini_tres = convert(datetime,convert(varchar(2),month(@w_fm_fin_tres))+'/01/'+convert(varchar(4),year(@w_fm_fin_tres)))
select @w_fm_fin_cuatro = dateadd(dd,-1,@w_fm_ini_tres) 



select @w_periodo_uno = year(@w_fm_fin_uno)
select @w_periodo_dos = year(@w_fm_fin_dos)
select @w_periodo_tres =  year(@w_fm_fin_tres)
select @w_periodo_cuatro =  year(@w_fm_fin_cuatro)

select @w_corte_ini_tres = co_corte from cob_conta..cb_corte where co_fecha_ini = @w_fm_ini_tres
select @w_corte_fin_tres = co_corte from cob_conta..cb_corte where co_fecha_ini = @w_fm_fin_tres
select @w_corte_ini_dos  = co_corte from cob_conta..cb_corte where co_fecha_ini = @w_fm_ini_dos
select @w_corte_fin_dos  = co_corte from cob_conta..cb_corte where co_fecha_ini = @w_fm_fin_dos
select @w_corte_ini_uno  = co_corte from cob_conta..cb_corte where co_fecha_ini = @w_fm_ini_uno
select @w_corte_fin_uno  = co_corte from cob_conta..cb_corte where co_fecha_ini = @w_fm_fin_uno
select @w_corte_cuatro   = co_corte from cob_conta..cb_corte where co_fecha_ini = @w_fm_fin_cuatro


select 
'@w_fm_ini_uno'= @w_fm_ini_uno,
'@w_fm_fin_uno'= @w_fm_fin_uno,
'@w_fm_ini_dos'= @w_fm_ini_dos,
'@w_fm_fin_dos'= @w_fm_fin_dos,
'@w_fm_ini_tres'= @w_fm_ini_tres,
'@w_fm_fin_tres'= @w_fm_fin_tres,
'@w_corte_tres' = @w_corte_ini_tres,
'@w_fm_fin_cuatro'= @w_fm_fin_cuatro


/*****************************************/
/*saldos iniciales -3 meses              */
/*****************************************/
select 
hi_empresa,
hi_oficina, 
hi_cuenta,
saldo_i   = sum(hi_saldo), 
debito_i  = sum(hi_debito), 
credito_i = sum(hi_credito)
into #saldos_iniciales
from cob_conta_his..cb_hist_saldo,
cob_conta..cb_cuenta
where hi_periodo = @w_periodo_cuatro 
and hi_corte = @w_corte_cuatro
and hi_cuenta = cu_cuenta
and cu_movimiento = 'S'
group by hi_empresa,hi_oficina, hi_cuenta

/*****************************************/
/*saldos iniciales --2 meses             */
/*****************************************/

select 
hi_empresa,
hi_oficina, 
hi_cuenta,
saldo_i   = sum(hi_saldo), 
debito_i  = sum(hi_debito), 
credito_i = sum(hi_credito)
into #saldos_iniciales_pas --saldos mes -3
from cob_conta_his..cb_hist_saldo,
cob_conta..cb_cuenta
where hi_periodo = @w_periodo_tres
and hi_corte = @w_corte_fin_tres
and hi_cuenta = cu_cuenta
and cu_movimiento = 'S'
group by hi_empresa,hi_oficina, hi_cuenta

/*****************************************/
/*saldos iniciales --1 meses             */
/*****************************************/
select 
hi_empresa,
hi_oficina, 
hi_cuenta,
saldo_i   = sum(hi_saldo), 
debito_i  = sum(hi_debito), 
credito_i = sum(hi_credito)
into #saldos_iniciales_act
from cob_conta_his..cb_hist_saldo,
cob_conta..cb_cuenta
where hi_periodo = @w_periodo_dos
and hi_corte = @w_corte_fin_dos
and hi_cuenta = cu_cuenta
and cu_movimiento = 'S'
group by hi_empresa,hi_oficina, hi_cuenta

/*****************************************/
/*Movimiento  --2 meses                  */
/*****************************************/

select 
as_empresa,  
as_oficina_dest, 
as_cuenta,
credito = sum(as_credito),
debito  = sum(as_debito)
into #mov_mes_ante
from   cob_conta..cb_comprobante, cob_conta..cb_asiento
where as_empresa      = co_empresa
and as_fecha_tran   = co_fecha_tran
and as_comprobante  = co_comprobante
and as_oficina_orig = co_oficina_orig
and co_fecha_tran   >= @w_fm_ini_tres
and co_fecha_tran   <= @w_fm_fin_tres 
and as_mayorizado    = 'S'
group by as_empresa, as_oficina_dest, as_cuenta


/*****************************************/
/*Movimiento  --1 meses                  */
/*****************************************/

select 
as_empresa,  
as_oficina_dest, 
as_cuenta,
credito = sum(as_credito),
debito  = sum(as_debito)
into #mov_mes_pas
from   cob_conta..cb_comprobante, cob_conta..cb_asiento
where as_empresa      = co_empresa
and as_fecha_tran   = co_fecha_tran
and as_comprobante  = co_comprobante
and as_oficina_orig = co_oficina_orig
and co_fecha_tran   >= @w_fm_ini_dos
and co_fecha_tran   <= @w_fm_fin_dos 
and as_mayorizado    = 'S'
group by as_empresa, as_oficina_dest, as_cuenta

/*****************************************/
/*Movimiento  --Actuales                 */
/*****************************************/

select 
as_empresa,  
as_oficina_dest, 
as_cuenta,
credito = sum(as_credito),
debito  = sum(as_debito)
into #mov_mes_act
from   cob_conta..cb_comprobante, cob_conta..cb_asiento
where as_empresa      = co_empresa
and as_fecha_tran   = co_fecha_tran
and as_comprobante  = co_comprobante
and as_oficina_orig = co_oficina_orig
and co_fecha_tran   >= @w_fm_ini_uno
and co_fecha_tran   <= @w_fm_fin_uno 
and as_mayorizado    = 'S'
group by as_empresa, as_oficina_dest, as_cuenta

create table #reporte_140(
empresa                 varchar(4) null,
coddiv                  varchar(3) null,
nucta                   varchar(15) null,
cedestin                varchar(4) null,
subdirecion             varchar(4) null,
region                  varchar(4) null,
sldo_mes_act_div        varchar(25) null,
prom_mes_act_div        varchar(25) null, 
neto_mes_act_div        varchar(25) null, 
debe_mes_act_div        varchar(25) null, 
haber_mes_act_div       varchar(25) null, 
sldo_mes_pas_div        varchar(25) null, 
prom_mes_pas_div        varchar(25) null, 
neto_mes_pas_div        varchar(25) null, 
debe_mes_pas_div        varchar(25) null, 
haber_mes_pas_div       varchar(25) null, 
sldo_mes_ant_div        varchar(25) null, 
prom_mes_ant_div        varchar(25) null,  
neto_mes_ant_div        varchar(25) null,  
debe_mes_ant_div        varchar(25) null,  
haber_mes_ant_div       varchar(25) null,  
sldo_mes_act_val        varchar(25) null,  
prom_mes_act_val        varchar(25) null,  
neto_mes_act_val        varchar(25) null,   
debe_mes_act_val        varchar(25) null,   
haber_mes_act_val       varchar(25) null,   
sldo_mes_pas_val        varchar(25) null,    
prom_mes_pas_val        varchar(25) null,    
neto_mes_pas_val        varchar(25) null,    
debe_mes_pas_val        varchar(25) null,    
haber_mes_pas_val       varchar(25) null,    
sldo_mes_ant_val        varchar(25) null,    
prom_mes_ant_val        varchar(25) null,    
neto_mes_ant_val        varchar(25) null,    
debe_mes_ant_val        varchar(25) null,    
haber_mes_ant_val        varchar(25) null)    

--Saldos del mes -3 con los movimientos del mes -2
insert into #reporte_140(
coddiv,
empresa,
cedestin,
nucta  ,
debe_mes_ant_val,
haber_mes_ant_val,
sldo_mes_ant_val,
neto_mes_ant_val)
select 
'MXP',
cobis.dbo.fn_llena_0(hi_empresa,4),
cobis.dbo.fn_llena_0(hi_oficina,4),
cobis.dbo.fn_llena_0(hi_cuenta,15),
cobis.dbo.fn_llena_0(debito,25),
cobis.dbo.fn_llena_0(credito,25),
saldo = cobis.dbo.fn_llena_0(saldo_i + debito - credito,25),
saldo = cobis.dbo.fn_llena_0(saldo_i + debito - credito,25)
from #mov_mes_ante,--movimientos -3 mes
#saldos_iniciales -- 4 meses
where as_empresa = hi_empresa
and   as_oficina_dest = hi_oficina
and as_cuenta = hi_cuenta

--Saldos del mes -3 Sin movimientos en el mes -2
insert into #reporte_140(
coddiv,
empresa,
cedestin,
nucta  ,
debe_mes_ant_val,
haber_mes_ant_val,
sldo_mes_ant_val,
neto_mes_ant_val)
select 
'MXP',
cobis.dbo.fn_llena_0(hi_empresa,4),
cobis.dbo.fn_llena_0(hi_oficina,4),
cobis.dbo.fn_llena_0(hi_cuenta,15),
cobis.dbo.fn_llena_0('0.00',25),
cobis.dbo.fn_llena_0('0.00',25),
saldo = cobis.dbo.fn_llena_0(saldo_i,25),
saldo = cobis.dbo.fn_llena_0(saldo_i,25)
from #saldos_iniciales si -- 4 meses
where not exists(select 1
                 from #reporte_140
                 where  cobis.dbo.fn_llena_0(si.hi_oficina,4) = cedestin
                 and    cobis.dbo.fn_llena_0(si.hi_cuenta,15) = nucta) 

--Momovimientos del mes -2 que no tienen saldo en el mes -3
insert into #reporte_140(
coddiv,
empresa,
cedestin,
nucta  ,
debe_mes_ant_val,
haber_mes_ant_val,
sldo_mes_ant_val,
neto_mes_ant_val)
select 
'MXP',
cobis.dbo.fn_llena_0(as_empresa,4),
cobis.dbo.fn_llena_0(as_oficina_dest,4),
cobis.dbo.fn_llena_0(as_cuenta,15),
cobis.dbo.fn_llena_0(debito,25),
cobis.dbo.fn_llena_0(credito,25),
saldo = cobis.dbo.fn_llena_0(debito - credito,25),
saldo = cobis.dbo.fn_llena_0(debito - credito,25)
from #mov_mes_ante 
where not exists(select 1
                 from #reporte_140
                 where cobis.dbo.fn_llena_0(as_oficina_dest,4) = cedestin
                 and   cobis.dbo.fn_llena_0(as_cuenta,15) = nucta)


---Saldos del mes -2 con los movimientos del mes -1
select 
hi_empresa = cobis.dbo.fn_llena_0(hi_empresa,4),
hi_oficina = cobis.dbo.fn_llena_0(hi_oficina,4),
hi_cuenta  = cobis.dbo.fn_llena_0(hi_cuenta,15),
debito     = cobis.dbo.fn_llena_0(debito,25),
credito    = cobis.dbo.fn_llena_0(credito,25),
saldo = cobis.dbo.fn_llena_0(saldo_i + debito - credito,25)
into #valores_pas
from #mov_mes_pas,
#saldos_iniciales_pas
where as_empresa = hi_empresa
and   as_oficina_dest = hi_oficina
and as_cuenta = hi_cuenta


--Saldos del mes -2 Sin movimientos en el mes -1
insert into #valores_pas (
hi_empresa, hi_oficina, hi_cuenta, debito, credito, saldo)
select
hi_empresa = cobis.dbo.fn_llena_0(hi_empresa,4),
hi_oficina = cobis.dbo.fn_llena_0(hi_oficina,4),
hi_cuenta  = cobis.dbo.fn_llena_0(hi_cuenta,15),
debito     = cobis.dbo.fn_llena_0('0.00',25),
credito    = cobis.dbo.fn_llena_0('0.00',25),
saldo = cobis.dbo.fn_llena_0(saldo_i, 25)
from #saldos_iniciales_pas si
where not exists(select 1 
                 from #valores_pas vp
                 where vp.hi_oficina = cobis.dbo.fn_llena_0(si.hi_oficina,4)
                 and   vp.hi_cuenta  = cobis.dbo.fn_llena_0(si.hi_cuenta,15))


update #reporte_140 set
sldo_mes_pas_val = saldo,
neto_mes_pas_val = saldo,
debe_mes_pas_val = debito,
haber_mes_pas_val= credito
from #valores_pas
where nucta = hi_cuenta
and cedestin = hi_oficina


--Momovimientos del mes -1 que no tienen saldo en el mes -2

insert into #reporte_140(
coddiv,
empresa,
cedestin,
nucta  ,
debe_mes_pas_val,
haber_mes_pas_val,
sldo_mes_pas_val,
neto_mes_pas_val)
select 
'MXP',
cobis.dbo.fn_llena_0(as_empresa,4),
cobis.dbo.fn_llena_0(as_oficina_dest,4),
cobis.dbo.fn_llena_0(as_cuenta,15),
cobis.dbo.fn_llena_0(debito,25),
cobis.dbo.fn_llena_0(credito,25),
saldo = cobis.dbo.fn_llena_0(debito - credito,25),
saldo = cobis.dbo.fn_llena_0(debito - credito,25)
from #mov_mes_pas
where not exists(select 1
                 from #reporte_140
                 where cobis.dbo.fn_llena_0(as_oficina_dest,4) = cedestin
                 and   cobis.dbo.fn_llena_0(as_cuenta,15) = nucta)
                 
---Saldos del mes -1 con los movimientos del mes actual
select 
hi_empresa = cobis.dbo.fn_llena_0(hi_empresa,4),
hi_oficina = cobis.dbo.fn_llena_0(hi_oficina,4),
hi_cuenta  = cobis.dbo.fn_llena_0(hi_cuenta,15),
debito     = cobis.dbo.fn_llena_0(debito,25),
credito    = cobis.dbo.fn_llena_0(credito,25),
saldo = cobis.dbo.fn_llena_0(saldo_i + debito - credito,25)
into #valores_act
from #mov_mes_act,
#saldos_iniciales_act
where as_empresa = hi_empresa
and   as_oficina_dest = hi_oficina
and as_cuenta = hi_cuenta

---Saldos del mes -1 que no tienen movimientos del mes actual
insert into #valores_act (
hi_empresa, hi_oficina, hi_cuenta, debito, credito, saldo)
select
hi_empresa = cobis.dbo.fn_llena_0(hi_empresa,4),
hi_oficina = cobis.dbo.fn_llena_0(hi_oficina,4),
hi_cuenta  = cobis.dbo.fn_llena_0(hi_cuenta,15),
debito     = cobis.dbo.fn_llena_0('0.00',25),
credito    = cobis.dbo.fn_llena_0('0.00',25),
saldo = cobis.dbo.fn_llena_0(saldo_i, 25)
from #saldos_iniciales_act si
where not exists(select 1 
                 from #valores_act vp
                 where vp.hi_oficina = cobis.dbo.fn_llena_0(si.hi_oficina,4)
                 and   vp.hi_cuenta  = cobis.dbo.fn_llena_0(si.hi_cuenta,15))



update #reporte_140 set
sldo_mes_act_val = saldo,
neto_mes_act_val = saldo, 
debe_mes_act_val = debito,
haber_mes_act_val= credito
from #valores_act
where nucta = hi_cuenta
and cedestin = hi_oficina

---Movimientos del mes actual 
insert into #reporte_140(
coddiv,
empresa,
cedestin,
nucta  ,
debe_mes_act_val,
haber_mes_act_val,
sldo_mes_act_val,
neto_mes_act_val)
select 
'MXP',
cobis.dbo.fn_llena_0(as_empresa,4),
cobis.dbo.fn_llena_0(as_oficina_dest,4),
cobis.dbo.fn_llena_0(as_cuenta,15),
cobis.dbo.fn_llena_0(debito,25),
cobis.dbo.fn_llena_0(credito,25),
saldo = cobis.dbo.fn_llena_0(debito - credito,25),
saldo = cobis.dbo.fn_llena_0(debito - credito,25)
from #mov_mes_act
where not exists(select 1
                 from #reporte_140
                 where cobis.dbo.fn_llena_0(as_oficina_dest,4) = cedestin
                 and   cobis.dbo.fn_llena_0(as_cuenta,15) = nucta)
                 

select 
hi_empresa,
oficina= cobis.dbo.fn_llena_0(hi_oficina, 4),
cuenta = cobis.dbo.fn_llena_0(hi_cuenta, 15),
promedio= sum(hi_saldo)/(datediff(dd,@w_fm_ini_tres,@w_fm_fin_tres)+1)
into #promedio_ant
from cob_conta_his..cb_hist_saldo
where hi_periodo = @w_periodo_tres
and hi_corte >= @w_corte_ini_tres
and hi_corte <= @w_corte_fin_tres
group by hi_empresa,hi_oficina, hi_cuenta

select 
hi_empresa,
oficina= cobis.dbo.fn_llena_0(hi_oficina, 4),
cuenta = cobis.dbo.fn_llena_0(hi_cuenta, 15),
promedio= sum(hi_saldo)/(datediff(dd,@w_fm_ini_dos,@w_fm_fin_dos)+1)
into #promedio_pas
from cob_conta_his..cb_hist_saldo
where hi_periodo = @w_periodo_dos
and hi_corte >= @w_corte_ini_dos
and hi_corte <= @w_corte_fin_dos
group by hi_empresa,hi_oficina, hi_cuenta

select 
hi_empresa,
oficina= cobis.dbo.fn_llena_0(hi_oficina, 4),
cuenta = cobis.dbo.fn_llena_0(hi_cuenta, 15),
promedio= sum(hi_saldo)/(datediff(dd,@w_fm_ini_dos,@w_fm_fin_dos)+1)
into #promedio_act
from cob_conta_his..cb_hist_saldo
where hi_periodo = @w_periodo_uno
and hi_corte >= @w_corte_ini_uno
and hi_corte <= @w_corte_fin_uno
group by hi_empresa,hi_oficina, hi_cuenta


update #reporte_140 set
prom_mes_ant_val = cobis.dbo.fn_llena_0(promedio,25)
from #promedio_ant
where nucta = cuenta
and cedestin = oficina

update #reporte_140 set
prom_mes_pas_val = cobis.dbo.fn_llena_0(promedio,25)
from #promedio_pas
where nucta = cuenta
and cedestin = oficina


update #reporte_140 set
prom_mes_act_val = cobis.dbo.fn_llena_0(promedio,25)
from #promedio_act
where nucta = cuenta
and cedestin = oficina

update #reporte_140 set
prom_mes_pas_val = cobis.dbo.fn_llena_0('0.00',25)
where prom_mes_pas_val is null




update #reporte_140 set
region = cobis.dbo.fn_llena_0(of_regional,4)
from cobis..cl_oficina R
where cedestin = of_oficina

update #reporte_140 set
sldo_mes_act_val  = isnull(sldo_mes_act_val ,cobis.dbo.fn_llena_0('0.00',25)),
prom_mes_act_val  = isnull(prom_mes_act_val ,cobis.dbo.fn_llena_0('0.00',25)),
neto_mes_act_val  = isnull(neto_mes_act_val ,cobis.dbo.fn_llena_0('0.00',25)),
debe_mes_act_val  = isnull(debe_mes_act_val ,cobis.dbo.fn_llena_0('0.00',25)),
haber_mes_act_val = isnull(haber_mes_act_val,cobis.dbo.fn_llena_0('0.00',25)),
sldo_mes_pas_val  = isnull(sldo_mes_pas_val ,cobis.dbo.fn_llena_0('0.00',25)),
prom_mes_pas_val  = isnull(prom_mes_pas_val ,cobis.dbo.fn_llena_0('0.00',25)),
neto_mes_pas_val  = isnull(neto_mes_pas_val ,cobis.dbo.fn_llena_0('0.00',25)),
debe_mes_pas_val  = isnull(debe_mes_pas_val ,cobis.dbo.fn_llena_0('0.00',25)),
haber_mes_pas_val = isnull(haber_mes_pas_val,cobis.dbo.fn_llena_0('0.00',25)),
sldo_mes_ant_val = isnull(sldo_mes_ant_val,cobis.dbo.fn_llena_0('0.00',25)),
prom_mes_ant_val  = isnull(prom_mes_ant_val ,cobis.dbo.fn_llena_0('0.00',25)),
neto_mes_ant_val  = isnull(neto_mes_ant_val ,cobis.dbo.fn_llena_0('0.00',25)),
debe_mes_ant_val  = isnull(debe_mes_ant_val ,cobis.dbo.fn_llena_0('0.00',25)),
haber_mes_ant_val  = isnull(haber_mes_ant_val ,cobis.dbo.fn_llena_0('0.00',25))

--select * from #promedio_ant
update #reporte_140 set
sldo_mes_act_div = cobis.dbo.fn_llena_0('0.00',25),
prom_mes_act_div = cobis.dbo.fn_llena_0('0.00',25),
neto_mes_act_div = cobis.dbo.fn_llena_0('0.00',25),
debe_mes_act_div = cobis.dbo.fn_llena_0('0.00',25), 
haber_mes_act_div= cobis.dbo.fn_llena_0('0.00',25),
sldo_mes_pas_div = cobis.dbo.fn_llena_0('0.00',25),
prom_mes_pas_div = cobis.dbo.fn_llena_0('0.00',25),
neto_mes_pas_div = cobis.dbo.fn_llena_0('0.00',25),
debe_mes_pas_div = cobis.dbo.fn_llena_0('0.00',25),
haber_mes_pas_div = cobis.dbo.fn_llena_0('0.00',25),
sldo_mes_ant_div = cobis.dbo.fn_llena_0('0.00',25),
prom_mes_ant_div = cobis.dbo.fn_llena_0('0.00',25),
neto_mes_ant_div = cobis.dbo.fn_llena_0('0.00',25),
debe_mes_ant_div = cobis.dbo.fn_llena_0('0.00',25),
haber_mes_ant_div = cobis.dbo.fn_llena_0('0.00',25)


update #reporte_140 set
subdirecion     = cobis.dbo.fn_llena_0(of_oficina_padre,4)
from cob_conta..cb_oficina
where region = of_oficina


--Reporte 6.1 S1DQ0140_COBIS_D_AAAAMMDD.txt

select  @w_formato_fecha = 111, 
		@w_batch = 36430, 
		@w_empresa = 1 

select	
@w_ruta_arch	= ba_path_destino,
--@w_nombre_arch	= replace(convert(varchar,@i_param1, 106), ' ', '_')
@w_nombre_arch	= CONVERT(varchar,DATEPART(yyyy, @w_fecha),4)+CONVERT(varchar,cobis.dbo.fn_llena_0(DATEPART(mm, @w_fecha),2),2)+CONVERT(varchar,cobis.dbo.fn_llena_0(DATEPART(dd, @w_fecha),2),2)

from cobis..ba_batch
where ba_batch = @w_batch

if @@error != 0 or @@rowcount != 1 or isnull(@w_ruta_arch, '') = '' or isnull(@w_nombre_arch, '') = ''
begin
   select @w_error = 70134
   goto ERROR_PROCESO
END

IF OBJECT_ID('tempdb..##tmp_rep_S1D_COBIS_D') IS NOT NULL DROP TABLE ##tmp_rep_S1D_COBIS_D


SELECT
datos =
'0078'          +
coddiv           +
nucta            +
cedestin         +
subdirecion      +
region           +
sldo_mes_act_div   +
prom_mes_act_div   +
neto_mes_act_div   +
debe_mes_act_div   +
haber_mes_act_div  +
sldo_mes_pas_div   +
prom_mes_pas_div   +
neto_mes_pas_div   +
debe_mes_pas_div   +
haber_mes_pas_div  +
sldo_mes_ant_div   +
prom_mes_ant_div   +
neto_mes_ant_div   +
debe_mes_ant_div   +
haber_mes_ant_div +
case when charindex('-',sldo_mes_act_val,0) <> 0 then
    '-' + cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,replace(sldo_mes_act_val,'-','0')),1),24)
else 
    cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,sldo_mes_act_val) ,1),25)
end+
case when charindex('-',prom_mes_act_val,0) <> 0 then
    '-' + cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,replace(prom_mes_act_val,'-','0')),1),24)
else 
    cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,prom_mes_act_val) ,1),25)
end+                   
case when charindex('-',neto_mes_act_val,0) <> 0 then
    '-' + cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,replace(neto_mes_act_val,'-','0')),1),24)
else 
    cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,neto_mes_act_val) ,1),25)
end+                   
case when charindex('-',debe_mes_act_val,0) <> 0 then
    '-' + cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,replace(debe_mes_act_val,'-','0')),1),24)
else 
    cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,debe_mes_act_val) ,1),25)
end+
 case when charindex('-',haber_mes_act_val,0) <> 0 then
    '-' + cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,replace(haber_mes_act_val,'-','0')),1),24)
else 
    cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,haber_mes_act_val) ,1),25)
end+                   
case when charindex('-',sldo_mes_pas_val,0) <> 0 then
    '-' + cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,replace(sldo_mes_pas_val,'-','0')),1),24)
else 
    cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,sldo_mes_pas_val) ,1),25)
end+
case when charindex('-',prom_mes_pas_val,0) <> 0 then
    '-' + cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,replace(prom_mes_pas_val,'-','0')),1),24)
else 
    cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,prom_mes_pas_val) ,1),25)
end+
case when charindex('-',neto_mes_pas_val,0) <> 0 then
    '-' + cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,replace(neto_mes_pas_val,'-','0')),1),24)
else 
    cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,neto_mes_pas_val) ,1),25)
end+
case when charindex('-',debe_mes_pas_val,0) <> 0 then
    '-' + cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,replace(debe_mes_pas_val,'-','0')),1),24)
else 
    cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,debe_mes_pas_val) ,1),25)
end+                   
 case when charindex('-',haber_mes_pas_val,0) <> 0 then
    '-' + cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,replace(haber_mes_pas_val,'-','0')),1),24)
else 
    cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,haber_mes_pas_val) ,1),25)
end+ 
case when charindex('-',sldo_mes_ant_val,0) <> 0 then
    '-' + cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,replace(sldo_mes_ant_val,'-','0')),1),24)
else 
    cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,sldo_mes_ant_val) ,1),25)
end+ 
case when charindex('-',prom_mes_ant_val,0) <> 0 then
    '-' + cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,replace(prom_mes_ant_val,'-','0')),1),24)
else 
    cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,prom_mes_ant_val) ,1),25)
end+ 
case when charindex('-',neto_mes_ant_val,0) <> 0 then
    '-' + cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,replace(neto_mes_ant_val,'-','0')),1),24)
else 
    cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,neto_mes_ant_val) ,1),25)
end+ 
case when charindex('-',debe_mes_ant_val,0) <> 0 then
    '-' + cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,replace(debe_mes_ant_val,'-','0')),1),24)
else 
    cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,debe_mes_ant_val) ,1),25)
end+ 
 case when charindex('-',haber_mes_ant_val,0) <> 0 then
    '-' + cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,replace(haber_mes_ant_val,'-','0')),1),24)
else 
    cobis.dbo.fn_llena_0(CONVERT(varchar,convert(money,haber_mes_ant_val) ,1),25)
end
INTO ##tmp_rep_S1D_COBIS_D
from #reporte_140


select @w_reporte = 'S1DQ0140_COBIS_D_'
select @w_sql = 'select * from ##tmp_rep_S1D_COBIS_D'


select	@w_sql_bcp = 'bcp "' + @w_sql + '" queryout "' + @w_ruta_arch + @w_reporte + @w_nombre_arch +'".txt"'+'" -C -c -t";" -T'

EXEC xp_cmdshell @w_sql_bcp

IF NOT EXISTS (select 1 from cobis..cl_log_notificador where ln_nemonico = 'COPYBTI' and ln_report_name = @w_reporte + @w_nombre_arch +'.txt' and ln_gen_process_date = @w_fecha)
BEGIN
	INSERT INTO cobis..cl_log_notificador (ln_nemonico, ln_report_name, ln_generation_date, ln_gen_process_date, ln_upload_date, ln_copy_date, ln_report_pattern, ln_status)
	VALUES ('COPYBTI', @w_reporte + @w_nombre_arch +'.txt', GETDATE(),@w_fecha, null, null, @w_reporte +'{PPD:yyyyMMdd}.txt', null)
END
ELSE
BEGIN
	UPDATE cobis..cl_log_notificador
	SET
		ln_generation_date = GETDATE(),
		ln_status = NULL
	where ln_nemonico = 'COPYBTI' and ln_report_name = @w_reporte + @w_nombre_arch +'.txt' and ln_gen_process_date = @w_fecha
END

IF NOT EXISTS (select 1 from cobis..cl_log_notificador where ln_nemonico = 'CHARITS' and ln_report_name = @w_reporte + @w_nombre_arch +'.txt' and ln_gen_process_date = @w_fecha)
BEGIN
	INSERT INTO cobis..cl_log_notificador (ln_nemonico, ln_report_name, ln_generation_date, ln_gen_process_date, ln_upload_date, ln_copy_date, ln_report_pattern, ln_status)
	VALUES ('CHARITS', @w_reporte + @w_nombre_arch +'.txt', GETDATE(),@w_fecha, null, null, @w_reporte +'{PPD:yyyyMMdd}.txt', null)
END
ELSE
BEGIN
	UPDATE cobis..cl_log_notificador
	SET
		ln_generation_date = GETDATE(),
		ln_status = NULL
	where ln_nemonico = 'CHARITS' and ln_report_name = @w_reporte + @w_nombre_arch +'.txt' and ln_gen_process_date = @w_fecha
END

return 0

ERROR_PROCESO:

select @w_msg = mensaje
from cobis..cl_errores with (nolock)
where numero = @w_error
