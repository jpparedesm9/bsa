/*************************************************************************/
/*   Archivo:              sp_rep_cobis_sm.sp		                     */
/*   Stored procedure:     sp_rep_cobis_sm                               */
/*   Base de datos:        cob_conta_super                               */
/*   Producto:             Regulatorios                                  */
/*   Disenado por:         Dario Cumbal - Daniel Berrio                  */
/*   Fecha de escritura:   Abril 2022                                    */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                                   PROPOSITO                           */
/*   Genera reporte COBIS_SM_AAAAMMDD.txt del requerimiento 172199       */
/*                                                                       */
/*       Parametros de Entrada                                           */
/*			Fecha de proceso                                             */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/*    04/Abril/2022          DBM              emision inicial            */
/*    21/Octubre/2022        D. Cumbal        ajuste cuadre balanza      */
/*************************************************************************/


USE [cob_conta_super]
GO

IF OBJECT_ID ('dbo.sp_rep_cobis_sm') IS NOT NULL
	DROP PROCEDURE dbo.sp_rep_cobis_sm
GO

CREATE proc [dbo].[sp_rep_cobis_sm](
   @i_param1  DATETIME
)
AS

--select @i_param1= '10/17/2022'

declare @w_fecha             datetime
declare @w_fecha_act         datetime 
declare @w_fecha_ini_mes_act datetime 

---------------------------------------------

declare @w_fm_ini_saldo     datetime 
declare @w_fm_ini_mes_dos   datetime

--------------------------------------------

declare @w_fecha_fm_act     datetime 
declare @w_fecha_fm_ant     datetime 

declare @w_fecha_aux        datetime 
declare @w_fin_mes_ant_hab  datetime
declare @w_fin_mes_ant      datetime
declare @w_fin_mes_hab      datetime
declare @w_ini_mes          datetime
declare @w_fin_mes          datetime 
declare @w_ini_mes_ant      datetime
declare @w_fecha_ini_act    datetime

declare @w_fm_ini_saldo_hab datetime 

declare @w_corte_f_actual     int, 
        @w_corte_fm_ant       int,
        @w_periodo_mes_act    int,
        @w_periodo_mes_ant    int,
        @w_corte_in_mes_ant   int,
        @w_periodo_inicial    int,
        @w_corte_inicial      int,
        @w_corte_ini_mov      int,
        @w_corte_ini_fin      int,
        @w_estado             char(1),
		@w_corte_fm_actual    int
		
        
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
@w_msg varchar(150),
@w_ciudad int

--obtiene parametro DISTRITO FERIADO NACIONAL
select @w_ciudad = pa_smallint 
	from cobis..cl_parametro 
	where pa_nemonico = 'CFN' 
	AND pa_producto = 'ADM'

--Reporte 6.9 COBIS_SM_AAAAMMDD.txt

select  @w_formato_fecha = 111, 
		@w_batch = 36430, 
		@w_empresa = 1 

IF OBJECT_ID('tempdb..##tmp_rep_cobis_sm') IS NOT NULL DROP TABLE ##tmp_rep_cobis_sm

select @w_fecha  = @i_param1
--Se resta un dia al proceso porque se ejecutara al inicio de dia del dia siguiente

-------------------FERIADOS

select @w_fecha  = dateadd(dd,-1, @w_fecha )

while exists (select 1 from cobis..cl_dias_feriados where df_fecha = @w_fecha  and df_ciudad = @w_ciudad)
begin
                select @w_fecha  = dateadd(dd,-1, @w_fecha )
end

select  @w_formato_fecha = 111, 
		@w_batch = 36430, 
		@w_empresa = 1 

select	
@w_ruta_arch	= ba_path_destino,
@w_nombre_arch	= CONVERT(varchar,DATEPART(yyyy, @w_fecha),4)+CONVERT(varchar,cobis.dbo.fn_llena_0(DATEPART(mm, @w_fecha),2),2)+CONVERT(varchar,cobis.dbo.fn_llena_0(DATEPART(dd, @w_fecha),2),2)

from cobis..ba_batch
where ba_batch = @w_batch

select @w_fecha_act = @w_fecha -- Fecha ultimo dia habil contabilizado
select @w_fecha_ini_act = convert(datetime, convert(varchar,month(@w_fecha_act))+'/01/'+convert(varchar,year(@w_fecha_act)))


EXEC  cob_conta..sp_calcula_ultima_fecha_habil
    @i_reporte          = 'NINGUN',  -- buro mensual
    @i_fecha            = @w_fecha_ini_act,
    @o_ini_mes          = @w_ini_mes out,
    @o_fin_mes          = @w_fin_mes out,
    @o_fin_mes_hab      = @w_fin_mes_hab out,
    @o_fin_mes_ant      = @w_fin_mes_ant out,
    @o_fin_mes_ant_hab  = @w_fin_mes_ant_hab out
    
select @w_ini_mes_ant = convert(datetime, convert(varchar,month(@w_fin_mes_ant))+'/01/'+convert(varchar,year(@w_fin_mes_ant)))

select 
'@w_fin_mes_ant_hab' = @w_fin_mes_ant_hab, 
'@w_fin_mes_hab'     = @w_fin_mes_hab,
'@w_fin_mes'         = @w_fin_mes,
'@w_fin_mes_ant'     = @w_fin_mes_ant,
'@w_ini_mes_ant'     = @w_ini_mes_ant

   
EXEC  cob_conta..sp_calcula_ultima_fecha_habil
    @i_reporte          = 'NINGUN',  -- buro mensual
    @i_fecha            = @w_ini_mes_ant,
    @o_fin_mes_ant      = @w_fm_ini_saldo out,
    @o_fin_mes_ant_hab  = @w_fm_ini_saldo_hab out
  
select '@w_fm_ini_saldo: ' = @w_fm_ini_saldo, '@w_fm_ini_saldo_hab' = @w_fm_ini_saldo_hab
select @w_fm_ini_mes_dos = dateadd (dd,1,@w_fm_ini_saldo)

         
--------------------------------------------------------------------------------------------------             
-- Obtencion de cortes y periodos
--------------------------------------------------------------------------------------------------
--CortesIniciales 
select @w_corte_inicial    = co_corte from cob_conta..cb_corte where co_fecha_ini = @w_fm_ini_saldo
select @w_periodo_inicial = year(@w_fm_ini_saldo)
select '@w_corte_inicial:' = @w_corte_inicial, '@w_periodo_inicial'= @w_periodo_inicial, '@w_fm_ini_saldo'= @w_fm_ini_saldo
--Fin de Mes Anterior 
select @w_corte_fm_ant = co_corte from cob_conta..cb_corte where co_fecha_ini = @w_fin_mes_ant
select @w_periodo_mes_ant = year(@w_fin_mes_ant)
select '@w_corte_fm_ant'= @w_corte_fm_ant, '@w_periodo_mes_ant'= @w_periodo_mes_ant, '@w_fin_mes_ant'= @w_fin_mes_ant 

--Fecha Actual
select @w_corte_f_actual = co_corte, @w_estado = co_estado from cob_conta..cb_corte where co_fecha_ini = @w_fecha_act
select @w_periodo_mes_act = year(@w_fecha_act) 

select '@w_corte_f_actual' = @w_corte_f_actual, '@w_periodo_mes_act' = @w_periodo_mes_act, '@w_fecha_act:' = @w_fecha_act
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

create table #reporte(
empresa               int         null,
V_COD_EMPRESA         varchar(4)  null,
V_COD_DIVISA          varchar(3)  null,
cuenta                varchar(14) null,
V_COD_CUENTA          varchar(15) null,
oficina               int         null,
V_COD_CENTRO_DESTINO  varchar(4)  null,
saldo_actual          money       null,
N_SALDO_ACTUAL        varchar(20) null, 
saldo_anterior        money       null,
N_SALDO_ANTERIOR      varchar(20) null, 
D_FECHA_CONTABLE      varchar(10) null,
debe                  money       null,
N_DEBE                varchar(21) null,
haber                 money       null, 
N_HABER               varchar(21) null,
saldo_ini_ant         money       null, 
N_SALDO_INICIAL_ANT   varchar(21) null,
debe_ante             money       null, 
N_DEBE_ANTERIOR       varchar(21) null,
haber_ante            money       null, 
N_HABER_ANTERIOR      varchar(21) null
)

select 
'@w_corte_fm_ant'  = @w_corte_fm_ant, 
'@w_corte_inicial' = @w_corte_inicial

--Inicial
select
empresa_ini = hi_empresa,
cuenta_ini  = hi_cuenta,
oficina_ini = hi_oficina,
credito_ini = isnull(sum(hi_credito),0),
debito_ini  = isnull(sum(hi_debito),0),
saldo_ini   = isnull(sum(hi_saldo),0)
into #valores_iniciales
from cob_conta_his..cb_hist_saldo, cob_conta..cb_cuenta
where hi_empresa = 1
and   hi_cuenta = cu_cuenta
and   hi_periodo = @w_periodo_inicial
and   hi_corte   = @w_corte_inicial
and   cu_movimiento = 'S'
group by hi_empresa, hi_cuenta, hi_oficina


insert into #reporte (
empresa,
V_COD_EMPRESA,
V_COD_DIVISA,
cuenta      ,
V_COD_CUENTA,
oficina,
V_COD_CENTRO_DESTINO,
saldo_ini_ant,
debe ,
haber,
debe_ante,
haber_ante
)
select
empresa_ini,
null,
'MXP',
cuenta_ini,
null,
oficina_ini,
null,
saldo_ini,
0,
0,
0,
0
from #valores_iniciales

--Valores Anteriores
select
empresa_ant = hi_empresa,
cuenta_ant  = hi_cuenta,
oficina_ant = hi_oficina,
credito_ant = isnull(sum(hi_credito),0),
debito_ant  = isnull(sum(hi_debito),0),
saldo_ant   = isnull(sum(hi_saldo),0)
into #valores_anteriores
from cob_conta_his..cb_hist_saldo, cob_conta..cb_cuenta
where hi_empresa = 1
and   hi_cuenta = cu_cuenta
and   hi_periodo = @w_periodo_mes_ant
and   hi_corte   = @w_corte_fm_ant
and   cu_movimiento = 'S'
group by hi_empresa, hi_cuenta, hi_oficina

create table #valores_actuales
(empresa_act  int         null,
 cuenta_act   varchar(14) null,
 oficina_act  int   null,
 credito_act  money null,
 debito_act   money null,
 saldo_act    money null
)
      
--Valores Actuales
if @w_estado = 'A'
  insert into #valores_actuales
  (empresa_act  ,
   cuenta_act   ,
   oficina_act  ,
   credito_act  ,
   debito_act   ,
   saldo_act    )
   select
   empresa_ant = sa_empresa,
   cuenta_ant  = sa_cuenta,
   oficina_ant = sa_oficina,
   credito_ant = isnull(sum(sa_credito),0),
   debito_ant  = isnull(sum(sa_debito),0),
   saldo_ant   = isnull(sum(sa_saldo),0)
   from cob_conta..cb_saldo, cob_conta..cb_cuenta
   where sa_empresa = 1
   and   sa_cuenta = cu_cuenta
   and   sa_periodo = @w_periodo_mes_act
   and   sa_corte   = @w_corte_f_actual
   and   cu_movimiento = 'S'
   group by sa_empresa, sa_cuenta, sa_oficina
else
   insert into #valores_actuales
  (empresa_act  ,
   cuenta_act   ,
   oficina_act  ,
   credito_act  ,
   debito_act   ,
   saldo_act    )
   select
   empresa_ant = hi_empresa,
   cuenta_ant  = hi_cuenta,
   oficina_ant = hi_oficina,
   credito_ant = isnull(sum(hi_credito),0),
   debito_ant  = isnull(sum(hi_debito),0),
   saldo_ant   = isnull(sum(hi_saldo),0)
   from cob_conta_his..cb_hist_saldo, cob_conta..cb_cuenta
   where hi_empresa = 1
   and   hi_cuenta = cu_cuenta
   and   hi_periodo = @w_periodo_mes_act
   and   hi_corte   = @w_corte_f_actual
   and   cu_movimiento = 'S'
   group by hi_empresa, hi_cuenta, hi_oficina
-----------------------------------------------------------------
--Obtener Mov 
-----------------------------------------------------------------
--Anterior - Inicial
select 
empresa_res_i = empresa_ant,
cuenta_res_i  = cuenta_ant,
oficina_res_i = oficina_ant,
credito_res_i = sum(credito_ant) - sum(credito_ini),
debito_res_i  = sum(debito_ant) - sum(debito_ini)
into #val_resul_ini_ante
from #valores_iniciales,
#valores_anteriores
where empresa_ini = empresa_ant
and   cuenta_ini  = cuenta_ant
and   oficina_ini = oficina_ant
group by empresa_ant, cuenta_ant, oficina_ant

insert into #val_resul_ini_ante(
empresa_res_i,
cuenta_res_i ,
oficina_res_i,
credito_res_i,
debito_res_i) 
select
empresa_ant,
cuenta_ant ,
oficina_ant,
sum(credito_ant),
sum(debito_ant)
from #valores_anteriores
where not exists(select 1 from #val_resul_ini_ante where empresa_res_i = empresa_ant and cuenta_res_i = cuenta_ant and oficina_res_i = oficina_ant)
group by empresa_ant, cuenta_ant, oficina_ant

---Actual - Anterior
select 
empresa_res_f = empresa_act,
cuenta_res_f  = cuenta_act,
oficina_res_f = oficina_act,
credito_res_f = sum(credito_act) - sum(credito_ant),
debito_res_f  = sum(debito_act) - sum(debito_ant)
into #val_resul_ant_act
from #valores_actuales,
#valores_anteriores
where empresa_act = empresa_ant
and   cuenta_act = cuenta_ant
and   oficina_act = oficina_ant
group by empresa_act, cuenta_act, oficina_act

insert into #val_resul_ant_act(
empresa_res_f,
cuenta_res_f ,
oficina_res_f,
credito_res_f,
debito_res_f) 
select
empresa_act,
cuenta_act ,
oficina_act,
sum(credito_act),
sum(debito_act)
from #valores_actuales
where not exists(select 1 from #val_resul_ant_act where empresa_res_f = empresa_act and cuenta_res_f = cuenta_act and oficina_res_f = oficina_act)
group by empresa_act, cuenta_act, oficina_act

-----------------------------------------------------------------
-----------------------------------------------------------------

--Actualizacion saldos
update #reporte set
saldo_anterior = saldo_ant
from #valores_anteriores
where empresa = empresa_ant
and   cuenta  = cuenta_ant
and   oficina = oficina_ant

insert into #reporte (
empresa,
V_COD_DIVISA,
cuenta      ,
oficina,
saldo_ini_ant,
saldo_anterior,
debe ,
haber,
debe_ante,
haber_ante
)
select
empresa_ant,
'MXP',
cuenta_ant,
oficina_ant,
0,
saldo_ant,
0,
0,
0,
0
from #valores_anteriores
where not exists(select 1 from #reporte where empresa = empresa_ant and   cuenta  = cuenta_ant and   oficina = oficina_ant)

update #reporte set
saldo_actual = saldo_act
from #valores_actuales
where empresa = empresa_act
and   cuenta  = cuenta_act
and   oficina = oficina_act


insert into #reporte (
empresa,
V_COD_DIVISA,
cuenta      ,
oficina,
saldo_ini_ant,
saldo_anterior,
saldo_actual,
debe ,
haber,
debe_ante,
haber_ante
)
select
empresa_act,
'MXP',
cuenta_act,
oficina_act,
0,
0,
saldo_act,
0,
0,
0,
0
from #valores_actuales
where not exists(select 1 from #reporte where empresa = empresa_act and cuenta = cuenta_act and oficina = oficina_act)
----------------------------------------------------------------------
--Actualizacion mov
----------------------------------------------------------------------
update #reporte set
debe_ante  = debito_res_i,
haber_ante = credito_res_i
from #val_resul_ini_ante
where empresa = empresa_res_i
and   cuenta  = cuenta_res_i
and   oficina = oficina_res_i

update #reporte set
debe  = debito_res_f,
haber = credito_res_f
from #val_resul_ant_act
where empresa = empresa_res_f
and   cuenta  = cuenta_res_f
and   oficina = oficina_res_f

update #reporte set
D_FECHA_CONTABLE = convert(varchar(10),'          ')
----------------------------------------------------------------------
----------------------------------------------------------------------

SELECT
datos = convert(varchar(4),cobis.dbo.fn_llena_0('78',4)) +
--Solicitud del cliente de quemar el valor 0078 en la empresa
convert(varchar(3),V_COD_DIVISA)+
cobis.dbo.fn_llena_0(cuenta,15)+
cobis.dbo.fn_llena_0(oficina,4)+
(case when isnull(saldo_actual,0.00) < 0 then
	'-'+cobis.dbo.fn_llena_0(convert(varchar,-isnull(saldo_actual,0.00)),19)
else
	cobis.dbo.fn_llena_0(convert(varchar,isnull(saldo_actual,0.00)),20)
end)+
(case when isnull(saldo_anterior,0.00) < 0 then
	'-'+cobis.dbo.fn_llena_0(convert(varchar,-isnull(saldo_anterior,0.00)),19)
else
	cobis.dbo.fn_llena_0(convert(varchar,isnull(saldo_anterior,0.00)),20)
end)+
D_FECHA_CONTABLE+
(case when isnull(debe,0.00) < 0 then
	'-'+cobis.dbo.fn_llena_0(convert(varchar,-isnull(debe,0.00)),19)
else
	cobis.dbo.fn_llena_0(convert(varchar,isnull(debe,0.00)),20)
end)+
(case when isnull(haber,0.00) < 0 then
	'-'+cobis.dbo.fn_llena_0(convert(varchar,-isnull(haber,0.00)),19)
else
	cobis.dbo.fn_llena_0(convert(varchar,isnull(haber,0.00)),20)
end)+
(case when isnull(saldo_ini_ant,0.00) < 0 then
	'-'+cobis.dbo.fn_llena_0(convert(varchar,-isnull(saldo_ini_ant,0.00)),19)
else
	cobis.dbo.fn_llena_0(convert(varchar,isnull(saldo_ini_ant,0.00)),20)
end)+
(case when isnull(debe_ante,0.00) < 0 then
	'-'+cobis.dbo.fn_llena_0(convert(varchar,-isnull(debe_ante,0.00)),19)
else
	cobis.dbo.fn_llena_0(convert(varchar,isnull(debe_ante,0.00)),20)
end)+
(case when isnull(haber_ante,0.00) < 0 then
	'-'+cobis.dbo.fn_llena_0(convert(varchar,-isnull(haber_ante,0.00)),19)
else
	cobis.dbo.fn_llena_0(convert(varchar,isnull(haber_ante,0.00)),20)
end)
INTO ##tmp_rep_cobis_sm
from #reporte 


select @w_reporte = 'COBIS_SM_'
select @w_sql = 'select * from ##tmp_rep_cobis_sm'


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



drop table #reporte
drop table #datos_fin_mes_ant

