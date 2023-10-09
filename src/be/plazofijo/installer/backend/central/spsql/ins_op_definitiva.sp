/************************************************************************/
/*      Archivo:                inspfdef.sp                             */
/*      Stored procedure:       sp_ins_op_definitiva                    */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Miryam Davila                           */
/*      Fecha de documentacion: 07-Nov-94                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier aflteracion o agregado hecho por alguno de sus        */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa mueve la informacion de las tablas temporales     */
/*      de operaciones de plazo fijo nuevas a las tablas definitivas    */
/*      realizando la funcion completa de apertura del deposito.        */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      07-Nov-94  Ricardo Valencia   Creacion                          */
/*      25-Nov-94  Juan Jose Lam      Modificacion                      */
/*      22-Ago-95  Carolina Alvarado  Activacion Automatica             */
/*                                    Grabacion  Condiciones y detalles */
/*                                    Grabacion  detalle de cheques     */
/*      16-Dic-98  Dolores Guerrero   Retencion sobre el capital (1%)   */
/*                 Gabriela Estupinan                                   */
/*      29-Abr-99  Ximena Cartagena  Envio de parametros de capitaliza- */
/*                                   cion de intereses a sp_estima_int  */
/*                                   de tasa efectiva a nominal.        */
/*      17-Ago-01  Memito Saborio    Inclusion de un campo nuevo que    */
/*                                   lleva una instruccion especial.    */
/*      03-May-2005 N. Silva         Identacion general y correcciones  */
/*     2005/10/04 Carlos Cruz D.    Se aumenta campo para manejo de su- */
/*                                  cursal de retencion de corresponden-*/
/*                                  cia                                 */
/*     2006/08/03 Ricardo Ramos     Adicionar campo de fideicomiso      */
/*     22/Jul/2009   Y. Martinez NYM DPF00015 ICA                       */
/*     2017/01/11 Jorge Salazar     DPF-H94952 MANEJO DE RETENCIONES MX */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_ins_op_definitiva')
   drop proc sp_ins_op_definitiva
go

create proc sp_ins_op_definitiva (
@s_ssn                          int          = NULL,
@s_user                         login        = NULL,
@s_term                         varchar(30)  = NULL,
@s_date                         datetime     = NULL,
@s_sesn                         int          = NULL,
@s_srv                          varchar(30)  = NULL,
@s_lsrv                         varchar(30)  = NULL,
@s_ofi                          smallint     = NULL,
@s_rol                          smallint     = NULL,
@t_debug                        char(1)      = 'N',
@t_file                         varchar(10)  = NULL,
@t_from                         varchar(32)  = NULL,
@t_trn                          smallint     = NULL,
@i_cuenta                       cuenta,
@i_operacion                    char(1),
@i_renova_todo                  char(1)      = 'N',
@i_renovaut                     char(1)      = 'N',
@i_cancelaut                    char(1)      = 'N',
@i_puntos                       float        = 0,
@i_autorizado                   login        = NULL,
@i_estado                       catalogo     = NULL,
@i_secuencia                    smallint     = NULL,
@i_numdoc                       smallint     = 0,
@i_moneda_pg                    char(2)      = NULL,
@i_fecha_crea                   datetime     = NULL,
@i_monto_base                   money        = 0,
@i_historia                     int          = 0,
@i_activa                       char(1)      = NULL,
@i_ley                          char(1)      = NULL,
@i_fecha_cal_tasa               datetime     = NULL,
@i_fecha_ingreso                datetime     = NULL,
@i_aut_spread                   login        = NULL,
@i_formato_fecha                int          = 101,
@i_autoriza_pago_otros          login        = NULL,
@i_empresa                      tinyint      = 1,
@i_instruccion_especial         varchar(255) = NULL,
@i_firmas_aut                   char(1)      = NULL,
@i_dias_hold                    int          = 0,
@i_modifica                     char(1)      = 'N',
@i_op_operacion                 int          = NULL,
@o_sec_ticket                   int          = NULL  out
)
with encryption
as
declare
@w_sp_name                      varchar(32),
@w_return                       int,
@w_ced_ruc                      numero,
@w_comentario                   varchar(32),
@w_siguiente                    int,
@w_sig_ant                      int,
@w_secuencial                   int,
@w_sec                          int,
@w_cuenta_dias                  int,
@w_max_ttransito                int,
@w_num_oficial                  int,
@w_money                        money,
@w_total_monet                  money,
@w_clase                        char(1),
@w_telefono                     char(12),
@w_numdeci                      tinyint,
@w_usadeci                      char(1),
@w_mantiene_stock               char(1),
@w_moneda_desc                  descripcion,
@w_producto_mnemonico           char(3),
@w_tip_operacion                char(1),
@w_tran                         smallint,
@w_desmaterializa               char(1),
/* VARIABLES NECESARIAS PARA PF_OPERACION Y PF_OPERACION_TMP */
@w_num_banco                    cuenta,
@w_num_banco1                   cuenta,
@w_operacionpf1                 int,
@w_operacionpf                  int,
@w_ente                         int,
@w_historia_fin                 int,
@w_toperacion                   catalogo,
@w_categoria                    catalogo,
@w_oficina                      smallint,
@w_numdoc                       smallint,
@w_moneda                       tinyint,
@w_casilla                      tinyint,
@w_direccion                    tinyint,
@w_num_dias                     smallint,
@w_monto                        money,
@w_int_base                     money,
@w_imp_base                     money,
@w_mon                          money,
@w_monto_pg_int                 money,
@w_monto_pgdo                   money,
@w_monto_blq                    money,
@w_tasa                         float,
@w_tasa1                        float,
@w_tasa_mer                     float,
@w_tasa_efectiva                float,
@w_tasa_imp                     float,
@w_int_ganado                   money,
@w_int_estimado                 money,
@w_int_estim                    money,
@w_int_pagados                  money,
@w_int_provision                money,
@w_total_int_ganados            money,
@w_total_retencion              money,
@w_total_int_pagados            money,
@w_total_int_estimado           money,
@w_total_int_estim              money,
@w_dif_estim                    money,
@w_dif_estimado                 money,
@w_dif_impuesto                 money,
@w_fpago                        catalogo,
@w_ppago                        catalogo,
@w_dia_pago                     tinyint,
@w_historia                     smallint,
@w_base_calculo                 smallint,
@w_duplicados                   tinyint,
@w_renovaciones                 smallint,
@w_incremento                   smallint,
@w_mon_sgte                     smallint,
@w_estado                       catalogo,
@w_pignorado                    char (1),
@w_retenido                     char (1),
@w_totalizado                   char (1),
@w_tcapitalizacion              char (1),
@w_oficial                      login,
@w_descripcion                  varchar(255),
@w_causa_mod                    varchar(10),
@w_fecha_valor                  datetime,
@w_fecha_ven                    datetime,
@w_fecha_ven1                   datetime,
@w_p_fecha_crea                 datetime,
@w_fecha_pg_int                 datetime,
@w_fecha_ult_pg_int             datetime,
@w_accion_sgte                  varchar(4),
@w_fecha_ing                    datetime,
@w_fecha_real_pg                datetime,
@w_retienimp                    char(1),
@w_tipo_plazo                   catalogo,
@w_tipo_monto                   catalogo,
@w_estado_xren                  catalogo,
@w_dif                          smallint,
@w_impuesto                     money,
@w_num_pagos                    smallint,
@w_ch1                          catalogo,
@w_ct_sub_secuencia             smallint,
@w_ct_banco                     catalogo,
@w_ct_cuenta                    cuenta,
@w_ct_cheque                    int,
@w_ct_valor                     money,
@w_ct_descripcion               descripcion,
@w_sec_ticket                   int,
@w_prorroga_aut                 char(1),     -- Prorroga Aut.
@w_num_dias_gracia              int,         -- Prorroga Aut.
@w_tasa_variable                char(1),     -- Tasa Variable.
@w_mnemonico_tasa               catalogo,    -- Tasa Variable.
@w_modalidad_tasa               char(1),     -- Tasa Variable.
@w_periodo_tasa                 smallint,    -- Tasa Variable.
@w_descr_tasa                   descripcion, -- Tasa Varia.
@w_operador                     char(1),     -- Tasa Variable.
@w_spread                       float,       -- Tasa Variable.
@w_spread_vig                   float,       -- Tasa Variable.
@w_spread_max                   float,       -- Tasa Variable.
@w_spread_min                   float,       -- Tasa Variable.
@w_flag_tasaefec                char(1),     -- Efectiva/Nominal
@w_cupon                        char(1),
@w_categoria_cupon              catalogo,
@w_moneda_base                  tinyint,
@w_ente_corresp                 int,
@w_amortiza_per                 money,
@w_fideicomiso                  varchar(15),
/* VARIABLES NECESARIAS PARA PF_BENEFICIARIO PF_BENEFICIARIO_TMP */
@w_bt_ente                      int,
@w_bt_rol                       catalogo,
@w_bt_fecha_crea                datetime,
@w_bt_fecha_mod                 datetime,
@w_bt_tipo                      char(1),
@w_bt_condicion                 char(1),
/* VARIABLES NECESARIAS PARA PF_MOV_MONET */
@w_mt_sub_secuencia             tinyint,
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
@w_mt_impuesto_capital_me       money,
@w_mt_tipo_cliente              char(1),
@w_mt_autorizado                char(1),
@w_mt_cotizacion                money,
@w_mt_tipo_cotiza               char(1),
@w_mt_ttransito                 smallint,
@w_mt_cta_corresp               cuenta,
@w_mt_cod_corresp               catalogo,
@w_mt_benef_corresp             varchar(245),
@w_mt_ofic_corresp              int,
@w_mt_tipo_cuenta_ach           char(1),
@w_mt_oficina_dest              smallint,
@w_mt_cod_banco_ach             smallint,
/* Variables para det_pago_tmp  */
@w_benef_chq                    varchar(255),
@w_pt_beneficiario              int,
@w_sec1                         int,
@w_pt_tipo                      catalogo,
@w_pt_forma_pago                catalogo,
@w_pt_cuenta                    cuenta,
@w_pt_monto                     money,
@w_pt_porcentaje                float,
@w_pt_fecha_crea                datetime,
@w_pt_fecha_mod                 datetime,
@w_pt_moneda_pago               smallint,
@w_pt_descripcion               varchar(255),
@w_pt_oficina                   int,
@w_pt_tipo_cliente              char(1),
@w_pt_secuencia                 int,
@w_pt_tipo_cuenta_ach           char(1),
@w_pt_cod_banco_ach             smallint,
@w_retiene_imp_capital          char(1),
@w_impuesto_capital             money  ,
@w_mm_cuenta                    varchar(24),
@w_mm_sub_secuencia             tinyint,
@w_mm_operacion                 int,
@w_mm_oficina                   int,
@w_mm_fecha_ult_pg_int          datetime,
@w_mm_fecha_pg_int              datetime,
@w_mm_valor                     money,
@w_mm_valor_ext                 money,
@w_mm_impuesto                  money,
@w_mm_impuesto_capital_me       money,
@w_mm_renovaciones              int,
@w_mm_moneda                    int,
@w_mm_total_int_estimado        money,
@w_anio_comercial               char(1),
@w_porc_comision                float,
@w_tasa_base                    float,
@w_comision                     money,
@w_ct_nombre_banco              descripcion,
@w_scontable                    catalogo,
@w_captador                     login,
@w_oficial_prin                 login,
@w_oficial_sec                  login,
@w_fpago_cheque                 char(1), 
@w_tipo_persona                 catalogo,
@w_origen_fondos                catalogo,
@w_proposito_cuenta             catalogo,
@w_producto_bancario1           catalogo,
@w_producto_bancario2           catalogo,
@w_dias_reales                  char(1),
@w_tipo_tasa_var                char(1),
@w_condicion                    int,    
@w_plazo_orig                   int,
@w_tran_sabado                  char(1),
@w_fecha_temp_hoy               datetime,
@w_fecha_ven_temp               datetime,
@w_num_dias_labor               smallint,
@w_bt_secuencia                 smallint,
@w_sucursal                     smallint,
@w_ret_ica                      char(1),
@w_tasa_retencion               float,
@w_tasa_ica                     float,
@w_base_ret                     money,
@w_base_ica                     money,
@w_tot_int_est_neto             money,
@w_impuesto_ica                 money,
@w_tipo_deposito                int,
@w_producto                     catalogo,
@w_valor_retenido               money

select
@w_sp_name     = 'sp_ins_op_definitiva',
@w_secuencial  = @s_ssn,
@w_estado_xren ='N'

if (@t_trn <> 14901 or @i_operacion <> 'I') and(@t_trn <> 14916 or @i_operacion <> 'U') begin
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = 141112
   return 1
end

select @w_moneda_base = em_moneda_base
from   cob_conta..cb_empresa
where  em_empresa = @i_empresa

if @@rowcount = 0 begin
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = 601018
   return  1
end

select @w_num_oficial = fu_funcionario
from   cobis..cl_funcionario
where  fu_login = @s_user

select @w_producto_mnemonico = pd_abreviatura
from   cobis..cl_producto
where  pd_producto = 14

select
@w_num_banco          = ot_num_banco,
@w_operacionpf        = ot_operacion,
@w_toperacion         = ot_toperacion,
@w_categoria          = ot_categoria,
@w_oficina            = ot_oficina,
@w_moneda             = ot_moneda,
@w_num_dias           = ot_num_dias,
@w_monto              = ot_monto,
@w_tasa               = ot_tasa,
@w_int_estimado       = ot_int_estimado,
@w_total_int_estimado = ot_total_int_estimado,
@w_ppago              = ot_ppago,
@w_dia_pago           = ot_dia_pago,
@w_oficial            = ot_oficial,
@w_descripcion        = ot_descripcion,
@w_fecha_valor        = ot_fecha_valor,
@w_fecha_ven          = ot_fecha_ven,
@w_fecha_pg_int       = ot_fecha_pg_int,
@w_fecha_real_pg      = ot_fecha_total,
@w_fecha_ing          = ot_fecha_ingreso,
@w_retienimp          = ot_retienimp,
@w_tipo_plazo         = ot_tipo_plazo,
@w_tipo_monto         = ot_tipo_monto,
@w_tasa_efectiva      = ot_tasa_efectiva,
@w_tcapitalizacion    = ot_tcapitalizacion,
@w_fpago              = ot_fpago,
@w_base_calculo       = ot_base_calculo,
@w_casilla            = ot_casilla,
@w_direccion          = ot_direccion,
@w_tasa_imp           = ot_impuesto,
@w_impuesto_capital   = ot_impuesto_capital,
@w_retiene_imp_capital= ot_retiene_imp_capital,
@w_prorroga_aut       = ot_prorroga_aut,
@w_num_dias_gracia    = ot_num_dias_gracia,
@w_tasa_variable      = ot_tasa_variable,
@w_mnemonico_tasa     = ot_mnemonico_tasa,
@w_modalidad_tasa     = ot_modalidad_tasa,
@w_periodo_tasa       = ot_periodo_tasa,
@w_descr_tasa         = ot_descr_tasa,
@w_operador           = ot_operador,
@w_spread             = ot_spread,
@w_flag_tasaefec      = ot_flag_tasaefec,
@w_tasa_base          = ot_porc_comision,
@w_cupon              = ot_cupon,
@w_categoria_cupon    = ot_categoria_cupon,
@w_captador           = ot_captador,
@w_oficial_prin       = ot_oficial_principal,
@w_oficial_sec        = ot_oficial_secundario,
@w_anio_comercial     = ot_anio_comercial,
@w_origen_fondos      = ot_origen_fondos,
@w_proposito_cuenta   = ot_proposito_cuenta,
@w_producto_bancario1 = ot_producto_bancario1,
@w_producto_bancario2 = ot_producto_bancario2,
@w_dias_reales        = ot_dias_reales,
@w_ente_corresp       = ot_ente_corresp,
@w_plazo_orig         = ot_plazo_orig,
@w_sucursal           = ot_sucursal,
@w_amortiza_per       = ot_amortiza_periodo,
@w_fideicomiso        = ot_fideicomiso,
@w_desmaterializa     = ot_desmaterializa
from  pf_operacion_tmp
where ot_usuario      = @s_user
and   ot_sesion       = @s_sesn
and   ot_num_banco    = @i_cuenta

if @@rowcount = 0 begin
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = 141004
   return 1
end

select @w_moneda_desc = mo_descripcion
from   cobis..cl_moneda
where  mo_moneda = @w_moneda

if @i_moneda_pg is null select @i_moneda_pg = convert(varchar(2),@w_moneda) begin
   select @w_ente      = bt_ente
   from   pf_beneficiario_tmp
   where  bt_usuario   = @s_user
   and    bt_sesion    = @s_sesn
   and    bt_operacion = @w_operacionpf
   and    bt_rol       = 'T'
   and    bt_tipo      = 'T'
end

if @@rowcount = 0 begin
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = 141005
   return 1
end

exec @w_return = cob_pfijo..sp_aplica_impuestos
@s_ofi              = @s_ofi,
@t_debug            = @t_debug,
@i_ente             = @w_ente,
@i_plazo            = @w_num_dias,
@i_capital          = @w_monto,
@i_interes          = @w_total_int_estimado,
@i_base_calculo     = @w_base_calculo,
@o_retienimp        = @w_retienimp      out,
@o_tasa_retencion   = @w_tasa_retencion out,
@o_valor_retencion  = @w_valor_retenido out

if @w_return <> 0 begin
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = @w_return
   return @w_return
end

select @w_usadeci = mo_decimales
from   cobis..cl_moneda
where  mo_moneda = @w_moneda

if @w_usadeci = 'S' begin
   select @w_numdeci  = isnull (pa_tinyint,0)
   from   cobis..cl_parametro
   where  pa_nemonico = 'DCI'
   and    pa_producto = 'PFI'
end
else
   select @w_numdeci = 0

select
@w_mantiene_stock  = td_mantiene_stock,
@w_tipo_persona    = td_tipo_persona,
@w_tipo_tasa_var   = td_tipo_tasa_var,
@w_tipo_deposito   = td_tipo_deposito
from  pf_tipo_deposito
where td_mnemonico = @w_toperacion

select
@w_monto_pg_int      = @w_monto,
@w_monto_pgdo        = 0,
@w_monto_blq         = 0,
@w_int_ganado        = 0,
@w_int_pagados       = 0,
@w_int_provision     = 0,
@w_total_int_ganados = 0,
@w_total_int_pagados = 0,
@w_historia          = 1,
@w_tasa_mer          = 0,
@w_duplicados        = 99,
@w_renovaciones      = 0,
@w_incremento        = 0,
@w_estado            = 'ING',
@w_pignorado         = 'N',
@w_retenido          = 'N',
@w_totalizado        = 'N',
@w_causa_mod         = 'NULL',
@w_total_retencion   = 0,
@w_fecha_ult_pg_int  = @w_fecha_valor,
@w_numdoc            = 0,
@w_imp_base          = 0

select @w_mon_sgte = 1

if @i_renovaut = 'S' begin
   select @w_accion_sgte = 'XREN'
end
else begin
   if @i_cancelaut = 'S' begin
      select
	  @w_accion_sgte = 'XCAN',
      @w_mon_sgte = 2
   end
   else begin
      select @w_accion_sgte = 'NULL'
   end
end

if @i_fecha_crea is null
   select @w_p_fecha_crea = @s_date
else
   select @w_p_fecha_crea = @i_fecha_crea

if (@w_flag_tasaefec = 'N') and (@w_tasa_variable = 'N') begin
   select @w_tasa_mer = ta_tasa_mer
   from   pf_tasa
   where  ta_tipo_deposito =  @w_toperacion
   and    ta_tipo_monto    =  @w_tipo_monto
   and    ta_tipo_plazo    =  @w_tipo_plazo
   
   if @@rowcount = 0 begin
      exec cobis..sp_cerror
	  @t_debug = @t_debug,
	  @t_file  = @t_file,
	  @t_from  = @w_sp_name,
	  @i_num   = 141055
      return 1
   end
end
else begin
   select @w_tasa_mer = @w_tasa
end

select @w_tasa_mer = @w_tasa_base

if @t_trn = 14916
   select @w_historia = @i_historia

begin tran

select @w_historia_fin = @w_historia + 1

if @i_renovaut = 'S'
   select @w_historia_fin = @w_historia_fin + 1

if @i_cancelaut = 'S'
   select @w_historia_fin = @w_historia_fin + 1

if @i_operacion = 'I' or @i_operacion = 'U' or (@i_operacion = 'R' and @i_estado = 'VEN') begin

   select @w_telefono   = te_valor
   from   cobis..cl_telefono
   where  te_ente       = @w_ente
   and    te_direccion  = 1
   and    te_secuencial = 1
   
   if @@rowcount = 0
      select @w_telefono = '000000'

   if @w_porc_comision > 0 begin
      select @w_comision = ((@w_porc_comision/100) * @w_monto *  @w_num_dias)/360
      select @w_comision = round(@w_comision, @w_numdeci)
   end
   else begin
      select @w_comision = 0
   end

   select @w_mon                = round(@w_monto, @w_numdeci)
   select @w_monto_pg_int       = round(@w_monto_pg_int, @w_numdeci)
   select @w_monto_pgdo         = round(@w_monto_pgdo, @w_numdeci)
   select @w_monto_blq          = round(@w_monto_blq, @w_numdeci)
   select @w_int_ganado         = round(@w_int_ganado, @w_numdeci)
   select @w_int_estimado       = round(@w_int_estimado, @w_numdeci)
   select @w_int_pagados        = round(@w_int_pagados, @w_numdeci)
   select @w_int_provision      = round(@w_int_provision, @w_numdeci)
   select @w_total_int_ganados  = round(@w_total_int_ganados, @w_numdeci)
   select @w_total_int_pagados  = round(@w_total_int_pagados, @w_numdeci)
   select @w_incremento         = round(@w_incremento, @w_numdeci)
   select @w_total_int_estimado = round(@w_total_int_estimado, @w_numdeci)
   select @i_monto_base         = round(@i_monto_base,@w_numdeci)
   
   select @w_ced_ruc = en_ced_ruc
   from   cobis..cl_ente
   where  en_ente = @w_ente

   insert into pf_operacion(
   op_num_banco,               op_operacion,                   op_ente,                 op_toperacion,
   op_categoria,               op_producto,                    op_oficina,              op_moneda,
   op_num_dias,                op_monto,                       op_monto_pg_int,         op_monto_pgdo,
   op_monto_blq,               op_tasa,                        op_int_ganado,           op_int_estimado,
   op_int_pagados,             op_int_provision,               op_total_int_ganados,    op_total_int_pagados,
   op_incremento,              op_total_int_estimado,          op_ppago,                op_dia_pago,
   op_historia,                op_duplicados,                  op_renovaciones,         op_estado,
   op_pignorado,               op_oficial,                     op_descripcion,          op_fecha_valor,
   op_fecha_ven,               op_fecha_pg_int,                op_fecha_ult_pg_int,     op_fecha_crea,
   op_fecha_mod,               op_fecha_ingreso,               op_totalizado,           op_fecha_total,
   op_tipo_plazo,              op_tipo_monto,                  op_causa_mod,            op_retenido,
   op_total_retencion,         op_retienimp,                   op_tasa_efectiva,        op_accion_sgte,
   op_mon_sgte,                op_tcapitalizacion,             op_fpago,                op_base_calculo,
   op_casilla,                 op_direccion,                   op_residuo,              op_total_int_retenido,
   op_renova_todo,             op_imprime,                     op_puntos,               op_total_int_acumulado,
   op_tasa_mer,                op_telefono,                    op_ced_ruc,              op_moneda_pg,
   op_impuesto,                op_impuesto_capital,            op_retiene_imp_capital,  op_ley,
   op_fecha_real,              op_ult_fecha_cal_tasa,          op_prorroga_aut,         op_num_dias_gracia,
   op_estatus_prorroga,        op_num_prorroga,                op_tasa_variable,        op_mnemonico_tasa,
   op_modalidad_tasa,          op_periodo_tasa,                op_descr_tasa,           op_operador,
   op_spread,                  op_anio_comercial,              op_flag_tasaefec,        op_porc_comision,
   op_comision,                op_cupon,                       op_categoria_cupon,      op_captador,
   op_oficial_principal,       op_oficial_secundario,          op_origen_fondos,        op_proposito_cuenta,
   op_producto_bancario1,      op_producto_bancario2,          op_dias_reales,          op_tipo_tasa_var,
   op_plazo_orig,              op_ente_corresp,                op_aprobado,             op_localizado,
   op_fecha_localizacion,      op_fecha_no_localiza,           op_dias_hold,            op_sucursal,
   op_oficina_apertura,        op_oficial_apertura,            op_toperacion_apertura,  op_tipo_plazo_apertura,
   op_tipo_monto_apertura,     op_amortiza_periodo,            op_fideicomiso,          op_ica,
   op_desmaterializa)
   values(
   @w_num_banco,               @w_operacionpf,                 @w_ente,                 @w_toperacion,
   @w_categoria,               14,                             @w_oficina,              @w_moneda,
   @w_num_dias,                @w_mon,                         @w_monto_pg_int,         @w_monto_pgdo,
   @w_monto_blq,               @w_tasa,                        @w_int_ganado,           @w_int_estimado,
   @w_int_pagados,             @w_int_provision,               @w_total_int_ganados,    @w_total_int_pagados,
   @w_incremento,              @w_total_int_estimado,          @w_ppago,                @w_dia_pago, --GAR GB-DP00120
   @w_historia_fin,            @w_duplicados,                  @w_renovaciones,         @w_estado,
   @w_pignorado,               @w_oficial,                     @w_descripcion,          @w_fecha_valor,
   @w_fecha_ven,               @w_fecha_pg_int,                @w_fecha_ult_pg_int,     @w_p_fecha_crea,
   @s_date,                    @w_fecha_ing,                   @w_totalizado,           @w_fecha_real_pg,
   @w_tipo_plazo,              @w_tipo_monto,                  @w_causa_mod,            @w_retenido,
   @w_total_retencion,         @w_retienimp,                   @w_tasa_efectiva,        @w_accion_sgte,
   @w_mon_sgte,                @w_tcapitalizacion,             @w_fpago,                @w_base_calculo,
   @w_casilla,                 @w_direccion,                   0,                       0,
   @i_renova_todo,             'N',                            @i_puntos,               0,
   @w_tasa_mer,                @w_telefono,                    @w_ced_ruc,              @i_moneda_pg,
   @w_tasa_imp,                @w_impuesto_capital,            @w_retiene_imp_capital,  @i_ley,
   getdate(),                  @i_fecha_cal_tasa,              @w_prorroga_aut,         @w_num_dias_gracia,
   'N',                        0,                              @w_tasa_variable,        @w_mnemonico_tasa,
   @w_modalidad_tasa,          @w_periodo_tasa,                @w_descr_tasa,           @w_operador,
   @w_spread,                  @w_anio_comercial,              @w_flag_tasaefec,        @w_porc_comision,
   @w_comision,                @w_cupon,                       @w_categoria_cupon,      @w_captador,
   @w_oficial_prin,            @w_oficial_sec,                 @w_origen_fondos,        @w_proposito_cuenta,
   @w_producto_bancario1,      @w_producto_bancario2,          @w_dias_reales,          @w_tipo_tasa_var,
   @w_plazo_orig,              @w_ente_corresp,                'N',                     'S',
   @s_date,                    null,                           @i_dias_hold,            @w_sucursal,
   @w_oficina,                 @w_oficial_prin,                @w_toperacion,           @w_tipo_plazo,
   @w_tipo_monto,              @w_amortiza_per,                @w_fideicomiso,          @w_ret_ica,
   @w_desmaterializa)

   if @@error <> 0 begin
      rollback tran
      exec cobis..sp_cerror
	  @t_debug = @t_debug,
	  @t_file  = @t_file,
      @t_from  = @w_sp_name,
	  @i_num   = 143001
      select @w_return = 1
      goto borra
   end

   insert into pf_operacion_his(
   oh_num_banco,           oh_operacion,          oh_retienimp,             oh_tasa,
   oh_base_calculo,        oh_categoria,          oh_num_dias,              oh_tcapitalizacion,
   oh_oficial_secundario,  oh_fecha_valor,        oh_int_estimado,          oh_total_int_estimado,
   oh_fecha_ven,           oh_fecha_ult_pg_int,   oh_tasa_efectiva,         oh_tasa_mer,
   oh_int_ganado,          oh_total_int_ganados,  oh_ente_corresp,          oh_descripcion,
   oh_fecha_pg_int,        oh_localizado,         oh_fecha_localizacion ,   oh_fecha_no_localiza,
   oh_puntos,              oh_spread,             oh_operador,              oh_casilla,
   oh_direccion,           oh_sucursal,           oh_fpago,                 oh_ppago,
   oh_dia_pago,            oh_dias_reales,        oh_instruccion_especial,  oh_oficina,
   oh_oficial,             oh_monto,              oh_fideicomiso)
   values(
   @w_num_banco,           @w_operacionpf,        @w_retienimp,             @w_tasa,
   @w_base_calculo,        @w_categoria,          @w_num_dias,              @w_tcapitalizacion,
   @w_oficial_sec,         @w_fecha_valor,        @w_int_estimado,          @w_total_int_estimado,
   @w_fecha_ven,           @w_fecha_ult_pg_int,   @w_tasa_efectiva,         @w_tasa_mer,
   @w_int_ganado,          @w_total_int_ganados,  @w_ente_corresp,          @w_descripcion,
   @w_fecha_pg_int,        'S',                   @s_date,                  null,
   @i_puntos,              @w_spread,             @w_operador,              @w_casilla,
   @w_direccion,           @w_sucursal,           @w_fpago,                 @w_ppago,
   @w_dia_pago,            @w_dias_reales,        @i_instruccion_especial,  @w_oficina,
   @w_oficial,             @w_mon,                @w_fideicomiso)

   if @@error <> 0 begin
      rollback tran
      exec cobis..sp_cerror
	  @t_debug = @t_debug,
	  @t_file  = @t_file,
      @t_from  = @w_sp_name,
	  @i_num   = 143001
      select @w_return = 1
      goto borra
   end

   insert pf_rubro_op(
   ro_num_banco,   ro_operacion,       ro_concepto,      ro_mnemonico_tasa,
   ro_operador,    ro_modalidad_tasa,  ro_periodo_tasa,  ro_toperacion,
   ro_moneda,      ro_tipo_monto,      ro_tipo_plazo,    ro_descr_tasa,
   ro_spread,      ro_valor)
   select
   rot_num_banco,  rot_operacion,      rot_concepto,     rot_mnemonico_tasa,
   rot_operador,   rot_modalidad_tasa, rot_periodo_tasa, rot_toperacion,
   rot_moneda,     rot_tipo_monto,     rot_tipo_plazo,   rot_descr_tasa,
   rot_spread,     rot_valor
   from  pf_rubro_op_tmp
   where rot_usuario   = @s_user
   and   rot_sesion    = @s_sesn
   and   rot_num_banco = @w_num_banco
   
   if @t_from = 'sp_mod_op_definitiva' begin
      select
	  @w_tip_operacion = 'U',
      @w_tran          = 1423
   end
   else begin
      select
	  @w_tip_operacion = 'I',
      @w_tran          = 1421
   end
   
   if @i_instruccion_especial is not null begin
      if exists(select 1 from pf_instruccion where in_operacion = @w_operacionpf and isnull(in_estadoxren,'N') = 'N') begin
         update pf_instruccion
         set    in_instruccion = @i_instruccion_especial,
                in_fecha_mod   = @s_date
         where  in_operacion   = @w_operacionpf
		 and    isnull(in_estadoxren,'N') = 'N'
		 
		 if @@error <> 0 begin
            exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
            @t_from  = @w_sp_name,
			@i_num   = 145045
            select @w_return = 1
			goto borra
         end
		 
		 insert into ts_instruccion (
		 secuencial,      tipo_transaccion,         clase,   fecha,
         usuario,         terminal,                 srv,     lsrv,
         operacion,       instruccion)
         values(
		 @s_ssn,          14238,                    'N',     @s_date,
         @s_user,         @s_term,                  @s_srv,  @s_lsrv,
         @w_operacionpf,  @i_instruccion_especial)
		 
		 if @@error <> 0  begin
            exec cobis..sp_cerror
            @t_debug       = @t_debug,
            @t_file        = @t_file,
            @t_from        = @w_sp_name,
            @i_num         = 143005
            select @w_return = 1
            goto borra
         end
      end
	  else begin
         insert pf_instruccion(
		 in_operacion,   in_instruccion,          in_estadoxren,
		 in_fecha_crea,  in_fecha_mod)
         values(
		 @w_operacionpf, @i_instruccion_especial, 'N',
		 @s_date,        @s_date)
		 
		 if @@error <> 0 begin
            exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
            @t_from  = @w_sp_name,
			@i_num   = 143053
            select @w_return = 1
            goto borra
         end
		 
		 insert into ts_instruccion (
		 secuencial,      tipo_transaccion,         clase,   fecha,
         usuario,         terminal,                 srv,     lsrv,
         operacion,       instruccion)
         values(
		 @s_ssn,          14151,                    'N',     @s_date,
         @s_user,         @s_term,                  @s_srv,  @s_lsrv,
         @w_operacionpf,  @i_instruccion_especial)
		 
		 if @@error <> 0 begin
		    exec cobis..sp_cerror
            @t_debug       = @t_debug,
            @t_file        = @t_file,
            @t_from        = @w_sp_name,
            @i_num         = 143005
            select @w_return = 1
            goto borra
         end
      end
   end
   
   insert pf_historia(
   hi_operacion,   hi_secuencial,   hi_fecha,    hi_trn_code,
   hi_valor,       hi_funcionario,  hi_oficina,  hi_fecha_crea,
   hi_fecha_mod)
   values (
   @w_operacionpf, @w_historia,     @s_date,     @t_trn,
   @w_monto,       @s_user,         @w_oficina,  @s_date,
   @s_date)
   
   if @@error <> 0 begin
      exec cobis..sp_cerror
	  @t_debug = @t_debug,
	  @t_file  = @t_file,
      @t_from  = @w_sp_name,
	  @i_num   = 143006
      select @w_return = 1
      goto borra
   end
   
   select @w_historia = @w_historia + 1
   
   if convert(datetime,@w_fecha_valor,101) < convert(datetime,@s_date,101) begin
      if @i_autorizado is not null begin
         insert pf_autorizacion(
		 au_operacion,    au_autoriza,    au_oficina, au_tautorizacion,
         au_fecha_crea,   au_num_banco,   au_oficial)
         values (
		 @w_operacionpf,  @i_autorizado,  @s_ofi,     'BACK',
         @s_date,         @i_cuenta,      @s_user)
            
         if @@error <> 0 begin
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 143040
            select @w_return = 1
            goto borra
         end
      end
   end
   
   if @i_autoriza_pago_otros is not null begin
      insert pf_autorizacion (
	  au_operacion  , au_autoriza           , au_oficina, au_tautorizacion,
      au_fecha_crea , au_num_banco          , au_oficial)
      values (
	  @w_operacionpf, @i_autoriza_pago_otros, @s_ofi    , 'PGOC',
      @s_date       , @i_cuenta             , @s_user)

	  if @@error <> 0 begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
		 @i_num   = 143040
         select @w_return = 1
         goto borra
      end
   end
   
   if @i_puntos > 0 begin
      insert pf_autorizacion (
	  au_operacion  , au_autoriza  , au_oficina, au_tautorizacion,
      au_fecha_crea , au_num_banco , au_oficial)
      values (
	  @w_operacionpf, @s_user,       @s_ofi    , 'ASP',
      @s_date       , @i_cuenta    , @s_user)

	  if @@error <> 0 begin
         exec cobis..sp_cerror
		 @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name, @i_num   = 143040
         select @w_return = 1
         goto borra
         end
      end
	  
      exec cobis..sp_cseqnos
	  @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_tabla     = 'cl_det_producto',
      @o_siguiente = @w_siguiente out

      select @w_comentario = 'APERTURA DE CERTIFICADO DPF'

      insert into cobis..cl_det_producto (
	  dp_cliente_ec, dp_direccion_ec, dp_det_producto, dp_filial,
      dp_oficina   , dp_producto    , dp_tipo        , dp_moneda,
      dp_fecha     , dp_comentario  , dp_monto       , dp_tiempo,
      dp_cuenta    , dp_estado_ser  , dp_autorizante , dp_oficial_cta)
      values (
	  @w_ente      , @w_direccion   , @w_siguiente   ,     1    ,
      @s_ofi       , 14             , 'R'            , @w_moneda,
      @s_date      , @w_comentario  , @w_monto       , @w_num_dias,
      @w_num_banco , 'V'            , @w_num_oficial , @w_num_oficial)

      if @@error <> 0 begin
         exec cobis..sp_cerror
		 @t_debug = @t_debug,
		 @t_file  = @t_file,
         @t_from  = @w_sp_name,
		 @i_num   = 703027
         select @w_return = 1
         goto borra
      end
   end

   select @w_bt_ente = 0
   
   while 1 = 1 begin
      set rowcount 1
      select
	  @w_bt_ente         = bt_ente,
      @w_bt_rol          = bt_rol,
      @w_bt_fecha_crea   = bt_fecha_crea,
      @w_bt_fecha_mod    = bt_fecha_mod,
      @w_bt_tipo         = bt_tipo,
      @w_bt_condicion    = bt_condicion,
      @w_bt_secuencia    = bt_secuencia
      from pf_beneficiario_tmp
      where bt_usuario   = @s_user
      and bt_sesion      = @s_sesn
      and bt_ente        > @w_bt_ente
      and bt_operacion   = @w_operacionpf
	  order by bt_ente
	  
      if @@rowcount = 0
         break

      if @t_debug = 'S'
	     print 'INSOP w_bt_ente ' + cast(@w_bt_ente as varchar)

      set rowcount 0
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
      @i_cuenta      = @w_num_banco,
      @i_ente        = @w_bt_ente,
      @i_rol         = @w_bt_rol,
      @i_estado_xren = @w_estado_xren,
      @i_tipo        = @w_bt_tipo,
      @i_condicion   = @w_bt_condicion,
      @i_secuencia   = @w_bt_secuencia
	  
      if @w_return <> 0 begin
         select @w_return = 1
         goto borra
      end
      else begin
         update pf_operacion_his
         set    oh_ente        = op_ente,
                oh_descripcion = op_descripcion,
                oh_direccion   = op_direccion,
                oh_telefono    = op_telefono
         from   pf_operacion, pf_operacion_his
         where  op_operacion   = oh_operacion
         and    op_operacion   = @w_operacionpf
      end
	  
	  select @w_ced_ruc = en_ced_ruc
      from   cobis..cl_ente
      where  en_ente = @w_bt_ente
	  
	  if @w_ced_ruc is null
	     select @w_ced_ruc = p_pasaporte
         from   cobis..cl_ente
         where  en_ente = @w_bt_ente

      if @t_debug = 'S' print 'INSOP w_bt_ente ' + cast(@w_bt_ente as varchar)
      if @t_debug = 'S' print 'INSOP w_siguiente ' + cast(@w_siguiente as varchar)
      if @t_debug = 'S' print 'INSOP w_bt_rol ' + cast(@w_bt_rol as varchar)
      if @t_debug = 'S' print 'INSOP w_bt_tipo ' + cast(@w_bt_tipo as varchar)

      if @w_bt_tipo = 'T' begin
	     insert cobis..cl_cliente(
		 cl_cliente,  cl_det_producto, cl_rol   , cl_ced_ruc,  cl_fecha)
		 values (
		 @w_bt_ente,  @w_siguiente   , @w_bt_rol, @w_ced_ruc,  @s_date)

         if @@error <> 0 begin
            exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
            @t_from  = @w_sp_name,
			@i_num   = 703028
            select @w_return = 1
            goto borra
         end
      end
   end

   set rowcount 0
   exec @w_return = cob_pfijo..sp_gen_ticket
   @t_debug       = @t_debug,
   @t_file        = @t_file,
   @t_from        = @w_sp_name,
   @i_oficina     = @s_ofi,
   @o_secuencial  = @w_sec_ticket out
   select @o_sec_ticket = @w_sec_ticket

   if @i_secuencia is null
      select @w_sec = 0
   else
      select @w_sec = @i_secuencia
	  
   delete pf_secuen_ticket
   where  st_operacion = @w_operacionpf

   select
   @w_mt_sub_secuencia = 0,
   @w_total_monet      = 0,
   @w_max_ttransito    = 0

   while 2 = 2 begin
      set rowcount 1
      select
	  @w_mt_sub_secuencia       = mt_sub_secuencia,
      @w_mt_producto            = mt_producto,
      @w_mt_cuenta              = mt_cuenta,
      @w_mt_valor               = mt_valor,
      @w_mt_tipo                = mt_tipo,
      @w_mt_beneficiario        = mt_beneficiario,
      @w_mt_impuesto            = mt_impuesto,
      @w_mt_moneda              = mt_moneda,
      @w_mt_valor_ext           = mt_valor_ext,
      @w_mt_fecha_crea          = mt_fecha_crea,
      @w_mt_fecha_mod           = mt_fecha_mod,
      @w_mt_impuesto_capital_me = mt_impuesto_capital_me,
      @w_mt_tipo_cliente        = mt_tipo_cliente,
      @w_mt_autorizado          = mt_autorizado,
      @w_mt_cotizacion          = mt_cotizacion,
      @w_mt_tipo_cotiza         = mt_tipo_cotiza,
      @w_mt_ttransito           = mt_ttransito,
      @w_mt_cta_corresp         = mt_cta_corresp,
      @w_mt_cod_corresp         = mt_cod_corresp,
      @w_mt_benef_corresp       = mt_benef_corresp,
      @w_mt_ofic_corresp        = mt_ofic_corresp,
      @w_mt_tipo_cuenta_ach     = mt_tipo_cuenta_ach,
      @w_mt_oficina_dest        = mt_oficina,
      @w_mt_cod_banco_ach       = mt_cod_banco_ach
	  from  pf_mov_monet_tmp
	  where mt_usuario          = @s_user
      and   mt_sesion           = @s_sesn
      and   mt_sub_secuencia    > @w_mt_sub_secuencia
      and   mt_operacion        = @w_operacionpf
	  
	  if @@rowcount = 0
	     break

      set rowcount 0

      insert pf_mov_monet(
	  mm_operacion         , mm_secuencia             , mm_secuencial      , mm_sub_secuencia,
      mm_producto          , mm_cuenta                , mm_tran            , mm_valor,
      mm_tipo              , mm_beneficiario          , mm_impuesto        , mm_moneda,
      mm_valor_ext         , mm_fecha_crea            , mm_fecha_mod       , mm_estado,
      mm_fecha_aplicacion  , mm_impuesto_capital_me   , mm_user            , mm_tipo_cliente,
      mm_autorizado        , mm_cotizacion            , mm_tipo_cotiza     , mm_ttransito,
      mm_cta_corresp       , mm_cod_corresp           , mm_benef_corresp   , mm_ofic_corresp,
      mm_usuario           , mm_fecha_valor           , mm_oficina_pago    , mm_oficina,
      mm_tipo_cuenta_ach   , mm_cod_banco_ach)
      values (
	  @w_operacionpf       , @w_sec                   , 0                  , @w_mt_sub_secuencia,
      @w_mt_producto       , @w_mt_cuenta             , 14901              , @w_mt_valor,
      @w_mt_tipo           , @w_mt_beneficiario       , @w_mt_impuesto     , @w_mt_moneda,
      @w_mt_valor_ext      , @s_date                  , @s_date            , null,
      null                 , @w_mt_impuesto_capital_me, @s_user            , @w_mt_tipo_cliente,
      @w_mt_autorizado     , @w_mt_cotizacion         , @w_mt_tipo_cotiza  , @w_mt_ttransito,
      @w_mt_cta_corresp    , @w_mt_cod_corresp        , @w_mt_benef_corresp, @w_mt_ofic_corresp,
      @s_user              , @w_fecha_valor           , @w_mt_oficina_dest , @w_mt_oficina_dest,
      @w_mt_tipo_cuenta_ach, @w_mt_cod_banco_ach)
	  
      if @@error <> 0 begin
         exec cobis..sp_cerror
		 @t_debug = @t_debug,
		 @t_file  = @t_file,
         @t_from  = @w_sp_name,
		 @i_num   =  143021
		 select @w_return = 1
         goto borra
      end

      insert into ts_mov_monet (
	  secuencial        , tipo_transaccion, clase       , fecha,
      usuario           , terminal        , srv         , lsrv,
      operacion         , transaccion     , secuencia   , sub_secuencia,
      producto          , cuenta          , valor       , tipo,
      beneficiario      , impuesto        , moneda      , valor_ext,
      fecha_crea        , fecha_mod       , estado)
      values(
	  @s_ssn            , @t_trn          , 'N'         , @s_date,
      @s_user           , @s_term         , @s_srv      , @s_lsrv,
      @w_operacionpf    , @t_trn          , @w_sec      , @w_mt_sub_secuencia,
	  @w_mt_producto    , @w_mt_cuenta    , @w_mt_valor , @w_mt_tipo,
	  @w_mt_beneficiario, @w_mt_impuesto  , @w_mt_moneda, @w_mt_valor_ext,
      @s_date           , @s_date         , null)
	  
	  if @@error <> 0 begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 143005
		 select @w_return = 1
         goto borra
      end
	  
	  if @w_mt_ttransito > @w_max_ttransito
         select @w_max_ttransito = @w_mt_ttransito
		 
      select @w_producto = 'CHQL'
		 
      while 1 = 1 begin
	     select
		 @w_ct_sub_secuencia = ct_secuencial,
         @w_ct_banco         = ct_banco,
         @w_ct_cuenta        = ct_cuenta,
         @w_ct_cheque        = ct_cheque,
         @w_ct_valor         = ct_valor,
         @w_ct_descripcion   = ct_descripcion,
         @w_ct_nombre_banco  = ct_nombre_banco
         from  pf_det_cheque_tmp
         where ct_usuario    = @s_user
         and   ct_sesion     = @s_sesn
         and   ct_operacion  = @w_operacionpf
         and   ct_secuencial = @w_mt_sub_secuencia
         order by ct_secuencial
		 
		 if @@rowcount = 0
		    break

         set rowcount 0

         insert  pf_emision_cheque (
		 ec_operacion  , ec_secuencia     , ec_sub_secuencia   , ec_secuencial,
         ec_moneda     , ec_descripcion   , ec_tipo            , ec_tran    ,
         ec_banco      , ec_cuenta        , ec_numero          , ec_valor,
         ec_fecha_crea , ec_fecha_mod     , ec_fecha_emision   , ec_fecha_mov,
         ec_estado     , ec_fpago         , ec_nombre_banco)
         values (
		 @w_operacionpf, 0                , @w_mt_sub_secuencia, @s_ssn,
         @w_mt_moneda  , @w_ct_descripcion, 'B'                , 14901,
         @w_ct_banco   , @w_ct_cuenta     , @w_ct_cheque       , @w_ct_valor,
         @s_date       , @s_date          , null               , @s_date,
         --'A'         , @w_mt_producto   , @w_ct_nombre_banco) 
		 'A'           , @w_producto      , @w_ct_nombre_banco)

         if @@rowcount <> 1 begin
            exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   =  143031
            return 1
         end
		 
         delete pf_det_cheque_tmp
		 where  ct_usuario    = @s_user
         and    ct_sesion     = @s_sesn
         and    ct_operacion  = @w_operacionpf
         and    ct_secuencial = @w_mt_sub_secuencia
         and   (ct_banco      = @w_ct_banco         or @w_ct_banco is null)
         and   (ct_cuenta     = @w_ct_cuenta        or @w_ct_cuenta is null)
         and   (ct_cheque     = @w_ct_cheque        or @w_ct_cheque is null)
      end

      set rowcount 0
      select @w_total_monet  = @w_total_monet + @w_mt_valor
	  select @w_mt_valor     = @w_mt_valor + @w_mt_impuesto
      select @w_mt_valor_ext = @w_mt_valor_ext + @w_mt_impuesto_capital_me

      if @w_mt_tipo = 'B' begin
	     insert into pf_secuen_ticket (
		 st_num_banco   , st_operacion  , st_secuencial, st_secuencia,
         st_fpago       , st_valor      , st_estado    , st_moneda,
         st_valor_ext   , st_fecha_crea , st_oficina)
         values (
		 @w_num_banco   , @w_operacionpf, @w_sec_ticket, @w_sec,
         @w_mt_producto , @w_mt_valor   , 'I'          , @w_mt_moneda,
         @w_mt_valor_ext, @s_date       , @s_ofi)
         
		 if @@error <> 0 begin
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 143045
            select @w_return = 1
            goto borra
         end
      end
   end
   
   set rowcount 0
   
   select @w_sec1 = isnull(max(dp_secuencia),0) + 1
   from   pf_det_pago
   where  dp_operacion = @w_operacionpf

   select @w_pt_beneficiario = 0
   
   if (@i_renovaut='S' and @i_renova_todo='N'  and @w_fpago <> 'ANT') 
      select @w_estado_xren='S'
	  
   select @w_pt_forma_pago = ''
   
   delete pf_det_pago_tmp
   where  dt_usuario   = @s_user
   and    dt_sesion    = @s_sesn
   and    (dt_operacion = @w_operacionpf or @w_operacionpf is null)
   and    dt_tipo       = 'VUL'

   while 6=6 begin
      set rowcount 1
      select
	  @w_pt_beneficiario     = dt_beneficiario,
      @w_pt_tipo             = dt_tipo,
      @w_pt_forma_pago       = dt_forma_pago,
      @w_pt_cuenta           = dt_cuenta,
      @w_pt_monto            = dt_monto,
      @w_pt_porcentaje       = dt_porcentaje,
      @w_pt_fecha_crea       = dt_fecha_crea,
      @w_pt_fecha_mod        = dt_fecha_mod,
      @w_pt_moneda_pago      = dt_moneda_pago,
      @w_pt_descripcion      = dt_descripcion,
      @w_pt_oficina          = dt_oficina,
      @w_pt_tipo_cliente     = dt_tipo_cliente,
      @w_pt_secuencia        = dt_secuencia,
      @w_pt_tipo_cuenta_ach  = dt_tipo_cuenta_ach,
      @w_pt_cod_banco_ach    = dt_cod_banco_ach,
      @w_benef_chq           = dt_benef_chq
      from  pf_det_pago_tmp
      where dt_usuario       = @s_user
      and   dt_sesion        = @s_sesn
      and   dt_operacion     = @w_operacionpf
	  and  (dt_beneficiario >= @w_pt_beneficiario or (dt_beneficiario = @w_pt_beneficiario and dt_forma_pago <> @w_pt_forma_pago))
      order by dt_beneficiario

      if @@rowcount = 0
         break

      set rowcount 0
      select @w_pt_monto = round(@w_pt_monto,@w_numdeci)

      insert pf_det_pago (
	  dp_operacion         , dp_ente            , dp_tipo       , dp_secuencia,
      dp_forma_pago        , dp_cuenta          , dp_monto      , dp_porcentaje,
      dp_fecha_crea        , dp_fecha_mod       , dp_estado_xren, dp_estado,
      dp_moneda_pago       , dp_descripcion     , dp_oficina    , dp_tipo_cliente,
      dp_tipo_cuenta_ach   , dp_cod_banco_ach   ,dp_benef_chq)
      values(
	  @w_operacionpf       , @w_pt_beneficiario , @w_pt_tipo    , @w_sec1,
      @w_pt_forma_pago     , @w_pt_cuenta       , @w_pt_monto   , @w_pt_porcentaje,
      @s_date              , @s_date            , @w_estado_xren, 'I',
      @w_pt_moneda_pago    , @w_pt_descripcion  , @w_pt_oficina , @w_pt_tipo_cliente,
      @w_pt_tipo_cuenta_ach, @w_pt_cod_banco_ach, @w_benef_chq) 

      if @@error <> 0 begin
         exec cobis..sp_cerror
		 @t_debug = @t_debug,
		 @t_file  = @t_file,
         @t_from  = @w_sp_name,
		 @i_num   =  143038
         select @w_return = 1
         goto borra
      end

      insert into ts_det_pago (
	  secuencial    , tipo_transaccion  , clase           , fecha,
      usuario       , terminal          , srv             , lsrv,
      operacion     , ente              , tipo            , forma_pago,
      cuenta,monto  , porcentaje        , fecha_crea      , fecha_mod,
      moneda_pago)
      values  (
	  @s_ssn        , @t_trn            , 'N'             , @s_date,
      @s_user       , @s_term           , @s_srv          , @s_lsrv,
      @w_operacionpf, @w_pt_beneficiario, @w_pt_tipo      , @w_pt_forma_pago,
      @w_pt_cuenta  , @w_pt_monto       , @w_pt_porcentaje, @s_date,
      @s_date       , @w_pt_moneda_pago)
	  
	  if @@error <> 0 begin
         exec cobis..sp_cerror
         @t_debug       = @t_debug,
         @t_file        = @t_file,
         @t_from        = @w_sp_name,
         @i_num         = 143005
         select @w_return = 1
         goto borra
      end
	  
	  set rowcount 1
      if @i_renovaut = 'S' and @w_fpago = 'ANT' begin
         select @w_sec1 = @w_sec1 + 1

         insert pf_det_pago (
	     dp_operacion         , dp_ente            , dp_tipo           , dp_secuencia,
         dp_forma_pago        , dp_cuenta          , dp_monto          , dp_porcentaje,
         dp_fecha_crea        , dp_fecha_mod       , dp_estado_xren    , dp_estado,
         dp_moneda_pago       , dp_descripcion     , dp_oficina        , dp_tipo_cliente,
         dp_tipo_cuenta_ach   , dp_cod_banco_ach   , dp_benef_chq)
         values (
	     @w_operacionpf       , @w_pt_beneficiario , @w_pt_tipo        , @w_sec1,
         @w_pt_forma_pago     , @w_pt_cuenta       , @w_pt_monto       , @w_pt_porcentaje,
         @s_date              , @s_date            , 'S'               , 'A',
         @w_pt_moneda_pago    , @w_pt_descripcion  , @w_pt_oficina     , @w_pt_tipo_cliente,
         @w_pt_tipo_cuenta_ach, @w_pt_cod_banco_ach, @w_benef_chq)
	  
         if @@error <> 0 begin
            exec cobis..sp_cerror
            @t_debug  = @t_debug,
            @t_file   = @t_file,
            @t_from   = @w_sp_name,
			@i_num    = 143038
            select @w_return = 1
            goto borra
         end
      end 
   
      delete pf_det_pago_tmp
      where  dt_usuario      = @s_user
      and    dt_sesion       = @s_sesn
      and    dt_beneficiario = @w_pt_beneficiario
      and    dt_operacion    = @w_operacionpf
      and    dt_forma_pago   = @w_pt_forma_pago
      and   (dt_cuenta       = @w_pt_cuenta       or @w_pt_cuenta is null)
      and   (dt_tipo         = @w_pt_tipo         or @w_pt_tipo is null)
      and   (dt_porcentaje   = @w_pt_porcentaje   or @w_pt_porcentaje is null)
      
      if @@error <> 0 begin
         exec cobis..sp_cerror
         @t_debug       = @t_debug,
         @t_file        = @t_file,
         @t_from        = @w_sp_name,
         @i_num         = 145005
         select @w_return = 1
         goto borra
      end
   
      set rowcount 0
      select @w_sec1 = @w_sec1 + 1
   end
   
   select @w_ente = op_ente
   from   pf_operacion
   where  op_num_banco = @i_cuenta

   if @i_renovaut = 'S' begin
      insert pf_renovacion (
	  re_operacion  , re_renovacion , re_incremento, re_tasa,
      re_plazo      , re_monto      , re_oficina   , re_oficial,
      re_renova_todo, re_fecha_valor, re_fecha_crea, re_fecha_mod,
      re_estado     , re_impuesto   , re_tot_int)
      values (
	  @w_operacionpf, 1             , 0            , 0,
      @w_num_dias   , @w_monto      , @s_ofi       , @s_user,
      @i_renova_todo, @w_fecha_ven  , @s_date      , @s_date,
      'I'           , 0             , 0)

      if @@error <> 0 begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 143004
         select @w_return = 1
      end

      insert pf_historia (
	  hi_operacion  , hi_secuencial , hi_fecha  , hi_trn_code,
      hi_valor      , hi_funcionario, hi_oficina, hi_fecha_crea,
      hi_fecha_mod)
      values(
	  @w_operacionpf, @w_historia   , @s_date   , 14104,
      @w_monto      , @s_user       , @s_ofi    , @s_date,
      @s_date)
      
	  if @@error <> 0 begin
         exec cobis..sp_cerror
		 @t_debug = @t_debug,
		 @t_file  = @t_file,
         @t_from  = @w_sp_name,
		 @i_num   =  143006
         return 1
      end
      select @w_historia = @w_historia  +1
   end

   if @i_cancelaut = 'S'
   begin
      insert pf_cancelacion (
	  ca_operacion  , ca_funcionario , ca_oficina          , ca_pen_monto,
      ca_pen_porce  , ca_secuencial  , ca_solicitante      , ca_tipo,
      ca_estado     , ca_comentario  , ca_fecha_crea       , ca_fpago,
      ca_fecha_ven  , ca_fecha_pg_int, ca_accion_sgte      , ca_estado_op,
      ca_autorizado , ca_fecha_mod   , ca_valor            , ca_monto_pg_int,
      ca_int_ganado , ca_int_pagados , ca_total_int_pagados, ca_fecha_ult_pg_int)
      values (
	  @w_operacionpf, @s_user        , @s_ofi              , 0,
      0             , 1              , @w_ente             , 'N',
      'I'           , null           , @s_date             , @w_fpago,
      @w_fecha_ven  , @w_fecha_pg_int, @w_accion_sgte      , @w_estado,
      @s_user       , @s_date        , @w_monto            , 0,
      0             , 0              , 0                   , @s_date)

	  if @@error <> 0 begin
         exec cobis..sp_cerror
		 @t_debug = @t_debug,
		 @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 143039
         return 1
      end

      insert pf_historia (
	  hi_operacion  , hi_secuencial , hi_fecha  , hi_trn_code,
      hi_valor      , hi_funcionario, hi_oficina, hi_fecha_crea,
      hi_fecha_mod)
      values (
      @w_operacionpf, @w_historia   , @s_date   , 14140,
      @w_monto      , @s_user       , @s_ofi    , @s_date,
      @s_date)

	  if @@error <> 0 begin
         exec cobis..sp_cerror
		 @t_debug = @t_debug,
		 @t_file  = @t_file,
         @t_from  = @w_sp_name,
		 @i_num   = 143006
         return 1
      end
      select @w_historia = @w_historia  +1
   end

   -------------------------------------
   -- Calculo ponderado de Tasa y Plazo
   -------------------------------------
   declare cursor_renovacion cursor
   for
   select
   mm_cuenta   , mm_sub_secuencia   , mm_moneda             , mm_valor,
   mm_valor_ext, mm_impuesto        , mm_impuesto_capital_me
   from  cob_pfijo..pf_mov_monet
   where mm_operacion = @w_operacionpf
   and   mm_tran      = 14901
   and   mm_producto  = 'REN'
   for read only

   open cursor_renovacion
   fetch cursor_renovacion into
   @w_mm_cuenta   , @w_mm_sub_secuencia, @w_mm_moneda          , @w_mm_valor,
   @w_mm_valor_ext, @w_mm_impuesto     , @w_mm_impuesto_capital_me

   while @@fetch_status = 0 begin
      select
	  @w_mm_operacion    = op_operacion,
      @w_mm_oficina      = op_oficina,
      @w_mm_renovaciones = op_renovaciones
      from  cob_pfijo..pf_operacion
      where op_num_banco = @w_mm_cuenta
	  
	  update cob_pfijo..pf_operacion
	  set    op_renovaciones = @w_mm_renovaciones + 1
	  where  op_num_banco    = @w_mm_cuenta

      if @w_mm_moneda <> @w_moneda_base begin
         select @w_mm_valor    = @w_mm_valor_ext
         select @w_mm_impuesto = @w_mm_impuesto_capital_me
      end

      select @w_mm_total_int_estimado = @w_total_int_estimado / @w_mm_valor
      select @w_mm_total_int_estimado = @w_mm_total_int_estimado * @w_mm_valor

      insert into pf_renovacion(
	  re_operacion            , re_renovacion         , re_incremento      , re_tasa,
      re_plazo                , re_monto              , re_int_vencido     , re_oficial,
      re_estado               , re_fecha_valor        , re_descripcion     , re_fecha_crea,
      re_fecha_mod            , re_operacion_new      , re_oficina_ant     , re_impuesto,
      re_tot_int              , re_moneda_pg          , re_vuelto          , re_oficina,
      re_int_pagados          , re_total_int_pagados  , re_fecha_ult_pg_int, re_fecha_pg_int,
      re_renova_todo)
      values (
	  @w_mm_operacion         , @w_mm_renovaciones + 1, 0                  , @w_tasa,
      @w_num_dias             , @w_mm_valor           , 0                  , @s_user,
      'I'                     , @w_fecha_valor        , @w_descripcion     , @s_date,
      @s_date                 , @w_operacionpf        , @w_mm_oficina      , @w_mm_impuesto,
      @w_mm_total_int_estimado, ''                    , 0                  , @w_oficina ,
      0                       , 0                     , @w_fecha_ult_pg_int, @w_fecha_pg_int,
      'S')

      insert pf_historia (
	  hi_operacion  , hi_secuencial , hi_fecha  , hi_trn_code,
      hi_valor      , hi_funcionario, hi_oficina, hi_fecha_crea,
      hi_fecha_mod)
      values (
	  @w_operacionpf, @w_historia   , @s_date   , 14104,
      @w_mm_valor   , @s_user       , @s_ofi    , @s_date,
      @s_date)

      if @@error <> 0 begin
         exec cobis..sp_cerror
		 @t_debug = @t_debug,
		 @t_file  = @t_file,
         @t_from  = @w_sp_name,
		 @i_num   =  143006
         return 1
      end

      select @w_historia = @w_historia  +1

      fetch cursor_renovacion into
      @w_mm_cuenta   , @w_mm_sub_secuencia, @w_mm_moneda          , @w_mm_valor,
      @w_mm_valor_ext, @w_mm_impuesto     , @w_mm_impuesto_capital_me
   end

   close cursor_renovacion
   deallocate cursor_renovacion

   update pf_operacion
   set    op_historia  = @w_historia
   where  op_operacion = @w_operacionpf
   
   if @i_operacion = 'I'
      select @w_clase = 'N'
   if @i_operacion = 'U' or (@i_operacion = 'R' and @i_estado = 'VEN')
      select @w_clase = 'A'

   if not (@i_operacion = 'R' and @i_estado = 'ACT') begin
      insert ts_operacion (
	  secuencial           , tipo_transaccion  , clase               , usuario,
      terminal             , srv               , lsrv                , fecha,
      num_banco            , operacion         , ente                , toperacion,
      categoria            , producto          , oficina             , moneda,
      num_dias             , monto             , monto_pg_int        , monto_pgdo,
      monto_blq            , tasa              , int_ganado          , int_estimado,
      int_pagados          , int_provision     , total_int_ganados   , total_int_pagados,
      total_int_estimado   , ppago             , dia_pago            , historia,
      incremento           , duplicados        , renovaciones        , estado,
      pignorado            , oficial           , descripcion         , fecha_valor,
      fecha_ven            , fecha_pg_int      , fecha_ult_pg_int    , fecha_crea,
      fecha_mod            , fecha_ingreso     , totalizado          , fecha_total,
      tipo_plazo           , tipo_monto        , causa_mod           , retenido,
      total_retencion      , retienimp         , tasa_efectiva       , accion_sgte,
      mon_sgte             , tcapitalizacion   , fpago               , base_calculo,
      casilla              , direccion         , porc_comision       , comision,
      cupon                , categoria_cupon   , sucursal            , ica)
      values (
	  @s_ssn               , @t_trn            , @w_clase            , @s_user,
      @s_term              , @s_srv            , @s_lsrv             , @s_date,
      @w_num_banco         , @w_operacionpf    , @w_ente             , @w_toperacion,
      @w_categoria         , 14                , @w_oficina          , @w_moneda,
      @w_num_dias          , @w_mon            , @w_monto_pg_int     , @w_monto_pgdo,
      @w_monto_blq         , @w_tasa           , @w_int_ganado       , @w_int_estimado,
      @w_int_pagados       , @w_int_provision  , @w_total_int_ganados, @w_total_int_pagados,
      @w_total_int_estimado, @w_ppago          , @w_dia_pago         , @w_historia,
      @w_incremento        , @w_duplicados     , @w_renovaciones     , @w_estado,
      @w_pignorado         , @w_oficial        , @w_descripcion      , @w_fecha_valor,
      @w_fecha_ven         , @w_fecha_pg_int   , @w_fecha_ult_pg_int , @s_date,
      @s_date              , @w_fecha_ing      , @w_totalizado       , @w_fecha_real_pg,
      @w_tipo_plazo        , @w_tipo_monto     , @w_causa_mod        , @w_retenido,
      @w_total_retencion   , @w_retienimp      , @w_tasa_efectiva    , @w_accion_sgte,
      @w_mon_sgte          , @w_tcapitalizacion, @w_fpago            , @w_base_calculo,
      @w_casilla           , @w_direccion      , @w_porc_comision    , @w_comision,
      @w_cupon             , @w_categoria_cupon, @w_sucursal         , @w_ret_ica)

      if @@error <> 0 begin
         exec cobis..sp_cerror
		 @t_debug = @t_debug,
		 @t_file  = @t_file,
         @t_from  = @w_sp_name,
		 @i_num   =  143005
         select @w_return = 1
         goto borra
      end
   end
   
   select @w_fpago_cheque = fp_automatico
   from   pf_fpago
   where  fp_mnemonico = @w_mt_producto
   and    fp_estado    = 'A'
 
   if @w_dias_reales = 'S' begin
      select @w_fecha_ven = dateadd(dd,@w_num_dias,@w_fecha_valor)
   end
   else begin
      exec sp_funcion_1
	  @i_operacion = 'SUMDIA',
      @i_fechai    = @w_fecha_valor,
      @i_dias      = @w_num_dias,
      @i_dia_pago  = @w_dia_pago,
      @o_fecha     = @w_fecha_ven out
   end

   if @w_mantiene_stock = 'S'
      select @w_fecha_ven1=@w_fecha_ven
   else
   begin
      exec sp_primer_dia_labor
      @t_debug         = @t_debug,
      @t_file          = @t_file,
      @t_from          = @w_sp_name,
      @i_fecha         = @w_fecha_ven,
      @i_tipo_deposito = @w_tipo_deposito,
      @o_fecha_labor   = @w_fecha_ven1 out
      
	  select @w_dif = datediff(dd,@w_fecha_ven,@w_fecha_ven1)

      if @w_dif > 0
         select @w_num_dias=@w_num_dias+@w_dif
   end
   
   if @w_dias_reales = 'S' begin
      if @w_max_ttransito > 0 begin
	  
         select @w_tran_sabado = td_tran_sabado
         from   pf_tipo_deposito
         where  td_mnemonico   = @w_toperacion

         select @w_cuenta_dias = 1

         select @w_fecha_temp_hoy =  @w_fecha_valor
		 
         exec sp_primer_dia_labor
         @t_debug         = @t_debug,
         @t_file          = @t_file,
         @t_from          = @w_sp_name,
         @i_fecha         = @w_fecha_temp_hoy,
         @s_ofi           = @s_ofi,
         @i_tran_sabado   = 'S',
         @i_operacion     = 'C',
         @i_ttransito     = @w_max_ttransito,
         @i_tipo_deposito = @w_tipo_deposito,
         @o_fecha_labor   = @w_fecha_temp_hoy out

         select @w_fecha_valor    = @w_fecha_temp_hoy
         select @w_fecha_ven_temp = dateadd(dd,@w_num_dias,@w_fecha_valor )

         exec sp_primer_dia_labor
         @t_debug         = @t_debug,
         @t_file          = @t_file,
         @t_from          = @w_sp_name,
         @i_fecha         = @w_fecha_ven_temp,
         @i_tipo_deposito = @w_tipo_deposito,
         @o_fecha_labor   = @w_fecha_ven1 out
		 
         exec sp_primer_dia_labor
         @t_debug         = @t_debug,
         @t_file          = @t_file,
         @t_from          = @w_sp_name,
         @i_fecha         = @w_fecha_ven1,
         @s_ofi           = @s_ofi,
         @i_tran_sabado   = @w_tran_sabado,
   	     @i_tipo_deposito = @w_tipo_deposito,
         @o_fecha_labor   = @w_fecha_ven1 out

         if @w_fpago = 'VEN' begin
            select @w_dia_pago = datepart(dd, @w_fecha_ven1)
         end
      end
   end

   exec sp_estima_int                                                   -- GAL 15/SEP/2009 - RVVUNICA
   @i_fecha_inicio    = @w_fecha_valor,
   @s_ofi             = @s_ofi,
   @s_date            = @s_date,
   @i_fecha_final     = @w_fecha_ven1,
   @i_monto           = @w_monto,
   @i_tasa            = @w_tasa,
   @i_tcapitalizacion = @w_tcapitalizacion,
   @i_fpago           = @w_fpago,
   @i_ppago           = @w_ppago,
   @i_dias_anio       = @w_base_calculo,
   @i_dia_pago        = @w_dia_pago,
   @i_batch           = 'S',
   @i_retienimp       = @w_retienimp,
   @i_moneda          = @w_moneda,
   @i_ente            = @w_ente,
   @i_tasa_imp        = @w_tasa_imp,
   @i_dias_reales     = @w_dias_reales,
   @i_modifica        = @i_modifica,
   @i_op_operacion    = @i_op_operacion,
   @i_toperacion      = @w_toperacion,
   @i_periodo_tasa    = @w_periodo_tasa, 
   @i_modalidad_tasa  = @w_modalidad_tasa,
   @i_descr_tasa      = @w_descr_tasa,
   @i_mnemonico_tasa  = @w_mnemonico_tasa,
   @i_tipo_plazo      = @w_tipo_plazo,
   @i_en_linea        = 'S',
   @i_tasa1           = @w_tasa_retencion,
   @i_ret_ica         = @w_ret_ica,
   @i_tasa_ica        = @w_tasa_ica,
   @o_fecha_prox_pg   = @w_fecha_pg_int    out,
   @o_int_pg_pp       = @w_int_estim       out,
   @o_int_pg_ve       = @w_total_int_estim out,
   @o_num_pagos       = @w_num_pagos       out


   if @w_max_ttransito > 0 begin
      update pf_operacion
      set    op_int_estimado = @w_int_estim,
             op_dia_pago     = @w_dia_pago
      where  op_operacion    = @w_operacionpf
   end
   
   select
   @w_dif_estim    = @w_total_int_estim - @w_total_int_estimado,
   @w_dif_impuesto = 0

   if @w_retienimp = 'S' begin
      select @w_tasa         = @w_tasa_imp
      select @w_impuesto     = @w_total_int_estim*@w_tasa/100
      select @w_dif_impuesto = @w_dif_estim*@w_tasa/100
   end




   select @w_dif_estimado=@w_dif_estim - @w_dif_impuesto

   select
   'NUM. BANCO'          = @w_num_banco,
   'NUM. OPERACION'      = @w_operacionpf,
   'FECHA VENCIMIENTO'   = convert(varchar,@w_fecha_ven1,@i_formato_fecha),
   'INTERES ESTIMADO'    = @w_int_estim,
   'IMPUESTOS RENTA'     = @w_impuesto,
   'TOTAL INT. ESTIMADO' = @w_total_int_estim,
   'FECHA PAGO INTERES'  = convert(varchar,@w_fecha_pg_int,@i_formato_fecha),
   'DIA DE PAGO'         = convert(varchar(3),@w_dia_pago) + ' DE CADA MES',
   'NUMERO DE PAGOS'     = @w_num_pagos,
   'PLAZO'               = @w_num_dias,
   'DIFERENCIA INTERES'  = @w_dif_estimado,
   'SECUENCIAL TICKET'   = @w_sec_ticket,
   'TIPO PERSONA'        = @w_tipo_persona,
   'IMPUESTOS ICA'       = @w_impuesto_ica
   select @w_return = 0
commit tran
goto borra

------------------------------------
-- Eliminacion de tablas temporales
------------------------------------
borra:
set rowcount 0
delete pf_operacion_tmp
where  ot_usuario = @s_user
and    ot_sesion  = @s_sesn

delete pf_rubro_op_tmp
where  rot_usuario = @s_user
and    rot_sesion  = @s_sesn

delete pf_mov_monet_tmp
where  mt_usuario = @s_user
and    mt_sesion  = @s_sesn

delete pf_beneficiario_tmp
where  bt_usuario = @s_user
and    bt_sesion  = @s_sesn

delete pf_det_pago_tmp
where  dt_usuario = @s_user
and    dt_sesion  = @s_sesn

delete pf_det_cheque_tmp
where  ct_usuario = @s_user
and    ct_sesion  = @s_sesn

return @w_return
go

