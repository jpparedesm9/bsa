/*sp_modificacion_deposito*/
/************************************************************************/
/*      Archivo:                a_modope.sp                             */
/*      Stored procedure:       sp_modificacion_deposito                */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           N. Silva                                */
/*      Fecha de documentacion: 14-Abr-2005                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa realiza todos los calculos necesarios y actualiza */
/*      todos los campos de la operacion de acuerdo a lo solicitado por */
/*      el operativo.                                                   */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA        AUTOR              RAZON                           */
/*      14-Abr-2005  N. Silva           Emision Inicial                 */
/*      03-Ago-2006  R. Ramos           Adicionar campo de fideicomiso  */
/*      05/Dic/2016  A. Zuluaga         Desacople                       */
/************************************************************************/
use cob_pfijo
go
if object_id('sp_modificacion_deposito') IS   NOT NULL
drop proc sp_modificacion_deposito
go
create proc sp_modificacion_deposito (
@s_ssn                  int             = NULL,
@s_org                  char(1)         = NULL,
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
@i_cuenta_ant           cuenta,
@i_fecha_valor          datetime,
@i_fecha_camb           datetime,
@i_tasa                 float           = NULL,
@i_tasa_efectiva        float           = NULL,
@i_plazo                int             = NULL,
@i_impuesto             money           = 0,
@i_descripcion          descripcion     = NULL,
@i_retiene_imp_capital  char(1)         = 'N',
@i_plazo_orig           int             = NULL,   -- Plazo original para renovacion automatica
@i_firmas_aut           char(1)         = NULL,   -- gap DP00008 Firmas Autorizadas
@i_toperacion           catalogo        = NULL,   -- Cambio de tipo de operacion GLOBAL
@i_oficina              smallint        = NULL,   -- Cambio de oficina GLOBAL
@i_categoria            catalogo        = NULL,
@i_base_calculo         int             = NULL,
@i_tcapitalizacion      char(1)         = NULL,
@i_fecha_ven            datetime        = NULL,
@i_oficial_princ        login           = NULL,
@i_oficial_sec          login           = NULL,
@i_ente_corresp         int             = NULL, --GAR GB-DP00120
@i_modifico_fp          tinyint         = 0,    --GAR Para validar si cambiaron las formas de pago
@i_dia_pago             int             = NULL,
@i_int_estimado         money           = NULL,
@i_total_int_estimado   money           = NULL,
@i_fecha_pg_int         datetime        = NULL,
@i_localizado           char(1)         = NULL,
@i_instruccion_especial descripcion     = NULL, --CVA Oct-07-05
@i_fecha_localizacion   smalldatetime   = NULL,
@i_fecha_no_localiza    smalldatetime   = NULL,
@i_spread_fijo          float           = 0,
@i_operador_fijo        char(1)         = NULL,
@i_casilla              tinyint         = NULL,
@i_direccion            tinyint         = NULL,
@i_sucursal             smallint        = NULL,
@i_fpago                catalogo        = NULL, --CVA Oct -07-05
@i_ppago                catalogo        = NULL, --CVA Oct -07-05
@i_dias_reales          char(1)         = NULL,
@i_tipo_plazo           catalogo        = NULL,
@i_int_ganado           money           = NULL,
@i_total_int_ganados    money           = NULL,
@i_tasa_base            float           = NULL,
@i_modifica             char(1)         = 'N', --CVA Jun-29-06 para escalonados vendr  en S
@i_fideicomiso          varchar(15)     = NULL,
@i_desmaterializa       char(1)         = NULL
)
as
declare @w_sp_name                      varchar(32),
@w_descripcion                  descripcion,
@o_comprobante                  int,
@w_string                       varchar(30),
@w_return                       int,
@w_siguiente                    int,
@w_secuencia                    int,
@w_total_monet                  money,
@w_fecha_no_lab                 datetime,
@w_retienimp                    char(1),
@w_numdeci                      tinyint,
@w_usadeci                      char(1),
@w_sec_ticket                   int,
@w_moneda_base                  tinyint,
@w_contabiliza                  char(1),
@w_toperacion                   catalogo,
@w_toperacion_ant               catalogo,
@w_categoria                    catalogo,
@w_categoria_ant                catalogo,
@w_oficina                      smallint,
@w_plazo_orig                   int,
@w_plazo_orig_ant               int,
@w_plazo                        int,
@w_plazo_ant                    int,
@w_base_calculo                 int,
@w_base_calculo_ant             int,
@w_tcapitalizacion              char(1),
@w_tcapitalizacion_ant          char(1),
@w_ced_ruc                      numero,   --CVA May-13-06
@w_fpago                        catalogo, --CVA Oct-18-05
@w_fpago_ant                    catalogo,
@w_ppago                        catalogo, --CVA Oct-18-05
@w_ppago_ant                    catalogo,
@w_fecha_valor                  datetime,
@w_oficina_ant                  smallint,
@w_interes                      money,
@w_interes_total                money,
@w_fecha_ven                    datetime,
@w_num_dias                     int,
@w_camb_bascalc                 char(1),
@w_camb_datos                   char(1),
@w_fecha_camb                   datetime,
@w_camb_tasa                    char(1),
@w_tasa1                        float,
@w_ajuste                       money,
@w_camb_fecv                    char(1),
@w_ente_corresp                 int, --GAR GB-DP00120
@w_localizado                   char(1),
@w_fecha_localizacion           smalldatetime,
@w_fecha_no_localiza            smalldatetime,
@w_pignorado                    char(1),
@w_pi_cuenta                    cuenta,
@w_pi_spread                    int,
@w_op_spread_fijo               float,
@w_op_operador_fijo             char(1),
@w_spread                       float,
@w_operador                     char(1),
@w_utilizo_spread               char(1),
@w_estado_spread                char(1),
@w_ssn_spread                   int,
@w_desmaterializa_ant           char(1),
/*  Variables para la operacion anterior en Renovacion */
@w_op_fecha_ven                    datetime,
@w_op_operacion                    int,
@w_op_moneda                       tinyint,
@w_op_toperacion                   catalogo,
@w_op_producto                     tinyint,
@w_op_oficina                      smallint,
@w_op_plazo_orig                   int,
@w_op_num_dias                     int,
@w_op_historia                     smallint,
@w_op_renovaciones                 smallint,
@w_op_monto                        money,
@w_op_total_int_estimado           money,
@w_op_total_int_pagados            money,
@w_op_int_pagados                  money,
@w_op_oficial_secundario           login,
@w_inactivo                        char(1),
@w_dia_pago                        int,
@w_dia_pago_ant                    int,
@w_op_tasa                         float,
@w_tasa                            float,
@w_tasa_ant                        float,
@w_op_tasa_efectiva                float,
@w_op_mon_sgte                     smallint,
@w_op_estado                       catalogo,
@w_ch1                             catalogo,
@w_op_accion_sgte                  catalogo,
@w_op_causa_mod                    varchar(60),
@w_op_fecha_valor                  datetime,
@w_op_fecha_pg_int                 datetime,
@w_op_tcapitalizacion              char(1),     -- Capitaliz.
@w_op_fpago                        catalogo,    -- Capitaliz.
@w_op_ppago                        catalogo,    -- Capitaliz.
@w_op_fecha_ult_pg_int             datetime,
@w_op_dias_reales                  char(1),
@w_op_categoria                    catalogo,
@w_op_oficial_principal            login,
@w_op_sec_incre                    int,
@w_op_int_ganado                   money,
@w_op_retienimp                    char(1),
@w_op_tipo_plazo                   catalogo,
@w_op_flag_tasaefec                char(1),
@w_op_ente_corresp                 int, --GAR GB-DP00120
@w_op_dia_pago                     int,
@w_fideicomiso                     varchar(15),
@w_fideicomiso_ant                 varchar(15),
@w_op_fideicomiso                  varchar(15),
@w_op_desmaterializa           char(1),
/* VARIABLES NECESARIAS PARA PF_BENEFICIARIO PF_BENEFICIARIO_TMP */
@w_bt_ente                      int,
@w_bt_rol                       catalogo,
@w_bt_fecha_crea                datetime,
@w_bt_fecha_mod                 datetime,
@w_bt_tipo                      char(1),
@w_bt_condicion                 char(1),
@w_bt_secuencia                 smallint,
@w_titulares                    varchar(100),
@w_titulares_ant                varchar(100),
@w_firmantes                    varchar(100),
@w_firmantes_ant                varchar(100),
@w_be_ente                      int,
@w_be_tipo                      char(1),
@w_be_condicion                 char(1),


/* VARIABLES NECESARIAS PARA PF_MOV_MONET */
@w_mt_sub_secuencia             int,
@w_mt_producto                  catalogo,
@w_mt_cuenta					cuenta,
@w_mt_tipo						char(1),
@w_mt_beneficiario				int,
@w_mt_impuesto					money,
@w_mt_moneda					int,
@w_mt_valor_ext					money,
@w_mt_fecha_crea                datetime,
@w_mt_fecha_mod                 datetime,
@w_mt_valor                     money,
@w_mt_val                       money,
@w_mt_impuesto_capital_me       money,
@w_mt_secuencial                money,
@w_mt_cta_corresp               cuenta,
@w_mt_cod_corresp               catalogo,
@w_mt_benef_corresp             varchar(245),
@w_mt_ofic_corresp              int,
@w_mm_secuencia                 int,
@w_mt_ttransito                 smallint,
/*  Variables para det_cheque_tmp   */
@w_ct_sub_secuencia             smallint,
@w_ct_banco                     catalogo,
@w_ct_cuenta                    cuenta,
@w_ct_cheque                    int,
@w_operacion_tmp                int,
@w_ct_valor                     money,
@w_ct_val                       money,
@w_ct_val_tot                   money,
@w_ct_descripcion               descripcion,
@w_ct_fecha_crea                datetime,
@w_ct_fecha_mod                 datetime,
@w_ct_benef_chq                 descripcion,
/* Variables para det_pago_tmp  */
@w_pt_beneficiario				int,
@w_sec1                         int,
@w_pt_tipo						catalogo,
@w_pt_forma_pago				catalogo,
@w_pt_cuenta					cuenta,
@w_pt_monto						money,
@w_pt_mont                      money,
@w_pt_porcentaje				float,
@w_pt_fecha_crea				datetime,
@w_pt_fecha_mod					datetime,
@w_pt_moneda_pago               smallint,
@w_pt_benef_chq                 varchar(64),
@w_op_ente                      int,
@w_pt_descripcion               varchar(255),   --gap DP00008
@w_pt_oficina                   smallint,    --gap DP00008
@w_pt_tipo_cliente              char(1),        --gap DP00008
@w_pt_tipo_cuenta_ach           char(1),
@w_pt_banco_ach                 descripcion,
@w_pt_cod_banco_ach             smallint,  --LIM 19/NOV/2005
/* Variables para retencion de impuesto */
@w_total_monet_me               money,
@w_op_bloqueo_legal             char(1),
@w_op_monto_pgdo                money,
@w_op_monto_blq                 money,
@w_op_monto_blq_legal           money,
@w_op_monto_int_blq_legal       money,
@w_op_base_calculo              int,
@w_op_prorroga_aut              char(1),
@w_op_tasa_variable             char(1),
@w_op_camb_oper                 int,
@w_op_int_estimado              money,
@w_op_residuo                   money,
@w_op_int_provision             money,
@w_op_total_int_ganados         money,
@w_op_total_int_retenido        money,
@w_op_total_retencion           money,
@w_op_impuesto_capital          money,
@w_op_localizado                char(1),
@w_op_fecha_localizacion        smalldatetime,
@w_op_fecha_no_localiza         smalldatetime,
/* Variables de pf_tipo_deposito */
@w_td_forma_pago                catalogo,
@w_td_capitalizacion            char(1),
@w_td_base_calculo              int,
@w_td_prorroga_aut              char(1),
@w_td_tasa_variable             char(1),
@w_td_tasa_efectiva             char(1),
@w_td_dias_reales               char(1),
@w_td_tipo_persona              catalogo,
@w_fecha_pg_int                 datetime,
@w_interes_act_prox             money,
@w_monto_estim_int              money,
@w_tasa_base                    float,
@w_op_tipo_monto                catalogo,
@w_op_nuevo_tipo_plazo          catalogo,
@w_instruccion_especial         descripcion, --CVa Oct-06-05
@w_op_fecha_ult_pago_int_ant	datetime,
@w_dias_reales_ant              char(1),
@w_dias_reales                  char(1),
@w_tmp_ente						int,
@w_tmp_retienimp				char(1),
@w_fecha_grab					datetime,
@w_int_estimado					money,
@w_total_int_estimado			money,
@w_num_pagos					smallint,
@w_fecha_ven1					datetime,
@w_fecha_valor_aux				datetime,
@w_tasa_spread					float,
@w_valor_cuota					money,
@w_contador						int,
@w_suma_cuotas					money,
@w_diferencia					money,
@w_fecha_valor_ant              datetime,
@w_fecha_valor_act              datetime,
@w_oficial_principal            login,
@w_oficial_secundario           login,
@w_oficial_principal_ant        login,
@w_oficial_secundario_ant       login,
@w_fecha_ven_ant                datetime,
@w_fecha_ven_act                datetime,
@w_fecha_camb_ant               datetime,
@w_tasa_base_ini                float,
@w_ult_fecha_calculo			datetime,
@w_desmaterializa               char(1)


/*----------------------------------*/
/*  Verificar codigo de Transaccion */
/*----------------------------------*/
if   @t_trn <> 14165
begin
   exec cobis..sp_cerror
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_num       = 141112
        return 141112
end

-------------------------------
-- Inicializacion de variables
-------------------------------
select @w_sp_name = 'sp_modificacion_deposito'

CREATE TABLE #det_cus_garantias (            --LIM 01/FEB/2006
       garantia                varchar(64)     NOT NULL,
       tipo                    varchar(64)     NOT NULL,
       tasa                    float               NULL,
       cuenta                  varchar(24)         NULL)


CREATE TABLE #det_oper_relacion (            --LIM 01/FEB/2006
       op_garantia                varchar(64)     NOT NULL,
       op_tramite                 int             NOT NULL,
       op_tipo                    char(1)         NOT NULL,
       op_toperacion              varchar(10)         NULL,
       op_producto                varchar(10)         NULL,
       op_tasa_asoc               char(1)             NULL,
       op_cuenta                  varchar(24)         NULL)

/* ALMACENA LAS DIFERENCIAS DE INTERES EN LOS REAJUSTES */
create table #interes_proyectado (           --LIM 01/FEB/2006
concepto        varchar(10),
valor           money
)
-------------------------------------
-- Encontrar el primer dia laborable
-------------------------------------
exec sp_primer_dia_labor
     @t_debug       = @t_debug,
     @t_file        = @t_file,
     @t_from        = @w_sp_name,
     @i_fecha       = @s_date,
     @s_ofi         = @s_ofi,
     @o_fecha_labor = @w_fecha_no_lab out

---------------
-- Moneda Base
---------------
select @w_moneda_base = em_moneda_base
    from cob_conta..cb_empresa
where em_empresa = 1

select @w_ajuste    =   0, @w_tmp_retienimp = 'N'
select   @w_retienimp = 'N',
   @i_impuesto = 0,
   @w_utilizo_spread = 'N'

------------------------------------
-- Lectura de la tabla pf_operacion
------------------------------------
select @w_op_operacion              = op_operacion,
       @w_op_num_dias               = op_num_dias,
       @w_op_plazo_orig             = op_plazo_orig,
       @w_op_moneda                 = op_moneda,
       @w_op_oficina                = op_oficina,
       @w_op_monto                  = op_monto_pg_int, -- Capitalizacion
       @w_op_producto               = op_producto,
       @w_op_tasa                   = op_tasa,
       @w_op_tasa_efectiva          = op_tasa_efectiva,
       @w_op_historia               = op_historia,
       @w_op_renovaciones           = op_renovaciones,
       @w_op_mon_sgte               = op_mon_sgte,
       @w_op_accion_sgte            = op_accion_sgte,
       @w_op_fecha_ven              = op_fecha_ven,
       @w_op_causa_mod              = op_causa_mod,
       @w_op_total_int_estimado     = op_total_int_estimado,
       @w_op_fecha_ult_pg_int       = op_fecha_ult_pg_int,
       @w_op_fecha_pg_int           = op_fecha_pg_int,
       @w_op_total_int_pagados      = op_total_int_pagados,
       @w_op_int_pagados            = op_int_pagados,
       @w_op_estado                 = op_estado,
       @w_op_tcapitalizacion        = op_tcapitalizacion, -- Capitalizacion
       @w_op_fpago                  = op_fpago,           -- Capitaliz.
       @w_op_ppago                  = op_ppago,           -- CVA Oct-06-05
       @w_op_retienimp              = op_retienimp,       -- PRA
       @w_op_fecha_valor            = op_fecha_valor,
       @w_op_toperacion             = op_toperacion,
       @w_op_bloqueo_legal          = op_bloqueo_legal,
       @w_op_monto_pgdo             = op_monto_pgdo,
       @w_op_monto_blq              = op_monto_blq,
       @w_op_monto_blq_legal        = op_monto_blqlegal,
       @w_op_monto_int_blq_legal    = op_monto_int_blqlegal,
       @w_op_ente                   = op_ente,
       @w_op_base_calculo           = op_base_calculo,
       @w_op_prorroga_aut           = op_prorroga_aut,
       @w_op_tasa_variable          = op_tasa_variable,
       @w_op_camb_oper              = isnull(op_camb_oper,0),
       @w_op_categoria              = op_categoria,
       @w_op_oficial_principal      = op_oficial_principal,
       @w_op_oficial_secundario     = op_oficial_secundario,
       @w_op_sec_incre              = isnull(op_sec_incre,0),
       @w_op_int_estimado           = op_int_estimado,
       @w_op_int_provision          = op_int_provision,
       @w_op_total_int_ganados      = op_total_int_ganados,
       @w_op_total_int_retenido     = op_total_int_retenido,
       @w_op_total_retencion        = op_total_retencion,
       @w_op_impuesto_capital       = op_impuesto_capital,
       @w_op_tipo_plazo             = op_tipo_plazo,
       @w_op_flag_tasaefec          = op_flag_tasaefec,
       @w_op_int_ganado             = op_int_ganado,
       @w_op_residuo                = op_residuo,
       @w_op_ente_corresp           = op_ente_corresp, --GAR GB-DP00120
       @w_op_localizado             = op_localizado,
       @w_op_fecha_localizacion     = op_fecha_localizacion,
       @w_op_fecha_no_localiza      = op_fecha_no_localiza,
       @w_op_tipo_monto             = op_tipo_monto,
       @w_op_fecha_ult_pago_int_ant = op_fecha_ult_pago_int_ant,
       @w_op_dia_pago               = op_dia_pago,
       @w_op_dias_reales            = op_dias_reales,
       @w_inactivo                  = op_inactivo,
       @w_pignorado                 = isnull(op_pignorado,'N'),
       @w_op_spread_fijo            = op_spread,
       @w_op_operador_fijo          = op_operador,
       @w_tasa_base_ini             = op_tasa_mer,
       @w_op_fideicomiso            = op_fideicomiso,
       @w_op_desmaterializa         = op_desmaterializa
from cob_pfijo..pf_operacion
where op_num_banco        = @i_cuenta_ant
and ((op_estado = 'ACT' and (op_accion_sgte is NULL or op_accion_sgte = 'NULL')) or op_estado in ('VEN','XACT'))
if @@rowcount = 0
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141051
   return 141051
end

/*Validacion de que no tenga montos Bloqueados*/

if (isnull(@w_op_monto_pgdo,0) + isnull(@w_op_monto_blq ,0) + isnull(@w_op_monto_blq_legal,0) + isnull(@w_op_monto_int_blq_legal,0)) > 0
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141200
   return 141200
end


set rowcount 1
select   @w_tmp_ente = bt_ente
from  pf_beneficiario_tmp
where bt_usuario  = @s_user
and   bt_sesion   = @s_sesn
and   bt_operacion   = @w_op_operacion
and   bt_rol      = 'T'
and   bt_tipo     = 'T'
order by bt_secuencia
if @@rowcount = 0
begin
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 141005
   return 141005
end

set rowcount 0

--CVA Oct-18-05
select @w_instruccion_especial = in_instruccion
  from pf_instruccion
 where in_operacion = @w_op_operacion
   and isnull(in_estadoxren,'N') = 'N'

select @w_fecha_camb     = @i_fecha_camb
select @w_fecha_camb_ant = @i_fecha_camb
select @w_fecha_valor    = @i_fecha_valor

--La variable S indica que debe actualizar la primera cuota de pf_cuotas
if @i_fecha_valor <> @w_op_fecha_valor
   select @w_camb_datos = 'S'

--------------------------------------------------------------------------------------------------------
-- Controlar que el Tipo de operacion a cambiar tenga las mismas caracteristicas que el de la operacion
--------------------------------------------------------------------------------------------------------
if @i_toperacion <> @w_op_toperacion
begin
   select @w_td_forma_pago     = td_forma_pago,
          @w_td_capitalizacion = td_capitalizacion,
          @w_td_base_calculo   = convert(int,td_base_calculo),
          @w_td_prorroga_aut   = td_prorroga_aut,
          @w_td_tasa_variable  = td_tasa_variable,
          @w_td_tasa_efectiva  = td_tasa_efectiva,
          @w_td_dias_reales    = td_dias_reales
     from cob_pfijo..pf_tipo_deposito
    where td_mnemonico = @i_toperacion
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 149066
      return 149066
   end
   if @w_op_tasa_variable = 'S'  and @w_td_tasa_variable = 'N'
   begin
      exec cobis..sp_cerror
           @t_debug      = @t_debug,
           @t_file       = @t_file,
           @t_from       = @w_sp_name,
           @i_msg        = 'La operacion es Tasa Variable y no puede cambiar el tipo de Deposito a Fija',
           @i_num        = 141199
      return 141199
   end
   if @w_op_tasa_variable = 'N'  and @w_td_tasa_variable = 'S'
   begin
      exec cobis..sp_cerror
           @t_debug      = @t_debug,
           @t_file       = @t_file,
           @t_from       = @w_sp_name,
           @i_msg        = 'La operacion es de Tasa Fija y no puede cambiar el tipo de Deposito a Variable',
           @i_num        = 141199
      return 141199
   end
end

-----------------------------------------------
-- Control si la operacion tiene bloqueo legal
-----------------------------------------------
if (@w_op_bloqueo_legal = 'S' and @i_toperacion <> @w_op_toperacion) or (@w_op_bloqueo_legal = 'S' and @i_oficina <> @w_op_oficina)
begin
   exec cobis..sp_cerror
        @t_debug      = @t_debug,
        @t_file       = @t_file,
        @t_from       = @w_sp_name,
        @i_msg        = 'La operacion tiene Bloqueo Legal, no se permite cambiar Oficina o Tipo de Aplicacion',
        @i_num        = 141200
   return 141200
end

if (@w_op_bloqueo_legal = 'S' and @i_fideicomiso <> @w_op_fideicomiso)
begin
   exec cobis..sp_cerror
        @t_debug      = @t_debug,
        @t_file       = @t_file,
        @t_from       = @w_sp_name,
        @i_msg        = 'La operacion tiene Bloqueo Legal, no se permite cambiar el fideicomiso',
        @i_num        = 141200
   return 141200
end

----------------------------------------------
-- Controles para modificacion de fecha valor
----------------------------------------------
if ((@i_fecha_valor <> @w_op_fecha_valor) and (@w_op_fecha_ult_pg_int > @w_op_fecha_valor))
begin
   exec cobis..sp_cerror
        @t_debug      = @t_debug,
        @t_file       = @t_file,
        @t_from       = @w_sp_name,
        @i_msg        = 'No puede cambiar la fecha valor porque realizo pago de intereses',
        @i_num        = 141201
   return 141201
end

if ((@i_fecha_valor <> @w_op_fecha_valor) and (@w_op_fecha_ult_pago_int_ant > @w_op_fecha_valor))
begin
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_msg      = 'No puede cambiar la fecha valor porque realizo pago de intereses',
      @i_num      = 141205
   return 141205
end

if ((@i_fecha_valor <> @w_op_fecha_valor) and @w_op_estado = 'VEN')
begin
   --No puede cambiar la fecha valor el deposito esta vencido
   exec cobis..sp_cerror
        @t_debug      = @t_debug,
        @t_file       = @t_file,
        @t_from       = @w_sp_name,
        @i_num        = 141202
   return 141202
end

if (@i_fecha_valor <> @w_op_fecha_valor)
begin
   if @w_op_int_pagados > 0 or @w_op_total_int_pagados > 0
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_msg   = 'No puede cambiar la fecha valor porque operacion ya tiene intereses pagados',
         @i_num   = 141206
      return  141206
   end
end

--------------------------------
-- Control fecha de vencimiento
--------------------------------
if @i_fecha_ven < @s_date
begin
   exec cobis..sp_cerror
        @t_debug      = @t_debug,
        @t_file       = @t_file,
        @t_from       = @w_sp_name,
        @i_msg        = 'Fecha de Vencimiento es menor a la fecha del sistema',
        @i_num        = 141202
   return 141202
end

--------------------------------
-- Control Desmaterializados
--------------------------------

 if (isnull(@w_op_desmaterializa,'N') <> isnull(@i_desmaterializa,'N')) and @w_op_total_int_pagados > 0 begin
   exec cobis..sp_cerror
   @t_from       = @w_sp_name,
   @i_msg        = 'No se puede cambiar la marca de Desmaterializado si ya se han pagado intereses',
   @i_num        = 141202
   return 141202
end

------------------------------------
-- Encuentra parametro de decimales
------------------------------------
select @w_usadeci = mo_decimales
  from cobis..cl_moneda
 where mo_moneda = @w_op_moneda

if @w_usadeci = 'S'
begin
   select @w_numdeci = isnull (pa_tinyint,0)
     from cobis..cl_parametro
    where pa_nemonico = 'DCI'
      and pa_producto = 'PFI'
end
else
   select @w_numdeci = 0


select @w_be_ente = 0, @w_titulares ='', @w_titulares_ant= '',@w_firmantes= '', @w_firmantes_ant = ''

while 1=1
begin
  set rowcount 1
  select @w_be_ente      = be_ente,
         @w_be_tipo      = be_tipo,
         @w_be_condicion = be_condicion
  from pf_beneficiario
  where be_operacion   = @w_op_operacion
    and be_ente        > @w_be_ente
    and be_estado      = 'I'
    and be_estado_xren = 'N'
  order by be_ente
  if @@rowcount = 0
     break

  if @w_be_tipo = 'T'
     select @w_titulares_ant = @w_titulares_ant  + convert(varchar(10),@w_be_ente) + '(' + @w_be_condicion + ')' + '; '

  if @w_be_tipo = 'F'
     select @w_firmantes_ant = @w_firmantes_ant  + convert(varchar(10),@w_be_ente) + '(' + @w_be_condicion + ')' + '; '
end

select @w_be_ente = 0

while 2=2
begin
  set rowcount 1
  select @w_be_ente      = bt_ente,
         @w_be_tipo      = bt_tipo,
         @w_be_condicion = bt_condicion
   from pf_beneficiario_tmp
  where bt_usuario     = @s_user
    and bt_sesion      = @s_sesn
    and bt_ente        > @w_be_ente
    and bt_operacion   = @w_op_operacion
  order by bt_ente
  if @@rowcount = 0
     break

  if @w_be_tipo = 'T'
     select @w_titulares = @w_titulares  + convert(varchar(10),@w_be_ente) +  '(' + @w_be_condicion + ')'+ '; '

  if @w_be_tipo = 'F'
     select @w_firmantes = @w_firmantes  + convert(varchar(10),@w_be_ente) +  '(' + @w_be_condicion + ')'+ '; '

end


set rowcount 0


begin tran
   -------------------------------
   -- Inicializacion de Variables
   -------------------------------
   select @w_contabiliza        = 'N'
   select @w_toperacion         = NULL
   select @w_categoria          = NULL
   select @w_oficina            = NULL
   select @w_plazo              = NULL
   select @w_dia_pago           = NULL
   select @w_plazo_orig         = NULL
   select @w_base_calculo       = NULL
   select @w_tcapitalizacion    = NULL
   select @w_fecha_ven          = NULL
   select @w_ente_corresp       = NULL --GAR GB-DP00120
   select @w_camb_fecv          = 'N'
   select @w_localizado         = NULL
   select @w_fecha_localizacion = NULL
   select @w_fecha_no_localiza  = NULL
   select @w_fpago              = NULL
   select @w_ppago              = NULL
   select @w_fecha_valor_act    = NULL
   select @w_oficial_principal  = NULL
   select @w_oficial_secundario = NULL
   select @w_fecha_valor_act    = NULL
   select @w_dias_reales        = NULL
   select @w_spread             = NULL
   select @w_operador           = NULL
   select @w_fideicomiso        = NULL
   select @w_desmaterializa     = NULL

   -----------------------------------
   -- Evaluacion para cambio de datos
   -----------------------------------
   /** Verifica que no se hayan realizado cambios de oficina durante el d¡a  **/
   if @i_toperacion <> @w_op_toperacion
   begin
      select @w_toperacion = @i_toperacion
      select @w_contabiliza = 'S'

      if exists(select 1
                  from cob_pfijo..pf_cambio_oper
                 where co_operacion    = @w_op_operacion
                   and co_estado    = 'A'   -- Aplicado
                   and co_fecha  = @s_date
                   and co_toperacion   <> co_toperacion_ant)
       begin
          UPDATE cob_pfijo..pf_cambio_oper
             set co_estado    = 'R'            -- Reverso
           where co_operacion    = @w_op_operacion
             and co_estado    = 'A'   -- Aplicado
             and co_fecha  = @s_date
             and co_toperacion <> co_toperacion_ant
       end
       select @w_toperacion_ant = @w_op_toperacion
   end
   else
       select @w_toperacion_ant = NULL

   if @i_categoria <> @w_op_categoria
   begin
      select @w_categoria = @i_categoria
      select @w_categoria_ant = @w_op_categoria
   end
   else
      select @w_categoria_ant = NULL

   if @i_ente_corresp <> @w_op_ente_corresp
      select @w_ente_corresp = @i_ente_corresp --GAR GB-DP00120

   if @i_localizado <> @w_op_localizado
      select @w_localizado = @i_localizado

   if @i_fecha_localizacion <> @w_op_fecha_localizacion
      select @w_fecha_localizacion = @i_fecha_localizacion

   if @i_fecha_no_localiza <> @w_op_fecha_no_localiza
      select @w_fecha_no_localiza = @i_fecha_no_localiza

   /** Verifica que no se hayan realizado cambios de oficina durante el d¡a **/
   if @i_oficina <> @w_op_oficina
   begin
      select @w_oficina = @i_oficina
      select @w_contabiliza = 'S'

        if exists(select 1
                  from cob_pfijo..pf_cambio_oper
                 where co_operacion    = @w_op_operacion
                   and co_estado    = 'A'   -- Aplicado
                   and co_fecha  = @s_date
                   and co_oficina   <> co_oficina_ant)
       begin
          UPDATE cob_pfijo..pf_cambio_oper
             set co_estado = 'R'            -- Reverso
           where co_operacion    = @w_op_operacion
             and co_estado    = 'A'   -- Aplicado
             and co_fecha  = @s_date
             and co_oficina   <> co_oficina_ant
       end

       select @w_oficina_ant = @w_op_oficina

   end
   else
       select @w_oficina_ant = NULL

   if @i_plazo <> @w_op_num_dias
   begin
      select @w_plazo = @i_plazo
      select @w_plazo_ant = @w_op_num_dias
   end
   else
      select @w_plazo_ant = NULL

   if @i_dia_pago <> @w_op_dia_pago
      select @w_dia_pago = @i_dia_pago,
             @w_dia_pago_ant = @w_op_dia_pago
   else
      select @w_dia_pago_ant = NULL

   if @i_plazo_orig <> @w_op_plazo_orig
   begin
        select @w_plazo_orig = @i_plazo_orig
        select @w_plazo_orig_ant = @w_op_plazo_orig
   end
   else
        select @w_plazo_orig_ant = NULL

   if @i_fecha_ven <> @w_op_fecha_ven
   begin
      select @w_fecha_ven = @i_fecha_ven
      select @w_fecha_ven_ant = @w_op_fecha_ven
   end
   else
      select @w_fecha_ven_ant = NULL

   if @i_fecha_valor <>  @w_op_fecha_valor
   begin
      select @w_fecha_valor_act = @i_fecha_valor
      select @w_fecha_valor_ant = @w_op_fecha_valor
   end
   else
      select @w_fecha_valor_ant = NULL

   if @i_base_calculo <> @w_op_base_calculo
   begin
      select @w_base_calculo = @i_base_calculo
      select @w_camb_bascalc = 'S'
      select @w_base_calculo_ant = @w_op_base_calculo
   end
   else
      select @w_base_calculo_ant = NULL

   if @i_tasa <> @w_op_tasa
   begin
      select @w_tasa = @i_tasa
      select @w_camb_tasa = 'S'
      select @w_tasa_ant = @w_op_tasa
   end
   else
      select @w_tasa_ant  = NULL

   if @i_tcapitalizacion <> @w_op_tcapitalizacion
   begin
      select @w_tcapitalizacion = @i_tcapitalizacion
      select @w_tcapitalizacion_ant = @w_op_tcapitalizacion
   end
   else
     select @w_tcapitalizacion_ant = NULL

   if @i_desmaterializa <> @w_op_desmaterializa
   begin
      select @w_desmaterializa  = @i_desmaterializa
      select @w_desmaterializa_ant = @w_op_desmaterializa
   end
   else
      select @w_desmaterializa_ant = NULL --@w_op_desmaterializa

   if @i_oficial_princ <> @w_op_oficial_principal
   begin
      select @w_oficial_principal = @i_oficial_princ
      select @w_oficial_principal_ant = @w_op_oficial_principal
   end
   else
       select @w_oficial_principal_ant = NULL

   if @i_oficial_sec <> @w_op_oficial_secundario
   begin
      select @w_oficial_secundario = @i_oficial_sec
      select @w_oficial_secundario_ant = @w_op_oficial_secundario
   end
   else
      select @w_oficial_secundario_ant = NULL

   if @i_fpago <> @w_op_fpago   --CVA Oct-18-05
   begin
      select @w_fpago     = @i_fpago
      select @w_fpago_ant = @w_op_fpago
   end
   else
      select @w_fpago_ant = NULL

   if @i_ppago <> @w_op_ppago   --CVA Oct-18-05
   begin
      select @w_ppago     = @i_ppago
      select @w_ppago_ant = @w_op_ppago
   end
   else
      select @w_ppago_ant = NULL

   if @i_dias_reales <> @w_op_dias_reales --CVA Nov-09-05
   begin
      select @w_dias_reales      = @i_dias_reales
      select @w_dias_reales_ant  = @w_op_dias_reales
   end
   else
      select @w_dias_reales_ant  = NULL

   --Cambio para fideicomiso
   if @i_fideicomiso <> @w_op_fideicomiso
   begin
        select @w_fideicomiso = @i_fideicomiso
        select @w_fideicomiso_ant = @w_op_fideicomiso
   end
   else
       select @w_fideicomiso_ant = NULL

   if @i_spread_fijo <> @w_op_spread_fijo and @i_spread_fijo <> 0
   select @w_spread         = @i_spread_fijo,
               @w_operador       = @i_operador_fijo,
          @w_utilizo_spread = 'S'

   else
   select  @w_spread = @w_op_spread_fijo,
           @w_operador = @w_op_operador_fijo

   if @i_tasa_base <> 0 and @i_tasa_base <> @w_tasa_base_ini
      select @w_tasa_base_ini = @i_tasa_base

   --Si esta cambiando plazo y por ende la tasa pero no tiene spread entonces
   --se deben actualizar a nulos los valores que antes tenian
   if @w_op_tasa_variable = 'N'
   if @w_camb_tasa = 'S' and @i_spread_fijo = 0
      select  @w_spread   = 0,
              @w_operador = NULL

   if @w_titulares = @w_titulares_ant
      select @w_titulares_ant = '', @w_titulares = ''

   if @w_firmantes = @w_firmantes_ant
      select @w_firmantes = '', @w_firmantes_ant = ''

   /* Forma de Pago de Intereses */
   select @w_fpago_ant = dp_forma_pago
     from pf_det_pago
    where dp_operacion    = @w_op_operacion
      and dp_tipo         in ('INT','INTV')
      and dp_estado_xren  = 'N' 
      and dp_estado       = 'I' 

   select @w_fpago = dt_forma_pago
     from pf_det_pago_tmp
    where dt_operacion = @w_op_operacion
      and dt_usuario   = @s_user
      and dt_sesion    = @s_sesn

   if @w_fpago_ant = isnull(@w_fpago, @w_fpago_ant)
      select @w_fpago_ant = NULL,
             @w_fpago     = NULL

   ------------------------------------
   -- Insercion de historia de cambios
   ------------------------------------
   insert into cob_pfijo..pf_cambio_oper(co_secuencial     , co_operacion           , co_num_banco     , co_oficina,
                                         co_oficina_ant    , co_toperacion          , co_toperacion_ant, co_funcionario,
                                         co_oficial_prin   , co_oficial_prin_ant    , co_fecha         , co_contabiliza,
                                         co_contabilizado  , co_fecha_valor         , co_fecha_valop   , co_fecha_valop_ant,
                                         co_base_calculo   , co_base_calculo_ant    , co_oficina_ope   , co_oficina_ope_ant,
                                         co_tcapitalizacion, co_tcapitalizacion_ant , co_estado        , co_tasa,
                                         co_tasa_ant       , co_fecha_ven           , co_fecha_ven_ant , co_instruccion_especial,
                                         co_fpago          , co_fpago_ant           , co_ppago         , co_ppago_ant,
                                         co_categoria      , co_categoria_ant       , co_oficial_sec   , co_oficial_sec_ant,
                                         co_num_dias       , co_num_dias_ant        , co_plazo_orig    , co_plazo_orig_ant,
                                         co_dias_reales    , co_dias_reales_ant     , co_titulares     , co_titulares_ant ,
                                         co_firmantes      , co_firmantes_ant       , co_dia_pago      , co_dia_pago_ant,
                                         co_fideicomiso    , co_fideicomiso_ant     , co_desmaterializa, co_desmaterializa_ant )
                                 values (@w_op_camb_oper   , @w_op_operacion        , @i_cuenta_ant    , @w_oficina,
                                         @w_oficina_ant    , @w_toperacion          , @w_toperacion_ant, @s_user,
                                         @w_oficial_principal , @w_oficial_principal_ant, getdate()    , @w_contabiliza,
                                         'N'               , @w_fecha_camb_ant      , @w_fecha_valor_act, @w_fecha_valor_ant,
                                         @w_base_calculo   , @w_base_calculo_ant    , @w_oficina       , @w_oficina_ant,
                                         @w_tcapitalizacion, @w_tcapitalizacion_ant , 'A'              , @w_tasa,
                                         @w_tasa_ant       , @w_fecha_ven           , @w_fecha_ven_ant , @w_instruccion_especial,
                                         @w_fpago          , @w_fpago_ant           , @w_ppago         , @w_ppago_ant,
                                         @w_categoria      , @w_categoria_ant       , @w_oficial_secundario, @w_oficial_secundario_ant,
                                         @w_plazo          , @w_plazo_ant           , @w_plazo_orig    , @w_plazo_orig_ant,
                                         @w_dias_reales    , @w_dias_reales_ant     , @w_titulares     , @w_titulares_ant,
                                         @w_firmantes      , @w_firmantes_ant       , @w_dia_pago      , @w_dia_pago_ant,
                                         @w_fideicomiso    , @w_fideicomiso_ant     , @w_desmaterializa , @w_desmaterializa_ant)
   if @@error <> 0
   begin
       exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 141139
       select @w_return = 141139
       goto borra
   end

   select @w_op_camb_oper = @w_op_camb_oper + 1

   -------------------------------------------------------------
   -- Pongo en estado 'U'(Utilizado) la autorizacion de spread
   -------------------------------------------------------------
   if @i_spread_fijo > 0
   select @w_estado_spread = 'U'
   else
   select @w_estado_spread = 'A'

   update pf_aut_spread
      set as_estado     = @w_estado_spread,
     @w_ssn_spread = as_secuencial
    where as_operacion = @w_op_operacion
      and as_fecha     = @s_date
      and as_estado    = 'V'
   if @@rowcount <> 0 and @w_utilizo_spread = 'S'
   begin
      insert into pf_autorizacion (
      au_operacion,            au_autoriza,                 au_adicional,                  au_oficina,
      au_tautorizacion,        au_fecha_crea,               au_num_banco,                  au_oficial,
      au_spread,               au_tasa_base,                au_tasa,          au_secuencial)
      values(
      @w_op_operacion,         @s_user,                     null,                          @s_ofi,
      'ASP',                   @s_date,                     @i_cuenta_ant,                 @w_op_oficial_principal,
      @i_spread_fijo,          @w_tasa_base_ini,            @w_tasa  ,        @w_ssn_spread)
      if @@error <> 0
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 143040
       select @w_return = 143040
       goto borra
      end

   end

   -------------------------------------------------
   -- Proceso para calculo de retencion de impuesto
   -------------------------------------------------
   select @w_tasa1 = pa_float
     from cobis..cl_parametro
    where pa_producto = 'PFI'
      and pa_nemonico = 'IMP'

      -----------------------------------------------------------------------------
      -- CVA Oct-06-05
      -- Se inserta las instrucciones en la tabla de instrucciones de la operacion
      -----------------------------------------------------------------------------
      select @w_instruccion_especial = ''

      if @i_instruccion_especial is not null
      begin
         if exists(select 1 from pf_instruccion where in_operacion = @w_op_operacion and isnull(in_estadoxren,'N') = 'N')
         begin
            select @w_instruccion_especial = in_instruccion
              from pf_instruccion
             where in_operacion   = @w_op_operacion
                and isnull(in_estadoxren,'N') = 'N'

            update pf_instruccion
               set in_instruccion = @i_instruccion_especial,
              in_fecha_mod   = @s_date
             where in_operacion   = @w_op_operacion
                and isnull(in_estadoxren,'N') = 'N'
            if @@error <> 0
            begin
               exec cobis..sp_cerror
				  @t_debug = @t_debug,
				  @t_file  = @t_file,
				  @t_from  = @w_sp_name,
				  @i_num   = 145045
			  select @w_return = 145045
              goto borra
       end

            insert into ts_instruccion (secuencial    , tipo_transaccion       , clase , fecha,
                                        usuario       , terminal               , srv   , lsrv,
                                        operacion     , instruccion)
                               values  (@s_ssn        , 14238                  , 'N'   , @s_date,
                                        @s_user       , @s_term                , @s_srv, @s_lsrv,
                                        @w_op_operacion, @i_instruccion_especial)
          /* Si no se puede insertar error */
            if @@error <> 0
            begin
               exec cobis..sp_cerror
                    @t_debug       = @t_debug,
				    @t_file        = @t_file,
				    @t_from        = @w_sp_name,
	                @i_num         = 143005
                select @w_return = 143005
          goto borra
       end
    end
    else
         begin
          insert pf_instruccion(in_operacion   , in_instruccion         , in_estadoxren,
              in_fecha_crea  , in_fecha_mod)
                      values(@w_op_operacion, @i_instruccion_especial, 'N',
              @s_date,     @s_date)
       if @@error <> 0
            begin
               exec cobis..sp_cerror
				  @t_debug = @t_debug,
				  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
		          @i_num   = 143053
             select @w_return = 143053
               goto borra
            end

            insert into ts_instruccion (secuencial    , tipo_transaccion, clase , fecha,
                                        usuario       , terminal        , srv   , lsrv,
                                        operacion     , instruccion)
                               values  (@s_ssn        , 14151           , 'N'   , @s_date,
                                        @s_user       , @s_term         , @s_srv, @s_lsrv,
                                        @w_op_operacion, @i_instruccion_especial)
       if @@error <> 0
            begin
             exec cobis..sp_cerror
                     @t_debug       = @t_debug,
                    @t_file        = @t_file,
                    @t_from        = @w_sp_name,
                    @i_num         = 143005
             select @w_return = 143005
               goto borra
          end
         end /*** revision de que exista      ***/
      end /*** revision de que no sea null ***/
      else
      begin
         if exists(select 1 from pf_instruccion where in_operacion = @w_op_operacion and isnull(in_estadoxren,'N') = 'N')
         begin
            delete from pf_instruccion
              where in_operacion              = @w_op_operacion
                and isnull(in_estadoxren,'N') = 'N'
       if @@error <> 0
            begin
               exec cobis..sp_cerror
				  @t_debug = @t_debug,
				  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
		          @i_num   = 147044
             select @w_return = 147044
               goto borra
            end
         end
      end

   --------------------------------------------
   -- Insercion de registro en tabla historica
   --------------------------------------------
   insert pf_historia (hi_operacion    , hi_secuencial , hi_fecha  , hi_trn_code,
                       hi_valor        , hi_funcionario, hi_oficina, hi_fecha_crea,
                       hi_fecha_mod    , hi_tasa,        hi_observacion) --En observacion van  los puntos
               values (@w_op_operacion , @w_op_historia , @s_date   , 14165,
                       @w_op_monto     , @s_user        , @s_ofi    , @s_date,
                       @s_date         , @w_op_tasa     , convert(varchar,@i_spread_fijo))
   if @@error <> 0
   begin
      exec cobis..sp_cerror
           @t_debug       = @t_debug,
           @t_file        = @t_file,
           @t_from        = @w_sp_name,
           @i_num         = 143006
      select @w_return = 143006
      goto borra
   end

   select @w_op_historia = @w_op_historia + 1

   --------------------------------------------
   -- Evaluacion de datos que fueron cambiados
   --------------------------------------------
   if @i_toperacion = @w_op_toperacion
      select @w_toperacion = @w_op_toperacion

   if @i_categoria = @w_op_categoria
      select @w_categoria = @w_op_categoria

   if @i_ente_corresp = @w_op_ente_corresp
      select @w_ente_corresp = @w_op_ente_corresp --GAR GB-DP00120

   if @i_localizado = @w_op_localizado
      select @w_localizado = @w_op_localizado

   if @i_fecha_localizacion = @w_op_fecha_localizacion
      select @w_fecha_localizacion = @w_op_fecha_localizacion

   if @i_fecha_no_localiza = @w_op_fecha_no_localiza
      select @w_fecha_no_localiza = @w_op_fecha_no_localiza

   if @i_oficina = @w_op_oficina
      select @w_oficina = @w_op_oficina

   if @i_base_calculo = @w_op_base_calculo
      select @w_base_calculo = @w_op_base_calculo

   if @i_tasa = @w_op_tasa
      select @w_tasa = @w_op_tasa

   if @i_tcapitalizacion = @w_op_tcapitalizacion
      select @w_tcapitalizacion = @w_op_tcapitalizacion

   if @i_desmaterializa =  @w_op_desmaterializa
      select @w_desmaterializa =  @w_op_desmaterializa

   if @i_oficial_princ = @w_op_oficial_principal
      select @w_oficial_principal = @w_op_oficial_principal

   if @i_oficial_sec = @w_op_oficial_secundario
      select @w_oficial_secundario = @w_op_oficial_secundario

   if @i_fpago = @w_op_fpago    --CVA Oct-18-05
      select @w_fpago = @w_op_fpago

   if @i_ppago = @w_op_ppago    --CVA Oct-18-05
      select @w_ppago = @w_op_ppago

   select @w_interes = 0, @w_interes_total = 0

   ----------------------------------
   -- Evaluaci¢n por cambio de plazo
   ----------------------------------
   if @i_plazo = @w_op_num_dias
   begin

      select @w_plazo      = @w_op_num_dias

      select @w_fecha_ven  = @i_fecha_ven --@w_op_fecha_ven CVA Jul-14-06 cuando se cambia fecha valor el plazo no siempre cambia

      --CVA Dic-13-05
      if  @w_op_dias_reales <> @i_dias_reales
      begin
          select @w_fecha_ven = @i_fecha_ven
     select @w_camb_fecv = 'S'
      end
   end
   else
   begin
      select @w_fecha_ven  = @i_fecha_ven
      select @w_plazo           = @i_plazo
      select @w_camb_fecv       = 'S'
   end

   select @w_interes       = @i_int_estimado
   select @w_interes_total = @i_total_int_estimado

   -----------------------------------------------------------------
   -- Validacion por cambio de fecha valor y rec lculo de intereses
   -----------------------------------------------------------------
   if @i_fecha_valor <> @w_op_fecha_valor
   begin
         select @w_num_dias      = @i_plazo
         select @w_interes       = @i_int_estimado
         select @w_interes_total    = @i_total_int_estimado
         select @w_op_fecha_ult_pg_int    = @i_fecha_valor
         select @w_fecha_ven     = @i_fecha_ven
         select @w_fecha_pg_int         = @i_fecha_pg_int
   end
   else
         select @w_fecha_pg_int         = @w_op_fecha_pg_int


   ----------------------------------------------------------
   -- Actualizar Operacion como causa de modificacion en COP
   ----------------------------------------------------------
   select @w_secuencia   = @w_op_mon_sgte
   select @w_op_mon_sgte = @w_op_mon_sgte + 1

   if @i_tasa_efectiva is null
      select @i_tasa_efectiva = 0


   if @w_localizado = 'S'
      select @w_inactivo = NULL

   update pf_operacion
      set op_mon_sgte           = op_mon_sgte + 1,
          op_retienimp          = @w_retienimp,
          op_causa_mod          = 'COP',
          op_historia           = @w_op_historia,
          op_fecha_mod          = @s_date,
          op_tasa               = @w_tasa,
          op_tasa_efectiva      = @i_tasa_efectiva,
          op_base_calculo       = @w_base_calculo,
          op_toperacion         = @w_toperacion,
          op_categoria          = @w_categoria,
          op_oficina            = @w_oficina,
          op_num_dias           = @w_plazo,
          op_plazo_orig         = @i_plazo_orig,
          op_tipo_plazo         = @i_tipo_plazo, --CVA Nov-02-05
          op_tcapitalizacion    = @w_tcapitalizacion,
          op_renova_todo        = @w_tcapitalizacion,  --CVA Jul-29-06
          op_oficial_principal  = @w_oficial_principal,
          op_oficial_secundario = @w_oficial_secundario,
          op_fecha_valor        = @w_fecha_valor,
          op_sec_incre          = @w_op_sec_incre,
          op_camb_oper          = @w_op_camb_oper,
          op_int_estimado       = @w_interes,
          op_total_int_estimado = isnull(@w_interes_total,0),
          op_fecha_ven          = @w_fecha_ven,
          op_fecha_ult_pg_int   = @w_op_fecha_ult_pg_int,
          op_tasa_mer           = @w_tasa_base_ini,
          op_tasa_ant           = @w_op_tasa,
          op_cambio_tasa        = @w_camb_tasa,
          op_int_ganado         = @i_int_ganado,
          op_total_int_ganados  = @i_total_int_ganados,
          op_ente_corresp       = @w_ente_corresp,
          op_descripcion        = @i_descripcion,
          op_fecha_pg_int       = @i_fecha_pg_int,
          op_localizado         = @w_localizado,
          op_fecha_localizacion = @w_fecha_localizacion,
          op_fecha_no_localiza  = @w_fecha_no_localiza,
--          op_puntos             = @w_spread,
          op_spread             = @w_spread, --CVA Nov-29-05
          --op_operador           = @w_operador ,
          op_casilla            = @i_casilla,
          op_direccion          = @i_direccion,
          op_sucursal           = @i_sucursal,
          op_fpago              = @i_fpago,
          op_ppago              = @i_ppago,          --CVA Oct-18-05
          op_dia_pago           = @i_dia_pago,       --CVA Nov-02-05
          op_dias_reales        = @i_dias_reales, --CVA Nov-09-05
          op_inactivo           = @w_inactivo,
          op_fideicomiso        = @w_fideicomiso,
          op_desmaterializa     = @w_desmaterializa
    where op_num_banco = @i_cuenta_ant
   if @@error <> 0
   begin
      exec cobis..sp_cerror
           @t_debug       = @t_debug,
           @t_file        = @t_file,
           @t_from        = @w_sp_name,
           @i_num         = 145001
      select @w_return = 145001
      goto borra
   end

   if @w_camb_datos = 'S'
   begin

      select @w_ult_fecha_calculo = dateadd(dd,datediff(dd,@w_fecha_valor,@s_date)-1,@w_fecha_valor)

      update pf_operacion
         set op_ult_fecha_calculo = @w_ult_fecha_calculo
      where op_num_banco = @i_cuenta_ant
      if @@error <> 0
      begin
      exec cobis..sp_cerror
           @t_debug       = @t_debug,
           @t_file        = @t_file,
           @t_from        = @w_sp_name,
           @i_num         = 145001
      select @w_return = 145001
      goto borra
      end
   end


   ----------------------------------------------------------
   -- Cambia el estado de los beneficiarios anteriores
   ----------------------------------------------------------
   update pf_beneficiario
   set    be_estado = 'E',
          be_estado_xren = 'M'
   where  be_operacion   = @w_op_operacion
     and  be_estado_xren = 'N'  --CVA Oct-18-05
     and  be_estado      = 'I'  --CVA Oct-18-05

   ----------------------------------------------------------
   -- Insercion de beneficiarios en la tabla pf_beneficiario
   ----------------------------------------------------------
   select @w_bt_ente = 0
   while 1 = 1
   begin
      set rowcount 1
      select @w_bt_ente        = bt_ente,
             @w_bt_rol         = bt_rol,
        @w_bt_fecha_crea  = bt_fecha_crea,
        @w_bt_fecha_mod   = bt_fecha_mod,
             @w_bt_tipo        = bt_tipo,
             @w_bt_condicion   = bt_condicion,
             @w_bt_secuencia   = bt_secuencia
        from pf_beneficiario_tmp
       where bt_usuario     = @s_user
         and bt_sesion      = @s_sesn
         and bt_ente        > @w_bt_ente
         and bt_operacion   = @w_op_operacion
       order by bt_ente
      if @@rowcount = 0
         break

      set rowcount 0

      -----------------------------------------------------------
      -- Insercion definitiva de beneficiarios de ese plazo fijo
      -----------------------------------------------------------
      exec @w_return = sp_beneficiario
           @s_ssn         = @s_ssn,
           @s_user        = @s_user,
           @s_term        = @s_term,
           @s_date        = @s_date,
           @s_srv         = @s_srv,
           @s_lsrv        = @s_lsrv,
           @s_ofi         = @s_ofi,
           @s_rol         = @s_rol,
           @t_debug       = @t_debug,
           @t_file        = @t_file,
           @t_from        = @t_from,
           @t_trn         = 14109,
           @i_operacion   = 'I',
           @i_cuenta      = @i_cuenta_ant,
           @i_ente        = @w_bt_ente,
           @i_rol         = @w_bt_rol,
           @i_estado_xren = 'N',
           @i_tipo        = @w_bt_tipo,
           @i_condicion   = @w_bt_condicion,
           @i_secuencia   = @w_bt_secuencia
      if @w_return <> 0
      begin
         goto borra
      end

      --I. CVA May-13-2006
      ---------------------------------------------
      -- Busqueda de nueva cedula del beneficiario
      ---------------------------------------------
      select @w_ced_ruc = en_ced_ruc
        from cobis..cl_ente
       where en_ente = @w_bt_ente
      if @w_ced_ruc IS   NULL
         select @w_ced_ruc = p_pasaporte
           from cobis..cl_ente
          where en_ente = @w_bt_ente

      --------------------------------------
      -- Insercion de productos del cliente
      --------------------------------------
      select @w_siguiente = dp_det_producto
        from cobis..cl_det_producto
       where dp_cuenta  = @i_cuenta_ant

      if not exists(select 1 from cobis..cl_cliente, cobis..cl_det_producto
         where cl_det_producto = dp_det_producto
                          and dp_cuenta       = @i_cuenta_ant
                          and cl_cliente      = @w_bt_ente)
      begin
         insert cobis..cl_cliente
                             (cl_cliente,  cl_det_producto, cl_rol   , cl_ced_ruc,  cl_fecha)
                      values (@w_bt_ente,  @w_siguiente,    @w_bt_rol, @w_ced_ruc,  @s_date)
         if @@error <> 0
         begin
          exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
                   @t_from  = @w_sp_name,
         @i_num   = 703028

               end
     end

     --I. CVA May-13-2006

   end /* while 1 */

   set rowcount 0

      select @w_sec1 = isnull(max(dp_secuencia),0)+1
        from pf_det_pago
       where dp_operacion = @w_op_operacion

      select @w_pt_beneficiario = 0

      select @w_string = 'Sec ' + convert(varchar, @w_sec1)

      --------------------------------------------------------------------------------
      -- Actualizacion de la tabla pf_det_pago para deshabilitar los valores de pagos
      -- anteriores del Pago.
      --------------------------------------------------------------------------------
      set rowcount 0

      if @i_tcapitalizacion = 'S' --CVA Jun-09-06
      begin
         UPDATE cob_pfijo..pf_det_pago
            set dp_estado      = 'E',
                dp_estado_xren = 'M'
          where dp_operacion    = @w_op_operacion
            and dp_tipo         in ('INT','INTV')
            and dp_estado_xren  = 'N'  --CVA Oct-18-05
            and dp_estado       = 'I'  --CVa Oct-18-05

      end


      if @i_modifico_fp = 1
      begin
         --CVA Asegurarme que exista un registro en temporales
         if exists (select 1 from pf_det_pago_tmp
                       where dt_operacion = @w_op_operacion
                         and dt_usuario   = @s_user
                         and dt_sesion    = @s_sesn)
         begin
         UPDATE cob_pfijo..pf_det_pago
            set dp_estado      = 'E',
                dp_estado_xren = 'M'
          where dp_operacion    = @w_op_operacion
            and dp_tipo         in ('INT','INTV')
            and dp_estado_xren  = 'N'  --CVA Oct-18-05
            and dp_estado       = 'I'  --CVa Oct-18-05
    end

    if @i_tcapitalizacion = 'N'   --CVA Jun-08-06
    begin

         while 6=6
         begin
       set rowcount 1
            select @w_pt_beneficiario    = dt_beneficiario,
                   @w_pt_tipo            = dt_tipo,
                   @w_pt_forma_pago      = dt_forma_pago,
                   @w_pt_cuenta          = dt_cuenta,
                   @w_pt_monto           = dt_monto,
                   @w_pt_porcentaje      = dt_porcentaje,
                   @w_pt_fecha_crea      = dt_fecha_crea,
                   @w_pt_fecha_mod       = dt_fecha_mod,
                   @w_pt_moneda_pago     = dt_moneda_pago,
                   @w_pt_benef_chq       = dt_benef_chq,
                   @w_pt_descripcion     = dt_descripcion,
                   @w_pt_oficina         = dt_oficina,
                   @w_pt_tipo_cliente    = dt_tipo_cliente,
                   @w_pt_tipo_cuenta_ach = dt_tipo_cuenta_ach,
                   @w_pt_cod_banco_ach   = dt_cod_banco_ach --LIM 19/NOV/2005
			  from pf_det_pago_tmp
             where dt_usuario       = @s_user
               and dt_sesion     = @s_sesn
               and dt_operacion  = @w_op_operacion
               and ((dt_beneficiario    >= @w_pt_beneficiario) or
                   (dt_beneficiario     = @w_pt_beneficiario and dt_forma_pago <> @w_pt_forma_pago))
             order by dt_beneficiario
            if @@rowcount = 0
               break

            select @w_pt_mont = round(@w_pt_monto, @w_numdeci)

            insert pf_det_pago (dp_operacion       , dp_ente             , dp_tipo          , dp_secuencia,
                                dp_forma_pago      , dp_cuenta           , dp_monto         , dp_porcentaje,
                                dp_fecha_crea      , dp_fecha_mod        , dp_estado_xren   , dp_estado,
                                dp_moneda_pago     , dp_benef_chq        , dp_descripcion   , dp_oficina,
                                --dp_tipo_cliente    , dp_tipo_cuenta_ach  , dp_banco_ach)   --LIM 19/NOV/2005 Comentado
								dp_tipo_cliente    , dp_tipo_cuenta_ach  , dp_cod_banco_ach)   --LIM 19/NOV/2005
                        values (@w_op_operacion    , @w_pt_beneficiario  , @w_pt_tipo       , @w_sec1,
                                @w_pt_forma_pago   , @w_pt_cuenta        , @w_pt_mont       , @w_pt_porcentaje,
                                @s_date            , @s_date             , 'N'              , 'I',
                                @w_pt_moneda_pago  , @w_pt_benef_chq     , @w_pt_descripcion, @w_pt_oficina,
                                --@w_pt_tipo_cliente , @w_pt_tipo_cuenta_ach  , @w_pt_banco_ach)   --LIM 19/NOV/2005 Comentado
								@w_pt_tipo_cliente , @w_pt_tipo_cuenta_ach  , @w_pt_cod_banco_ach)          --LIM 19/NOV/2005
            if @@error <> 0
            begin
               exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 143038
               select @w_return = 143038
               goto borra
            end

            insert into ts_det_pago (secuencial      , tipo_transaccion  , clase           , fecha,
                                     usuario         , terminal          , srv             , lsrv,
                                     operacion       , ente              , tipo            , forma_pago,
                                     cuenta          , monto             , porcentaje      , fecha_crea,
                                     fecha_mod       , moneda_pago)
                            values  (@s_ssn          , @t_trn            , 'N'             , @s_date,
                                     @s_user         , @s_term           , @s_srv          , @s_lsrv,
                                     @w_op_operacion , @w_pt_beneficiario, @w_pt_tipo      , @w_pt_forma_pago,
                                     @w_pt_cuenta    , @w_pt_mont        , @w_pt_porcentaje, @s_date,
                                     @s_date         , @w_pt_moneda_pago)
            /* Si no se puede insertar error */
            if @@error <> 0
            begin
               exec cobis..sp_cerror
                    @t_debug       = @t_debug,
                    @t_file        = @t_file,
                    @t_from        = @w_sp_name,
                    @i_num         = 143005
               select @w_return = 143005
               goto borra
            end

            delete pf_det_pago_tmp
             where dt_usuario      = @s_user
               and dt_sesion     = @s_sesn
               and dt_operacion  = @w_op_operacion
               and dt_beneficiario  = @w_pt_beneficiario
               and dt_forma_pago        = @w_pt_forma_pago

            select @w_sec1 = @w_sec1 + 1

         end /*  While 6  */
   end --capitalizacion = 'N'
   else
   begin --capitalizacion = 'S'
            delete pf_det_pago_tmp
        where dt_usuario      = @s_user
               and dt_sesion     = @s_sesn
               and dt_operacion  = @w_op_operacion
   end
      end

      set rowcount 0

      -------------------------------------------------------------
      -- Por cambio de Formas de Pago, eliminaci¢n de pf_cuotas
      -------------------------------------------------------------
      if @i_fpago = 'VEN' and @w_op_fpago = 'PER'
      begin
         insert into cob_pfijo..pf_cuotas_his (
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
         from  cob_pfijo..pf_cuotas
         where cu_operacion =  @w_op_operacion
         
         delete from pf_cuotas where cu_operacion = @w_op_operacion

      end

      -----------------------------------------------------------------------
      --CONTABILIZACION POR CAMBIO DE OFICINA O TIPO DE OPERACION
      -----------------------------------------------------------------------
      if @i_oficina <> @w_op_oficina or @i_toperacion <> @w_op_toperacion
      begin
         select  @w_oficina         = @i_oficina,
         @w_oficina_ant     = @w_op_oficina,
         @w_toperacion      = @i_toperacion,
         @w_toperacion_ant = @w_op_toperacion
         
         select @w_descripcion = 'MANTENI. ' + 'OF.ANT ' + convert(varchar,@w_oficina_ant) + ' OF.NUE ' + convert(varchar,@w_oficina) + ' TD.ANT ' + convert(varchar,@w_toperacion_ant) + ' TD.NUE ' + convert(varchar,@w_toperacion) + ' ' + @i_cuenta_ant
         
         exec @w_return = cob_pfijo..sp_aplica_conta
         @s_ssn         = @s_ssn,
         @s_date        = @s_date,
         @s_user        = @s_user,
         @s_term        = @s_term,
         @s_ofi         = @s_ofi,
         @t_debug       = @t_debug,
         @t_file        = @t_file,
         @t_from        = @w_sp_name,
         @t_trn         = 14937,
         @i_en_linea    = 'N',
         @i_empresa     = 1,
         @i_fecha       = @s_date,
         @i_tran        = @t_trn,            --Transaccion de mantenimiento
         @i_producto    = 14,          --@w_producto,
         @i_oficina_oper= @w_oficina_ant,
         @i_oficina     = @w_oficina_ant,
         @i_oficina_new = @w_oficina,
         @i_toperacion  = @w_toperacion_ant,
         @i_toperacion_new = @w_toperacion,
         @i_tplazo         = @i_tipo_plazo,
         @i_tplazo_old     = @w_op_tipo_plazo,
         @i_operacionpf = @w_op_operacion,
         @i_afectacion  = 'N',      --'N',               -- N=Normal,  R=Reverso
         @i_descripcion = @w_descripcion,
         @i_monto       = @w_op_monto,
         @i_valor       = @i_int_ganado,
         @i_retieneimp  = 'N',     -- Trae valor real retiene impuestos para calculo de cotizacion
         @i_fecha_tran  = @s_date,           -- Tomar reg. de esta fecha.
         @i_secuencia   = @w_op_mon_sgte, -- Toma reg. de sec. adec
         @i_moneda      = @w_op_moneda,
         @o_comprobante = @o_comprobante out
         if @w_return <> 0
         begin
            exec cobis..sp_cerror
            @t_debug       = @t_debug,
            @t_file        = @t_file,
            @t_from        = @w_sp_name,
            @i_num         = @w_return
            
            rollback tran
            
            goto borra
         end
      end

      ------------------------------------------------------------
      -- Contabilizacion de la operacion por ajustes en intereses
      -- Actualizacion de cuotas
      ------------------------------------------------------------
      if @i_tasa         <> @w_op_tasa       or
         @i_base_calculo <> @w_op_base_calculo  or
         @i_fecha_valor  <> @w_op_fecha_valor   or
         @i_plazo        <> @w_op_num_dias      or
         @i_tcapitalizacion <> @w_op_tcapitalizacion or
         @i_fpago           <> @w_op_fpago      or
         @i_ppago           <> @w_op_ppago      or
         @i_dia_pago        <> @w_op_dia_pago   or
         @i_dias_reales     <> @w_op_dias_reales
      begin
          exec @w_return         = sp_incremento_cero
              @s_ssn                  = @s_ssn,
              @s_user                 = @s_user,
              @s_term                 = @s_term,
              @s_date                 = @s_date,
              @s_sesn                 = @s_sesn,
              @s_srv                  = @s_srv,
              @s_lsrv                 = @s_lsrv,
              @s_ofi                  = @s_ofi,
              @s_rol                  = @s_rol,
              @t_debug                = @t_debug,
              @t_file                 = @t_file,
              @t_from                 = @t_from,
              @i_fecha_proceso        = @s_date,
              @i_op_operacion         = @w_op_operacion,
              @i_cuenta               = @i_cuenta_ant,
              @i_en_linea             = 'S',
              @i_tasa_efectiva        = @i_tasa_efectiva,
              @i_flag_tasaefec        = @w_op_flag_tasaefec,
              @i_camb_tasa            = @w_camb_tasa,                   -- Para el cambio de base de c lculo
              @i_camb_datos           = @w_camb_datos,                  -- En el caso que cambie fecha valor
              @i_camb_fecv            = @w_camb_fecv,
              @i_camb_bascalc         = @w_camb_bascalc,
              @i_op_moneda            = @w_op_moneda,
              @i_op_monto             = @w_op_monto,
              @i_op_base_calculo      = @i_base_calculo,
              @i_fecha_ven            = @i_fecha_ven,
              @i_tasa                 = @i_tasa,
              @i_op_ente              = @w_op_ente,
              @i_op_oficina           = @w_op_oficina,
              @i_op_dias_reales       = @w_op_dias_reales,
              @i_op_toperacion        = @w_op_toperacion,
              @i_op_fecha_valor       = @i_fecha_camb,
              @i_fecha_valor          = @i_fecha_valor,
              @i_op_tipo_plazo        = @w_op_tipo_plazo,
              @i_op_fecha_pg_int      = @w_fecha_pg_int,
              @i_op_ppago             = @i_ppago,
              @i_op_fpago             = @i_fpago,
              @i_int_ganado           = @w_op_int_ganado,
              @i_new_int_ganado       = @i_int_ganado,        --Ganado Nuevo
              @i_new_total_int_gan    = @i_total_int_ganados, --Total Ganado Nuevo
              @i_dia_pago             = @i_dia_pago,
              @i_num_dias_ant         = @w_op_num_dias,       --Plazo Anterior
              @i_fpago_ant            = @w_op_fpago,
              @i_fecha_pg_int_ant     = @w_op_fecha_pg_int,
              @i_int_estimado         = @w_interes,
			  @i_fecha_cambio         = @i_fecha_camb,  --CVA Ene-17-06
              @i_fecha_ult_pg_int     = @w_op_fecha_ult_pg_int, --CVA Ene-17-06
			  @i_modifica             = @i_modifica --CVA Jun-29-06 para escalonados
            if @w_return <> 0
            begin
               exec cobis..sp_cerror
                    @t_debug       = @t_debug,
                    @t_file        = @t_file,
                    @t_from        = @w_sp_name,
                    @i_num         = @w_return

               rollback tran

               goto borra
            end
            set rowcount 0
         end



    if @i_tasa <> @w_op_tasa  and @w_pignorado = 'S'
         begin
            if exists(select pi_cuenta
                      from pf_pignoracion
                      where pi_operacion    = @w_op_operacion
                        and  pi_producto    = 'GAR')
                begin
                    exec @w_return = cob_interfase..sp_icredito   -- BRON: 15/07/09  cob_credito..sp_pignoracion_dpf
                         @i_operacion      = 'A',
                         @s_ssn            = @s_ssn,
                         @s_user           = @s_user,
                         @s_term           = @s_term,
                         @s_srv            = @s_srv,
                         @s_ofi            = @s_ofi,
                         @s_org            = @s_org,
                         @s_lsrv           = @s_lsrv,
                         @s_rol            = @s_rol,
                         @s_date           = @s_date,
                         @i_modo           = 1,
                         @i_tasa_actual    = @i_tasa,
                         @i_tasa_ant       = @w_op_tasa,
                         @i_num_operacion  = @i_cuenta_ant,
                         @i_producto       = 14
                         
                    if @w_return <> 0
                    begin
                       select @w_return = @w_return
                       rollback tran
                       goto borra
                    end

                    set rowcount 0
                end
         end

         select @w_td_tipo_persona   = td_tipo_persona
           from cob_pfijo..pf_tipo_deposito
          where td_mnemonico = @i_toperacion

         select  '15637'   = @i_cuenta_ant,
                 '15638'   = @w_sec_ticket,
                 'Tipo Persona' = @w_td_tipo_persona

     commit tran
--rollback tran
      goto borra

----------------------------
-- Borrar tablas temporales
----------------------------
borra:
  set rowcount 0

  delete pf_rubro_op_tmp
  where rot_usuario   = @s_user
    and rot_sesion    = @s_sesn
    and rot_operacion = @w_op_operacion

  delete pf_mov_monet_tmp
   where mt_usuario   = @s_user
     and mt_sesion    = @s_sesn
     and mt_operacion = @w_op_operacion

  delete pf_beneficiario_tmp
   where bt_usuario   = @s_user
     and bt_sesion    = @s_sesn
     and bt_operacion = @w_op_operacion

  delete pf_det_pago_tmp
   where dt_usuario   = @s_user
     and dt_sesion    = @s_sesn
     and dt_operacion = @w_op_operacion

  delete pf_det_cheque_tmp
   where ct_usuario   = @s_user
     and ct_sesion    = @s_sesn
     and ct_operacion = @w_op_operacion

  delete pf_condicion_tmp
   where ct_usuario   = @s_user
     and ct_sesion    = @s_sesn
     and ct_operacion = @w_op_operacion

  delete pf_operacion_tmp
   where ot_usuario   = @s_user
     and ot_sesion    = @s_sesn
     and ot_operacion = @w_op_operacion

return @w_return
go


