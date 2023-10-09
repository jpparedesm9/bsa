/*************************************************************************/  
/*   Archivo:              banxico.sp			                         */
/*   Stored procedure:     sp_banxico                                    */
/*   Base de datos:        cob_conta_super                               */
/*   Producto:             Regulatorios                                  */
/*   Disenado por:         Raymundo Picazo - Sonia Rojas                 */
/*   Fecha de escritura:   Enero 2019                                    */
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
/*   Genera reporte regulatorio baxico desde la sarta 22                 */
/*                                                                       */
/*       Parametros de Entrada                                           */
/*			Fecha de proceso                                             */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/*    14/Enero/2019           RPA              emision inicial           */
/*    26/Febrero/2019         RPA     Modificacion nombre del reporte    */
/*    05-07-2019           srojas     Reestructuración Buro histórico  	 */
/*    11/Julio/2019           MDP     Se agrega solo ejecución mensual   */
/*    17/Septiembre/2019      JCH     creacion reporte LCR 		          */
/*    18-10-2019              MTA     Validar Ejecucion doble cierre     */
/*  07/noviembre/2019         JCH     optimizacion de caso 122487 a 129694*/
/*   07/01/2020               ACH     Caso#133012,codigoPostalSinPrincipal*/
/*   01/12/2020               DCU     Caso #150300l, cambio tipo dato    */
/*   10/02/2022               DBM     Caso #172727, ajuste reportes      */
/*************************************************************************/

USE [cob_conta_super]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID ('dbo.sp_banxico') IS NOT NULL
	DROP PROCEDURE dbo.sp_banxico
GO

CREATE proc [dbo].[sp_banxico](
   @i_param1  DATETIME
)
AS





DECLARE
@w_return			      int,
@w_error			      int,
@w_mensaje                varchar(150),
@w_sql				      varchar(5000),
@w_sql_bcp			      varchar(5000),
@w_sp_name                varchar(64),
@w_msg                    varchar(255),
@w_ciudad_nacional        SMALLINT,
@w_fecha_inicio           datetime,
@w_fecha_corte            datetime,
@w_fecha_fin              datetime,
@w_fecha_fin_ant          datetime,
@w_est_vigente            int,
@w_est_vencido            int,
@w_est_cancelado          int,
@w_solicitud              char(1),
@w_batch			      int,
@w_empresa			      int,
@w_fecha_proceso	      datetime,
@w_formato_fecha	      int,
@w_ruta_arch		      varchar(255),
@w_nombre_arch		      varchar(30),
@w_rep_req                varchar(24),
@w_reporte                varchar(24),
@w_reporte_seguimiento    varchar(24),
@w_reporte_altas          varchar(24),
@w_reporte_bajas          varchar(24),
@w_reporte_reservas       varchar(24),
@w_reporte_revolvente     varchar(24),
@w_mes_cen                varchar(2),
@w_anio_cen               varchar(4),
@w_ciudad                 int,
@w_fin_mes				  char(1),
@w_sig_habil              datetime,
@w_fecha_aux              DATETIME,
@w_est_castigado          INT,
@w_est_suspenso    		  INT,
@w_est_etapa2			  INT,
@w_fecha_fin_bmp          DATETIME,
@w_fecha_aux_bmp          DATETIME,
@w_reporte_lcr  		  varchar(24),
@w_fecha_bimestre_ini     DATETIME

declare @w_sec_valores_pagados table(
   vp_secuencial          int,
   vp_banco               varchar(30)
)

exec @w_error    = cob_externos..sp_estados
@i_producto      = 7,
@o_est_vencido   = @w_est_vencido   out,
@o_est_vigente   = @w_est_vigente   out,
@o_est_castigado = @w_est_castigado out,
@o_est_suspenso  = @w_est_suspenso  out,
@o_est_cancelado = @w_est_cancelado out,
@o_est_etapa2 	 = @w_est_etapa2    out

if @@error <> 0 begin
   print 'No Encontro Estado Vencido/Vigente/Castigado para Cartera'
   return 1
end
	   

select @w_rep_req = 'BXO'
select @w_sp_name = 'sp_banxico', @w_reporte = 'BANXICO'

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

--MTA inicio

/* DETERMINAR SI HOY ES EL ULTIMO HABIL DEL MES */
IF @i_param1 IS NOT NULL or @i_param1 <> ' '
begin 
	select @w_fecha_proceso = @i_param1
end

SELECT @w_fecha_aux = dateadd(dd,-1,@w_fecha_proceso )

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


IF (datepart(day, @w_fecha_proceso) = 1) 
BEGIN
         while exists (select 1 from cobis..cl_dias_feriados where df_fecha = @w_fecha_aux and df_ciudad = @w_ciudad)
         begin
                select @w_fecha_aux = dateadd(dd,-1, @w_fecha_aux)
         end
END 
ELSE
BEGIN
   --SELECT '---------------------> sale'
	return 0
END 

--select 'PARAM ' = @i_param1, 'fproc' = @w_fecha_proceso, 'f_ult_lab' = @w_fecha_aux 

--MTA Fin 

declare @resultadobcp table (linea varchar(max))

declare @TablaRiesgo as table
(
	calificacion	varchar(3),
	rango_desde		float,
	rango_hasta		float
)

IF @i_param1 IS NOT NULL or @i_param1 <> ' '
begin 
--	select @w_mes_cen = SUBSTRING( convert(varchar(25), @i_param1, 120) , 6,7);  --mta
--	select @w_anio_cen = SUBSTRING( convert(varchar(25), @i_param1, 120) , 1,4);  --mta 
	select @w_mes_cen = SUBSTRING( convert(varchar(25), @w_fecha_aux, 120) , 6,7)
	select @w_anio_cen = SUBSTRING( convert(varchar(25), @w_fecha_aux, 120) , 1,4)
end


update cob_conta..cb_solicitud_reportes_reg
set   sr_mes =  @w_mes_cen,
      sr_anio = @w_anio_cen,
	  sr_status = 'I' 
where sr_reporte = @w_rep_req

print @w_rep_req
exec @w_return = cob_conta..sp_calcula_ultima_fecha_habil
@i_reporte			= @w_rep_req,
@o_existe_solicitud = @w_solicitud out,
@o_ini_mes			= @w_fecha_inicio out,
@o_fin_mes			= @w_fecha_corte out,
@o_fin_mes_hab		= @w_fecha_fin out

if @w_return != 0
begin
   select @w_error = @w_return
   goto ERROR_PROCESO
end
 
if @w_solicitud = 'N' return 0

select @w_fecha_inicio = DATEADD(month, -1, @w_fecha_inicio) --Esto es por que es bimenstral 
select @w_formato_fecha = 111, @w_batch = 36430, @w_empresa = 1 

select	
@w_ruta_arch	= ba_path_destino,
@w_nombre_arch	= replace(convert(varchar,@w_fecha_corte, 106), ' ', '_')
from cobis..ba_batch
where ba_batch = @w_batch

if @@error != 0 or @@rowcount != 1 or isnull(@w_ruta_arch, '') = '' or isnull(@w_nombre_arch, '') = ''
begin
   select @w_error = 70134
   goto ERROR_PROCESO
end
	   
IF OBJECT_ID('tempdb..##tmp_seguimiento') IS NOT NULL DROP TABLE ##tmp_seguimiento
IF OBJECT_ID('tempdb..#tmp_saldo_devengado') IS NOT NULL DROP TABLE #tmp_saldo_devengado
IF OBJECT_ID('tempdb..#tmp_dias_atraso_op') IS NOT NULL DROP TABLE #tmp_dias_atraso_op
IF OBJECT_ID('tempdb..#tmp_dias_vencimiento') IS NOT NULL DROP TABLE #tmp_dias_vencimiento
IF OBJECT_ID('tempdb..#tmp_clientes') IS NOT NULL DROP TABLE #tmp_clientes
IF OBJECT_ID('tempdb..##tmp_altas') IS NOT NULL DROP TABLE ##tmp_altas
IF OBJECT_ID('tempdb..##tmp_bajas') IS NOT NULL DROP TABLE ##tmp_bajas
IF OBJECT_ID('tempdb..##tmp_reservas') IS NOT NULL DROP TABLE ##tmp_reservas
IF OBJECT_ID('tempdb..#tmp_pagos') IS NOT NULL DROP TABLE #tmp_pagos
if object_id('tempdb..#ultima_cuota') is not null  drop table #ultima_cuota
IF OBJECT_ID('tempdb..##tmp_linea_revolvente') is not null  drop table ##tmp_linea_revolvente
IF OBJECT_ID('tempdb..##tmp_linea_revolvente_tmp') is not null  drop table ##tmp_linea_revolvente_tmp

--------------------------------------------------------------------------------------------
-------------------------       REPORTE SEGUIMIENTO          -------------------------------
--------------------------------------------------------------------------------------------

--SELECT 'F CONSOL' = @w_fecha_fin  mta

/***************************************************/

select 
ts_id_producto               = '69401', --1
ts_banco                     = do_banco, --2
ts_codigo_cliente            = do_codigo_cliente,--3
ts_clasificacion_cred        = case WHEN do_dias_mora_365 <= 30 then '1'
                                WHEN do_dias_mora_365 >= 31 AND do_dias_mora_365 <= 89 then '2'
		                        WHEN do_dias_mora_365 >= 90 AND do_dias_mora_365 <= 180 then '3'
								end,--4
ts_reestructura              = 40,--5
ts_tipo_microcredito         = case --6
                                  when do_tipo_operacion = 'GRUPAL' THEN 0
                                  when do_tipo_operacion = 'INDIVIDUAL' THEN 1
                                  else 2
                               end,
ts_fecha_originacion         = convert(char(10), do_fecha_concesion, 111),--7
ts_fecha_reestructura        = convert(char(10), do_fecha_concesion, 111),--8
ts_fecha_fin_reestructura    = convert(char(10), do_fecha_vencimiento, 111),--9
ts_tipo_estado_cuenta 		 = 0,--10
ts_estado_cuenta_papel		 = 0,--11
ts_banca_internet		     = case --12
								when (SELECT COUNT(*) FROM cobis..cl_telefono, cob_bvirtual..bv_in_login WHERE do_codigo_cliente = te_ente AND te_valor = il_login) >= 1 then 1
								else 0 
								end,
ts_fecha_vencimiento         = convert(char(10), do_fecha_vencimiento, 111),--13
ts_escala_periodos           = case UPPER(do_periodicidad_cuota) --14
                                  when 7    then 10
		                          when 10   then 20
		                          when 14   then 30
		                          when 15   then 40
		                          when 30   then 50
		                          else 60
		                        end,
ts_plazo_meses               = do_plazo_dias/30.4,--15
ts_monto                     = do_monto,--16
ts_tasa_int_anual            = do_tasa_com,--17
ts_mecanismo_pago            = 80,--18
ts_medio_adq_credito		 = 1,--19
ts_fecha_corte               = convert(char(10), @w_fecha_fin, 111),--20
ts_saldo_devengado           = convert(money,0), --Saldo Capital mas Saldo de Intereses Devengados no Cobrados --21
ts_monto_exigible            = convert(money,0), --suma campos --22
ts_monto_exigible_cap        = convert(money,0), --do_saldo_cap, mta --23
ts_monto_exigible_int        = convert(money,0), --do_saldo_int, mta --24
ts_monto_exigible_com        = convert(money,0), --25
ts_monto_exigible_com_np     = convert(money,0), --26
ts_monto_exigible_otros      = convert(money,0),/*(select --27
								sum(case when dr_categoria  = 'A' and dr_cat_rub_aso  = 'I' and dr_exigible    = 1 then  isnull(dr_valor,0) else 0 end)
								from cob_conta_super..sb_dato_operacion_rubro
								where dr_fecha      = @w_fecha_fin
								and   dr_aplicativo = 7
								and   dr_banco      = do_banco
								group by dr_banco)*/
ts_pago_realizado            = convert(money,0), --suma campos --28
ts_pago_realizado_cap        = convert(money,0), --29
ts_pago_realizado_int        = convert(money,0), --30
ts_pago_realizado_com        = convert(money,0), --31
ts_pago_realizado_com_np     = convert(money,0), --32
ts_pago_realizado_iva        = convert(money,0), --33
ts_quitas                    = 0,--34
ts_relacion_acreditado       = 1,--35
ts_indicador_garantia        = 1,--36
ts_numero_garantias          = 0,--37
ts_grupo                     = isnull(do_grupo, 0),--38
ts_miembros_grupo            = isnull(do_numero_integrantes, 0),--39
ts_ciclo                     = 0,--40
ts_porcentaje_pago           = convert(float,0.0), --41
ts_dias_atraso               = do_dias_mora_365,--round(convert(float,do_dias_mora_365)/30.4, 2),--42
ts_atr                       = 0,--43
ts_atr_max                   = 0,--44
ts_meses                     = 0,--45
ts_ind_consulta_sic          = null,--46
ts_meses_cons_sic            = null,--47
ts_riesgo                    = 0,--48
ts_monto_buro                = convert(float,0.0),--49
ts_saldo_buro                = null,--50
ts_cociente                  = null,--51 
ts_antiguedad                = do_meses_primer_op,--52
ts_metodologia_reversas      = 0,--53
ts_etapa_deterioro			 = case --54
                              WHEN do_dias_mora_365 <= 30 then 1
                              WHEN do_dias_mora_365 >= 31 AND do_dias_mora_365 <= 89 then 2
		                        WHEN do_dias_mora_365 >= 90 AND do_dias_mora_365 <= 180 then 3
                              else convert(varchar(20), null)
                              end,
ts_tasa_int_anual_cob        = do_tasa_com, --55
ts_prob_incumplimiento       = null,--56
ts_sev_perdida       		 = null,--57
ts_exposicion_incump_total   = do_saldo_cap + do_saldo_int ,--58
ts_metodologia_reversas_gen  = null,--59
ts_met_reservas_horizonte    = null,--60
ts_reservas_gen              = null,--61
ts_etapa_deterioro_nif       = 0,--62
ts_tasa_descuento_nif        = 0,--63
ts_tasa_interes_nif          = 0,--64
ts_tasa_prepago_anual_nif    = 0,--65
ts_probabilidad_incump       = 0,--66
ts_severidad_perdida         = 0,--67
ts_exposicion_incump_interna = 0,--68
ts_monto_reservas            = 0,--69
ts_reservas_met_interna      = 0,--70
ts_reservas_total_interna    = 0,--71
ts_prob_incump_capital		 = 0,--72
ts_sev_perdida_capital       = 0,--73
ts_exp_incump_capital 	     = 0,--74
ts_reservas_total_capital    = 0,--75
ts_reservas_adicionales      = null,--76
ts_cat_originacion           = do_valor_cat,--77
ts_cat_fecha_corte			 = do_valor_cat--78
into ##tmp_seguimiento
from cob_conta_super..sb_dato_operacion
where do_fecha = @w_fecha_fin
and do_tipo_operacion = 'GRUPAL'
and do_estado_cartera in (@w_est_vigente, @w_est_vencido, @w_est_etapa2)

select banco = dc_banco, cuota = max(dc_num_cuota)
into #ultima_cuota
from cob_conta_super..sb_dato_cuota_pry 
where dc_fecha = @w_fecha_fin and dc_fecha_vto <= @w_fecha_fin
group by dc_banco


select 
banco = dd_banco, 
rubro_cap       = sum(case  when dd_concepto = 'CAP' and dt_reversa = 'N' then dd_monto when dd_concepto = 'CAP' and dt_reversa = 'S' then (dd_monto * -1)  else 0 end),
rubro_int       = sum(case  when dd_concepto = 'INT' and dt_reversa = 'N' then dd_monto when dd_concepto = 'INT' and dt_reversa = 'S' then (dd_monto * -1)  else 0 end),
rubro_iva       = sum(case  when dd_concepto IN ('IVA_INT','IVA_CMORA') and dt_reversa = 'N' then dd_monto when dd_concepto IN ('IVA_INT','IVA_CMORA') and dt_reversa = 'S' then (dd_monto * -1)  else 0 end),
rubro_commora   = sum(case  when dd_concepto = 'COMMORA' and dt_reversa = 'N' then dd_monto when dd_concepto = 'COMMORA' and dt_reversa = 'S' then (dd_monto * -1)  else 0 end)
into #tmp_pagos
from sb_dato_transaccion, sb_dato_transaccion_det, ##tmp_seguimiento
where dd_banco = dt_banco
and dd_fecha = dt_fecha
and dd_secuencial = dt_secuencial
and dd_aplicativo = dt_aplicativo
and ts_banco = dd_banco
and dd_fecha between @w_fecha_inicio and @w_fecha_fin
and dt_tipo_trans = 'PAG'
group by dd_banco
		
select * into #rubro_negativo from #tmp_pagos 
where rubro_cap < 0 or rubro_int < 0 or rubro_iva < 0 or rubro_commora <0 

delete from #tmp_pagos where rubro_cap < 0 or rubro_int < 0 or rubro_iva < 0 or rubro_commora <0

insert into #tmp_pagos
select 
banco = dd_banco, 
rubro_cap       = sum(case  when dd_concepto = 'CAP' and dt_reversa = 'N' then dd_monto when dd_concepto = 'CAP' and dt_reversa = 'S' then (dd_monto * -1)  else 0 end),
rubro_int       = sum(case  when dd_concepto = 'INT' and dt_reversa = 'N' then dd_monto when dd_concepto = 'INT' and dt_reversa = 'S' then (dd_monto * -1)  else 0 end),
rubro_iva       = sum(case  when dd_concepto IN ('IVA_INT','IVA_CMORA') and dt_reversa = 'N' then dd_monto when dd_concepto IN ('IVA_INT','IVA_CMORA') and dt_reversa = 'S' then (dd_monto * -1)  else 0 end),
rubro_commora   = sum(case  when dd_concepto = 'COMMORA' and dt_reversa = 'N' then dd_monto when dd_concepto = 'COMMORA' and dt_reversa = 'S' then (dd_monto * -1)  else 0 end)
from sb_dato_transaccion, sb_dato_transaccion_det, #rubro_negativo
where dd_banco = dt_banco
and dd_fecha = dt_fecha
and dd_secuencial = dt_secuencial
and dd_aplicativo = dt_aplicativo
and banco = dd_banco
and dt_fecha_trans between @w_fecha_inicio and @w_fecha_fin
and dt_tipo_trans = 'PAG'
group by dd_banco

	
--Pagos realizados

update ##tmp_seguimiento set 
ts_pago_realizado_cap = round(rubro_cap,2),
ts_pago_realizado_int = round(rubro_int,2),
ts_pago_realizado_com_np = round(rubro_commora,2),
ts_pago_realizado_iva = round(rubro_iva,2)
from #tmp_pagos
where ts_banco = banco

--MTA Inicio
select
dr_banco,
--CAPITALES
dr_cap_vig_ex    = sum(case when dr_categoria  = 'C'  and dr_estado =   @w_est_vigente  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
dr_cap_vig_ne    = sum(case when dr_categoria  = 'C'  and dr_estado =   @w_est_vigente  and dr_exigible   = 0 then  isnull(dr_valor,0) else 0 end ), 
dr_cap_ven_ex    = sum(case when dr_categoria  = 'C'  and dr_estado in (@w_est_vencido,@w_est_castigado)  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
dr_cap_ven_ne    = sum(case when dr_categoria  = 'C'  and dr_estado in (@w_est_vencido,@w_est_castigado)  and dr_exigible   = 0 then  isnull(dr_valor,0) else 0 end ), 
--INTERESES
dr_int_vig_ex    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vigente  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
dr_int_vig_ne    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vigente  and dr_exigible   = 0 then  isnull(dr_valor,0) else 0 end), 
dr_int_ven_ex    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vencido  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
dr_int_ven_ne    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vencido  and dr_exigible   = 0 then  isnull(dr_valor,0) else 0 end),
--IVAS
dr_iva_int_ex    = sum(case when dr_categoria  = 'A' and dr_cat_rub_aso  = 'I' and dr_exigible    = 1 then  isnull(dr_valor,0) else 0 end),
dr_saldo_iva_com = sum(case when dr_categoria  = 'A' and  dr_cat_rub_aso  = 'O' then isnull(dr_valor,0) else 0 end),
--INTERES SUSPENDIDO
dr_int_sus_ex    = sum(case when dr_categoria  = 'I' and dr_estado in (@w_est_suspenso,@w_est_castigado) and dr_exigible   = 1   then  isnull(dr_valor,0) else 0 end ),
dr_int_sus_ne    = sum(case when dr_categoria  = 'I' and dr_estado in (@w_est_suspenso,@w_est_castigado) and dr_exigible   = 0   then  isnull(dr_valor,0) else 0 end ),

dr_com_ex        = sum(case when dr_categoria  = 'O' and dr_exigible    = 1   then isnull(dr_valor,0) else 0 end),
dr_com_ne        = sum(case when dr_categoria  = 'O' and dr_exigible    = 0   then isnull(dr_valor,0) else 0 end)

into #rubros_tmp
from ##tmp_seguimiento, cob_conta_super..sb_dato_operacion_rubro
where dr_fecha      = @w_fecha_fin
and   dr_aplicativo = 7
and   dr_banco      = ts_banco
group by dr_banco



UPDATE ##tmp_seguimiento
SET ts_monto_exigible_cap = dr_cap_vig_ex + dr_cap_ven_ex,
    ts_monto_exigible_int = dr_int_vig_ex + dr_int_ven_ex + dr_int_ven_ne,
    ts_saldo_devengado = isnull(dr_cap_vig_ex + dr_cap_ven_ex + dr_int_vig_ex + dr_int_ven_ex + dr_int_ven_ne, 0),
	ts_exposicion_incump_total = ts_exposicion_incump_total - dr_int_sus_ex - dr_int_sus_ne,
	ts_monto_exigible_com_np = dr_com_ex + dr_com_ne,
   ts_monto_exigible_otros = dr_iva_int_ex + dr_saldo_iva_com
FROM #rubros_tmp 
WHERE ts_banco = dr_banco

--MTA Fin

update ##tmp_seguimiento 
set ts_ciclo    = isnull(dc_ciclo,0)
from cob_cartera..ca_operacion, cob_cartera..ca_det_ciclo 
where ts_banco = op_banco
and dc_operacion = op_operacion

select banco = doa_banco, quita = sum(doa_total)
into #quitas
FROM cob_conta_super..sb_dato_operacion_abono, ##tmp_seguimiento 
WHERE doa_fecha = @w_fecha_fin 
AND   doa_banco  = ts_banco 
AND doa_condonaciones = 'S'
AND doa_fecha_pag between @w_fecha_inicio and @w_fecha_fin
GROUP BY doa_banco

--Quitas y condonaciones
UPDATE ##tmp_seguimiento 
   set ts_quitas = quita
FROM #quitas 
WHERE banco  = ts_banco


--Campo 16(suma campo 17 - 21) y 22 (suma campos 23 - 27)
update ##tmp_seguimiento set 
ts_monto_exigible = ts_monto_exigible_cap + 
                    ts_monto_exigible_int + 
                  ts_monto_exigible_com_np,
ts_pago_realizado = round(ts_pago_realizado_cap +
	                        ts_pago_realizado_int +
                           ts_pago_realizado_com +
                           ts_pago_realizado_iva +
                           ts_pago_realizado_com_np, 2)	
--

update ##tmp_seguimiento set 
ts_monto_exigible = ts_monto_exigible + dr_iva_int_ex + dr_saldo_iva_com
from #rubros_tmp 
where ts_banco = dr_banco


if object_id ('sb_banxico_seguimiento') is not null drop table sb_banxico_seguimiento
select * into sb_banxico_seguimiento from ##tmp_seguimiento
 
select @w_reporte_seguimiento = 'Banxico_Seguimiento_'
select @w_sql = 'select * from ##tmp_seguimiento'


select	@w_sql_bcp = 'bcp "' + @w_sql + '" queryout "' + @w_ruta_arch + @w_reporte_seguimiento + @w_nombre_arch +'".txt"'+'" -C -c -t";" -T'

delete from @resultadobcp
insert into @resultadobcp
EXEC xp_cmdshell @w_sql_bcp
select * from @resultadobcp


--------------------------------------------------------------------------------------------
-------------------------             REPORTE ALTAS          -------------------------------
--------------------------------------------------------------------------------------------


select distinct cliente  = do_codigo_cliente
into #tmp_clientes
from sb_dato_operacion
where do_fecha = @w_fecha_fin
and do_estado_cartera = 1
and do_codigo_cliente not in (select distinct do_codigo_cliente
                              from sb_dato_operacion
                                where do_fecha < @w_fecha_inicio)
                                

insert into #tmp_clientes
select distinct cliente  = do_codigo_cliente
from sb_dato_operacion
where do_fecha = @w_fecha_fin
and do_tipo_operacion = 'REVOLVENTE'
and do_monto = 0
and do_fecha_concesion between @w_fecha_inicio and @w_fecha_fin
and not exists (select 1
                   from cob_conta_super..sb_dato_transaccion
                   where dt_banco = do_banco
                   and   dt_tipo_trans = 'DES')
and do_codigo_cliente not in (select distinct do_codigo_cliente
                              from sb_dato_operacion
                                where do_fecha < @w_fecha_inicio)
and do_codigo_cliente not in (select cliente from #tmp_clientes)
							   
select 
ta_codigo_cliente            = en_ente,
ta_folio_buro_credito        = convert(varchar(64),'0'),
ta_folio_circulo_credito     = ltrim(rtrim(convert(varchar(1),null))),-- convert(char(1),ASCII ( 255)),--LTRIM(convert(char(1), '')), --fijo
ta_personalidad_juridica     = 1, --Persona Fisica
ta_nombre_cliente            = ltrim(rtrim(replace(isnull(en_nombre, '') + ' ' +isnull(p_s_nombre,''),'.',''))),
ta_apellidos_cliente         = ltrim(rtrim(replace(isnull(p_p_apellido, '') + ' ' +isnull(p_s_apellido,''),'.',''))),
ta_nacionalidad              = case when en_nacionalidad = 484 then 1 else en_nac_aux end,
ta_fecha_nacimiento          = convert(varchar(12),FORMAT (p_fecha_nac, 'yyyy/MM/dd')),  --
ta_sector_economico          = 32, --fijo
ta_rfc_cliente               = en_rfc,--Campo 10
ta_curp_cliente              = en_ced_ruc,
ta_genero                    = case --5
                                  when p_sexo = 'M' THEN 1
                                  when p_sexo = 'F' THEN 2                 
                               end,
ta_estado_civil              = case --5   
                                  when p_estado_civil = 'SO' THEN 1                              
								  else 2                                
                               end,
ta_sector_laboral            = 5, --fijo
ta_ingreso_mensual           = en_otros_ingresos, --(select sum(nc_ingreso_mensual) from cobis..cl_negocio_cliente where nc_ente = en_ente),
ta_codigo_postal             = isnull(convert(varchar(20),' '), ''),
ta_codigo_pais               = isnull(convert(int,0),0),
ta_codigo_estado             = isnull(convert(varchar(20),' '), ''),
ta_codigo_municipio          = isnull(convert(int,0),0),
ta_localidad                 = convert(varchar(14),'0'),--Campo 20
ta_actividad_economica       = isnull(convert(varchar(12),' '), ''),
ta_numero_empleados          = convert(numeric(5),0) --fijo
into ##tmp_altas
from cobis..cl_ente
where en_ente in (select cliente from #tmp_clientes)

--Folio Buro Cliente
update ##tmp_altas
set ta_folio_buro_credito = ib_folio 
from cob_credito..cr_interface_buro
where ib_cliente = ta_codigo_cliente
and   ib_estado  = 'V'
and   ib_folio is not null
 
 
update ##tmp_altas set 
ta_codigo_postal    = right('00000' + convert(varchar,di_codpostal),5),
ta_codigo_pais      = di_pais,
ta_codigo_municipio = di_ciudad,
--JEOM 02/02/2022 INI
--ta_localidad        = convert(varchar,di_pais)+convert(varchar,di_provincia)+cob_cartera.dbo.LlenarI(convert(varchar,di_ciudad),'0',4)+'0001'
ta_localidad        = convert(varchar,di_pais)+CASE WHEN convert(int,di_provincia) < 10 THEN  '0' + convert(varchar,di_provincia) 
ELSE convert(varchar,di_provincia) END +cob_cartera.dbo.LlenarI(convert(varchar,di_ciudad),'0',4)+'0001',
ta_codigo_estado = CASE WHEN convert(int,di_provincia) < 10 THEN  '0' + convert(varchar,di_provincia) ELSE convert(varchar,di_provincia) END 
--JEOM 02/02/2022 FIN
from cobis..cl_direccion 
where di_ente = ta_codigo_cliente
and   di_tipo = 'RE'

update ##tmp_altas set 
ta_codigo_postal    = right('00000' + convert(varchar,di_codpostal),5),
ta_codigo_pais      = di_pais,
ta_codigo_municipio = di_ciudad,
--JEOM 02/02/2022 INI
--ta_localidad        = convert(varchar,di_pais)+convert(varchar,di_provincia)+cob_cartera.dbo.LlenarI(convert(varchar,di_ciudad),'0',4)+'0001'
ta_localidad        = convert(varchar,di_pais)+CASE WHEN convert(int,di_provincia) < 10 THEN  '0' + convert(varchar,di_provincia) 
ELSE convert(varchar,di_provincia) END +cob_cartera.dbo.LlenarI(convert(varchar,di_ciudad),'0',4)+'0001',
ta_codigo_estado = CASE WHEN convert(int,di_provincia) < 10 THEN  '0' + convert(varchar,di_provincia) ELSE convert(varchar,di_provincia) END 
--JEOM 02/02/2022 FIN
from  cobis..cl_direccion
where di_ente = ta_codigo_cliente
and   di_tipo = 'AE'
and   ltrim(ta_codigo_postal) = ''

--update ##tmp_altas set 
--ta_codigo_estado = CASE WHEN convert(int,di_provincia) < 10 THEN  '0' + convert(varchar,di_provincia) ELSE convert(varchar,di_provincia) END 
--from cobis..cl_direccion
--where di_ente = ta_codigo_cliente

update ##tmp_altas set 
ta_actividad_economica = convert(varchar(12),nc_actividad_ec)
from cobis..cl_negocio_cliente
where nc_ente = ta_codigo_cliente

SELECT
tmp_codigo_cliente = ta_codigo_cliente,
tmp_actividad_economica = ta_actividad_economica,
tmp_actividad_nueva = altas_banxico
into #tmp_act_eco
from cobis..cl_negocio_cliente_homologacion, ##tmp_altas
WHERE ta_actividad_economica = cobis..cl_negocio_cliente_homologacion.cobis

--JEOM 02/02/2022 INI
update ##tmp_altas set 
ta_actividad_economica = tmp_actividad_nueva
from #tmp_act_eco
WHERE ta_codigo_cliente = tmp_codigo_cliente
--JEOM 02/02/2022 FIN

if object_id ('sb_banxico_altas') is not null drop table sb_banxico_altas
select *into sb_banxico_altas from ##tmp_altas

select @w_reporte_altas = 'Banxico_Altas_'
select @w_sql = 'select * from ##tmp_altas'

select	@w_sql_bcp = 'bcp "' + @w_sql + '" queryout "' + @w_ruta_arch + @w_reporte_altas + @w_nombre_arch +'".txt"'+'" -C -c -t; -T'

delete from @resultadobcp
insert into @resultadobcp
EXEC xp_cmdshell @w_sql_bcp
select * from @resultadobcp



--------------------------------------------------------------------------------------------
-------------------------             REPORTE BAJAS          ----------------------------
--------------------------------------------------------------------------------------------
select @w_fecha_fin_ant = dateadd(dd, datepart(dd, @w_fecha_fin) * -1, @w_fecha_fin)
while exists (select 1 from cobis..cl_dias_feriados where df_fecha = @w_fecha_fin_ant and df_ciudad = @w_ciudad) select @w_fecha_fin_ant = dateadd(dd, -1, @w_fecha_fin_ant) 

select @w_fecha_bimestre_ini = right('00' + convert(varchar,datepart(mm,dateadd(mm,-1,@w_fecha_fin))),2) + '/01/' + right('0000' + convert(varchar,datepart(yyyy,dateadd(mm,-1,@w_fecha_fin))),4)

select 
tb_banco                          = do_banco,
tb_tipo_credito                   = convert(numeric(2),40),
tb_fecha_baja                     = isnull(convert(varchar(12),FORMAT (do_fecha_proceso, 'yyyy/MM/dd')), ''),
tb_tipo_baja                      = convert(numeric(2), 60),
--JEOM 30/12/2021 INI
tb_mont_reco_quita                = convert(numeric(10,2), 0),
tb_mont_reco_quita_acum           = convert(numeric(10,2), 0)
--JEOM 30/12/2021 FIN				 
into ##tmp_bajas
from cob_conta_super..sb_dato_operacion
where do_fecha = @w_fecha_fin
and do_fecha_proceso between @w_fecha_bimestre_ini and @w_fecha_fin
and do_estado_cartera = @w_est_cancelado
and exists (select 1
                   from cob_conta_super..sb_dato_transaccion
                   where dt_banco = do_banco
                   and   dt_tipo_trans = 'DES')
and do_tipo_operacion != 'REVOLVENTE'

insert into ##tmp_bajas
select 
tb_banco                          = do_banco,
tb_tipo_credito                   = convert(numeric(2),40),
tb_fecha_baja                     = isnull(convert(varchar(12),FORMAT (do_fecha_proceso, 'yyyy/MM/dd')), ''),
tb_tipo_baja                      = convert(numeric(2), 60),
--JEOM 30/12/2021 INI
tb_mont_reco_quita                = convert(numeric(10,2), 0),
tb_mont_reco_quita_acum           = convert(numeric(10,2), 0)
--JEOM 30/12/2021 FIN
from cob_conta_super..sb_dato_operacion
where do_fecha = @w_fecha_fin
and do_fecha_proceso between @w_fecha_bimestre_ini and @w_fecha_fin
and do_estado_cartera = @w_est_cancelado
and exists (select 1
                   from cob_conta_super..sb_dato_transaccion
                   where dt_banco = do_banco
                   and   dt_tipo_trans = 'DES')
and do_tipo_operacion = 'REVOLVENTE'
and do_fecha_vencimiento between @w_fecha_bimestre_ini and @w_fecha_fin

--

insert into ##tmp_bajas
select 
tb_banco                          = do_banco,
tb_tipo_credito                   = convert(numeric(2),40),
tb_fecha_baja                     = isnull(convert(varchar(12),FORMAT (do_fecha_castigo, 'yyyy/MM/dd')), ''),
tb_tipo_baja                      = convert(numeric(2), 10),
--JEOM 30/12/2021 INI
tb_mont_reco_quita                = convert(numeric(10,2), 0),
tb_mont_reco_quita_acum           = convert(numeric(10,2), 0)
--JEOM 30/12/2021 FIN				 
from cob_conta_super..sb_dato_operacion
where do_fecha = @w_fecha_fin
and do_fecha_castigo between @w_fecha_bimestre_ini and @w_fecha_fin
and do_estado_cartera = @w_est_castigado

insert into ##tmp_bajas
select 
tb_banco                          = do_banco,
tb_tipo_credito                   = convert(numeric(2),40),
tb_fecha_baja                     = isnull(convert(varchar(12),FORMAT (do_fecha_castigo, 'yyyy/MM/dd')), ''),
tb_tipo_baja                      = convert(numeric(2), 10),
--JEOM 30/12/2021 INI
tb_mont_reco_quita                = convert(numeric(10,2), 0),
tb_mont_reco_quita_acum           = convert(numeric(10,2), 0)
--JEOM 30/12/2021 FIN		 
from cob_conta_super..sb_dato_operacion
where do_fecha = @w_fecha_fin
and do_fecha_castigo between @w_fecha_bimestre_ini and @w_fecha_fin
and do_estado_cartera = @w_est_castigado
and do_banco not in (select tb_banco from ##tmp_bajas)

--

if object_id ('sb_banxico_bajas') is not null drop table sb_banxico_bajas
select *into sb_banxico_bajas from ##tmp_bajas

select @w_reporte_bajas = 'Banxico_Bajas_'

--JEOM INI

CREATE TABLE ##conodado_ban(
  lv_do_banco        VARCHAR(24),
  ln_mont_reco_quita numeric(10,2)
)

CREATE TABLE ##conodado_ban_acum(
  lv_do_banco_ac        VARCHAR(24),
  ln_mont_reco_quita_ac numeric(10,2)
)

--Se actualiza los que tienen pagos condonados
UPDATE ##tmp_bajas 
   set tb_tipo_baja = 15 
FROM cob_conta_super..sb_dato_operacion_abono 
WHERE doa_fecha = @w_fecha_fin 
AND   doa_banco  = tb_banco 
AND doa_condonaciones = 'S'


--crear tabla temporal para hacer agrupaciones cruzo con el tb_banco filtrar informacion con el where
--anterior

--Se procede a actualizar los campos de los montos

TRUNCATE TABLE ##conodado_ban
TRUNCATE TABLE ##conodado_ban_acum

--Mismpo periodo
--Comentado porque no se acumulará
/*INSERT INTO ##conodado_ban(
  lv_do_banco,
  ln_mont_reco_quita )
SELECT doa_banco,
	   sum(doa_total)        
FROM cob_conta_super..sb_dato_operacion_abono 
WHERE doa_fecha_pag = @w_fecha_fin
AND doa_condonaciones = 'S' 
GROUP BY doa_banco, doa_operacion*/

SELECT doa_banco, doa_sec_pag, doa_total
INTO #tmp_condonados
FROM cob_conta_super..sb_dato_operacion_abono
WHERE doa_fecha = @w_fecha_fin
AND doa_fecha_pag between @w_fecha_inicio and @w_fecha_fin
AND doa_condonaciones = 'S'
group by doa_banco,doa_sec_pag, doa_total

--Periodo actual y periodo anterior


INSERT INTO ##conodado_ban_acum(
  lv_do_banco_ac,
  ln_mont_reco_quita_ac )
SELECT doa_banco,
	   sum(doa_total) 
FROM #tmp_condonados
GROUP BY doa_banco

--Para el mismo periodo
UPDATE ##tmp_bajas
SET tb_mont_reco_quita = ln_mont_reco_quita_ac
FROM ##conodado_ban_acum
WHERE tb_banco = lv_do_banco_ac

--Para los dos periodos actual y anterior
UPDATE ##tmp_bajas
SET tb_mont_reco_quita_acum = ln_mont_reco_quita_ac
FROM ##conodado_ban_acum
WHERE tb_banco = lv_do_banco_ac
and tb_tipo_baja = 15


DROP TABLE ##conodado_ban
DROP TABLE ##conodado_ban_acum
--JEOM FIN
select @w_sql = 'select * from ##tmp_bajas'

select	@w_sql_bcp = 'bcp "' + @w_sql + '" queryout "' + @w_ruta_arch + @w_reporte_bajas + @w_nombre_arch +'".txt"'  + '" -C -c -t";" -T'

delete from @resultadobcp
insert into @resultadobcp
EXEC xp_cmdshell @w_sql_bcp
select * from @resultadobcp

--------------------------------------------------------------------------------------------
-------------------------             REPORTE RESERVAS          ----------------------------
--------------------------------------------------------------------------------------------

select 
tr_banco                          = do_banco,
tr_tipo_gar                       = convert(numeric(1),0),--fijo
tr_tipo_gar_real                  = convert(numeric(2),0),--fijo
tr_importe_gar                    = convert(numeric(11,2), 0),--fijo
tr_prob_incumplimiento            = convert(numeric(5,2), 0),
tr_prob_incump_garante_acred      = convert(numeric(5,2), 0), --fijo
tr_severidad_perdida_acred        = convert(numeric(5,2),0), 
tr_severidad_perdida_garante      = convert(numeric(2),0),--fijo
tr_severidad_perdida_ajustada     = convert(numeric(5,2),0),--fijo
tr_factor_ajuste_garantia         = convert(numeric(4,2),0),--fijo --10
tr_factor_ajuste_moneda           = convert(numeric(3,2),0),--fijo
tr_porcentaje_cobpp               = convert(numeric(4,2),0),--fijo
tr_exposicion_incumpliemto        = convert(money,0),
tr_exposicion_incumpliemto_ajus   = convert(numeric(11,2),0),--fijo
tr_monto_reservas                 = convert(numeric(5,2),0),
tr_total_reservas                 = convert(numeric(10,2),0),--fijo
tr_reg_unico_gar_inmobiliarias    = isnull(convert(varchar(12),' '),''),--fijo
tr_clave_garante                  = isnull(convert(varchar(12),' '),''),--fijo
tr_id_portfolio                   = convert(numeric(3),0)--fijo 
into ##tmp_reservas
from cob_conta_super..sb_dato_operacion
where do_fecha = @w_fecha_fin


--MTA Inicio
select
dr_banco,
--CAPITALES
dr_cap_vig_ex    = sum(case when dr_categoria  = 'C'  and dr_estado =   @w_est_vigente  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
dr_cap_vig_ne    = sum(case when dr_categoria  = 'C'  and dr_estado =   @w_est_vigente  and dr_exigible   = 0 then  isnull(dr_valor,0) else 0 end ), 
dr_cap_ven_ex    = sum(case when dr_categoria  = 'C'  and dr_estado in (@w_est_vencido,@w_est_castigado)  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
dr_cap_ven_ne    = sum(case when dr_categoria  = 'C'  and dr_estado in (@w_est_vencido,@w_est_castigado)  and dr_exigible   = 0 then  isnull(dr_valor,0) else 0 end ), 
--INTERESES
dr_int_vig_ex    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vigente  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
dr_int_vig_ne    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vigente  and dr_exigible   = 0 then  isnull(dr_valor,0) else 0 end), 
dr_int_ven_ex    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vencido  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
dr_int_ven_ne    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vencido  and dr_exigible   = 0 then  isnull(dr_valor,0) else 0 end),
--IVAS
dr_iva_int_ex    = sum(case when dr_categoria  = 'A' and dr_cat_rub_aso  = 'I' and dr_exigible    = 1 then  isnull(dr_valor,0) else 0 end),
dr_saldo_iva_com = sum(case when dr_categoria  = 'A' and  dr_cat_rub_aso  = 'O' then isnull(dr_valor,0) else 0 end),
--INTERES SUSPENDIDO
dr_int_sus_ex    = sum(case when dr_categoria  = 'I' and dr_estado in (@w_est_suspenso,@w_est_castigado) and dr_exigible   = 1   then  isnull(dr_valor,0) else 0 end ),
dr_int_sus_ne    = sum(case when dr_categoria  = 'I' and dr_estado in (@w_est_suspenso,@w_est_castigado) and dr_exigible   = 0   then  isnull(dr_valor,0) else 0 end ),

dr_com_ex        = sum(case when dr_categoria  = 'O' and dr_exigible    = 1   then isnull(dr_valor,0) else 0 end),
dr_com_ne        = sum(case when dr_categoria  = 'O' and dr_exigible    = 0   then isnull(dr_valor,0) else 0 end)

into #rubros_res_tmp
from ##tmp_reservas, cob_conta_super..sb_dato_operacion_rubro
where dr_fecha      = @w_fecha_fin
and   dr_banco      = tr_banco
group by dr_banco


UPDATE ##tmp_reservas
SET tr_exposicion_incumpliemto = dr_cap_vig_ex + dr_cap_ven_ex + dr_cap_ven_ne + dr_cap_vig_ne + dr_int_vig_ex + dr_int_vig_ne  + dr_int_ven_ex + dr_int_ven_ne
FROM #rubros_res_tmp 
WHERE tr_banco = dr_banco


if object_id ('sb_banxico_reservas') is not null drop table sb_banxico_reservas
select *into sb_banxico_reservas from ##tmp_reservas

select @w_reporte_reservas  = 'Banxico_Reservas_'
select @w_sql = 'select *from ##tmp_reservas'

select	@w_sql_bcp = 'bcp "' + @w_sql + '" queryout "' + @w_ruta_arch + + @w_reporte_reservas + @w_nombre_arch +'".txt"'  + '" -C -c -t";" -T'

delete from @resultadobcp
insert into @resultadobcp
EXEC xp_cmdshell @w_sql_bcp
select * from @resultadobcp

if object_id('tempdb..##tmp_seguimiento') is not null drop table ##tmp_seguimiento

if object_id('tempdb..##tmp_altas') is not null drop table ##tmp_altas 

if object_id('tempdb..##tmp_bajas') is not null drop table ##tmp_bajas 

if object_id('tempdb..##tmp_reservas') is not null  drop table ##tmp_reservas 

---------------------------------------------------------------------------------------------
-------------------------       REPORTE CREDITO REVOLVENTE       ----------------------------
---------------------------------------------------------------------------------------------

print 'inicia ejeucion del reporte seguimiento'
----------------------------
--fecha a fin de bimestre pasado habil
----------------------------	
select @w_fecha_fin_bmp = dateadd(mm,-2, @w_fecha_fin)	

select @w_fecha_aux_bmp = @w_fecha_fin_bmp
--calcular si  es dia habil
while exists (select 1 from cobis..cl_dias_feriados where df_fecha = @w_fecha_aux_bmp and df_ciudad = @w_ciudad)
      begin
          select @w_fecha_aux_bmp = dateadd(dd,-1, @w_fecha_aux_bmp)
       end	

exec @w_return = cob_conta_super..sp_seguimiento_lcr
@i_ruta_arch 		  = @w_ruta_arch,
@i_fecha_inicio       = @w_fecha_inicio, 
@i_fecha_fin          = @w_fecha_fin,
@i_fecha_corte		  = @w_fecha_corte,
@i_fecha_fin_bmp	  = @w_fecha_aux_bmp


if @w_return != 0
begin
   select @w_error = @w_return
   goto ERROR_PROCESO
end

------------------------------------------------------------------------
------------------------- GENERACION ARCHIVO----------------------------
------------------------------------------------------------------------
select @w_reporte_lcr = 'CR_SEGUIMIENTO_'

select @w_sql = 'select * from cob_conta_super..sb_banxico_lcr'

select @w_sql_bcp = 'bcp "' + @w_sql + '" queryout "' + @w_ruta_arch + @w_reporte_lcr + replace(convert(varchar,@w_fecha_corte, 104), '.', '') +'".txt"'  + '" -C -c -t";" -T'

delete from @resultadobcp
insert into @resultadobcp
EXEC xp_cmdshell @w_sql_bcp
select * from @resultadobcp

---------------------------------------------------------------------------------------------
-------------------------   FIN   REPORTE CREDITO REVOLVENTE     ----------------------------
---------------------------------------------------------------------------------------------


return 0

ERROR_PROCESO:

select @w_msg = mensaje
from cobis..cl_errores with (nolock)
where numero = @w_error

select @w_msg = isnull(@w_msg, @w_mensaje)
	
exec @w_return = cob_conta_super..sp_errorlog 
@i_operacion	= 'I',
@i_fecha_fin	= @w_fecha_proceso,
@i_origen_error = @w_error, 
@i_fuente		= @w_sp_name,
@i_descrp_error = @w_msg
	
return @w_error
GO
