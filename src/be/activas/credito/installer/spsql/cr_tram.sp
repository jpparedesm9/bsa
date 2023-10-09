/***********************************************************************/
/* Archivo:             cr_tram.sp                                     */
/* Stored procedure:    sp_tramite                                     */
/* Base de  Datos:      cob_credito                                    */
/* Producto:            Credito                                        */
/* Disenado por:        Myriam Davila                                  */
/***********************************************************************/
/*                         IMPORTANTE                                  */
/* Este programa  es parte de los   paquetes bancarios propiedad de    */
/* "MACOSA",representantes exclusivos para   el Ecuador de  la         */
/* AT&T                                                                */
/* Su uso no   autorizado queda expresamente prohibido   asi   como    */
/* cualquier   autorizacion o agregado hecho por   alguno de   sus     */
/* usuario  sin   el debido   consentimiento por escrito de la         */
/* Presidencia Ejecutiva   de MACOSA   o  su representante             */
/***********************************************************************/
/*                         PROPOSITO                                   */
/* Este stored procedure:                                              */
/* inserta, actualiza o elimina un  registro en la tabla cr_tramite    */
/***********************************************************************/
/*  FECHA          AUTOR              RAZON                            */
/*  22/OCT/2009    Sylvia Nuñez       Requerimiento Datacredito        */
/*  03/MAR/2010    Gabriel Alvis      Req07 Cupos de Credito           */
/*  13/FEB/2011    Johnatan Zamora    Fecha_cierre en cliente_campan   */
/*  16/04/2013     A. Munoz           Req. 0353 Alianzas Comerciales   */
/***********************************************************************/

use cob_credito
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

if exists (select 1 from sysobjects where name = 'sp_tramite')
   drop proc sp_tramite
go


create proc sp_tramite (
@s_ssn                      int                    = null,
@s_user                     login                  = null,
@s_sesn                     int                    = null,
@s_term                     varchar(30)            = null,
@s_date                     datetime               = null,
@s_srv                      varchar(30)            = null,
@s_lsrv                     varchar(30)            = null,
@s_rol                      smallint               = null,
@s_ofi                      smallint               = null,
@s_org_err                  char(1)                = null,
@s_error                    int                    = null,
@s_sev                      tinyint                = null,
@s_msg                      descripcion            = null,
@s_org                      char(1)                = null,
@t_rty                      char(1)                = null,
@t_trn                      smallint               = null,
@t_debug                    char(1)                = 'N',
@t_file                     varchar(14)            = null,
@t_from                     varchar(30)            = null,
@i_operacion                char(1)                = null,
@i_tramite                  int                    = null,
@i_tipo                     char(1)                = null,
@i_truta                    tinyint                = null,
@i_oficina_tr               smallint               = null,
@i_usuario_tr               login                  = null,
@i_fecha_crea               datetime               = null,
@i_oficial                  smallint               = null,
@i_sector                   catalogo               = null,
@i_ciudad                   int                    = null,
@i_estado                   char(1)                = null,
@i_nivel_ap                 tinyint                = null,
@i_fecha_apr                datetime               = null,
@i_usuario_apr              login                  = null,
@i_numero_op_banco          cuenta                 = null,
/*   CAMPOS PARA TRAMITES DE GARANTIAS   */
@i_proposito                catalogo               = null,
@i_razon                    catalogo               = null,
@i_txt_razon                varchar(255)           = null,
@i_efecto                       catalogo           = null,
/*   CAMPOS PARA LINEAS DE   CREDITO  */
@i_cliente                  int                    = null,
@i_grupo                    int                    = null,
@i_fecha_inicio             datetime               = null,
@i_num_dias                 smallint = 0,
@i_per_revision             catalogo               = null,
@i_condicion_especial       varchar(255)           = null,
@i_rotativa                 char(1)                = null,
/*   OPERACIONES ORIGINALES Y RENOVACIONES  */
@i_linea_credito            cuenta                 = null,
@i_toperacion               catalogo               = null,
@i_producto                 catalogo               = null,
@i_monto                    money =  0,
@i_moneda                   tinyint  =  0,
@i_periodo                  catalogo               = null,
@i_num_periodos             smallint = 0,
@i_destino                  catalogo               = null,
@i_act_financiar            catalogo               = null, -- IB CCA 422
@i_ciudad_destino           int                    = null,
@i_cuenta_corriente         cuenta                 = null,
--  @i_garantia_limpia          char               = null,
--   SOLO PARA   PRESTAMOS   DE CARTERA
@i_monto_desembolso         money                  = null,
@i_reajustable              char(1)                = null,
@i_per_reajuste             tinyint                = null,
@i_reajuste_especial        char(1)                = null,
@i_fecha_reajuste           datetime               = null,
@i_cuota_completa           char(1)                = null,
@i_tipo_cobro               char(1)                = null,
@i_tipo_reduccion           char(1)                = null,
@i_aceptar_anticipos        char                   = null,
@i_precancelacion           char                   = null,
@i_tipo_aplicacion          char                   = null,
@i_renovable                char                   = null,
@i_fpago                    catalogo               = null,
@i_cuenta                   cuenta                 = null,
@i_direccion                tinyint                = null,
@i_origen_fondos            catalogo               = null,
@i_fondos_propios           char(1)                =  'N',
--   GENERALES
@i_renovacion               smallint               = null,
@i_cliente_cca              int                    = null,
@i_es_acta                  char(1)                = null,
@i_op_renovada              cuenta                 = null,
@i_deudor                   int                    = null,
--   REESTRUCTURACIONES
@i_op_reestructurar         cuenta                 = null,
--Financiamientos
@i_plazo                    smallint               = null,
@i_tplazo                   catalogo               = null,
/* PERSONALIZACION BCO DEL ESTADO   */
@i_rent_actual              float                  = null,
@i_rent_solicitud           float                  = null,
@i_rent_recomend            float                  = null,
@i_prod_actual              money                  = null,
@i_prod_solicitud           money                  = null,
@i_prod_recomend            money                  = null,
@i_clase                    catalogo               = null,
@i_admisible                money                  = null,
@i_noadmis                  money                  = null,
@i_relacionado              int                    = null,
@i_original                 cuenta                 = null,
@i_pondera                  float                  = null,
@i_subtipo                  char(1)                = null,
@i_tipo_producto            catalogo               = null,
@i_origen_bienes            catalogo               = null,
@i_localizacion             catalogo               = null,
@i_plan_inversion           catalogo               = null,
@i_naturaleza               catalogo               = null,
@i_tipo_financia            catalogo               = null,
@i_sobrepasa                char(1)                =  'N',
@i_forward                  char(1)                =  null,
@i_elegible                 char(1)                =  'N',  --Tipo de   cupo
@i_emp_emisora              int                    = null,
@i_num_acciones             smallint               = null,
@i_responsable              int                    = null,
@i_negocio                  cuenta                 = null,
@i_convierte_tasa           char(1)                = null,
@i_tasa_equivalente         char(1)                = null,
@i_reestructuracion         char(1)                = null,
@i_concepto_credito         catalogo               = null,
@i_aprob_gar                catalogo               = null,
@i_mercado_objetivo         catalogo               = null,
@i_tipo_productor           varchar(24)            = null,
@i_valor_proyecto           money                  = null,
@i_sindicado                char(1)                = null,
@i_margen_redescuento       float                  = null,
@i_asociativo               char(1)                = null,
@i_modo                     char(1)                = null,
@i_incentivo                char(1)                = null,
@i_fecha_eleg               datetime               = null,
@i_fecha_redes              datetime               = null,
@i_comite                   varchar(20)            = null,
@i_acta                     varchar(20)            = null,
@i_llave_redes              cuenta                 = null,
@i_solicitud                int                    = null,
@i_montop                   money                  = null,
@i_monto_desembolsop        money                  = null,
@i_operacion_pasiva         int                    = null,
@i_mercado                  catalogo               = null,
@i_dias_vig                 int                    = null,
@i_cod_actividad            catalogo               = null,     --Codigo   de actividad productiva
@i_num_desemb               int                    = null,       --Numero dedesembolso
@i_frad_aviso               datetime               = null,
@i_fsol_pago                datetime               = null,
@i_fprorg_icr               datetime               = null,
@i_fmeleg_icr               datetime               = null,
@i_num_comunic              varchar(16)            = null,
@i_fsol_req                 datetime               = null,
@i_flim_cump                datetime               = null,
@i_fenv_doc                 datetime               = null,
@i_observa                  descripcion            = null,
@i_fmax_aviso               datetime               = null,
@i_carta_apr                varchar(64)            = null,
@i_fecha_aprov              datetime               = null,
@i_fmax_redes               datetime               = null,
@i_f_prorroga               datetime               = null,
@i_formato_fecha            int                    = 103,
@i_nlegal_fi                catalogo               = null,
@i_sujcred                  catalogo               = null,
@i_fabrica                  catalogo               = null,
@i_callcenter               catalogo               = null,
@i_apr_fabrica              catalogo               = null,
@i_monto_solicitado         money                  = null,
@i_tipo_normal              char(1)                = null,
@i_tipo_plazo               catalogo               = null,
@i_tipo_cuota               catalogo               = null,
@i_plazocup                 smallint               = null,
@i_cuota_aproximada         money                  = null,
@i_fuente_recurso           varchar(10)            = null,
@i_tipo_credito             char(1)                = null,
@i_fecha_fija               char(1)                = null,
@i_dia_pago                 tinyint                = null,
@i_tasa_reest               float                  = null,
@i_motivo_reest             catalogo               = null,
@i_monto_renov              money                  = null,
@i_primera_instancia        int                    = null,     -- LPO REQ. Ejecutivo Master
@i_calificacion             char(1)                = null,     -- PAQUETE 2: REQ 260 - MIR VINCULANTE - 30/JUN/2011 - GAL
@i_tram_ext                 char(1)                = 'N',
@i_campana                  int                    = null,      --NJS REQ 236
@i_toperacion_pr            catalogo               = null,
@i_id_carga                 int                    = null,     -- Req. 353 Alianzas Comerciales
@i_id_alianza               int                    = null,     -- Req. 353 Alianzas Comerciales
@i_crea_ext                 char(1)                = null,     -- Req. 353 Alianzas Comerciales
@i_autoriza_central         char(1)                = null,
@i_cuota_prorrogar          int                    = null,     -- Req. 436 Normalizacion
@i_fecha_prorrogar          datetime               = null,     -- Req. 436 Normalizacion
@i_tipo_tramite             char(1)                = null,
@o_msg_msv                  varchar(255)           = null out, -- Req. 353 Alianzas Comerciales
@o_tramite_msv              int                    = null out
)
as
declare
    @w_sp_name                    varchar(32),
    @w_existe                     tinyint, 
    @w_tramite                    int,
    @w_tramite_retorno            int,
    @w_operacion_retorno          varchar(25),
    @w_truta                      tinyint ,
    @w_tipo                       char(1) ,
    @w_oficina_tr                 smallint,
    @w_usuario_tr                 login ,
    @w_fecha_crea                 datetime   ,
    @w_oficial                    smallint   ,
    @w_sector                     catalogo   ,
    @w_ciudad                     int ,
    @w_estado                     char(1) ,
    @w_nivel_ap  tinyint ,
    @w_fecha_apr                  datetime   ,
    @w_usuario_apr                login ,
    @w_secuencia                  smallint   ,
    @w_numero_op                  int,
    @w_numero_op_banco            cuenta,
    @w_aprob_por                  login,
    @w_nivel_por                  tinyint,
    @w_comite                     catalogo,
    @w_acta                       cuenta,
    @w_proposito                  catalogo   ,
    @w_razon                      catalogo   ,
    @w_txt_razon                  varchar(255),
    @w_efecto                     catalogo,
    @w_des_cla                    catalogo,
    @w_cliente                    int ,
    @w_grupo                      int ,
    @w_fecha_inicio               datetime   ,
    @w_num_dias                   smallint   ,
    @w_tipo_t_cla                 char(1),
    @w_per_revision               catalogo   ,
    @w_condicion_especial         varchar(255),
    @w_linea_credito              cuenta,
    @w_toperacion                 catalogo   ,
    @w_producto                   catalogo   ,
    @w_monto                      money ,
    @w_montop                     money ,
    @w_monto_desembolsop          money ,
    @w_monto_solicitado           money,
    @w_moneda                     tinyint,
    @w_periodo                    catalogo,
    @w_num_periodos               smallint,
    @w_destino                    catalogo,
    @w_ciudad_destino             int,
    @w_cuenta_corriente           cuenta  ,
    @w_renovacion                 smallint,
    @w_fecha_concesion            datetime,
    @w_dias_vig                   int,
    @w_rent_actual                float,
    @w_rent_solicitud             float,
    @w_rent_recomend              float,
    @w_prod_actual                money,
    @w_prod_solicitud             money,
    @w_prod_recomend              money,
    @w_clase                      catalogo,
    @w_admisible                  money,
    @w_noadmis                    money,
    @w_relacionado                int,
    @w_cont                       int,
    @w_numero_aux                 int,
    @w_linea                      int,
    @w_numero_linea               int,
    @w_prioridad                  tinyint,
    @o_tramite                    int,
    @o_linea_credito              cuenta,
    @o_numero_op                  cuenta,
    @w_estacion                   smallint,
    @w_etapa                      tinyint,
    @w_login                      login,
    @w_error                      int,
    @w_pondera                    float,
    @w_cupo_noad                  money,  /* PARA  CUPO  */
    @w_total_noad                 money,  /* TOTAL DE GAR   NO AD DE ES CUPO */
    @w_subtipo                    char(1),
    @w_tipo_producto              catalogo,
    @w_origen_bienes              catalogo,
    @w_localizacion               catalogo,
    @w_plan_inversion             catalogo,
    @w_naturaleza                 catalogo,
    @w_tipo_financia              catalogo,
    @w_sobrepasa                  char(1),
    @w_forward                    char(1),
    @w_elegible                   char(1),
    @w_emp_emisora                int,
    @w_num_acciones               smallint,
    @w_responsable                int,
    @w_negocio                    cuenta,
    @w_convierte_tasa             char(1),
    @w_tasa_equivalente           char(1),
    @w_reestructuracion           char(1),
    @w_concepto_credito           catalogo,
    @w_aprob_gar                  catalogo,
    @w_cont_admisible             char(1),
    @w_mercado_objetivo           catalogo,
    @w_tipo_productor             varchar(24),
    @w_valor_proyecto             money,
    @w_sindicado                  char(1),
    @w_margen_redescuento         float,
    @w_fecha_desembolso           datetime,
    @w_num_cupo                   int,
    @w_secuencial                 int,
    @w_asociativo                 char(1),
    @w_incentivo                  char(1),
    @w_fecha_eleg                 datetime,
    @w_fecha_redes                datetime,
    @w_llave_redes                cuenta,
    @w_solicitud                  int,
    @w_tramite_act                int,
    @w_operacion_pas              int,
    @w_operacion_act              int,
    @w_banco_nuevo                cuenta,
    @w_banco_activa               cuenta,
    @w_banco_pasiva               cuenta,
    @w_dias                       int,
    @w_fecha_vto                  datetime,
    @w_mercado                    catalogo,
    @w_tipo_amortiza              catalogo,
    @w_cod_actividad              catalogo,
    @w_num_desemb                 int,
    @w_carta_apr                  varchar(64),
    @w_fecha_aprov                datetime,
    @w_fmax_redes                 datetime,
    @w_f_prorroga                 datetime,
    @w_fechlimcum                 datetime,
    @w_sujcred                    catalogo,
    @w_sujcred_esp                catalogo,
    @w_fabrica                    catalogo,
    @w_callcenter                 catalogo,
    @w_apr_fabrica                catalogo,
    @w_nat_obl                    char(1),
    @w_banc_suj                   catalogo,
    @w_etapa_actual               int,
    @w_tipo_plazo                 catalogo,
    @w_tipo_cuota                 catalogo,
    @w_plazo                      smallint,
    @w_cuota_aproximada           money,
    @w_fuente_recurso             varchar(10),
    @w_tipo_credito               char(1),
    @w_pa_dimive                  tinyint,
    @w_pa_dimave                  tinyint,
    @w_tipo_etapa                 char(1),
    @w_secu_regen                 tinyint,
    @w_estacion_sec               smallint,
    @w_commit                     char(1),
    @w_msg                        varchar(100),
    @w_tr_tramite                 int,
    @w_ser_pub_vig                money,
    @w_ser_pub_mora               money,
    @w_cartera_viv                money,
    @w_endeudamiento              money,
    @w_dias_vig_hc                smallint,
    @w_orden                      int,
    @w_respuesta                  char(1),
    @w_total_cca                  money,
    @w_total_tdc                  money,
    @w_clase_cca                  catalogo,
    @w_monto_cca                  money,
    @w_linea_original             int,          -- GAL 03/MAR/2010 - REQ07 CUPOS DE CREDITO
    @w_rotativa                   char(1),      -- GAL 03/MAR/2010 - REQ07 CUPOS DE CREDITO
    @w_utilizado                  money,        -- GAL 03/MAR/2010 - REQ07 CUPOS DE CREDITO
    @w_est_can                    tinyint,      -- GAL 03/MAR/2010 - REQ07 CUPOS DE CREDITO
    @w_activa_req_paq2            char(1),      -- GAL 31/MAY/2010 - REQ07 CUPOS DE CREDITO
    @w_central                    varchar(2),    -- CIFIN o DATACREDITO
    @w_central_riesgo             catalogo,
    @w_tipo_persona               catalogo,
    @w_dictamen_final             char(1),
    @w_spread                     float,        --ADI 17/12/2010 - REQ204 TASAS PREFERENCIALES
    @w_signo                      char(1),      --ADI 17/12/2010 - REQ204 TASAS PREFERENCIALES
    @w_programa                   varchar(40),  -- JSA Req173.F3
    @w_return                     int,          -- JSA Req173.F3
    @w_banca                      catalogo,     -- JSA Req173.F3
    @w_montomx_tram_smv           money,        -- GAL 21/FEB/2011 - REQ 175: PEQUEÑA EMPRESA
    @w_smmlv                      money,        -- GAL 21/FEB/2011 - REQ 175: PEQUEÑA EMPRESA
    @w_tipo_pers                  varchar(10),  -- AZU CONTROL DE CAMBIO 235 (EMPLEADOS)
    @w_tip_func                   varchar(10),  -- AZU CONTROL DE CAMBIO 235 (EMPLEADOS)
    @w_filtro                     int,          -- AZU CONTROL DE CAMBIO 235 (EMPLEADOS)
    @w_banca_ruta                 char(1),
    @w_tipo_operacion             catalogo,      -- JAR REQ 246,
    --*-- INI JAR REQ 218 --*--
    @w_politica                   catalogo,
    @w_segmento                catalogo,
    @w_valor                      varchar(20),
    @w_evalua                     tinyint,
    @w_tasa_pref                  char(1),
    --*-- FIN JAR REQ 218 --*--
    @w_vig_fuente                 smallint,     -- GAL PAQUETE 1: REQ 216/231 - 19/ABR/2011
    @w_ofi_ccenter                smallint,     -- GAL PAQUETE 1: REQ 216/231 - 19/ABR/2011
    @w_primera_instancia          int,          -- LPO Paquete 2
    -- INI JAR Paquete 2 REQ 215 Pequqña Empresa F.4.
    @w_max_riesgo                 money,
    @w_tipo_tr                    char(1),
    @w_monto_tr                   money,    
    @w_reservado                  money,
    -- INI JAR Paquete 2 REQ 215 Pequqña Empresa F.4.
    @w_calificacion               char(1),       -- PAQUETE 2: REQ 260 - MIR VINCULANTE CALIFICACION - 30/JUN/2011 - GAL
    @w_estacion_oficial           smallint,
    @w_cod_gar_fng                catalogo,
    @w_master                     int,           --Incidencia 43762 Ejecutivo Master
    @w_oficina_master             int,            --Incidencia 43762 Ejecutivo Master
    @w_tramite_if                 int,
    @w_fecha_proc                 datetime,
    @w_gar_op                     varchar(64),
    @w_plazot121                  int,
    @w_estacion_ema               smallint,
    @w_ema                        char(1),
    @w_opi                        char(1),   --Req 0352 Oficinas OPI
    @w_alianza                    int,
    @w_valor_alianza              int,
    @w_msg_alianza                varchar(255),
    @w_tramite_msv                int,
    @w_cedula                     numero,
    @w_dia_pago_archiv            int,
    @w_fecha_pago                 char(1),
    @w_al_toperacion              varchar(10),
    @w_al_dia_pago                int,
    @w_al_monto                   money,
    @w_alto_riesgo                char(1),
	@w_miembros 				  int--SRO

/*INICIAR VARIABLES DE TRABAJO*/
select
@w_commit       = 'N',    
@w_sp_name      =  'sp_tramite',
@i_cliente      =  isnull(@i_cliente,@i_cliente_cca),
@i_fecha_inicio =  @s_date,
@w_tipo_operacion = @i_toperacion  -- JAR REQ 246

/*TRAE LA FECHA DE PROCESO*/
select @w_fecha_proc = fp_fecha 
from   cobis..ba_fecha_proceso

if @i_tipo = 'E' select @w_tipo_operacion = @i_toperacion_pr -- JAR REQ 246
   
/* PARAMETRO EMPLEADO */
select @w_tip_func = pa_char
from  cobis..cl_parametro
where pa_producto = 'MIS'
and   pa_nemonico = 'TIPFUN'

/* CONTROLAR DIA MINIMO DEL MES PARA FECHAS DE VENCIMIENTO */
select @w_pa_dimive = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'DIMIVE'
and   pa_producto = 'CCA'

if @@rowcount = 0 begin
   select @w_error = 2101084, @w_msg = 'NO SE ENCUENTRA EL PARAMETRO GENERAL DIMIVE DE CARTERA'
   goto ERRORFIN
end

/* CONTROLAR DIA MAXIMO DEL MES PARA FECHAS DE VENCIMIENTO */
select @w_pa_dimave = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'DIMAVE'
and   pa_producto = 'CCA'

if @@rowcount = 0 begin
   select @w_error = 2101084, @w_msg = 'NO SE ENCUENTRA EL PARAMETRO GENERAL DIMIVE DE CARTERA'
   goto ERRORFIN
end

--- CODIGO PADRE DE GARANTIAS FNG
select @w_cod_gar_fng = pa_char
from cobis..cl_parametro with (nolock)
where pa_producto  = 'GAR'
and   pa_nemonico  = 'CODFNG'

select @w_dias_vig_hc = pa_smallint 
from cobis..cl_parametro
where pa_nemonico = 'VIDFDC'
and pa_producto = 'MIS'

if @w_dias_vig_hc is null
   select @w_dias_vig_hc = 30

   
select @w_est_can = pa_tinyint
from  cobis..cl_parametro
where pa_nemonico = 'ESTCAN'
and   pa_producto = 'CRE'


select @w_activa_req_paq2 = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CRE'
and    pa_nemonico = 'ACTRP2'  

if @w_activa_req_paq2 is null
   select @w_activa_req_paq2 = 'N'
   
-- SALARIO M-NIMO MENSUAL LEGAL VIGENTE
select @w_smmlv = pa_money
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'SMV'

-- INI - PAQUETE 1 2011: REQ 216/231
select @w_ofi_ccenter = pa_smallint
from cobis..cl_parametro
where pa_producto = 'MIS'
and   pa_nemonico = 'OFCACE'

if @@rowcount = 0
   return 101077
   
select @w_vig_fuente = pa_smallint
from cobis..cl_parametro
where pa_producto = 'CRE'
and   pa_nemonico = 'VIGFUE'

if @@rowcount = 0
   return 101077
-- FIN - PAQUETE 1 2011: REQ 216/231   
   
if @i_moneda = 0 select @i_montop = @i_monto

--if  @i_dia_pago< @w_pa_dimive or @i_dia_pago > @w_pa_dimave
--begin
--    select @i_dia_pago=15
--    print 'Dia de pago fijo no esta en el rango de dias definido para el pago ' + cast(@w_pa_dimive as varchar) + '-' + cast(@w_pa_dimave as varchar)+ ' se coloca el dia 15 por defecto'
--end

if @i_id_alianza is null 
begin 
   select @i_id_alianza = al_alianza  
   from cobis..cl_alianza, cobis..cl_alianza_cliente
   where al_alianza = ac_alianza
   and   ac_ente    = @i_cliente 
   and   ac_estado  = 'V'
   and   al_estado  = 'V'
end

-- ALIANZAS COMERCIALES: ( "Fecha Pago fijo" es un campo de la caracterizacion de la alianza ) 
-- Si es un tramite de alianzas MASIVO:
--    "Fecha Pago fijo" = 'S'-> El día de pago que esta parametrizado en la alianza, sin importar lo que tenga el archivo plano.
--    "Fecha Pago fijo" = 'N'-> Se toma el dia que esta en el archivo plano 
-- Si es un tramite de alianzas Front End:
--    "Fecha Pago fijo" = 'S'-> El día de pago que esta parametrizado en la alianza, Saldra mensaje informativo.
--    "Fecha Pago fijo" = 'N'-> Se validara normalmente el dia de pago.
select @w_fecha_pago      = 'N' 
select @w_dia_pago_archiv = @i_dia_pago -- Se guarda dia de pago que viene por archivo plano
if @i_id_alianza is not null and @i_tipo in ( 'O', 'T', 'U' ) 
begin      

   exec @w_error = sp_default_alianza
   @i_alianza            = @i_id_alianza,
   @o_toperacion         = @w_al_toperacion out,
   @o_dia_pago           = @w_al_dia_pago   out, 
   @o_monto_promedio     = @w_al_monto      out,
   @o_fecha_pago         = @w_fecha_pago    out

   if @w_error <> 0 begin
      select @w_msg = 'ERROR AL EJECUTAR EL PROCESO sp_default_alianza DE Credito'
      goto ERRORFIN
   end
   -- Se toma el default debido a que en el archivo de tramites masivos originales no viene el dia de pago.
   if @i_tipo = 'O' and isnull( @i_crea_ext,'N')  = 'S' 
   begin 
      select @i_dia_pago = isnull(@i_dia_pago, 0) 
      if @i_dia_pago = 0 
         select @i_dia_pago = dt_dia_pago  from cob_cartera..ca_default_toperacion where dt_toperacion = @w_al_toperacion

      if @i_dia_pago < @w_pa_dimive or @i_dia_pago > @w_pa_dimave
      begin 
         --select @w_cedula = en_ced_ruc from cobis..cl_ente where en_ente = @i_cliente
         select @i_dia_pago = isnull( @i_dia_pago,0)
         select @o_msg_msv = 'DIA DE PAGO NO ESTA EN RANGO PERMITIDO PARA CREAR TRAMITES. DIA: '+ convert( varchar(10), @i_dia_pago) + ' (sp_tramite).'
         select @w_msg = @o_msg_msv
         select @w_error = 1
         goto ERRORFIN
         --return 1    
      end
      
      select @w_dia_pago_archiv = @i_dia_pago
   end 

   if @i_toperacion is null
      select @i_toperacion = @w_al_toperacion

   if @i_monto is null or @i_monto = 0
      select @i_monto = @w_al_monto

   if @i_monto_desembolso is null or @i_monto_desembolso = 0
      select @i_monto_desembolso = @w_al_monto

   if isnull( @i_crea_ext,'N')  = 'S' 
   begin
      -- Por Masivo. Se Utiliza el día de pago que esta parametrizado en la alianza, sin importar lo que tenga el archivo plano
      if @w_fecha_pago = 'S' begin
         select @i_dia_pago = @w_al_dia_pago
      end else begin
         if @i_tipo <> 'O' 
         begin
            if @i_dia_pago < @w_pa_dimive or @i_dia_pago > @w_pa_dimave
            begin 
               select @w_cedula = en_ced_ruc from cobis..cl_ente where en_ente = @i_cliente
               select @o_msg_msv = 'El tipo de operacion '+ @i_toperacion + ', con dia pago '+ convert( varchar(10), @i_dia_pago) + ' no valido. (sp_tramite).'
               select @w_msg = @o_msg_msv
               select @w_error = 1
               goto ERRORFIN
            end
         end
      end
   end 
   else 
   begin
      --Por Front end
      if @w_fecha_pago = 'S'  -- Alianza
      begin 
         if  @i_dia_pago is not null and @i_dia_pago <> @w_al_dia_pago    
         begin
            select @w_msg = 'DIA DE PAGO DEFINIDO POR LA CARACTERIZACION DE LA ALIANZA ES: '+ convert( varchar(10), @w_al_dia_pago )
            print @w_msg 
         end
         select @i_dia_pago = @w_al_dia_pago   -- Alianza
      end
   end 
end

if @i_id_alianza is null 
begin      
   exec @w_error = cob_cartera..sp_verifica_fecha   -- use cob_cartera   sp_helptext sp_verifica_fecha
        @i_toperacion = @i_toperacion,
        @i_dia_pago   = @i_dia_pago 
           
   if @w_error <> 0
      goto ERRORFIN
end   


if @i_usuario_tr = 'AUTOMATICO' begin

   select @w_banc_suj = en_banca
   from   cobis..cl_ente
   where  en_ente =  @i_cliente
   
   select @i_mercado_objetivo = codigo
   from   cr_corresp_sib
   where  tabla = 'T61'
   and    codigo_sib =  @w_banc_suj
   
   select @i_mercado =  codigo
   from   cr_corresp_sib
   where  tabla = 'T62'
   and    codigo_sib =  @w_banc_suj
   
   select @i_sujcred =  codigo
   from   cr_corresp_sib
   where  tabla = 'T63'
   and    codigo_sib =  @w_banc_suj
   
   select @w_etapa_actual = pa_etapa
   from   cr_pasos
   where  pa_truta   =  @i_truta
   and    pa_paso =  1
   
   select @i_elegible = 'N'

   exec @w_error = SP_ASIGNACION_2
   @s_ssn       = @s_ssn,
   @s_user      = @s_user,
   @s_date      = @s_date,
   @i_oficina   = @i_oficina_tr,
   @i_etapa     = @w_etapa_actual,
   @o_estacion  = @w_estacion out
   
   if @w_error <> 0 begin
      select @w_msg = 'ERROR AL EJECUTAR EL PROGRAMA SP_ASIGNACION_2'
      goto ERRORFIN
   end
   
   select @i_usuario_tr  =  es_usuario
   from   cr_estacion
   where  es_estacion    =  @w_estacion
end



if @i_operacion <> 'Q' begin

   /* CHEQUEO DE EXISTENCIAS */
   select
   @w_tramite                 = tr_tramite,
   @w_truta                   = tr_truta,
   @w_tipo                    = tr_tipo,
   @w_oficina_tr              = tr_oficina,
   @w_usuario_tr              = tr_usuario,
   @w_fecha_crea              = tr_fecha_crea,
   @w_oficial                 = tr_oficial,
   @w_sector                  = tr_sector,
   @w_ciudad                  = tr_ciudad,
   @w_estado                  = tr_estado,
   @w_nivel_ap                = tr_nivel_ap ,
   @w_fecha_apr               = tr_fecha_apr,
   @w_usuario_apr             = tr_usuario_apr ,
   @w_numero_op               = tr_numero_op,
   @w_numero_op_banco         = tr_numero_op_banco,
   @w_aprob_por               = tr_aprob_por,
   @w_nivel_por               = tr_nivel_por,
   @w_comite                  = tr_comite,
   @w_acta                    = tr_acta,
   @w_proposito               = tr_proposito,
   @w_razon                   = tr_razon,
   @w_txt_razon               = rtrim(tr_txt_razon),
   @w_efecto                  = tr_efecto,
   @w_cliente                 = tr_cliente,
   @w_grupo                   = tr_grupo,
   @w_fecha_inicio            = tr_fecha_inicio,
   @w_num_dias                = tr_num_dias,
   @w_per_revision            = tr_per_revision,
   @w_condicion_especial      = tr_condicion_especial,
   @w_numero_linea            = tr_linea_credito,
   @w_toperacion              = tr_toperacion,
   @w_producto                = tr_producto,
   @w_monto                   = tr_monto,
   @w_montop                  = tr_montop,
   @w_monto_desembolsop       = tr_monto_desembolsop,
   @w_moneda                  = tr_moneda,
   @w_periodo                 = tr_periodo,
   @w_num_periodos            = tr_num_periodos,
   @w_destino                 = tr_destino,
   @w_ciudad_destino          = tr_ciudad_destino,
   @w_cuenta_corriente        = tr_cuenta_corriente,
   @w_renovacion              = tr_renovacion,
   @w_rent_actual             = tr_rent_actual,
   @w_rent_solicitud          = tr_rent_solicitud,
   @w_rent_recomend           = tr_rent_recomend,
   @w_prod_actual             = tr_prod_actual,
   @w_prod_solicitud          = tr_prod_solicitud,
   @w_prod_recomend           = tr_prod_recomend,
   @w_clase                   = tr_clase,
   @w_admisible               = tr_admisible,
   @w_noadmis                 = tr_noadmis,
   @w_relacionado             = tr_relacionado,
   @w_pondera                 = tr_pondera,
   @w_subtipo                 = tr_subtipo,
   @w_tipo_producto           = tr_tipo_producto,
   @w_origen_bienes           = tr_origen_bienes,
   @w_localizacion            = tr_localizacion,
   @w_plan_inversion          = tr_plan_inversion,
   @w_naturaleza              = tr_naturaleza,
   @w_tipo_financia           = tr_tipo_financia,
   @w_sobrepasa               = tr_sobrepasa,
   @w_forward                 = tr_forward,
   @w_elegible                = tr_elegible,
   @w_emp_emisora             = tr_emp_emisora,
   @w_num_acciones            = tr_num_acciones,
   --@w_responsable             = tr_responsable,
   @w_primera_instancia       = tr_responsable,         -- LPO REQ. Ejecutivo Master
   @w_negocio                 = tr_negocio,
   @w_reestructuracion        = tr_reestructuracion,
   @w_concepto_credito        = tr_concepto_credito,
   @w_aprob_gar               = tr_aprob_gar,
   @w_cont_admisible          = tr_cont_admisible,
   @w_mercado_objetivo        = tr_mercado_objetivo,
   @w_tipo_productor          = tr_tipo_productor,
   @w_valor_proyecto          = tr_valor_proyecto,
   @w_sindicado               = tr_sindicado,
   @w_margen_redescuento      = tr_margen_redescuento,
   @w_asociativo              = tr_asociativo,
   @w_incentivo               = tr_incentivo,
   @w_fecha_eleg              = tr_fecha_eleg,
   @w_fecha_redes             = tr_fecha_redes,
   @w_llave_redes             = tr_llave_redes,
   @w_solicitud               = tr_solicitud,
   @w_mercado                 = tr_mercado,
   @w_dias_vig                = tr_dias_vig,
   @w_cod_actividad           = tr_cod_actividad,
   @w_num_desemb              = tr_num_desemb,
   @w_sujcred                 = tr_sujcred,
   @w_fabrica                 = tr_fabrica,
   @w_callcenter              = tr_callcenter,
   @w_apr_fabrica             = tr_apr_fabrica,
   @w_monto_solicitado        = tr_monto_solicitado,
   @w_tipo_plazo              = tr_tipo_plazo,
   @w_tipo_cuota              = tr_tipo_cuota,
   @w_plazo                   = tr_plazo,
   @w_cuota_aproximada        = tr_cuota_aproximada,
   @w_fuente_recurso          = tr_fuente_recurso,
   @w_tipo_credito            = tr_tipo_credito,
   @w_central                 = tr_central
   from cr_tramite
   where tr_tramite =  @i_tramite
   
   if @@rowcount > 0
   begin
      select @w_existe = 1
      
      -- INI - GAL 13/OCT/2010 - INC 12823
      if @w_central is null
      begin
         exec @w_error = sp_central_riesgo
         @i_tramite = @i_tramite,
         @i_backend = 'S',
         @o_central = @w_central    out
         
         if @w_error <> 0
         begin
            select @w_msg = 'ERROR EN DETERMINACION DE CENTRAL DE RIESGO'
            goto ERRORFIN
         end
      end
      -- FIN - GAL 13/OCT/2010
   end
   else
      select @w_existe = 0

      
   select
   @w_secuencia    =  rt_secuencia,
   @w_tipo_etapa   =  et_tipo,
   @w_estacion_sec =  rt_estacion
   from    cr_ruta_tramite, cr_etapa
   where   rt_tramite = @i_tramite
   and     rt_salida is NULL
   and     rt_etapa   = et_etapa
   
   if @@rowcount = 0 begin  
   
      select @w_secuencia = max(rt_secuencia)
      from   cr_ruta_tramite
      where  rt_tramite =  @i_tramite
      
      select
      @w_tipo_etapa   =  et_tipo,
      @w_estacion_sec =  rt_estacion
      from    cr_ruta_tramite, cr_etapa
      where   rt_tramite   = @i_tramite
      and     rt_secuencia = @w_secuencia
      and     rt_etapa     = et_etapa

   end

      
   /* CHEQUEO DE LINEA DE CREDITO  */
   if @i_linea_credito is not null begin
   
      select @w_numero_linea = li_numero
      from cob_credito..cr_linea
      where li_num_banco = @i_linea_credito
      
      if @@rowcount  =  0 begin
         select @w_error = 2101010, @w_msg = 'NO EXISTE LA LINEA DE CREDITO: ' + @i_linea_credito
         goto ERRORFIN
      end
   end

   /* CHEQUEO DE  NUMERO DE   OPERACION   */
   if @i_producto = 'CCA' and @i_numero_op_banco is not null  begin

      if not exists(select 1 from cob_cartera..ca_operacion
      where op_banco = @i_numero_op_banco) begin
         select @w_error = 2101011, @w_msg = 'NO SE ENCUENTRA EL PRESTAMO: ' + @i_numero_op_banco
         goto ERRORFIN
      end
         
   end
end

   

if @i_operacion = 'F' -- Validacion de FNG
begin
    
   if exists(select 1
             from cob_custodia..cu_custodia with (nolock),
                  cob_credito..cr_gar_propuesta with (nolock),
                  cob_cartera..ca_operacion with (nolock),
                  cob_custodia..cu_tipo_custodia with (nolock)
             where gp_tramite       = op_tramite
               and op_banco         = @i_numero_op_banco
               and gp_garantia      = cu_codigo_externo
               and cu_estado        in ('V', 'X')
               and cu_tipo          = tc_tipo
               and tc_tipo_superior = @w_cod_gar_fng
            )
   begin
      if @i_crea_ext is null
      begin
         print 'El prestamo ' + @i_numero_op_banco + ' tiene una garantia FNG, este tipo de garantias no permiten hacer Renovaciones marcadas como Reestructuracion.'
         -- REGISTRO NO EXISTE
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file, 
              @t_from  = @w_sp_name,
              @i_num   = 2103001
         return 2103001
      end
      else
      begin
         select @o_msg_msv = 'El prestamo ' + @i_numero_op_banco + ' tiene una garantia FNG, este tipo de garantias no permiten hacer Renovaciones marcadas como Reestructuracion, ' + @w_sp_name
         select @w_return = 2103001
         return @w_return
      end
   end
end


if @i_operacion =  'I' or @i_operacion =  'U'
begin

   select @w_alianza = null

   select @w_alianza = ac_alianza
   from cobis..cl_alianza_cliente with (nolock),
        cobis..cl_alianza         with (nolock)
   where ac_ente = @i_cliente
      and ac_alianza = al_alianza
      and ac_estado  = 'V'
      and al_estado  = 'V'

   if @i_operacion = 'I' and @i_tipo in ('C','O','U','T') --No hay definicion para Renovaciones,las Alianzas fueron definidas solo
   begin                                                  --para aceptar Cupos (con sus Utilizaciones y Unificaciones) y Originales. 
      if @w_alianza is not null
      begin
         exec @w_return = sp_validacion_alianza
         @i_ente           = @i_cliente,
         @i_alianza        = @w_alianza,
         @i_toperacion     = @i_toperacion,
         @i_tipo_credito   = @i_tipo,
         @o_valor          = @w_valor_alianza out,
         @o_msg            = @w_msg_alianza   out

         if @w_return <> 0
         begin
            if @i_crea_ext is null
               print 'No se puede Crear el tramite. Error Ejecutando sp_validacion_alianza.'
            else
               select @o_msg_msv = 'No se puede Crear el tramite. Error Ejecutando sp_validacion_alianza. ' + @w_sp_name
               
            return @w_return
         end          

         if @w_valor_alianza <> 0  --No pasa las validaciones de Alianzas. No se puede crear el tramite
         begin
            if @i_crea_ext is null
               print 'No se puede Crear el tramite. No cumplio Validaciones de Alianzas. ' + isnull(@w_msg_alianza,'---')
            else
               select @o_msg_msv = 'No se puede Crear el tramite. No cumplio Validaciones de Alianzas. ' + isnull(@w_msg_alianza,'---') + '. ' + @w_sp_name
               
            return 1
         end
      end
   end
   
   if @i_operacion = 'U' and @i_tipo in ('C','O','U','T') --No hay definicion para Renovaciones,las Alianzas fueron definidas solo
   begin                                                  --para aceptar Cupos (con sus Utilizaciones y Unificaciones) y Originales. 
      if @w_alianza is not null
      begin
         --2. No se debera poder asignar una linea de credito diferente a las aprobadas por la Alianza Comercial
         if @i_toperacion is not null
         begin
            if not exists(select 1
                          from cobis..cl_alianza_linea with (nolock)
                          where al_alianza = @w_alianza
                          and   al_linea   = @i_toperacion)
            begin
               print 'CLIENTE ALIANZA, NO SE PERMITE MODIFICAR LA LINEA'
               select @w_error = 2105002, @w_msg = 'ERROR AL ACTUALIZAR EL TRAMITE: ' + convert(varchar, @i_tramite)
               goto ERRORFIN
            end
         end
      end
   end
   
   -- INI LPO REQ. Ejecutivo Master
   -- 436 Normalizacion se agrega tipo de tramite M
   if @i_tipo in ('C','O','R','E','M')
   begin
      if @i_sector = '1' --Banca Microcredito
      begin         
         select @w_estacion_oficial = es_estacion,
                @w_oficina_master   = es_oficina,
                @w_ema              = es_ema,
                @w_master           = es_master
         from cob_credito..cr_estacion with (nolock),
              cobis..cc_oficial with (nolock),
              cobis..cl_funcionario with (nolock)
         where es_usuario     = fu_login
           and oc_funcionario = fu_funcionario
           and oc_oficial     = @i_oficial
           
         /*DETERMINA SI LA OFICINA ES OPI*/      
        select @w_opi = to_opi
        from cob_credito..cr_tipo_oficina
        where to_oficina = @w_oficina_master
        
        if @w_ema = 'S' and @w_opi = 'N'
        begin
			select @w_error = 2101014, @w_msg = 'EMA no Puede manejar Cartera en este tipo de Oficina'
            goto ERRORFIN
        end
         
        select @i_primera_instancia = null
        
        if @w_opi = 'N'
        begin
			if @w_master is not null
				select @i_primera_instancia = @w_master
			else
			begin
				select @w_estacion_ema  = es_estacion
				from cob_credito..cr_estacion with (nolock)
				where es_oficina = @w_oficina_master
				  and es_ema     = 'S'
	               
				if @w_estacion_ema is not null
				begin
	       			select @i_primera_instancia = es_estacion
					from cob_credito..cr_estacion
					where es_estacion_sup is not null
					and es_oficina  = @w_oficina_master
					and es_estacion <> @w_estacion_ema
				end
				else
				begin
					select @i_primera_instancia = es_estacion
					from cob_credito..cr_estacion
					where es_estacion_sup is not null
					  and es_oficina  = @w_oficina_master
				end
			end            
         end
         else
         begin
            select @i_primera_instancia = es_estacion
            from cob_credito..cr_estacion with (nolock)
            where es_oficina = @w_oficina_master
              and es_ema     = 'S'
         end
         
         if @i_primera_instancia is null
         begin
			select @w_error = 2101014, @w_msg = 'POR FAVOR REVISAR LA PRIMERA INSTANCIA DE APROBACION PARA ESTA OFICINA'
            goto ERRORFIN
         end  
      end
      
      if @i_sector <> '1' and @i_primera_instancia is null  --Otras Bancas
      begin
         select @w_error = 2101014, @w_msg = 'POR FAVOR INDICAR QUIEN RECIBIRA EL TRAMITE EN APROBACION'
         goto ERRORFIN
      end
   end  
   -- FIN LPO REQ. Ejecutivo Master
   
   if not exists ( select 1 from cobis..cl_oficina
   where of_oficina = @i_oficina_tr
   and   of_subtipo = 'O')
   begin
      select @w_error = 2108015, @w_msg = 'SE ADMITEN TRAMITES SOLO EN OFICINAS DE SUBTIPO -O- (cl_oficina)'
      goto ERRORFIN
   end
    
   if exists(select 1 from cr_corresp_sib
   where  tabla   =  'T21'
   and    codigo_sib =  convert(varchar(10),@i_oficina_tr))
   begin
      select @w_error = 2108015, @w_msg = 'NO SE ADMITEN TRAMITES EN OFICINAS PARAMETRIZADAS EN LA TABLA T21 (cr_corresp_sib)'
      goto ERRORFIN
   end
   
   /**   OBTENER  PRIORIDAD   **/
   select @w_prioridad = tt_prioridad
   from   cr_tipo_tramite
   where  tt_tipo  =  @i_tipo

   if @@rowcount = 0 select @w_prioridad  =  1
   
   --VALIDAR   SI EXISTE   AL MENOS UN RUBRO PARAMETRIZADO COMO ICR
   if exists(select  1 from cr_destino_tramite,  cr_destino_economico
   where dt_tramite =  @i_tramite
   and   dt_destino   >  ''
   and   dt_destino   =  de_codigo_inversion
   and   de_incentivo =  'S')
       select @i_incentivo  =  'S'
   else
       select @i_incentivo  =  'N'
       
   if @i_operacion = 'I'
      select @i_tipo_credito = 'N'   

   --*-- INI JAR REQ 218      
   select @w_segmento = mo_segmento 
     from cobis..cl_mercado_objetivo_cliente 
    where mo_ente = @i_cliente

   if @w_segmento is null
   begin
      select @w_error = 2108058
      goto ERRORFIN
   end
   --*-- FIN JAR REQ 218

   /*JSAR****************/
   select 
   @w_banca        = rtrim(ltrim(en_banca)),
   @w_tipo_persona = en_subtipo,
   @w_tipo_pers    = p_tipo_persona, 
   @w_max_riesgo   = isnull(en_max_riesgo,0)     -- JAR Paquete 2 REQ 215 Pequeña Empresa F.4.
   from   cobis..cl_ente
   where  en_ente  = @i_cliente
   
   -- INI -- JAR Paquete 2 REQ 215 Pequeña Empresa F.4.
   if @i_tipo not in ('E','A')
   begin 
      select @w_tipo_tr  = case when @i_tipo = 'C' and @i_original is not null then 'A' else @i_tipo end,
             @w_monto_tr = case when @i_tipo in('U','R') then @i_monto_renov else @i_monto end
   
      /* VALIDACION DE MAXIMO ENDEUDAMIENTO */
      exec @w_error = sp_valida_endeudamiento_glb
         @i_cliente       = @i_cliente,
         @i_linea_credito = @i_linea_credito, 
         @i_tipo_tr       = @w_tipo_tr,
         @i_max_riesgo    = @w_max_riesgo,
         @i_tramite       = @i_tramite,
         @i_toperacion    = @i_toperacion,
         @i_monto_tr      = @w_monto_tr
         
      if @w_error <> 0 goto ERRORFIN
   end  -- if @i_tipo <> 'E'
     
   
   -- FIN -- JAR Paquete 2 REQ 215 Pequeña Empresa F.4.   
   select @w_programa = re_programa
   from   cr_truta, cr_pasos, cr_regla
   where  ru_truta    = re_truta
   and    ru_truta    = pa_truta
   and    pa_paso     = re_paso
   and    re_etapa    = 0
   and    re_truta    = 0
   and    re_banca    = @w_banca
   and    re_programa = 'SP_BANCA_VALIDA_CREDITO_ACTIVO'
   
   if @w_programa is not null
   begin
      exec @w_return       = @w_programa
           @i_deudor       = @i_cliente,
           @o_tipo_credito = @i_tipo_credito out
      
      if @w_return <> 0
      begin
         select @w_error = 2101002
         select @w_msg   = 'No se pudo ejecutar programa: ' + @w_programa
         goto ERRORFIN
      end
   end
/*********************/   
/*
   --/*VALIDAR   SI CLIENTE TIENE CREDITO ACTIVO*/
   if exists (select 1 from   cob_cartera..ca_operacion
   where op_estado <>  99
   and   op_cliente =  @i_deudor)
      select @i_tipo_credito = 'R'
   
   --/*VALIDAR SI EL CLIENTE TIENE CREDITOS CANCELADOS */
   if @i_tipo_credito = 'N' begin
      if exists (select 1 from   cob_cartera_his..ca_operacion
      where op_estado <>  99
      and   op_cliente =  @i_deudor)
         select @i_tipo_credito = 'R'

   end
*/   
   if @i_tramite is null
   begin
      select @w_tr_tramite = -op_tramite
      from   cob_cartera..ca_operacion
      where  op_banco = @i_numero_op_banco
   end
   else
      select @w_tr_tramite = @i_tramite
      
   if @i_tipo = 'U' and @i_crea_ext is null
   begin 
      if @i_crea_ext = 'S' 
         select @w_tr_tramite = abs(@w_tr_tramite)
      if not exists( select 1 from cr_op_renovar where or_tramite = @w_tr_tramite )  
      begin
         select @w_error = 2101011, @w_msg = 'NO EXISTE OPERACION A UNIFICAR'  
         goto ERRORFIN  
      end
   end  
   
   --*-- INI REQ 218 CUPOS --*--
   if @i_tipo = 'C' and @i_original is null
   begin
      create table #politicas(
         politica  catalogo  null)
         
      insert into #politicas values ('PLAZOMAX')
      insert into #politicas values ('MONTOMAX')

      select @w_politica = ''

      while 1=1
      begin
         select top 1
                @w_politica = politica
           from #politicas
          where politica > @w_politica
          order by politica
          
         if @@rowcount = 0 break
         
         if @w_politica = 'PLAZOMAX'
         begin
            select 
               @w_error = 2108064,
               @w_msg   = 'PLAZO NO ACORDE AL PARAMETRIZADO'

            if @i_tplazo <> 'M'                                                                                                                                                                                                   
               select @w_valor = cast(@i_plazo * (select td_factor from cob_cartera..ca_tdividendo where td_tdividendo = @i_tplazo) / 30 as varchar)
            else  
               select @w_valor = cast(@i_plazo as varchar)               
         end

         if @w_politica = 'MONTOMAX'
         begin
            select 
               @w_error = 2108063,
               @w_msg   = 'MONTO NO ACORDE AL PARAMETRIZADO',
               @w_valor = cast((@i_monto*1.00) / (@w_smmlv*1.00) as varchar)
         end
         
         -- Validacion Valores de la Matriz de Cupos
         select @w_valor = ltrim(rtrim(@w_valor))
         
         exec @w_return = sp_valida_mat_cupos
            @i_segmento     = @w_segmento,
            @i_banca        = @w_banca,
            @i_nom_politica = @w_politica,
            @i_alianza      = @w_alianza,
            @i_valor        = @w_valor,
            @o_evalua       = @w_evalua  out            
         
         if @w_return <> 0
         begin
            select @w_error = @w_return
            goto ERRORFIN
         end
         
         if @w_evalua = 0
         begin
            goto ERRORFIN
         end          
      end -- while 1=1     
   end
   --*-- FIN REQ 218 CUPOS --*--
   else
   begin
      -- INI - REQ 175: PEQUEÑA EMPRESA
      select @w_montomx_tram_smv = pa_float                                  -- MONTO MAXIMO DE CUPO EN SMMLV POR BANCA
      from cobis..cl_parametro
      where pa_producto = 'CRE'
      and   pa_nemonico = 'MMXTS' + rtrim(ltrim(@w_banca))
      
      if @i_monto > @w_montomx_tram_smv * @w_smmlv
      begin
         select 
         @w_error = 2108046,
         @w_msg   = 'MONTO DEL TRAMITE SUPERA EL MAXIMO PERMITIDO'
         
         goto ERRORFIN
      end
      -- FIN - REQ 175: PEQUEÑA EMPRESA
   end
   /* INICIO - GAL 03/MAR/2010 - REQ07 CUPOS DE CREDITO */
   if @w_activa_req_paq2 = 'S'
   begin
      if @i_tipo = 'C' and @i_original is not null
      begin
         -- SE VERIFICA QUE AL HACER UNA DISMINUCION DEL CUPO 
         -- NO SE ESTE POR DEBAJO DE LO YA UTILIZADO POR EL CLIENTE
         select @w_utilizado = 0
         
         select 
         @w_linea_original = li_numero,
         @w_rotativa       = isnull(@i_rotativa, li_rotativa),
         @w_utilizado      = isnull(li_utilizado,0),  -- JAR REQ 215. Paquete 2
         @w_reservado      = isnull(li_reservado,0)   -- JAR REQ 215. Paquete 2
         from cr_linea
         where li_num_banco = @i_original
        
         if @i_monto < @w_utilizado + @w_reservado    -- JAR REQ 215. Paquete 2
         begin
            select 
            @w_error = 2101036, 
            @w_msg   = 'MONTO INGRESADO ES MENOR QUE MONTO UTILIZADO + RESERVADO'  -- JAR REQ 215. Paquete 2
            goto ERRORFIN
         end
      end
   end
   /* FIN - GAL 03/MAR/2010 */
end

/*   INSERCION   DEL   REGISTRO */
if @i_operacion = 'I' begin
   
   if @i_tipo is  NULL begin
      select @w_error = 2101001, @w_msg = 'EL PARAMETRO @i_tipo ES OBLIGATORIO'
      goto ERRORFIN
   end
   --------------------------------------------------------------------------------------------------------------------
 --FILTROS REQ: 164
   --LPO INICIO 07/Oct/2010   
   if @i_tipo <> 'A'
   begin
      -- INI - PAQUETE 1: REQ 216/231 - 19/ABR/2011
      -- SI EXISTE TRAMITE CREADO EN CALLCENTER RECHAZADO DEL MISMO TIPO 
      -- DEL TRAMITE QUE SE ESTA CREANDO PERO INGRESADO POR OTRO CANAL
      -- SE IMPIDE SU CREACION
      if  exists(select 1 from cr_tramite, cr_estacion 
                 where tr_estado     = 'Z' 
                 and   tr_cliente    = @i_cliente
                 and   @w_vig_fuente > datediff(dd, tr_fecha_crea, @s_date)
                 and   tr_tipo       = @i_tipo
                 and   es_usuario    = tr_usuario 
                 and   es_oficina    = @w_ofi_ccenter                      ) 
      and not exists(select 1 from cr_estacion
                     where es_usuario = @i_usuario_tr
                     and   es_oficina = @w_ofi_ccenter)
      begin
         select @w_error = 2108067
         goto ERRORFIN
      end
      -- FIN - PAQUETE 1: REQ 216/231 - 19/ABR/2011
   
      select 
      @w_tipo_persona = en_subtipo,
      @w_tipo_pers    = p_tipo_persona
      from cobis..cl_ente
      where en_ente = @i_cliente

      if exists(select 1 
                from cr_filtros, cr_pasos_filtros, cr_ruta_filtros, cr_filtro_tipo_cliente
                where pf_ruta         = 0
                and   pf_etapa        = 0
                and   pf_etapa        = fi_etapa
                and   pf_ruta         = rf_ruta
                and   fi_tipo_persona = @w_tipo_persona
                and   rf_estado       = 'V'
                and   ft_filtro       = fi_filtro
                and   ft_tipo_cliente = @w_tipo_pers)
      begin
         select @w_filtro = 1
      end else begin
         select @w_filtro = 0
      end

      if exists (select 1 from cr_filtros where fi_etapa = 0 and fi_tipo_persona = @w_tipo_persona and @w_filtro = 1)
      begin
         
         select distinct @w_dictamen_final =  vv_dictamen_final
         from cr_valor_variables_filtros, cr_filtros
         where vv_ruta         = 0
           and vv_etapa        = 0
           and vv_ente         = @i_cliente
           and vv_etapa        = fi_etapa
           and vv_filtro       = fi_filtro
           and vv_tramite     is null
           and fi_tipo_persona = @w_tipo_persona
         
         if @w_dictamen_final is null-- Aun No se ha ejecutado el filtro de Datos Basicos, no se puede ingresar el tramite.
         begin
            select @w_error = 2101008, @w_msg = 'Aun No se ejecuta el filtro de Datos Basicos, no se puede ingresar el tramite.'
            goto ERRORFIN
         end
         if @w_dictamen_final = 'N' -- El Dictamen Final de esta etapa es N, se requiere visto bueno superior para ingresar el tramite
         begin
            select @w_error = 2101008, @w_msg = 'El Dictamen Final de Datos Basicos es N, se requiere visto bueno superior para ingresar el tramite'
            goto ERRORFIN
         end
      end
   end
   --FILTROS REQ: 164
   --LPO FIN 07/Oct/2010
   --------------------------------------------------------------------------------------------------------------------
   
   /* PARA ESTOS TIPOS DE TRAMITES EL CAMPO DEUDOR ES OBLIGATORIO*/
   if (@i_deudor is NULL   and @i_tipo = 'O')  
   or (@i_deudor is NULL   and @i_tipo = 'R')      
   or (@i_deudor is NULL   and @i_tipo = 'F')
   or (@i_deudor is NULL   and @i_tipo = 'U')  
   or (@i_deudor is NULL   and @i_tipo = 'T')
   begin
      select @w_error = 2101001, @w_msg = 'EL PARAMETRO @i_deudor ES OBLIGATORIO'
      goto ERRORFIN
   end

   if @w_existe =  1 begin
      select @w_error = 2101002, @w_msg = 'SE ESTA INTENTANDO CREAR UN TRAMITE QUE YA EXISTE'
      goto ERRORFIN
   end
   
   select @w_banca_ruta = ru_directa
   from cr_truta
   where ru_truta  = @i_truta
   
   if @w_banca_ruta <> @w_banca
   begin
      select @w_error = 2103001, @w_msg = 'LA BANCA DEL CLIENTE NO COINCIDE CON LA BANCA DE LA RUTA ESCOGIDA'
      goto ERRORFIN
   end
   
/*JSAR - Req173.F3*************************************/
   select @w_programa = null
   
   select @w_programa = re_programa
     from cr_truta, cr_pasos, cr_regla
    where ru_truta    = re_truta
      and ru_truta    = pa_truta
      and pa_paso     = re_paso
      and re_etapa    = 0 --@w_etapa_actual
      and re_truta    = 0 --@i_truta
      and re_banca    = @w_banca
      and re_programa = 'SP_BANCA_VALIDA_DUPLICADO'
      
   if @w_programa is not null
   begin
      exec @w_return  = @w_programa
           @i_cliente = @i_cliente,
           @o_msg     = @w_msg out
           
      if @w_return <> 0
      begin
         select @w_error = 2101002
         if isnull(@i_crea_ext,'N') = 'S' and @w_msg is not null
            select @o_msg_msv = @w_msg
         else
            select @w_msg   = 'No se pudo ejecutar  programa: ' + @w_programa
         goto ERRORFIN
      end
   end
   
   select @w_programa = null
   select @w_programa = re_programa --DIAB
     from cr_truta, cr_pasos, cr_regla
    where ru_truta    = re_truta
      and ru_truta    = pa_truta
      and pa_paso     = re_paso
      and re_etapa    = 0 --@w_etapa_actual
      and re_truta    = 0 --@i_truta
      and re_banca    = @w_banca
      and re_programa = 'SP_BANCA_CUPO'
      
   if @w_programa is not null and @i_tipo in ('C','U','T')
   begin
      exec @w_return  = @w_programa
           @i_cliente = @i_cliente,
           @i_ruta    = @i_truta
   
      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERRORFIN
      end
   end
/******************************************************/

   if @i_tipo not in ('C', 'A')
   begin
      --*-- INI JAR REQ 218
            
      if @w_alianza is null --Cliente NO tiene alianza
      begin      
         select @w_tasa_pref = mc_valor
         from cr_matriz_cupos with (nolock), cr_politicas_cupos with (nolock)
         where pc_nom_politica = 'TASAPREF'
           and pc_banca        = @w_banca
           and pc_estado       = 'V'
           and mc_segmento     = @w_segmento
           and mc_alianza      is null
           and pc_num_politica = mc_politica     
      end
      else  ----Cliente tiene alianza
      begin
         select @w_tasa_pref = mc_valor
         from cr_matriz_cupos with (nolock), cr_politicas_cupos with (nolock)
         where pc_nom_politica = 'TASAPREF'
           and pc_banca        = @w_banca
           and pc_estado       = 'V'
           and mc_segmento     = @w_segmento
           and mc_alianza      = @w_alianza
           and pc_num_politica = mc_politica           
      end
      --*-- FIN JAR REQ 218
      if (@i_tipo in ('T', 'U') and @w_tasa_pref = 'S') or (@i_tipo not in ('T', 'U'))  -- JAR REQ 218
      begin
         /* LLAMADA AL STORED PROCEDURE SP_VALIDA_MATRICES*/ --ADI REQ204
         exec @w_error = sp_valida_matrices 
         @i_ente               = @i_cliente,
         @i_tramite            = @i_tramite,
         @i_tipo_credito       = @i_tipo_credito,
         @i_mercado            = @i_mercado,
         @i_mercado_objetivo   = @i_mercado_objetivo,
         @i_clase_cca          = @i_clase,
         @i_toperacion         = @i_toperacion,   
         @i_monto_solicitado   = @i_monto,            -- @i_monto_solicitado  - 20/ENE/2011 - INC 15234
         @i_plazo              = @i_plazo, 
         @i_destino            = @i_destino,          -- CCFU REQ 233,236
         @i_campana            = @i_campana,          -- CCFU REQ 233,236   
         @i_alianza            = @w_alianza, --SE DEBE MODIFICAR EL sp_valida_matrices PARA ENVIARA ESTE PARAMETRO DE ALIANZAS
         @o_spread             = @w_spread out,
         @o_signo              = @w_signo out,
         @o_msg                = @w_msg out
         
         if @w_error <> 0
         begin
            select @w_error = @w_error, @w_msg = 'ERROR AL VALIDAR MATRICES DE TASA PREFERENCIALES'
            goto ERRORFIN
         end
      end
   end
   
   if @w_tip_func = @w_tipo_pers  --Si es Empleado calcula clase de cartera
   begin

      if @w_tipo_persona = 'C'
      begin
         select @w_error = 2101008, @w_msg = 'El Tramite es de Empleado, pero el Empleado No es persona Natural. Favor Revisar!!! '
         goto ERRORFIN
      end

      exec @w_error = sp_clasecca
      @i_modo            = 9,
      @i_toperacion      = @i_toperacion,
      @o_clase_cartera   = @w_clase_cca out
      
      if @w_error <> 0 begin
         if @i_crea_ext is not null
            select @o_msg_msv = 'ERROR EN RUTEO AL EJECUTAR EL PROGRAMA SP_CLASECCA, ' + @w_sp_name
            
         print 'ERROR EN RUTEO AL EJECUTAR EL PROGRAMA SP_CLASECCA '
         select @w_error = 2101037
         goto ERRORFIN
      end

      if @w_clase_cca is null begin
         if @i_crea_ext is not null
            select @o_msg_msv = 'ERROR EN RUTEO AL EJECUTAR EL PROGRAMA SP_CLASECCA, ' + @w_sp_name
            
         print 'ERROR LA LINEA NO ESTA PARAMETRIZADA EN T115 <LINEAS PARA EMPLEADOS: CONSUMO E HIPOTECARIAS> ' + @i_toperacion
         select @w_error = 2101037
         goto ERRORFIN
      end
      
      select @i_clase = @w_clase_cca
   end
   
   /** LLAMADA AL   STORED PROCEDURE QUE INSERTA TRAMITES  **/
   exec @w_error = cob_credito..sp_in_tramite
   @s_ssn,                 @s_user,                  @s_sesn,
   @s_term,                @s_date,                  @s_srv,
   @s_lsrv,                @s_rol,                   @s_ofi,
   @s_org_err,             @s_error,                 @s_sev,
   @s_msg,                 @s_org,                   @t_rty,
   @t_trn,                 @t_debug,                 @t_file,
   @t_from,                @i_operacion,             @i_tramite,
   @i_tipo,                @i_truta,                 @i_oficina_tr,
   @i_usuario_tr,          @i_fecha_crea,            @i_oficial,
   @i_sector,              @i_ciudad,                @i_estado,
   @i_nivel_ap,            @i_fecha_apr,             @i_usuario_apr,
   @i_numero_op_banco,     @i_proposito,             @i_razon,
   @i_txt_razon,           @i_efecto,                @i_cliente,
   @i_grupo,               @i_fecha_inicio,          @i_num_dias,
   @i_per_revision,        @i_condicion_especial,    @i_rotativa,
   @i_linea_credito,       @i_toperacion,            @i_producto,
   @i_monto,               @i_moneda,                @i_periodo,
   @i_num_periodos,        @i_destino,               @i_ciudad_destino,
   @i_cuenta_corriente,    @i_monto_desembolso,      @i_reajustable,
   @i_per_reajuste,        @i_reajuste_especial,     @i_fecha_reajuste,
   @i_cuota_completa,      @i_tipo_cobro,            @i_tipo_reduccion,
   @i_aceptar_anticipos,   @i_precancelacion,        @i_tipo_aplicacion,
   @i_renovable,           @i_fpago,                 @i_cuenta,
   @i_origen_fondos,       @i_fondos_propios,        @i_direccion,
   0,                      @i_cliente_cca,           @i_op_renovada,
   @i_deudor,              @i_op_reestructurar,      @i_plazo,
   @i_tplazo,              @i_rent_actual,           @i_rent_solicitud,
   @i_rent_recomend,       @i_prod_actual,           @i_prod_solicitud,
   @i_prod_recomend,       @i_clase,                 @i_admisible,
   @i_noadmis,             @i_relacionado,           @i_original,
   @i_pondera,             @i_subtipo,               @i_tipo_producto,
   @i_origen_bienes,       @i_localizacion,          @i_plan_inversion,
   @i_naturaleza,          @i_tipo_financia,         @i_sobrepasa,
   @i_forward,             @i_elegible,              @i_emp_emisora,
   @i_num_acciones,        @i_responsable,           @i_negocio,
   @i_convierte_tasa,      @i_tasa_equivalente,      @i_reestructuracion,
   @i_concepto_credito,    @i_aprob_gar,             @i_mercado_objetivo,
   @i_tipo_productor,      @i_valor_proyecto,        @i_sindicado,
   @i_margen_redescuento,  @i_asociativo,            @i_incentivo,
   @i_fecha_eleg,          'N',                      @i_fecha_redes,
   @i_llave_redes,         @i_solicitud,             @i_montop,
   @i_monto_desembolsop,   @i_mercado,               @i_dias_vig,
   @i_cod_actividad,       @i_num_desemb,            @i_carta_apr,
   @i_fecha_aprov,         @i_fmax_redes,            @i_f_prorroga,
   @i_flim_cump,           @i_nlegal_fi,             @i_sujcred,
   @i_fabrica,             @i_callcenter,            @i_apr_fabrica,
   @i_monto_solicitado,    @i_tipo_plazo,            @i_tipo_cuota,
   @i_plazocup,            @i_cuota_aproximada,      @i_fuente_recurso,
   @i_tipo_credito,        @i_fecha_fija,            @i_dia_pago,
   @i_tasa_reest,          @i_motivo_reest,          @w_spread,
   @w_signo,               @i_primera_instancia,     @i_campana,
   @i_toperacion_pr, -- LPO REQ. Ejecutivo Master   
   @w_alianza,             @i_autoriza_central,      --Req. 353 Alianzas Comerciales.
   @i_crea_ext = @i_crea_ext,   --Req. 353 Alianzas Comerciales.
   @i_act_financiar = @i_act_financiar,            --Req. 422 IB
   @i_cuota_prorrogar = @i_cuota_prorrogar, --Req. 436 Normalizacion
   @i_fecha_prorrogar = @i_fecha_prorrogar, --Req. 436 Normalizacion
   @i_tipo_tramite    = @i_tipo_tramite,    --Req. 436 Normalizacion
   @o_msg_msv  = @o_msg_msv out,  --Req. 353 Alianzas Comerciales.
   @o_retorno  = @w_tramite_retorno   out,
   @o_retorno1 = @w_operacion_retorno out,
   @o_tramite_msv = @w_tramite_msv    out
   
   if @w_error <> 0 begin
      select @w_msg = 'ERROR AL EJECUTAR EL PROGRAMA SP_IN_TRAMITE'
      goto ERRORFIN
   end
   
   select @o_tramite_msv = @w_tramite_msv 
   --Inicio MAL05102011 Ajuste Req-184 
     update cr_valor_variables_filtros
     set vv_tramite = @w_tramite_retorno
         from cr_valor_variables_filtros a, cr_filtros
         where a.vv_ruta         = 0
           and a.vv_etapa        = 0
           and a.vv_ente         = @i_cliente
           and a.vv_etapa        = fi_etapa
           and a.vv_filtro       = fi_filtro
           and a.vv_tramite      is null
           and fi_tipo_persona = @w_tipo_persona
   --Fin  MAL05102011 
      
   -- INI JAR REQ 151 CONTRAOFERTAS

   --REQ 296 JMRV
   update cr_cliente_campana set
   cc_estado        = 'C',
   cc_tramite       = @i_tramite,
   cc_fecha_cierre  = @w_fecha_proc
   from  cr_campana 
   where cc_campana = ca_codigo
   and   cc_cliente = @i_cliente
   and   cc_campana = @i_campana
   and   cc_estado  = 'V'
   and   ca_tipo_campana <> 3 --REQ499 Normalizacion Clientes Especiales Mar/2015
      
   if @@error <> 0 
   begin
      select @w_msg = 'ERROR AL ACTUALIZAR CLIENTE-CAMPANA sp_in_tramite'
      goto ERRORFIN
   end
   -- FIN JAR REQ 151 CONTRAOFERTAS
   -- INI - PAQUETE 1 - 2011: POTENCIACION CALL CENTER / POOL DE PROMOTORES
   if @i_tipo = 'O'
   begin
      exec @w_error = cobis..sp_tarea
      @i_operacion      = 'M',
      @i_ente           = @i_cliente,
      @i_tipo           = 'T',
      @i_producto       = 21,
      @i_secuencial_prd = @w_tramite_retorno,
      @i_fecha_proc     = @s_date,
      @i_creador        = @s_user
      
      if @w_error <> 0 
      begin
         select @w_msg = 'ERROR AL ACTUALIZAR TAREA DE CREACION DE TRAMITE sp_in_tramite'
         goto ERRORFIN
      end

      if @s_ofi = @w_ofi_ccenter
      begin      
         exec @w_error = sp_genera_tarea_2
         @i_ente           = @i_cliente,
         @i_creador        = @s_user,
         @i_secuencial_prd = @w_tramite_retorno
         
         if @w_error <> 0 
         begin
            select @w_msg = 'ERROR AL INGRESAR TAREA DE REFERENCIACION sp_in_tramite'
            goto ERRORFIN
         end
      end     
   end
   -- FIN - PAQUETE 1 - 2011: POTENCIACION CALL CENTER / POOL DE PROMOTORES
end -- fin operacion I

if @i_operacion in ('I','U') and @i_tramite is not null
begin
   --SNU 21/Oct/2009. Se calcula la clase de cartera para Cupos, Originales, y Renovaciones
   if @i_tipo in ('C','O','R')
   begin

        if @w_central is null
         begin
	         exec @w_error = sp_central_riesgo
	    @i_tramite = @i_tramite,
	         @i_backend = 'S',
	         @o_central = @w_central    out
         
		         if @w_error <> 0
		         begin
		            select @w_msg = 'ERROR EN DETERMINACION DE CENTRAL DE RIESGO'
		            goto ERRORFIN
		         end
		 end 


       
      exec @w_error = cobis..sp_orden_consulta_ext
      @s_user      = @s_user,
      @s_ofi       = @s_ofi,
      @i_ente      = @i_cliente,
      @i_tconsulta = @w_central,   --CIFIN o DATACREDITO
      @i_modo      = 'I',
      @o_orden     = @w_orden out,
      @o_respuesta = @w_respuesta out
      
      if @w_error <> 0 begin
         select @w_msg = 'ERROR AL EJECUTAR EL PROGRAMA DE CONSULTA DE ORDEN'
         goto ERRORFIN
      end
      
      if @w_respuesta = 'S'
      begin
           
         create table #endeu_tmp
         ( te_endeudamiento      money        null,
           te_vivienda           money        null,
           te_serpubdia          money        null,
           te_serpubmora         money        null
         )
         
         select @w_central_riesgo = codigo_sib
         from cr_corresp_sib
         where tabla  = 'T106'
           and codigo = @w_central
         
         exec @w_error = cobis..sp_consultar_xml
              @i_ente         = @i_cliente,
              @i_tservice     = @w_central,   --CIFIN o DATACREDITO
              @i_tquery       = '01',
              @i_central      = @w_central_riesgo
         
         if @w_error <> 0 begin
            select @w_msg = 'ERROR AL EJECUTAR EL PROGRAMA DE LLENADO DE DATOS DATACREDITO'
            goto ERRORFIN
         end

         select @w_endeudamiento = te_endeudamiento,
                @w_cartera_viv   = te_vivienda,
                @w_ser_pub_vig   = te_serpubdia,
                @w_ser_pub_mora  = te_serpubmora
         from #endeu_tmp
           
         if @w_tip_func <> @w_tipo_pers  --Si es Empleado calcula clase de cartera
         begin

            --Inserta en la tabla cr_endeudamiento
            exec @w_error = sp_clasecca
            @i_modo            = 4,
            @i_endeudamiento   = @w_endeudamiento,
            @i_vivienda        = @w_cartera_viv, 
            @i_serpubdia       = @w_ser_pub_vig,
            @i_serpubmora      = @w_ser_pub_mora, 
            @i_tramite         = @i_tramite
            
            if @w_error <> 0 begin
               select @w_msg = 'ERROR AL EJECUTAR EL PROGRAMA SP_CLASECCA EN INSERCION'
               goto ERRORFIN
            end
            
            --Si es renovacion
            if @i_tipo = 'R' and isnull(@i_monto_renov,0) <> 0
               select @w_monto_cca = @i_monto_renov
            else                                         
               select @w_monto_cca = @i_monto

            --Se recalcula la clase de cartera
            exec @w_error = sp_clasecca
            @i_modo            = 3,
            @i_endeudamiento   = @w_endeudamiento,
            @i_vivienda        = @w_cartera_viv, 
            @i_serpubdia       = @w_ser_pub_vig,
            @i_serpubmora      = @w_ser_pub_mora, 
            @i_tramite         = @i_tramite,
            @i_monto           = @w_monto_cca,
            @o_clase_cartera   = @w_clase_cca out
            
            if @w_error <> 0 begin
               select @w_msg = 'ERROR AL EJECUTAR EL PROGRAMA SP_CLASECCA EN RECALCULO'
               goto ERRORFIN
            end
            select @i_clase = @w_clase_cca,
                   @w_clase = @w_clase_cca
        end --de tipo persona Empleado
      --end--if exists
      end--if @w_respuesta = 'S'
   end--Si el tipo ('O','C','R')
   --FIN SNU 21/OCT/2009. Se calcula la clase de cartera
end

/* ACTUALIZACION DEL REGISTRO */
if @i_operacion   =  'U' begin

   if @i_tramite is NULL begin
      select @w_error = 2101001, @w_msg = 'EL PARAMETRO @I_TRAMITE ES OBLIGATORIO'
      goto ERRORFIN
   end

   if @i_tipo is NULL begin
      select @w_error = 2101001, @w_msg = 'EL PARAMETRO @I_TIPO ES OBLIGATORIO'
      goto ERRORFIN
   end
   
   if @w_existe = 0 begin
      select @w_error = 2105002, @w_msg = 'SE INTENTA MODIFICAR UN TRAMITE QUE NO EXISTE'
      goto ERRORFIN
   end
   
   /* UN TRAMITE DE CUPO O DE REESTRUCTURACION NECESARIAMENTE ES SOBRE UN CLIENTE "VIEJO" */
   --if @i_tipo in ('C','E') select @i_tipo_credito =  'R'
   if @i_tipo in ('C','E','R','U','T') select @i_tipo_credito =  'R' --JJMD Se agrega Renovacion, Unificación y Utilización
    
   if @@trancount = 0 begin
      begin tran 
      select @w_commit = 'S'
   end
   
   if @i_tipo not in ('C', 'A')
   begin
      --*-- INI JAR REQ 218
      if @w_alianza is null --Cliente NO tiene alianza
      begin      
         select @w_tasa_pref = mc_valor
         from cr_matriz_cupos with (nolock), cr_politicas_cupos with (nolock)
         where pc_nom_politica = 'TASAPREF'
           and pc_banca        = @w_banca
           and pc_estado       = 'V'
           and mc_segmento     = @w_segmento
           and mc_alianza      is null
           and pc_num_politica = mc_politica     
      end
      else  ----Cliente tiene alianza
      begin
         select @w_tasa_pref = mc_valor
         from cr_matriz_cupos with (nolock), cr_politicas_cupos with (nolock)
         where pc_nom_politica = 'TASAPREF'
           and pc_banca        = @w_banca
           and pc_estado       = 'V'
           and mc_segmento     = @w_segmento
           and mc_alianza      = @w_alianza
           and pc_num_politica = mc_politica           
      end
      --*-- FIN JAR REQ 218
      
      if (@i_tipo in ('T', 'U') and @w_tasa_pref = 'S') or (@i_tipo not in ('T', 'U')) -- JAR REQ 218      
      begin
         /* LLAMADA AL STORED PROCEDURE SP_VALIDA_MATRICES*/ --ADI REQ204
         exec @w_error = sp_valida_matrices 
         @i_ente               = @i_cliente,
         @i_tramite            = @i_tramite,
         @i_tipo_credito       = @i_tipo_credito,
         @i_mercado            = @i_mercado,
         @i_mercado_objetivo   = @i_mercado_objetivo,
         @i_clase_cca          = @i_clase,
         @i_toperacion         = @i_toperacion,
         @i_monto_solicitado   = @i_monto,         -- @i_monto_solicitado  - 20/ENE/2011 - INC 15234
         @i_plazo              = @i_plazo,   
         @i_destino            = @i_destino, 
         @i_campana            = @i_campana,     
         @i_alianza            = @w_alianza,      --SE DEBE MODIFICAR EL sp_valida_matrices PARA ENVIARA ESTE PARAMETRO DE ALIANZAS
         @o_spread             = @w_spread out,
         @o_signo              = @w_signo out,
         @o_msg                = @w_msg out
         
         if @w_error <> 0
         begin
            select @w_error = @w_error, @w_msg = 'ERROR AL VALIDAR MATRICES DE TASA PREFERENCIALES'
            goto ERRORFIN
         end      
      end
   end
   
   if @w_tip_func = @w_tipo_pers  --Si es Empleado calcula clase de cartera
   begin      
      if @w_tipo_persona = 'C'
      begin
         select @w_error = 2101008, @w_msg = 'El Tramite es de Empleado, pero el Empleado No es persona Natural. Favor Revisar!!! '
         goto ERRORFIN
      end

      exec @w_error = sp_clasecca
      @i_modo            = 9,
      @i_toperacion      = @i_toperacion,
      @o_clase_cartera   = @w_clase_cca out
      
      if @w_error <> 0 begin
         print 'ERROR EN RUTEO AL EJECUTAR EL PROGRAMA SP_CLASECCA '
         select @w_error = 2101037
         goto ERRORFIN
      end
      
      if @w_clase_cca is null begin
         print 'ERROR LA LINEA NO ESTA PARAMETRIZADA EN T115 <LINEAS PARA EMPLEADOS: CONSUMO E HIPOTECARIAS> ' + @i_toperacion
         select @w_error = 2101037
         goto ERRORFIN
      end
      
      select @i_clase = @w_clase_cca
   end
   
   /* LLAMADA  AL STORED   PROCEDURE   DE ACTUALIZACION */
   exec @w_error   =  cob_credito..sp_up_tramite
   @s_date                  =  @s_date,
   @s_error                 =  @s_error,
   @s_lsrv        =  @s_lsrv,
   @s_msg                   =  @s_msg,
   @s_ofi                   =  @s_ofi,
   @s_org                   =  @s_org,
   @s_org_err               =  @s_org_err,
   @s_rol                   =  @s_rol,
   @s_sesn                  =  @s_sesn,
   @s_sev                   =  @s_sev,
   @s_srv                   =  @s_srv,
   @s_ssn                   =  @s_ssn,
   @s_term                  =  @s_term,
   @s_user                  =  @s_user,
   @t_debug                 =  @t_debug,
   @t_file                  =  @t_file,
   @t_from                  =  @t_from,
   @t_rty                   =  @t_rty,
   @t_trn                   =  @t_trn,
   @i_aceptar_anticipos     =  @i_aceptar_anticipos,
   @i_admisible             =  @i_admisible,
   @i_apr_fabrica           =  @i_apr_fabrica,
   @i_aprob_gar             =  @i_aprob_gar,
   @i_asociativo            =  @w_asociativo,
   @i_callcenter            =  @i_callcenter,
   @i_carta_apr             =  @i_carta_apr,
   @i_ciudad                =  @i_ciudad,
   @i_ciudad_destino        =  @i_ciudad_destino,
   @i_clase                 =  @i_clase,
   @i_cliente               =  @i_cliente,
   @i_cliente_cca           =  @i_cliente_cca,
   @i_cod_actividad         =  @i_cod_actividad,
   @i_concepto_credito      =  @i_concepto_credito,
   @i_condicion_especial    =  @i_condicion_especial,
   @i_convierte_tasa        =  @i_convierte_tasa,
   @i_cuenta                =  @i_cuenta,
   @i_cuenta_corriente      =  @i_cuenta_corriente,
   @i_cuota_aproximada      =  @i_cuota_aproximada,
   @i_cuota_completa        =  @i_cuota_completa,
   @i_destino               =  @i_destino,
   @i_deudor                =  @i_deudor,
   @i_dias_vig              =  @i_dias_vig,
   @i_efecto                =  @i_efecto,
   @i_elegible              =  @i_elegible,
   @i_emp_emisora           =  @i_emp_emisora,
   @i_estado                =  @i_estado,
   @i_f_prorroga            =  @i_f_prorroga,
   @i_fabrica               =  @i_fabrica,
   @i_fecha_apr             =  @i_fecha_apr,
   @i_fecha_aprov           =  @i_fecha_aprov,
   @i_fecha_crea            =  @i_fecha_crea,
   @i_fecha_eleg            =  @i_fecha_eleg,
   @i_fecha_inicio          =  @i_fecha_inicio,
   @i_fecha_reajuste        =  @i_fecha_reajuste,
   @i_fecha_redes           =  @w_fecha_redes,
   @i_flim_cump             =  @i_flim_cump,
   @i_fmax_redes            =  @i_fmax_redes,
   @i_fondos_propios        =  @i_fondos_propios,
   @i_forward               =  @i_forward,
   @i_fpago                 =  @i_fpago,
   @i_fuente_recurso        =  @i_fuente_recurso,
   @i_grupo                 =  @i_grupo,
   @i_incentivo             =  @i_incentivo,
   @i_linea_credito         =  @i_linea_credito,
   @i_llave_redes           =  @i_llave_redes,
   @i_localizacion          =  @i_localizacion,
   @i_margen_redescuento    =  @i_margen_redescuento,
   @i_mercado               =  @i_mercado,
   @i_mercado_objetivo      =  @i_mercado_objetivo,
   @i_moneda                =  @i_moneda,
   @i_monto                 =  @i_monto,
   @i_monto_desembolso      =  @i_monto_desembolso,
   @i_monto_desembolsop     =  @i_monto_desembolsop,
   @i_monto_solicitado      =  @i_monto_solicitado,
   @i_montop                =  @i_montop,
   @i_naturaleza            =  @i_naturaleza,
   @i_negocio               =  @i_negocio,
   @i_nivel_ap              =  @i_nivel_ap,
   @i_nlegal_fi             =  @i_nlegal_fi,
   @i_noadmis               =  @i_noadmis,
   @i_num_acciones          =  @i_num_acciones,
   @i_num_desemb            =  @i_num_desemb,
   @i_num_dias              =  @i_num_dias,
   @i_num_periodos          =  @i_num_periodos,
   @i_numero_op_banco       =  @i_numero_op_banco,
   @i_oficial               =  @i_oficial,
   @i_oficina_tr            =  @i_oficina_tr,
   @i_op_reestructurar      =  @i_op_reestructurar,
   @i_op_renovada           =  @i_op_renovada,
   @i_operacion             =  @i_operacion,
   @i_origen_bienes         =  @i_origen_bienes,
   @i_origen_fondos         =  @i_origen_fondos,
   @i_original              =  @i_original,
   @i_per_reajuste          =  @i_per_reajuste,
   @i_per_revision          =  @i_per_revision,
   @i_periodo               =  @i_periodo,
   @i_plan_inversion        =  @i_plan_inversion,
   @i_plazo                 =  @i_plazo,
   @i_plazocup              =  @i_plazocup,
   @i_pondera               =  @i_pondera,
   @i_precancelacion        =  @i_precancelacion,
   @i_prod_actual           =  @i_prod_actual,
   @i_prod_recomend         =  @i_prod_recomend,
   @i_prod_solicitud        =  @i_prod_solicitud,
   @i_producto              =  @i_producto,
   @i_proposito             =  @i_proposito,
   @i_razon                 =  @i_razon,
   @i_reajustable           =  @i_reajustable,
   @i_reajuste_especial     =  @i_reajuste_especial,
   @i_reestructuracion      =  @i_reestructuracion,
   @i_relacionado           =  @i_relacionado,
   @i_renovable             =  @i_renovable,
   @i_renovacion            =  @i_renovacion,
   @i_rent_actual           =  @i_rent_actual,
   @i_rent_recomend         =  @i_rent_recomend,
   @i_rent_solicitud        =  @i_rent_solicitud,
   @i_responsable           =  @i_responsable,
   @i_rotativa              =  @i_rotativa,
   @i_sector                =  @i_sector,
   @i_sindicado             =  @i_sindicado,
   @i_solicitud             =  @i_solicitud,
   @i_subtipo               =  @i_subtipo,
   @i_sujcred               =  @i_sujcred,
   @i_tasa_equivalente      =  @i_tasa_equivalente,
   @i_tipo                  =  @i_tipo,
   @i_tipo_aplicacion       =  @i_tipo_aplicacion,
   @i_tipo_cobro            =  @i_tipo_cobro,
   @i_tipo_cuota            =  @i_tipo_cuota,
   @i_tipo_financia         =  @i_tipo_financia,
   @i_tipo_normal           =  @i_tipo_normal,
   @i_tipo_plazo            =  @i_tipo_plazo,
   @i_tipo_producto         =  @i_tipo_producto,
   @i_tipo_productor        =  @i_tipo_productor,
   @i_tipo_reduccion        =  @i_tipo_reduccion,
   @i_toperacion            =  @i_toperacion,
   @i_tplazo                =  @i_tplazo,
   @i_tramite               =  @i_tramite,
   @i_truta                 =  @i_truta,
   @i_txt_razon             =  @i_txt_razon,
   @i_usuario_apr           =  @i_usuario_apr,
   @i_usuario_tr            =  @i_usuario_tr,
   @i_valor_proyecto        =  @i_valor_proyecto,
   @i_tipo_credito          =  @i_tipo_credito,
   @i_w_admisible           =  @w_admisible,
   @i_w_aprob_gar           =  @w_aprob_gar,
   @i_w_ciudad              =  @w_ciudad,
   @i_w_ciudad_destino      =  @w_ciudad_destino,
   @i_w_clase               =  @w_clase,
   @i_w_cliente             =  @w_cliente,
   @i_w_concepto_credito    =  @w_concepto_credito,
   @i_w_condicion_especial  =  @w_condicion_especial,
   @i_w_cuenta_corriente    =  @w_cuenta_corriente,
   @i_w_destino             =  @w_destino,
   @i_w_efecto              =  @w_efecto,
   @i_w_elegible            =  @w_elegible,
   @i_w_emp_emisora         =  @w_emp_emisora,
   @i_w_estado              =  @w_estado,
   @i_w_fecha_apr           =  @w_fecha_apr,
   @i_w_fecha_crea          =  @w_fecha_crea,
   @i_w_fecha_inicio        =  @w_fecha_inicio,
   @i_w_forward             =  @w_forward,
   @i_w_grupo               =  @w_grupo,
   @i_w_linea_credito       =  @w_linea_credito,
   @i_w_localizacion        =  @w_localizacion,
   @i_w_moneda              =  @w_moneda,
   @i_w_monto               =  @w_monto,
   @i_w_monto_desembolsop   =  @w_monto_desembolsop,
   @i_w_monto_solicitado    =  @w_monto_solicitado,
   @i_w_montop              =  @w_montop,
   @i_w_naturaleza          =  @w_naturaleza,
   @i_w_negocio             =  @w_negocio,
   @i_w_nivel_ap            =  @w_nivel_ap,
   @i_w_noadmis             =  @w_noadmis,
   @i_w_num_acciones        =  @w_num_acciones,
   @i_w_num_dias            =  @w_num_dias,
   @i_w_num_periodos        =  @w_num_periodos,
   @i_w_numero_linea        =  @w_numero_linea,
   @i_w_numero_op   =  @w_numero_op,
   @i_w_numero_op_banco     =  @w_numero_op_banco,
   @i_w_oficial             =  @w_oficial,
   @i_w_oficina_tr          =  @w_oficina_tr,
   @i_w_origen_bienes       =  @w_origen_bienes,
   @i_w_per_revision        =  @w_per_revision,
   @i_w_periodo             =  @w_periodo,
   @i_w_plan_inversion      =  @w_plan_inversion,
   @i_w_pondera             =  @w_pondera,
   @i_w_prod_actual         =  @w_prod_actual,
   @i_w_prod_recomend       =  @w_prod_recomend,
   @i_w_prod_solicitud      =  @w_prod_solicitud,
   @i_w_producto            =  @w_producto,
   @i_w_proposito           =  @w_proposito,
   @i_w_razon               =  @w_razon,
   @i_w_reestructuracion    =  @w_reestructuracion,
   @i_w_relacionado         =  @w_relacionado,
   @i_w_renovacion          =  @w_renovacion,
   @i_w_rent_actual         =  @w_rent_actual,
   @i_w_rent_recomend       =  @w_rent_recomend,
   @i_w_rent_solicitud      =  @w_rent_solicitud,
   --@i_w_responsable         =  @w_responsable,
   @i_w_primera_instancia   =  @w_primera_instancia,
   @i_w_sector              =  @w_sector,
   @i_w_tipo                =  @w_tipo,
   @i_w_tipo_financia       =  @w_tipo_financia,
   @i_w_tipo_producto       =  @w_tipo_producto,
   @i_w_toperacion          =  @w_toperacion,
   @i_w_truta               =  @w_truta,
   @i_w_txt_razon           =  @w_txt_razon,
   @i_w_usuario_apr         =  @w_usuario_apr,
   @i_w_usuario_tr          =  @w_usuario_tr,
   @i_w_tipo_credito        =  @w_tipo_credito,
   @i_fecha_fija            =  @i_fecha_fija,
   @i_dia_pago              =  @i_dia_pago,
   @i_tasa_reest            =  @i_tasa_reest,
   @i_motivo_reest          =  @i_motivo_reest,
   @i_spread                =  @w_spread,
   @i_signo                 =  @w_signo,
   @i_primera_instancia     =  @i_primera_instancia,    -- LPO REQ. Ejecutivo Master
   @i_toperacion_pr         =  @i_toperacion_pr,
   @i_act_financiar         =  @i_act_financiar,         -- IB Req. 422
   @i_cuota_prorrogar       =  @i_cuota_prorrogar, --Req. 436 Normalizacion
   @i_fecha_prorrogar       =  @i_fecha_prorrogar, --Req. 436 Normalizacion
   @i_tipo_tramite          =  @i_tipo_tramite     --Req. 436 Normalizacion

   if @w_error <> 0 begin
      select @w_msg = 'ERROR AL EJECUTAR EL PROGRAMA sp_up_tramite'
      goto ERRORFIN
   end
   
print 'SRO ---> i_toperacion'+@i_toperacion
   --INICIA SRO
   if (@i_toperacion='CREGRP' or @i_toperacion='CREGRP1' or @i_toperacion='CREGRUP1')
	begin		
		SELECT  @w_miembros = count(1)
		FROM  cobis..cl_cliente_grupo
		WHERE  cg_grupo = @i_cliente
					
		update cob_credito..cr_tramite_grupal
		set tg_monto = (@i_monto/@w_miembros)
		WHERE  tg_tramite = @i_tramite
	end
    --FIN SRO
   -- INI JAR REQ 151 CONTRAOFERTAS
   -- REQ 296 JMRV??????

   -- INI JAR REQ 151 CONTRAOFERTAS
	update cr_cliente_campana set
	cc_estado        = ca_estado,
	cc_tramite       = null,
	cc_fecha_cierre  = null
	from  cr_campana
	where cc_campana = ca_codigo
	and   cc_campana = @i_campana
	and   cc_tramite = @i_tramite
	and   ca_tipo_campana <> 3 --REQ499 Normalizacion Clientes Especiales Mar/2015
	  
	if @@error <> 0 
	begin
	  select @w_msg = 'ERROR AL ACTUALIZAR CLIENTE-CAMPANA sp_up_tramite'
	  goto ERRORFIN
	end
   -- FIN JAR REQ 151 CONTRAOFERTAS

   ---INC113021
   if @i_tipo <> 'E'
   begin
      select tc_tipo into #tipo_garantia
      from cob_custodia..cu_tipo_custodia
      where  tc_tipo_superior  = @w_cod_gar_fng
	
      select @w_gar_op = cu_tipo from cob_credito..cr_gar_propuesta, cob_custodia..cu_custodia                               
      where gp_garantia = cu_codigo_externo and   gp_tramite  = @i_tramite                   
      and   cu_tipo in (select tc_tipo from #tipo_garantia)
      and   ((cu_estado		<> 'A' and   gp_est_garantia  <> 'A') )
	     
      if @w_gar_op  is not null
      begin
         ---INC 112608-VAlidacion del plazo parametrizado para garantias FNG
         select @w_plazot121 = 0
         exec cob_credito..sp_resp_plazo_max_gar
         @t_trn = 22284,
         @i_tipo_garantia = @w_gar_op,
         @i_tipo_consulta = 'T',
         @o_valor =  @w_plazot121 out  
		   
         if @i_plazo > @w_plazot121
         begin
            select @w_msg = 'El PLAZO DE LA OPERACION SUPERA LO PARAMETRIZADO EN T121'
            select @w_error = 2101124
            goto ERRORFIN
         end
      end
   end 
   ---INC 112608-113021 Fin  VAlidacion del plazo parametrizado para garantias FNG

   
   if @w_commit = 'S' begin
      commit tran
      select @w_commit = 'N'
   end
end

-- INI JAR REQ 215
if @i_operacion in ('I', 'U')
begin   
	if @i_operacion = 'I'
	begin
		select @i_tramite = @w_tramite_retorno
	end
   -- INI - PAQUETE 2: REQ 260 - MIR VINCULANTE - 30/JUN/2011
   if @i_tipo in ('O', 'R', 'C') and @i_calificacion is not null
   begin
      exec @w_return = sp_puntaje_mir
      @s_user           = @s_user,
      @t_debug          = @t_debug,
      @t_file           = @t_file,
      @i_tramite        = @i_tramite,
      @i_calificacion   = @i_calificacion,
      @i_manual         = 'S',
      @o_msg            = @w_msg out 
      
      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERRORFIN
      end
   end
   -- FIN - PAQUETE 2: REQ 260 - MIR VINCULANTE
end

if @i_operacion = 'C' -- Actualizacion Reservado y Utilizado de cupo
begin
   /* ACTUALIZACION DE RESERVADO PARA EL CUPO */
   if @i_tipo in ('T', 'U')
   begin      
      exec @w_return = sp_reservado         
         @i_linea_credito = @i_linea_credito

      if @w_return <> 0 begin
         select @w_error = @w_return
         goto ERRORFIN
      end
   end
end   -- if @i_operacion = ''

-- INI JAR REQ 215

/* ELIMINACION DE REGISTROS   */
if @i_operacion   =  'D' begin

   if @w_existe = 0 begin
      select @w_error = 2105002, @w_msg = 'SE INTENTA ELIMINAR UN TRAMITE QUE NO EXISTE'
      goto ERRORFIN
   end
   
   if @@trancount = 0 begin
      begin tran 
      select @w_commit = 'S'
   end
   
   exec @w_error   =  cob_credito..sp_de_tramite
   @s_ssn,              @s_user,               @s_sesn,
   @s_term,             @s_date,               @s_srv,
   @s_lsrv,             @s_rol,                @s_ofi,
   @s_org_err,          @s_error,              @s_sev,
   @s_msg,              @s_org,                @t_rty,
   @t_trn,              @t_debug,              @t_file,
   @t_from,             @i_operacion,          @i_tramite,
   @w_tipo,             @w_truta,              @w_oficina_tr,
   @w_usuario_tr,       @w_fecha_crea,         @w_oficial,
   @w_sector,           @w_ciudad,             @w_estado,
   @w_nivel_ap,         @w_fecha_apr,          @w_usuario_apr,
   @w_numero_op,        @w_numero_op_banco,    @w_proposito,
   @w_razon,            @w_txt_razon,          @w_efecto,
   @w_cliente,          @w_grupo,              @w_fecha_inicio,
   @w_num_dias,         @w_per_revision,       @w_condicion_especial,
   @w_numero_linea,     @w_toperacion,         @w_producto,
   @w_monto,            @w_moneda,             @w_periodo,
   @w_num_periodos,     @w_destino,            @w_ciudad_destino,
   @w_cuenta_corriente, @w_renovacion,         @w_reestructuracion,
   @w_concepto_credito, @w_aprob_gar,          @w_cont_admisible,
   @w_montop,           @w_monto_desembolsop

   if @w_error <> 0 begin
      select @w_msg = 'ERROR AL EJECUTAR EL PROGRAMA sp_de_tramite'
      goto ERRORFIN
   end
   
   -- INI JAR REQ 151 CONTRAOFERTAS
   update cr_cliente_campana set
   cc_estado = 'V'
   from  cr_campana
   where cc_campana = ca_codigo
   and   cc_cliente = @w_cliente
   and   cc_estado  = 'C'
   and   ca_tipo_campana <> 3 --REQ499 Normalizacion Clientes Especiales Mar/2015
	  
   if @@error <> 0 
   begin
     select @w_msg = 'ERROR AL ACTUALIZAR CLIENTE-CAMPANA sp_de_tramite'
     goto ERRORFIN
   end
   -- FIN JAR REQ 151 CONTRAOFERTAS

   if @w_commit = 'S' begin
      commit tran
      select @w_commit = 'N'
   end
      
end




/* CONSULTA OPCION QUERY */
if @i_operacion = 'Q' begin

   /* ACTUALIZA LOS DATOS QUE CAMBIARON DESDE LA PALM Y SE TOMAN DE CCA EN EL QUERY */
   exec @w_error = cob_palm..sp_paso_creditos_batch_pda
   @s_ssn        = @s_ssn,
   @i_tramite    = @i_tramite

   if @w_error <> 0 begin
      select @w_msg = 'ERROR AL EJECUTAR EL PROGRAMA cob_palm..sp_paso_creditos_batch_pda'
      goto ERRORFIN
   end
   
    --   CONTROL  CAMBIO DE   ESP   SUJETO DE   CREDITO
    if @i_tramite is not null begin
    
       select @w_sujcred =  tr_sujcred
       from   cr_tramite
       where  tr_tramite =  @i_tramite

       set   rowcount 1
       
       select @w_sujcred_esp =  et_sujeto
       from   cr_especifica_tramites
       where  et_tramite    =  @i_tramite
       
       set   rowcount 0

       if @w_sujcred  <> @w_sujcred_esp begin
       
           delete  cr_especifica_tramites
           where   et_tramite  =  @i_tramite
           
           if @@error <> 0 begin
              select @w_error = 710003, @w_msg = 'ERROR AL BORRAR TABLA cr_especifica_tramites'
              goto ERRORFIN
           end
           
       end

    end

    /* TRAE LOS DATOS DE DESEMBOLSOS PARCIALES SI HUBIESEN */
    select @w_num_cupo = li_numero
    from cr_linea
    where li_tramite =  @i_tramite

    if @@rowcount <> 0 and @w_num_cupo is not null begin
    
       select @w_fecha_desembolso = min(ca_fecha_desembolso)
       from cr_ctrl_cupo_asoc
       where ca_num_cupo    =  @w_num_cupo
       
       if @w_fecha_desembolso is not null and @w_fecha_crea > @w_fecha_desembolso
       begin
          select @w_error = 2108001, @w_msg = 'LA FECHA DE CRACION DEL TRAMITE ES MAYOR Al PRIMER USO DE LA LINEA DE CREDITO'
          goto ERRORFIN
       end
       
    end

    exec sp_query_tramite
    @t_debug               =  @t_debug,
    @t_file                =  @t_file,
    @t_from                =  @t_from,
    @i_tramite             =  @i_tramite,
    @i_numero_op_banco     =  @i_numero_op_banco,
    @i_linea_credito       =  @i_linea_credito,
    @i_producto            =  @i_producto,
    @i_modo                =  @i_modo,
    @i_es_acta             =  @i_es_acta,
    @i_tipo                =  @i_tipo,
    @i_usuario_apr         =  @i_usuario_apr,
    @i_comite              =  @i_comite,
    @i_formato_fecha       =  @i_formato_fecha,
    @i_tipo_tramite        =  @i_tipo_tramite  --Req. 436 Normalizacion

end


if @i_operacion = 'A' begin

   if @i_modo = '0' begin
   
      if @i_fecha_apr < @w_fecha_apr print 'ALERTA: La nueva fecha es menor a la fecha anterior de APROBACION'
      
      select  @w_fecha_apr = tr_fecha_apr
      from    cr_tramite
      where   tr_tramite = @i_tramite
      
      if @@rowcount = 0 begin
         select @w_error = 2105002, @w_msg = 'SE ESTA INTENTANDO ACTUALIZAR UN TRAMITE QUE NO EXISTE'
         goto ERRORFIN
      end
      
      update cr_tramite set    
      tr_fecha_apr      = @i_fecha_apr,
      tr_fecha_ap_ant   = @w_fecha_apr,
      tr_acta           = @i_acta,
      tr_estado         = 'A',
      tr_txt_razon      = @i_txt_razon
      where tr_tramite = @i_tramite
      
      if @@error <> 0 begin
         select @w_error = 2105002, @w_msg = 'ERROR AL ACTUALIZAR EL TRAMITE: ' + convert(varchar, @i_tramite)
         goto ERRORFIN
      end
     
      select   
      @w_dias   = li_dias,
      @w_dias_vig =  li_dias_vig
      from cr_linea
      where li_tramite = @i_tramite
      
      if @w_dias <>  null begin
      
         select @w_fecha_vto = dateadd(dd,@w_dias,@i_fecha_apr)

         if @i_fecha_apr is null 
            select @i_fecha_apr = @w_fecha_proc
         
         update cr_linea set      
         li_fecha_aprob = @i_fecha_apr,
         li_fecha_vto   = @w_fecha_vto
         where li_tramite = @i_tramite
         
         if @@error <> 0 begin
            select @w_error = 2105002, @w_msg = 'ERROR AL ACTUALIZAR (2) EL TRAMITE: ' + convert(varchar, @i_tramite)
            goto ERRORFIN
         end

         
      end else begin
   
         if @i_fecha_apr is null 
            select @i_fecha_apr = @w_fecha_proc
      
         update cr_linea set      
         li_fecha_aprob = @i_fecha_apr
         where li_tramite = @i_tramite

         if @@error <> 0 begin
            select @w_error = 2105002, @w_msg = 'ERROR AL ACTUALIZAR (3) EL TRAMITE: ' + convert(varchar, @i_tramite)
            goto ERRORFIN
         end
         
      end
      
      return 0
      
   end
end



if @i_operacion = 'V' begin

   if @i_tipo is NULL begin
      select @w_error = 2101001, @w_msg = 'EL PARAMETRO @I_TIPO ES OBLIGATORIO'
      goto ERRORFIN
   end

   if @w_existe = 0 begin
      select @w_error = 2105002, @w_msg = 'SE INTENTA VALIDAR UN TRAMITE QUE NO EXISTE'
      goto ERRORFIN
   end


   if not exists(select 1 from cr_tramite
   where tr_tramite = @i_tramite
   and   tr_tipo    = @i_tipo )
   begin
      select @w_error = 2101005, @w_msg = 'EL TRAMITE ' + convert(varchar, @i_tramite) + ' NO ES DEL TIPO ' + @i_tipo
      goto ERRORFIN
   end

   exec sp_query_tramite
   @t_debug           = @t_debug,
   @t_file            = @t_file,
   @t_from            = @t_from,
   @i_tramite         = @i_tramite,
   @i_numero_op_banco = @i_numero_op_banco,
   @i_linea_credito   = @i_linea_credito,
   @i_producto        = @i_producto,
   @i_modo            = @i_modo,
   @i_es_acta         = @i_es_acta,
   @i_tipo            = @i_tipo,
   @i_usuario_apr     = @i_usuario_apr,
   @i_comite          = @i_comite
   
end


/* Igualar   Activa con respecto  de la Pasiva en   Redescuentos */
if @i_operacion = 'X' begin

   select
   @w_operacion_pas  =  op_operacion,
   @w_banco_pasiva      =  op_banco,
   @w_tipo_amortiza  =  ltrim(rtrim(op_tipo_amortizacion))
   from cob_cartera..ca_operacion
   where op_operacion = @i_operacion_pasiva
   
   if @w_tipo_amortiza = 'MANUAL' begin
      print 'Para Operaciones manuales, Fechas Inicio,  Fin   de Op.Activa y Op.Pasiva deben ser iguales...REVISAR!!'
      return  0
   end
   
   select @w_tramite_act = tr_tramite
   from cr_tramite
   where tr_op_redescuento =  @w_operacion_pas
   
   select
   @w_banco_activa   =  op_banco,
   @w_operacion_act = op_operacion
   from cob_cartera..ca_operacion
   where op_tramite = @w_tramite_act
   
   /*   CREAR OPERACION   ACTIVA EN   TEMPORALES */
   exec @w_error = cob_cartera..sp_pasotmp
   @s_user              =  @s_user,
   @s_term              =  @s_term,
   @i_banco             =  @w_banco_activa,
   @i_operacionca       =  'S',
   @i_dividendo         =  'S',
   @i_amortizacion      =  'S',
   @i_cuota_adicional   =  'S',
   @i_rubro_op          =  'S',
   @i_relacion_ptmo     =  'S',
   @i_nomina            =  'S'
   
   if @w_error <>   0 begin
      select @w_msg = 'ERROR AL EJECUTAR EL PROCESO sp_pasotmp DE CARTERA'
      goto ERRORFIN
   end
   
   /* IGUALAR  OPERACION ACTIVA CON PASIVA */
   exec @w_error = cob_cartera..sp_redescuento_int
   @s_user                  = @s_user,
   @s_date                  = @s_date,
   @s_ofi                = @s_ofi,
   @s_term               = @s_term,
   @i_operacion          = 'G',                     --'G' : Igualar Activa con   Pasiva
   @i_pasiva                = @w_banco_pasiva,   --   op_banco de la pasiva
   @i_activa                = @w_banco_activa,   --   op_banco de la activa
   @i_moneda                = @i_moneda,            --   moneda de   la operacion
   @i_tipo_op            = 'R',                     --'R' : Pasiva   con   redescuento
   @i_hereda                = 'N',
   @i_credito            = 'S'
   
   if @w_error <>   0 begin
   
      exec @w_error = cob_cartera..sp_borrar_tmp_int
      @s_user  = @s_user,
      @s_sesn  = @s_sesn,
      @i_banco    = @w_banco_activa
      
      select @w_msg = 'ERROR AL EJECUTAR EL PROCESO sp_redescuento_int DE CARTERA'
      goto ERRORFIN
   end


   /*   PASO DEFINITIVA   OPERACION   ACTIVA */
   exec @w_error = cob_cartera..sp_pasodef
   @i_banco           =  @w_banco_activa,
   @i_operacionca     = 'S',
   @i_dividendo       = 'S',
   @i_amortizacion    = 'S',
   @i_cuota_adicional = 'S',
   @i_rubro_op        = 'S',
   @i_relacion_ptmo   = 'S'
   
   if   @w_error <> 0  begin 
      exec @w_error = cob_cartera..sp_borrar_tmp_int
      @s_user     =  @s_user,
      @s_sesn     =  @s_sesn,
      @i_banco    =  @w_banco_activa
      
      select @w_msg = 'ERROR AL EJECUTAR EL PROCESO sp_pasodef DE CARTERA'
      goto ERRORFIN
   end

   /*   BORRAR OPERACION ACTIVA EN TEMPORALES  */
   exec @w_error = cob_cartera..sp_borrar_tmp_int
   @s_user     =  @s_user,
   @s_sesn     =  @s_sesn,
   @i_banco =  @w_banco_activa
   
   if @w_error <> 0 begin  
      select @w_msg = 'ERROR AL EJECUTAR EL PROCESO sp_borrar_tmp_int DE CARTERA'
      goto ERRORFIN
   end
end


--LPO 17/Jul/2009 INICIO. Se regenera la secuencia en etapa de aprobación por si el director cambia el monto

if @w_tipo_etapa = 'A' begin

   select 
   @w_alto_riesgo = en_alto_riesgo
   from cobis..cl_ente with (nolock)
   where en_ente = @w_cliente

   if @w_alto_riesgo <> 'S' 
   begin
   
      exec @w_error    = sp_secuencia_g
      @s_date           = @s_date,
      @t_trn            = 21929,
      @i_tramite        = @i_tramite,
      @i_tabla_temporal = 'S',
      @i_origen         = 'T'             -- PAQUETE 2. REQ 214 - LLAMADO DESDE EL TRANSMITIR
   
      if @w_error <> 0  begin
         select @w_msg = 'ERROR AL EJECUTAR EL PROCESO sp_secuencia_g'
         goto ERRORFIN
      end

      select @w_secu_regen = se_secuencia
      from  cr_secuencia
      where se_tramite  = @i_tramite
      and   se_estacion = @w_estacion_sec
   
      update cr_secuencia set -- Para que luego de regenerar la secuencia no vuelva a pasar el trámite por las estaciones ya visitadas
      se_estado = 'A'
      where se_tramite = @i_tramite
      and   se_secuencia < @w_secu_regen
   
      if @@error <> 0 begin
         select @w_error = 2105001, @w_msg = 'ERROR AL ACTUALIZAR EL ESTADO DE LA TABLA cr_secuencia'
         goto ERRORFIN
      end
   end
   
end

--LPO 17/Jul/2009 FIN. Se regenera la secuencia en etapa de aprobación por si el director cambia el monto

return 0

ERRORFIN:

if @w_commit = 'S' begin
   rollback tran
   select @w_commit = 'N'
end

if @i_crea_ext is null
begin
   exec cobis..sp_cerror
   @t_from  = @w_sp_name,
   @i_num   = @w_error,
   @i_msg   = @w_msg
   
   return 1
end
else
begin
   if @o_msg_msv is null
   begin
      if @w_msg is null
      begin
         select @w_msg = mensaje
         from   cobis..cl_errores
         where  numero     = @w_error
      end
      select @o_msg_msv = @w_msg + ', ' + @w_sp_name
   end
   select @w_return = @w_error
   return @w_return
end
GO

