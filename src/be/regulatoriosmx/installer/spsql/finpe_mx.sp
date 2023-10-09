USE cob_conta
GO
/* ********************************************************************* */
/*      Archivo:                sp_precancela_refer.sp                   */
/*      Stored procedure:       sp_precancela_refer                      */
/*      Base de datos:          cob_conta                                */
/*      Producto:               Contabilidad                             */
/*      Disenado por:                                                    */
/*      Fecha de escritura:     10-Ene-2017                              */
/* ********************************************************************* */
/*                              IMPORTANTE                               */
/*      Este programa es parte de los paquetes bancarios propiedad de    */
/*      "MACOSA", representantes exclusivos para el Ecuador de la        */
/*      "NCR CORPORATION".                                               */
/*      Su uso no autorizado queda expresamente prohibido asi como       */
/*      cualquier alteracion o agregado hecho por alguno de sus          */
/*      usuarios sin el debido consentimiento por escrito de la          */
/*      Presidencia Ejecutiva de MACOSA o su representante.              */
/* ********************************************************************* */
/*                              PROPOSITO                                */
/*   Cierre de Periodo Contable                                          */
/* ********************************************************************* */
/*                              MODIFICACIONES                           */
/*      FECHA           AUTOR                RAZON                       */
/*      12/Dic/2017     LGU                  Personalizacion MX          */
/*      10/Ene/2019     DCU                  Simulacion #133294          */
/*                                           Simulacion: S-> Si, N-> No  */
/*                                           Arreglo contrapartida       */
/* ***********************************************************************/

IF OBJECT_ID ('dbo.sp_finpe_mx') IS NOT NULL
    DROP PROCEDURE dbo.sp_finpe_mx
GO

CREATE PROCEDURE sp_finpe_mx (
   @s_user         login       = 'usrbatch',
   @i_param1       TINYINT,
   @i_param2       char(1)     = 'N'     
)

AS


/* DECLARA VARIABLES DE TRABAJO */
declare
@w_oficina         smallint,
@w_descripcion     varchar(80),
@w_area_orig       smallint,
@w_saldo           money,
@w_saldo_me        money,
@w_detalles        int,
@w_credito         money,
@w_debito          money,
@w_credito_me      money,
@w_debito_me       money,
@w_cuenta          varchar(14),
@w_comprobante     int,
@w_contador        int,
@w_moneda_base     tinyint,
@w_saldo_mn        money,
@w_moneda          TINYINT,
@w_sp_name         VARCHAR(50),
@w_cta_ingresos    varchar(14),
@w_cta_gastos      varchar(14),
@w_cta_contra      varchar(14),
@w_ofi_contra      SMALLINT,
@w_fp_mes          SMALLINT,
@w_msg             VARCHAR(150),
@w_campo           VARCHAR(30),
@w_dato            VARCHAR(150),
@w_proceso         VARCHAR(30),
@w_error           INT,
@w_proceso_cierre  INT ,
@w_fecha_proceso   DATETIME,
@w_fecha_ing_comp  DATETIME,
@w_fecha_fin_per   DATETIME,
@w_estado          VARCHAR(1),
@w_periodo         INT,
@w_corte           INT,
@w_tot_deb_mn      money,
@w_tot_cre_mn      money,
@w_tot_deb_me      money,
@w_tot_cre_me      money,
@w_tot_area        INT,
@w_commit          CHAR(1),
@w_ant_comprobante INT,
@w_empresa         TINYINT,
@w_simulacion      char(1),
@w_path            varchar(255),
@w_query           varchar(500),
@w_destino         varchar(2500),
@w_errores         varchar(1500),
@w_comando         varchar(2500),
@w_s_app           varchar(50)

/* INICIALIZA VARIABLES DE TRABAJO */
select
@w_descripcion     = 'Asiento Automático de Cierre de Periodo Contable generado el: ',
@w_oficina         = 0,
@w_area_orig       = 0,
@w_saldo           = 0,
@w_detalles        = 0,
@w_credito         = 0,
@w_debito          = 0,
@w_cuenta          = '',
@w_comprobante     = 0,
@w_moneda_base     = 0,
@w_sp_name         = 'sp_finpe_mx',
@w_proceso_cierre  = 6079 --- CIERRE DE CUENTAS DE PYG


/* DETERMINAR SI SE EJECUTA EL PROCESO */
SELECT @w_empresa = @i_param1
select @w_simulacion = @i_param2
/* FECHA DE PROCESO DE COBIS */

print '@w_simulacion:' +  @w_simulacion

select @w_path = pp_path_destino
from   cobis..ba_path_pro
where  pp_producto = 6 -- CONTA

select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM' and pa_nemonico = 'S_APP'

SELECT @w_fecha_proceso = fp_fecha
FROM cobis..ba_fecha_proceso 

SELECT @w_proceso = 'CIERRE'

IF NOT EXISTS (select 1 from cob_conta..cb_solicitud_reportes_reg
                where sr_reporte = @w_proceso and sr_status  = 'I')
BEGIN
  RETURN 0
END

SELECT @w_descripcion = @w_descripcion + convert(VARCHAR, @w_fecha_proceso, 103)

DELETE cob_conta..cb_errores WHERE cbe_procedimiento = 'sp_finpe_mx' AND cbe_fecha_err = @w_fecha_proceso

/*Simulacion*/
if @w_simulacion = 'S'
begin
    if not object_id('cb_comprobante_simulacion') is null drop table cb_comprobante_simulacion
    select * into cb_comprobante_simulacion from cob_conta..cb_comprobante where 1 = 2
    
    if not object_id('cb_asiento_simulacion') is null drop table cb_asiento_simulacion
    select * into cb_asiento_simulacion from cob_conta..cb_asiento where 1 = 2
    
    if not object_id('cb_retencion_simulacion') is null drop table cb_retencion_simulacion
    select * into cb_retencion_simulacion from cob_conta..cb_retencion where 1 = 2    
end

/* BUSCA AREA ORIGEN */
select @w_area_orig = pa_smallint
from cobis..cl_parametro
where pa_nemonico = 'ARC'
and   pa_producto = 'CCA'


/* BUSCA MONEDA BASE */
select @w_moneda_base = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'MLO'
and   pa_producto = 'ADM'

/* DETERMINAR LAS CUENTAS DE INGRESOS Y GASTOS Y SU RESPECTIVA CUENTA DE CONTRAPARTIDA PARA EL CIERRE */
SELECT
'cuenta'     = ca_cuenta,
'moneda'     = ca_condicion,
'ctr_cuenta' = ca_cta_asoc,
'ctr_oficina'= ca_oficina_destino
INTO #cta_contra
FROM cob_conta..cb_cuenta_asociada
WHERE ca_proceso = @w_proceso_cierre

IF @@ROWCOUNT = 0 BEGIN
    SELECT
    @w_msg   = 'CUENTAS DE CIERRE NO PARAMETRIZADAS',
    @w_campo = 'cuenta_asociada',
    @w_dato  =  '420301',
    @w_error = 601301
    GOTO ERROR_FIN
END



/* VERIFICAR QUE LAS CUENTAS DE CIERRE EXISTAN Y SEAN DE MOVIMIENTO */
IF NOT EXISTS(SELECT 1 FROM #cta_contra, cob_conta..cb_cuenta WHERE cu_cuenta = ctr_cuenta AND cu_movimiento = 'S')
BEGIN
    SELECT
    @w_msg = 'LA CUENTA CONTRAPARTIDA DE CIERRE DE PERIODO NO EXISTE O NO ES DE MOVIMIENTO',
    @w_campo = 'cuenta_proceso',
    @w_dato  =  '420301',
    @w_error = 601302
    GOTO ERROR_FIN
END

/* DETERMINAR EL MES DONDE SE INGRESARA EL COMPROBANTE DE CIERRE DE PERIODO */
SELECT @w_fp_mes  = pa_int
FROM cobis..cl_parametro
WHERE pa_nemonico = 'MESFPE'

IF @@ROWCOUNT = 0 BEGIN
    SELECT
    @w_msg = 'NO PARAMETRIZADO EL MES DE INGRESO DEL COMPROBANTE DE FIN DE PERIODO',
    @w_campo = 'cl_parametro',
    @w_dato  = 'MESFPE',
    @w_error = 601303
    GOTO ERROR_FIN
END


/* DETERMINAR LA FECHA DE INGRESO DEL COMPROBANTE DE CIERRE */
IF @w_fp_mes = 1  -- enero
    SELECT @w_fecha_ing_comp = convert(datetime, '01/01/'+ convert(VARCHAR,datepart(yy,@w_fecha_proceso )))
ELSE              -- caso contario asumimos diciembre
    SELECT @w_fecha_ing_comp = convert(datetime, '12/31/'+ convert(VARCHAR,datepart(yy,@w_fecha_proceso)-1))

/* VERIFICAR QUE LA FECHA DE CORTE EN QUE SE INGRESA EL COMPROBANTE ESTE ABIERTO O VIGENTE */
IF NOT EXISTS( SELECT 1 FROM cob_conta..cb_corte
WHERE co_empresa = @w_empresa
AND co_fecha_ini = @w_fecha_ing_comp
AND co_estado   IN ('V','A')) BEGIN
    SELECT
    @w_msg = 'EL CORTE DE INGRESO DEL COMPROBANTE DE FIN DE PERIODO NO ESTA ABIERTO: '+ convert(VARCHAR,@w_fecha_ing_comp, 101) ,
    @w_campo = 'co_estado_co',
    @w_dato  = @w_estado,
    @w_error = 601304
    GOTO ERROR_FIN
END

SELECT @w_estado = ''

/* DETERMINAR LA FECHA EN QUE FINALIZA EL PERIDO QUE ESTAMOS CERRANDO */
SELECT @w_fecha_fin_per  = convert(datetime, '12/31/'+ convert(VARCHAR,datepart(yy,@w_fecha_proceso)-1))


/* DETERMINAR EL NUMERO DE CORTE Y ESTADO DE LA FECHA DE FIN DE PERIODO */
SELECT
@w_estado  = co_estado,
@w_corte   = co_corte,
@w_periodo = co_periodo
FROM cob_conta..cb_corte
WHERE co_empresa = @w_empresa
AND co_fecha_ini = @w_fecha_fin_per

/* ESTE CONTROL APLICA SOLO CUANDO LAS FECHAS DE INGRESO Y FIN DE PERIODO SON DIFERENTES */
IF @w_estado <> 'C' AND @w_fecha_fin_per <> @w_fecha_ing_comp BEGIN
    SELECT
    @w_msg = 'EL CORTE DE FIN DE PERIODO NO ESTA CERRADO',
    @w_campo = 'co_estado_co',
    @w_dato  = @w_estado,
    @w_error = 601305
    GOTO ERROR_FIN
END


/* DETERMINAR EL UNIVERSO DE CUENTAS QUE PARTICIPAN */
select distinct
cu_cuenta      = cu_cuenta,
cu_moneda      = cu_moneda,
cu_tercero     = convert(char(1),'N'), --al inicio asumimos que ninguna cuenta es de terceros
cu_ctr_cuenta  = ctr_cuenta,
cu_ctr_oficina = ctr_oficina
into #cuentas_finpe
from cob_conta..cb_cuenta, #cta_contra
where substring(cu_cuenta,1,1) = cuenta
AND   cu_moneda                = moneda
and   cu_movimiento            = 'S'


/* DETERMINAR LAS CUENTAS DE TERCEROS Y TERCEROS TRIBUTARIOS */
update #cuentas_finpe set
cu_tercero = 'S'
from cob_conta..cb_cuenta_proceso
where cp_cuenta = cu_cuenta
and   cp_proceso in (6003, 6095)  --terceros y terceros tributarios


/* VERIFICAR QUE NO EXISTAN COMPROBANTES DE CIERRE DE AÑO NO MAYORIZADOS */
IF @w_fecha_fin_per = @w_fecha_ing_comp BEGIN -- CONTROL SOLO APLICA CUANDO LA FECHA DE INGRESO DEL COMPR = FECHA INICIO CIERRE
	IF EXISTS(SELECT 1 FROM cob_conta..cb_comprobante
              WHERE co_empresa    = @w_empresa
    		  AND co_fecha_tran   = @w_fecha_ing_comp
    		  AND co_automatico   = @w_proceso_cierre
    		  AND co_mayorizado   = 'N')
    BEGIN
	    SELECT
	    @w_msg = 'ERROR: EXISTE COMPROBANTE NO MAYORIZADO. PARA REPROCESAR MAYORICE',
	    @w_campo = 'co_mayorizado',
	    @w_dato  = 'N',
	    @w_error = 601306
	    GOTO ERROR_FIN
    END
END


create table #saldos_cierre(
asiento      int identity,
cuenta       varchar(14),
oficina      int,
area         smallint,
ente         int,
debito       money,
credito      money,
debito_me    money,
credito_me   money,
moneda       tinyint,
documento    varchar(20) null,
tdocumento   char(4)     NULL,
ctr_cuenta   varchar(14) NULL,  -- cuenta contra
ctr_oficina  INT         NULL  -- oficina contra
)

insert into #saldos_cierre
select
cuenta      = hi_cuenta,
oficina     = hi_oficina,
area        = hi_area,
ente        = 0,  -- ente cero para las cuentas que no son de tercero
debito      = case when hi_saldo    < 0 then abs(hi_saldo)     else 0 end,
credito     = case when hi_saldo    > 0 then abs(hi_saldo)     else 0 end,
debito_me   = case when hi_saldo_me < 0 then abs(hi_saldo_me)  else 0 end,
credito_me  = case when hi_saldo_me > 0 then abs(hi_saldo_me)  else 0 end,
moneda      = cu_moneda,
documento   = '',
tdocumento  = '',
ctr_cuenta  = cu_ctr_cuenta,
ctr_oficina = cu_ctr_oficina
from cob_conta_his..cb_hist_saldo, #cuentas_finpe
where hi_corte    = @w_corte
and   hi_periodo  = @w_periodo
and   hi_cuenta   = cu_cuenta
and   cu_tercero  = 'N'
and   isnull(hi_saldo, 0)  <> 0

insert into #saldos_cierre
select
cuenta     = st_cuenta,
oficina    = st_oficina,
area       = st_area,
ente       = st_ente,
debito     = case when st_saldo    < 0 then abs(st_saldo)    else 0 end,
credito    = case when st_saldo    > 0 then abs(st_saldo)    else 0 end,
debito_me  = case when st_saldo_me < 0 then abs(st_saldo_me) else 0 end,
credito_me = case when st_saldo_me > 0 then abs(st_saldo_me) else 0 end,
moneda     = cu_moneda,
documento   = '',
tdocumento  = '',
ctr_cuenta = cu_ctr_cuenta,
ctr_oficina= cu_ctr_oficina
from cob_conta_tercero..ct_saldo_tercero, #cuentas_finpe
where st_corte      = @w_corte
and   st_periodo    = @w_periodo
and   st_cuenta     = cu_cuenta
and   cu_tercero    = 'S'
and   isnull(st_saldo, 0)  <> 0


/* DETERMINAR LAS OFICINAS QUE TIENEN SALDOS */
select distinct oficina
into #oficina
from #saldos_cierre

update #saldos_cierre set
documento  = en_ced_ruc,
tdocumento = en_tipo_ced
from cobis..cl_ente
where en_ente = ente


/* REPORTAR COMO ERRORES A LAS PERSONAS NO REGISTRADAS EN LA BASE DE CLIENTES */
insert into cob_conta..cb_errores
select
@w_sp_name,  'CLIENTE NO EXISTE', 'ente', CONVERT(VARCHAR(50),ente), @w_fecha_proceso
from #saldos_cierre
where isnull(ente, 0) > 0
and  (documento = '' or tdocumento = '')

if @@rowcount <> 0 BEGIN
	RETURN 601307  --terminar el proceso en caso de existir terceros no registrados
END

/* VERIFICAR QUE LA CUENTA TENGA PERMISOS DE CREAR ASIENTOS EN LA OFICINA Y AREA */
select distinct oficina, area, cuenta
into #plan_general
from #saldos_cierre

delete #plan_general
from cob_conta..cb_plan_general
where pg_cuenta  = cuenta
and   pg_oficina = oficina
and   pg_area    = area

insert into cob_conta..cb_errores
select
SP      = @w_sp_name,
MENSAJE = 'CUENTA NO REGISTRADA EN LA TABLA CB_PLAN GENERA PARA LA OFICINA Y AREA',
CAMPO   = 'cb_plan_general',
DATO    = 'CTA: ' + cuenta + ' OFI: '+ CONVERT(VARCHAR, oficina) +  ' AREA: '+ CONVERT(VARCHAR, area),
FECHA   = @w_fecha_proceso
from #plan_general

IF @@ROWCOUNT <> 0 return 601308

/* VERIFICAR QUE LA CUENTA DE CONTRAPARTIDA TENGA PERMISOS DE CREAR ASIENTOS EN LA OFICINA Y AREA */
select distinct ctr_oficina, 'ctr_area' = area, ctr_cuenta
into #plan_general_contra
from #saldos_cierre

delete #plan_general_contra
from cob_conta..cb_plan_general
where pg_cuenta  = ctr_cuenta
and   pg_oficina = ctr_oficina
and   pg_area    = ctr_area

insert into cob_conta..cb_errores
select
SP      = @w_sp_name,
MENSAJE = 'CUENTA NO REGISTRADA EN LA TABLA CB_PLAN GENERAL PARA LA OFICINA Y AREA',
CAMPO   = 'cb_plan_general_contra',
DATO    = 'CTA: ' + rtrim(ctr_cuenta) + ' OFI: '+ CONVERT(VARCHAR, ctr_oficina) +  ' AREA: '+ CONVERT(VARCHAR, ctr_area),
FECHA   = @w_fecha_proceso
from #plan_general_contra

IF @@ROWCOUNT <> 0 return 601309

SELECT * INTO #asiento     FROM cb_asiento WHERE 1=2
ALTER TABLE #asiento ADD ente int
ALTER TABLE #asiento ADD doc  VARCHAR(64)
ALTER TABLE #asiento ADD tdoc catalogo

SELECT * INTO #asiento_ant FROM #asiento WHERE 1=2


/**************************************************************/
/*     GENERACION DE COMPROBANTES DE CIERRE POR OFICINA       */
/**************************************************************/
SELECT @w_oficina = 0

/* CICLO POR OFICINA EXTRAE SALDOS GENERALES Y DE TERCEROS */
while 1 = 1
BEGIN
    set rowcount 1

    select @w_oficina = oficina
    from #oficina
    where oficina > @w_oficina
    order by oficina

    if @@rowcount = 0 begin
      set rowcount 0
      break
    end

    set rowcount 0

    TRUNCATE TABLE #asiento

    exec @w_error = cob_conta..sp_cseqcomp
    @i_empresa = @w_empresa,
    @i_fecha   = @w_fecha_ing_comp,
    @i_tabla   = 'cb_tcomprobante',
    @i_modulo  = 6,
    @i_modo    = 1,
    @o_siguiente = @w_comprobante out

    if @w_error <> 0 begin
        set rowcount 0
        SELECT
        @w_msg = 'GENERANDO CODIGO COMPROBANTE',
        @w_campo = 'oficina',
        @w_dato  = CONVERT(VARCHAR(50),@w_oficina),
	    @w_error = 601307
        goto ERROR_FIN
    end

    /* LLEVANDO A CERO LAS CUENTAS DE INGRESOS Y GASTOS  */
    insert into #asiento (
    as_fecha_tran,       as_comprobante,    as_empresa,
    as_asiento,          as_cuenta,         as_oficina_dest,
    as_area_dest,        as_credito,        as_debito,
    as_concepto,
    as_credito_me,     as_debito_me,
    as_cotizacion,       as_mayorizado,     as_tipo_doc,
    as_tipo_tran,        as_moneda,         as_opcion,
    as_fecha_est,        as_detalle,        as_consolidado,
    as_oficina_orig,     as_mes_fecha_tran, ente,
    doc,                 tdoc)
    select
    @w_fecha_ing_comp,   @w_comprobante,    @w_empresa,
    0,                   cuenta,            @w_oficina,
    area,                credito,           debito,
    CASE WHEN ente > 0 THEN 'Ente: ' + convert(VARCHAR,ente) + ' ' + tdocumento + ': ' + documento  + '. '+ @w_descripcion
    ELSE @w_descripcion END,
    credito_me,        debito_me,
    0,                   'N',               case when moneda = 0 then 'N' else 'C' end,
    'N' ,                moneda,            NULL,
    NULL,                NULL,              NULL,
    @w_oficina,          NULL,              ente,
    documento,           tdocumento
    from #saldos_cierre
    WHERE oficina = @w_oficina

    if @@error <> 0 begin
        rollback tran
        set rowcount 0
        insert into cob_conta..cb_errores
        VALUES('sp_finpe_mx','INSERTANDO CB_ASIENTO','oficina',CONVERT(VARCHAR(50),@w_oficina),getdate())
        goto SIGUIENTE
    end
PRINT '1'
--SELECT 'tabla ASIENTO 1', * FROM #asiento

    /* INGRESANDO ASIENTO DE CONTRAPARTIDA PARA CUADRAR EL COMPROBANTE  */
    insert into #asiento (
    as_fecha_tran,       as_comprobante,    as_empresa,
    as_asiento,          as_cuenta,         as_oficina_dest,
    as_area_dest,        as_credito,        as_debito,
    as_concepto,         as_credito_me,     as_debito_me,
    as_cotizacion,       as_mayorizado,     as_tipo_doc,
    as_tipo_tran,        as_moneda,         as_opcion,
    as_fecha_est,        as_detalle,        as_consolidado,
    as_oficina_orig,     as_mes_fecha_tran, ente,
    doc,                 tdoc )
    select
    @w_fecha_ing_comp,   @w_comprobante,    @w_empresa,
    0,                   ctr_cuenta,        ctr_oficina,
    area,
    CASE WHEN sum (debito-credito) > 0 THEN sum (debito-credito) ELSE 0 end,
    CASE WHEN sum (debito-credito) < 0 THEN sum (credito-debito) ELSE 0 end,
    @w_descripcion,
    CASE WHEN sum (debito_me-credito_me) > 0 THEN sum (debito_me-credito_me) ELSE 0 end,
    CASE WHEN sum (debito_me-credito_me) < 0 THEN sum (credito_me-debito_me) ELSE 0 end,
    0,                   'N',               case when moneda = 0 then 'N' else 'C' end,
    'N' ,                moneda,            NULL,
    NULL,                NULL,              NULL,
    @w_oficina,          NULL,              0,
    '',                  ''
    from #saldos_cierre
    WHERE oficina = @w_oficina
    GROUP BY ctr_cuenta, ctr_oficina, area, moneda

    if @@error <> 0 begin
        rollback tran
        set rowcount 0
        insert into cob_conta..cb_errores
        VALUES('sp_finpe_mx','INSERTANDO CB_ASIENTO contra','oficina',CONVERT(VARCHAR(50),@w_oficina),getdate())
        goto SIGUIENTE
    END


	-- VALIDO SI EXISTE UN COMPROBANTE DE CIERRA YA INGRESADO
	-- ESTO OCURRE SOLO CUANDO LAS FECHAS DE INGRESO Y CIERRE
	-- SON DIFERENTES, CASO CONTRARIO LOS DATOS YA VIENEN DESDE EL PRINCIPIO
	if @w_simulacion = 'N'
    begin
       IF EXISTS(SELECT 1 FROM cob_conta..cb_comprobante
                 WHERE co_empresa    = @w_empresa
    	         AND co_fecha_tran   = @w_fecha_ing_comp
    		     AND co_oficina_orig = @w_oficina
    		     AND co_automatico   = @w_proceso_cierre
    		     AND co_reversado    <> 'S')
    	   AND  @w_fecha_fin_per <> @w_fecha_ing_comp
   	   BEGIN
	      -- BUSCA EL ULTIMO COMPROBANTE INGRESADO DE LA OFICINA EN CURSO
          SELECT
          @w_ant_comprobante = max(co_comprobante)
   		  FROM cob_conta..cb_comprobante
		  WHERE co_empresa    = @w_empresa
		  AND co_fecha_tran   = @w_fecha_ing_comp
		  AND co_oficina_orig = @w_oficina
		  AND co_automatico   = @w_proceso_cierre
          /****************
   		  SELECT
   		  @w_estado = co_estado
   		  FROM cob_conta..cb_comprobante
		  WHERE co_empresa    = @w_empresa
		  AND co_fecha_tran   = @w_fecha_ing_comp
		  AND co_oficina_orig = @w_oficina
		  AND co_automatico   = @w_proceso_cierre
		  AND co_comprobante  = @w_ant_comprobante
          ***************/
         
         
    	  TRUNCATE TABLE #asiento_ant

    	  -- RECUPERO LOS ASIENTOS ANTERIORES
    	  INSERT INTO #asiento_ant
    	  SELECT
		  as_fecha_tran,   @w_comprobante,    as_empresa,
  	      0,               as_cuenta,         as_oficina_dest,
--		  as_area_dest,    as_credito,        as_debito,
--		  as_concepto,     as_credito_me,     as_debito_me,
		  as_area_dest,    as_debito,         as_credito,    -- coloco los valores reversados
		  as_concepto,     as_debito_me,      as_credito_me, -- coloco los valores reversados
		  as_cotizacion,   as_mayorizado,     as_tipo_doc,
		  as_tipo_tran,    as_moneda,         as_opcion,
		  as_fecha_est,    as_detalle,        as_consolidado,
		  as_oficina_orig, as_mes_fecha_tran, as_concepto_adi,
    	  0, '', ''
    	  FROM cob_conta..cb_asiento
    	  WHERE as_empresa    = @w_empresa
    	  AND as_comprobante  = @w_ant_comprobante
--    	  AND as_oficina_dest = @w_oficina
    	  AND as_fecha_tran   = @w_fecha_ing_comp

    	  -- RECUPERAR LOS ENTES
    	  UPDATE #asiento_ant SET
    		ente = re_ente,
    		doc  = re_identifica,
    		tdoc = re_tipo
    	  FROM cob_conta..cb_retencion
    	  WHERE as_empresa    = re_empresa
    	  AND as_comprobante  = re_comprobante
    	  AND as_asiento      = re_asiento
		  AND re_fecha        = @w_fecha_ing_comp

             
--SELECT 'RECUPERO ASIENTO ANTE', * FROM  #asiento_ant

		  -- UNO LOS ASIENTOS ANTERIORES + LOS NUEVOS
    	  INSERT INTO #asiento_ant
    	  SELECT * FROM #asiento
          
    	  -- BORRO LOS DATOS DE LA TABLA PARA AQUI CONSOLIDAR NUEVAMENTE
    	  TRUNCATE TABLE #asiento  
  
          -- CONSOLIDO NUEVAMENTE
	      insert into #asiento(
	      as_fecha_tran,       as_comprobante,    as_empresa,
	      as_asiento,          as_cuenta,         as_oficina_dest,
	      as_area_dest,        as_concepto,
  
          as_credito,
	      as_debito,
	      as_credito_me,
	      as_debito_me,
   
          as_cotizacion,       as_mayorizado,     as_tipo_doc,
	      as_tipo_tran,        as_moneda,         as_opcion,
	      as_fecha_est,        as_detalle,        as_consolidado,
	      as_oficina_orig,     as_mes_fecha_tran, ente,
	      doc,                 tdoc)
	      SELECT
	      @w_fecha_ing_comp,   @w_comprobante,    @w_empresa,
	      0,                   as_cuenta,         as_oficina_dest,
	      as_area_dest,        as_concepto,

	      'as_credito'    = case when sum(as_debito - as_credito)       > 0 then 0     else abs(sum(as_debito - as_credito))       end,
	      'as_debito'     = case when sum(as_debito - as_credito)       > 0 then abs(sum(as_debito - as_credito))           else 0 end,
	      'as_credito_me' = case when sum(as_debito_me - as_credito_me) > 0 then 0     else abs(sum(as_debito_me - as_credito_me)) end,
	      'as_debito_me'  = case when sum(as_debito_me - as_credito_me) > 0 then abs(sum(as_debito_me - as_credito_me))     else 0 end,

	      0,                   'N',               case when as_moneda = 0 then 'N' else 'C' end,
	      'N',                 as_moneda,         NULL,
	      null,                null,              null,
	      @w_oficina ,         NULL, ente,
	      doc,                 tdoc
    	  FROM #asiento_ant
    	  GROUP BY as_cuenta, as_oficina_dest, as_area_dest, as_moneda, as_concepto, ente, doc, tdoc
    	  HAVING (sum(as_debito - as_credito) > 0 OR sum(as_debito_me - as_credito_me)> 0)
   	  END
    end
   	-- del if si existe comprobante en las mismas fechas de ingreso y cierre

    -- NUMERO LOS ASIENTOS
    SELECT @w_contador = 0

    UPDATE #asiento SET
    as_asiento = @w_contador,
    @w_contador = @w_contador +1
PRINT '5'
--SELECT 'tabla ASIENTO + SECUENCIAL + ANTERIOR', * FROM #asiento

    select
    @w_tot_deb_mn = sum(as_debito),
    @w_tot_cre_mn = sum(as_credito),
    @w_tot_deb_me = sum(as_debito_me),
    @w_tot_cre_me = sum(as_credito_me),
    @w_tot_area   = max(as_area_dest),
    @w_detalles = count(1)
    from #asiento

    IF @w_detalles = 0 GOTO SIGUIENTE


    IF @@TRANCOUNT = 0 BEGIN
       SELECT @w_commit = 'S'
       BEGIN TRAN
    end
    
    if @w_simulacion = 'N'
    begin
       insert into cob_conta..cb_comprobante values(
       @w_comprobante,               @w_empresa,               @w_fecha_ing_comp,
       @w_oficina,                   @w_tot_area,              @w_fecha_proceso,
       @w_fecha_proceso,             'USR_BATCH',              @w_descripcion,
       'N',                          NULL,                     @w_detalles,
       @w_tot_deb_mn,                @w_tot_cre_mn,            @w_tot_deb_me,
       @w_tot_cre_me,                @w_proceso_cierre,        'N',
       'S',                          'sa',                     NULL,
       NULL,                         NULL,                     NULL,
       'N',                          NULL)
       
       if @@error <> 0 begin
          IF @w_commit = 'S' BEGIN rollback tran SELECT @w_commit = 'N' end
          set rowcount 0
          insert into cob_conta..cb_errores
          VALUES('sp_finpe_mx','INSERTANDO CB_COMPROBANTE','oficina',CONVERT(VARCHAR(50),@w_oficina),getdate())
          goto SIGUIENTE
       end
       PRINT '7'
       
       INSERT INTO cb_asiento
       SELECT
       as_fecha_tran, as_comprobante, as_empresa,
       as_asiento, as_cuenta, as_oficina_dest,
       as_area_dest, as_credito, as_debito,
       as_concepto, as_credito_me, as_debito_me,
       as_cotizacion, as_mayorizado, as_tipo_doc,
       as_tipo_tran, as_moneda, as_opcion,
       as_fecha_est, as_detalle, as_consolidado,
       as_oficina_orig, as_mes_fecha_tran, as_concepto_adi
       FROM #asiento
       
       PRINT '8'   
       insert into cob_conta..cb_retencion (
       re_comprobante,         re_empresa,             re_asiento,
       re_identifica,          re_tipo,                re_ente,
       re_fecha,               re_cuenta,              re_concepto,
       re_base,                re_valret,              re_valor_asiento,
       re_valor_iva,           re_valor_ica,           re_iva_retenido,
       re_con_iva,             re_con_iva_reten,       re_con_timbre,
       re_valor_timbre,        re_retencion_calculado, re_iva_calculado,
       re_ica_calculado,       re_timbre_calculado,    re_codigo_regimen,
       re_con_ica,             re_con_ivapagado,       re_valor_ivapagado,
       re_ivapagado_calculado, re_documento,           re_oficina_orig,
       re_con_dptales,         re_valor_dptales)
       select
       @w_comprobante,     @w_empresa,     as_asiento,
       doc,                tdoc,           ente,
       @w_fecha_ing_comp,  as_cuenta,      '9999',
       0,                  0,              0,              NULL,
       NULL,               NULL,           NULL,           NULL,
       0,                  NULL,           NULL,           NULL,
       NULL,               NULL,           NULL,           NULL,
       NULL,               NULL,           NULL,           '.',
       @w_oficina,         NULL,           NULL
       from #asiento
       where isnull(ente, 0) > 0
       
       if @@error <> 0 begin
          IF @w_commit = 'S' BEGIN rollback tran SELECT @w_commit = 'N' end
          set rowcount 0
          insert into cob_conta..cb_errores
          VALUES('sp_finpe_mx','INSERTANDO CB_RETENCION','oficina',CONVERT(VARCHAR(50),@w_oficina),getdate())
          goto SIGUIENTE
       end    
    end
    else
    begin
        insert into cob_conta..cb_comprobante_simulacion values(
       @w_comprobante,               @w_empresa,               @w_fecha_ing_comp,
       @w_oficina,                   @w_tot_area,              @w_fecha_proceso,
       @w_fecha_proceso,             'USR_BATCH',              @w_descripcion,
       'N',                          NULL,                     @w_detalles,
       @w_tot_deb_mn,                @w_tot_cre_mn,            @w_tot_deb_me,
       @w_tot_cre_me,                @w_proceso_cierre,        'N',
       'S',                          'sa',                     NULL,
       NULL,                         NULL,                     NULL,
       'N',                          NULL)
       
       if @@error <> 0 begin
          IF @w_commit = 'S' BEGIN rollback tran SELECT @w_commit = 'N' end
          set rowcount 0
          insert into cob_conta..cb_errores
          VALUES('sp_finpe_mx','INSERTANDO CB_COMPROBANTE','oficina',CONVERT(VARCHAR(50),@w_oficina),getdate())
          goto SIGUIENTE
       end
       PRINT '7'
       
       INSERT INTO cb_asiento_simulacion
       SELECT
       as_fecha_tran, as_comprobante, as_empresa,
       as_asiento, as_cuenta, as_oficina_dest,
       as_area_dest, as_credito, as_debito,
       as_concepto, as_credito_me, as_debito_me,
       as_cotizacion, as_mayorizado, as_tipo_doc,
       as_tipo_tran, as_moneda, as_opcion,
       as_fecha_est, as_detalle, as_consolidado,
       as_oficina_orig, as_mes_fecha_tran, as_concepto_adi
       FROM #asiento
       
       PRINT '8'   
       insert into cob_conta..cb_retencion_simulacion (
       re_comprobante,         re_empresa,             re_asiento,
       re_identifica,          re_tipo,                re_ente,
       re_fecha,               re_cuenta,              re_concepto,
       re_base,                re_valret,              re_valor_asiento,
       re_valor_iva,           re_valor_ica,           re_iva_retenido,
       re_con_iva,             re_con_iva_reten,       re_con_timbre,
       re_valor_timbre,        re_retencion_calculado, re_iva_calculado,
       re_ica_calculado,       re_timbre_calculado,    re_codigo_regimen,
       re_con_ica,             re_con_ivapagado,       re_valor_ivapagado,
       re_ivapagado_calculado, re_documento,           re_oficina_orig,
       re_con_dptales,         re_valor_dptales)
       select
       @w_comprobante,     @w_empresa,     as_asiento,
       doc,                tdoc,           ente,
       @w_fecha_ing_comp,  as_cuenta,      '9999',
       0,                  0,              0,              NULL,
       NULL,               NULL,           NULL,           NULL,
       0,                  NULL,           NULL,           NULL,
       NULL,               NULL,           NULL,           NULL,
       NULL,               NULL,           NULL,           '.',
       @w_oficina,         NULL,           NULL
       from #asiento
       where isnull(ente, 0) > 0
       
       if @@error <> 0 begin
          IF @w_commit = 'S' BEGIN rollback tran SELECT @w_commit = 'N' end
          set rowcount 0
          insert into cob_conta..cb_errores
          VALUES('sp_finpe_mx','INSERTANDO CB_RETENCION','oficina',CONVERT(VARCHAR(50),@w_oficina),getdate())
          goto SIGUIENTE
       end
    end 
   
    	
    
    PRINT '9'
    IF @w_commit = 'S' BEGIN
       SELECT @w_commit = 'N'
       commit TRAN
    end


   SIGUIENTE:

end

if @w_simulacion = 'N'
begin
   print 'SIMULACION N'
   --MAYORIZACION 
   EXEC @w_error = sp_ejec_maysi
   @i_param1    = @w_empresa,
   @i_param2    = @w_fecha_proceso
   
   IF @w_error <> 0 BEGIN
      SELECT
      @w_msg   = 'MAYORIZACION CONTA',
      @w_campo = 'return',
      @w_dato  =  convert(VARCHAR, @w_error),
      @w_error = 601309
      GOTO ERROR_FIN
   END
   
   -- PASO A DEFINITIVO DE AUXILIARES 
   EXEC @w_error = sp_cb_tterc_ej
   @i_param1  = @w_empresa
   
   IF @w_error <> 0 BEGIN
      SELECT
      @w_msg   = 'PASO A DEFINITIVO DE AUXILIARES',
      @w_campo = 'return',
      @w_dato  =  convert(VARCHAR, @w_error),
      @w_error = 601308
      GOTO ERROR_FIN
   END
   
   -- MAYORIZACION DE TERCEROS 
   EXEC @w_error = sp_maysiter
   @i_param1 = @w_empresa,
   @i_param2 = @w_fecha_proceso
   
   IF @w_error <> 0 BEGIN
      SELECT
      @w_msg   = 'MAYORIZACION TERCEROS',
      @w_campo = 'return',
      @w_dato  =  convert(VARCHAR, @w_error),
      @w_error = 601310
      GOTO ERROR_FIN
   END
end 
else
begin    
    select @w_query   = 'select * from cob_conta..cb_comprobante_simulacion'
    select @w_destino = @w_path + 'comprobante_simulacion.txt', 
           @w_errores = @w_path + 'comprobante_simulacion.err'  
       
    select @w_comando = 'bcp "' + @w_query + '" queryout "'    
    select @w_comando = @w_comando + @w_destino + '" -b5000 -c' + @w_s_app + 's_app.ini -T -e"' + @w_errores + '"'

    exec @w_error = xp_cmdshell @w_comando

    if @w_error <> 0 begin
      select @w_error = 70146
      goto ERROR_FIN
    end
   
    select @w_query   = 'select * from cob_conta..cb_asiento_simulacion'
    select @w_destino = @w_path + 'cb_asiento_simulacion.txt', 
           @w_errores = @w_path + 'cb_asiento_simulacion.err'  
       
    select @w_comando = 'bcp "' + @w_query + '" queryout "'    
    select @w_comando = @w_comando + @w_destino + '" -b5000 -c' + @w_s_app + 's_app.ini -T -e"' + @w_errores + '"'

    exec @w_error = xp_cmdshell @w_comando

    if @w_error <> 0 begin
      select @w_error = 70146
      goto ERROR_FIN
    end
    
    select @w_query   = 'select * from cob_conta..cb_retencion_simulacion'
    select @w_destino = @w_path + 'retencion_simulacion.txt', 
           @w_errores = @w_path + 'retencion_simulacion.err'  
       
    select @w_comando = 'bcp "' + @w_query + '" queryout "'    
    select @w_comando = @w_comando + @w_destino + '" -b5000 -c' + @w_s_app + 's_app.ini -T -e"' + @w_errores + '"'

    exec @w_error = xp_cmdshell @w_comando

    if @w_error <> 0 begin
      select @w_error = 70146
      goto ERROR_FIN
    end
   

end 
  
   

/* PONER COMO PROCESADA LA SOLICITUD DE REPORTE */
update cob_conta..cb_solicitud_reportes_reg
set   sr_status = 'P'
where sr_reporte = @w_proceso
and   sr_status = 'I'

return 0

ERROR_FIN:

IF @w_commit = 'S' BEGIN rollback tran SELECT @w_commit = 'N' end

insert into cob_conta..cb_errores
VALUES(@w_sp_name,  @w_msg, @w_campo, @w_dato, @w_fecha_proceso)

RETURN @w_error

GO

