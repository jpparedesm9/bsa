/************************************************************************/
/*   Archivo:             consolidador.sp                               */
/*   Stored procedure:    sp_consolidador                               */
/*   Base de datos:       cob_cartera                                   */
/*   Producto:            Cartera                                       */
/*   Disenado por:        Ricardo Reyes                                 */
/*   Fecha de escritura:  Abr.09.                                       */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                              PROPOSITO                               */
/*   Extraccion de datos para el consolidador ex_dato_operacion         */
/************************************************************************/
/*                               MODIFICACIONES                         */
/*  FECHA              AUTOR          CAMBIO                            */
/*  OCT-2010  Elcira Pelaez    Diferidos NR059                          */
/*  ENE-2012  Luis C. Moreno   RQ293-RECONOCIMIENTO GARANTIAS           */
/*  MAY-2013  Andres A. Munoz  RQ353-ALIANZAS COMERCIALES               */
/*  ABR-2014  Liana Coto       Req 425 -- FORMATO 507                   */
/*  JUN-2014  Luis Guzmann      Req. 394 - Venta Cartea Castigada       */
/*  JUL-2014  Luisa Bernal     RQ375-TRASLADO CARTERA_CUPOS             */
/*  ENE/2015  Liana Coto       REQ486 PASO REPOSITORIO                  */
/*                             DATOS TRASLADOS CLIENTES                 */
/*  DIC-2014  Oskar Orozco     Req. 472 - Nuevo Campo de mora           */
/*  DIC-2014  LIANA COTO       REQ479 FINAGRO                           */
/*  OCT-2016  JORGE SALAZAR    MIGRACION COBIS CLOUD                    */
/*  ABR-2017  TANIA BAIDAL     CL_ENTE_AUX POR CL_ENTE_ADICIONAL        */
/*  AGO-2017  SANDRA ECHEVERRI AJUSTE PARA PROVISIONES                  */
/*  SEP-2017  TANIA BAIDAL     SE MODIFICA ESTRUCTURA ex_dato_operacion */
/*  ENE-2018  LGU              MODIFICAR ESTRUCTURA ex_dato_operacion   */
/*                                              ex_dato_operacion_rubro */
/*                                                    ex_dato_cuota_pry */
/*  MAY/2019  LGU               Requerimiento #118535                   */
/*  MAY/2019  DCumbal           Requerimiento #110097                   */
/*  JUN/2019  DCumbal           Ajuste al requerimiento #110097         */
/*  Jul/2019  MDiaz             Requerimiento #117956                   */
/*  JUL/2019  PXSG              Requerimiento #115931                   */
/*  Jul/2019  MDias             Requerimiento #117956                   */
/*  Ago/2019  MTaco             Validar fecha de vencimiento nula       */
/*  Sep/2019  A.GONZALEZ        REQ 121717 ODS REVOLVENTE               */
/*  Sep/2019  A.GONZALEZ        Soporte #126655                         */
/*  Sep/2019  A.GONZALEZ        REQ 121717 Correcciones                 */
/*  Oct/2019  D. Cumbal         Revision errores 116513                 */
/*  Nov/2019  PXSG              REQ 129681 Cobranzas Mc Collect         */
/*  Ene/2020  MTA               Caso 131766, agregar campos al reporte  */
/*                              ODS Saldos cartera                      */
/* Feb/2020  A.GONZALEZ         Req. 123672 -TIMBRADOS, EJECUCION DE    */
/*                              HISTORICO SB_DATO_CUOTA_PRY DIA 9       */
/*  Ene/2020  AZU               Optimizacion                            */
/*  FEB/2020  AGO               HISTORICO                               */
/*  Mar/2020  MTA               Corregir mora negativa para la mora365  */
/*  Abr/2020  DCU               Caso: 138102                            */
/*  Abr/2020  DCU               Caso: 138744                            */
/*  May/2020  ACH               Caso: 139932                            */
/*  Jul/2020  ACH               Caso: 139932 - doble desplazamiento     */
/*  Jul/2020  ACH               Caso: 139932 dias_360 calcula d         */
/*  Ago/2020  DCU               Caso: 143874 Numero de integrantes      */
/*  Ago/2020  JSA               Caso: 144928 Optimizacion Batch         */
/*  Ago/2020  DCU               Caso: 145246 Calculo dias mora          */
/*  SEP/2020  JOHAN CASTRO      Caso: 142301 Coutas prestamo reporte    */
/*  ENE/2021  AGO               Req 147999   Renovaciones  Financiadas  */
/*  OCT/2021  DCU               Caso: 169559 Ajuste reporte banxico     */
/*  Dic/2021  ACH               R173628-Catálogos HRC simple, coment #27*/
/*  Ene/2022  KVI               E175325-Num.Cuotas,PlazoDias en Sol.Ind.*/
/*  Mar/2022  DBM               Req 172727 Actualizacion campos reporte */
/*  Jul/2022  DCU               Caso: 188641 Frecuencia Pago            */
/*  Dic/2022  ACH               Caso: 194284 DIA DE PAGO                */
/*  Ene/2023  DBM               Caso: 200081 CAMBIO DIA DE PAGO         */
/*  Jun/2023  KVI               Req.205892 Rpt Riesgo Ind nva evaluacion*/
/************************************************************************/ 


use cob_cartera
go
 
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

if exists (select 1 from sysobjects where name = 'sp_consolidador')
   drop proc sp_consolidador
go
---INC. 112734 MAY.06.2013
CREATE proc sp_consolidador
   
as declare
   @w_error                 int,
   @w_sp_name               varchar(64),
   @w_fecha_proceso         smalldatetime,
   @w_fecha_ini             smalldatetime,   
   @w_fecha_ven             smalldatetime,   
   @w_msg                   varchar(64),
   @w_rubro_int             char(3),
   @w_est_vigente           tinyint,
   @w_est_novigente         tinyint,
   @w_est_vencido           tinyint,
   @w_est_cancelado         tinyint,
   @w_est_suspenso          tinyint,
   @w_est_castigado         tinyint,
   @w_est_diferido          tinyint,
   @w_fecha_fm              datetime,
   @w_ciudad                int,
   @w_sig_habil             datetime,
   @w_fin_mes               char(1),
   @w_dias_gracia_reest     tinyint,   --Nuevo Desarrollo Control de Cambio Reest
   @w_rubro_cap             catalogo,
   @w_concepto_rec_fng      varchar(30),
   @w_concepto_rec_usa      varchar(30),
   @w_cod_gar_esp           varchar(30),
   @w_cod_gar_fng           varchar(30),
   @w_cod_gar_usaid         varchar(30),
   @w_cto_int               catalogo,
   @w_cto_inttras           catalogo,
   @w_numdias               int, 
   @w_div_min_sig           int,
   @w_div_min_ex            int,
   @w_fecha_ven_ant         datetime,
   @w_fecha_ven_sig         datetime,
   @w_operacion             int,
   @w_num_div_cap 			int,
   @w_num_div_int 			int,
   @w_tdividendo			char(1),
   @w_factor				int,
   @w_mod_pago				int,
   @w_prod_bancario         int,
   @w_num_ciclo_ant         int,
   @w_grupo_act             int,
   @w_return                int,
   @w_resultado             int,
   @w_codigo_act_apr        int,
   @w_codigo_act_cuest      int,
   @w_dias_atraso           int,   
   @w_operaciones_aux       int,
   @w_ciclo_actual          int,
   @w_dias_atr_cic_ant      int ,
   @w_grupo_aux             int,
   @w_fecha_encuestas       datetime,
   @w_ciudad_nacional       int,
   @w_fecha_6_meses         datetime,
   @w_fecha_3_meses         datetime,
   @w_fecha_vencimiento     datetime,
   @w_fecha_prox_vto        datetime,
   @w_banco                 cuenta,
   @w_fant_consol           DATETIME,
   @w_fp_objetado           VARCHAR(32),
   @w_est_anulado           int,
   @w_est_condonado         int,
   @w_est_credito           int,
   @w_fecha_ini_desp        datetime,
   @w_ant_habil             datetime,
   @w_fecha_primer_desplaz  datetime,
   @w_act_dias_antes_dsp    char(1),
   @w_coutas                int,
   @w_est_etapa2            int

   
set ansi_warnings off

/*Para quitar un dÃ­a al primer dezplamiento que se realizo en el mes de abril*/
select @w_fecha_primer_desplaz = '04/30/2020' -- Por que la fecha del primer desplazamiento se quita un 1 para conservar como estaba antes
select @w_act_dias_antes_dsp = pa_char from cobis..cl_parametro where pa_producto = 'CCA' AND pa_nemonico = 'AN31DS'--Activar el calculo de 3 dias menos para el primer desplazamiento Activar = S, desactivar N. Caso #139932
																														  
/* CARGADO DE VARIABLES DE TRABAJO */
select 
@w_sp_name            = 'sp_consolidador',
@w_fin_mes            = 'N',
@w_operacion          = 0
/*DETERMINAR LA FECHA DE PROCESO */
select 
@w_fecha_proceso = fc_fecha_cierre,
@w_fecha_ini     = dateadd(dd,1-datepart(dd,fc_fecha_cierre), fc_fecha_cierre)
from cobis..ba_fecha_cierre
where fc_producto = 7

/*PARA FECHA DEPLAZAMIENTO*/
select @w_fecha_ini_desp = '01/01/1900'

-- CONCEPTOS DE INTERES
select @w_cto_int = 'INT',
       @w_cto_inttras = 'INTTRAS'

select @w_cto_int = pa_char
from cobis..cl_parametro with (nolock)
where pa_producto = 'CCA'
and   pa_nemonico = 'INT'

select @w_cto_inttras = pa_char
from cobis..cl_parametro with (nolock)
where pa_producto = 'CCA'
and   pa_nemonico = 'TRASIN'

-- Codigo padre para garantias colaterales
select @w_cod_gar_esp = pa_char
from cobis..cl_parametro with (nolock)
where pa_producto = 'GAR'
and   pa_nemonico = 'GARESP'

---parametro para el cargue de los reconocimientos
select @w_cod_gar_fng = pa_char
from cobis..cl_parametro with (nolock)
where pa_producto  = 'GAR'
and   pa_nemonico  = 'CODFNG'

select @w_cod_gar_usaid = pa_char
from cobis..cl_parametro with (nolock)
where pa_producto = 'GAR'
and pa_nemonico = 'CODUSA'


select tc_tipo as tipo_sub 
into #colaterales
from cob_custodia..cu_tipo_custodia with (nolock)
where tc_tipo_superior = @w_cod_gar_esp
and   tc_tipo in (@w_cod_gar_fng,@w_cod_gar_usaid)

select @w_concepto_rec_fng = pa_char
from   cobis..cl_parametro with (nolock)
where  pa_producto = 'CCA'
and    pa_nemonico = 'RECFNG'

select @w_concepto_rec_usa = pa_char
from   cobis..cl_parametro with (nolock)
where  pa_producto = 'CCA'
and    pa_nemonico = 'RECUSA'

/* CIUDAD DE FERIADOS */
select @w_ciudad = pa_int
from cobis..cl_parametro with (nolock)
where pa_nemonico = 'CIUN'
and   pa_producto = 'ADM'

/*CODIGO ACTIVIDAD APROBACION SOLICITUDES*/
select @w_codigo_act_apr = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_producto = 'CCA'
and    pa_nemonico = 'CAAPSO'


/*CODIGO ACTIVIDAD CUESTIONARIOS*/
select @w_codigo_act_cuest = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_producto = 'CCA'
and    pa_nemonico = 'CAAPCU'

select @w_fecha_fm = '01/01/1900'

/* PARAMETRO GENERAL INTERES */
select @w_rubro_int = pa_char
from cobis..cl_parametro with (nolock)
where pa_producto = 'CCA'
and   pa_nemonico = 'INT'

if @@rowcount = 0 begin
   select 
   @w_error = 724504, 
   @w_msg   = 'NO EXISTE EL PARAMETRO GENERAL "INT" PARA CARTERA'
   goto ERROR
end

select @w_rubro_cap = pa_char
from   cobis..cl_parametro with (nolock)
where  pa_producto = 'CCA'
and    pa_nemonico = 'CAP'

if @@rowcount = 0 begin
   select 
   @w_error = 710076, 
   @w_msg   = 'NO EXISTE EL PARAMETRO GENERAL "CAP" PARA CARTERA'
   goto ERROR
end




/* DETERMINAR SI HOY ES EL ULTIMO HABIL DEL MES */
select @w_sig_habil = dateadd(dd, 1, @w_fecha_proceso)

while exists (select 1
                  from cobis..cl_dias_feriados with (nolock)
                  where df_fecha = @w_sig_habil
                  and   df_ciudad = @w_ciudad)
begin
   select @w_sig_habil = dateadd(dd, 1, @w_sig_habil)
end

if datepart(mm, @w_sig_habil) <> datepart(mm, @w_fecha_proceso)
   select @w_fin_mes = 'S'
   

   
/* PARAMETRO GENERAL PARA DIAS DE REESTRUCTURACION */
select @w_dias_gracia_reest = pa_tinyint
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'DIASGR'
and    pa_producto = 'CRE'

if @w_dias_gracia_reest is null 
   select @w_dias_gracia_reest = 10

/* ENTRAR BORRANDO TODA LA INFORMACION GENERADA POR CARTERA EN COB_EXTERNOS */

--optimizacion, dado que actualmente solo existe Cartera
truncate table  cob_externos..ex_dato_operacion
truncate table  cob_externos..ex_dato_transaccion
truncate table  cob_externos..ex_dato_transaccion_det
truncate table cob_externos..ex_dato_operacion_rubro
   
delete cob_externos..ex_dato_deudores
where de_aplicativo = 7
     
delete cob_externos..ex_dato_nomina_peoplenet

delete cob_externos..ex_dato_nomina_peoplenet_cifras

delete cob_externos..ex_desmarca_fng_his
where df_aplicativo = 7

delete cob_externos..ex_pago_recono
where pr_aplicativo = 7

delete cob_externos..ex_condonacion
where co_aplicativo = 7

delete cob_externos..ex_op_reest_padre_hija
where ph_aplicativo = 7

delete cob_externos..ex_dato_reajuste
where dr_aplicativo = 7

delete cob_externos..ex_msv_proc_ca
where mp_aplicativo = 7

delete from cob_externos..ex_datos_lcr
where dl_aplicativo = 7 

delete from cob_externos..ex_cuota_minima
where cm_aplicativo = 7

truncate table cob_externos..ex_dato_verificacion 

--OPTIMIZACION. Se cambia el delete por truncate table. se debe volver a la opcion de delete cuando se optimice la 
--cantidad de registros que viajan en las tablas de seguros.
--delete cob_externos..ex_dato_seguros
--where se_aplicativo = 7

truncate table cob_externos..ex_dato_seguros

--CCA 394
delete cob_externos..ex_venta_universo
where vu_aplicativo = 7

--req 375 TRASLADO CARTERA CANCELADA
delete cob_externos..ex_cartera_trasladada_canc  
where et_aplicativo = 7

--REQ479 FINAGRO
delete from cob_externos..ex_val_oper_finagro
where vo_aplicativo = 7

--NORMALIZACION
delete cob_externos..ex_normalizacion
where en_aplicativo = 7

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
@o_est_credito    = @w_est_credito   out,
@o_est_etapa2     = @w_est_etapa2    out

if @w_error <> 0 goto ERROR

/* CARGA DE OPERACIONES ACTIVAS */
select    
cop_fecha              =  @w_fecha_proceso,
cop_operacion          =  op_operacion,   
cop_banco              =  convert(varchar(24),op_banco),             
cop_toperacion         =  convert(varchar(10),op_toperacion),  
cop_aplicativo         =  convert(tinyint,7),           
cop_destino            =  convert(varchar(10),op_destino),                   
cop_clase              =  convert(varchar,op_clase),                    
cop_cliente            =  op_cliente,  
cop_documento_tipo     =  convert(varchar,null),
cop_documento_nume     =  convert(varchar,null),              
cop_oficina            =  convert(int,op_oficina),                
cop_moneda             =  op_moneda,                  
cop_monto              =  op_monto,  
cop_tasa               =  convert(float,0),
cop_modalidad          =  convert(char(1),'V'),
cop_tplazo             =  op_tplazo,
cop_plazo_dias         =  case when op_toperacion = 'INDIVIDUAL' and op_tplazo = 'W' and  op_periodo_int= 2 and op_periodo_cap = 2 then convert(int,op_plazo * (((select td_factor from cob_cartera..ca_tdividendo where td_tdividendo = op_tplazo) * op_periodo_int))) --E175325
                          else convert(int,op_plazo * (select td_factor from cob_cartera..ca_tdividendo where td_tdividendo = op_tplazo)) end,
cop_fecha_liq          =  op_fecha_liq,               
cop_fecha_fin          =  op_fecha_fin,  
cop_edad_mora          =  0,             
cop_reestructuracion   =  convert(char(1),case when isnull(op_numero_reest,0) > 0 then 'S'          else 'N'  end), 
cop_fecha_reest        =  case when isnull(op_numero_reest,0) > 0 then op_fecha_ini else null end,
cop_natur_reest        =  convert(varchar,null),
cop_num_reest          =  convert(tinyint,isnull(op_numero_reest,0)), 
cop_num_renovacion     =  convert(int,isnull(op_num_renovacion,0)),
cop_estado             =  op_estado, --case op_estado when 3 then 4 when 4 then 3 else 1 end,   
cop_cupo_credito       =  convert(varchar,op_lin_credito),
cop_num_cuotas         =  case when op_tipo_amortizacion = 'ROTATIVA' then (select max(di_dividendo) from ca_dividendo with (nolock) where di_operacion = op_operacion) -- se cambia el calculo por el caso #139932, para operaciones revolventes las cuotas pendientes muestran valores negativos
                               when op_toperacion = 'INDIVIDUAL' then op_plazo --E175325
                          else convert(int,op_plazo * (select td_factor from ca_tdividendo where td_tdividendo = op_tplazo)/  ( op_periodo_int * (select td_factor from ca_tdividendo where td_tdividendo = op_tdividendo))) end,
cop_per_cuotas         =  (op_periodo_int )* (select td_factor from ca_tdividendo where td_tdividendo = op_tdividendo),
cop_val_cuota          =  op_cuota,
cop_cuotas_pag         =  convert(smallint,0),
cop_cuotas_ven         =  convert(smallint,0),
cop_saldo_ven          =  convert(money,0),
cop_fecha_prox_vto     =  convert(datetime, null),
cop_fecha_ult_pago     =  convert(datetime,null),
cop_valor_ult_pago     =  convert(money,0),
cop_fecha_castigo      =  convert(datetime,case when op_estado = @w_est_castigado then '10/14/2008' else null end),
cop_num_acta           =  convert(varchar,null),
cop_clausula           =  isnull(op_clausula_aplicada,'N'),
cop_oficial            =  op_oficial,
cop_naturaleza         =  case when op_naturaleza = 'A' and op_tipo <> 'G' then '1' 
                               when op_naturaleza = 'A' and op_tipo =  'G' then '3'
                               else '2'
                          end,
cop_fuente_recurso     = op_origen_fondos,
cop_categoria_producto =  '1',
cop_valor_vencido      =  convert(money, 0),
cop_tipo_garantias     =  case when isnull(op_gar_admisible,'N') = 'N' then 'O' else 'E' end,
cop_op_anterior        =  op_anterior,
cop_edad_cod           =  convert(tinyint, 0),
cop_num_cuotas_reest   =  convert(tinyint, 0),
cop_tramite            =  op_tramite,
/* INI - GAL 01/AGO/2010 - OMC */
cop_nota_int              =  convert(tinyint, null),
cop_fecha_ini_mora        =  convert(datetime, null),
cop_gracia_mora           =  convert(smallint, null),
cop_estado_cobranza       =  op_estado_cobranza,
cop_tasa_mora             =  convert(float, null),
cop_tasa_com              =  convert(float, null),
/* FIN - GAL 01/AGO/2010 - OMC */
cop_entidad_convenio      = op_entidad_convenio,
cop_fecha_cambio_linea    = @w_fecha_proceso,
cop_valor_nominal         = 0.00,
cop_emision               = ' ',
cop_sujcred               = (select tr_sujcred from cob_credito..cr_tramite with (nolock)
                            where tr_numero_op = op_operacion 
                            and tr_tramite = (select max(tr_tramite) from cob_credito..cr_tramite with (nolock)
                                              where tr_numero_op = op_operacion) 
                            and tr_fecha_apr is not null ),
cop_cap_vencido           = convert(money, 0),
/*Req 378 12/08/2013*/
cop_valor_proxima_cuota   = convert(money,0),
cop_saldo_total_Vencido   = convert(money,0),
cop_saldo_otr             = convert(money,0),
cop_saldo_cap_total       = convert(money,0),
cop_regional              = convert(varchar,null),
cop_edad_mora_365         = convert(int,0), --OMOG Req. 472. 03/DIC/2014
cop_normalizado           = convert(char,null),
cop_tipo_norm             = convert(tinyint,null),
cop_frec_pagos_cap        = 0,
cop_frec_pagos_int        = 0,
cop_fec_pri_amort_cubierta= null,
cop_monto_condo           = null,
cop_fecha_condo           = null,
cop_monto_castigo         = null,
cop_inte_castigo          = null,
cop_monto_bonifica        = null,
cop_inte_refina           = null,
cop_emproblemado          = convert(char,null),
cop_mod_pago              = null,
cop_sector                = op_sector,
cop_subtipo_linea         = op_subtipo_linea,
cop_cociente_pago         = convert(float, 1),
cop_numero_ciclos         = convert(int, null),
cop_grupo                 = convert(int, null),
cop_numero_integrantes    = convert(int, null),
-- LGU-2018-01-25
/* CAMPOS NUEVOS PARA EL ESTADO DE CUENTA */
cop_valor_cat             = op_valor_cat,
cop_gar_liq_orig          = convert(money, null),
cop_gar_liq_fpago         = convert(datetime, null),
cop_gar_liq_dev           = convert(money, null),
cop_gar_liq_fdev          = convert(datetime, null),
cop_cuota_capital         = convert(money, null),
cop_cuota_int             = convert(money, null),
cop_cuota_iva             = convert(money, null),
cop_fecha_suspenso        = op_fecha_suspenso,
cop_cuenta                = op_cuenta,
cop_tdividendo            = op_tdividendo,
cop_vencimiento_div       = convert(int, 0),
cop_plazo                 = convert(varchar(64),''),
cop_subtipo_producto      = convert(varchar(64),''),
cop_atraso_grupal         = convert(int, 0),
cop_fecha_dividendo_ven   = convert(datetime, null),
cop_fecha_apr_tramite     = op_fecha_ini,
cop_cuota_min_vencida     = convert(money, null),
cop_fecha_proceso         = op_fecha_ult_proceso,
cop_subproducto_cuenta    = convert(varchar(10) ,null),
cop_cuota_max_vencida     = convert(money         ,null),
cop_atraso_gr_ant         = convert(int         ,0),
cop_ciclo_actual          = convert(int         ,0),
cop_monto_aprobado        = op_monto_aprobado,
cop_tipo_amortizacion	  = op_tipo_amortizacion,
cop_fecha_ult_vto         = convert(datetime, null),
cop_cuota_ult_vto         = convert(int, null),
cop_cupo_original         = op_monto_aprobado,
cop_importe_ult_vto       = convert(money, null),
cop_importe_pri_vto       = convert(money, null),
cop_fecha_pri_vto         = convert(datetime, null),
cop_banco_padre           = convert(varchar(24),null),
cop_fecha_ven_orig        = convert(datetime, null),
cop_fecha_can_ant         = convert(datetime, null),
cop_fecha_ini_desp        = convert(datetime, null),
cop_fecha_fin_desp        = convert(datetime, null),
cop_cuota_int_esp         = convert(money,null),
cop_cuota_iva_esp         = convert(money,null),
cop_dias_desplazamiento   = 0,
cop_archivo_desp          = convert(varchar(50) ,null),
cop_renovacion_grupal     = convert(int , 0),
cop_renovacion_ind        = op_num_renovacion,
cop_meses_primer_op       = convert(int,null),
cop_periodicidad          = op_periodo_int,
cop_dia_pago              = convert(varchar(20),null)
into #operaciones
from ca_operacion , ca_estado with (nolock)
where op_estado   = es_codigo
and  (es_procesa  = 'S' 
      --> OPERACIONES CANCELADAS DURANTE EL MES DE PROCESO
      or (op_estado=@w_est_cancelado and op_fecha_ult_proceso between @w_fecha_ini and @w_fecha_proceso)     
      
      --> OPERACIONES CANCELADAS DURANTE EL MES DE PROCESO CON FECHA VALOR A MESES ANTERIORES)
      or (op_estado=@w_est_cancelado and op_fecha_ult_proceso < @w_fecha_ini and op_fecha_ult_mov between @w_fecha_ini and @w_fecha_proceso)
      -- OPERACIONES REVOLVENTES QUE AUN NO TERMINAN O TERMINARON EN EL MES DE PROCESO
      or (op_tipo_amortizacion = 'ROTATIVA' and op_fecha_fin >= @w_fecha_ini) 
     )  

--AZU	     
--create CLUSTERED index idx1 on #operaciones(cop_operacion,cop_toperacion)
create index idx1 on #operaciones(cop_operacion,cop_toperacion)

create index idx2 on #operaciones(cop_banco)

--Eliminacion 

delete #operaciones
where cop_tipo_amortizacion = 'ROTATIVA'
and   cop_estado in (@w_est_anulado, @w_est_condonado, @w_est_credito)

																																
--ACTUALIZACION DEL CAMPO OPERACION PADRE 

update #operaciones set 
cop_banco_padre = dc_referencia_grupal
from cob_cartera..ca_det_ciclo with (nolock)
where cop_operacion = dc_operacion
and   cop_toperacion = 'GRUPAL'


select or_referencia_grupal, tg_referencia_grupal, or_grupo
into #renovaciones_operaciones
from cob_credito..cr_op_renovar,
cob_credito..cr_tramite_grupal,
cob_cartera..ca_operacion,
cob_cartera..ca_estado
where or_operacion_original = tg_operacion
and op_operacion = tg_operacion
and op_estado = es_codigo
and (es_procesa = 'S' or  es_codigo = 3) 
group by or_referencia_grupal, tg_referencia_grupal,or_grupo


select or_referencia_grupal,  op_cliente
into #renovaciones_operaciones_cliente
from cob_credito..cr_op_renovar,
cob_credito..cr_tramite_grupal,
cob_cartera..ca_operacion,
cob_cartera..ca_estado
where or_operacion_original = tg_operacion
and op_operacion = tg_operacion
and op_estado = es_codigo
and (es_procesa = 'S' or  es_codigo = 3) 
group by or_referencia_grupal, op_cliente

select op_cliente, registros = count(1)
into #renova_cliente
from #renovaciones_operaciones_cliente
group by op_cliente

update #operaciones set
cop_renovacion_ind = registros
from #renova_cliente
where cop_cliente =  op_cliente

---CALCULO DEL CUPO ORIGINAL
select 
operacion  = ic_operacion, 
incremento = isnull(sum(ic_incremento) ,0)
into #cupo_orig 
from ca_incremento_cupo  with (nolock)
where ic_operacion in ( select cop_operacion from #operaciones where cop_tipo_amortizacion = 'ROTATIVA'  )
group by ic_operacion

--AZU
create index idx1 on #cupo_orig  (operacion)

update #operaciones set 
cop_cupo_original = cop_cupo_original-incremento
from #cupo_orig 
where cop_operacion = operacion

/****** DIA DE PAGO  ******/
select 
banco       = cop_banco , 
operacion   = cop_operacion,
vencimiento = min(di_fecha_ven), 
toperacion  = cop_toperacion,
dia_pago = 'XXXXXXXXXX'
into #dia_pago
from #operaciones, ca_dividendo with (nolock)
where cop_operacion = di_operacion
group by cop_banco, cop_operacion, cop_toperacion

select 
tc_banco       = cop_banco , 
tc_operacion   = cop_operacion,
tc_vencimiento = di_fecha_ven, 
tc_toperacion  = cop_toperacion,
tc_dia_pago = 'XXXXXXXXXX'
into #tabla_calculo_dia
from #operaciones, ca_dividendo with (nolock)
where cop_operacion = di_operacion

update #tabla_calculo_dia
set tc_dia_pago = case upper(datename(weekday, tc_vencimiento)) 
                                      when 'MONDAY'     then 'LUNES'  
                                      when 'TUESDAY'    then 'MARTES' 
                                      when 'WEDNESDAY'  then 'MIERCOLES' 
                                      when 'THURSDAY'   then 'JUEVES' 
                                      when 'FRIDAY'     then 'VIERNES' 
                                      when 'SATURDAY'   then 'SABADO'     
                                else 'DOMINGO'   end

select
dr_banco       = tc_banco , 
dr_operacion   = tc_operacion,
dr_dia_recurrente = tc_dia_pago,
dr_cantidad_dia = count(*),
dr_dia_mas_repetido = 0
into #dia_recurrente
from #tabla_calculo_dia
group by tc_banco, tc_operacion, tc_dia_pago;

SELECT
   dr_operacion,
   dr_dia_recurrente,
   dr_cantidad_dia,
   ROW_NUMBER() OVER(PARTITION BY dr_operacion ORDER BY dr_cantidad_dia DESC) AS row_number
into #added_row_number
FROM #dia_recurrente
GROUP BY dr_operacion,dr_dia_recurrente,dr_cantidad_dia



update #dia_recurrente
set dr_dia_mas_repetido = row_number
from #dia_recurrente a, #added_row_number b
where a.dr_operacion = b.dr_operacion
and a.dr_dia_recurrente = b.dr_dia_recurrente


update #dia_pago
set dia_pago = dr_dia_recurrente
from #dia_recurrente
where operacion = dr_operacion
and banco = dr_banco
and dr_dia_mas_repetido = 1


update #operaciones 
set cop_dia_pago = case when toperacion = 'REVOLVENTE' and cop_per_cuotas%7 = 0 
                                then 'MARTES' 
                                else (dia_pago) 
                     end 
from #dia_pago
where operacion   = cop_operacion

/****** DETERMINAR FECHA DE ULTIMO VENCIMIENTO  ******/
select 
banco       = cop_banco , 
operacion   = cop_operacion,
vencimiento = max(di_fecha_ven), 
cuota       = max(di_dividendo)
into #ult_vto
from #operaciones, ca_dividendo with (nolock)
where cop_operacion = di_operacion
and di_fecha_ven <= @w_fecha_proceso
group by cop_banco,cop_operacion

--AZU
create index idx1 on #ult_vto  (banco)
create index idx2 on #ult_vto  (operacion)

--SRO. Desplazamiento
select 
banco       = banco ,
operacion   = operacion , 
vencimiento = vencimiento, 
cuota       = cuota,
importe     = isnull(sum(am_cuota),0)
into #importe_amort
from #ult_vto , ca_amortizacion with (nolock)
where am_operacion = operacion 
and am_concepto in ( 'CAP', 'INT','IVA_INT', 'INT_ESPERA', 'IVA_ESPERA')
and am_dividendo = cuota 
group by banco, operacion,vencimiento,cuota

--AZU
create index idx1 on #importe_amort  (banco)
create index idx2 on #importe_amort  (operacion)

update #operaciones set 
cop_fecha_ult_vto   = vencimiento,
cop_cuota_ult_vto   = cuota,
cop_importe_ult_vto = importe
from #importe_amort
where cop_banco = banco

---CALCULAR IMPORTE DEL PRIMER VENCIMIENTO 

select 
operacion     = cop_operacion , 
fecha_pri_vto = di_fecha_ven,
importe       = isnull(sum(am_cuota),0)
into #importe_pri_vto
from #operaciones , ca_amortizacion,ca_dividendo with (nolock)
where am_operacion = cop_operacion
and  di_operacion  = cop_operacion  
and am_concepto in ( 'CAP', 'INT')
and am_dividendo = di_dividendo 
and am_dividendo = 1 
group by cop_operacion, di_fecha_ven

--AZU
create index idx1 on #importe_pri_vto  (operacion)

update #operaciones set 
cop_importe_pri_vto = importe,
cop_fecha_pri_vto   =fecha_pri_vto
from #importe_pri_vto
where cop_operacion = operacion


/* NO REPORTA OPERACIONES QUE FUERON CANCELADAS EN MESES ANTERIORES Y QUE VOLVIERON A SER CANCELADAS EN EL MES DE PROCESO POR FECHA VALOR */
select op_banco,  op_fecha_ult_mov, op_fecha_ult_proceso 
into #canceladas
from #operaciones, cob_cartera..ca_operacion with (nolock)
where cop_estado = @w_est_cancelado
and   cop_banco  = op_banco
and   op_fecha_ult_proceso < @w_fecha_ini and op_fecha_ult_mov between @w_fecha_ini and @w_fecha_proceso
and   cop_tipo_amortizacion <> 'ROTATIVA'

--AZU
create index idx1 on #canceladas  (op_banco, op_fecha_ult_proceso)

delete #operaciones
from cob_conta_super..sb_dato_operacion, #canceladas with (nolock)
where do_banco = op_banco
and   do_fecha = op_fecha_ult_proceso 
and   cop_banco = op_banco
and   do_estado_cartera = @w_est_cancelado


---25045
select cop_banco, concepto = dif_concepto, 'valDiff' =sum(dif_valor_total - dif_valor_pagado ), adicionar='S'
into #diferidos
from #operaciones, ca_diferidos with (nolock)
where cop_operacion = dif_operacion
group by cop_banco, dif_concepto
---25045

--AZU
create index idx1 on #diferidos  (cop_banco)

update #operaciones
set   cop_vencimiento_div = 1
from  cob_cartera..ca_dividendo with (nolock)
where cop_operacion = di_operacion
and   di_fecha_ven = @w_fecha_proceso

update #operaciones
set   cop_plazo    = td_descripcion
from  cob_cartera..ca_operacion,
      cob_cartera..ca_tdividendo with (nolock)
where cop_operacion = op_operacion       
and   td_tdividendo = op_tdividendo

/* ELIINAR LAS GRUPALES PADRES */
-- LGU-2018-02-20
select DISTINCT tg_referencia_grupal
into #grupales_padre
from #operaciones, cob_credito..cr_tramite_grupal, cob_cartera..ca_operacion with (nolock)
where cop_estado = @w_est_cancelado
and   cop_banco  = op_banco
and   op_fecha_ult_proceso <= @w_fecha_proceso 
AND   cop_banco  = tg_referencia_grupal


delete #operaciones
from #grupales_padre
where cop_banco = tg_referencia_grupal

--Actualizacion meses primer credito DCU

select cliente= op_cliente, fecha_ini = min(op_fecha_ini) 
into #primer_credito
from cob_cartera..ca_operacion,
#operaciones
where op_cliente = cop_cliente
and not exists (select  1 from cob_credito..cr_tramite_grupal where tg_referencia_grupal = op_banco)
group by op_cliente

select 
cliente,
meses= convert(float,datediff(dd, fecha_ini, @w_fecha_proceso)/30.4)
into #meses_cliente
from #primer_credito

update #operaciones set
cop_meses_primer_op = FLOOR(meses)
from #meses_cliente
where cliente = cop_cliente


/* ACTUALIZAR VALOR Y FECHA DE PAGO DE LA GARANTIA LIQUIDA */
-- LGU-2018-01-25
UPDATE #operaciones SET
	cop_gar_liq_orig   = gl_monto_garantia,
	cop_gar_liq_fpago  = gl_pag_fecha,
	cop_gar_liq_dev    = gl_dev_valor,
	cop_gar_liq_fdev   = gl_dev_fecha
FROM ca_garantia_liquida, cob_credito..cr_tramite_grupal with (nolock)
WHERE gl_grupo = tg_grupo
AND gl_cliente = tg_cliente
AND gl_tramite = tg_tramite
AND gl_monto_garantia > 0
AND tg_monto > 0
AND cop_banco = tg_prestamo
--///////////////////////////

/* DETERMINAR LA TASA DE LA OPERACION */
update #operaciones set
cop_tasa               =  ro_porcentaje,
cop_modalidad          =  case ro_fpago when 'P' then 'V' else 'A' end
from ca_rubro_op with (nolock)
where ro_operacion = cop_operacion
and   ro_concepto  = @w_rubro_int
and   ro_fpago in ('A', 'P')

/* DETERMINAR LA FECHA DE REESTRUCTURACION */
select tr_operacion, tr_fecha_ref=max(tr_fecha_ref)
into #reest
from cob_cartera..ca_transaccion, #operaciones with (nolock)
where tr_operacion = cop_operacion
and   tr_tran      in ('RES', 'PNO')
and   tr_estado   <> 'RV'
group by tr_operacion

--AZU
create index idx1 on #reest  (tr_operacion)

update #operaciones set
cop_reestructuracion   =  'S', 
cop_fecha_reest        =  tr_fecha_ref
from #reest
where tr_operacion = cop_operacion

/* PARA OPERACIONES REESTRUCTURADAS, DETERMINAR EL MOTIVO DE LA REESTRUCTURACION */
update #operaciones set
cop_natur_reest        =  tr_motivo
from cob_credito..cr_tramite with (nolock)
where tr_numero_op = cop_operacion
and   tr_tipo      = 'E'
and   cop_reestructuracion = 'S'

/* PARA OPERACIONES NORMALIZADAS, DETERMINAR EL TIPO DE HERRAMIENTA */
/* OTROS TIPOS DE NORMALIZACION */
update #operaciones set
cop_normalizado        =  'S',
cop_tipo_norm          = b.nm_tipo_norm
from cob_cartera..ca_normalizacion a, cob_credito..cr_normalizacion b with (nolock)
where a.nm_tramite = b.nm_tramite
and   b.nm_operacion = cop_banco

/* DETERMINAR LA FECHA DEL PROXIMO VENCIMIENTO */

update #operaciones set
cop_fecha_prox_vto =  di_fecha_ven,
cop_num_acta       =  convert(varchar,di_dividendo)        --REQ#142301
from ca_dividendo with (nolock)
where di_operacion = cop_operacion
and   di_estado    = @w_est_vigente

--update #operaciones set
--SRO. Desplazamiento
select 
co_banco = cop_banco,
co_cuota_capital = sum(case when am_concepto = 'CAP'      then isnull(am_cuota,0)  else 0 end),
co_cuota_int     = sum(case when am_concepto in ('INT', 'INT_ESPERA')     then isnull(am_cuota,0)  else 0 end),
co_cuota_iva     = sum(case when am_concepto in ('IVA_INT', 'IVA_ESPERA') then isnull(am_cuota,0)  else 0 end),
co_cuota_int_esp = sum(case when am_concepto = 'INT_ESPERA'               then isnull(am_cuota,0)  else 0 end),
co_cuota_iva_esp = sum(case when am_concepto = 'IVA_ESPERA'               then isnull(am_cuota,0)  else 0 end)   
into #cuota
from ca_dividendo d, ca_amortizacion a, #operaciones o with (nolock)
where cop_operacion = di_operacion
and   di_operacion  = am_operacion
and   am_operacion  = cop_operacion
and   am_dividendo  = di_dividendo
and   di_fecha_ven  = cop_fecha_prox_vto 
group by cop_banco, cop_operacion, cop_toperacion

--AZU
create index idx1 on #cuota  (co_banco)

--SRO. Desplazamiento
update #operaciones
set cop_cuota_capital = co_cuota_capital,
    cop_cuota_int     = co_cuota_int    ,
    cop_cuota_iva     = co_cuota_iva,
    cop_cuota_int_esp = co_cuota_int_esp,
    cop_cuota_iva_esp = co_cuota_iva_esp,
    cop_val_cuota     = cop_val_cuota + (co_cuota_int_esp + co_cuota_iva_esp)
from #cuota
where  cop_banco  = co_banco

/**********************************************************/
/* Actualizacion SubProducto                              */
/**********************************************************/

update #operaciones
set    cop_subproducto_cuenta = pr_codigo_subproducto
from cobis..cl_producto_santander with (nolock)
where cop_cliente   = pr_ente

/**********************************************************/
/* Actualizacion Preguntas                                */
/**********************************************************/

--HASTA ENCONTRAR EL HABIL ANTERIOR
select  @w_fecha_encuestas = dateadd(dd, -1, @w_fecha_proceso)

while exists( select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad  and df_fecha = @w_fecha_encuestas) 
  select @w_fecha_encuestas = dateadd(dd,-1,@w_fecha_encuestas)


select cliente = vd_cliente, 
       fecha   = max(vd_fecha)
into #respuestas 
from #operaciones,
     cob_credito..cr_verifica_datos with (nolock)
where cop_cliente = vd_cliente
and   cop_fecha >= dateadd(dd,1,@w_fecha_encuestas)
group by vd_cliente   
       


insert into cob_externos..ex_dato_verificacion 
select  
dv_fecha   = @w_fecha_proceso,
dv_cliente = vd_cliente,
dv_tramite = vd_tramite, 
dv_r01 = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c where t.tabla  = 'cr_sol_exp'            and   t.codigo = c.tabla and   c.codigo = substring(vd_respuesta,1,1)),
dv_r02 = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c where t.tabla  = 'cr_sol_exp'            and   t.codigo = c.tabla and   c.codigo = substring(vd_respuesta,3,1)),
dv_r03 = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c where t.tabla  = 'cr_sol_exp'            and   t.codigo = c.tabla and   c.codigo = substring(vd_respuesta,5,1)),
dv_r04 = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c where t.tabla  = 'cr_sol_exp'            and   t.codigo = c.tabla and   c.codigo = substring(vd_respuesta,7,1)),
dv_r05 = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c where t.tabla  = 'cr_sol_exp'            and   t.codigo = c.tabla and   c.codigo = substring(vd_respuesta,9,1)),
dv_r06 = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c where t.tabla  = 'cr_sol_exp'            and   t.codigo = c.tabla and   c.codigo = substring(vd_respuesta,11,1)),
dv_r07 = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c where t.tabla  = 'cr_sol_exp'            and   t.codigo = c.tabla and   c.codigo = substring(vd_respuesta,13,1)),
dv_r08 = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c where t.tabla  = 'cr_sol_exp'            and   t.codigo = c.tabla and   c.codigo = substring(vd_respuesta,15,1)),
dv_r09 = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c where t.tabla  = 'cr_sol_exp'            and   t.codigo = c.tabla and   c.codigo = substring(vd_respuesta,17,1)),
dv_r10 = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c where t.tabla  = 'cr_sol_exp'            and   t.codigo = c.tabla and   c.codigo = substring(vd_respuesta,19,1)),
dv_r11 = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c where t.tabla  = 'cr_sol_exp'            and   t.codigo = c.tabla and   c.codigo = substring(vd_respuesta,21,1)),
dv_r12 = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c where t.tabla  = 'cr_sol_exp'            and   t.codigo = c.tabla and   c.codigo = substring(vd_respuesta,23,1)),
dv_r13 = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c where t.tabla  = 'cr_sol_exp'            and   t.codigo = c.tabla and   c.codigo = substring(vd_respuesta,25,1)),
dv_r14 = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c where t.tabla  = 'cr_frecuencia'         and   t.codigo = c.tabla and   c.codigo = substring(vd_respuesta,27,1)),
dv_r15 = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c where t.tabla  = 'cr_redes_sociales'     and   t.codigo = c.tabla and   c.codigo = substring(vd_respuesta,29,1)),
dv_r16 = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c where t.tabla  = 'cr_tipo_telefono'      and   t.codigo = c.tabla and   c.codigo = substring(vd_respuesta,31,1)),
dv_r17 = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c where t.tabla  = 'cr_tipo_pago_telefono' and   t.codigo = c.tabla and   c.codigo = substring(vd_respuesta,33,1)),
dv_r18 =null,
dv_r19 =null,
dv_r20 =null,
dv_puntaje = vd_resultado
from #respuestas,
     cob_credito..cr_verifica_datos with (nolock)
where  cliente       = vd_cliente     
and    fecha         = vd_fecha 

/* DETERMINAR MONTO NO PROYECTADO DEL PROXIMO VENCIMIENTO */ --Req 378 12/08/2013
update #operaciones
set cop_valor_proxima_cuota = isnull((select SUM(am_cuota) from ca_amortizacion, ca_dividendo with (nolock)
where am_operacion = di_operacion
and   am_dividendo = di_dividendo
and di_estado = @w_est_vigente
and   am_operacion = cop_operacion),0)

update #operaciones
set cop_cuota_min_vencida = isnull((select SUM(am_cuota) 
                                   from ca_amortizacion, ca_dividendo with (nolock)
                                   where am_operacion = di_operacion
                                   and   am_dividendo = di_dividendo
                                   and    di_estado   = @w_est_vencido
                                   and   am_operacion = cop_operacion
                                   and   di_dividendo = (select max(di_dividendo) 
                                                         from ca_dividendo with (nolock)
                                                         where  di_estado   = @w_est_vencido
                                                         and    di_operacion= cop_operacion)
                                   ),0)



update #operaciones
set cop_cuota_max_vencida = isnull((select SUM(am_cuota) 
                                   from ca_amortizacion, ca_dividendo with (nolock)
                                   where am_operacion = di_operacion
                                   and   am_dividendo = di_dividendo
                                   and    di_estado   = @w_est_vencido
                                   and   am_operacion = cop_operacion
                                   and   di_dividendo = (select min(di_dividendo)
                                                         from ca_dividendo with (nolock)
                                                         where  di_estado   = @w_est_vencido
                                                         and    di_operacion= cop_operacion)
                                   ),0)

--------Caso #139932 doble desplazamiento CALCULO DIAS MAX DE ATRASO GRUPAL y DIAS MORA Ini
select cop_banco,    di_operacion,
	   /*se comenta el calculo de 360 por que el cliente indica que solo debe haber 1 día de diferencia entre dias mora y calculo de maximo dias de atraso - caso #139932*/
       --dias_360      = datediff(mm, isnull(min(di_fecha_ven),@w_fecha_proceso), @w_fecha_proceso) * 30 + datediff(dd, dateadd(mm, datediff(mm, isnull(min(di_fecha_ven),@w_fecha_proceso),@w_fecha_proceso), isnull(min(di_fecha_ven),@w_fecha_proceso)),@w_fecha_proceso),
       dias_360      = datediff(dd, isnull(min(di_fecha_ven),@w_fecha_proceso), @w_fecha_proceso),
       dias_365      = datediff(dd, isnull(min(di_fecha_ven),@w_fecha_proceso), @w_fecha_proceso) + 1,
       fecha_ven_ini = min(di_fecha_ven),
       dias_restar   = convert(int,0)
  into #operaciones_vencida
  from ca_dividendo, #operaciones with (nolock)
 where di_operacion = cop_operacion
   and di_estado    = @w_est_vencido
 group by cop_banco, cop_fecha_proceso, di_operacion

update #operaciones_vencida 
   set dias_360 = 0,   dias_365 = 0
 where dias_360 < 0 

select d.*
  into #desplazamiento
  from ca_desplazamiento d, #operaciones with (nolock)
 where cop_operacion    = de_operacion
   and de_estado  = 'A'
   and de_archivo <> 'WORKFLOW'

if ( @w_act_dias_antes_dsp = 'S' )
begin
    select distinct fecha_ini_desp       = de_fecha_ini, 
                    fecha_ini_desp_habil = de_fecha_ini
      into #fechas_ini_desplazamiento
      from #desplazamiento
     where de_fecha_ini <= @w_fecha_primer_desplaz

    while 1 = 1 begin
        select top 1 @w_fecha_ini_desp = fecha_ini_desp 
        from #fechas_ini_desplazamiento
        where fecha_ini_desp > @w_fecha_ini_desp
        order by fecha_ini_desp asc
        
        if @@rowcount = 0 break
        
        select @w_ant_habil = dateadd(dd, -1, @w_fecha_ini_desp )
        
        while exists (select 1
                      from cobis..cl_dias_feriados
                      where df_fecha   = @w_ant_habil
                      and   df_ciudad  = @w_ciudad)
        begin
           select @w_ant_habil = dateadd(dd, -1, @w_ant_habil)
        end
        
        update #fechas_ini_desplazamiento set
        fecha_ini_desp_habil = @w_ant_habil
        where fecha_ini_desp = @w_fecha_ini_desp
    end 

    update #desplazamiento 
       set de_fecha_ini = fecha_ini_desp_habil
      from #fechas_ini_desplazamiento
     where de_fecha_ini = fecha_ini_desp
end

select de_operacion,    de_fecha_ini, 
       dias = case when de_fecha_fin>= @w_fecha_proceso then
              datediff(dd,de_fecha_ini, @w_fecha_proceso)
              else 
              datediff(dd,de_fecha_ini, de_fecha_fin) end
 into #dias_restar            
 from #desplazamiento, #operaciones
where de_operacion = cop_operacion
  and de_estado    = 'A'

select de_operacion, dias = sum(dias)
  into #reales
  from #operaciones_vencida, #dias_restar
 where de_operacion   = di_operacion
   and fecha_ven_ini <= de_fecha_ini
 group by de_operacion

update #operaciones_vencida
   set dias_restar= dias
  from #reales
 where di_operacion = de_operacion

select cop_banco,    di_operacion, 
       dias_360 = dias_360 - isnull(dias_restar,0),
       dias_365 = dias_365 - isnull(dias_restar,0)
  into #actualizacion_vencida
  from #operaciones_vencida

create index idx1 on #actualizacion_vencida (di_operacion)

/*DIAS MORA*/
update #operaciones 
   set cop_edad_mora     = dias_365,
       cop_edad_mora_365 = dias_365
 from #actualizacion_vencida
where cop_operacion   = di_operacion

select cop_banco,    di_dividendo,    di_operacion,
       di_fecha_ven, di_fecha_can,    dias_atraso   = datediff(dd, di_fecha_ven, di_fecha_can)
  into #operaciones_canceladas
  from ca_dividendo, #operaciones with (nolock)
 where di_operacion = cop_operacion
   and di_estado    = @w_est_cancelado
   and di_fecha_can > di_fecha_ven

select cop_banco, de_operacion, dividendo = di_dividendo,
       calculo = sum(case when di_fecha_can > de_fecha_fin AND di_fecha_ven < de_fecha_ini then datediff(dd, de_fecha_ini,de_fecha_fin)
                          when di_fecha_can <= de_fecha_fin AND di_fecha_ven < de_fecha_ini then datediff(dd, de_fecha_ini,di_fecha_can)
                     else 0 end )
  into #actualizar_dividendo                
  from #desplazamiento, #operaciones_canceladas  
 where de_operacion =  di_operacion	  
   and di_operacion =  de_operacion 
   and di_fecha_can >  de_fecha_ini
 group by cop_banco, de_operacion, di_dividendo

update #operaciones_canceladas 
   set dias_atraso = dias_atraso - calculo
  from #actualizar_dividendo
 where di_operacion = de_operacion
   and di_dividendo = dividendo

update #operaciones_canceladas 
   set dias_atraso =0
 where dias_atraso < 0

create table #dias_maximo_atraso_grupal(banco cuenta, numero_maximo int)

insert into #dias_maximo_atraso_grupal (banco, numero_maximo)
select cop_banco, max(dias_360)
  from #actualizacion_vencida
 group by cop_banco

insert into #dias_maximo_atraso_grupal (banco, numero_maximo)
select cop_banco, max(dias_atraso)
  from #operaciones_canceladas
 group by cop_banco

select banco, dias_atraso = max(numero_maximo)
into #actualizar_dias_max
from #dias_maximo_atraso_grupal
group by banco

create index idx1 on #actualizar_dias_max  (banco)

update #operaciones  
   set cop_atraso_grupal = case when dias_atraso < 0 then 0 else dias_atraso end, 
       cop_atraso_gr_ant = case when dias_atraso < 0 then 0 else dias_atraso end 
  from #actualizar_dias_max
 where cop_banco = banco

--------Caso #139932 doble desplazamiento CALCULO DIAS MAX DE ATRASO GRUPAL y DIAS MORA FIN

/* DETERMINAR LA CANTIDAD DE CUOTAS VENCIDAS Y CANCELADAS */ 
select 
operacion  = di_operacion,
vencidas   = sum(case when di_estado = @w_est_vencido   then 1 else 0 end),
canceladas = sum(case when di_estado = @w_est_cancelado then 1 else 0 end)
into #resumen_cuotas
from ca_dividendo with (nolock)
where di_estado in (@w_est_vencido, @w_est_cancelado)
group by di_operacion
  
--AZU
create index idx1 on #resumen_cuotas  (operacion)

update #operaciones set
cop_cuotas_pag =  canceladas,
cop_cuotas_ven =  vencidas
from #resumen_cuotas
where cop_operacion = operacion

/* DETERMINAR SI EL CLIENTE ESTA EMPROBLEMADO */ 
update #operaciones set
cop_emproblemado  = en_emproblemado
from cobis..cl_ente with (nolock)
where cop_cliente = en_ente

--update #operaciones set cop_emproblemado = null
--where cop_emproblemado = ''

/* DETERMINAR EL SALDO VENCIDO */
select 
operacion = am_operacion,
saldo_ven = (sum(am_acumulado + am_gracia - am_pagado) + abs(sum(am_acumulado + am_gracia - am_pagado))) / 2
into #saldo_ven
from ca_amortizacion, ca_dividendo with (nolock)
where am_operacion = di_operacion
and   am_dividendo = di_dividendo
and   di_estado  in (@w_est_vencido, @w_est_vigente)
group by am_operacion
    
--AZU
create index idx1 on #saldo_ven  (operacion)

update #operaciones set
cop_saldo_ven = saldo_ven
from #saldo_ven
where cop_operacion = operacion

/* DETERMINAR EL COCIENTE PAGO */
select 
operacion  = cop_operacion, 
dividendo  = di_dividendo, 
dividendo2 = di_dividendo, 
per_cuota  = cop_per_cuotas, 
pagado     = sum(am_pagado),
cuota      = sum(am_cuota), 
promedio   = case when sum(am_cuota) > 0 then sum(am_pagado)/sum(am_cuota) else 0 end
into  #promedios
from  #operaciones , ca_dividendo , ca_amortizacion with (nolock)
where cop_operacion   = am_operacion
and   cop_operacion   = di_operacion
and   di_dividendo    = am_dividendo
and   (di_estado in(@w_est_vencido, @w_est_cancelado) or (di_estado = @w_est_vigente and di_fecha_ven = @w_fecha_proceso))
group by   cop_operacion, di_dividendo, cop_per_cuotas
order by cop_operacion, di_dividendo

--AZU
create index idx1 on #promedios  (operacion)

select 
max_operacion = cop_operacion, 
max_dividendo = max(di_dividendo)
into #maximos
from  #operaciones , ca_dividendo with (nolock)
where cop_operacion   = di_operacion
and   (di_estado in(@w_est_vencido, @w_est_cancelado) or (di_estado = @w_est_vigente and di_fecha_ven = @w_fecha_proceso))
group by   cop_operacion

--AZU
create index idx1 on #maximos  (max_operacion)

update #promedios set
dividendo = max_dividendo - dividendo + 1
from #maximos
where operacion = max_operacion

select 
operacion, 
cociente  = avg(promedio) 
into #cociente_pago
from #promedios, cob_conta_super..sb_cuota_p_pago
where per_cuota = pp_periodo_cuota
and   dividendo <= pp_cuotas
group by operacion

--AZU
create index idx1 on #cociente_pago  (operacion)

update #operaciones set
cop_cociente_pago = cociente
from  #cociente_pago
where operacion = cop_operacion 

/* DETERMINAR NUMERO DE CICLOS */
select 
operacion     = cop_operacion,
grupo         = dc_grupo,
numero_ciclos = isnull(max(dc_ciclo_grupo),0)
into #ciclos
from #operaciones, ca_det_ciclo with (nolock)
where cop_toperacion = 'GRUPAL'
and   dc_cliente     = cop_cliente
and   dc_operacion   = cop_operacion
group by cop_operacion, dc_grupo

--AZU
create index idx1 on #ciclos  (operacion)

update #operaciones set
cop_grupo         = grupo,
cop_numero_ciclos = numero_ciclos
from #ciclos
where cop_operacion = operacion

update #operaciones 
set cop_ciclo_actual = gr_num_ciclo
from cobis..cl_grupo with (nolock)
where cop_grupo =gr_grupo

--

select or_grupo, numero_renova = count(1)
into #renovacion_grupo
from #renovaciones_operaciones
group by or_grupo

update #operaciones set 
cop_renovacion_grupal = numero_renova 
from #renovacion_grupo
where cop_grupo = or_grupo



/* DETERMINAR NUMERO DE INTEGRANTES */

select dc_operacion, dc_grupo, dc_ciclo_grupo, dc_referencia_grupal
into #ca_det_ciclo
from ca_det_ciclo t, 
     #operaciones with (nolock)
where dc_grupo       = cop_grupo
and   dc_ciclo_grupo = cop_numero_ciclos
group by dc_operacion, dc_grupo, dc_ciclo_grupo, dc_referencia_grupal

create index #ca_det_ciclo_idx on #ca_det_ciclo (dc_grupo, dc_ciclo_grupo)

--Eliminar registros de referencia grupal
delete #ca_det_ciclo
from cob_cartera..ca_operacion with (nolock)
where dc_referencia_grupal = op_banco
and   dc_operacion         = op_operacion
                          

update #operaciones set
cop_numero_integrantes = (select isnull(count(dc_grupo),0)
                          from #ca_det_ciclo
                          where dc_grupo       = cop_grupo
                          and   dc_ciclo_grupo = cop_numero_ciclos)


/*Parametro para acumulados */  --Req 378 12/08/2013
declare @w_sacumv varchar(15) 

select @w_sacumv = pa_char
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'FSAMIN'
and    pa_producto = 'CCA'

/* SALDOS ACUMULADOS DE LA CUOTA MAS VENCIDA */  --Req 378 12/08/2013
select 
operacion_tot = am_operacion,
dividendo_tot = am_dividendo,
saldo_ven_tot = (sum(am_acumulado + am_gracia - am_pagado) + abs(sum(am_acumulado + am_gracia - am_pagado))) / 2
into #saldo_menor_ven
from ca_amortizacion, ca_dividendo , #operaciones with (nolock)
where am_operacion = di_operacion
and   cop_operacion = di_operacion
and   am_dividendo = di_dividendo
and   di_estado  in (@w_est_vencido)
and am_concepto = @w_sacumv
group by am_operacion, am_dividendo

--AZU
create index idx1 on #saldo_menor_ven  (operacion_tot)

delete #saldo_menor_ven
where saldo_ven_tot <= 0

select 
operacion_div = operacion_tot,
dividendo_div = min(dividendo_tot)
into #saldo_menor_ven_div
from #saldo_menor_ven
group by operacion_tot  

--AZU
create index idx1 on #saldo_menor_ven_div  (operacion_div, dividendo_div)

update #operaciones set
cop_saldo_otr = saldo_ven_tot 
from #saldo_menor_ven,
     #saldo_menor_ven_div
where cop_operacion = operacion_tot
and   operacion_tot = operacion_div
and   dividendo_tot = dividendo_div 

/* DETERMINAR EL SALDO TOTAL SOLO VENCIDO */ --Req 378 12/08/2013
select 
operacion = am_operacion,
saldo_ven = (sum(am_acumulado + am_gracia - am_pagado) + abs(sum(am_acumulado + am_gracia - am_pagado))) / 2,
fecha_vencimiento = min(di_fecha_ven)
into #saldo_tot_ven
from ca_amortizacion, ca_dividendo with (nolock)
where am_operacion = di_operacion
and   am_dividendo = di_dividendo
and   di_estado  in (@w_est_vencido)
group by am_operacion

--AZU
create index idx1 on #saldo_tot_ven  (operacion)
    
update #operaciones set
cop_saldo_total_Vencido = saldo_ven,
cop_fecha_dividendo_ven = fecha_vencimiento
from #saldo_tot_ven
where cop_operacion = operacion


/* DETERMINAR EL CAPITAL VENCIDO */
select 
operacion = am_operacion,
cap_mora  = isnull(sum(am_cuota-am_pagado),0)
into #cap_mora
from ca_amortizacion, ca_dividendo with (nolock)
where am_operacion = di_operacion
and   am_dividendo = di_dividendo
and   am_concepto  = 'CAP'
and   di_estado    = @w_est_vencido
group by am_operacion
    
--AZU
create index idx1 on #cap_mora  (operacion)

update #operaciones set
cop_cap_vencido = cap_mora
from #cap_mora
where cop_operacion = operacion

/* DETERMINAR EL VALOR TOTAL VENCIDO */


select 
operacion = am_operacion,
tot_mora  = isnull(sum(am_cuota-am_pagado),0)
into #total_mora
from ca_amortizacion, ca_dividendo with (nolock)
where am_operacion = di_operacion
and   am_dividendo = di_dividendo
and   di_estado    = @w_est_vencido
group by am_operacion
    
--AZU
create index idx1 on #total_mora (operacion)

update #operaciones set
cop_valor_vencido  = tot_mora
from #total_mora
where cop_operacion = operacion

/* DETERMINAR EL SALDO CAPITAL TOTAL*/ --Req 378 12/08/2013 -
select 
operacion      = am_operacion,
cap_tot        = sum(am_cuota-am_pagado),
cap_num_cuotas = max(di_dividendo)
into #cap_mora_tot
from ca_amortizacion, ca_dividendo with (nolock)
where am_operacion = di_operacion
and   am_dividendo = di_dividendo
and   am_concepto  = @w_rubro_cap
--and   di_estado    = @w_est_cancelado
group by am_operacion
    
--AZU
create index idx1 on #cap_mora_tot (operacion)

update #operaciones set
cop_saldo_cap_total = cap_tot--,
--cop_num_cuotas      = cap_num_cuotas
from #cap_mora_tot
where cop_operacion = operacion

/* REGIONAL */ --Req 378 12/08/2013
select 
operacion = cop_operacion,
regional  = of_zona
into #regional
from cobis..cl_oficina, #operaciones
where cop_oficina = of_oficina

update #operaciones
set cop_regional = of_nombre
from #regional, cobis..cl_oficina
where regional = of_oficina
and   operacion = cop_operacion

/* DETERMINAR LA FECHA DE CASTIGO */
update #operaciones set
cop_fecha_castigo = tr_fecha_ref
from ca_transaccion with (nolock)
where tr_operacion = cop_operacion
and   tr_tran      = 'ETM'
and   tr_estado   <> 'RV'
and   cop_estado   = @w_est_castigado

/* PARA LAS OPERACIONES MIGRADAS DE SICREDITO OBTENER LA FECHA DE CASTIGO DE LA CA_TRANSACCION_BANCAMIA */
update #operaciones set
cop_fecha_castigo = tr_fecha_mov
from ca_transaccion_bancamia with (nolock)
where tr_banco     = cop_banco
and   tr_tran      = 'ETM'
and   tr_estado   <> 'RV'
and   cop_estado   = @w_est_castigado

/* DETERMINAR FECHA Y MONTO DEL ULTIMO PAGO */
select 
operacion  = ab_operacion, 
fecha      = max(ab_fecha_pag),
secuencial = 0
into #ult_pago
from  ca_abono, #operaciones  with (nolock)
where ab_tipo = 'PAG'
and   ab_estado <> 'RV'
and   ab_operacion = cop_operacion 
group by  ab_operacion

--AZU
create index idx1 on #ult_pago (operacion, fecha)

select 
operacion  = operacion, 
fecha      = fecha,
secuencial = max(ab_secuencial_ing)
into #ult_pago_2
from ca_abono, #ult_pago with (nolock)
where ab_operacion = operacion
and   ab_fecha_pag = fecha
group by operacion, fecha

--AZU
create index idx1 on #ult_pago_2 (operacion, fecha)

select 
operacion = operacion, 
fecha     = fecha,
monto     = sum(abd_monto_mop)
into #ult_pago_3
from ca_abono_det, #ult_pago_2 with (nolock)
where abd_operacion      = operacion
and   abd_secuencial_ing = secuencial
group by operacion, fecha

--AZU
create index idx1 on #ult_pago_3 (operacion, fecha)

update #operaciones set
cop_fecha_ult_pago  =  fecha,
cop_valor_ult_pago  =  monto
from #ult_pago_3
where cop_operacion = operacion

/* ACTUALIZACION PARA TEMPORALIDAD DIARIA */
update #operaciones set
cop_edad_cod  = ct_codigo 
from   cob_credito..cr_param_cont_temp with (nolock)
where  cop_clase           =  ct_clase
and    cop_edad_mora/30.0  >  case when ct_desde = 0 then -30000 else ct_desde end
and    cop_edad_mora/30.0  <= ct_hasta

/* OPERACIONES PARA CONTROL DE CUOTAS PAGADAS A TIEMPO DESDE LA FECHA DE REESTRUCTURACION*/
delete ca_fecha_reest_control
from #operaciones
where cop_reestructuracion = 'N'
and   fr_operacion         = cop_operacion

update ca_fecha_reest_control set
fr_fecha = cop_fecha_reest
from #operaciones
where cop_reestructuracion = 'S'
and   fr_operacion         = cop_operacion
and   fr_fecha             < cop_fecha_reest

insert into ca_fecha_reest_control
select cop_operacion, cop_fecha_reest
from #operaciones
where cop_reestructuracion = 'S'
and   cop_operacion        not in (select fr_operacion from ca_fecha_reest_control with (nolock))

select 
operacion = op_operacion, 
fecha     = fr_fecha
into #op_reest_1
from ca_operacion, ca_fecha_reest_control with (nolock)
where op_operacion = fr_operacion

--AZU
create index idx1 on #op_reest_1 (operacion)

select 
operacion     = di_operacion,
cuotas_total  = sum(case when di_fecha_ven > fecha and di_fecha_ven <= @w_fecha_proceso and di_fecha_ven > fecha then 1 else 0 end),
cuotas_can_ok = sum(case when di_estado = 3 and (dateadd(dd,@w_dias_gracia_reest,di_fecha_ven) >= di_fecha_can) and di_fecha_ven > fecha then 1 else 0 end),
cuotas_ven_ok = sum(case when di_estado = 2 and (dateadd(dd,@w_dias_gracia_reest,di_fecha_ven) >= @w_fecha_proceso) and di_fecha_ven > fecha then 1 else 0 end)
into #op_reest_2
from #op_reest_1, ca_dividendo with (nolock)
where di_operacion  = operacion
and   di_fecha_ven >  fecha 
and   di_fecha_ven <= @w_fecha_proceso
and   di_estado    <> 0
group by di_operacion

--AZU
create index idx1 on #op_reest_2 (operacion)

select 
operacion_di = di_operacion,
fecha_di     = max(dateadd(dd, 1, di_fecha_ven))
into #op_reest_3
from #op_reest_1, ca_dividendo with (nolock)
where di_operacion  = operacion
and   di_fecha_ven  >  fecha 
and   di_fecha_ven  <= @w_fecha_proceso
and   di_estado     = 2
group by di_operacion

--AZU
create index idx1 on #op_reest_3 (operacion_di)

update #operaciones set
cop_num_cuotas_reest =  case when cuotas_can_ok + cuotas_ven_ok >= cuotas_total then cuotas_can_ok else 0 end
from #op_reest_2
where cop_operacion = operacion

update ca_fecha_reest_control set
fr_fecha = case when cuotas_can_ok + cuotas_ven_ok >= cuotas_total then fr_fecha else @w_fecha_proceso end
from #op_reest_2
where operacion   = fr_operacion

update ca_fecha_reest_control set
fr_fecha = case when cuotas_can_ok + cuotas_ven_ok >= cuotas_total then fr_fecha else fecha_di end
from #op_reest_2, #op_reest_3
where operacion   = fr_operacion
and   operacion   = operacion_di

-- INI - GAL 27/JUL/2010
update #operaciones set 
cop_nota_int = ci_nota
from cob_credito..cr_califica_int_mod with (nolock)
where ci_banco = cop_banco

select 
operacion  = di_operacion,
dividendo  = min(di_dividendo)
into #min_dividendo
from ca_dividendo, #operaciones with (nolock)
where di_estado    <> @w_est_cancelado
and   di_operacion  = cop_operacion
group by di_operacion

--AZU
create index idx1 on #min_dividendo (operacion, dividendo)

select 
operacion = di_operacion,
fecha_ven = di_fecha_ven,
gracia    = di_gracia
into #min_vto
from #min_dividendo, ca_dividendo with (nolock)
where di_operacion = operacion
and   di_dividendo = dividendo

--AZU
create index idx1 on #min_vto (operacion)

update #operaciones set 
cop_fecha_ini_mora = fecha_ven,
cop_gracia_mora    = gracia
from #min_vto
where cop_operacion = operacion


update #operaciones set 
cop_tasa_mora = ro_porcentaje_efa
from ca_rubro_op with (nolock)
where ro_operacion = cop_operacion
and   ro_concepto  = 'IMO'

update #operaciones set 
cop_tasa_com  = ro_porcentaje
from ca_rubro_op with (nolock)
where ro_operacion = cop_operacion
and   ro_concepto  = @w_rubro_int --'MIPYMES'
-- FIN - GAL 27/JUL/2010 

--Actualizacion Fecha de Cambio de Linea (Control de Cambio 224 -Empleados)
update #operaciones set 
cop_fecha_cambio_linea = null

update #operaciones set
cop_fecha_cambio_linea = tl_fecha_traslado
from ca_traslado_linea with (nolock)
where tl_operacion = cop_operacion
and   tl_estado    = 'P'

																																		   

/*FRECUENCIA DE PAGO DE CAPITAL*/
while (1=1)
begin
	select @w_operacion =  cop_operacion FROM cob_cartera..ca_dividendo,#operaciones with (nolock)
	WHERE di_operacion = cop_operacion
	and cop_operacion > @w_operacion
	and di_de_capital = 'S' 
	and di_de_interes = 'S'
	order by cop_operacion
	
	if @@rowcount = 0 
    begin
       set rowcount 0
       break
    end
	
	SELECT @w_div_min_ex = min(di_dividendo) 
     FROM cob_cartera..ca_dividendo with (nolock)
     WHERE di_estado IN (1,2,0)
        and di_operacion = @w_operacion
        and di_de_capital = 'S'

	SELECT @w_fecha_ven_ant  = di_fecha_ven
     FROM cob_cartera..ca_dividendo with (nolock)
     WHERE di_operacion = @w_operacion 
    -- AND di_de_capital = 'S' --AND di_de_interes = 'S'
     and di_dividendo = @w_div_min_ex

	SELECT @w_div_min_sig = min(di_dividendo) 
     FROM cob_cartera..ca_dividendo with (nolock)
     WHERE di_estado IN (0,1,2)
        and di_operacion = @w_operacion 
        and di_dividendo > @w_div_min_ex 
        and di_de_capital = 'S'
 
    SELECT @w_fecha_ven_sig  = di_fecha_ven
     FROM cob_cartera..ca_dividendo with (nolock)
     WHERE di_operacion = @w_operacion 
      --AND di_de_interes = 'S'
     and di_dividendo = @w_div_min_sig

	SELECT   @w_numdias  = datediff (dd,@w_fecha_ven_ant,@w_fecha_ven_sig)
	
	update #operaciones set 
	cop_frec_pagos_cap  = isnull(@w_numdias,0)
	where cop_operacion = @w_operacion

end

/*FRECUENCIA DE PAGO DE INTERES */
while (1=1)
begin
	select @w_operacion =  cop_operacion FROM cob_cartera..ca_dividendo,#operaciones with (nolock)
	WHERE di_operacion = cop_operacion
	and cop_operacion > @w_operacion
	and di_de_capital = 'N' 
	and di_de_interes = 'S'
	order by cop_operacion
	
	if @@rowcount = 0 
    begin
       set rowcount 0
       break
    end
	
	SELECT @w_div_min_ex = min(di_dividendo) 
     FROM cob_cartera..ca_dividendo with (nolock)
     WHERE di_estado IN (1,2,0)
        and di_operacion = @w_operacion
        and di_de_interes = 'S'

	SELECT @w_fecha_ven_ant  = di_fecha_ven
     FROM cob_cartera..ca_dividendo with (nolock)
     WHERE di_operacion = @w_operacion 
    -- AND di_de_capital = 'S' --AND di_de_interes = 'S'
     and di_dividendo = @w_div_min_ex

	SELECT @w_div_min_sig = min(di_dividendo) 
     FROM cob_cartera..ca_dividendo with (nolock)
     WHERE di_estado IN (0,1,2)
        and di_operacion = @w_operacion 
        and di_dividendo > @w_div_min_ex 
        and di_de_interes = 'S'
 
    SELECT @w_fecha_ven_sig  = di_fecha_ven
     FROM cob_cartera..ca_dividendo with (nolock)
     WHERE di_operacion = @w_operacion 
      --AND di_de_interes = 'S'
     and di_dividendo = @w_div_min_sig

	SELECT   @w_numdias  = datediff (dd,@w_fecha_ven_ant,@w_fecha_ven_sig)
	
	update #operaciones set 
	cop_frec_pagos_int  = @w_numdias
	where cop_operacion = @w_operacion

end

/*Modalidad de Pago*/
while (1=1)
begin
	select @w_operacion =  cop_operacion FROM cob_cartera..ca_dividendo,#operaciones with (nolock)
	WHERE di_operacion = cop_operacion
	and cop_operacion > @w_operacion
	order by cop_operacion
	
	if @@rowcount = 0 
    begin
       set rowcount 0
       break
    end
	
	SELECT @w_num_div_cap = count(di_dividendo) 
     FROM cob_cartera..ca_dividendo with (nolock)
     WHERE di_operacion = @w_operacion
        and di_de_capital = 'S'
        
	SELECT @w_num_div_int = count(di_dividendo) 
     FROM cob_cartera..ca_dividendo with (nolock)
     WHERE di_operacion = @w_operacion
        and di_de_interes = 'S'
		
	IF @w_num_div_cap = 1 AND @w_num_div_int = 1
		select @w_mod_pago = 1 
	else
		begin
			IF @w_num_div_cap = 1 AND @w_num_div_int > 1
				select @w_mod_pago = 2
			else
				begin
					SELECT @w_tdividendo = op_tdividendo
					FROM ca_operacion with (nolock)
					WHERE op_operacion = @w_operacion
					
					SELECT @w_factor = td_factor 
					FROM ca_tdividendo with (nolock)
					WHERE td_tdividendo = @w_tdividendo
					
					IF @w_factor > 30
						select @w_mod_pago = 3
						
					IF @w_factor > 1 AND @w_factor < 15 
						select @w_mod_pago = 4
							
					IF @w_factor = 15 
						select @w_mod_pago = 5	
					
					IF @w_factor = 30
						select @w_mod_pago = 6
				end
end

update #operaciones set 
	cop_mod_pago  = @w_mod_pago
	where cop_operacion = @w_operacion
		
end


--SUBPRODUCTO CUENTA 
--TRAMITES GRUPALES SE INICIALIZA TODOS EN N
select distinct
tramite            = cop_tramite,
promocion          = case tr_promocion when 'S' then 'S' else 'N' end
into #tramites
from cob_credito..cr_tramite_grupal, #operaciones, cob_credito..cr_tramite t with (nolock)
where tg_grupo     = cop_grupo 
and   tg_operacion = cop_operacion 
and   tg_tramite   = t.tr_tramite
and   tg_monto > 0
and   tg_participa_ciclo = 'S'
and   tg_prestamo <> tg_referencia_grupal

--AZU
create index idx1 on #tramites (tramite)

--TRAMITES INDIVIDUALES 
insert into #tramites
select 
tramite   = tr_tramite,
promocion = isnull(tr_promocion,'') 
from #operaciones, cob_credito..cr_tramite with (nolock)
where cop_tramite = tr_tramite
and tr_tramite not in (select tramite from #tramites)

--ACTUALIZAR PROMOCION 
--update #tramites  set 
--promocion = isnull(tr_promocion,promocion) 
--from cob_credito..cr_tramite,#tramites
--where tr_tramite = tramite 

update #operaciones set 
cop_subtipo_producto   = case promocion when 'S' then 'PROMO' when 'N' then 'TRADICIONAL' else 'INDIVIDUAL' end
from #tramites , #operaciones
where cop_tramite = tramite

																																										 


/* OBTENER FECHA PROXIMO VENCIMIENTO */   
select @w_operacion = 0
while 1=1
begin
   select top 1 @w_operacion = cop_operacion, @w_fecha_vencimiento = cop_fecha_fin
   from #operaciones 
   where cop_operacion > @w_operacion
   and cop_toperacion = 'REVOLVENTE'
   order by cop_operacion asc
   
   if @@rowcount = 0 break
   
   /* OBTENER FECHA DE CORTE */
   exec @w_error  = cob_cartera..sp_lcr_calc_corte
   @i_operacionca   = @w_operacion,
   @i_fecha_proceso = @w_fecha_proceso,
   @o_fecha_corte   = @w_fecha_prox_vto out
   
   if @w_fecha_prox_vto > @w_fecha_vencimiento select @w_fecha_prox_vto = null --''
   
   update #operaciones set
   cop_fecha_prox_vto = @w_fecha_prox_vto
   where cop_operacion = @w_operacion
end

																																										   

--***************************************************************************
--FECHA DE VENCIMIENTO ORIGINAL
SELECT  tr_secuencial = min(tr_secuencial) , tr_operacion, secuencia_max = min(tr_secuencial)+20
into #secuenciales_op
FROM cob_cartera..ca_transaccion, #operaciones with (nolock)
WHERE tr_operacion =cop_operacion 
AND tr_tran='DES'
AND tr_secuencial > 0
GROUP BY tr_operacion

--AZU 
create index idx1 on #secuenciales_op (tr_operacion)

select oph_fecha_fin, oph_operacion,oph_banco  
into #fecha_ven_original 
from cob_cartera..ca_operacion_his with (nolock)
where 1=2

INSERT INTO #fecha_ven_original
SELECT min(oph_fecha_fin), oph_operacion ,min( oph_banco )
FROM cob_cartera_his..ca_operacion_his, #secuenciales_op with (nolock)
WHERE oph_operacion =tr_operacion
AND oph_secuencial >= tr_secuencial -- Por caso#173628
AND oph_secuencial <secuencia_max
group by oph_operacion
union
SELECT min(oph_fecha_fin), oph_operacion,min( oph_banco )
FROM cob_cartera..ca_operacion_his, #secuenciales_op with (nolock)
WHERE oph_operacion =tr_operacion
AND oph_secuencial >= tr_secuencial -- Por caso#173628
AND oph_secuencial <secuencia_max
group by oph_operacion 

--AZU 
create index idx1 on #fecha_ven_original (oph_operacion)

update #operaciones
set cop_fecha_ven_orig = oph_fecha_fin
from #fecha_ven_original
where cop_operacion = oph_operacion
--****************************************************************************************
--FECHA CANCELACION ANTICIPADA
SELECT 'tr_fecha_ref'=max(tr_fecha_mov), tr_operacion --es la fecha de la operacion, estaba por definirse si era la operacion o la fecha valor
INTO #ultimo_pago
FROM cob_cartera..ca_transaccion, ca_det_trn,  #operaciones with (nolock)
WHERE tr_secuencial =  dtr_secuencial
AND tr_operacion = dtr_operacion
AND tr_operacion = cop_operacion
AND tr_secuencial > 0
AND tr_estado <> 'RV'
AND dtr_concepto = 'CAP'
AND tr_tran = 'PAG'
GROUP BY tr_operacion

--AZU 
create index idx1 on #ultimo_pago (tr_operacion)

update #operaciones
set cop_fecha_can_ant = tr_fecha_ref
from #ultimo_pago
where cop_operacion = tr_operacion

/*Por caso #173628 - Inicio*/
select fecha_fin = op_fecha_fin, operacion = op_operacion, banco = op_banco
into #operaciones_fecha_ven_orig_null
from cob_cartera..ca_operacion, #operaciones 
where op_banco = cop_banco
and cop_fecha_ven_orig is null

update #operaciones
set cop_fecha_ven_orig = fecha_fin
from #operaciones_fecha_ven_orig_null 
where cop_banco = banco
and cop_fecha_ven_orig is null
/*Por caso #173628 - Fin*/

/* REGISTRO DE LOS SALDOS DIARIOS DE LAS OPERACIONES EN COB_EXTERNOS */

insert into cob_externos..ex_dato_operacion (
do_fecha,                  do_operacion,              do_banco,               do_toperacion,
do_aplicativo,             do_destino_economico,      do_clase_cartera,       do_cliente,
do_documento_tipo,         do_documento_numero,       do_oficina,             do_moneda,
do_monto,                  do_tasa,                   do_modalidad,           do_plazo_dias,
do_fecha_desembolso,       do_fecha_vencimiento,      do_edad_mora,           do_reestructuracion,
do_fecha_reest,            do_nat_reest,              do_num_reest,           do_num_renovaciones,
do_estado,                 do_cupo_credito,           do_num_cuotas,          do_periodicidad_cuota,
do_valor_cuota,            do_cuotas_pag,             do_cuotas_ven,          do_saldo_ven,
do_fecha_prox_vto,         do_fecha_ult_pago,         do_valor_ult_pago,      do_fecha_castigo,
do_num_acta,               do_clausula,               do_oficial,             do_naturaleza,
do_fuente_recurso,         do_categoria_producto,     do_cap_mora,            do_tipo_garantias,
do_op_anterior,            do_edad_cod,               do_num_cuotas_reest,    do_tramite,
do_nota_int,               do_fecha_ini_mora,         do_gracia_mora,         do_estado_cobranza,
do_tasa_mora,              do_tasa_com,               do_entidad_convenio,    do_fecha_cambio_linea,
do_valor_nominal,          do_emision,                do_sujcred,             do_cap_vencido,
do_valor_proxima_cuota,    do_saldo_total_Vencido,    do_saldo_otr,           do_saldo_cap_total,
do_regional,               do_dias_mora_365,          do_normalizado,         do_tipo_norm, 
do_frec_pagos_capital,     do_frec_pagos_int,         do_fec_pri_amort_cubierta, do_monto_condo,
do_fecha_condo,            do_monto_castigo,          do_inte_castigo,        do_monto_bonifica,
do_inte_refina,            do_emproblemado,           do_mod_pago,            do_tipo_cartera,
do_subtipo_cartera,        do_cociente_pago,          do_numero_ciclos,       do_numero_integrantes,
/* LGU. NUEVOS CAMPOS */
do_grupo,                  do_valor_cat,              do_gar_liq_orig,        do_gar_liq_fpago,
do_gar_liq_dev,            do_gar_liq_fdev,
do_cuota_cap  ,            do_cuota_int   ,           do_cuota_iva   ,        do_fecha_suspenso,
do_cuenta     ,            do_plazo       ,           do_venc_dividendo,      do_fecha_aprob_tramite,
do_subtipo_producto,       do_atraso_grupal,          do_fecha_dividendo_ven, do_tplazo             ,
do_cuota_min_vencida,      do_fecha_proceso,          do_subproducto,         do_cuota_max_vencida,      
do_atraso_gr_ant,          do_monto_aprobado,         do_fecha_ult_vto,       do_cuota_ult_vto,		  
do_tipo_amortizacion,      do_cupo_original,          do_importe_ult_vto,     do_importe_pri_vto,
do_fecha_pri_vto,          do_banco_padre,            do_fecha_ven_orig,      do_fecha_can_ant,
do_cuota_int_esp,          do_cuota_iva_esp,          do_fecha_ini_desp,      do_fecha_fin_desp,
do_renovacion_grupal,      do_renovacion_ind,         do_meses_primer_op,     do_periodicidad,
do_dia_pago
)
select 
cop_fecha,                 cop_operacion,             cop_banco,              cop_toperacion,
cop_aplicativo,            cop_destino,               cop_clase,              cop_cliente,
cop_documento_tipo,        cop_documento_nume,        cop_oficina,            cop_moneda,
cop_monto,                 cop_tasa,                  cop_modalidad,          cop_plazo_dias,
cop_fecha_liq,             cop_fecha_fin,             cop_edad_mora,          cop_reestructuracion,
cop_fecha_reest,           cop_natur_reest,           cop_num_reest,          cop_num_renovacion,
cop_estado,                cop_cupo_credito,          cop_num_cuotas,         cop_per_cuotas,
cop_val_cuota,             cop_cuotas_pag,            cop_cuotas_ven,         cop_saldo_ven,
cop_fecha_prox_vto,        cop_fecha_ult_pago,        cop_valor_ult_pago,     cop_fecha_castigo,
cop_num_acta,              cop_clausula,              cop_oficial,            cop_naturaleza,
cop_fuente_recurso,        cop_categoria_producto,    cop_valor_vencido,      cop_tipo_garantias,
cop_op_anterior,           cop_edad_cod,              cop_num_cuotas_reest,   cop_tramite,
cop_nota_int,              cop_fecha_ini_mora,        cop_gracia_mora,        cop_estado_cobranza,
cop_tasa_mora,             cop_tasa_com,              cop_entidad_convenio,   cop_fecha_cambio_linea,
cop_valor_nominal,         cop_emision,               cop_sujcred,            cop_cap_vencido,
cop_valor_proxima_cuota,   cop_saldo_total_Vencido,   cop_saldo_otr,          cop_saldo_cap_total,
cop_regional,              cop_edad_mora_365,         cop_normalizado,        cop_tipo_norm,
cop_frec_pagos_cap,        cop_frec_pagos_int,        cop_fec_pri_amort_cubierta,cop_monto_condo,
cop_fecha_condo,           cop_monto_castigo,         cop_inte_castigo,       cop_monto_bonifica,
cop_inte_refina,           cop_emproblemado,          cop_mod_pago,           cop_sector,
cop_subtipo_linea,         cop_cociente_pago,         cop_numero_ciclos,      cop_numero_integrantes,
/* LGU. NUEVOS CAMPOS */
cop_grupo,                 cop_valor_cat,             cop_gar_liq_orig,       cop_gar_liq_fpago,
cop_gar_liq_dev,           cop_gar_liq_fdev,
cop_cuota_capital,         cop_cuota_int   ,          cop_cuota_iva   ,       cop_fecha_suspenso,
cop_cuenta       ,         cop_plazo       ,          cop_vencimiento_div,    cop_fecha_apr_tramite,
cop_subtipo_producto,      cop_atraso_grupal,         cop_fecha_dividendo_ven,cop_tplazo           ,
cop_cuota_min_vencida,     cop_fecha_proceso,         cop_subproducto_cuenta, cop_cuota_max_vencida,     
cop_atraso_gr_ant,         cop_monto_aprobado,        cop_fecha_ult_vto,      cop_cuota_ult_vto,
cop_tipo_amortizacion,     cop_cupo_original,         cop_importe_ult_vto,    cop_importe_pri_vto ,
cop_fecha_pri_vto,         cop_banco_padre,           cop_fecha_ven_orig,     cop_fecha_can_ant,  --mta
cop_cuota_int_esp,         cop_cuota_iva_esp,         cop_fecha_ini_desp,     cop_fecha_fin_desp, --sro
cop_renovacion_grupal,     cop_renovacion_ind,        cop_meses_primer_op,    cop_periodicidad,
cop_dia_pago
from #operaciones
if @@error <> 0 begin
   select 
   @w_error = 724504,
   @w_msg = 'Error en al Grabar en table cob_externos..ex_dato_operacion'
   goto ERROR
end


/* REGISTRO DEL DETALLE DE SALDOS DIARIOS EN COB_EXTERNOS */

																																					   

insert into cob_externos..ex_dato_operacion_rubro
select 
dr_fecha            = @w_fecha_proceso,
dr_banco            = cop_banco,
dr_toperacion       = cop_toperacion,
dr_aplicativo       = cop_aplicativo,
dr_concepto         = am_concepto,
dr_estado           = case when am_estado in (@w_est_novigente, @w_est_vigente) then @w_est_vigente else am_estado end,
dr_exigible         = case when di_estado in (@w_est_vencido) then 1 else 0 end,
dr_codvalor         = co_codigo * 1000 + case when cop_estado = @w_est_etapa2 then @w_est_etapa2 when cop_estado <> @w_est_etapa2 and am_estado in (@w_est_novigente, @w_est_vigente) then @w_est_vigente else am_estado end * 10 + case when di_estado in(@w_est_vencido) then 1 else 0 end,
dr_valor            = isnull(sum(case when isnull(am_acumulado,0) - isnull(am_pagado,0) < 0 then 0 else isnull(am_acumulado,0) - isnull(am_pagado,0) end), 0),
dr_cuota            = isnull(sum(isnull(am_cuota,0)), 0),
dr_acumulado        = isnull(sum(isnull(am_acumulado,0)), 0),
dr_pagado           = isnull(sum(isnull(am_pagado,0)), 0),
dr_categoria        = co_categoria, 
dr_rubro_aso        = null,
dr_cat_rub_aso      = null
from #operaciones, ca_amortizacion, ca_dividendo, ca_concepto with (nolock)
where cop_operacion = am_operacion
and   am_concepto   = co_concepto
and   cop_operacion = di_operacion
and   am_dividendo  = di_dividendo
and   di_estado     in (@w_est_vigente, @w_est_novigente, @w_est_vencido)
group by cop_banco, cop_toperacion, cop_aplicativo, am_concepto, 
case when am_estado in (@w_est_novigente, @w_est_vigente) then @w_est_vigente else am_estado end, 
case when di_estado in (@w_est_vencido) then 1 else 0 end,
co_codigo * 1000 + case when cop_estado = @w_est_etapa2 then @w_est_etapa2 when cop_estado <> @w_est_etapa2 and am_estado in (@w_est_novigente, @w_est_vigente) then @w_est_vigente else am_estado end * 10 + case when di_estado in(@w_est_vencido) then 1 else 0 end,
co_categoria
if @@error <> 0 begin
   select 
   @w_error = 724504, 
   @w_msg = 'Error en al Grabar en table cob_externos..ex_dato_operacion_rubro'
   goto ERROR
end


/* REGISTRO DEL DETALLE DE SALDOS DIARIOS EN COB_EXTERNOS */ 
/* DIVIDENDO CANCELADOS */
-- LGU 2018-01-25

																																						   

insert into cob_externos..ex_dato_operacion_rubro
select 
@w_fecha_proceso,
cop_banco,
cop_toperacion,
cop_aplicativo,
am_concepto,
@w_est_cancelado,
@w_est_cancelado,
0,
isnull(sum(case when isnull(am_acumulado,0) - isnull(am_pagado,0) < 0 then 0 else isnull(am_acumulado,0) - isnull(am_pagado,0) end), 0),
isnull(sum(isnull(am_cuota,0)), 0),
isnull(sum(isnull(am_acumulado,0)), 0),
isnull(sum(isnull(am_pagado,0)), 0),
co_categoria,
null,
null
from #operaciones, ca_amortizacion, ca_dividendo, ca_concepto with (nolock)
where cop_operacion = am_operacion
and   am_concepto   = co_concepto
and   cop_operacion = di_operacion
and   am_dividendo  = di_dividendo
and   di_estado     = @w_est_cancelado
group by cop_banco, cop_toperacion, cop_aplicativo, am_concepto, co_categoria

if @@error <> 0 begin
   select 
   @w_error = 724504, 
   @w_msg = 'Error en al Grabar en table cob_externos..ex_dato_operacion_rubro DIV = CAN'
   goto ERROR
end

/******************************************************/

select dr_fecha    , dr_banco    , dr_toperacion, dr_aplicativo, 
       dr_concepto = case when dr_concepto = 'INT_ESPERA' then 'INT' else 'IVA_INT' end, 
       dr_estado   , dr_exigible  , 
       dr_codvalor  = case when dr_concepto = 'INT_ESPERA' then 
                            '11'+ substring(convert(varchar,dr_codvalor),3,len(convert(varchar,dr_codvalor)))
                      else 
                            '12'+ substring(convert(varchar,dr_codvalor),3,len(convert(varchar,dr_codvalor)))
                      end,
       dr_valor    , dr_cuota    , dr_acumulado , dr_pagado    , 
       dr_categoria = case when dr_concepto = 'INT_ESPERA' then 'I' else dr_categoria end, 
       dr_rubro_aso, dr_cat_rub_aso
into #rubros_especiales
from cob_externos..ex_dato_operacion_rubro with (nolock)
where dr_concepto in ('INT_ESPERA', 'IVA_ESPERA')


update cob_externos..ex_dato_operacion_rubro set
dr_valor     = isnull(d.dr_valor,0) + isnull(t.dr_valor,0),
dr_cuota     = isnull(d.dr_cuota,0) + isnull(t.dr_cuota,0),
dr_acumulado = isnull(d.dr_acumulado,0) + isnull(t.dr_acumulado,0),
dr_pagado    = isnull(d.dr_pagado,0) + isnull(t.dr_pagado,0)
from cob_externos..ex_dato_operacion_rubro d, 
     #rubros_especiales t with (nolock)
where d.dr_banco      = t.dr_banco
and   d.dr_concepto   = t.dr_concepto
and   d.dr_estado     = t.dr_estado
and   d.dr_exigible   = t.dr_exigible   
and   d.dr_codvalor   = t.dr_codvalor  


delete #rubros_especiales
from #rubros_especiales t,
     cob_externos..ex_dato_operacion_rubro d with (nolock)
where d.dr_banco      = t.dr_banco
and   d.dr_concepto   = t.dr_concepto 
and   d.dr_estado     = t.dr_estado
and   d.dr_exigible   = t.dr_exigible     
and   d.dr_codvalor   = t.dr_codvalor  


insert into cob_externos..ex_dato_operacion_rubro
select dr_fecha    , dr_banco    , dr_toperacion, dr_aplicativo, 
       dr_concepto , dr_estado   , dr_exigible  , 
       dr_codvalor ,
       dr_valor    , dr_cuota    , dr_acumulado , dr_pagado    , 
       dr_categoria, dr_rubro_aso, dr_cat_rub_aso
from #rubros_especiales

delete cob_externos..ex_dato_operacion_rubro
where dr_concepto in ('INT_ESPERA', 'IVA_ESPERA')
/******************************************************/



/* CCA 246 - DETERMINA LOS NUEVOS RUBROS QUE SE DEBEN INGRESAR EN LA TABLA EX_DATO_OPERACION_RUBRO PARA LOS DIFERIDOS */
update #diferidos
set adicionar = 'N'
from cob_externos..ex_dato_operacion_rubro with (nolock)
where rtrim(cop_banco)+rtrim(concepto) = rtrim(dr_banco)+rtrim(dr_concepto)

if @@error <> 0 begin
   select 
   @w_error = 724504, 
   @w_msg = 'Error al Actualizar el indicador de adicion en tabla #diferidos'
   goto ERROR
end

/* CCA 246 - REGISTRA RUBROS DE DIFERIDOS EN EX_DATO_OPERACION_RUBRO */
insert into cob_externos..ex_dato_operacion_rubro
select
@w_fecha_proceso,
o.cop_banco,
o.cop_toperacion, 
o.cop_aplicativo,
d.concepto,
@w_est_diferido,
0,
co_codigo * 1000 + @w_est_diferido * 10 + 0, -- diferido no exigible
valDiff,
0,0,0, co_categoria,null,null
from #diferidos d, #operaciones o, ca_concepto with (nolock)
where adicionar   = 'S'
and   o.cop_banco = d.cop_banco
and   concepto    = co_concepto
and   valDiff     > 0

if @@error <> 0 begin
   select 
   @w_error = 724504, 
   @w_msg = 'Error en al Grabar diferidos en tabla cob_externos..ex_dato_operacion_rubro'
   goto ERROR
end


update  cob_externos..ex_dato_operacion_rubro
set dr_rubro_aso = ru_concepto_asociado
from ca_rubro  with (nolock)
where ru_toperacion  = dr_toperacion
and   ru_concepto    = dr_concepto
and   dr_aplicativo  = 7

update  cob_externos..ex_dato_operacion_rubro
set dr_cat_rub_aso = co_categoria
from ca_rubro  , ca_concepto with (nolock)
where ru_toperacion  = dr_toperacion
and   ru_concepto    = dr_rubro_aso
and   dr_rubro_aso   = co_concepto
and   dr_aplicativo  = 7



/* REGISTRO DE LAS TRANSACCIONES DIARIAS EN COB_EXTERNOS */

--REQ425
insert into cob_externos..ex_dato_castigos
select @w_fecha_proceso,   tr_secuencial,       tr_banco, 
       tr_toperacion,      7,                   tr_fecha_ref,        
       tr_tran,            case when tr_secuencial > 0 then 'N' else 'S' end, 
       'D' ,               'OFI',               tr_ofi_usu,         
	   0,                   tr_usuario,         tr_terminal,        
	   tr_fecha_real
from  ca_transaccion with (nolock)
where tr_fecha_mov   = @w_fecha_proceso
and   tr_estado     <> 'RV'
and   tr_tran       in ('CAS')

   if @@error <> 0 
   begin 
       select @w_error = 724504, 
              @w_msg = 'Error en al Grabar en table cob_externos..ex_dato_castigos'
              goto ERROR
   end --REQ425

insert into cob_externos..ex_dato_transaccion
select 
@w_fecha_proceso,   tr_secuencial,       tr_banco, 
tr_toperacion,      7,                   tr_fecha_ref,        
tr_tran,            --case tr_tran when 'RPA' then 'PAG' else tr_tran end,            
case when tr_secuencial > 0 then 'N' else 'S' end, 
case when tr_tran = 'DES' then 'C' else 'D' end,
'OFI',-- OJO FALTA CANAL 
tr_ofi_usu,         0,                   tr_usuario, 
tr_terminal,        tr_fecha_real
from ca_transaccion with (nolock)
where tr_fecha_mov   = @w_fecha_proceso
and   tr_estado     <> 'RV'
and   tr_tran       in ('PAG', 'DES')

if @@error <> 0 begin 
   select 
   @w_error = 724504, 
   @w_msg = 'Error en al Grabar en table cob_externos..ex_dato_transaccion'
   goto ERROR
end

select op_banco, ab_secuencial_pag, ab_secuencial_rpa, sa_ssn_corr into #Operacion
from cob_cartera..ca_secuencial_atx, cob_cartera..ca_operacion, cob_cartera..ca_abono with (nolock)
where sa_fecha_ing      = ab_fecha_pag
and   sa_fecha_ing      = @w_fecha_proceso
and   sa_operacion      = op_banco
and   op_operacion      = ab_operacion
and   ab_secuencial_ing = sa_secuencial_cca
and   ab_estado         <> 'RV'

update cob_externos..ex_dato_transaccion set
dt_secuencial_caja = sa_ssn_corr
from #Operacion
where dt_banco = op_banco
and   dt_secuencial  = ab_secuencial_pag
and   dt_tipo_trans  = 'PAG'
if @@error <> 0 begin 
   select 
   @w_error = 724504, 
   @w_msg = 'Error en Actualizar secuencial PAG caja ex_dato_transaccion'
   goto ERROR
end

/* REGISTRO DEL DETALLE DE TRANSACCIONES DIARIAS EN COB_EXTERNOS */

--REQ425
insert into cob_externos..ex_dato_castigos_det
select @w_fecha_proceso,   tr_secuencial,  tr_banco,
       tr_toperacion,      7,              dtr_concepto,   
       dtr_moneda,         dtr_cotizacion, sum(dtr_monto),
       convert(varchar(24),dtr_codvalor) 
from  ca_det_trn, ca_transaccion with (nolock)
where tr_operacion   = dtr_operacion
and   tr_secuencial  = dtr_secuencial
and   tr_fecha_mov   = @w_fecha_proceso
and   tr_estado     <> 'RV'
and   tr_tran       in ('CAS')
and   dtr_concepto  not like 'VAC%'
group by tr_secuencial, tr_banco, tr_toperacion, dtr_concepto, dtr_moneda, dtr_cotizacion, dtr_afectacion, dtr_codvalor

   if @@error <> 0 
   begin
      select @w_error = 724504, 
             @w_msg = 'Error en al Grabar en table cob_externos..ex_dato_castigos_det'
             goto ERROR
   end --REQ425


insert into cob_externos..ex_dato_transaccion_det
(dd_fecha,      dd_secuencial, dd_banco,          
 dd_toperacion, dd_aplicativo, dd_concepto,       
 dd_moneda,     dd_cotizacion, dd_monto,          
 dd_codigo_valor, dd_dividendo)
select 
@w_fecha_proceso,   tr_secuencial,  tr_banco,
tr_toperacion,      7,              dtr_concepto,   
dtr_moneda,         dtr_cotizacion, sum(dtr_monto),
convert(varchar(24),dtr_codvalor), dtr_dividendo 
from ca_det_trn, ca_transaccion with (nolock)
where tr_operacion   = dtr_operacion
and   tr_secuencial  = dtr_secuencial
and   tr_fecha_mov   = @w_fecha_proceso
and   tr_estado     <> 'RV'
and   tr_tran       in ('PAG', 'DES', 'RPA')
and   dtr_concepto  not like 'VAC%'
group by tr_secuencial, tr_banco, tr_toperacion, dtr_concepto, dtr_moneda, dtr_cotizacion, dtr_afectacion, dtr_codvalor, dtr_dividendo


if @@error <> 0 begin
   select 
   @w_error = 724504, 
   @w_msg = 'Error en al Grabar en table cob_externos..ex_dato_transaccion_det'
   goto ERROR
end

/*ACTUALIZACION  DE LA FORMA DE DESMBOLSO "CAJA" */
update cob_externos..ex_dato_transaccion_det set
dd_concepto = 'CAJA'
from cob_externos..ex_dato_transaccion with (nolock)
where dt_banco      =  dd_banco
and   dt_fecha      =  dd_fecha
and   dt_secuencial =  dd_secuencial
and   dt_tipo_trans = 'DES'
and   dd_concepto in (select cp_producto from cob_cartera..ca_producto with (nolock) where cp_atx = 'S')
if @@error <> 0 begin
   select 
   @w_error = 724504, 
   @w_msg = 'Error en al ACTUALIZAR FORMA DESEMBOLSO "CAJA"  ex_dato_transaccion_det'
   goto ERROR
end

/*ACTUALIZACION  SECUENCIAL DE PAGO */
update cob_externos..ex_dato_transaccion_det set
dd_secuencial  = tr_secuencial
from cob_cartera..ca_transaccion with (nolock)
where tr_banco           =  dd_banco
and   tr_secuencial_ref  =  dd_secuencial
and   tr_tran            = 'PAG'

if @@error <> 0 begin
   select 
   @w_error = 724504, 
   @w_msg = 'Error en al ACTUALIZAR SECUENCIAL PAGO  ex_dato_transaccion_det'
   goto ERROR
end


/*INFORMACION FORMA DE PAGO, CANAL DE RECEPCION DE PAGO*/
select 
ab_secuencial_rpa, ab_secuencial_pag,  ab_operacion, ab_fecha_ing, isnull(cp_canal,'OFI') as cp_canal into #oper_canal
from cob_cartera..ca_abono, 
     cob_cartera..ca_abono_det,
     cob_cartera..ca_producto with (nolock)
where ab_secuencial_ing = abd_secuencial_ing
and   ab_operacion  = abd_operacion
and   abd_concepto  = cp_producto
and   ab_fecha_ing  = @w_fecha_proceso
and   abd_tipo not in (select codigo from cobis..cl_catalogo
                       where tabla = (select codigo from cobis..cl_tabla
                       where tabla = 'ca_excluir_conc'))

                       
update cob_externos..ex_dato_transaccion set
dt_canal = cp_canal
from #oper_canal,ca_operacion with (nolock)
where dt_fecha          = ab_fecha_ing
and   dt_secuencial     = ab_secuencial_rpa 
and   dt_banco          = op_banco
and   op_operacion      = ab_operacion
and   dt_aplicativo     = 7

if @@error <> 0 begin
   select 
   @w_error = 724504, 
   @w_msg = 'Error en Actualizar campo CANAL ex_dato_transaccion'
   goto ERROR
end

update cob_externos..ex_dato_transaccion set
dt_canal = cp_canal
from #oper_canal,ca_operacion with (nolock)
where dt_fecha          = ab_fecha_ing
and   dt_secuencial     = ab_secuencial_pag 
and   dt_banco          = op_banco
and   op_operacion      = ab_operacion
and   dt_aplicativo     = 7

if @@error <> 0 begin
   select 
   @w_error = 724504, 
   @w_msg = 'Error en Actualizar campo CANAL ex_dato_transaccion'
   goto ERROR
end


/* REGISTRO DEL DETALLE DE DEUDORES Y CODEUDORES DE LOS PRESTAMOS */

SELECT @w_prod_bancario = pd_producto 
FROM cobis..cl_producto 
WHERE pd_abreviatura = 'CCA'

insert into cob_externos..ex_dato_deudores
select 
@w_fecha_proceso,
cop_banco,
cop_toperacion,  
7,
cl_cliente,
ltrim(rtrim(cl_rol))
--from cob_credito..cr_deudores, ca_operacion, #operaciones
from cobis..cl_det_producto,
           cobis..cl_cliente, #operaciones with (nolock)
where  dp_cuenta        = cop_banco
and dp_det_producto  = cl_det_producto
and dp_producto     = @w_prod_bancario -- Req. 381 CB Red Posicionada
/*where op_tramite = de_tramite
and   op_banco   = cop_banco
and   op_cliente = de_cliente
and   op_operacion = cop_operacion
and   de_cliente = cop_cliente
*/
if @@error <> 0 begin
   select 
   @w_error = 724504, 
   @w_msg = 'Error en al Grabar en table cob_externos..ex_dato_deudores'
   goto ERROR
end


/* CCA 394 VENTA CARTERA CASTIGADA*/

insert into cob_externos..ex_venta_universo
select @w_fecha_proceso, 7, * from ca_venta_universo with (nolock)
where Fecha_Venta = @w_fecha_proceso

if @@error <> 0 begin
   select 
   @w_error = 724504, 
   @w_msg = 'Error en al Grabar en table cob_externos..ex_venta_universo'
   goto ERROR
end

/* INSERTAR DESMARCACIONES FNG SI EXISTEN PARA LA FECHA DE PROCESO */
insert into cob_externos..ex_desmarca_fng_his
select * from ca_desmarca_fng_his with (nolock)
where df_fecha      = @w_fecha_proceso
and   df_aplicativo = 7

if @@error <> 0 begin
   select 
   @w_error = 724504, 
   @w_msg = 'Error en al Grabar en tabla cob_externos..ex_desmarca_fng_his'
   goto ERROR
end

/* LCM - 293 - INSERTAR PAGOS POR RECONOCIMIENTO CON DEVOLUCION */
insert into cob_externos..ex_pago_recono
select @w_fecha_proceso   ,7              ,pr_banco    ,pr_trn        ,pr_fecha         ,pr_fecha_ult_pago   ,
       pr_vlr             ,pr_vlr_amort   ,pr_estado   ,pr_tipo_gar   ,pr_subtipo_gar   ,pr_3nivel_gar       ,
       pr_vlr_calc_fijo   ,pr_div_pend    ,pr_div_venc
from ca_pago_recono with (nolock)
where pr_estado <> 'R'

if @@error <> 0 begin
   select 
   @w_error = 724504, 
   @w_msg = 'Error en al Grabar en tabla cob_externos..ex_pago_recono'
   goto ERROR
end

/* LCM - 230 - INSERTAR CONDONACIONES */
insert into cob_externos..ex_condonacion
select
@w_fecha_proceso,   7,               co_secuencial,
op_banco,           op_cliente,      co_fecha_aplica,
co_valor,           co_porcentaje,   co_concepto,     
co_estado_concepto, co_usuario,      co_rol_condona,
co_autoriza,        co_estado
from ca_condonacion,ca_operacion with (nolock)
where co_operacion = op_operacion
and   co_fecha_aplica = @w_fecha_proceso
and   co_estado   <> 'R'

if @@error <> 0 begin
   select 
   @w_error = 724504, 
   @w_msg = 'Error en al Grabar en tabla cob_externos..ex_condonacion'
   goto ERROR
end

/* EJD -  INSERTAR ex_op_reest_padre_hija */

   select
   'fecha_proceso'  = @w_fecha_proceso,      -- FECHA PROCESO
   'producto'       = 7,
   'banco_padre'    = op_banco,
   'ph_banco_hija'  = op_banco,
   'ente'           = op_cliente,   
   'sec_reest'      = ph_sec_reest,
   'fecha'          = ph_fecha,
   'op_hija'        = ph_op_hija
   into #ex_op_reest_padre_hija
   from  ca_op_reest_padre_hija,ca_operacion with (nolock)
   where ph_op_padre    = op_operacion
     
   update #ex_op_reest_padre_hija
   set    ph_banco_hija = op_banco
   from   ca_op_reest_padre_hija,ca_operacion with (nolock)
   where  ph_op_hija    = op_operacion
   and    op_hija       = op_operacion
   
   if @@error <> 0 begin
      select 
      @w_error = 724504, 
      @w_msg = 'Error en Actualizar tabla #ex_op_reest_padre_hija'
   goto ERROR
   end
   
   insert into cob_externos..ex_op_reest_padre_hija
   select fecha_proceso,
          producto,
          banco_padre,
          ph_banco_hija,
          ente,
          sec_reest,
          fecha
   from #ex_op_reest_padre_hija
     
   if @@error <> 0 begin
      select 
      @w_error = 724504, 
      @w_msg = 'Error en Actualizar tabla ex_op_reest_padre_hija'
   goto ERROR
   end 


--req 375 TRASLADO CARTERA CANCELADA

   insert into cob_externos..ex_cartera_trasladada_canc  
   select
   et_fecha            = @w_fecha_proceso,
   et_aplicativo       =  7,
   et_nro_tramite      = tc_nro_tramite   ,
   et_cod_operacion    = tc_cod_operacion ,
   et_eje_origen       = tc_eje_origen   ,
   et_ofc_origen       = tc_ofc_origen   ,
   et_eje_destino      = tc_eje_destino  , 
   et_ofc_destino      = tc_ofc_destino  ,
   et_cod_cliente      = tc_cod_cliente  ,
   et_fec_cancelacion  = tc_fec_cancelacion,
   et_nota_del_credito = tc_nota_del_credito   
   from cob_cartera..ca_cartera_trasladada_canc with (nolock)
    
  
  if @@error <> 0 
     begin
        select @w_error = 710034, @w_msg = 'ERROR AL ACTUALIZAR TABLA ex_cartera_trasladada_canc '
        goto ERROR
     end   
            

truncate table cob_cartera..ca_cartera_trasladada_canc

/* AAMG -- 353 Insertar ex_dato_reajuste*/
insert into cob_externos..ex_dato_reajuste (
dr_fecha,               dr_aplicativo, 
dr_secuencial,          dr_operacion,     dr_fecha_crea,
dr_reajuste_especial,   dr_desagio,       dr_sec_aviso,
dr_concepto,            dr_referencial,   dr_signo,
dr_factor,              dr_porcentaje )
select
@w_fecha_proceso,       7,
re_secuencial,          re_operacion,     re_fecha,
re_reajuste_especial,   re_desagio,       re_sec_aviso,
red_concepto,           red_referencial,  red_signo,
red_factor,             red_porcentaje
from  cob_cartera..ca_reajuste, 
      cob_cartera..ca_reajuste_det  with (nolock)
where re_fecha      = @w_fecha_proceso
and   re_secuencial = red_secuencial
and   re_operacion  = red_operacion

if @@error <> 0 
begin
   select 
   @w_error = 724504, 
   @w_msg = 'Error en Actualizar tabla ex_dato_reajuste'
   goto ERROR
end 

insert into cob_externos..ex_msv_proc_ca ( 
mp_fecha,    mp_aplicativo,
mp_id_carga, mp_id_alianza, mp_tipo_tr,    mp_tramite, mp_tipo,        mp_banco, 
mp_estado,   mp_monto,      mp_toperacion, mp_tasa,    mp_descripcion, mp_fecha_proc )
select 
@w_fecha_proceso,       7,
mp_id_carga, mp_id_alianza, mp_tipo_tr,    mp_tramite, mp_tipo,        mp_banco, 
mp_estado,   mp_monto,      mp_toperacion, mp_tasa,    mp_descripcion, mp_fecha_proc
from cob_cartera..ca_msv_proc  with (nolock)
where  convert( varchar(10), mp_fecha_proc, 101) = @w_fecha_proceso

if @@error <> 0 
begin
   select 
   @w_error = 724504, 
   @w_msg = 'Error en Actualizar tabla ex_msv_proc_ca'
   goto ERROR
end 

--REQ486 PASO REPOSITORIO DATOS TRASLADOS CLIENTES
--OBTENIENDO DATOS DE TRASLADO DE CUENTAS DE CARTERA
insert into cob_externos..ex_traslado_ctas_ca_ah(
tc_fecha_corte,   tc_cliente,       tc_oficina_ini,
tc_oficina_fin,   tc_tipo_prod )
select distinct  
trc_fecha_proceso,       trc_cliente,       trc_oficina_origen,
trc_oficina_destino,     'A'
from cob_cartera..ca_traslados_cartera, cobis..cl_ente  with (nolock)
where  trc_cliente       = en_ente
and    trc_fecha_proceso = @w_fecha_proceso
order by trc_fecha_proceso, trc_cliente

if @@error <> 0 
begin
   select 
   @w_error = 724504, 
   @w_msg = 'ERROR AL INSERTAR EN EX_TRASLADO_CTAS_CA_AH'
   goto ERROR
end 

--REQ479 FINAGRO
insert into cob_externos..ex_val_oper_finagro(
vo_fecha,          vo_operacion,   vo_ced_ruc,     vo_tipo_ruc,
vo_oper_finagro,   vo_num_gar,     vo_aplicativo)
select 
@w_fecha_proceso,  vo_operacion,   vo_ced_ruc,     vo_tipo_ruc,
vo_oper_finagro,   vo_num_gar,     7
from  cob_cartera..ca_val_oper_finagro  with (nolock)
where vo_fecha = @w_fecha_proceso

if @@error <> 0 
begin
   select 
   @w_error = 724504, 
   @w_msg   = 'ERROR AL INSERTAR EN LA TABLA EX_VAL_OPER_FINAGRO'
   goto ERROR
end 

--NORMALIZACION DE CARTERA
insert into cob_externos..ex_normalizacion (
en_fecha,              en_aplicativo,               en_banco,
en_tramite,            en_banco_norm,               en_tramite_norm,
en_cliente,            en_tipo_norm)
select distinct
@w_fecha_proceso,      7,                           nm_operacion,
nm_tramite,            op_banco,                    op_tramite,             
nm_cliente,            nm_tipo_norm                      
from cob_cartera..ca_operacion, cob_credito..cr_normalizacion  with (nolock)
where op_fecha_liq = @w_fecha_proceso
and   op_estado    = 1
and   op_cliente   = nm_cliente

if @@error <> 0 begin
   select 
   @w_error = 724504, 
   @w_msg = 'Error en al Grabar en table cob_externos..ex_normalizacion'
   goto ERROR
end

/*******************************************************/
/* Datos Rotativos                                     */
/*******************************************************/

select 'banco'     = op_banco    ,
       'operacion' = op_operacion,
       'cliente'   = op_cliente  ,
       'tramite'   = op_tramite  
into #operaciones_rotativas                   
from #operaciones,
     cob_cartera..ca_operacion  with (nolock)
where op_banco             = cop_banco
and   op_tipo_amortizacion = 'ROTATIVA'


select cliente, 'conteo' = count(1)
into #renovaciones
from #operaciones_rotativas
group by cliente


select banco    ,
       operacion, 
       'div_maximo'= max(di_dividendo) - 1 
into #dividendo_max                       
from #operaciones_rotativas,
     cob_cartera..ca_dividendo  with (nolock)
where operacion      = di_operacion
group by banco, operacion


insert into cob_externos..ex_cuota_minima(	
        cm_fecha         , 	cm_aplicativo,    cm_banco       ,
        cm_monto         ,  cm_capital   ,    cm_interes     ,
        cm_iva_interes   ,  cm_comision  ,    cm_iva_comision)
select @w_fecha_proceso  ,  7            ,    banco,        
       pago_minimo    = sum(am_cuota),
       capital        = sum(case when am_concepto  = 'CAP' then  isnull(am_cuota, 0) else 0 end),
       interes        = sum(case when am_concepto  = 'INT' then  isnull(am_cuota, 0) else 0 end),
       iva_interes    = sum(case when am_concepto  = 'IVA_INT' then  isnull(am_cuota, 0) else 0 end),
       comisiones     = sum(case when am_concepto  in ('COM', 'COMMORA') then  isnull(am_cuota, 0) else 0 end),
       iva_comisiones = sum(case when am_concepto  in ('IVA_CMORA', 'IVA_COM') then  isnull(am_cuota, 0) else 0 end)
from #dividendo_max,
       cob_cartera..ca_dividendo,
       cob_cartera..ca_amortizacion  with (nolock)
where  operacion = di_operacion
and    div_maximo   = di_dividendo    
and    di_operacion = am_operacion 
and    di_dividendo = am_dividendo
group by banco


select @w_fecha_3_meses = dateadd(mm,-3,@w_fecha_proceso)
select @w_fecha_6_meses = dateadd(mm,-6,@w_fecha_proceso)

select  banco,
        operacion, 
        'maximo_dias' = max(datediff(dd,di_fecha_ven, isnull(di_fecha_can,@w_fecha_proceso))),
        'numero'      = count(1)
into #vencidas_3_meses
from #operaciones_rotativas,
     cob_cartera..ca_dividendo  with (nolock)
where operacion = di_operacion
and  di_fecha_ven  >=  @w_fecha_3_meses 
and  di_fecha_ven   < @w_fecha_proceso
and  di_estado     <> 0   
and  (di_fecha_ven < di_fecha_can or di_fecha_can is null)
group by banco, operacion

select  banco,
        operacion, 
        'maximo_dias' = max(datediff(dd,di_fecha_ven, isnull(di_fecha_can,@w_fecha_proceso))),
        'numero'      = count(1)
into #vencidas_6_meses
from #operaciones_rotativas,
     cob_cartera..ca_dividendo  with (nolock)
where operacion = di_operacion
and  di_fecha_ven  >=  @w_fecha_6_meses 
and  di_fecha_ven   < @w_fecha_proceso
and  di_estado     <> 0   
and  (di_fecha_ven < di_fecha_can or di_fecha_can is null)
group by banco, operacion


select banco, operacion, 'numero_incrementos' = count(1) + 1 , 'ultimo_inc' = max(ic_fecha_proceso)
into #incrementos
from #operaciones_rotativas, ca_incremento_cupo with (nolock)
where operacion =  ic_operacion    
group by banco, operacion


insert into cob_externos..ex_datos_lcr(
    dl_fecha                     ,
	dl_aplicativo                ,
    dl_banco                     ,
    dl_bloqueado                 )
select @w_fecha_proceso          ,
       7                         ,
       banco                     ,
       'NO'
from #operaciones_rotativas c

update cob_externos..ex_datos_lcr
set dl_dias_de_atraso_6_meses = isnull(maximo_dias,0),   
    dl_num_de_atraso_6_meses  = isnull(numero,0)    
from  #vencidas_6_meses
where dl_banco = banco 


update cob_externos..ex_datos_lcr
set dl_dias_de_atraso_3_meses = isnull(maximo_dias,0),   
    dl_num_de_atraso_3_meses  = isnull(numero,0)    
from  #vencidas_3_meses
where dl_banco = banco 


update cob_externos..ex_datos_lcr set 
dl_num_incrementos   = numero_incrementos,
dl_fecha_ult_aumento = ultimo_inc
from  #incrementos
where dl_banco = banco 

update cob_externos..ex_datos_lcr set 
dl_bloqueado            = case when lb_bloqueo = 'S' then  'SI'
                               when lb_bloqueo = 'N' then 'NO' end , 
dl_usuario_ult_modifica = lb_usuario_ult_mod
from #operaciones_rotativas,
     cob_cartera..ca_lcr_bloqueo with (nolock)
where lb_operacion = operacion
and   banco        = dl_banco

update cob_externos..ex_datos_lcr set 
dl_num_renovacion = conteo
from cob_cartera..ca_operacion,
     #renovaciones with (nolock)
where op_banco   = dl_banco
and   op_cliente = cliente 

select cliente, 
       banco_ant = max(op_banco)
into #renovacion       
from  #operaciones_rotativas,
      cob_cartera..ca_operacion with (nolock)
where cliente = op_cliente
and   op_tipo_amortizacion = 'ROTATIVA'
and   banco <> op_banco
group by cliente


update cob_externos..ex_datos_lcr set 
dl_credito_anterior = banco_ant
from cob_cartera..ca_operacion ,
     #renovacion with (nolock)
where op_banco   = dl_banco
and   op_cliente = cliente

-- Inicio Req.205892															
truncate table cob_externos..ex_operacion

insert into cob_externos..ex_operacion
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
and cop_fecha_apr_tramite  between @w_fecha_ini and @w_fecha_proceso
and tg_referencia_grupal <> tg_prestamo
order by cop_operacion
-- Fin Req.205892

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

go
