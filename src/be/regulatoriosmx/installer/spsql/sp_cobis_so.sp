/*************************************************************************/
/*   Archivo:              sp_cobis_so.sp		                         */
/*   Stored procedure:     sp_cobis_so                                   */
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
/*   Genera reporte COBIS_SO_AAAAMMDD.txt del requerimiento 172199       */
/*                                                                       */
/*       Parametros de Entrada                                           */
/*			Fecha de proceso                                             */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/*    04/Abril/2022          DBM              emision inicial            */
/*************************************************************************/


USE [cob_conta_super]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID ('dbo.sp_cobis_so') IS NOT NULL
	DROP PROCEDURE dbo.sp_cobis_so
GO

CREATE proc [dbo].[sp_cobis_so](
   @i_param1  DATETIME
)
AS

DECLARE
@w_formato_fecha      int,
@w_fecha_fin          datetime,
@w_batch              int,
@w_empresa            int,
@w_ruta_arch          varchar(255),
@w_nombre_arch        varchar(30),
@w_error              int,
@w_reporte            varchar(24),
@w_sql                varchar(5000),
@w_sql_bcp            varchar(5000),
@w_msg                varchar(150),
@w_ciudad             int,
@w_fecha_fin_mes_ante datetime,
@w_periodo            int,
@w_corte              int,
@w_fecha_ini          datetime,
@w_est_vencido        int,  
@w_est_vigente        int,
@w_est_castigado      int,
@w_est_suspenso       int,
@w_est_cancelado      int,
@w_est_etapa2         int


exec @w_error    = cob_externos..sp_estados
@i_producto      = 7,
@o_est_vencido   = @w_est_vencido   out,
@o_est_vigente   = @w_est_vigente   out,
@o_est_castigado = @w_est_castigado out,
@o_est_suspenso  = @w_est_suspenso  out,
@o_est_cancelado = @w_est_cancelado out,
@o_est_etapa2 	 = @w_est_etapa2    out

--obtiene parametro DISTRITO FERIADO NACIONAL
select @w_ciudad = pa_smallint 
	from cobis..cl_parametro 
	where pa_nemonico = 'CFN' 
	AND pa_producto = 'ADM'

if @@error != 0 or @@ROWCOUNT != 1
begin
   select @w_error = 609318
   goto ERROR_PROCESO
end

select @w_fecha_fin  = @i_param1
if @w_fecha_fin is null
   select @w_fecha_fin = fp_fecha from cobis..ba_fecha_proceso

--Se resta un día al proceso porque se ejecutará al inicio de día del día siguiente
select @w_fecha_fin  = dateadd(dd,-1, @w_fecha_fin )

while exists (select 1 from cobis..cl_dias_feriados where df_fecha = @w_fecha_fin  and df_ciudad = @w_ciudad)
begin
                select @w_fecha_fin  = dateadd(dd,-1, @w_fecha_fin )
end

select @w_fecha_ini = dateadd (mm, datediff(mm,0,@w_fecha_fin), 0)
select @w_fecha_fin_mes_ante = dateadd(month, datediff(month, -1, @w_fecha_fin)-1, -1)

print '@w_fecha_ini: ' + convert(varchar,@w_fecha_ini)
print '@w_fecha_fin: ' + convert(varchar,@w_fecha_fin)
print '@w_fecha_fin_mes_ante: ' + convert(varchar,@w_fecha_fin_mes_ante)

--Reporte 6.7.	Generación de Archivo COBIS_SO_AAAAMMDD.txt

select  @w_formato_fecha = 111, 
		@w_batch = 36430, 
		@w_empresa = 1 

select	
@w_ruta_arch	= ba_path_destino,
--@w_nombre_arch	= replace(convert(varchar,@i_param1, 106), ' ', '_')
@w_nombre_arch	= CONVERT(varchar,DATEPART(yyyy, @w_fecha_fin),4)+CONVERT(varchar,cobis.dbo.fn_llena_0(DATEPART(mm, @w_fecha_fin),2),2)+CONVERT(varchar,cobis.dbo.fn_llena_0(DATEPART(dd, @w_fecha_fin),2),2)

from cobis..ba_batch
where ba_batch = @w_batch

if @@error != 0 or @@rowcount != 1 or isnull(@w_ruta_arch, '') = '' or isnull(@w_nombre_arch, '') = ''
begin
   select @w_error = 70134
   goto ERROR_PROCESO
END

IF OBJECT_ID('tempdb..##tmp_cobis_so') IS NOT NULL DROP TABLE ##tmp_cobis_so




/*CREAR TABLAS DE TRABAJO*/
create table #dato_operacion(
do_banco             varchar(24)   not null,
do_toperacion        varchar(10)   not null,
do_moneda            smallint      not null,
do_tgarantia         varchar(10)   not null,
do_calificacion      varchar(10)   not null,
do_clase_cartera     varchar(10)   not null,
do_oficina           smallint      not null,
do_cliente           int           not null,
do_fuente_recurso    varchar(10)   not null,
do_ent_convenio      varchar(1)    not null,
do_tipo_cartera      varchar(10)   not null,
do_subtipo_cartera   varchar(10)   not null,
do_codigo_cliente    int           not null,
do_estado_cartera    int           not null)

create table #perfil_boc(
pb_concepto        catalogo     not null,
pb_codigo          int          not null,
pb_codvalor        int          not null,
pb_parametro       varchar(11)  not null,
pb_tparametro      varchar(20)  not null
)

create table #cuentas_boc(
parametro     varchar(11) not null,
clave         varchar(40) not null,
cuenta        varchar(40) not null,
tercero       char(1)     not null,
naturaleza    char(1)     not null,
perfil        varchar(20) null)

create index idx1 on #cuentas_boc(parametro, clave)

--------------------------------------------------------
--Operaciones Activas
--------------------------------------------------------
insert into #dato_operacion
select
do_banco            = do_banco,
do_toperacion       = ltrim(rtrim(do_tipo_operacion)),
do_moneda           = do_moneda,
do_tgarantia        = case when do_tipo_garantias in ('H','I','A','E') then 'I' else 'O' end,
do_calificacion     = isnull(do_calificacion, 'A'),
do_clase_cartera    = ltrim(rtrim(do_clase_cartera)),
do_oficina          = do_oficina,
do_cliente          = do_codigo_cliente,
do_fuente_recurso   = isnull(do_fuente_recurso,''),
do_ent_convenio     = case when do_entidad_convenio = null then '1' else '0' end,
do_tipo_cartera     = ltrim(rtrim(do_tipo_cartera)),
do_subtipo_cartera  = ltrim(rtrim(do_subtipo_cartera)),
do_codigo_cliente   = do_codigo_cliente,
do_estado_cartera   = do_estado_cartera
from cob_conta_super..sb_dato_operacion
where do_fecha       = @w_fecha_fin
and   do_aplicativo  = 7


create index idx1 on #dato_operacion(do_banco)
create index idx2 on #dato_operacion(do_codigo_cliente)
create index idx3 on #dato_operacion(do_toperacion)


select do_banco, do_codigo_cliente
into #actualizacion_ente
from #dato_operacion

--Eliminamos registros cancelados y castigados
delete #dato_operacion where do_estado_cartera = @w_est_castigado 
delete #dato_operacion where do_estado_cartera = @w_est_cancelado --and do_toperacion <> 'REVOLVENTE'


-------------------------------------------------------
--Perfiles contables                                --
-------------------------------------------------------
truncate table #cuentas_boc

insert into #cuentas_boc(
parametro     ,
clave         ,
cuenta        ,
tercero       ,
naturaleza    ,
perfil        )
select distinct
parametro  = re_parametro,
clave      = re_clave,
cuenta     = re_substring,
tercero    = 'N',
naturaleza = '' ,
perfil     = dp_perfil
from cob_conta..cb_relparam, cob_conta..cb_det_perfil
where re_empresa   = dp_empresa
and   re_producto  = dp_producto
and   re_parametro = dp_cuenta

-------------------------------------------------------
--Saldos Iniciales                                   --
-------------------------------------------------------
select 
@w_periodo = co_periodo,
@w_corte   = co_corte
from cob_conta..cb_corte
where co_fecha_ini = @w_fecha_fin_mes_ante

select 
st_ente    ,
st_oficina , 
st_cuenta  ,    
st_saldo  = st_saldo,
st_clave   = convert(varchar(40), null),
st_banco   = convert(varchar(15), null)
into #saldos_anteriores
from cob_conta_tercero..ct_saldo_tercero
where st_periodo = @w_periodo
and   st_corte   = @w_corte
and   exists (select 1 from #dato_operacion where st_ente = do_codigo_cliente)

-------------------------------------------------------
--Movimientos del mes                                --
-------------------------------------------------------
select 
sa_fecha_tran  ,
sa_cuenta      ,
sa_oficina_dest, 
sa_debito  ,
sa_credito ,
banco   = case when sa_documento is not null then sa_documento
               when sa_documento is null and charindex('Ban:',sa_concepto,0)>0 then substring(sa_concepto,charindex('Ban:',sa_concepto,0) + 4, charindex('Sec:',sa_concepto,0)-5)
               else '            ' end,
sa_ente 
into #mov_mes_actual 
from cob_conta_tercero..ct_sasiento,
cob_conta_tercero..ct_scomprobante
where sc_fecha_tran  >= @w_fecha_ini
and   sc_fecha_tran  <= @w_fecha_fin
and   sc_fecha_tran  = sa_fecha_tran
and   sc_comprobante = sa_comprobante
and   sa_producto    = sc_producto

update #mov_mes_actual  set
sa_ente = do_codigo_cliente
from #actualizacion_ente
where banco = do_banco
and   sa_ente is null

select 
sa_ente   , 
sa_cuenta ,
sa_oficina_dest, 
sa_saldo = sum(sa_debito) - sum(sa_credito),
sa_clave   = convert(varchar(40), null),
sa_banco   = convert(varchar(20), null)
into #suma_mov_clientes_banco
from #mov_mes_actual 
group by sa_ente, sa_cuenta , sa_oficina_dest

update #suma_mov_clientes_banco set
sa_saldo  = sa_saldo  + st_saldo
from #saldos_anteriores
where sa_ente         = st_ente
and   sa_cuenta       = st_cuenta
and   sa_oficina_dest = st_oficina

-------------------------------------------------------
-------------------------------------------------------
insert into #suma_mov_clientes_banco
select
st_ente ,
--st_banco,
st_cuenta,
st_oficina,
st_saldo,--,
--st_credito
null,
null
from #saldos_anteriores
where not exists(select 1
                 from #suma_mov_clientes_banco
                 where sa_ente         = st_ente
                 and   sa_cuenta       = st_cuenta
                 ---and   banco           = st_banco
                 and   sa_oficina_dest = st_oficina)
                 
-----------------------------------------------------------------------
-----------------------------------------------------------------------
update #suma_mov_clientes_banco set
sa_clave = clave
from #cuentas_boc
where sa_cuenta = cuenta

select do_codigo_cliente, do_toperacion, do_banco = max(do_banco)
into #operaciones_cliente
from #dato_operacion
group by do_codigo_cliente, do_toperacion

update #suma_mov_clientes_banco set
sa_banco  = do_banco
from #operaciones_cliente
where sa_ente      = do_codigo_cliente
and  sa_clave like '%GRUPAL'
and  do_toperacion = 'GRUPAL'

update #suma_mov_clientes_banco set
sa_banco  = do_banco
from #operaciones_cliente
where sa_ente      = do_codigo_cliente
and  sa_clave like '%REVOLVENTE'
and  do_toperacion = 'REVOLVENTE'

update #suma_mov_clientes_banco set
sa_banco  = do_banco
from #operaciones_cliente
where sa_ente      = do_codigo_cliente
and  sa_clave like '%INDIVIDUAL'
and  do_toperacion = 'INDIVIDUAL'


-- eliminacion de registros que no tienen operaciones activas.
delete #mov_mes_actual
where not exists (select 1 from #dato_operacion where do_banco = banco)


select
datos = 
cobis.dbo.fn_llena_0('78',4) + 
convert(varchar,@w_fecha_fin,23)  +
cobis.dbo.fn_llena_0(sa_cuenta,15) +
cobis.dbo.fn_llena_0(sa_oficina_dest,4)+
'MXP' +
case when sa_saldo < 0 then
      '-'+cobis.dbo.fn_llena_0(convert(varchar,-sa_saldo),19)
else
      cobis.dbo.fn_llena_0(convert(varchar,sa_saldo),20)
end +
cobis.dbo.fn_llena_0(convert(varchar,0.00),20)+
cobis.dbo.fn_llena_0(0.00,20)+
cobis.dbo.fn_llena_0(0.00,20)+
cobis.dbo.fn_llena_0(sa_banco,12) + -- V_IDENTIFICADOR_OPE
'                  '+
'COB'
INTO ##tmp_cobis_so
from #suma_mov_clientes_banco
order by sa_banco

delete ##tmp_cobis_so where datos is null

select @w_reporte = 'COBIS_SO_'
select @w_sql = 'select * from ##tmp_cobis_so'


select	@w_sql_bcp = 'bcp "' + @w_sql + '" queryout "' + @w_ruta_arch + @w_reporte + @w_nombre_arch +'".txt"'+'" -C -c -t";" -T'

EXEC xp_cmdshell @w_sql_bcp


IF NOT EXISTS (select 1 from cobis..cl_log_notificador where ln_nemonico = 'COPYBTI' and ln_report_name = @w_reporte + @w_nombre_arch +'.txt' and ln_gen_process_date = @w_fecha_fin)
BEGIN
	INSERT INTO cobis..cl_log_notificador (ln_nemonico, ln_report_name, ln_generation_date, ln_gen_process_date, ln_upload_date, ln_copy_date, ln_report_pattern, ln_status)
	VALUES ('COPYBTI', @w_reporte + @w_nombre_arch +'.txt', GETDATE(),@w_fecha_fin, null, null, @w_reporte +'{PPD:yyyyMMdd}.txt', null)
END
ELSE
BEGIN
	UPDATE cobis..cl_log_notificador
	SET
		ln_generation_date = GETDATE(),
		ln_status = NULL
	where ln_nemonico = 'COPYBTI' and ln_report_name = @w_reporte + @w_nombre_arch +'.txt' and ln_gen_process_date = @w_fecha_fin
END

IF NOT EXISTS (select 1 from cobis..cl_log_notificador where ln_nemonico = 'CHARITS' and ln_report_name = @w_reporte + @w_nombre_arch +'.txt' and ln_gen_process_date = @w_fecha_fin)
BEGIN
	INSERT INTO cobis..cl_log_notificador (ln_nemonico, ln_report_name, ln_generation_date, ln_gen_process_date, ln_upload_date, ln_copy_date, ln_report_pattern, ln_status)
	VALUES ('CHARITS', @w_reporte + @w_nombre_arch +'.txt', GETDATE(),@w_fecha_fin, null, null, @w_reporte +'{PPD:yyyyMMdd}.txt', null)
END
ELSE
BEGIN
	UPDATE cobis..cl_log_notificador
	SET
		ln_generation_date = GETDATE(),
		ln_status = NULL
	where ln_nemonico = 'CHARITS' and ln_report_name = @w_reporte + @w_nombre_arch +'.txt' and ln_gen_process_date = @w_fecha_fin
END

return 0

ERROR_PROCESO:

select @w_msg = mensaje
from cobis..cl_errores with (nolock)
where numero = @w_error
