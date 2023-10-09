/************************************************************************/
/*      Archivo:                renoact.sp                              */
/*      Stored procedure:       sp_renova_act                           */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Carolina Alvarado                       */
/*      Fecha de documentacion: 21-Sep-95                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa mueve realiza todas las operaciones sobre el      */
/*      deposito actual , si es renovacion de vencida o es una          */
/*      instruccion de renovacion que llega a su fecha de vencimiento.  */
/************************************************************************/
/*      01-Jun-2007 N. Silva          Cambios para conservar codigo de  */
/*                                    renovacion (pf_operacion_renov)e  */
/*                                    identacion.                       */
/*                                    Implementacion de cuotas          */
/*      22-Feb-07  Rolando Linares    Tomar la Codigo del beneficiario  */
/*                                    Para enviar a SBA si es clie. MIS */
/*      07-Nov-2014 Andres Diab       REQ455 Incluir Tipo Producto en   */
/*                                    consulta de tasa referencia       */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_renova_act')
   drop proc sp_renova_act
go

create proc sp_renova_act (
   @s_ssn                  int             = NULL,
   @s_org                  char(1)         = NULL,
   @s_ssn_branch           int             = NULL,          
   @s_user                 login           = NULL,
   @s_term                 varchar(30)     = NULL,
   @s_date                 datetime        = NULL,
   @s_sesn                 int             = NULL,
   @s_srv                  varchar(30)     = NULL,
   @s_lsrv                 varchar(30)     = NULL,
   @s_ofi                  smallint        = NULL,
   @s_rol                  smallint        = NULL,
   @t_debug                char(1)         = 'N',
   @t_file                 varchar(10)     = NULL,
   @t_from                 varchar(32)     = NULL,
   @t_trn                  smallint        = NULL,
   @i_cuenta               cuenta,
   @i_operacionpf          int,
   @i_cuenta_ant           cuenta,
   @i_en_linea             char(1)         = 'S',
   @i_puntos               float           = 0,
   @i_descripcion          descripcion     = '',
   @i_ley                  char(1)         = NULL,
   @i_fecha_cal_tasa       datetime        = NULL,
   @i_fecha_proceso        datetime,
   @i_estado_ant           catalogo,                 -- Activacion
   @i_retiene_imp_capital  char (1)        = 'N',
   @i_impuesto_capital     money           = 0,
   @i_tasa_efectiva        float           = 0,      -- 04-May-2000 Tasa Efec/Nom
   @i_flag_tasaefec        char(1)         = 'N',    -- 04-May-2000 Tasa Efec/Nom
   @i_tasa_variable        char(1)         = 'N',    -- 12-Abr-2000 TASA VARIABLE
   @i_mnemonico_tasa       catalogo        = NULL,   -- 12-Abr-2000 TASA VARIABLE
   @i_modalidad_tasa       char(1)         = NULL,   -- 12-Abr-2000 TASA VARIABLE
   @i_periodo_tasa         smallint        = NULL,   -- 12-Abr-2000 TASA VARIABLE
   @i_descr_tasa           descripcion     = NULL,   -- 12-Abr-2000 TASA VARIABLE
   @i_operador             char(1)         = NULL,   -- 12-Abr-2000 TASA VARIABLE
   @i_spread               float           = 0,      -- 12-Abr-2000 TASA VARIABLE
   @i_aut_spread           login           = NULL,   -- 12-Abr-2000 TASA VARIABLE
   @i_inicio               int             = NULL,
   @i_tipcuenta            char(3)         = NULL,
   @i_cuenta_banco         cuenta          = NULL,
   @i_fin                  int             = NULL,
   @i_diahabil             char(1)         = 'S',
   @i_plazo_orig           int             = NULL,
   @i_cotizacion           float           = 1,
   @i_calldate             datetime        = NULL,
   @i_historia             int             = NULL,
   @i_desmaterializar      char(1)         = 'N'
)
with encryption
as
declare @w_sp_name                      varchar(32),
        @w_return                       int,
        @w_ced_ruc                      varchar(35),
        @w_moneda_pg                    char(2),
        @w_comentario                   varchar(32),
        @w_descripcion                  descripcion,
        @w_siguiente                    int,
        @w_error                        int,
        @w_secuencial                   int,
        @w_secuencia                    int,
        @w_sec_ticket                   int,
        @w_sec                          int,
        @w_num_oficial                  int,
        @w_money                        money,
        @w_int_ganado                   money,
        @w_total_monet                  money,
        @w_monto_renovar                money,
        @w_monto_c                      varchar(20),
        @w_ch1                          catalogo,
        @w_impuesto                     money,
        @w_tot_int                      money,
        @w_activa                       char(1),
        @w_fecha_hoy                    datetime,
        @w_numdeci                      tinyint,
        @w_usadeci                      char(1),
        @w_cotizacion                   float,
        @w_cotizacion_compra_billete    float,
        @w_cotizacion_venta_billete     float,
        @w_cotizacion_conta             float,
        @w_flag_incremento              smallint,
        @w_flag_error                   tinyint, 
        @w_moneda_base                  tinyint, 
        @w_emite_orden                  char(1),
        @w_mm_oficina                   int,
        @w_mensaje                      varchar(100),

/* VARIABLES NECESARIAS PARA PF_BENEFICIARIO PF_BENEFICIARIO_TMP */
        @w_bt_ente                      int,
        @w_bt_rol                       catalogo,
/* VARIABLES NECESARIAS PARA PF_MOV_MONET */
        @w_mt_secuencia                 int,
        @w_mt_sub_secuencia             int,
        @w_sub_secuencia                int,
        @w_mt_producto                  catalogo,
        @w_mt_cuenta                    cuenta,
        @w_mt_tipo                      char(1),
        @w_mt_beneficiario              int,
        @w_mt_impuesto                  money,
        @w_mt_moneda                    int,
        @w_mt_valor_ext                 money,
        @w_mt_fecha_crea                datetime,
        @w_mt_fecha_mod                 datetime,
        @w_mt_valor                     money,
        @w_mt_val                       money,
        @w_mt_impuesto_capital_me       money,
        @w_mt_cta_corresp               cuenta,
        @w_mt_cod_corresp               catalogo,
        @w_mt_benef_corresp             varchar(245),
        @w_mt_ofic_corresp              int,
/* Variables para det_pago_tmp  */
        @w_pt_beneficiario              int,
        @w_sec1                         int,
        @w_pt_sec                       int,
        @w_pt_tipo                      catalogo,
        @w_pt_forma_pago                catalogo,
        @w_pt_cuenta                    cuenta,
        @w_pt_monto                     money,
        @w_pt_porcentaje                float,
        @w_p_mon_sgte                   int,
        @w_pt_moneda_pago               smallint,
/* Variables para condicion_tmp  */
        @w_co_condicion                 tinyint,
        @w_co_comentario                varchar(60),
/*  Variables para la operacion anterior en Renovacion */
        @w_op_tasa                      float,
        @w_operacionpf                  int,
        @w_monto_pg_int                 money,
        @w_estado                       catalogo,
        @w_ente                         int,
        @w_toperacion                   catalogo,
        @w_categoria                    catalogo,
        @w_oficina                      smallint,
        @w_moneda                       tinyint,
        @w_num_dias                     smallint,
        @w_op_num_dias                  smallint, --MVG 24/092009
        @w_dif                          smallint,
        @w_base_calculo                 smallint,
        @w_monto                        money,
        @w_incremento                   money,
        @w_incremento_monet             money,
        @w_monto_act                    money,
        @w_fpago                        catalogo,
        @w_op_fpago                     catalogo,
        @w_ppago                        catalogo,
        @w_casilla                      tinyint,
        @w_direccion                    tinyint,
        @w_telefono                     varchar(8),
        @w_historia                     smallint,
        @w_mon_sgte                     smallint,
        @w_retienimp                    char(1),
        @w_fecha_valor                  datetime,
        @w_fecha_ven                    datetime,
        @w_fecha_ven1                   datetime,
        @w_int_estimado                 money,
        @w_total_int_estimado           money,
        @w_total_int_acumulado          money,
        @w_renova_todo                  char(1),
        @w_tcapitalizacion              char(1),
        @w_fecha_mod                    datetime,
        @w_tasa                         float,
        @w_tasa1                        float,
        @w_tasa_act                     float,
        @w_tasa_mer                     float,
        @w_dia_pago                     tinyint,
        @w_tipo_deposito                smallint,
        @w_tipo_plazo                   catalogo,
        @w_tipo_monto                   catalogo,
        @w_fecha_pg_int                 datetime,
        @w_fecha_real_pg                datetime,
        @w_tasa_efectiva                float ,
        @w_mm_valor                     money,
        @w_mm_valor_me                  money,
        @w_mm_valor_ext                 money,
        @w_mm_impuesto_capital          money,
        @w_mm_impuesto_capital_me       money,
        @w_monto_inicial                money,
        @w_monto_anterior               money,
        @w_funcionario                  login,
        @w_fpago_ticket                 int,
        @w_prorroga_aut                 char(1),     -- 06-Abr-2000 Prorroga Aut.
        @w_num_dias_gracia              int,         -- 06-Abr-2000 Prorroga Aut.
        @w_anio_comercial               char(1),     -- 04/Abr/2000 Fech. Comer.
        @w_spread_vig                   float,       -- 12-Abr-2000 Tasa Variable.
        @w_spread_max                   float,       -- 12-Abr-2000 Tasa Variable.
        @w_spread_min                   float,       -- 12-Abr-2000 Tasa Variable.
        @w_op_oficial_principal         login,
        @w_fecha_ingreso                datetime,
        @w_fecha_crea                   datetime, --CVA OCt-20-05
        @w_td_dias_reales               char(1),
        @w_op_renovaciones              int,
        @w_int_vencido                  money,
        @w_total_int_pagado             money,
        @w_normal                       char(1),
        @w_int_renovar                  money,
        @w_total_int_ganado             money,
        @w_causa_mod                    catalogo,
        @w_op_num_prorroga              int,
        @w_op_pignorado                 char(1),
        @w_op_monto_pgdo                money,
        @w_op_tipo_tasa_var             char(1),
        @w_op_sec_incre                 int,
        @w_ente_corresp                 int, -- GAR GB-DP00120 Cliente Correspondencia
        @w_spread_fijo                  float,
        @w_operador_fijo                char(1),
        @w_camb_oper                    int,
        @w_plazo_orig                   int,
        @w_cremento_suspenso            money,
        @w_tasa_variable                char(1),
        @w_flag_tasaefec                char(1),
        @w_tasa_efectiva_conver         float,
        @w_oficina_renova               varchar(6),
        @w_limite_max                   float,
        @w_limite_min                   float,
        @w_monto_max                    money,
        @w_usa_limite                   char(1),
        @w_oficial                      login,
        @w_cumplio_suspenso             tinyint,   
        @w_operador                     char(1),
        @w_spread                       float,
        @w_mnemonico_tasa_var           catalogo,
        @w_valor_tasa_var               float,
        @w_num_meses                    int,
        @w_periodo_tasa                 smallint,
        @w_modalidad_tasa               char(1),
        @w_descr_tasa                   descripcion,
        @w_periodo                      float,
        @w_incremento_suspenso          money,
        @w_incremento_suspenso_act      money,
        @w_tasa_new_vigente             float,
        @w_susp                         money,
        @w_oficial_secundario           login,     --ccr manejo del oficial secundario
        @w_captador                     login,     --ccr manejo del captador
        @w_casilla_renov                tinyint,   --ccr variable para manejo de entrega de correspondencia
        @w_direccion_renov              tinyint,   --ccr variable para manejo de entrega de correspondencia
        @w_sucursal_renov               smallint,  --ccr variable para manejo de entrega de correspondencia
        @w_mm_sub_secuencia             int,
        @w_mm_producto                  catalogo,
        @w_mm_cuenta                    cuenta,
        @w_mm_moneda                    smallint,
        @w_mm_impuesto                  money,
        @w_secuencia_aplm               int,
        @w_mm_tipo                      char(1),
        @w_op_bloqueo_legal             char(1),   --ccr manejo de estado de bloqueo legal
        @w_op_monto_blqlegal            money,     --ccr manejo de monto de bloqueo legal
        @w_op_retenido                  char(1),   --ccr manejo de estado de bloqueo
        @w_op_monto_blq                 money,     --ccr manejo de monto de bloqueo
        @w_op_origen_fondos             catalogo,  --ccr manejo de origen de fondos
        @w_op_proposito_cuenta          catalogo,  --ccr manejo de proposito de cuenta
        @w_sum_det_pago                 money,     --ccr suma de los valores de pf_det_pago
        @w_monto_ajuste                 money,     --ccr monto a ajustar en ultimo registro de pf_det_pago en caso de diferencia
        @w_op_oficina_apertura          smallint,  --LIM 11/NOV/2005
        @w_op_oficial_apertura          login,      --LIM 11/NOV/2005
        @w_op_toperacion_apertura       catalogo,    --LIM 11/NOV/2005
        @w_op_tipo_plazo_apertura       catalogo,   --LIM 15/NOV/2005
        @w_op_tipo_monto_apertura       catalogo,    --LIM 15/NOV/2005
        @w_op_localizado                char(1),
        @w_op_fecha_localizacion        datetime,
        @w_op_fecha_no_localiza         datetime,
        @w_op_inactivo                  char(1),
        @w_oficial_pri                  login,
        @w_oficial_sec                  login,
        @w_localizado                   char(1),
        @w_fecha_localizado             datetime,
        @w_fecha_no_localiza            datetime,
        @w_inactivo                     char(1),
        @w_pi_cuenta                    cuenta,     --
--Variables servicios bancarios
        @w_concepto                     varchar(255),
        @w_producto_fpago               tinyint,    
        @w_area_contable                int,
        @w_numero                       int,
        @w_campo1                       varchar(20),
        @w_campo47                      descripcion,
        @w_campo48                      descripcion,
        @w_cheque_ger                   catalogo,
        @w_secuencial_cheque            int, 
        @w_mm_beneficiario              int,
        @w_mm_benef_corresp             varchar(255),      --*-*
        @w_descripbenef                 varchar(250),
        @w_campo40                      char(1),
        @w_idlote                       int,
        @w_conceptosb                   tinyint,
        @w_modifica                     char(1),
        @w_batch                        char(1),
        @w_cod_ben                      varchar(255), --  RLINARES 02222007 */
        @w_origen_ben                   varchar(1),    /*  RLINARES 02222007 */
        @w_campo2                       varchar(20),    -- GAL 07/SEP/2009 - INTERFAZ - CHQCOM
        @w_campo3                       varchar(20),    -- GAL 07/SEP/2009 - INTERFAZ - CHQCOM
        @w_campo4                       varchar(20),    -- GAL 07/SEP/2009 - INTERFAZ - CHQCOM
        @w_campo5                       varchar(20),    -- GAL 23/SEP/2009 - INTERFAZ - CHQCOM  
        @w_campo6                       varchar(20),    -- GAL 23/SEP/2009 - INTERFAZ - CHQCOM
        @w_campo7                       varchar(20),    -- GAL 23/SEP/2009 - INTERFAZ - CHQCOM
        @w_tipo_benef                   catalogo,       -- GAL 07/SEP/2009 - INTERFAZ - CHQCOM
        @w_desc_conc_renova             descripcion,    -- GAL 07/SEP/2009 - INTERFAZ - CHQCOM
        @w_mpago_chqcom                 varchar(30),    -- GAL 07/SEP/2009 - INTERFAZ - CHQCOM
        @w_cod_conc_renova              varchar(30),    -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
        @w_instr_chqcom                 tinyint,        -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
        @w_mm_subtipo_ins               int,            -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM 
        @w_instrumento                  tinyint,        -- GAL 22/SEP/2009 - INTERFAZ - CHQCOM
        @w_subtipo_ins                  int,            -- GAL 22/SEP/2009 - INTERFAZ - CHQCOM
        @w_beneficiario                 varchar(255),   -- GAL 22/SEP/2009 - INTERFAZ - CHQCOM
        @w_referencia                   cuenta,         -- GAL 22/SEP/2009 - INTERFAZ - CHQCOM
        @w_area_origen                  smallint,       -- GAL 23/SEP/2009 - INTERFAZ - CHQCOM
        @w_instrumento_chger            tinyint,        -- MAL 26/OCT/2009 
        @w_subtipo_ins_chger            int,             -- MAL 26/OCT/2009 
	@w_dias_reales			varchar(2),
        @w_bloqueado                    varchar(10),
        @w_malaref                      varchar(10),
        @w_par_pago			varchar(20),
        @w_mensaje_1                    varchar(100),
        @w_bt_tipo			varchar(5),
        @w_re_puntos			float,
        @w_tasa_max                     float,
        @w_tasa_min                     float,
        @w_conc0                        float,
        @w_conc1                        float,
	@w_op_spread                    float,
        @w_valor_tasa_var_aux           float
 
select @w_sp_name          = 'sp_renova_act',
       @w_secuencial       = @s_ssn,
       @w_flag_error       = 0,
       @w_cumplio_suspenso = 0,
       @w_monto_act        = 0,
       @w_incremento_monet = 0

/*---------------------------------*/
/* Verificar numero de transaccion */
/*---------------------------------*/
if   @t_trn <> 14920
begin
   exec cobis..sp_cerror
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_num       = 141112
   return 141112
end


-- NYM INC 152 Busca nemonico de parametro valor por pagar 

select @w_par_pago = pa_char
  from cobis..cl_parametro
 where pa_producto = 'PFI'
   and pa_nemonico = 'NVXP'


select @w_moneda_base = em_moneda_base
from cob_conta..cb_empresa where em_empresa = 1


select @w_fecha_hoy = @i_fecha_proceso,
       @w_tasa_mer = 0

select @w_numdeci = isnull(pa_tinyint,0)
from cobis..cl_parametro
where pa_nemonico = 'DCI'
and   pa_producto = 'PFI'

-- MEDIO DE PAGO CHEQUE COMERCIAL - GAL 08/SEP/2009 - INTERFAZ - CHQCOM
select @w_mpago_chqcom = pa_char             
from cobis..cl_parametro
where pa_nemonico = 'CHQCOM'
and   pa_producto = 'PFI'

-- CODIGO DE CONCEPTO DE EMISION POR RENOVACION - GAL 08/SEP/2009 - INTERFAZ - CHQCOM
select @w_cod_conc_renova = pa_char             
from cobis..cl_parametro
where pa_nemonico = 'EMRENO'
and   pa_producto = 'PFI'

-- INSTRUMENTO DE SERVICIOS BANCARIOS ASOCIADO CHEQUES COMERCIALES - GAL 08/SEP/2009 - INTERFAZ - CHQCOM
select @w_instr_chqcom = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'INCHCO'
and   pa_producto = 'PFI'

-- INSTRUMENTO CHEQUES DE GERENCIA - MAL 26/OCT/2009 
select @w_instrumento_chger = pa_int
from cobis..cl_parametro
where pa_nemonico = 'ICHDG'
and   pa_producto = 'PFI'

-- SUBTIPO INSTRUMENTO CHEQUES DE GERENCIA - MAL 26/OCT/2009
select @w_subtipo_ins_chger = pa_int
from cobis..cl_parametro
where pa_nemonico = 'SICHDG'
and   pa_producto = 'PFI'

-- MEDIO DE PAGO CHEQUE GERencia - GAL 08/SEP/2009 - INTERFAZ - CHQCOM

select @w_cheque_ger = pa_char
  from cobis..cl_parametro
 where pa_nemonico='NCHG'
   and pa_producto='PFI'

---------------------------------------------
-- Acceso para obtener datos de pf_operacion
---------------------------------------------
select @w_operacionpf            = op_operacion,
       @w_ente                   = op_ente,
       @w_toperacion             = op_toperacion,
       @w_categoria              = op_categoria,
       @w_oficina                = op_oficina,
       @w_fecha_ingreso          = op_fecha_ingreso,
       @w_fecha_crea             = op_fecha_crea, 
       @w_moneda                 = op_moneda,
       @w_base_calculo           = op_base_calculo,
       @w_monto                  = op_monto,
       @w_total_int_acumulado    = op_total_int_acumulado,
       @w_int_ganado             = op_int_ganado,
       @w_renova_todo            = op_renova_todo,
       @w_monto_pg_int           = op_monto_pg_int,
       @w_historia               = op_historia,
       @w_fecha_ven              = op_fecha_ven,
       @w_op_fpago               = op_fpago,
       @w_ppago                  = op_ppago,
       @w_casilla                = op_casilla,
       @w_direccion              = op_direccion,
       @w_telefono               = op_telefono,
       @w_retienimp              = op_retienimp,
       @w_tcapitalizacion        = op_tcapitalizacion,
       @w_estado                 = op_estado,
       @w_tasa1                  = op_impuesto,
       @w_p_mon_sgte             = op_mon_sgte,
       @w_prorroga_aut           = op_prorroga_aut,         -- 06-Abr-2000 Prorroga Aut.
       @w_num_dias_gracia        = op_num_dias_gracia,      -- 06-Abr-2000 Prorroga Aut.
       @w_op_oficial_principal   = op_oficial_principal,
       @w_op_renovaciones        = op_renovaciones,
       @w_total_int_ganado       = op_total_int_ganados,
       @w_total_int_pagado       = op_total_int_pagados,
       @w_op_num_prorroga        = op_num_prorroga,
       @w_op_pignorado           = op_pignorado,
       @w_op_monto_pgdo          = op_monto_pgdo,
       @w_op_tipo_tasa_var       = op_tipo_tasa_var,
       @w_op_sec_incre           = op_sec_incre,
       @w_camb_oper              = op_camb_oper, 
       @w_incremento_suspenso    = isnull(op_incremento_suspenso, 0),
       @w_tasa_variable          = op_tasa_variable,
       @w_flag_tasaefec          = op_flag_tasaefec,
       @w_oficial                = op_oficial,
       @w_tcapitalizacion        = op_tcapitalizacion,
       @w_total_int_estimado     = op_total_int_estimado,
       @w_mnemonico_tasa_var     = op_mnemonico_tasa,
       @w_periodo_tasa           = op_periodo_tasa,
       @w_modalidad_tasa         = op_modalidad_tasa,
       @w_descr_tasa             = op_descr_tasa,
       @w_oficial_secundario     = op_oficial_secundario,      -- ccr manejo de oficial secundario
       @w_captador               = op_captador,                 -- ccr manejo de captador
       @w_op_retenido            = op_retenido,                 -- ccr manejo de estado de bloqueo
       @w_op_monto_blq           = op_monto_blq,                -- ccr manejo de monto de bloqueo
       @w_op_bloqueo_legal       = op_bloqueo_legal,            -- ccr manejo de estado de bloqueo legal
       @w_op_monto_blqlegal      = op_monto_blqlegal,           -- ccr manejo de monto de bloqueo legal
       @w_op_origen_fondos       = op_origen_fondos,            -- ccr manejo de origen de fondos
       @w_op_proposito_cuenta    = op_proposito_cuenta,         -- ccr manejo de proposito de cuenta
       @w_op_oficina_apertura    = op_oficina_apertura,        --LIM 11/NOV/2005
       @w_op_oficial_apertura    = op_oficial_apertura,        --LIM 11/NOV/2005
       @w_op_toperacion_apertura = op_toperacion_apertura,     --LIM 11/NOV/2005
       @w_op_tipo_plazo_apertura = op_tipo_plazo_apertura,      --LIM 15/NOV/2005
       @w_op_tipo_monto_apertura = op_tipo_monto_apertura,      --LIM 15/NOV/2005
       @w_op_localizado          = op_localizado,
       @w_op_fecha_localizacion  = op_fecha_localizacion,
       @w_op_fecha_no_localiza   = op_fecha_no_localiza,
       @w_op_inactivo            = op_inactivo,
       @w_op_tasa                = op_tasa,
       @w_op_num_dias            = op_num_dias,            --MVG 24/09/2009
	@w_dias_reales	         = op_dias_reales,
	@w_operador		 = op_operador,
	@w_spread		 = op_spread
from pf_operacion
where op_num_banco = @i_cuenta_ant

if @@rowcount = 0
begin
   exec cobis..sp_cerror
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_msg       = @w_estado,
      @i_num       = 141051
      
   return 141051
end
------------------------------------
-- Encuentra parametro de decimales
------------------------------------
select @w_usadeci = mo_decimales
  from cobis..cl_moneda
 where mo_moneda = @w_moneda
if @w_usadeci = 'S'
begin
   select @w_numdeci = isnull (pa_tinyint,0)
     from cobis..cl_parametro
    where pa_nemonico = 'DCI'
      and pa_producto = 'PFI'
end
else
   select @w_numdeci = 0


if @w_dias_reales = 'N' 
   select @w_anio_comercial = 'S'
else   
   select @w_anio_comercial = 'N'


---------------------------------------
-- Analisis para retencion de impuesto
---------------------------------------
if @w_retienimp = 'S'
begin
   select @w_tasa1 = pa_float
     from cobis..cl_parametro
    where pa_producto = 'PFI'
      and pa_nemonico = 'IMP'
end  /* Si paga impuesto  */
else
   select @w_tasa1 = 0

select @w_monto_pg_int      = @w_monto_pg_int + isnull(@w_total_int_acumulado,0),
       @w_incremento        = 0

select @w_tasa              = re_tasa,
       @w_num_dias          = re_plazo,
       @w_mt_secuencia      = re_renovacion,
       @w_incremento        = re_incremento,
       @w_descripcion       = re_descripcion,
       @w_fecha_valor       = re_fecha_valor,
       @w_moneda_pg         = re_moneda_pg,
       @w_monto_renovar     = isnull(re_monto_renovar,0),   --xca
       @w_impuesto          = re_impuesto,
       @w_tot_int           = re_tot_int,
       @w_monto_anterior    = re_monto,
       @w_renova_todo       = re_renova_todo,
       @w_funcionario       = re_oficial,
       @w_int_vencido       = re_int_vencido,
       @w_ente_corresp      = re_ente_corresp, --GAR GB-DP00120
       @w_dia_pago          = re_dia_pago, --GAR GB-DP00120 Dia Pago
       @w_td_dias_reales    = re_dias_reales,
       @w_fpago             = re_fpago,
       @w_ppago             = re_ppago,
       @w_spread_fijo       = isnull(re_spread_fijo, 0),
       @w_operador_fijo     = isnull(re_operador_fijo, '+'),
       @w_plazo_orig        = re_plazo_orig,
       @w_casilla_renov     = re_casilla,
       @w_direccion_renov   = re_direccion,
       @w_sucursal_renov    = re_sucursal,
       @w_oficial_pri       = re_oficial_principal,
       @w_oficial_sec       = re_oficial_secundario,
       @w_localizado        = re_localizado,
       @w_fecha_localizado  = re_fecha_localizado,
       @w_fecha_no_localiza = re_fecha_no_localizado,
       @w_inactivo          = re_inactivo,
       @w_re_puntos         = re_puntos
  from pf_renovacion
 where re_operacion = @w_operacionpf
   and re_estado = 'I'
if @@rowcount = 0
begin
   exec cobis..sp_cerror
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_num       = 141138
   return 141138
end

if @i_descripcion is null
   select @i_descripcion = @w_descripcion


select @w_ch1 = convert(varchar(20),@w_monto_act)

----------------------------------------
-- Proceso de renovacion de operaciones        
----------------------------------------


   if @i_en_linea = 'N'  --CVA Oct-21-05 Esto debe ser para instrucciones o renovaciones en linea
   begin
   
      --CCR se busca en pf_mov_monet la existencia de valores en suspenso para
      --comparar con op_incremento_suspenso
      select @w_susp = sum(mm_valor)
      from pf_mov_monet
      where mm_tran     = 14904
      and   mm_producto = 'SUSP'
      and   mm_estado       is null
      and   mm_operacion   = @w_operacionpf
      and   mm_valor <> 0
      and   mm_secuencia   = (select max(mm_secuencia)
                              from pf_mov_monet
                              where mm_operacion  = @w_operacionpf
                              and mm_tran         = 14904
                              and mm_estado      is null
                              and mm_valor       <> 0
                              and mm_producto     = 'SUSP')
      
      select @w_susp = isnull(@w_susp, 0)

      if @w_incremento_suspenso < @w_susp
      begin
         select   @w_incremento = 0,
            @w_incremento_suspenso_act = @w_incremento_suspenso      

         --CCR actualizo los registros de pf_mov_monet para que no sean
         --considerados
         update   pf_mov_monet
         set   mm_estado   = 'R'
         where mm_tran     = 14904
         and   mm_estado   is null
         and   mm_operacion   = @w_operacionpf
         and   mm_valor <> 0
         and   mm_secuencia   = (select max(mm_secuencia)
                                 from pf_mov_monet
                                 where mm_operacion  = @w_operacionpf
                                 and mm_tran         = 14904
                                 and mm_estado      is null
                                 and mm_valor       <> 0)

         --Reportar error en la instruccion
         select @w_error = 141217
         goto ERROR

      end --@w_incremento_suspenso < @w_susp
      else
      begin
         select   @w_incremento_suspenso_act = @w_incremento_suspenso - @w_susp        
      end

      ---------------------------------------------------
      -- APLICACION DE MOVIMIENTOS MONETARIOS DE 14904
      ---------------------------------------------------    
      select @w_mm_sub_secuencia = 0 
      while 1 = 1
      begin
     
         set rowcount 1
         select 
             @w_mm_sub_secuencia       = mm_sub_secuencia,
             @w_mm_producto            = mm_producto,
             @w_mm_moneda              = mm_moneda,
             @w_mm_cuenta              = mm_cuenta,
             @w_mm_valor               = mm_valor,
             @w_mm_valor_ext           = mm_valor_ext,
             @w_secuencia_aplm         = mm_secuencia,
             @w_mm_tipo                = mm_tipo,
             @w_mm_oficina             = mm_oficina,
             @w_mm_beneficiario        = mm_beneficiario,  /* rlinares 02222007 */
             @w_mm_benef_corresp       = mm_benef_corresp,                --*-*
             @w_origen_ben             = mm_tipo_cliente,   /* rlinares 02222007 */
             @w_mm_subtipo_ins         = mm_subtipo_ins     -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
         from pf_mov_monet
         where mm_operacion      = @w_operacionpf
         and   mm_tran           = 14904
         and   mm_secuencia      = (select max(mm_secuencia)
                                    from pf_mov_monet
                                    where mm_operacion  = @w_operacionpf
                                    and   mm_tran       = 14904
                                    and   mm_estado    is null
                                    and   mm_valor     <> 0)
         and   mm_estado        is  null
         and   mm_sub_secuencia  > @w_mm_sub_secuencia
         and   mm_valor         <> 0
         order by mm_sub_secuencia
         
         if @@rowcount = 0
            break

         -- INI NYM 152
         print ' nym  152 w_mm_beneficiario' + cast(@w_mm_beneficiario as varchar)
         print 'w_mm_producto' + cast(@w_mm_producto as varchar)
         print 'w_par_pago' + cast(@w_par_pago as varchar)
	 if @w_mm_producto in (@w_cheque_ger,@w_mpago_chqcom) and @w_mm_tipo = 'C' begin
	    if exists (      
	    select 	1
      	    from 	cobis..cl_ente,
			cobis..cl_refinh
      	    where en_ente 		= @w_mm_beneficiario 
      	    and	en_mala_referencia 	= 'S'
	    and	in_tipo_ced 		= en_tipo_ced
	    and	in_ced_ruc 		= en_ced_ruc
	    ) begin
               select @w_mensaje_1 = 'Aplica_inst_can. Se cambio medio de pago '+  @w_mm_producto + '  a VXP por que Ente: ' + cast(@w_mm_beneficiario as varchar) + ' Esta en Ref.Inhibitorias'
               select @w_mm_producto = @w_par_pago
               exec sp_errorlog
                    @i_fecha   = @s_date,
                    @i_error   = 0,
                    @i_usuario = @s_user,
                    @i_tran    = @t_trn,
                    @i_descripcion = @w_mensaje_1,
                    @i_cuenta  = @i_cuenta
      	    end

            print 'w_mm_producto' + cast(@w_mm_producto as varchar)

            update  pf_mov_monet
            set	  mm_producto = @w_mm_producto
	    where mm_operacion      = @w_operacionpf
	    and   mm_tran           = 14904
	    and   mm_secuencia      = @w_secuencia_aplm
	    and   mm_sub_secuencia  = @w_mm_sub_secuencia
            and   mm_estado        is  null
	    and   mm_valor         <> 0
	    
         end
         -- INI NYM 152

         -------------------------------------------------------------------------------------------------
         -- Proceso para enviar hacia aplicmov @i_alterno incrementado siempre y cuando mm_cuenta IS  NOT NULL 
         -------------------------------------------------------------------------------------------------
         if @w_mm_moneda = @w_moneda_base  -- Moneda nacional
            select @w_mm_valor_ext = 0    

         if @w_mm_tipo = 'C' --disminucion por instruccion
            select @w_emite_orden = 'S'
         else
            select @w_emite_orden = 'N'

         select @w_incremento_monet = @w_incremento_monet + @w_mm_valor
              
--print 'renoact @w_mm_beneficiario:%1!',@w_mm_beneficiario --*-*

         exec @w_return = sp_aplica_mov
            @s_ssn             = @s_ssn,
            @s_ssn_branch      = @s_ssn_branch,  
            @s_user            = @s_user,
            @s_ofi             = @s_ofi, 
            @s_date            = @s_date,
            @s_srv             = @s_srv,
            @s_term            = @s_term,
            @t_file            = @t_file,
            @t_from            = @w_sp_name, 
            @t_debug           = @t_debug,
            @t_trn             = 14904,
            @i_tipo            = 'N', 
            @i_operacionpf     = @w_operacionpf,
            @i_secuencia       = @w_secuencia_aplm, 
            @i_sub_secuencia   = @w_mm_sub_secuencia,
            @i_en_linea        = @i_en_linea,
            @i_retiene_capital = 'N',
            @i_emite_orden     = @w_emite_orden,
            @i_benefi          = @w_mm_benef_corresp --*-* 
            
         if @w_return <> 0
         begin
            select @w_flag_error = 1
            select @w_error =  @w_return          
            goto ERROR          
         end

         set rowcount 0 
      
         if @w_flag_error = 0
         begin

            update pf_mov_monet
            set mm_fecha_valor = @i_fecha_proceso,
            	mm_ssn_branch          = @s_ssn_branch
            where mm_operacion     = @w_operacionpf
            and   mm_tran          = 14904
            and   mm_sub_secuencia = @w_mm_sub_secuencia
            and   mm_secuencia     = @w_secuencia_aplm
            if @@error <> 0
            begin
               select @w_error =  145020
               goto ERROR          
            end          

            if @w_mm_tipo = 'C' --disminucion por instruccion
            begin
            --print '@w_mm_producto  '+ @w_mm_producto 
               select @w_producto_fpago = fp_producto,
                    @w_area_contable  = fp_area_contable
               from   pf_fpago
               where  fp_mnemonico = @w_mm_producto                   
               if @@error <> 0
               begin
                  if @i_en_linea = 'S'
                  begin
                     exec cobis..sp_cerror
                        @t_debug        = @t_debug,
                        @t_file         = @t_file,
                        @t_from         = @w_sp_name,
                        @i_num          = 141111   
                     return 141111    
                  end
                  else
                  begin
                     select @w_error = 141111   
                     goto ERROR
                  end
               end     
           
               if (@w_producto_fpago = 42) 
               begin
                  /************************************************************************/
                  /* Verificar si es beneficiario del MIS O EXTERNO     rlinares 02222007 */
                  /************************************************************************/
                  if @w_origen_ben <> 'M' /* Si es diferente de MIS NO ENVIO  DATOS A SBANCARIOS */
                  begin
                     select @w_cod_ben = NULL
                     select @w_origen_ben = NULL
                  end 
                  else
                  begin
                     select @w_cod_ben = convert(varchar(255),@w_mm_beneficiario)
                  end
                  ----------------------------------------------------
                  -- Tomar la descripcion del beneficiario del cheque 
                  ----------------------------------------------------
                  select @w_descripbenef     = ec_descripcion
                  from  pf_emision_cheque
                  where ec_operacion        = @w_operacionpf
                  and   ec_tran             = 14904
                  and   ec_secuencia        = @w_secuencia_aplm
                  and   ec_sub_secuencia    = @w_mm_sub_secuencia
                    
                  if @w_area_contable is null
                  begin
                     select @w_area_contable = td_area_contable
                     from   pf_tipo_deposito
                     where  td_mnemonico = @w_toperacion                                          
                     
                     if @@error <> 0
                     begin
                        if @i_en_linea = 'S'
                        begin
                           exec cobis..sp_cerror
                              @t_debug        = @t_debug,
                              @t_file         = @t_file,
                              @t_from         = @w_sp_name,
                              @i_num          = 141115 
                              
                           return 141115 
                        end
                        else
                        begin
                           select @w_error = 141115
                           goto ERROR
                        end
                     end
                  end 
                  
                  exec @w_idlote  = cob_interfase..sp_isba_cseqnos   -- BRON: 15/07/09  cob_sbancarios..sp_cseqnos 
                     @i_tabla     = 'sb_identificador_lotes', 
                     @o_siguiente = @w_numero out                 
                  
                  select @w_campo47  = tn_descripcion,
                         @w_concepto = substring(tn_descripcion,1,25) 
                  from   cobis..cl_ttransaccion
                  where  tn_trn_code = 14904
                  
                  select @w_concepto = 'DISMINUCION ' + @w_concepto                              
                  select @w_campo48  = 'DEPOSITO A PLAZO ' + @i_cuenta_ant
                                         
                  select @w_campo1 = 'PFI' 
                                           
                  if @w_mm_producto = @w_cheque_ger
                     select @w_campo40 = 'E'
      
                  ------------------------------------------------------------------
                  -- Tomar el codigo del concepto asignado a DPF en catalogo se SBA
                  ------------------------------------------------------------------                        
                  select @w_conceptosb = convert(tinyint,codigo) 
                  from   cobis..cl_catalogo 
                  where tabla in (select codigo 
                                  from   cobis..cl_tabla 
                                  where  tabla = 'sb_conceptos_implot') 
                  and   valor  = 'DPF'
                  
                  -- INICIO - GAL 07/SEP/2009 - INTERFAZ - CHQCOM                    
                              
                   if @w_mm_producto in (@w_mpago_chqcom , @w_cheque_ger)
                  begin
                     -- OBTENER DATOS DEL TITULAR DEL CREDITO
                     select @w_campo1 = en_tipo_ced + '-' + en_ced_ruc,                 -- TIPO Y NUMERO DEL TITULAR EJ. CC-79876543
                            @w_campo2 = en_nomlar                                       -- NOMBRE TITULAR                           
                     from   cobis..cl_ente
                     where  en_ente = @w_ente
                     


               		--NYMBMIA OBTENER DATOS DEL BENEFICIARIO
	               	if @w_origen_ben = 'M' begin                              -- ESTA EN COBIS..CL_ENTE
	                	select 	@w_campo3     		= en_tipo_ced + '-' + en_ced_ruc,         -- TIPO Y NUMERO DEL BENEFICIARIO EJ. CC-79876545
	                         	@w_beneficiario     	= en_nomlar,                              -- NOMBRE BENEFICIARIO
	                         	@w_tipo_benef = c_tipo_compania
	                  	from   cobis..cl_ente
	                  	where  en_ente = @w_mm_beneficiario
	               	end 
	               	else begin
	                	select @w_campo3     		= ce_cedula,                              -- NUMERO DEL BENEFICIARIO 
	                        	@w_beneficiario 	= ce_nombre                               -- NOMBRE BENEFICIARIO
	                  	from   pf_cliente_externo
	                  	where  ce_secuencial = @w_mm_beneficiario
	               	end

                     
                     select @w_tipo_benef = isnull(nullif(ltrim(rtrim(@w_tipo_benef)), ''), 'PA')
                     
                     select @w_desc_conc_renova = valor
                     from cobis..cl_tabla T, cobis..cl_catalogo C
                     where T.tabla  = 'cc_concepto_emision'
                     and   C.tabla  = T.codigo
                     and   C.codigo = @w_cod_conc_renova
                     
		               if @w_mm_producto = @w_mpago_chqcom
		         	   begin
		                  select 
		               		@w_instrumento  = @w_instr_chqcom,
		               		@w_subtipo_ins  = @w_mm_subtipo_ins
		         	   end
		              
		               if @w_mm_producto = @w_cheque_ger 
		               begin
		                  select	
		               		@w_instrumento  = @w_instrumento_chger,
		               		@w_subtipo_ins  = @w_subtipo_ins_chger 
		               end
                     
                     select 
                        @w_campo5       = @i_cuenta_ant,                               -- NUMERO PLAZO FIJO (CONOCIDO POR EL CLIENTE)
                        @w_campo6       = @w_cod_conc_renova,                          -- C+DIGO CONCEPTO DE RENOVACI+N
                        @w_campo7       = @w_desc_conc_renova,                         -- DESCRIPCI+N CONCEPTO DE RENOVACI+N
                        @w_campo4	= @w_beneficiario,
                        @w_referencia   = cast(@w_operacionpf as varchar),
                        @w_area_origen  = 99
                  end
                  else
                  begin
                     select
                        @w_beneficiario = @w_descripbenef,
                        @w_campo2       = @w_concepto,          -- descripcion de la transaccion
                        @w_area_origen  = 90
                  end
                                     
                  exec @w_return = cob_interfase..sp_isba_imprimir_lotes  -- BRON: 15/07/09  cob_sbancarios..sp_imprimir_lotes
                     @s_ssn              = @s_ssn,
                     @s_user             = @s_user,
                     @s_term             = @s_term,
                     @s_date             = @s_date,
                     @s_srv              = @s_srv,
                     @s_lsrv             = @s_lsrv,
                     @s_ofi              = @s_ofi,
                     @t_debug            = @t_debug,
                     @t_trn              = 29334,
                     @i_oficina_origen   = @w_oficina,
                     @i_ofi_destino      = @w_mm_oficina,
                     @i_area_origen      = @w_area_origen,
                     @i_func_solicitante = 0,
                     @i_fecha_solicitud  = @s_date,
                     @i_producto         = 4,
                     @i_instrumento      = @w_instrumento,
                     @i_subtipo          = @w_subtipo_ins,
                     @i_valor            = @w_mm_valor,
                     @i_beneficiario     = @w_beneficiario,
                     @i_referencia       = @w_referencia,
                     @i_tipo_benef       = @w_tipo_benef,
                     @i_campo1           = @w_campo1,
                     @i_campo2           = @w_campo2,
                     @i_campo3           = @w_campo3,
                     @i_campo4           = @w_campo4,
                     @i_campo5           = @w_campo5,
                     @i_campo6           = @w_campo6,
                     @i_campo7           = @w_campo7,
                     @i_campo8           = @w_campo48,           -- 'DEPOSITO A PLAZO ' + @w_num_banco                                              
                     @i_observaciones    = @w_concepto,                                                                                  
                     @i_llamada_ext      = 'S',
                     @i_concepto         = @w_conceptosb,        -- CATALOGO DE SERVICIOS BANCARIOS (3)
                     @i_fpago            = @w_mm_producto,       -- NUEVO REQUERIMIENTO SBA (NEMONICO DE LA FORMA DE PAGO)
                     @i_moneda           = @w_mm_moneda,         -- @w_moneda,
                     @i_origen_ing       = '3',
                     @i_idlote           = @w_numero,            -- SECUENCIAL DEL SEQNOS DE SERVICIOS BANCARIOS
                     @i_cod_ben          = @w_cod_ben,           /*  RLINARES 02222007 */
                     @i_orig_ben         = @w_origen_ben,        /*  RLINARES 02222007 */
                     @i_estado           = 'D',                  -- GAL 28/SEP/2009 - RVVUNICA
                     @i_campo21          = 'PFI',                -- GAL 28/SEP/2009 - RVVUNICA
                     @i_campo22          = 'D',                  -- GAL 28/SEP/2009 - RVVUNICA
                     @o_idlote           = @w_idlote out,                                                                             
                     @o_secuencial       = @w_secuencial_cheque out    
                     
                  -- FIN - GAL 28/SEP/2009 - INTERFAZ - CHQCOM     
                  
                  if @w_return <> 0
                  begin
                     if @i_en_linea = 'S'
                     begin
                        exec cobis..sp_cerror
                           @t_debug        = @t_debug,
                           @t_file         = @t_file,
                           @t_from         = @w_sp_name,
                           @i_num          = 141095
                        return 141095
                     end
                     else
                     begin
                        select @w_error = 141168
                        goto ERROR
                     end
                  end

                  ----------------------------------------------------------
                  -- Actualizar registro en pf_emision_cheque para que
                  -- no pueda ser cargado en pantalla de emision de ordenes
                ----------------------------------------------------------
                  update pf_emision_cheque
                  set    ec_fecha_emision    = @s_date,
                         ec_numero           = @w_numero,
                         ec_estado           = 'A',
                         ec_caja             = 'S',
                         ec_secuencial_lote  = @w_secuencial_cheque,     --LIM 12/OCT/2005
                         ec_subtipo_ins      = @w_subtipo_ins       --@w_mm_subtipo_ins         -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
                  where ec_operacion        = @w_operacionpf
                  and   ec_tran             = 14904
                  and   ec_secuencia        = @w_secuencia_aplm
                  and   ec_sub_secuencia    = @w_mm_sub_secuencia          
                  
                  if @@rowcount = 0
                  begin
                     select @w_error = 145031
                     goto ERROR
                  end
                            
                  -------------------------------------------------------------
                  -- Actualizar mm_num_cheque para reverso Servicios Bancarios
                  -------------------------------------------------------------
                  if @w_mm_producto in (@w_mpago_chqcom, @w_cheque_ger)                -- GAL 08/SEP/2009 - RVVUNICA
                  begin
                     update pf_mov_monet set
                        mm_subtipo_ins     = @w_subtipo_ins,     --@w_mm_subtipo_ins,
                        mm_secuencial_lote = @w_secuencial_cheque
                     where mm_operacion      = @w_operacionpf
                     and   mm_tran           = 14094
                     and   mm_secuencia      = @w_secuencia_aplm
                     and   mm_sub_secuencia  = @w_mm_sub_secuencia          
                  end
                  else
                  begin
                     update pf_mov_monet
                     set    mm_num_cheque = @w_numero
                     where mm_operacion      = @w_operacionpf
                     and   mm_tran           = 14094
                     and   mm_secuencia      = @w_secuencia_aplm
                     and   mm_sub_secuencia  = @w_mm_sub_secuencia          
                  end
                  
                  if @@error <> 0
                  begin            
                     select @w_error = 145020
                     goto ERROR
                  end
      
               end   --if (@w_producto_fpago = 42) 
            end --mm_tipo = 'C'
         end --flagerror = 0

         if @w_flag_error = 1 
         begin
            update pf_mov_monet
            set  mm_estado   = 'R'
            where mm_tran      = 14904
            and   mm_operacion = @w_operacionpf
            and   mm_secuencia = @w_secuencia_aplm
            
            if @@error <> 0
            begin
               select @w_error =  145020
               goto ERROR          
            end           

            select @w_incremento = 0, @w_incremento_monet = 0
         end
      end /* END WHILE 1 */

      select @w_monto_act     = @w_monto_renovar + isnull(@w_incremento,0)


if @t_debug = 'S' print '1 @w_tasa_variable  ' + cast (@w_tasa_variable  as varchar)

      if @w_tasa_variable = 'N'
      begin          
         select  @w_tasa_efectiva_conver = 0          
         select @w_oficina_renova = convert(varchar(6),@w_oficina)
      end
      else --Variable
      begin
         -----------------------------------------------------------
         -- Proceso para tomar el valor de la tasa variable para el
         -- siguiente periodo de pago de intereses (Tasa Variable)
         -----------------------------------------------------------
         exec @w_return = cob_pfijo..sp_cons_tasa_var
            @t_trn          = 14416,
            @i_operacion    = 'Q',
            @i_tipo         = 'N',
            @i_cod_tasa_ref = @w_mnemonico_tasa_var,--Cod. tasa referencial
            @i_fecha        = @s_date,   --Fecha de consulta
            @i_moneda       = @w_moneda, --Moneda de la negociacion
            @i_batch        = 'S',
            @i_toperacion   = @w_toperacion,      -- REQ455 Tipo Producto para buscar tasa IBR dia anterior
            @o_valor_ref    = @w_valor_tasa_var out --valor tasa referencial           
         --'if @w_return <> 0
         --'begin
         --'   select @w_error = @w_return
         --'   goto ERROR
         --'end

         if @w_mnemonico_tasa_var = 'ESC'
            select @w_valor_tasa_var = @w_tasa
      end




      -----------------------------------------------------------
      -- Calculo de la tasa nominal a partir de la tasa efectiva
      -- unicamente para operaciones que trabajan con tasa fija
      -----------------------------------------------------------
      select @w_tasa_new_vigente = @w_tasa

if @t_debug = 'S' print '2 @w_valor_tasa_var  ' + cast (@w_valor_tasa_var  as varchar) + '@w_flag_tasaefec  ' + cast (@w_flag_tasaefec  as varchar) + '@w_renova_todo  ' + cast (@w_renova_todo  as varchar)


      if (@w_flag_tasaefec = 'S') and (@w_renova_todo = 'S')
      begin
         select @w_tasa_efectiva_conver = 0           

         if @w_operador_fijo = '+'
            select @w_tasa_efectiva_conver = @w_tasa + @w_spread_fijo
         else
            select @w_tasa_efectiva_conver = @w_tasa - @w_spread_fijo


         select @w_periodo=pp_factor_en_meses
         from pf_ppago 
         where pp_codigo = @w_ppago
         if @@rowcount = 0
            select @w_periodo = @w_base_calculo / @w_num_dias
         else
            select @w_periodo = 12 / @w_periodo
         
         if @w_fpago in('ANT', 'PRA')
         begin
            select @w_tasa_new_vigente = ( 1 - power(1 + (@w_tasa_efectiva_conver / 100), -1 / @w_periodo) ) * @w_periodo * 100
            select @w_tasa_new_vigente = round(@w_tasa_new_vigente,6)
         end
         else /* Forma de pago PER,VEN' */
         begin
            select @w_tasa_efectiva_conver = ( power(1 + @w_tasa_efectiva_conver / 100, 1/@w_periodo) - 1 ) * @w_periodo * 100

            select @w_tasa_efectiva_conver = round(@w_tasa_efectiva_conver,6)
         end
      end  -- if (@w_flag_tasaefec = 'S') and (@w_renova_todo = 'S')

      if @w_flag_tasaefec = 'N'
                   select @w_tasa_efectiva_conver = 0


if @t_debug = 'S' print '3 @w_tasa_new_vigente  ' + cast (@w_tasa_new_vigente  as varchar) 
if @t_debug = 'S' print '4 @i_tasa_efectiva  ' + cast (@i_tasa_efectiva  as varchar) 

      if @w_tasa_new_vigente is not null
      begin
         if @w_spread_fijo <> 0
         begin
            if @w_operador_fijo = '+'
               select @i_tasa_efectiva = @w_tasa_efectiva_conver
            else
               select @i_tasa_efectiva = @w_tasa_efectiva_conver
         end
         else
            select @i_tasa_efectiva = @w_tasa_efectiva_conver
      end

if @t_debug = 'S'  print '5 @i_tasa_efectiva  ' + cast (@i_tasa_efectiva  as varchar) 

   end --@i_en_linea = 'N'
   else
   begin
      select @w_incremento_suspenso_act = @w_incremento_suspenso
      select @w_monto_act               = @w_monto_renovar + isnull(@w_incremento,0)
   end


   select @w_tasa_efectiva = @i_tasa_efectiva                             --04-May-2000 Tasa Efec/Nom

if @t_debug = 'S'  print '6 @w_tasa_efectiva  ' + cast (@w_tasa_efectiva  as varchar) 

   select @w_tipo_deposito  = td_tipo_deposito--,
          --@w_anio_comercial = td_anio_comercial                        --04/04/2000 Fecha Comercial
   from pf_tipo_deposito
   where td_mnemonico = @w_toperacion
   and   td_estado    = 'A'
   
   if @@rowcount = 0
   begin
      select @w_error = 141115
      goto ERROR
   end

   select @w_ch1 = convert(varchar(20),@w_monto_act)
   -------------------------------
   --  Ojo calcular tasa efectiva
   -------------------------------
   select @w_tipo_monto = mo_mnemonico
   from pf_monto, pf_auxiliar_tip
   where @w_monto_act     >= mo_monto_min
   and   @w_monto_act     <= mo_monto_max
   and   mo_mnemonico      = at_valor
   and   at_tipo           = 'MOT'
   and   at_tipo_deposito  = @w_tipo_deposito
   and   at_moneda         = @w_moneda
   and   at_estado         = 'A'
   
   if @@rowcount = 0
   begin
      if @i_en_linea = 'S'
      begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 141053
         return 141053  
      end
      else
      begin
         select @w_error = 141053
         goto ERROR
      end
   end


if @t_debug = 'S'  print '7.1 @w_dias_reales  ' + cast (@w_dias_reales  as varchar) 
if @t_debug = 'S'  print '7.1 @w_num_dias  ' + cast (@w_num_dias  as varchar) 
if @t_debug = 'S'  print '7.1 @w_fecha_valor  ' + cast (@w_fecha_valor  as varchar) 
if @t_debug = 'S'  print '7.1 @w_dia_pago  ' + cast (@w_dia_pago  as varchar) 


   --------------------------------
   -- Evaluacion del a¤o comercial
   --------------------------------
   if @w_dias_reales = 'S'
      select @w_fecha_ven = dateadd(dd,@w_num_dias,@w_fecha_valor)
   else
   begin   -- Fecha Comercial
      exec sp_funcion_1
           @i_operacion = 'SUMDIA',
           @i_fechai    = @w_fecha_valor,
           @i_dias      = @w_num_dias,
           @i_dia_pago  = @w_dia_pago,
           @o_fecha     = @w_fecha_ven out
   end

if @t_debug = 'S'  print '7.1 @w_fecha_ven  ' + cast (@w_fecha_ven  as varchar) 
   
   exec sp_primer_dia_labor
      @t_debug       = @t_debug,
      @t_file        = @t_file,
      @t_from        = @w_sp_name,
      @i_fecha       = @w_fecha_ven,
      @s_ofi         = @w_oficina,
      @i_tipo_deposito = @w_tipo_deposito,
      @o_fecha_labor = @w_fecha_ven1 out

if @t_debug = 'S'  print '7.1 @w_fecha_ven1  ' + cast (@w_fecha_ven1  as varchar) 
   
   if @w_dias_reales = 'S'
      select @w_dif=datediff(dd,@w_fecha_ven,@w_fecha_ven1)
   else
   begin   -- Fecha Comercial
      exec sp_funcion_1
         @i_operacion = 'DIFE30',
         @i_fechai   = @w_fecha_ven,
         @i_fechaf   = @w_fecha_ven1,
         @i_dia_pago = @w_dia_pago,
         @o_dias     = @w_dif out
   end
   if @w_dif > 0
      select @w_num_dias=@w_num_dias + @w_dif


if @t_debug = 'S'  print '7.1 @w_dif  ' + cast (@w_dif  as varchar) 
if @t_debug = 'S'  print '7.1 @w_num_dias  ' + cast (@w_num_dias  as varchar) 

   
   select @w_tipo_plazo = pl_mnemonico
   from pf_plazo, pf_auxiliar_tip
   where @w_num_dias     >= pl_plazo_min
   and   @w_num_dias     <= pl_plazo_max
   and   pl_mnemonico     = at_valor
   and   at_tipo          = 'PLA'
   and   at_tipo_deposito = @w_tipo_deposito
   and   at_moneda        = @w_moneda
   and   at_estado        = 'A'
   
   if @@rowcount = 0
   begin
      if @i_en_linea = 'S'
      begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 141054
         return 141054
      end
      else
      begin
         select @w_error = 141054
         goto ERROR
      end
   
   end
   
   --CVA Jun-30-06
   if @i_en_linea = 'N'
   begin
      select 
         @i_tasa_variable  = @w_tasa_variable,
         @i_periodo_tasa   = @w_periodo_tasa,     -- cobis..te_pizarra..pi_periodo
         @i_modalidad_tasa = @w_modalidad_tasa,     -- cobis..te_pizarra..pi_modalidad, en la IPC no aplica 
         @i_descr_tasa     = @w_descr_tasa,
         @i_mnemonico_tasa = @w_mnemonico_tasa_var     -- DTF, TCC, IPC, PRIME, ESC
   end


if @t_debug = 'S'  print '7.2 @i_tasa_variable  ' + cast (@i_tasa_variable  as varchar) 

   -------------------------------
   -- Evaluacion de Tasa variable
   -------------------------------
   if @i_tasa_variable = 'N'
   begin
      select @w_tasa_mer = ta_vigente,
             @w_tasa_act = ta_vigente
      from pf_tasa
      where ta_tipo_deposito =  @w_toperacion
      and   ta_moneda        =  @w_moneda
      and   ta_tipo_monto    =  @w_tipo_monto
      and   ta_tipo_plazo    =  @w_tipo_plazo
      
      if @@rowcount = 0
      begin
         if @i_en_linea = 'S'
         begin
            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 141055
            return 141055
         end
         else
         begin
            select @w_error = 141055
            goto ERROR
         end
      end

	select @w_tasa_efectiva = @w_tasa_act

if @t_debug = 'S'  print '7.2 @w_tasa_efectiva  ' + cast (@w_tasa_efectiva  as varchar) 

         if isnull(@w_spread_fijo,0) > 0
         begin
            if @w_operador_fijo = '+'
               select @w_tasa_efectiva  = @w_tasa_efectiva + isnull(@w_spread_fijo,0)
            else
               select @w_tasa_efectiva  = @w_tasa_efectiva - isnull(@w_spread_fijo,0)
         end

         if isnull(@w_re_puntos,0) > 0
         begin
            if @w_operador_fijo = '+'
               select @w_tasa_efectiva  = @w_tasa_efectiva + isnull(@w_re_puntos,0)
            else
               select @w_tasa_efectiva  = @w_tasa_efectiva - isnull(@w_re_puntos,0)
         end

if @t_debug = 'S'  print '7.2 @w_spread_fijo  ' + cast (@w_spread_fijo  as varchar) 
if @t_debug = 'S'  print '7.2 @w_operador_fijo  ' + cast (@w_operador_fijo  as varchar) 
if @t_debug = 'S'  print '7.2 @w_tasa_efectiva  ' + cast (@w_tasa_efectiva  as varchar) 


   end
   else
   begin  
      -----------------------------------------------------------
      -- Proceso para tomar el valor de la tasa variable para el
      -- siguiente periodo de pago de intereses (Tasa Variable)
      -----------------------------------------------------------
   
      exec @w_return = cob_pfijo..sp_tasa_variable
          @t_trn             = 14415,
          @i_operacion       = 'Q',
          @i_tipo            = 'E',
          @i_monto           = @w_monto_act,
          @i_plazo           = @w_num_dias,
          @i_mnemonico_prod  = @w_toperacion,
          @i_moneda          = @w_moneda,
          @i_batch           = 'S',
          @i_tipo_plazo      = @w_tipo_plazo,         -- xca 18-Oct-2005
          @i_mnemonico_tasa  = @w_mnemonico_tasa_var,  -- xca 18-Oct-2005
          @o_operador        = @w_operador out,              -- operador (+/-)
          @o_spread_vigente  = @w_spread out,                -- valor spread vigente
          @o_tasa_max        = @w_tasa_max out,          -- xca 18-Oct-2005
          @o_tasa_min        = @w_tasa_min out               -- xca 18-Oct-2005

       if @w_return <> 0
       begin
          select @w_mensaje = 'Error recibido por sp_tasa_variable'
          select @w_error = @w_return
          goto ERROR
       end

       exec @w_return = cob_pfijo..sp_cons_tasa_var
         @t_trn      = 14416,
         @i_operacion   = 'Q',
         @i_tipo     = 'N',
         @i_cod_tasa_ref   = @w_mnemonico_tasa_var,--Cod. tasa referencial
         @i_fecha = @s_date,   --Fecha de consulta
         @i_moneda   = @w_moneda, --Moneda de la negociacion
         @i_batch = 'S',
         @i_toperacion   = @w_toperacion,      -- REQ455 Tipo Producto para buscar tasa IBR dia anterior
         @o_valor_ref   = @w_valor_tasa_var out --valor tasa referencial            
   
       if @w_valor_tasa_var = 0 begin
          select @w_tasa_mer = @w_tasa
          select @w_valor_tasa_var = @w_tasa
       end

if @t_debug = 'S'  print '@w_valor_tasa_var ' + cast ( @w_valor_tasa_var  as varchar)

if @t_debug = 'S'  print '@w_operador_fijo ' + cast ( @w_operador_fijo as varchar)
if @t_debug = 'S'  print '@w_re_puntos' + cast (@w_re_puntos  as varchar)

if @t_debug = 'S'  print '@w_spread ' + cast(  @w_spread as varchar)
if @t_debug = 'S'  print '@w_operador  ' + cast ( @w_operador   as varchar)

       select @w_valor_tasa_var_aux  = @w_valor_tasa_var 
       
       if isnull(@w_re_puntos,0) > 0
       begin
          if @w_operador_fijo = '+'
             select @w_valor_tasa_var  = @w_valor_tasa_var + isnull(@w_re_puntos,0)
          else
             select @w_valor_tasa_var  = @w_valor_tasa_var - isnull(@w_re_puntos,0)
       end

if @t_debug = 'S'  print ' 2@w_valor_tasa_var ' + cast ( @w_valor_tasa_var  as varchar)

       if isnull(@w_spread,0) > 0
       begin
          if @w_operador  = '+'
             select @w_valor_tasa_var  = @w_valor_tasa_var + isnull(@w_spread,0)
          else
             select @w_valor_tasa_var  = @w_valor_tasa_var - isnull(@w_spread,0)
       end

if @t_debug = 'S'  print '3@w_valor_tasa_var ' + cast ( @w_valor_tasa_var  as varchar)

       if @w_valor_tasa_var > @w_tasa_max
          select @w_valor_tasa_var = @w_tasa_max

       if @w_valor_tasa_var < @w_tasa_min
	  select @w_valor_tasa_var = @w_tasa_min



 --NYM INC 44213
	  if isnull(@w_spread_fijo,0) > 0 or isnull(@w_re_puntos,0) > 0 begin
	     select @w_conc0 = isnull(@w_operador_fijo,'+') + convert(varchar(100),isnull(@w_re_puntos,0))
	     select @w_conc1 = isnull(@w_operador ,'+') + convert(varchar(100),isnull(@w_spread,0))
	     select @w_op_spread = convert(float,@w_conc0 ) + convert(float,@w_conc1)

	     if @w_op_spread  > 0
		    select @w_operador = '+'
	     else
		   select @w_operador = '-'

	     select @w_spread = abs(@w_op_spread )
      end

      select @w_valor_tasa_var = @w_valor_tasa_var_aux  

if @t_debug = 'S' print ' @w_operador ' + cast ( @w_operador as varchar)
if @t_debug = 'S' print 'yyy  @w_spread ' + cast ( @w_spread as varchar)
if @t_debug = 'S' print '3 @w_valor_tasa_var ' + cast ( @w_valor_tasa_var  as varchar)


       ------------------------------
       -- Tomar valor para num_meses
       ------------------------------
       select @w_num_meses = pp_factor_en_meses
       from pf_ppago
       where pp_codigo = @w_ppago

       if @w_ppago = 'NNN'
       begin
          select @w_num_meses = 0
       end


       if @t_debug = 'S' print 'w_toperacion ' + cast (@w_toperacion as varchar)
       if @t_debug = 'S' print 'w_valor_tasa_var ' + cast (@w_valor_tasa_var as varchar)
       if @t_debug = 'S' print 'w_periodo_tasa ' + cast (@w_periodo_tasa as varchar)
       if @t_debug = 'S' print 'w_modalidad_tasa ' + cast (@w_modalidad_tasa as varchar)
       if @t_debug = 'S' print 'w_descr_tasa ' + cast (@w_descr_tasa as varchar)
       if @t_debug = 'S' print 'w_operador ' + cast (@w_operador as varchar)
       if @t_debug = 'S' print 'w_spread ' + cast (@w_spread as varchar)
       if @t_debug = 'S' print 'w_base_calculo ' + cast (@w_base_calculo as varchar)
       if @t_debug = 'S' print 'w_fpago ' + cast (@w_fpago as varchar)
       if @t_debug = 'S' print 'w_num_meses ' + cast (@w_num_meses as varchar)

       --------------------------------------------
       -- Proceso para Calculo de la tasa variable
       --------------------------------------------
       exec @w_return = cob_pfijo..sp_calcula_tasa_var
          @t_trn             = 14948,
          @i_toperacion      = @w_toperacion,
          @i_vr_tasa_var     = @w_valor_tasa_var,
          @i_periodo_tasa    = @w_periodo_tasa,
          @i_modalidad_tasa  = @w_modalidad_tasa, -- en la IPC no aplica
          @i_descr_tasa      = @w_descr_tasa,
          @i_mnemonico_tasa  = @w_mnemonico_tasa_var,
          @i_operador        = @w_operador,
          @i_spread          = @w_spread,
          @i_base_calculo    = @w_base_calculo,
          @i_modalidad_prod  = @w_fpago,
          @i_per_pago        = @w_num_meses,
          @i_plazo           = @w_num_dias,
          @i_en_linea        = 'N',
          @i_moneda          = @w_moneda,
          @i_monto           = @w_monto,
          @i_inicio_periodo  = 'S',     --CVA Jun-20-06 Para que obtenga la tasa del primer rango del periodo
          @o_tasa_EA         = @w_tasa_efectiva out, /* valor tasa efect */
          @o_tasa_nom_reexp  = @w_tasa out /* valor tasa nominal */

       if @w_return <> 0
       begin
          select @w_mensaje = 'Error recibido por sp_calcula_tasa_var'
          select @w_error = @w_return
          goto ERROR
       end
	

       if @t_debug = 'S' print '7.2 w_tasa_efectiva ' + cast (@w_tasa_efectiva as varchar)
       if @t_debug = 'S' print '7.2 w_tasa ' + cast (@w_tasa as varchar)
   
   end

if @t_debug = 'S'  print '8 @w_valor_tasa_var  ' + cast (@w_valor_tasa_var  as varchar) 
if @t_debug = 'S' print '8 @w_tasa_mer  ' + cast (@w_tasa_mer  as varchar) 
if @t_debug = 'S' print '8 @w_tasa_act  ' + cast (@w_tasa_act  as varchar) 
if @t_debug = 'S' print '8 @w_tasa  ' + cast (@w_tasa  as varchar) 
if @t_debug = 'S' print '8 @w_flag_tasaefec  ' + cast (@w_flag_tasaefec  as varchar) 
if @t_debug = 'S' print '8 @i_tasa_variable  ' + cast (@i_tasa_variable  as varchar) 
if @t_debug = 'S' print '8 @w_flag_tasaefec  ' + cast (@w_flag_tasaefec  as varchar) 


/*
   -----------------------------------------
   -- Conversion de tasa Efectiva a Nominal
   -----------------------------------------
   if @w_tasa = 0
   begin
      if (@w_flag_tasaefec = 'N') and (@i_tasa_variable = 'N')
         select @w_tasa = @w_tasa_act
      ------------------------------------------------------------------------------------------------------------------------
      -- Proceso incrementado para calcular la tasa nominal a partir de la tasa efectiva leida en la tabla pf_tasa 4-May-2000
      ------------------------------------------------------------------------------------------------------------------------
      if @w_flag_tasaefec = 'S'
      begin
         select @w_tasa_efectiva = @w_tasa_act
         exec @w_return = sp_tasa_nominal
              @s_ssn             = @s_ssn,
              @s_user            = @s_user,
              @s_sesn            = @s_sesn,
              @s_ofi             = @s_ofi,
              @s_date            = @s_date,
              @t_trn             = 14950,
              @s_srv             = @s_srv,
              @s_term            = @s_term,
              @t_file            = @t_file,
              @t_from            = @w_sp_name,
              @t_debug           = @t_debug,
              @i_tasa_efectiva   = @w_tasa_act,
              @i_op_ppago        = @w_ppago,
              @i_op_fpago        = @w_fpago,
              @i_td_base_calculo = @w_base_calculo,
              @i_op_num_dias     = @w_num_dias,
              @o_tasa_nominal    = @w_tasa out      -- Valor de la tasa nominal
         if @w_return <> 0
         begin
            select @w_error = @w_return
            goto ERROR
         end
      end
   end --if @w_tasa = 0
*/


if @t_debug = 'S' print '9 @w_tasa_efectiva  ' + cast (@w_tasa_efectiva  as varchar) 
if @t_debug = 'S' print '9 @w_tasa  ' + cast (@w_tasa  as varchar) 


   if @i_descripcion is null
      select @i_descripcion='Por Renovacion'
   
   --CVA Jun-30-06 para escalonados
   if charindex('C',@w_tipo_plazo) > 0 
      select @w_modifica = 'S'
   else
      select @w_modifica = 'N'

   ------------------------------------------
   -- Evaluar si se trata de Fecha Comercial
   ------------------------------------------
   if @i_en_linea     = 'N'
      select @w_batch = 'S'
   else
      select @w_batch = 'N'

   --CCR no se calcula en base al anio comercial sino a los dias reales
   --if @w_td_dias_reales = 'S'                                                           GAL 14/SEP/2009 - RVVUNICA
   --begin
   
   
   
if @t_debug = 'S' print '10 @w_fecha_valor  ' + cast (@w_fecha_valor  as varchar) 
if @t_debug = 'S' print '10 @w_fecha_ven1  ' + cast (@w_fecha_ven1  as varchar) 
if @t_debug = 'S' print '10 @w_monto_act  ' + cast (@w_monto_act  as varchar) 
if @t_debug = 'S' print '10 @w_tasa  ' + cast (@w_tasa  as varchar) 
if @t_debug = 'S' print '10 @w_dia_pago  ' + cast (@w_dia_pago  as varchar) 
if @t_debug = 'S' print '10 @w_base_calculo  ' + cast (@w_base_calculo  as varchar) 
   
      exec sp_estima_int
         @i_fecha_inicio    = @w_fecha_valor,
         @s_ofi             = @s_ofi,
         @s_date            = @s_date,
         @i_fecha_final     = @w_fecha_ven1,
         @i_monto           = @w_monto_act,
         @i_tasa            = @w_tasa,
         @i_tcapitalizacion = @w_tcapitalizacion,
         @i_fpago           = @w_fpago,
         @i_ppago           = @w_ppago,
         @i_dias_anio       = @w_base_calculo,
         @i_dia_pago        = @w_dia_pago,
      
         @i_retienimp       = @w_retienimp,        --29-abr-99 capitalizacion xca-B077
         @i_moneda          = @w_moneda,           --29-abr-99 capitalizacion xca-B077
         -- @i_diahabil        = @i_diahabil,      GAL 01/SEP/2009 - CSQL
         @i_dias_reales     = @w_td_dias_reales,
         --I. CVA Jun-30-06 Parametros para escalonado
         @i_modifica        = @w_modifica,
         @i_op_operacion    = @w_operacionpf,
         @i_toperacion      = @w_toperacion,               
         @i_periodo_tasa    = @i_periodo_tasa,       -- cobis..te_pizarra..pi_periodo
         @i_modalidad_tasa  = @i_modalidad_tasa,     -- cobis..te_pizarra..pi_modalidad, en la IPC no aplica 
         @i_descr_tasa      = @i_descr_tasa,
         @i_mnemonico_tasa  = @i_mnemonico_tasa,     -- DTF, TCC, IPC, PRIME, ESC
         @i_tipo_plazo      = @w_tipo_plazo, 
         @i_en_linea        = @i_en_linea,   
         @i_batch           = @w_batch,
         --F. CVA Jun-30-06 Parametros para escalonado
         @o_fecha_prox_pg   = @w_fecha_pg_int out,
         @o_fecha_real_pg   = @w_fecha_real_pg out,
         @o_int_pg_pp       = @w_int_estimado out,
         @o_int_pg_ve       = @w_total_int_estimado out


if @t_debug = 'S' print '10 @w_int_estimado  ' + cast (@w_int_estimado  as varchar) 
if @t_debug = 'S' print '10 @w_total_int_estimado  ' + cast (@w_total_int_estimado  as varchar) 
if @t_debug = 'S' print '10 @w_fecha_pg_int  ' + cast (@w_fecha_pg_int  as varchar) 

   /*end                                                                      GAL 14/SEP/2009 - RVVUNICA
   else
   begin
      ------------------------------
      -- 04/04/2000 Fecha Comercial
      ------------------------------
      exec sp_estima_int_com
         @i_fecha_inicio    = @w_fecha_valor,
         @s_ofi             = @s_ofi,
         @s_date            = @s_date,
         @i_fecha_final     = @w_fecha_ven1,
         @i_monto           = @w_monto_act,
         @i_tasa            = @w_tasa,
         @i_tcapitalizacion = @w_tcapitalizacion,
         @i_fpago           = @w_fpago,
         @i_ppago           = @w_ppago,
         @i_dias_anio       = @w_base_calculo,
         @i_dia_pago        = @w_dia_pago,
         @i_batch           = 1,
         @i_retienimp       = @w_retienimp,  -- 15-may-98 capitalizacion
         @i_moneda          = @w_moneda, --15-may-98 capitalizacion
         @i_num_dias        = @w_num_dias, --12/ene/99 fechas comerciales
         @o_fecha_prox_pg   = @w_fecha_pg_int out,
         @o_int_pg_pp       = @w_int_estimado out,
         @o_int_pg_ve       = @w_total_int_estimado out
   end
   */

   select @w_monto_act = round(@w_monto_act, @w_numdeci)
   select @w_int_estimado = round(@w_int_estimado, @w_numdeci)
   select @w_total_int_estimado = round(@w_total_int_estimado, @w_numdeci)

   update pf_historia
   set hi_valor = @w_monto_act
   where hi_operacion  = @i_operacionpf 
   and   hi_secuencial = @i_historia

   /*CCruz*/
   if exists(select 1
             from pf_operacion_renov
             where or_operacion = @i_operacionpf
             and   or_estado    = 'REN')
   begin
      update pf_operacion_renov
      set or_estado = 'ANU'
      where or_operacion = @w_operacionpf
      and   or_estado    = 'REN'

     --CVA Jun-30-06
      update pf_rubro_op_renov
      set ror_estado = 'ANU'
      where ror_operacion = @w_operacionpf
      and   ror_estado    = 'REN'
       
   end

   -------------------------------------------------------
   -- Insercion de la operacion producto de la renovacion
   -------------------------------------------------------
   insert into pf_operacion_renov
           (or_num_banco             , or_operacion             , or_ente                  ,
            or_toperacion            , or_categoria             , or_producto              , or_oficina,
            or_moneda                , or_num_dias              , or_monto                 , or_monto_pg_int,
            or_monto_pgdo            , or_monto_blq             , or_tasa                  , or_int_ganado,
            or_int_estimado          , or_int_pagados           , or_int_provision         ,
            or_total_int_ganados     , or_total_int_pagados     , or_incremento            ,
            or_total_int_estimado    , or_ppago,or_dia_pago     , or_historia              ,
            or_duplicados            , or_renovaciones          , or_estado                , or_pignorado,
            or_oficial               , or_descripcion           , or_fecha_valor           , or_fecha_ven,
            or_fecha_pg_int          , or_fecha_ult_pg_int      , or_fecha_crea            ,
            or_fecha_mod             , or_fecha_ingreso         , or_totalizado            , or_fecha_total,
            or_tipo_plazo            , or_tipo_monto            , or_causa_mod             , or_retenido,
            or_total_retencion       , or_retienimp             , or_tasa_efectiva         , or_accion_sgte,
            or_mon_sgte              , or_tcapitalizacion       , or_fpago                 , or_base_calculo,
            or_casilla               , or_direccion             , or_residuo               , or_total_int_retenido,
            or_renova_todo           , or_imprime               , or_puntos                , or_total_int_acumulado,
            or_tasa_mer              , or_moneda_pg             , or_telefono              , or_impuesto,
            or_retiene_imp_capital   , or_impuesto_capital      , or_ley                   , or_fecha_real,
            or_ult_fecha_cal_tasa    , or_prorroga_aut          , or_num_dias_gracia       , or_estatus_prorroga,
            or_num_prorroga          , or_tasa_variable         , or_mnemonico_tasa        , or_modalidad_tasa,
            or_periodo_tasa          , or_descr_tasa            , or_operador              , or_spread,
            or_anio_comercial        , or_flag_tasaefec         , or_renovada              , or_estado_renov,
            or_oficial_principal     , or_ult_fecha_calculo     , or_fecha_cancela         , or_plazo_ant,
            or_fecven_ant            , or_tot_int_est_ant       , or_fecha_ord_act         , or_int_prov_vencida,
            or_int_total_prov_vencida, or_plazo_orig            , or_tipo_tasa_var         , or_ult_fecha_calven,
            or_sec_incre             , or_fecha_ult_renov       , or_sucursal              , or_incremento_suspenso,
            or_oficial_secundario    , or_captador              , or_bloqueo_legal         , or_monto_blqlegal,
            or_dias_reales           , or_inactivo              , or_localizado            , or_fecha_localizacion,
            or_fecha_no_localiza     , or_origen_fondos         , or_proposito_cuenta      , or_ced_ruc,
            or_aprobado              , or_producto_bancario1    , or_producto_bancario2    , or_oficina_apertura,   --LIM 12/NOV/2005
            or_oficial_apertura      , or_toperacion_apertura   , or_tipo_plazo_apertura   , or_tipo_monto_apertura) --LIM 15/NOV/2005                               --LIM 12/NOV/2005
   select   op_num_banco             , op_operacion             , op_ente,
            op_toperacion            , op_categoria             , op_producto              , op_oficina,
            op_moneda                , op_num_dias              , op_monto                 , op_monto_pg_int,
            op_monto_pgdo            , op_monto_blq             , op_tasa                  , op_int_ganado,
            op_int_estimado          , op_int_pagados           , op_int_provision         ,
            op_total_int_ganados     , op_total_int_pagados     , op_incremento            ,
            op_total_int_estimado    , op_ppago,op_dia_pago     , op_historia              ,
            op_duplicados            , op_renovaciones          , 'REN'                    , op_pignorado,
            op_oficial               , op_descripcion           , op_fecha_valor           , op_fecha_ven,
            op_fecha_pg_int          , op_fecha_ult_pg_int      , op_fecha_crea            ,
            op_fecha_mod             , op_fecha_ingreso         , op_totalizado            , op_fecha_total,
            op_tipo_plazo            , op_tipo_monto            , op_causa_mod             , op_retenido,
            op_total_retencion       , op_retienimp             , op_tasa_efectiva         , op_accion_sgte,
            op_mon_sgte              , op_tcapitalizacion       , op_fpago                 , op_base_calculo,
            op_casilla               , op_direccion             , op_residuo               , op_total_int_retenido,
            op_renova_todo           , op_imprime               , op_puntos                , op_total_int_acumulado,
            op_tasa_mer              , op_moneda_pg             , op_telefono              , op_impuesto,
            op_retiene_imp_capital   , op_impuesto_capital      , op_ley                   , op_fecha_real,
            op_ult_fecha_cal_tasa    , op_prorroga_aut          , op_num_dias_gracia       , op_estatus_prorroga,
            op_num_prorroga          , op_tasa_variable         , op_mnemonico_tasa        , op_modalidad_tasa,
            op_periodo_tasa          , op_descr_tasa            , op_operador              , op_spread,
            op_anio_comercial        , op_flag_tasaefec         , op_renovada              , @i_estado_ant,
            op_oficial_principal     , op_ult_fecha_calculo     , op_fecha_cancela         , op_plazo_ant,
            op_fecven_ant            , op_tot_int_est_ant       , op_fecha_ord_act         , op_int_prov_vencida,
            op_int_total_prov_vencida, op_plazo_orig            , op_tipo_tasa_var         , op_ult_fecha_calven,
            op_sec_incre             , @s_date                  , op_sucursal              , op_incremento_suspenso,
            op_oficial_secundario    , op_captador              , op_bloqueo_legal         , op_monto_blqlegal,
            op_dias_reales           , op_inactivo              , op_localizado            , op_fecha_localizacion,
            op_fecha_no_localiza     , op_origen_fondos         , op_proposito_cuenta      , op_ced_ruc,
            op_aprobado              , op_producto_bancario1    , op_producto_bancario2    , op_oficina_apertura,   --LIM 12/NOV/2005
            op_oficial_apertura      , op_toperacion_apertura   , op_tipo_plazo_apertura   , op_tipo_monto_apertura --LIM 15/NOV/2005
   from pf_operacion
   where op_operacion = @i_operacionpf
   
   if @@error <> 0
   begin
   ---------------------------------------------------------------------
   -- Cheque si se grabaron los datos sobre la tabla pf_operacion_renov
   ---------------------------------------------------------------------
      select isnull(@i_operacionpf,0)
      select @w_error = 143001
      goto ERROR
   end

   --CVA Jun-30-06 Inserte el antes para escalonados
   if charindex('C',@w_tipo_plazo) > 0 
   begin
      insert into pf_rubro_op_renov(
         ror_num_banco,     ror_operacion,       ror_toperacion,     ror_moneda,
         ror_tipo_monto,    ror_tipo_plazo,      ror_concepto,       ror_mnemonico_tasa,
         ror_operador,      ror_modalidad_tasa,  ror_periodo_tasa,   ror_descr_tasa,
         ror_spread,        ror_valor,           ror_estado)
      select   
         ro_num_banco,      ro_operacion,        ro_toperacion,      ro_moneda,
         ro_tipo_monto,     ro_tipo_plazo,       ro_concepto,        ro_mnemonico_tasa,
         ro_operador,       ro_modalidad_tasa,   ro_periodo_tasa,    ro_descr_tasa,
         ro_spread,         ro_valor,            'REN' 
      from pf_rubro_op
      where ro_operacion = @i_operacionpf
      
      if @@error <> 0
      begin
         select isnull(@i_operacionpf,0)
         select @w_error = 143001
         goto ERROR
      end
   end

   ---------------------------------------------
   -- Nuevos calculos para grabar en operacion
   ---------------------------------------------
   select @w_int_renovar      = @w_total_int_estimado - @w_total_int_pagado,
          @w_total_int_pagado = @w_total_int_ganado

   if @w_estado = 'ACT'
      select @w_normal='S',
         @w_causa_mod='TVEN'
   if @w_estado = 'VEN'
      select @w_normal='N',
         @w_causa_mod='VEN'

   -------------------
   -- Calculos
   -------------------
   if @w_tasa=0 and @w_renova_todo ='S'
      select @w_int_renovar=@w_total_int_acumulado + @w_int_ganado,
         @w_total_int_acumulado=@w_int_renovar

   select @w_int_renovar = round(@w_int_renovar,@w_numdeci)

   -------------------------------------------------------------------------------------------------------
   -- Borrado de la operacion e Insercion de la nueva operacion renovada con el mismo codigo de operacion
   -------------------------------------------------------------------------------------------------------
   --select @w_historia = @w_historia + 1
   delete pf_operacion where op_operacion = @i_operacionpf

   --CVA Oct-15-05 Si en la pf_renovacion dice S entonces en la instruccion o ejecucion se cambio
   --              la capitalizacion a SI.
   if @w_renova_todo = 'S'
      select @w_tcapitalizacion = 'S'
   else
      select @w_tcapitalizacion = 'N'


if @t_debug = 'S' print '11 @w_int_estimado  ' + cast (@w_int_estimado  as varchar)
if @t_debug = 'S' print '11 @w_total_int_estimado  ' + cast (@w_total_int_estimado  as varchar)


   --CVA Oct-15-05
   insert pf_operacion ( op_num_banco          ,    op_operacion              , op_ente              , op_toperacion,
                         op_categoria          ,    op_producto               , op_oficina           , op_moneda    ,
                         op_num_dias           ,    op_monto                  , op_monto_pg_int      , op_monto_pgdo,
                         op_monto_blq          ,    op_tasa                   , op_int_ganado        , op_int_estimado,
                         op_int_pagados        ,    op_int_provision          , op_total_int_ganados , op_total_int_pagados,
                         op_incremento         ,    op_total_int_estimado     , op_ppago             , op_dia_pago         ,
                         op_historia           ,    op_duplicados             , op_renovaciones      , op_estado           ,
                         op_pignorado          ,    op_oficial                , op_descripcion       , op_fecha_valor      ,
                         op_fecha_ven          ,    op_fecha_pg_int           , op_fecha_ult_pg_int  , op_fecha_crea       ,
                         op_fecha_mod          ,    op_fecha_ingreso          , op_totalizado        , op_fecha_total      ,
                         op_tipo_plazo         ,    op_tipo_monto             , op_causa_mod         , op_retenido         ,
                         op_total_retencion    ,    op_retienimp              , op_tasa_efectiva     , op_accion_sgte,
                         op_mon_sgte           ,    op_tcapitalizacion        , op_fpago             , op_base_calculo,
                         op_casilla            ,    op_direccion              , op_residuo           , op_total_int_retenido,
                         op_renova_todo        ,    op_imprime                , op_puntos            , op_total_int_acumulado,
                         op_tasa_mer           ,    op_moneda_pg              , op_telefono          , op_impuesto,
                         op_retiene_imp_capital,    op_impuesto_capital       , op_ley               , op_fecha_real,
                         op_ult_fecha_cal_tasa ,    op_prorroga_aut           , op_num_dias_gracia   , op_estatus_prorroga,
                         op_num_prorroga       ,    op_tasa_variable          , op_mnemonico_tasa    , op_modalidad_tasa,
                         op_periodo_tasa       ,    op_descr_tasa             , op_operador          , op_spread,
                         op_anio_comercial     ,    op_flag_tasaefec          , op_renovada          , op_oficial_principal,
                         op_plazo_orig         ,    op_tipo_tasa_var          , op_sec_incre         , op_fecha_ult_renov,
                         op_ente_corresp       ,    op_dias_reales            , op_aprobado,
                         op_camb_oper          ,    op_incremento_suspenso    , op_oficial_secundario, op_captador,
                         op_sucursal           ,    op_bloqueo_legal          , op_monto_blqlegal    , op_origen_fondos,                  
                         op_proposito_cuenta   ,    op_oficina_apertura       , op_oficial_apertura  , op_toperacion_apertura,   --LIM 11/NOV/2005
                         op_tipo_plazo_apertura,    op_tipo_monto_apertura    , op_localizado        , op_fecha_localizacion,
                         op_fecha_no_localiza  ,    op_inactivo               , op_desmaterializa,     op_plazo_ant)       --MVG 24/09/2009
                values ( @i_cuenta             ,    @i_operacionpf            , @w_ente               , @w_toperacion,                         
                         @w_categoria          ,    14                        , @w_oficina            , @w_moneda,    --LIM 11/NOV/2005
                         @w_num_dias           ,    @w_monto_act              , @w_monto_act          , @w_op_monto_pgdo,
                         @w_op_monto_blq       ,    @w_tasa                   , 0                     , @w_int_estimado,
                         0                     ,    0                         , 0                     , 0,
                         0                     ,    @w_total_int_estimado     , @w_ppago              , @w_dia_pago, --GAR GB-DP00120 Dia Pago
                         @w_historia           ,    99                        , @w_op_renovaciones    , 'ING',
                         @w_op_pignorado       ,    @s_user                   , @i_descripcion        , @w_fecha_valor,
                         @w_fecha_ven          ,    @w_fecha_pg_int           , @w_fecha_valor        , @w_fecha_crea,
                         @s_date               ,    @w_fecha_ingreso          , 'N'                   , @w_fecha_real_pg,
                         @w_tipo_plazo         ,    @w_tipo_monto             , 'ING'                 , @w_op_retenido,
                         0                     ,    @w_retienimp              , @w_tasa_efectiva      , 'NULL',
                         (@w_p_mon_sgte +1)    ,    @w_tcapitalizacion        , @w_fpago              , @w_base_calculo,
                         @w_casilla_renov      ,    @w_direccion_renov        , 0                     , 0,
                         @w_renova_todo        ,    'N'                       , @i_puntos             , round(@w_total_int_acumulado, @w_numdeci),
                         @w_tasa_mer           ,    @w_moneda_pg              , @w_telefono           , @w_tasa1,
                         @i_retiene_imp_capital,    @i_impuesto_capital       , @i_ley                , getdate(),
                         @i_fecha_cal_tasa     ,    @w_prorroga_aut           , @w_num_dias_gracia    , 'N',
                         @w_op_num_prorroga    ,    @i_tasa_variable          , @i_mnemonico_tasa     , @i_modalidad_tasa, -- Prorroga Automatica
                         @i_periodo_tasa       ,    @i_descr_tasa             , @w_operador_fijo      , @w_spread_fijo,
                         @w_anio_comercial        ,    @w_flag_tasaefec          , 'S'                   , @w_oficial_pri,
                         @w_plazo_orig         ,    @w_op_tipo_tasa_var       , @w_op_sec_incre       , @s_date,
                         @w_ente_corresp       ,    @w_td_dias_reales         , 'S',                  
                         @w_camb_oper          ,    @w_incremento_suspenso_act, @w_oficial_sec        , @w_captador,
                         @w_sucursal_renov     ,    @w_op_bloqueo_legal       , @w_op_monto_blqlegal  , @w_op_origen_fondos,                
                         @w_op_proposito_cuenta,    @w_op_oficina_apertura    , @w_op_oficial_apertura, @w_op_toperacion_apertura, --LIM 11/NOV/2005
                         @w_op_tipo_plazo_apertura, @w_op_tipo_monto_apertura , @w_localizado         , @w_fecha_localizado,
                         @w_fecha_no_localiza,      @w_inactivo               , @i_desmaterializar,     @w_op_num_dias)                 
   if @@error <> 0
   begin
      select isnull(@i_operacionpf,0)
      select @w_error = 143001
      goto ERROR
   end


   if @w_tasa <>  @w_op_tasa and @w_op_pignorado = 'S'
   begin
      if exists(select pi_cuenta
                from pf_pignoracion
                where pi_operacion = @i_operacionpf
                and   pi_producto  = 'GAR'         )
      begin
         insert pf_cambio_tasa (
            ct_operacion,    ct_fecha_crea,   ct_num_banco,
            ct_tasa_ant,     ct_tasa_act,     ct_estado,
            ct_login)
         values (
            @i_operacionpf,  @s_date,         @i_cuenta,
            @w_op_tasa ,     @w_tasa,         'I' ,
            @s_user) 
            
         select @w_error =  @@error
         if @w_error <> 0
         begin
            select @w_mensaje = 'Error almacenar cambio tasa'
            goto ERROR
         end
      end
   end

   ----------------------------------------------------------
   --CVA Jun-30-06 Registro de pf_rubro_op
   -----------------------------------------------------------
   --CVA Jun-30-06 para escalonados
   if charindex('C',@w_tipo_plazo) > 0 
   begin
      delete from pf_rubro_op where ro_operacion = @i_operacionpf

      --Cargue en definitiva pf_rubro_op lo registrado en pf_rubro_op_tmp
      exec @w_return = sp_rubro_op_tmp
      @s_ssn      = @s_ssn,
      @s_user         = @s_user,  
      @s_sesn         = @s_ssn,
      @s_term         = @s_term, 
      @s_date         = @s_date,
      @s_srv          = @s_srv,
      @s_lsrv         = @s_lsrv,
      @s_ofi          = @s_ofi,
      @s_rol          = @s_rol,
      @t_debug        = @t_debug,
      @t_file         = @t_file,
      @t_from         = @t_from,
      @t_trn          = 14469,
      @i_operacion    = 'I',
      @i_op_operacion = @i_operacionpf
      
      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end   
   end

   select @w_num_oficial = fu_funcionario
   from cobis..cl_funcionario
   where fu_login = @w_funcionario

   --------------------------------------------------------------------
   -- Obtencion de detalle del producto si existiese registro
   --------------------------------------------------------------------
   select @w_siguiente = dp_det_producto
   from cobis..cl_det_producto
   where dp_cuenta = @i_cuenta  
   if @@rowcount = 0
   begin
      --------------------------------------------------------------------
      -- Generacion de un nuevo secuencial para tabla detalle de producto
      --------------------------------------------------------------------
      exec cobis..sp_cseqnos 
         @t_debug     = @t_debug,
         @t_file      = @t_file,
         @t_from      = @w_sp_name,
         @i_tabla     = 'cl_det_producto',
         @o_siguiente = @w_siguiente out

      -----------------------------------------------
      -- Creacion de registro de detalle de producto
      -----------------------------------------------
      insert into cobis..cl_det_producto(
         dp_det_producto,  dp_filial,                  dp_oficina,
         dp_producto,      dp_tipo,                    dp_moneda,
         dp_fecha,         dp_comentario,              dp_monto,
         dp_tiempo,        dp_cuenta,                  dp_estado_ser,
         dp_autorizante,   dp_oficial_cta)
      values (
         @w_siguiente,     1,                          @s_ofi,
         14,               'R',                        @w_moneda,
         @s_date,          'RENOVACION DE OPERACION',  @w_monto_act,
         1,                @i_cuenta,                  'V',
         @w_num_oficial,   @w_num_oficial)
         
      if @@rowcount <> 1
      begin
         select @w_error= 703027
         goto ERROR
      end
   end
 
   if @w_incremento < 0
      select @w_monto_renovar= @w_monto_renovar + @w_incremento

   select @w_monto_renovar = round(@w_monto_renovar, @w_numdeci)

   ---------------------------------------------------------------------------
   -- Calculo del impuesto del 1% sobre lo que se va a renovar
   ---------------------------------------------------------------------------
   if @w_renova_todo = 'S'
      select @w_monto_inicial = @w_monto_anterior + @w_tot_int - @w_impuesto
   else
      select @w_monto_inicial = @w_monto_anterior - @w_impuesto

   ----------------------------------------------------------------------------------------------------
   -- Si el valor es en moneda nacional, el valor en moneda extranjera es multiplicado
   -- por la cotizacion.
   ----------------------------------------------------------------------------------------------------
   if @w_moneda <> 0
   begin
      set rowcount 1
      select @w_cotizacion_compra_billete =co_compra_billete ,
             @w_cotizacion_venta_billete = co_venta_billete,
             @w_cotizacion_conta = co_conta
      from cob_pfijo..pf_cotizacion
      where co_moneda = @w_moneda
      order by co_fecha desc
      select @w_cotizacion = @w_cotizacion_conta  --Utiliza cotiz.contable
      set rowcount 0

      select @w_mm_valor_me = @w_monto_renovar
      select @w_mm_valor = round(@w_mm_valor_me * @w_cotizacion, @w_numdeci)
      if @i_retiene_imp_capital = 'S'
         select @w_mm_impuesto_capital_me = @w_monto_inicial -  @w_mm_valor_me,
                @w_mm_impuesto_capital = 0
   end
   else
   begin
      select @w_mm_valor = @w_monto_renovar,
             @w_mm_valor_me = 0
      if @i_retiene_imp_capital = 'S'
         select @w_mm_impuesto_capital = @w_monto_inicial - @w_mm_valor,
                @w_mm_impuesto_capital_me = 0
   end

   /*****CCR se actualizan los beneficiarios anteriores****/
   set rowcount 0
   
   if exists(select 1 from pf_beneficiario where be_operacion = @w_operacionpf
             and be_estado_xren   = 'S' and be_estado  = 'I')
   begin
      update   cob_pfijo..pf_beneficiario
      set be_estado_xren = 'A',
          be_estado   = 'E'
      where be_operacion   = @w_operacionpf
      and   be_estado_xren = 'N'
      and   be_estado      = 'I'
      
      if @@error <> 0
      begin
         select @w_error = 147009
         goto ERROR
      end 

      -----------------------------------------------------------
           -- Eliminar la relacion de los clientes para luego insertar
           -- los nuevos o mismo clientes de la renovacion
      -----------------------------------------------------------
      delete from cobis..cl_cliente
      where  cl_det_producto = @w_siguiente
      
      if @@error <> 0
      begin    
         select @w_error = 703028
         goto ERROR
      end 
   end
   /*****FIN CCR se actualizan los beneficiarios anteriores****/

   select @w_bt_ente = 0
   while 1 = 1
   begin
      set rowcount 1
      select @w_bt_ente        = be_ente,
             @w_bt_rol         = be_rol,
             @w_bt_tipo        = be_tipo
      from pf_beneficiario
      where be_ente        > @w_bt_ente
      and   be_operacion   = @w_operacionpf
      and   be_estado_xren = 'S'
      order by be_ente
      
      if @@rowcount = 0
         break

      select @w_bloqueado = 'N'
      select @w_malaref = 'N'


      if @w_bt_tipo <> 'F' and 
         exists(	select  1 
		  	from 	cobis..cl_ente,
			        cobis..cl_refinh
			where	in_tipo_ced 	= en_tipo_ced
			and	in_ced_ruc 	= en_ced_ruc
			and	en_ente 	=  @w_bt_ente)
      begin
         select @w_error = 141255
         goto ERROR
      end         

      set rowcount 0

      ----------------------------
      -- Codigo aumentado por CAL
      ----------------------------
      select @w_ced_ruc = en_ced_ruc
      from cobis..cl_ente
      where en_ente = @w_bt_ente

      if @w_bt_tipo = 'T' begin
         insert cobis..cl_cliente (cl_cliente,  cl_det_producto, cl_rol,
                                cl_ced_ruc,  cl_fecha)
                        values (@w_bt_ente,  @w_siguiente,    @w_bt_rol,
                                @w_ced_ruc,  @s_date)
         if @@rowcount  <> 1  begin
            select @w_error = 703028
            goto ERROR
         end
      
         update cobis..cl_ente
         set en_cliente = 'S' 
         where en_ente  = @w_bt_ente
      
         if @@error <> 0 begin
            select @w_error = 703028
            goto ERROR                         
         end
      end

      update pf_beneficiario
      set be_estado_xren = 'N'
       where be_operacion   = @w_operacionpf
      and   be_ente        = @w_bt_ente
      and   be_estado_xren = 'S'
      
      if @@error <> 0
      begin
         select @w_error = 147009
         goto ERROR
      end
   end /* while 1 */

   /****************************************
   CCR actualizacion de instrucci¢n especial
   ****************************************/
   set rowcount 0
   if exists   (select 1 from pf_instruccion
                where isnull(in_estadoxren, 'N') = 'S'
                and   in_operacion         = @w_operacionpf
                )
   begin
      update pf_instruccion
      set in_estadoxren  = 'E',
          in_fecha_mod   = @s_date
      where in_estadoxren  = 'N'
      and   in_operacion   = @w_operacionpf
      if @@error <> 0
      begin
         select @w_error = 145056
         goto ERROR
      end
      
      update pf_instruccion
      set in_estadoxren  = 'N',
          in_fecha_mod   = @s_date
      where in_estadoxren  = 'S'
      and   in_operacion   = @w_operacionpf
      if @@error <> 0
      begin
         select @w_error = 145056
         goto ERROR
      end
   end

   /***CCR FIN INSTR. ESP.*****************/

   select @w_sec1 = isnull(max(dp_secuencia),0)+1
   from pf_det_pago
   where dp_operacion = @i_operacionpf

   /*******************************************************
   CCR Actualizacion de registros de pf_det_pago 
   ********************************************************/
   if @w_tcapitalizacion = 'S'
   begin
      update pf_det_pago
      set dp_estado = 'E'
                     where dp_operacion = @i_operacionpf
      if @@error <> 0
      begin
         select @w_error = 145037
         goto ERROR
      end
   end --@w_tcapitalizacion ='S'
   else--@w_tcapitalizacion <>'S'
   begin
      if exists(select 1 from pf_det_pago where dp_operacion = @i_operacionpf
                and dp_estado_xren = 'S' and dp_estado = 'I')
      begin
         update   pf_det_pago
         set   dp_estado   = 'E'
         where dp_operacion    = @i_operacionpf
         and   dp_estado_xren  = 'N'
         and   dp_estado       = 'I'
         if @@error <> 0
         begin
            select @w_error = 145037
            goto ERROR
         end
         
         update   pf_det_pago
         set dp_estado_xren = 'N',
             dp_estado   = 'I'
         where dp_estado_xren = 'S'
         and   dp_estado      = 'I'
         and   dp_operacion   = @i_operacionpf
         if @@error <> 0
         begin
            select @w_error = 145037
            goto ERROR
         end
      end
   end--@w_tcapitalizacion <> 'S'
      
   /****************************************************************
   CCR se actualiza pf_det_pago en caso de cambio de tasa o falla en
   incremento/disminucion
   ****************************************************************/
   if @w_tcapitalizacion <> 'S'
   begin
      select @w_sum_det_pago = 0
      
      select @w_sum_det_pago = sum(dp_monto)
      from  pf_det_pago
      where dp_operacion   = @w_operacionpf
      and   dp_estado_xren = 'N'
      and   dp_estado      = 'I'
      
      if @w_int_estimado <> isnull(@w_sum_det_pago, @w_int_estimado)
      begin
         update   pf_det_pago
         set   dp_monto = round((@w_int_estimado * dp_porcentaje) /100 , @w_numdeci)
         where dp_operacion   = @w_operacionpf
         and   dp_estado_xren = 'N'
         and   dp_estado   = 'I'
         
         if @@error <> 0
         begin
            select @w_error = 145037
            goto ERROR
         end
         
         select @w_sum_det_pago = 0
         
         select @w_sum_det_pago  = sum(dp_monto)
         from  pf_det_pago
         where dp_operacion   = @w_operacionpf
         and   dp_estado_xren = 'N'
         and   dp_estado   = 'I'
         
         select @w_monto_ajuste = 0
         
         if @w_int_estimado <> isnull(@w_sum_det_pago, @w_int_estimado)
         begin
            select @w_monto_ajuste  = round(@w_int_estimado - @w_sum_det_pago, @w_numdeci)
            
            update pf_det_pago
            set   dp_monto = dp_monto + @w_monto_ajuste
            where dp_operacion   = @w_operacionpf
            and   dp_estado_xren = 'N'
            and   dp_estado   = 'I'
            and   dp_secuencia   = (select max(dp_secuencia) from pf_det_pago
                                    where dp_operacion   = @w_operacionpf
                                    and   dp_estado_xren = 'N'
                                    and   dp_estado      = 'I')
            if @@error <> 0
            begin
               select @w_error = 145037
               goto ERROR
            end
         end
      end --@w_int_estimado <> isnull(@w_sum_det_pago, @w_int_estimado)
   end --@w_tcapitalizacion <> 'S'
   /*******FIN CCR actualizacion pf_det_pago***********************/

   /*******************
   FIN CCR
   *******************/

   select @w_pt_sec=0

   -------------------------------------------------
   -- Actualizacion de pf_renovacion
   -------------------------------------------------
   update pf_renovacion
      set re_operacion_new = @w_operacionpf,
          re_fecha_mod  = @w_fecha_hoy,
          re_estado_ant    = @i_estado_ant,
          re_estado  = 'A'
   where re_operacion = @w_operacionpf
   and   re_estado    = 'I'
   if @@rowcount <> 1
   begin
      select @w_error = 145004
      goto ERROR
   end

   if @w_op_fpago = 'PER'
   begin
      -------------------------------------------------------------
      -- Grabar las cuotas en un archivo historico para el reverso
      -------------------------------------------------------------
      insert into cob_pfijo..pf_cuotas_his(
             ch_ente          , ch_operacion , ch_cuota   , ch_fecha_pago,
             ch_valor_cuota   , ch_retencion , ch_capital , ch_fecha_crea,
             ch_moneda        , ch_oficina   , ch_num_dias, ch_estado,
             ch_fecha_ult_pago, ch_tasa      , ch_ppago   , ch_base_calculo,
             ch_fecha_grab    , ch_valor_neto, ch_retenido)
      select cu_ente          , cu_operacion , cu_cuota   , cu_fecha_pago,
             cu_valor_cuota   , cu_retencion , cu_capital , cu_fecha_crea,
             cu_moneda        , cu_oficina   , cu_num_dias, cu_estado,
             cu_fecha_ult_pago, cu_tasa      , cu_ppago   , cu_base_calculo,
             @s_date          , cu_valor_neto, cu_retenido
      from cob_pfijo..pf_cuotas
      where cu_operacion =  @i_operacionpf  

      /* Borrado de registros en la tabla de cuotas */
      delete cob_pfijo..pf_cuotas
      where cu_operacion = @i_operacionpf
   end

   ----------------------------------------------------------------------
   -- Solo se activa automaticamente si fue Instruccion
   ----------------------------------------------------------------------
   select @w_flag_incremento = 0

   --Disminucion en Instrucciones
   if @w_emite_orden = 'S'
      select @w_incremento_monet = @w_incremento_monet * -1                 


if @t_debug = 'S' print '11 @i_estado_ant  ' + cast (@i_estado_ant  as varchar)
if @t_debug = 'S' print '11 @w_flag_incremento  ' + cast (@w_flag_incremento  as varchar)

   ---------------------------------------------------------------------------------------
   -- Activaci¢n del DPF renovado
   ---------------------------------------------------------------------------------------
   if (@i_estado_ant = 'ACT' or @i_estado_ant = 'VEN') and @w_flag_incremento = 0
   begin
     --print 'renoact.sp va sp_activa_deposito'     
      exec @w_return = sp_activa_deposito
         @s_ssn           = @s_ssn,
         @s_user          = @s_user,
         @s_sesn          = @s_sesn,
         @s_ofi           = @s_ofi,
         @s_date          = @s_date,
         @t_trn           = 14914,
         @s_srv           = @s_srv,
         @s_term          = @s_term,
         @t_file          = @t_file,
         @t_from          = @w_sp_name,
         @t_debug         = @t_debug,
         @i_num_banco     = @i_cuenta,
         @i_operacion     = 'R',
         @i_observacion   = @i_descripcion,
         @i_operacion_ant = @w_operacionpf,
         @i_secuencia_ant = @w_secuencia_aplm, --CVA Mar-03-06 aplica para instrucciones
         @i_normal        = 'S',
         @i_impuesto      = @w_impuesto,
         @i_tot_int       = @w_tot_int,
         @i_en_linea      = @i_en_linea,
         @i_incremento    = @w_incremento_monet  --CVA Mar-3-06
         
      if @w_return <> 0
      begin
         select @w_error = @w_return   
         goto ERROR
      end    
   end

   --------------------------------------------
   -- Generar archivo de cuotas
   --------------------------------------------
   if @w_fpago = 'PER'
   begin
        --print 'renoact.sp va sp_cuotas'
      /* Generacion de nuevo archivo de cuotas por operacion */
      exec @w_return= sp_cuotas
         @s_ssn                 = @s_ssn,
         @s_user                = @s_user,
         @s_sesn                = @s_sesn,
         @s_ofi                 = @s_ofi,
         @s_date                = @s_date,
         @t_trn                 = 14146,
         @s_srv                 = @s_srv,
         @s_term                = @s_term,
         @t_file                = @t_file,
         @t_from                = @w_sp_name,
         @t_debug               = @t_debug,
         @i_op_ente             = @w_ente,
         @i_op_operacion        = @i_operacionpf,
         @i_op_fecha_valor      = @w_fecha_valor,
         @i_op_fecha_ven        = @w_fecha_ven,
         @i_op_monto            = @w_monto_act,
         @i_op_tasa             = @w_tasa,
         @i_op_num_dias         = @w_num_dias,
         @i_op_ppago            = @w_ppago,
         @i_op_retienimp        = @w_retienimp, 
         @i_op_moneda           = @w_moneda,
         @i_op_oficina          = @s_ofi,
         @i_op_tcapitalizacion  = @w_tcapitalizacion,
         @i_op_fpago            = @w_fpago,
         @i_op_base_calculo     = @w_base_calculo,
         @i_op_anio_comercial   = @w_dias_reales,
         @i_modifica            = @w_modifica
   
      if @w_return <> 0
      begin
         select @w_error = @w_return   
         goto ERROR
      end
   
   end
   
   --CVA Jun-30-06 que se borre lo insertado por instruccion
   delete pf_rubro_op_i where roi_operacion  = @w_operacionpf

if @t_debug = 'S' print '11 @w_dias_reales  ' + cast (@w_dias_reales  as varchar)



return 0

------------------------------
-- Manejo de mensaje de error
------------------------------
ERROR:

--   rollback tran  

   if @i_en_linea = 'N'
   begin
      set rowcount 0

      update pf_renovacion
      set re_estado = 'X' 
      where re_operacion= @w_operacionpf
      
      delete pf_rubro_op_i where roi_operacion  = @w_operacionpf

      delete pf_rubro_op_tmp where rot_operacion = @w_operacionpf

      update pf_operacion
      set op_accion_sgte = 'NULL',
          op_causa_mod   = 'NULL'
      where op_operacion = @w_operacionpf

      exec sp_errorlog 
         @i_fecha   = @s_date,
         @i_error   = @w_error,
         @i_usuario = @s_user,
         @i_tran    = @t_trn,
         @i_cuenta  = @i_cuenta
   end
   else
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = @w_error
   end

   return @w_error
go
