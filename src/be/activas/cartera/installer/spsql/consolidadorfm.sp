/************************************************************************/
/*   Archivo:             consolidadorfm.sp                             */
/*   Stored procedure:    sp_consolidador_fin_mes                       */
/*   Base de datos:       cob_cartera                                   */
/*   Producto:            Cartera                                       */
/*   Disenado por:        JSA                                           */
/*   Fecha de escritura:  Ago.20                                        */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBISCORP'.                                                       */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBISCORP o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*   Extraccion de datos para el consolidador cuando es fin de mes      */
/************************************************************************/
/*                               MODIFICACIONES                         */
/*  FECHA         AUTOR                   CAMBIO                        */
/*  Ago/2020     JSA     Caso: 144928 Optimizacion Batch                */
/*  May/2021     ACH     Caso: 156405 Optimizacion para reportes        */
/*  Jul/2021     DCU     Caso: 123672 Timbrado                          */
/*	Dec/2021     JEOM    Caso: 172727							        */
/*  12/08/2022   DCU     REQ #174670 EDO DE CTA SIMPLE                  */
/*  15/06/2023   KVI     Req.205892 Rpt Riesgo Ind nva evaluacion       */
/************************************************************************/ 

USE cob_cartera
GO
 
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

if exists (select 1 from sysobjects where name = 'sp_consolidador_fin_mes')
   drop proc sp_consolidador_fin_mes
go

create proc sp_consolidador_fin_mes
as declare
   @w_error                 int,
   @w_sp_name               varchar(64),
   @w_fecha_proceso         smalldatetime,
   @w_fecha_ini             smalldatetime,   
   @w_msg                   varchar(64),
   @w_est_vigente           tinyint,
   @w_est_novigente         tinyint,
   @w_est_vencido           tinyint,
   @w_est_cancelado         tinyint,
   @w_est_suspenso          tinyint,
   @w_est_castigado         tinyint,
   @w_est_diferido          tinyint,
   @w_ciudad                int,
   @w_sig_habil             datetime,
   @w_fin_mes               char(1),
   @w_return                int,
   @w_fant_consol           DATETIME,
   @w_fp_objetado           VARCHAR(32),
   @w_est_anulado           int,
   @w_est_condonado         int,
   @w_est_credito           INT
set ansi_warnings off

/* CARGADO DE VARIABLES DE TRABAJO */
select 
@w_sp_name = 'sp_consolidador_fin_mes',
@w_fin_mes = 'N'

/*DETERMINAR LA FECHA DE PROCESO */
select 
@w_fecha_proceso = fc_fecha_cierre,
@w_fecha_ini     = dateadd(dd,1-datepart(dd,fc_fecha_cierre), fc_fecha_cierre)
from cobis..ba_fecha_cierre
where fc_producto = 7

/* CIUDAD DE FERIADOS */
select @w_ciudad = pa_int
from cobis..cl_parametro
where pa_nemonico = 'CIUN'
and   pa_producto = 'ADM'

/* DETERMINAR SI HOY ES EL ULTIMO HABIL DEL MES */
select @w_sig_habil = dateadd(dd, 1, @w_fecha_proceso)

while exists (select 1
                  from cobis..cl_dias_feriados
                  where df_fecha = @w_sig_habil
                  and   df_ciudad = @w_ciudad)
begin
   select @w_sig_habil = dateadd(dd, 1, @w_sig_habil)
end

if datepart(mm, @w_sig_habil) <> datepart(mm, @w_fecha_proceso)
   select @w_fin_mes = 'S'

/* ENTRAR BORRANDO TODA LA INFORMACION GENERADA POR CARTERA EN COB_EXTERNOS */

--optimizacion, dado que actualmente solo existe Cartera
truncate table cob_externos..ex_dato_operacion_abono
truncate table cob_externos..ex_dato_cuota_pry
--truncate table cob_externos..ex_operacion -- Comentado por Req.205892

/* ESTADOS DE CARTERA */
exec @w_error = sp_estados_cca
@o_est_vigente    = @w_est_vigente   out,
@o_est_novigente  = @w_est_novigente out,
@o_est_vencido    = @w_est_vencido   out,
@o_est_cancelado  = @w_est_cancelado out,
@o_est_castigado  = @w_est_castigado out,
@o_est_suspenso   = @w_est_suspenso  out,
@o_est_diferido   = @w_est_diferido  out,
@o_est_anulado    = @w_est_anulado   out,
@o_est_condonado  = @w_est_condonado out,
@o_est_credito    = @w_est_credito   out

if @w_error <> 0 goto ERROR

if @w_fin_mes = 'S' 
or exists (select 1 from cob_conta_super..sb_calendario_proyec
           where  cp_fecha_proc = @w_fecha_proceso)
BEGIN
   /* CARGA DE OPERACIONES ACTIVAS */
   SELECT
   cop_fecha             = @w_fecha_proceso,
   cop_operacion         = op_operacion,
   cop_tipo_amortizacion = op_tipo_amortizacion,
   cop_estado            = op_estado,
   cop_banco             = op_banco,
   cop_toperacion        = convert(varchar(10),op_toperacion),
   cop_fecha_liq         = op_fecha_liq,
   cop_moneda            = op_moneda,
   cop_monto             = op_monto,
   cop_oficina           = convert(int,op_oficina),
   cop_cliente           = op_cliente,
   cop_tramite           = op_tramite,
   cop_oficial           = op_oficial,
   cop_fecha_ini         = op_fecha_ini,
   cop_fecha_fin         = op_fecha_fin
   into #operaciones
   from ca_operacion , ca_estado WITH (nolock)
   where op_estado   = es_codigo
   and (es_procesa  = 'S' 
      --> OPERACIONES CANCELADAS DURANTE EL MES DE PROCESO
      or (op_estado=@w_est_cancelado and op_fecha_ult_proceso between @w_fecha_ini and @w_fecha_proceso)     
      --> OPERACIONES CANCELADAS DURANTE EL MES DE PROCESO CON FECHA VALOR A MESES ANTERIORES)
      or (op_estado=@w_est_cancelado and op_fecha_ult_proceso < @w_fecha_ini and op_fecha_ult_mov between @w_fecha_ini and @w_fecha_proceso)
      -- OPERACIONES REVOLVENTES QUE AUN NO TERMINAN O TERMINARON EN EL MES DE PROCESO
      or (op_tipo_amortizacion = 'ROTATIVA' and op_fecha_fin >= @w_fecha_ini) 
     )
   ORDER BY op_operacion
   
   create CLUSTERED index idx1 on #operaciones(cop_operacion)
   create index idx2 on #operaciones(cop_banco)

   --Eliminacion 
   delete #operaciones
   where cop_tipo_amortizacion = 'ROTATIVA'
   and   cop_estado in (@w_est_anulado, @w_est_condonado, @w_est_credito)
   
   /* NO REPORTA OPERACIONES QUE FUERON CANCELADAS EN MESES ANTERIORES Y QUE VOLVIERON A SER CANCELADAS EN EL MES DE PROCESO POR FECHA VALOR */
   select op_banco,  op_fecha_ult_mov, op_fecha_ult_proceso 
   into #canceladas
   from #operaciones, cob_cartera..ca_operacion WITH (nolock)
   where cop_estado = @w_est_cancelado
   and   cop_operacion = op_operacion
   and   op_fecha_ult_proceso < @w_fecha_ini and op_fecha_ult_mov between @w_fecha_ini and @w_fecha_proceso
   and   cop_tipo_amortizacion <> 'ROTATIVA'
   
   --AZU
   create index idx1 on #canceladas  (op_banco, op_fecha_ult_proceso)
   
   delete #operaciones
   from cob_conta_super..sb_dato_operacion, #canceladas
   where do_banco = op_banco
   and   do_fecha = op_fecha_ult_proceso 
   and   do_aplicativo = 7
   and   cop_banco = op_banco
   and   do_estado_cartera = @w_est_cancelado
   
   /* ELIINAR LAS GRUPALES PADRES */
   select DISTINCT tg_referencia_grupal
   into #grupales_padre
   from #operaciones, cob_credito..cr_tramite_grupal, cob_cartera..ca_operacion WITH (nolock)
   where cop_operacion = op_operacion
   and   cop_estado = @w_est_cancelado
   and   op_fecha_ult_proceso <= @w_fecha_proceso 
   AND   op_banco  = tg_referencia_grupal
   
   delete #operaciones
   from #grupales_padre
   where cop_banco = tg_referencia_grupal

   SELECT @w_fp_objetado  = pa_char
    FROM cobis..cl_parametro
    WHERE pa_producto = 'CCA'
    AND pa_nemonico = 'AB_OBJ'

	--//////////////////////////////////////////////////////
	CREATE TABLE #abonos (
	doa_aplicativo   SMALLINT,
	doa_fecha        DATETIME,
	doa_banco        VARCHAR(32),
	doa_operacion    INT,
	doa_sec_pag      INT,
	doa_fecha_pag    DATETIME,
	doa_di_fecha_ven DATETIME,
	doa_dividendo    SMALLINT,
	doa_dias_atraso  INT,
	doa_fpago        VARCHAR(32),
	doa_total        MONEY,
	doa_capital      MONEY,
	doa_int          MONEY,
	doa_otro         MONEY,
	doa_saldo_cap    MONEY,
	doa_sec_ing      INT,
	doa_oficina      SMALLINT,
	doa_estado       VARCHAR(10),
	doa_usuario      VARCHAR(20),
	doa_moneda       SMALLINT,
	doa_iva_int      MONEY,
	doa_imo          MONEY,
	doa_iva_imo      MONEY,
	doa_disp         MONEY,
	doa_iva_disp     MONEY,
	doa_objetado     VARCHAR(10),
	doa_sec_rpa      INT,
	doa_tipo_trn     VARCHAR(10)
	)

	--JEOM 17/12/2021 INI
	CREATE TABLE #condonados (
	cop_operacion 	INT,  
	ab_secuencial_ing INT 	
	)

	--JEOM 17/12/2021 FIN
	
	INSERT INTO #abonos (
		doa_aplicativo,
		doa_fecha        ,doa_banco        ,doa_operacion    ,
		doa_sec_pag      ,doa_fecha_pag    ,doa_di_fecha_ven ,
		doa_dias_atraso  ,doa_fpago        ,doa_total        ,
		doa_capital      ,doa_int          ,doa_otro         ,
		doa_saldo_cap    ,doa_sec_ing      ,doa_oficina      ,
		doa_estado       ,doa_usuario      ,doa_moneda       ,
		doa_iva_int      ,doa_imo          ,doa_iva_imo      ,
		doa_disp         ,doa_iva_disp     ,doa_objetado     ,
		doa_sec_rpa      ,doa_tipo_trn
		)
	select 
		7,
		cop_fecha        ,cop_banco        ,ab_operacion     ,
		ab_secuencial_pag,ab_fecha_pag     ,NULL             ,
		0                ,abd_concepto     ,abd_monto_mpg    , 
		0                ,0                ,0                ,
		0                ,ab_secuencial_ing,ab_oficina       ,
		ab_estado        ,ab_usuario       ,abd_moneda       ,
		0                ,0                ,0                ,
		0                ,0                ,'N'              ,
		ab_secuencial_rpa,'PAG'
	from ca_abono, ca_abono_det,  #operaciones WITH (nolock)
	where ab_operacion = cop_operacion
	and ab_operacion = abd_operacion
	and ab_secuencial_ing = abd_secuencial_ing
	AND abd_concepto <> 'SOBRANTE'
	AND ab_estado = 'A'
	AND cop_toperacion in ('GRUPAL', 'INDIVIDUAL') ---*****
	
	--CREATE CLUSTERED INDEX idx_1 ON #abonos (doa_operacion,doa_sec_pag, doa_fecha_pag)
	--AZU
	CREATE INDEX idx_1 ON #abonos (doa_operacion,doa_sec_pag, doa_fecha_pag)
	CREATE INDEX idx_2 ON #abonos (doa_fpago)

	
	--////////////////////////////////
	-- marcar los pagos objetados
	--////////////////////////////////
	UPDATE #abonos SET doa_objetado = 'S'
	WHERE doa_fpago = @w_fp_objetado 

	--JEOM INI 15/12/2021 INI crear una tabla temporal
	CREATE INDEX indx_1 ON #condonados (cop_operacion, ab_secuencial_ing)

	INSERT INTO #condonados (
					cop_operacion, 
					ab_secuencial_ing
				) 
	SELECT cop_operacion,  
		   ab_secuencial_ing
	FROM cob_cartera..ca_abono,
		 cob_cartera..ca_abono_det, 
		 #operaciones WITH (nolock)
	WHERE ab_operacion = cop_operacion
	AND   ab_operacion = abd_operacion
	AND   ab_secuencial_ing = abd_secuencial_ing
	AND   abd_tipo = 'CON'
	AND   ab_estado not in ( 'RV', 'E')
	group by cop_operacion, ab_secuencial_ing

	--JEOM INI 15/12/2021 FIN
	
	-- SOLO GRUPALES XQ ESTA IMPLEMENTADO SUMARIZADO
	SELECT 
	tr_operacion, tr_secuencial, dtr_dividendo, 
	'capital'  = (CASE dtr_concepto         WHEN 'CAP'        THEN sum(dtr_monto_mn) ELSE 0 end),
	'interes' = (CASE WHEN dtr_concepto     IN ('INT', 'IVA_INT', 'INT_ESPERA', 'IVA_ESPERA')    THEN sum(dtr_monto_mn) ELSE 0 end),
	'imo'     = convert(MONEY,0),
	'iva_int' = convert(MONEY,0),
	'iva_imo' = convert(MONEY,0),
	'otro'    = (CASE WHEN dtr_concepto NOT IN ('CAP', 'INT', 'IVA_INT', 'INT_ESPERA', 'IVA_ESPERA')    THEN sum(dtr_monto_mn) ELSE 0 end)
	INTO #monto_pago
	FROM cob_cartera..ca_transaccion, cob_cartera..ca_det_trn, #abonos  WITH (nolock)
	WHERE doa_operacion = tr_operacion
	AND doa_sec_pag   = tr_secuencial
	AND tr_operacion  = dtr_operacion
	AND tr_secuencial = dtr_secuencial
	AND tr_tran       = 'PAG'
	AND dtr_concepto <> 'VAC0'
	GROUP BY tr_operacion, tr_secuencial, dtr_dividendo, dtr_concepto
	
	CREATE INDEX idx1 ON #monto_pago (tr_operacion, tr_secuencial, dtr_dividendo)
    
	SELECT 
		tr_operacion, 
		tr_secuencial, 
		dtr_dividendo, 
		'capital' = sum(capital), 
		'interes' = sum(interes), 
		'imo'     = sum(imo),
		'iva_int' = sum(iva_int),
		'iva_imo' = sum(iva_imo),
		'otro'    = sum(otro)
	INTO #monto_def
	FROM  #monto_pago
	GROUP BY tr_operacion, tr_secuencial, dtr_dividendo
	
	--AZU 
	create index idx1 on #monto_def (tr_operacion, tr_secuencial, dtr_dividendo)

	--AZU
    select * into #operaciones_grupales_ind from #operaciones
	WHERE  cop_operacion >= 0
	and cop_toperacion in ('GRUPAL', 'INDIVIDUAL')

	-- LOS DESEMBOLSOS DE LAS GRUPALES (SOLO HAY 1)
	--/////////////////////////////////////////////////
	INSERT INTO cob_externos..ex_dato_operacion_abono
	SELECT 
		7,
		cop_fecha        ,cop_banco        ,cop_operacion    ,
		0                ,cop_fecha_liq    ,cop_fecha_liq, 
		0                ,0                ,'Saldo Inicial'  ,
		cop_monto        ,cop_monto        ,00000            ,
		0                ,cop_monto        ,0                ,
		cop_oficina      ,'A'              ,'na'             ,
		cop_moneda       ,0                ,0                ,
		0                ,0                ,0                ,
		''               ,0                ,'DES', 'N'--JEOM
	FROM #operaciones_grupales_ind

   -- LOS INTERESES AL FINAL DE LA OPERACION
   --SRO. Desplazamiento
   select 
   	operacion = cop_operacion,   'interes'= sum(am_cuota ) INTO #cuota_int
   from ca_dividendo d, ca_amortizacion a, #operaciones o  WITH (nolock)
   where cop_operacion = di_operacion
   and   di_operacion  = am_operacion
   and   am_operacion  = cop_operacion
   and   am_dividendo  = di_dividendo
   and   am_concepto   IN ( 'INT', 'IVA_INT', 'INT_ESPERA', 'IVA_ESPERA')
   and   cop_toperacion in ('GRUPAL', 'INDIVIDUAL')
   group by cop_operacion
	
	--AZU
	create index idx1 on #cuota_int (operacion)

	UPDATE cob_externos..ex_dato_operacion_abono SET 
		doa_total = doa_total + interes,
		doa_int   = interes
	FROM #cuota_int
	WHERE operacion = doa_operacion
	AND doa_aplicativo = 7
	AND doa_sec_pag    = 0
	--//////////////////////

	
	INSERT INTO cob_externos..ex_dato_operacion_abono
	SELECT 
		doa_aplicativo,
		doa_fecha        ,doa_banco        ,doa_operacion    ,
		doa_sec_pag      ,doa_fecha_pag    ,di_fecha_ven     , 
		dtr_dividendo,
		CASE WHEN datediff(dd, di_fecha_ven,doa_fecha_pag ) > 0 THEN datediff(dd, di_fecha_ven,doa_fecha_pag ) ELSE 0 END  , ----------------------XXXXXXXXXXXXXXXXXXXXXXXXXS
		doa_fpago        ,
		doa_total        ,capital          ,interes          ,
		otro             ,doa_saldo_cap    ,doa_sec_ing      ,
		doa_oficina      ,doa_estado       ,doa_usuario      ,
		doa_moneda       ,iva_int          ,imo              ,
		iva_imo          ,0                ,0                ,
		doa_objetado     ,doa_sec_rpa      ,doa_tipo_trn, 'N'--poner n JEOM
	FROM #abonos, #monto_def m, cob_cartera..ca_dividendo WITH (nolock)
	WHERE doa_operacion = tr_operacion
	AND doa_sec_pag     = tr_secuencial
	AND tr_operacion    = di_operacion
	AND dtr_dividendo   = di_dividendo

   ---------***********************************************************************
   -- para = REVOLVENTES
	TRUNCATE TABLE #abonos
	TRUNCATE TABLE #monto_pago
	TRUNCATE TABLE #monto_def

	INSERT INTO #abonos (
		doa_aplicativo,
		doa_fecha        ,doa_banco        ,doa_operacion    ,
		doa_sec_pag      ,doa_fecha_pag    ,doa_di_fecha_ven ,
		doa_dias_atraso  ,doa_fpago        ,doa_total        ,
		doa_capital      ,doa_int          ,doa_otro         ,
		doa_saldo_cap    ,doa_sec_ing      ,doa_oficina      ,
		doa_estado       ,doa_usuario      ,doa_moneda       ,
		doa_iva_int      ,doa_imo          ,doa_iva_imo      ,
		doa_disp         ,doa_iva_disp     ,doa_objetado     ,
		doa_sec_rpa      ,doa_tipo_trn
		)
	select
		7,
		cop_fecha        ,cop_banco        ,ab_operacion     ,
		ab_secuencial_pag,ab_fecha_pag     ,NULL             ,
		0                ,abd_concepto     ,abd_monto_mpg    ,
		0                ,0                ,0                ,
		0                ,ab_secuencial_ing,ab_oficina       ,
		ab_estado        ,ab_usuario       ,abd_moneda       ,
		0                ,0                ,0                ,
		0                ,0                ,'N',
		ab_secuencial_rpa,'PAG'
	from ca_abono, ca_abono_det,  #operaciones WITH (nolock)
	where ab_operacion = cop_operacion
	and ab_operacion = abd_operacion
	and ab_secuencial_ing = abd_secuencial_ing
	AND abd_concepto <> 'SOBRANTE'
	AND ab_estado = 'A'
	AND cop_toperacion not in ( 'GRUPAL', 'INDIVIDUAL') ---*****
	AND ab_fecha_pag BETWEEN @w_fecha_ini AND @w_fecha_proceso

	--////////////////////////////////
	-- marcar los pagos objetados
	--////////////////////////////////
	UPDATE #abonos SET doa_objetado = 'S'
	WHERE doa_fpago = @w_fp_objetado 


	-- VALORES PAGADOS
	INSERT INTO #monto_pago
	SELECT
		tr_operacion, tr_secuencial, dtr_dividendo,
		'capital' = (CASE WHEN dtr_concepto IN ('CAP')      THEN sum(dtr_monto_mn) ELSE 0 end),
		'interes' = (CASE WHEN dtr_concepto IN ('INT')      THEN sum(dtr_monto_mn) ELSE 0 end),
		'imo'     = (CASE WHEN dtr_concepto IN ('COMMORA')  THEN sum(dtr_monto_mn) ELSE 0 end),
		'iva_int' = (CASE WHEN dtr_concepto IN ('IVA_INT')   THEN sum(dtr_monto_mn) ELSE 0 end),
		'iva_imo' = (CASE WHEN dtr_concepto IN ('IVA_CMORA') THEN sum(dtr_monto_mn) ELSE 0 end),
		'otro'    = (CASE WHEN dtr_concepto NOT IN ('CAP', 'INT', 'IVA_INT', 'COMMORA', 'IVA_CMORA')
		            THEN sum(dtr_monto_mn) ELSE 0 end)
	FROM cob_cartera..ca_transaccion, cob_cartera..ca_det_trn, #abonos WITH (nolock)
	WHERE doa_operacion = tr_operacion
	AND doa_sec_pag     = tr_secuencial
	AND tr_operacion    = dtr_operacion
	AND tr_secuencial   = dtr_secuencial
	AND tr_tran         = 'PAG'
	AND dtr_concepto   <> 'VAC0'
	GROUP BY tr_operacion, tr_secuencial, dtr_dividendo, dtr_concepto


	INSERT INTO #monto_def
	SELECT
		tr_operacion,
		tr_secuencial,
		dtr_dividendo,
		'capital' = sum(capital),
		'interes' = sum(interes),
		'imo'     = sum(imo),
		'iva_int' = sum(iva_int),
		'iva_imo' = sum(iva_imo),
		'otro'    = sum(otro)
	FROM  #monto_pago
	GROUP BY tr_operacion, tr_secuencial, dtr_dividendo


	--AZU
	select * into #operaciones_no_grupal from #operaciones
	WHERE  cop_toperacion NOT IN ('GRUPAL', 'INDIVIDUAL')

   -- ////////////////////////////////
   -- LOS SALDOS INICIALES DE LAS LCR,
   -- ////////////////////////////////
	INSERT INTO cob_externos..ex_dato_operacion_abono
	SELECT
		7,
		cop_fecha        ,cop_banco        ,cop_operacion    ,
		0                ,cop_fecha_liq    ,cop_fecha_liq    ,
		0                ,0                ,'Saldo Inicial'  ,
		0                ,0                ,00000            ,
		0                ,0                ,0                ,
		cop_oficina      ,'A'              ,'na'             ,
		cop_moneda       ,0                ,0                ,
		0                ,0                ,0                ,
		'N'              ,0                ,'INI', 'N'--JEOM
	FROM #operaciones_no_grupal    --#operaciones   --AZU
	--WHERE  cop_toperacion <> 'GRUPAL'


   -- SON CERO PARA LAS CREADAS EN EL MES
	-- SON LOS SALDOS DEL CONSOLIDADOR AL FINAL DEL MES ANTERIOR PARA LAS CREADAS EN OTRAS FECHAS
	-- ///////////////////////////////////////////////////////////////////////////////////////////
	SELECT @w_fant_consol = max(do_fecha)
	FROM cob_conta_super..sb_dato_operacion
	WHERE do_fecha < @w_fecha_ini

	SELECT  
	't_banco'   = dc_banco ,
	't_cap'     = sum(dc_cap_cuota - dc_cap_pag), 
	't_int'     = sum(dc_int_acum  - dc_int_pag),
	't_iva_int' = sum(dc_iva_int_acum  - dc_iva_int_pag),
	't_imo'     = sum(dc_imo_cuota  - dc_imo_pag),
	't_iva_imo' = sum(dc_iva_imo_cuota  - dc_int_pag)
	INTO #saldos_ini_lcr
	FROM cob_conta_super..sb_dato_cuota_pry, #operaciones  WITH (nolock)
	where dc_fecha = @w_fant_consol
	AND dc_estado <> 3
	AND cop_toperacion not in ('GRUPAL', 'INDIVIDUAL')
	AND dc_banco = cop_banco
	GROUP BY dc_banco

	UPDATE cob_externos..ex_dato_operacion_abono set
		doa_total     = t_cap + t_int + t_iva_int + t_imo + t_iva_imo,
		doa_capital   = t_cap ,
		doa_int       = t_int ,
		doa_otro      = t_iva_int ,
		doa_imo       = t_imo,
		doa_iva_imo   = t_iva_imo
	FROM #saldos_ini_lcr
	WHERE  t_banco = doa_banco
	
	-- /////////////////////////////////////////
	-- PAGOS DEL MES
	-- /////////////////////////////////////////

	INSERT INTO cob_externos..ex_dato_operacion_abono
	SELECT
		doa_aplicativo,
		doa_fecha        ,doa_banco        ,doa_operacion    ,
		doa_sec_pag      ,doa_fecha_pag    ,di_fecha_ven     , 
		dtr_dividendo,
		CASE WHEN datediff(dd, di_fecha_ven,doa_fecha_pag ) > 0 THEN datediff(dd, di_fecha_ven,doa_fecha_pag ) ELSE 0 END  , ----------------------XXXXXXXXXXXXXXXXXXXXXXXXXS
		doa_fpago        ,
		doa_total        ,capital          ,interes          ,
		otro             ,doa_saldo_cap    ,doa_sec_ing      ,
		doa_oficina      ,doa_estado       ,doa_usuario      ,
		doa_moneda       ,iva_int          ,imo              ,
		iva_imo          ,0                ,0                ,
		doa_objetado     ,doa_sec_rpa      ,doa_tipo_trn, 'N' --JEOM
	FROM #abonos, #monto_def m, cob_cartera..ca_dividendo  WITH (nolock)
	WHERE doa_operacion = tr_operacion
	AND doa_sec_pag     = tr_secuencial
	AND tr_operacion    = di_operacion
	AND dtr_dividendo   = di_dividendo
	
	-- /////////////////////////////////////////
	-- DESEMBOLSOS DEL MES
	-- /////////////////////////////////////////
	SELECT * INTO #desembolsos FROM #abonos WHERE 1=2
	
	INSERT INTO #desembolsos
	SELECT
		7,
		cop_fecha        ,cop_banco        ,cop_operacion    ,
		dm_secuencial    ,tr_fecha_ref     ,NULL             ,
		dm_dividendo     ,0                ,'Disposición'    ,
		0                ,0                ,0                ,
		0                ,0                ,dm_secuencial    ,
		cop_oficina      ,dm_estado        ,tr_usuario       ,
		tr_moneda        ,0                ,0                ,
		0                ,0                ,0                ,
		'N'               ,tr_secuencial    ,'DES'
	from cob_cartera..ca_desembolso,  
	     #operaciones, 
	     cob_cartera..ca_transaccion  WITH (nolock)
	WHERE dm_operacion = cop_operacion
	AND tr_operacion  = cop_operacion
	AND tr_secuencial = dm_secuencial
	AND cop_toperacion not in ('GRUPAL', 'INDIVIDUAL')
	AND tr_estado      <> 'RV'
	AND tr_fecha_ref  BETWEEN @w_fecha_ini AND @w_fecha_proceso
	
	SELECT 
		tr_operacion, tr_secuencial, 
		'capital' = (CASE WHEN dtr_concepto IN ('CAP')      THEN sum(dtr_monto) ELSE 0 end),
		'com'     = (CASE WHEN dtr_concepto IN ('COM')      THEN sum(dtr_monto) ELSE 0 end),
		'iva_com' = (CASE WHEN dtr_concepto IN ('IVA_COM')  THEN sum(dtr_monto) ELSE 0 end),
		'otro'    = (CASE WHEN dtr_concepto NOT IN ('CAP', 'COM', 'IVA_COM')
		            THEN sum(dtr_monto) ELSE 0 end)
	INTO #monto_des
	from ca_desembolso, #operaciones, ca_transaccion, ca_det_trn dtr  WITH (nolock)
	WHERE dm_operacion = cop_operacion
	AND tr_operacion  = cop_operacion
	AND tr_secuencial = dm_secuencial
	AND cop_toperacion not in ('GRUPAL', 'INDIVIDUAL')
	AND dtr_operacion  = tr_operacion
	AND dtr_secuencial = tr_secuencial
	AND tr_estado      <> 'RV'
	AND tr_fecha_ref  BETWEEN @w_fecha_ini AND @w_fecha_proceso
	GROUP BY tr_operacion, tr_secuencial, dtr_concepto
	

	SELECT
		tr_operacion,
		tr_secuencial,
		'capital' = sum(capital),
		'com'     = sum(com),
		'iva_com' = sum(iva_com),
		'otro'    = sum(otro)
		INTO #monto_des_def
	FROM  #monto_des
	GROUP BY tr_operacion, tr_secuencial
	
	create index idx1 on #desembolsos (doa_operacion, doa_sec_pag, doa_dividendo)

    print '[sp_datos_operacion] Insert ex_dato_operacion_abono ' + convert(varchar(64),convert(date,getdate())) + ' ' + convert(varchar(64),getdate(),108)

	INSERT INTO cob_externos..ex_dato_operacion_abono
	SELECT
		doa_aplicativo,
		doa_fecha        ,doa_banco        ,doa_operacion    ,
		doa_sec_pag      ,doa_fecha_pag    ,di_fecha_ven     , 
		doa_dividendo    ,0                ,doa_fpago        ,
		capital          ,capital          ,0                ,
		otro             ,capital          ,doa_sec_ing      ,
		doa_oficina      ,doa_estado       ,doa_usuario      ,
		doa_moneda       ,0                ,0                ,
		0                ,com              ,iva_com          ,
		doa_objetado     ,doa_sec_rpa      ,doa_tipo_trn, 'N'--JEOM
	FROM #desembolsos, #monto_des_def m, ca_dividendo WITH (nolock)
	WHERE doa_operacion = tr_operacion
	AND doa_sec_pag     = tr_secuencial
	AND tr_operacion    = di_operacion
	AND doa_dividendo   = di_dividendo


	--2021/12/17  update con mi tabla JEOM
	UPDATE  cob_externos..ex_dato_operacion_abono
			SET doa_condonaciones = 'S'
	FROM #condonados 
	WHERE 
	doa_sec_ing       = ab_secuencial_ing 
	AND doa_operacion = cop_operacion

	TRUNCATE TABLE #condonados

	--jeom


	--//////////////////////////////////////////////////////
   /* REGISTRO DEL LAS FECHAS DE FUTUROS VENCIMIENTOS DE LA OPERACION */
   insert into cob_externos..ex_dato_cuota_pry
   select 
   @w_fecha_proceso,
   cop_banco,
   cop_toperacion,  
   7,
   di_dividendo,
   di_fecha_ven,
   di_estado,
   saldo            = isnull(sum(am_cuota-am_pagado),0),
   /* NUEVOS CAMPOS PARA SACAR EL ESTADO DE CUENTA DESDE EL CONSOLIDADOR */
   /* VALORES CUOTA */
   di_cap_cuota     = sum(case when am_concepto = 'CAP'        then am_cuota else 0 end),
   di_int_cuota     = sum(case when am_concepto in ('INT', 'INT_ESPERA')      then am_cuota else 0 end),
   di_imo_cuota     = sum(case when am_concepto = 'COMMORA'    then am_cuota else 0 end),
   di_pre_cuota     = sum(case when am_concepto = 'COMPRECAN'  then am_cuota else 0 end),
   di_iva_int_cuota = sum(case when am_concepto in ('IVA_INT', 'IVA_ESPERA')    then am_cuota else 0 end),
   di_iva_imo_cuota = sum(case when am_concepto = 'IVA_CMORA'  then am_cuota else 0 end),
   di_iva_pre_cuota = sum(case when am_concepto = 'IVA_COMPRE' then am_cuota else 0 end),
   di_otros_cuota   = sum(case when am_concepto NOT IN ('CAP', 'INT', 'COMMORA', 'COMPRECAN', 'IVA_INT', 'IVA_CMORA', 'IVA_COMPRE', 'INT_ESPERA', 'IVA_ESPERA') then am_cuota else 0 end),
   /* VALORES ACUMULADOS */
   di_int_acum      = sum(case when am_concepto IN ('INT', 'INT_ESPERA') then am_acumulado else 0 end),
   di_iva_int_acum  = sum(case when am_concepto IN ('IVA_INT', 'IVA_ESPERA') then am_acumulado else 0 end),
   /* VALORES PAGADOS */
   di_cap_pag       = sum(case when am_concepto = 'CAP'        then am_pagado else 0 end),
   di_int_pag       = sum(case when am_concepto in ('INT', 'INT_ESPERA')        then am_pagado else 0 end),
   di_imo_pag       = sum(case when am_concepto = 'COMMORA'    then am_pagado else 0 end),
   di_pre_pag       = sum(case when am_concepto = 'COMPRECAN'  then am_pagado else 0 end),
   di_iva_int_pag   = sum(case when am_concepto in ('IVA_INT', 'IVA_ESPERA')    then am_pagado else 0 end),
   di_iva_imo_pag   = sum(case when am_concepto = 'IVA_CMORA'  then am_pagado else 0 end),
   di_iva_pre_pag   = sum(case when am_concepto = 'IVA_COMPRE' then am_pagado else 0 end),
   di_otros_pag     = sum(case when am_concepto NOT IN ('CAP', 'INT', 'COMMORA', 'COMPRECAN', 'IVA_INT', 'IVA_CMORA', 'IVA_COMPRE', 'INT_ESPERA', 'IVA_ESPERA') then am_pagado else 0 end),
   /* FECHA DE CANCELACION DE LA CUOTA */
   max(di_fecha_can),
   null,
   di_fecha_ini,
   null,
   null
   from ca_dividendo d, ca_amortizacion a, #operaciones o WITH (nolock)
   where cop_operacion = di_operacion
   and   di_operacion  = am_operacion
   and   am_operacion  = cop_operacion
   and   am_dividendo  = di_dividendo
   group by cop_banco, cop_operacion, cop_toperacion, di_dividendo, di_fecha_ven, di_fecha_ini, di_estado

   if @@error <> 0 begin
      select 
      @w_error = 724504, 
      @w_msg = 'Error en al Grabar en table cob_externos..ex_dato_cuota_pry'
      goto ERROR
   end
   
   select
   ult_banco      = tr_banco,
   ult_dividendo  = dtr_dividendo,
   ult_fecha_pag  = max(tr_fecha_ref)
   into #ultpagos
   from cob_cartera..ca_transaccion, cob_cartera..ca_det_trn, #operaciones WITH (nolock)
   where tr_operacion  = dtr_operacion
   and   tr_operacion  = cop_operacion
   and   tr_secuencial = dtr_secuencial
   and   tr_tran       = 'PAG'
   and   tr_estado     <> 'RV'
   group by tr_banco, dtr_dividendo

   if @@error != 0  begin
      select
      @w_error = 708192, 
      @w_msg = 'Error en al Consultar Ultimos Pagos'
      goto ERROR
   end

	--AZU
	create index idx1 on #ultpagos (ult_banco, ult_dividendo)

   update cob_externos..ex_dato_cuota_pry set
   dc_fecha_upago  = ult_fecha_pag
   from #ultpagos
   where ult_banco     = dc_banco
   and   ult_dividendo = dc_num_cuota

   if @@error != 0  begin
      select 
      @w_error = 724504,
      @w_msg = 'Error en al Grabar en table cob_externos..ex_dato_cuota_pry'
      goto ERROR
   END
      
   insert into cob_externos..ex_condonacion
   select
   @w_fecha_proceso,   7,               co_secuencial,
   op_banco,           op_cliente,      co_fecha_aplica,
   co_valor,           co_porcentaje,   co_concepto,     
   co_estado_concepto, co_usuario,      co_rol_condona,
   co_autoriza,        co_estado
   from ca_condonacion,ca_operacion  WITH (nolock)
   where co_operacion    = op_operacion
   and   datepart(mm,co_fecha_aplica) = datepart(mm, @w_fecha_proceso)
   and   datepart(yy,co_fecha_aplica) = datepart(yy, @w_fecha_proceso)
   and   co_estado       = 'R'
   
   if @@error <> 0 begin
      select 
      @w_error = 724504, 
      @w_msg = 'Error en al Grabar en tabla cob_externos..ex_condonacion'
      goto ERROR
   end

   --- Por caso #156405
   /*insert into cob_externos..ex_operacion
    (  
    eo_fecha        ,     eo_operacion,      eo_banco,
	eo_cliente      ,     eo_toperacion,     eo_monto,
	eo_estado       ,     eo_aplicativo)
	select                
	cop_fecha       ,     cop_operacion,     cop_banco,
    cop_cliente     ,     cop_toperacion,    cop_monto,
    cop_estado,           7
    from #operaciones, cob_credito..cr_tramite_grupal
    where cop_operacion = tg_operacion
	and cop_fecha_ini  between @w_fecha_ini and @w_fecha_proceso
	and tg_referencia_grupal <> tg_prestamo
	order by cop_operacion*/ -- Comentado por Req.205892
	



end

return 0

ERROR:

exec sp_errorlog 
@i_fecha     = @w_fecha_proceso,
@i_error     = @w_error, 
@i_usuario   = 'sa', 
@i_tran      = 7999,
@i_tran_name = @w_sp_name,
@i_cuenta    = 'Masivo',
@i_anexo     = @w_msg,
@i_rollback  = 'S'

return @w_error
GO


