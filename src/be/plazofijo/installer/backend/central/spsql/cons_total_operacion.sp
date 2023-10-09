/************************************************************************/
/*      Archivo:                contotop.sp                             */
/*      Stored procedure:       sp_cons_total_operacion                 */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Myriam Davila                           */
/*      Fecha de documentacion: 21-Nov-1994                             */
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
/*      Este programa procesa las transacciones de QUERY a la tabla     */
/*      de operaciones 'pf_operacion' retornando el registro completo   */
/*      con todas las descripciones de las tablas foraneas 'cl_ente',   */
/*      'cl_oficina', 'cl_funcionario', 'cl_producto', 'cl_moneda',     */
/*      'cl_tabla', 'cl_catalogo' y 'pf_ppago',pf_tipo_deposito         */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      03-Ago-06  Ricardo Ramos      Adicionar campo de fideicomiso    */
/*      12/JUL-09  Y. Martinez        NYM DPF00015 ICA                  */
/*      12/JUL-09  Y. Martinez        NYM DPF00018 AUTRETENEDOR         */
/*      11/ENE-17  J. Salazar         DPF-H94952 MANEJO RETENCIONES MX  */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if object_id('sp_cons_total_operacion') is not null
   drop proc sp_cons_total_operacion
go

create proc sp_cons_total_operacion (
      @s_ssn                   int         = NULL,
      @s_user                  login       = NULL,
      @s_term                  varchar(30) = NULL,
      @s_date                  datetime    = NULL,
      @s_srv                   varchar(30) = NULL,
      @s_lsrv                  varchar(30) = NULL,
      @s_ofi                   smallint    = NULL,
      @s_rol                   smallint    = NULL,
      @t_debug                 char(1)     = 'N',
      @t_file                  varchar(10) = NULL,
      @t_from                  varchar(32) = NULL,
      @t_trn                   smallint    = NULL,
      @i_operacion             char(1),
      @i_flag                  char(1)     = 'N',
      @i_estado1               catalogo    = '%',
      @i_estado2               catalogo    = '%',
      @i_estado3               catalogo    = '%',
      @i_accion_sgte           catalogo    = '%',
      @i_cuenta                cuenta,
      @i_siguientes            char(1)     = 'N',   --12-Abr-2000 Tasa Var.
      @i_formato_fecha         int         = 101,   --GESCY2K B248
      @i_empresa               smallint    = 1,     --JSA: Para obtener la moneda base
      @i_flag_valida_cliente   char(1)     = 'N',   --KTA GB-GAP00128
      @i_flag_valida_cif       char(1)     = 'N',   --KTA GB-GAP00128
      @i_flag_valida_cif_blq   char(1)     = 'N',   --KTA GB-GAP00128
      @i_bloqueado             char(1)     = 'N',   --CVA Set-29-05
      @i_bloqueo_leg           char(1)     = 'N',   --CVA Set-29-05
      @i_pignorado             char(1)     = 'N',   --
      @i_aprobacion            char(1)     = 'N',   -- xca
      @i_activacion            char(1)     = 'N',   --xca
      @i_flag_val_instruccion  char(1)     = 'N',
      @i_val_caja              char(1)     = 'N',
      @i_flag_val_inact        char(1)     = 'S',
      @i_flag_pago_pend        char(1)     = 'N',         --LIM 01/NOV/2005
      @i_flag_per              char(1)     = 'N',
      @i_flag_val_rev_renov    char(1)     = 'N',   --ccr validar que la operacion tenga renovacion a reversar
      @i_flag_firma            char(1)     = 'N',
      @i_flag_pago             char(1)     = 'N',   --Para validar que se haya realizado el pago
      @i_cert                  char(1)     = 'N' --Valida que este imprimiendo un certificado desde frontend

)
with encryption
as
declare @w_sp_name                      varchar(32),
        @w_prox_fech_pago               datetime,
        @w_dias_mes                     int,
        @w_dias_periodo                 int,
        @o_codsuper                     catalogo, -- CVA Oct-26-05
        @o_num_banco                    cuenta,
        @o_cert_origen                  cuenta,
        @o_fecha_cert_origen            datetime,
        @o_fecha_cert_origen_temp       datetime,
        @o_tasa_congelado               float,
        @o_num_banco_new                cuenta,
        @o_operacion                    int,
        @o_operacion_new                int,
        @o_ente                         int,
        @o_en_nombre_completo           varchar(254),
        @o_toperacion                   catalogo,
        @o_desc_toperacion              descripcion,
        @o_categoria                    catalogo,
        @o_desc_categoria               descripcion,
        @o_producto                     tinyint,
        @o_pd_descripcion               descripcion,
        @o_oficina                      smallint,
        @o_ced_ruc                      numero,
        @o_of_nombre                    descripcion,
        @o_moneda                       tinyint,
        @w_moneda_base                  tinyint,
        @o_mo_descripcion               descripcion,
        @o_num_dias                     smallint,
        @o_dias_anio                    smallint,
        @o_monto                        money,
        @o_monto_pg_int                 money,
        @o_moneda_pg                    char(2),
        @o_monto_pgdo                   money,
        @o_monto_blq                    money,
        @o_tasa                         float,
        @o_meses                        tinyint,
        @o_int_ganado                   money,
        @o_int_estimado                 money,
        @w_total                        money,
        @o_int_pagados                  money,
        @o_int_provision                money,
        @o_total_int_ganados            money,
        @o_total_int_pagados            money,
        @o_total_int_estimado           money,
        @o_total_int_retenido           money,
        @o_tcapitalizacion              char(1),
        @o_fpago                        char(3),
        @w_msg                          varchar(30),
        @o_ppago                        char(3),
        @o_pp_descripcion               descripcion,
        @o_dia_pago                     smallint, --12-May-2000 cambio para soportar 360
        @o_historia                     smallint,
        @o_duplicados                   tinyint,
        @o_renovaciones                 smallint,
        @o_numdoc                       smallint,
        @o_estado                       catalogo,
        @o_pignorado                    char(1),
        @o_oficial                      login,
        @o_telefono                     varchar(8),
        @o_telefono2                    varchar(8),
        @o_direccion                    tinyint,
        @o_casilla                      tinyint,
        @o_cd_descripcion               descripcion,
        @o_fu_nombre                    descripcion,
        @o_descripcion                  varchar(255),
        @o_accion_sgte                  catalogo,
        @o_fecha_valor                  datetime,
        @o_fecha_ven                    datetime,
        @o_fecha_can                    datetime,
        @o_fecha_pg_int                 datetime,
        @o_fecha_ult_pg_int             datetime,
        @o_fecha_crea                   datetime,
        @o_fecha_ult_calculo            datetime,
        @o_fecha_ing                    datetime,
        @o_dia_vencido                  int,
        @o_ciudad                       descripcion,
        @o_preimpreso                   int,
        @o_condicion2                   char(1),
        @o_condicion3                   char(1),
        @w_dia_vencido                  int,
        @o_retienimp                    char(1),
        @o_impuesto                     money,
        @w_tasa                         float,
        @w_ente2                        int,
        @w_ente3                        int,
        @w_dias                         float,
        @o_fecha_mod                    datetime,
        @o_mantiene                     char(1),
        @o_alterno3                     char(30),
        @o_disponible                   int,
        @o_factor_en_meses              tinyint,
        @o_alterno                      char(30),
        @o_num_imp_orig                 tinyint,
        @o_dias_antes_impresion         tinyint,
        @o_impuesto_capital             money,
        @o_capital_pagado               money,
        @o_ley                          char(1),
        @o_fecha_cal_tasa               datetime,
        @w_operacion_reprog             int,
        @w_certificado_origen           int,
        @w_tasa_moneda                  char(3),
        @o_anio_comercial               char(1),  --04/04/2000 Fecha Comercial
        @o_tasa_variable                char(1),  --12-Abr-2000 Tasa variable S/N.
        @o_tasa_efectiva                float,    --04-May-2000 Conversion Efectiva/Nominal
        @o_flag_tasaefec                char(1),  --04-May-2000 Conversion Efectiva/Nominal
        @o_total_int_acumulado          money,    --12-May-2000 Fusion/Fraccionamiento
        @o_tot_int_est_ant              money,    --12-May-2000 Fusion/Fraccionamiento
        @o_residuo                      float,    --12-May-2000 Fusion/Fraccionamiento
        @o_imprime                      char(1),  --12-May-2000 Fusion/Fraccionamiento
        @o_plazo_ant                    smallint, --12-May-2000 Fusion/Fraccionamiento
        @o_fecven_ant                   datetime, --12-May-2000 Fusion/Fraccionamiento
        @o_fech_ord_act                 datetime, --12-May-2000 Fusion/Fraccionamiento
        @o_retenido                     char(1),  --12-May-2000 Fusion/Fraccionamiento
        @o_tipo_monto                   catalogo, --12-May-2000 Fusion/Fraccionamiento
        @o_tipo_plazo                   catalogo, --12-May-2000 Fusion/Fraccionamiento
        @o_estatus_prorroga             char(1),  --12-May-2000 Fusion/Fraccionamiento
        @o_num_prorroga                 int,      --12-May-2000 Fusion/Fraccionamiento
        @o_mnemonico_tasavar            catalogo, --12-Abr-2000 Tasa Variable
        @o_modalidad_tasa               char(1),  --12-Abr-2000 Tasa Variable
        @o_periodo_tasa                 smallint, --12-Abr-2000 Tasa Variable
        @o_operador                     char(1),  --12-Abr-2000 Tasa Variable
        @o_spread                       float,    --12-Abr-2000 Tasa Variable
        @o_puntos                       float,    --12-Abr-2000 Tasa Variable
        @o_desc_tasa_var                descripcion,  --12-Abr-2000 Tasa Variable
        @o_tran_sabado                  char(1),      -- GES 05/14/01 CUZ-009-043
        /*Modificacion : Walter Solis 29/05/01  DP-00017-16 */
        @o_porc_comision                float,
        @o_comision                     money,
        @o_paga_comision                catalogo,
        /*Modificacion:  Walter Solis  DP-00024-23*/
        @o_provincia                    varchar(60),
        @o_cupon                        char(1),        -- GES 06/22/01 CUZ-020-032
        @o_categoria_cupon              catalogo,       -- GES 06/29/01 CUZ-020-062
        @o_desc_categoria_cupon         catalogo,       -- GES 06/29/01 CUZ-020-062
        /*Modificacion:  Walter Solis  DP-00034-15*/
        @o_custodia                     char(1),
        /*Modificacion:  Memito Saborio  DP-000073*/
        @o_instruccion                  varchar(255),
        @o_incremento_prorroga          money,    -- GES 08/23/01 CUZ-0224-053
        @o_vuelto                       money,    -- JSA 01/05/02 Agrega el vuelto
        @w_return                       int,      -- GES 09/11/01 CUZ-031-020
        @o_captador                     login,    -- GAR 14-feb-2005 GB
        @o_bloqueo_legal                char(1),  --GAR 21-feb-2005 DP00036
        @o_captador_nombre              descripcion, --GAR 21-feb-2005 DP00026
        @o_aprobado                     char(1),     -- GAR 23-feb-5005 DP00023
        @o_mon_sgte                     smallint,
        @o_monto_blqlegal               money,    --GAR 7-mar-2005 DP00065
        @w_mayor_edad                   tinyint,  --KTA GB-GAPDP00128
        @w_par_cliente_cif_blq          char(1),  --CVA GB-GAPDP00128
        @w_par_cliente_cif              char(1),  --KTA GB-GAPDP00128
        @w_par_cliente_menor            char(1),  --KTA GB-GAPDP00128
        @w_en_subtipo                   char(1),  --KTA GB-GAPDP00128
        @w_fecha_nac                    datetime, --KTA GB-GAPDP00128
        @w_diff                         tinyint,   --KTA GB-GAPDP00128
        @w_funcionario                  login,
        @o_capital_inicial              money, --GAR 17-mar-2005 DP00022
        @o_capital_periodo              money, --CVA Set-26-06
        @o_fecha_renovacion             datetime, --GAR 17-mar-2005 DP00022
        @o_prorroga_aut                 char(1), --GAR 17-mar-2005 DP00022
        @o_oficial_principal            login,  -- GES DP00010
        @o_oficial_secundario           login,  -- GES DP00010
        @o_nombre_oficial_principal     varchar(30),    -- GES DP00010
        @o_nombre_oficial_secundario    varchar(30),     -- GES DP00010
        @o_origen_fondos                catalogo, --KTA GB-GAPDP00143
        @o_proposito_cuenta             catalogo, --KTA GB-GAPDP00143
        @o_producto_bancario1           catalogo, --KTA GB-GAPDP00143
        @o_producto_bancario2           catalogo,  --KTA GB-GAPDP00143
        @o_op_dias_reales               char(1),    --gap DP00008
        @o_ente_corresp                 int,        --GAR GB-DP00120
        @o_localizado                   char(1),
        @o_fecha_localizacion           smalldatetime,
        @o_fecha_no_localiza            smalldatetime,
        @o_plazo_orig                   int,
        @o_nom_ente_corresp             varchar(254),
        @o_fecha_temp_hoy               datetime,
        @o_transito                     tinyint,
        @o_max_sec                      int,
        @o_fech_camb                    datetime,
        @o_desc_origen_fondos           varchar(260),
        @o_desc_proposito_cuenta        varchar(260),
        @o_desc_producto_bancario1      varchar(260),
        @o_desc_producto_bancario2      varchar(260),
        @o_dias_hold                    int,
        @w_cuenta_dias                  int,
        @o_sucursal                     smallint,
        @w_val_caja                     char(1),
        @o_saldo_disponible             money,
        @o_inactivo                     char(1),       --LIM 22/OCT/2005
        @o_incremento_susp              money,         --LIM 22/OCT/2005
        @w_msg_out                      varchar(255),  --LIM 01/NOV/2005
        @w_operacion                    int,           --LIM 04/NOV/2005
        @w_noexiste                     char(1),       --LIM 04/NOV/2005
        @o_fecha_ult_inc_dism           varchar(10),   --LIM 08/NOV/2005
        @o_localizado_out               varchar(20),   --LIM 15/NOV/2005
        @o_tasa_base                    float,   --CVA Ene-24-06
        @w_dias_plazo                   int,          --LIM 14/DIC/2005
        @w_fecha_ven                    datetime,        --LIM 14/DIC/2005
        @o_op_fecha_ult_pago_int_ant    datetime,   --+-+
        @w_fecha_ini_per                datetime,   --+-+
        @o_num_dias_new                 smallint,   --+-+
        @o_monto_prox_pago              money,
        @o_monto_vuelto                 money,      --LIM 01/FEB/2006
        @o_amortiza_per                 money,
        @o_vamortiza_per                money,
        @o_total_amortizado             money,
        @o_fideicomiso                  varchar(15),
        @w_forma_pago                   varchar (30),
        @w_num_cuenta                   varchar (24),
        @o_desmaterializa               char(1),
        @o_isin                         varchar(20),
        @o_fungible                     varchar(12),
        -- NYM DOF00015 ICA
        @w_total_aux                    money,
        @o_tasa_retencion               float,
        @o_ret_ica                      char(1),
        @o_tasa_ica                     float,
        @o_base_ret                     money,
        @o_base_ica                     money,
        @o_imp_ica                      money,
        @o_decimal_imp                  tinyint,
        @o_autoretenedor                char(1),
        @o_int_dias_vencidos            money,          --*-*
        @w_fecha_temp                   datetime,       --*-*
        @w_dias_vencidos                smallint,       --*-*
        @w_numdeci                      tinyint,        --*-*
        @w_usadeci                      char(1),         --*-*
        -- NYM DPF00015 ICA
        @o_causa_op_retenido            varchar(20),
        @o_desc_causa_retenido          varchar(200),
        @w_tipo_deposito                int,
        @o_alianza                      int,
        @o_des_alianza                  varchar(255)

select @w_sp_name = 'sp_cons_total_operacion',
       @o_num_banco_new = null,
       @o_mantiene      = 'N',
       @o_disponible    = 0,
       @o_numdoc        = 0,
       @o_num_imp_orig  = 0

/*------------------------------------------------*/
/**  VERIFICAR CODIGO DE TRANSACCION PARA QUERY  **/
/*------------------------------------------------*/
if ( @i_operacion = 'Q' ) and ( @t_trn <> 14401 )
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141042
   return 1
end

---------------------------------
-- Encontrar numero de decimales
---------------------------------
select @w_moneda_base = em_moneda_base
  from cob_conta..cb_empresa
 where em_empresa = @i_empresa
if @@rowcount = 0
  return 601018 --@w_error

select @w_mayor_edad = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'MDE'
   and pa_producto = 'ADM'
   and pa_tipo     = 'T'
if @@rowcount = 0
begin
   return 101077  -- No existe parametro
end


select @w_par_cliente_cif = pa_char
  from cobis..cl_parametro
 where pa_nemonico = 'BCI'
   and pa_producto = 'PFI'
if @@rowcount = 0
begin
   return 101077  -- No existe parametro
end

--CVA Oct-03-05
select @w_par_cliente_cif_blq = pa_char
  from cobis..cl_parametro
 where pa_nemonico = 'BCL'
   and pa_producto = 'PFI'
if @@rowcount = 0
begin
   return 101077  -- No existe parametro
end



select @w_par_cliente_menor = pa_char
  from cobis..cl_parametro
 where pa_nemonico = 'BME'
   and pa_producto = 'PFI'
if @@rowcount = 0
begin
   return 101077  -- No existe parametro
end




---------------------------
-- Busqueda de Operaciones
---------------------------
if @i_operacion = 'Q'
begin
   select @w_operacion = op_operacion
     from pf_operacion
   where op_num_banco = @i_cuenta


   select @o_fecha_ult_inc_dism =   convert(varchar(10),max(mm_fecha_aplicacion),@i_formato_fecha) --LIM 08/NOV/2005
   from   pf_mov_monet
   where  mm_operacion = @w_operacion
   and    mm_tran in (14989,14990)
   and    mm_estado = 'A'

   select @o_num_banco          = op_num_banco,
   @o_operacion                 = op_operacion,
   @o_ente                      = op_ente,
   @o_toperacion                = op_toperacion,
   @o_categoria                 = op_categoria,
   @o_producto                  = op_producto,
   @o_oficina                   = op_oficina,
   @o_moneda                    = op_moneda,
   @o_num_dias                  = op_num_dias,
   @o_telefono                  = op_telefono,
   @o_dias_anio                 = op_base_calculo,
   @o_monto                     = op_monto,
   @o_monto_pg_int              = op_monto,
   @o_monto_pgdo                = op_monto_pgdo,
   @o_monto_blq                 = op_monto_blq,
   @o_tasa                      = op_tasa,
   @o_int_ganado                = op_int_ganado,
   @o_int_estimado              = op_int_estimado,
   @o_int_pagados               = op_int_pagados,
   @o_int_provision             = op_int_provision,
   @o_total_int_ganados         = op_total_int_ganados,
   @o_total_int_pagados         = op_total_int_pagados,
   @o_total_int_estimado        = op_total_int_estimado,
   @o_total_int_retenido        = op_total_int_retenido,
   @o_tcapitalizacion           = op_tcapitalizacion,
   @o_fpago                     = op_fpago,
   @o_ppago                     = op_ppago,
   @o_dia_pago                  = op_dia_pago,
   @o_direccion                 = op_direccion,
   @o_casilla                   = op_casilla,   --12-May-2000estuvo mal asignado
   @o_historia                  = op_historia,
   @o_duplicados                = op_duplicados,
   @o_renovaciones              = op_renovaciones,
   @o_estado                    = op_estado,
   @o_pignorado                 = op_pignorado,
   @o_oficial                   = op_oficial,
   @o_descripcion               = op_descripcion,
   @o_fecha_ing                 = op_fecha_ingreso,
   @o_fecha_valor               = op_fecha_valor,
   @o_fecha_ven                 = op_fecha_ven,
   @o_fecha_pg_int              = op_fecha_pg_int,
   @o_fecha_ult_pg_int          = op_fecha_ult_pg_int,
   @o_fecha_ult_calculo         = op_ult_fecha_calculo,
   @o_accion_sgte               = op_accion_sgte,
   @o_fecha_crea                = op_fecha_crea,
   @o_retienimp                 = op_retienimp,
   @o_moneda_pg                 = op_moneda_pg,
   @o_fecha_mod                 = op_fecha_mod,
   @o_fecha_can                 = op_fecha_cancela,
   @o_preimpreso                = op_preimpreso,
   @o_num_imp_orig              = op_num_imp_orig ,
   @o_impuesto_capital          = op_impuesto_capital,
   @o_ley                       = op_ley,
   @o_fecha_cal_tasa            = op_ult_fecha_cal_tasa,
   @o_anio_comercial            = isnull(op_anio_comercial,'N'), --04/04/2000 Fecha Comercial
   @o_tasa_variable             = isnull(op_tasa_variable,'N'),--12-Abr-2000 Tasa Variable
   @o_flag_tasaefec             = isnull(op_flag_tasaefec,'N'), --04-May-2000 Conversion Tasa Efectiva a Nominal
   @o_tasa_efectiva             = op_tasa_efectiva, --04-May-2000 Conversion Tasa Efectiva a Nominal
   @o_total_int_acumulado       = op_total_int_acumulado, --12-May-2000  Fus/Fra
   @o_tot_int_est_ant           = op_tot_int_est_ant, --12-May-2000  Fus/Fra
   @o_residuo                   = op_residuo,         --12-May-2000  Fus/Fra
   @o_imprime                   = op_imprime,         --12-May-2000  Fus/Fra
   @o_plazo_ant                 = op_plazo_ant,       --12-May-2000  Fus/Fra
   @o_fecven_ant                = op_fecven_ant,      --12-May-2000  Fus/Fra
   @o_fech_ord_act              = op_fecha_ord_act,   --12-May-2000  Fus/Fra
   @o_retenido                  = op_retenido,        --12-May-2000  Fus/Fra
   @o_tipo_monto                = op_tipo_monto,      --12-May-2000  Fus/Fra
   @o_tipo_plazo                = op_tipo_plazo,      --12-May-2000  Fus/Fra
   @o_estatus_prorroga          = op_estatus_prorroga,--12-May-2000  Fus/Fra
   @o_num_prorroga              = op_num_prorroga,    --12-May-2000  Fus/Fra
   @o_mnemonico_tasavar         = op_mnemonico_tasa,  --12-Abr-2000 Tasa Var.
   @o_modalidad_tasa            = op_modalidad_tasa,  --12-Abr-2000 Tasa Var.
   @o_periodo_tasa              = op_periodo_tasa,    --12-Abr-2000 Tasa Var.
   @o_operador                  = op_operador,        --12-Abr-2000 Tasa Var.
   @o_spread                    = op_spread,          --12-Abr-2000 Tasa Var.
   @o_desc_tasa_var             = op_descr_tasa,      --12-Abr-2000 Tasa Var.
   @o_puntos                    = op_puntos,          --12-Abr-2000 Tasa Var.
   @o_porc_comision             = op_porc_comision,
   @o_comision                  = op_comision,
   @o_paga_comision             = td_paga_comision,
   @o_cupon                     = op_cupon,   -- GES 06/22/01 CUZ-020-033
   @o_categoria_cupon           = op_categoria_cupon,  -- CUZ-020-063
   @o_custodia                  = op_custodia, --WSM 16/07/01 DP-00034-15
   @o_incremento_prorroga       = op_incremento_prorroga, -- GES CUZ-024-054
   @o_captador                  = op_captador, --GAR 14-feb-2005,
   @o_bloqueo_legal             = isnull(op_bloqueo_legal,'N'), --GAR 21-feb-2005 DP00036
   @o_aprobado                  = op_aprobado, --GAR 23-feb-2005 DP00023
   @o_mon_sgte                  = op_mon_sgte,      --KTA GB-GAPDP00049,
   @o_monto_blqlegal            = isnull(op_monto_blqlegal,0), --GAR 07-Mar-2005 DP00065
   @o_prorroga_aut              = op_prorroga_aut, --GAR 17-mar-2005 DP00022
   @o_oficial_principal         = op_oficial_principal,  -- GES DP00010
   @o_oficial_secundario        = op_oficial_secundario,  -- GES DP00010
   @o_origen_fondos             = op_origen_fondos,      --KTA GB-GAPDP00143
   @o_proposito_cuenta          = op_proposito_cuenta,   --KTA GB-GAPDP00143
   @o_producto_bancario1        = op_producto_bancario1, --KTA GB-GAPDP00143
   @o_producto_bancario2        = op_producto_bancario2,  --KTA GB-GAPDP00143
   @o_op_dias_reales            = op_dias_reales,   --gap DP00008
   @o_ente_corresp              = op_ente_corresp,         --GAR GB-DP00120
   @o_localizado                = op_localizado,
   @o_fecha_localizacion        = op_fecha_localizacion,
   @o_fecha_no_localiza         = op_fecha_no_localiza,
   @o_plazo_orig                = op_plazo_orig,
   @o_dias_hold                 = isnull(op_dias_hold, 0),
   @o_sucursal                  = op_sucursal,
   @o_incremento_susp           = op_incremento_suspenso,  --LIM 22/OCT/2005
   @o_inactivo                  = op_inactivo,       --LIM 22/OCT/2005
   @o_op_fecha_ult_pago_int_ant = op_fecha_ult_pago_int_ant,  --+-+
   @o_tasa_base                 = op_tasa_mer,
   @o_amortiza_per              = isnull(op_amortiza_periodo,0),
   @o_total_amortizado          = isnull(op_total_amortizado,0),
   @o_fideicomiso               = op_fideicomiso,
   @o_desmaterializa            = op_desmaterializa,
   @o_isin                      = op_isin,
   @o_fungible                  = op_fungible,
   @o_autoretenedor             = op_autoretenedor
   from pf_operacion with (index = pf_operacion_Key),
   pf_tipo_deposito
   where op_num_banco = @i_cuenta
   and op_toperacion = td_mnemonico



   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 141051
      return 1
   end
   else
   begin

        select @w_usadeci = mo_decimales
        from cobis..cl_moneda
        where mo_moneda = @o_moneda

        if @w_usadeci = 'S'
        begin
           select @w_numdeci = isnull (pa_tinyint,0)
           from cobis..cl_parametro
           where pa_nemonico = 'DCI'
           and   pa_producto = 'PFI'
        end
        else
           select @w_numdeci = 0


        -- NYMR NR 192
        if @o_retenido = 'S'
           select @o_causa_op_retenido = R.rt_motivo ,
                  @o_desc_causa_retenido = (select valor from cobis..cl_tabla T, cobis..cl_catalogo C where T.tabla = 'pf_motivo_ret' and T.codigo = C.tabla and C.codigo = R.rt_motivo)
           from cob_pfijo..pf_retencion R where rt_operacion = @o_operacion

        --*-*Obtiene valor de int. x dias vencidos, (si la fecha de vencimiento cae en un dia no habil => paga interes hasta el siguiente dia habil
        select @w_dias_vencidos = 0
        select @o_int_dias_vencidos = 0
        select @w_fecha_temp = @o_fecha_ven
        if @o_fecha_ven < @s_date
        begin
        
		select   @w_tipo_deposito = td_tipo_deposito
		from     pf_tipo_deposito
		where    td_mnemonico = @o_toperacion
        
        
                --si la fecha de vencimiento fue un dia no habil => busca fecha siguiente habil
                exec sp_primer_dia_labor
                        @t_debug       = @t_debug,
                        @t_file        = @t_file,
                        @t_from        = @w_sp_name,
                        @i_fecha       = @w_fecha_temp,
                        @s_ofi         = @o_oficina,
                        @i_tipo_deposito = @w_tipo_deposito,
                        @o_fecha_labor = @w_fecha_temp out

                if @o_op_dias_reales = 'S'
                        select @o_int_dias_vencidos = datediff(dd,@o_fecha_ven, @w_fecha_temp)
                else
                        exec sp_funcion_1
                                @i_operacion  = 'DIFE30',
                                @i_fechai     = @o_fecha_ven,
                                @i_fechaf     = @w_fecha_temp,
                                @i_dia_pago   = @o_dia_pago,
                                @i_batch      = 0,              --*-*
                                @o_dias       = @w_dias_vencidos out

--print 'AAAA o_int_dias_vencidos:' + cast(@o_int_dias_vencidos as varchar) + ' @o_fecha_ven:' + cast(@o_fecha_ven as varchar) + ' @w_fecha_temp:' + + cast(@w_fecha_temp as varchar)

                -- Calcula valor del interes con ultima tasa disponible
                select @o_int_dias_vencidos = round(@o_monto_pg_int * @o_tasa * @w_dias_vencidos / (@o_dias_anio * 100) , @w_numdeci)

        end

--print 'o_int_dias_vencidos:' + cast(@o_int_dias_vencidos as varchar) + ' @o_fecha_ven:' + cast(@o_fecha_ven as varchar) + ' @s_date:' + + cast(@s_date as varchar)

   ---------------------------
   --OBTIENE  MEDIO DE PAGO
   ---------------------------
   set rowcount 1
   select @w_forma_pago = fp_descripcion
   from cob_pfijo..pf_det_pago,
   cob_pfijo..pf_fpago
   where dp_operacion = @o_operacion
   and dp_forma_pago = fp_mnemonico

   -----------------------------
   --OBTIENE  NUMERO DE CUENTA
   -----------------------------
   set rowcount 1
   select @w_num_cuenta = dp_cuenta
   from cob_pfijo..pf_det_pago,
   cob_pfijo..pf_fpago
   where dp_operacion = @o_operacion
   and dp_forma_pago = fp_mnemonico


      select @o_monto_vuelto = isnull(sum(mm_valor),0)         --LIM 01/FEB/2006
      from pf_mov_monet
      where mm_operacion = @o_operacion
        and mm_tran = 14901
        and mm_tipo = 'C'

      if @o_fpago in ('PER','PRA') -- 13-Mar-2000 PRA
      begin
    select @o_factor_en_meses = pp_factor_en_meses
           from pf_ppago
          where rtrim(pp_codigo) = rtrim(@o_ppago)
      end
   end

--print 'fecha_val:%1!,fecha_ven:%2!,num_dias:%3!',@o_fecha_valor,@o_fecha_ven,@o_num_dias

   if @i_flag_pago_pend = 'S'
   begin

       select @w_operacion = op_operacion
         from pf_operacion
        where op_num_banco = @i_cuenta

      if not exists(select 1 from  pf_emision_cheque
                       where ec_operacion = @w_operacion
                          and ec_estado = 'A'
                          and ec_fecha_mov = @s_date)
         select @w_noexiste = 'S'
         else
         select @w_noexiste = 'N'
      if @w_noexiste = 'S'
        begin
         if not exists(select 1 from pf_mov_monet
                            where  mm_operacion = @w_operacion
                        and mm_estado    = 'A'
                            and mm_tran      = 14943
                            and mm_fecha_aplicacion = @s_date
                            )
            select @w_noexiste = 'S'
             else
            select @w_noexiste = 'N'
      end
        if @w_noexiste = 'S'
      begin
         exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 141208
            return 141208

       end
   end

   if @i_flag_per = 'S' and @o_fpago = 'VEN'
   begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_msg   = 'Transaccion no permitida. Operacion es de frecuencia al vencimiento',
        @i_num   = 141208
         return 141208
   end



   ---------------------------------------------------------------------
   -- VALIDAR QUE LA OPERACION NO SE ENCUENTRA INACTIVA. ESTA VALIDACION
   -- SE REALIZARA SI EL PARAMETRO @i_flag_val_inact = 'S'
   ---------------------------------------------------------------------
   if @i_flag_val_inact = 'S' and @o_inactivo = 'S'
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file     = @t_file,
         @t_from     = @w_sp_name,
         @i_num      = 149097
      return 149097
   end

   /***********************************************************************
   CCR Validar si el DPF posee una renovacion en línea que pueda reversarse
   ***********************************************************************/
   if @i_flag_val_rev_renov = 'S'
   begin
      -- si no existe renovaci¢n aplicada en la fecha de hoy
      if not exists  (select 1 from pf_renovacion
            where re_estado   = 'A'
            and   re_operacion   = @o_operacion
            and   re_fecha_crea  = @s_date)
      begin
         --existe una instrucci¢n de renovaci¢n aplicada por el batch
         if exists   (select 1 from pf_renovacion
               where re_estado   = 'A'
               and   re_operacion   = @o_operacion
               and   re_fecha_valor = @s_date)
         begin
            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file     = @t_file,
               @t_from     = @w_sp_name,
               @i_num      = 141209
            return 141209
         end
         else
         begin
            --existe instrucci¢n de renovación pero aplicada en otra fecha
            if exists   (select 1 from pf_renovacion
                  where re_estado   = 'A'
                  and   re_operacion   = @o_operacion
                  and   re_fecha_valor <> @s_date)
            begin
               exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file     = @t_file,
                  @t_from     = @w_sp_name,
                  @i_num      = 141204
               return 141204
            end
            else  -- no existe renovacion o existe una en estado no aplicada
            begin
               exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file     = @t_file,
                  @t_from     = @w_sp_name,
                  @i_num      = 141210
               return 141210
            end
         end
      end
   end
   /*****FIN CCR Validacion renovacion en linea***************************/


   ---------------------------------------------------------------------
   -- Desplegar unicamente operaciones de los funcionarios relacionados
   -- al funcionario que aprueba pantalla de activacion
   ---------------------------------------------------------------------
   if @i_aprobacion = 'S'
   begin
      select @w_funcionario = fu_funcionario
      from   pf_funcionario
      where  fu_funcionario = @s_user        -- funcionario que se logea
        and  fu_tautorizacion = 'APRO'
        and  fu_func_relacionado = @o_oficial              -- funcionario que aperturo la operacion

      if @@rowcount = 0
      begin
         ----------------------------------------------------------------
         -- Verifica usuario autorizado pero sin funcionario relacionado
         ----------------------------------------------------------------
         select @w_funcionario = fu_funcionario
         from pf_funcionario
         where fu_funcionario = @s_user
           and fu_tautorizacion = 'APRO'
           and fu_func_relacionado is null

         if @@rowcount = 0
         begin
            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 141058
            return 1
         end
      end
   end

   ----------------------------------------
   --VALIDACION ENTE CIFRADO, MENOR DE EDAD
   ----------------------------------------
   if @i_flag_valida_cliente = 'S'
   begin

      declare beneficiarios cursor
          for select en_subtipo,
                     p_fecha_nac
                from cobis..cl_ente,
                     pf_beneficiario
               where en_ente      = be_ente
                 and be_operacion = @o_operacion
                 and be_estado    = 'I'
                 and be_tipo      = 'T'
      open  beneficiarios
      fetch beneficiarios into @w_en_subtipo,
                               @w_fecha_nac

      while @@fetch_status <> -1
      begin
         if @@fetch_status = -2
         begin
            close beneficiarios
            deallocate beneficiarios
            raiserror ('200001 - Fallo lectura del cursor beneficiarios', 16, 1)
            return 0
         end

         -------------------------------------
         -- Verificacion para cliente cifrado
         -------------------------------------
         if @w_en_subtipo = 'I' and @w_par_cliente_cif = 'N' and @i_flag_valida_cif = 'S'
         begin
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 141177 --Transaccion no permitida. Cliente Cifrado entre propietarios.
         break
            return 1
         end

         if @w_en_subtipo = 'I' and @w_par_cliente_cif_blq = 'N' and @i_flag_valida_cif_blq = 'S'
         begin
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 141177 --Transaccion no permitida. Cliente Cifrado entre propietarios.
            break
            return 1
         end

      fetch beneficiarios into @w_en_subtipo,
                               @w_fecha_nac
      end --del while
      close beneficiarios
      deallocate beneficiarios
   end

   ----------------------------------------------------------------------
   -- Se imprime vuelto entregado al cliente en caso de haberlo aplicado
   ----------------------------------------------------------------------
   select @o_vuelto = isnull(sum(dp_monto), 0)
     from pf_det_pago
    where dp_operacion = @o_operacion
      and dp_tipo = 'VUL'

   if isnull(@o_moneda,1) = @w_moneda_base
   begin
      select @o_vuelto = @o_vuelto - isnull(mm_valor,0)
        from pf_mov_monet
       where mm_operacion = @o_operacion
         and mm_estado = 'A'
         and mm_tran = 14928
   end
   else
   begin
      select @o_vuelto = @o_vuelto - isnull(mm_valor_ext,0)
        from pf_mov_monet
       where mm_operacion = @o_operacion
         and mm_estado = 'A'
         and mm_tran = 14928
   end

   --------------------------------------------------------------------------------------------------
   -- Devolver la ultima fecha de cambio en la pantalla de mantenimiento de depositos operaciones ACT
   --------------------------------------------------------------------------------------------------
   select @o_max_sec  = max(co_secuencial)
   from   pf_cambio_oper
   where  co_operacion = @o_operacion

   select @o_fech_camb = co_fecha
   from   pf_cambio_oper
   where  co_operacion = @o_operacion
     and  co_secuencial = @o_max_sec

   select @o_instruccion = isnull(in_instruccion,'')
     from pf_instruccion
    where in_operacion = @o_operacion
      and isnull(in_estadoxren,'N') = 'N'


   select @o_provincia = cobis..cl_provincia.
          pv_descripcion
     from cobis..cl_provincia, cobis..cl_ciudad, cobis..cl_oficina
    where  cobis..cl_oficina.of_oficina = @o_oficina and
           cobis..cl_ciudad.ci_ciudad  =  cobis..cl_oficina.of_ciudad and
           cobis..cl_provincia.pv_provincia = cobis..cl_ciudad.ci_provincia

    select @o_tran_sabado = td_tran_sabado  -- GES 05/14/01 CUZ-009-044
      from pf_tipo_deposito
     where td_mnemonico = @o_toperacion

   ----------------------------------------------------------------------------------------
   -- Verificar si operacion tiene tiempo de tránsito para reflejar en pantalla activacion
   -- y apntalla de consulta detallada siempre y cuando la operacion sea ING.
   ----------------------------------------------------------------------------------------
   if @i_activacion = 'S' and @o_estado = 'ING'
   begin

      select @o_transito = isnull(max(mm_ttransito),0)   --LIM 09/DIC/2005
      from pf_mov_monet
      where mm_operacion = @o_operacion
         and  mm_tran = 14901
         and mm_secuencia = 0
         and mm_estado is null

      if @o_transito is null
         select @o_transito = 0

      end -- @i_activacion = 'S'

   if @i_flag = 'S'
   begin
      if exists(select * from pf_tipo_deposito
                 where td_mnemonico = @o_toperacion
                   and td_mantiene_stock = 'S')
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 141149
         return 141149
      end
   end

   --CVA Oct-28-06 Verificar el pago pendiente del batch
   if @i_flag_pago = 'S'
   begin
        if exists(select op_operacion from pf_operacion
        where op_num_banco = @o_num_banco
               and isnull(op_pago_interes,'S') = 'N')
   begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 141220
         return 141220
   end
   end

   if @i_flag='N'
   begin
      select @o_mantiene = td_mantiene_stock,
             @o_disponible = td_stock
        from pf_tipo_deposito
       where td_mantiene_stock = 'S'
         and td_mnemonico = @o_toperacion

      if @o_mantiene = 'S'
         select @o_numdoc=(select count(*) from pf_det_lote
          where dl_lote=@i_cuenta)
   end

-- print '@o_estado, @i_estado1, @i_estado2, @i_estado3, @o_accion_sgte, @i_accion_sgte: ' + @o_estado + ' ' + @i_estado1 + ' ' + @i_estado2 + ' ' + @i_estado3 + ' ' + @o_accion_sgte + ' ' + @i_accion_sgte

   if not ((@o_estado like @i_estado1 )
            or (@o_estado like @i_estado2  and @o_accion_sgte like @i_accion_sgte)
            or ( @o_estado like @i_estado3 ))
   begin
      if @o_estado = 'CAN'
         select @w_msg_out = 'Operacion no permitida, el deposito se encuentra cancelado'
                else
                  if @o_aprobado = 'N'                   --LIM 17/NOV/2005
                     select @w_msg_out = 'Operacion no permitida, el deposito no ha sido aprobado'
                  else
               if (@o_aprobado = 'S') and (@o_estado ='ING' or @o_estado = 'XACT')  --LIM 17/NOV/2005                --LIM 17/NOV/2005
                        select @w_msg_out = 'Operacion no permitida, el deposito no ha sido activado'

               else
               if @o_accion_sgte = 'XCAN'                         --LIM 01/NOV/2005
                  select @w_msg_out = 'Operacion no permitida, el deposito tiene instruccion de cancelacion'
               else
                  if @o_accion_sgte = 'XREN'                         --LIM 01/NOV/2005
                     select @w_msg_out = 'Operacion no permitida, el deposito tiene instruccion de renovacion'
                  else                                         --LIM 01/NOV/2005
                     select @w_msg_out = 'Operacion o transaccion no permitida'
      select @w_msg_out = '[' + @w_sp_name +'] ' + @w_msg_out
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141112,
         @i_msg   = @w_msg_out      --LIM 01/NOV/2005
      return 141112
   end

   --CVA Set-29-05
   if @i_bloqueado = 'S'
   begin
      if not (@o_retenido = @i_bloqueado)
      begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 141112,
            @i_msg   = 'Dpf. no tiene montos bloqueados'
         return 141112
      end
   end

   if @i_bloqueo_leg = 'S'
   begin
      if not (@o_bloqueo_legal = @i_bloqueo_leg)
      begin
        exec cobis..sp_cerror
            @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 141112,
               @i_msg   = 'Dpf. no esta bloqueado legalmente'
         return 141112
      end
   end


   if  @i_pignorado = 'S'
   begin
      if not (@o_pignorado = @i_pignorado)
      begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 141112,
            @i_msg   = 'Dpf. no tiene monto pignorado'
         return 141112
      end
   end

   /*********************************************************
      CCR VALIDAR QUE NO SE PUEDA CANCELAR, INCREMENTAR, DISMINUIR, MANTENER UN DPF
      QUE TIENE UNA INSTRUCCION DE CANCELACION/RENOVACION
   *********************************************************/
   if @i_flag_val_instruccion = 'S'
   begin
      if isnull(@o_accion_sgte, 'NULL') is null
      begin
         exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 141191
         return 141191
      end
   end

   /********************************************************************
   CCR VERIFICAR SI HAY TRANSACCIONES QUE AUN NO PASAN POR CAJA
   ********************************************************************/
   if @i_val_caja = 'S'
   begin
      if exists   (select 1 from cob_pfijo..pf_mov_monet
            where mm_operacion   = @o_operacion
            and   mm_producto in ('EFEC', 'CHQP', 'CHG', 'CHQL', 'CHQI', 'CHQE'))
      begin
         select @w_val_caja = 'S'
      end
      else
      begin
         select @w_val_caja = 'N'
      end
   end
   ----------------------------------------------------------------------
   -- Lectura de los Registros relacionados con el registro de Operacion
   ----------------------------------------------------------------------
   select @o_en_nombre_completo = case when en_nomlar = ''
                                       then p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre + ' '
                                       else en_nomlar
                                  end ,

     @o_ced_ruc = en_ced_ruc
     from cobis..cl_ente
    where en_ente  = @o_ente

   select @o_of_nombre      = of_nombre,
     @o_ciudad        = ci_descripcion
     from cobis..cl_oficina, cobis..cl_ciudad
    where of_oficina        = @o_oficina
      and of_ciudad         = ci_ciudad

   if @i_cert = 'S'
   select @o_mo_descripcion = mo_simbolo
     from cobis..cl_moneda
    where mo_moneda         = @o_moneda
   else
   select @o_mo_descripcion = mo_descripcion
     from cobis..cl_moneda
    where mo_moneda         = @o_moneda

   select @o_pp_descripcion = pp_descripcion,
     @o_meses = pp_factor_en_meses
     from pf_ppago
    where rtrim(pp_codigo)         = rtrim(@o_ppago)

   if @o_ppago='NNN'
      select @o_pp_descripcion='AL VENCIMIENTO'


   select @o_fu_nombre      = fu_nombre
     from cobis..cl_funcionario
    where fu_login          = @o_oficial

   --GAR 22-feb-2005 DP00026
   select @o_captador_nombre      = fu_nombre
     from cobis..cl_funcionario
    where fu_login          = @o_captador

   select @o_desc_toperacion = td_descripcion
     from pf_tipo_deposito
    where  @o_toperacion = td_mnemonico

   select @o_desc_categoria = y.valor
     from cobis..cl_tabla    x,
          cobis..cl_catalogo y
    where x.tabla  = 'pf_categoria'
      and x.codigo = y.tabla
      and y.codigo = @o_categoria

   select @o_desc_categoria_cupon = y.valor
     from cobis..cl_tabla    x,
          cobis..cl_catalogo y
    where x.tabla  = 'pf_categoria'
      and x.codigo = y.tabla
      and y.codigo = @o_categoria_cupon

   if @o_direccion  IS NOT null
      select @o_cd_descripcion = di_barrio + '/' + di_descripcion
   from cobis..cl_direccion
       where di_ente = isnull(@o_ente_corresp,@o_ente)   --xca
    and  di_direccion  = @o_direccion
   else
      if @o_casilla IS NOT null
         select @o_cd_descripcion = cs_valor + '-Zona' + (select zp_descripcion from cobis..cl_codpos where zp_coddep = a.cs_provincia and zp_codzona = a.cs_emp_postal)
           from cobis..cl_casilla a
          where  cs_ente     = isnull(@o_ente_corresp,@o_ente)
            and  cs_casilla  = @o_casilla
      else
    select @o_cd_descripcion = of_nombre
   from cobis..cl_oficina
   where of_oficina = @o_sucursal

      select @w_dia_vencido = datediff(dd,@s_date,@o_fecha_ven)

   if @w_dia_vencido >=0
      select @o_dia_vencido = 0
   else
      select @o_dia_vencido = -@w_dia_vencido


   if @o_fpago = 'VEN'
      if @o_total_int_ganados = 0 and @o_total_int_pagados = 0
         select @w_total = @o_total_int_estimado  - @o_total_int_pagados
      else
         select @w_total = @o_total_int_ganados  - @o_total_int_pagados


--  print '@o_fpago %1! , @o_int_ganado %2! , @o_int_pagados %3! ',@o_fpago, @o_int_ganado, @o_int_pagados

   if @o_fpago in ('ANT','PRA')  -- 13-Mar-2000 PRA
      select @w_total = @o_total_int_ganados  - @o_total_int_estimado
   if @o_fpago = 'PER'
      --if @o_int_ganado = 0 and @o_int_pagados = 0
      --   select @w_total = @o_int_estimado  - @o_int_pagados
      --else
      --NYMVU%
         select @w_total = @o_total_int_ganados - @o_total_int_pagados

   --if @o_int_ganado = 0
   --   select @w_total_aux = 0
   --else
   select   @w_total_aux = @o_int_dias_vencidos

   --INI NYM DPF00015 ICA
   exec @w_return = cob_pfijo..sp_aplica_impuestos                   -- GAL 14/SEP/2009 - INTERFAZ - IMPCOL
   @s_ofi             = @s_ofi,
   @i_ente            = @o_ente,
   @i_capital         = @w_total,
   @i_plazo           = @o_num_dias,
   @i_base_calculo    = @o_dias_anio,
   @o_retienimp       = @o_retienimp      out,
   @o_tasa_retencion  = @o_tasa_retencion out,
   @o_valor_retencion = @o_impuesto       out

   if @w_return <> 0
   begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = @w_return
      return @w_return
   end

   --print 'NYM CONTOTOP  @o_retienimp %1! , @o_tasa_retencion %2! , @o_impuesto %3! , @o_ret_ica %4! , @o_tasa_ica %5! , @o_imp_ica %6!', @o_retienimp, @o_tasa_retencion, @o_impuesto, @o_ret_ica, @o_tasa_ica, @o_imp_ica
   --PRINT 'nym CONTOTOP @o_fecha_ven %1! ', @o_fecha_ven

   select @w_dias = datediff(dd,@o_fecha_valor,@s_date)

   if @o_estado='REN'
   begin
      select @o_operacion_new     =re_operacion_new,
             @o_fecha_renovacion  =re_fecha_valor --GAR 17-mar-2005 DP00022
   from pf_renovacion
       where re_operacion=@o_operacion

      select @o_num_banco_new=op_num_banco
   from pf_operacion
       where op_operacion=@o_operacion_new
   end

   if @o_duplicados = 99
      select @o_duplicados = 0


   select @o_dias_antes_impresion = pa_tinyint
     from cobis..cl_parametro
    where pa_nemonico = 'DIC'
      and pa_producto = 'PFI'

   ---------------
   -- Condiciones
   ---------------
   set rowcount  1
   select @w_ente2 =be_ente,
          @o_condicion2 = be_condicion
     from pf_beneficiario
    where be_operacion = @o_operacion
      and be_rol = 'A'

   if @@rowcount <> 0
   begin
      select @o_alterno = p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre + ' '
        from cobis..cl_ente
       where en_ente = @w_ente2

      set rowcount 1
      select @w_ente3 =be_ente,
             @o_condicion3 = be_condicion
   from pf_beneficiario
       where be_operacion = @o_operacion
         and be_rol = 'A'
         and be_ente <> @w_ente2

      if @@rowcount <> 0
      begin
         select @o_alterno3 = p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre + ' '
           from cobis..cl_ente
          where en_ente           = @w_ente3
      end
      else
         select @o_condicion3 = ''
   end
   else
      select @o_condicion2 = ''

      ------------------
      -- Capital Pagado
      ------------------
   select @o_capital_pagado =pa_money
     from cobis..cl_parametro
         where pa_nemonico = 'PROVCB'

      --
   select @o_telefono2 =te_valor
   from cobis..cl_telefono
  where te_ente = @o_ente
      and te_direccion = @o_direccion
      and te_secuencial = 2

  ------------------------------------------------------------
  -- CALCULO CAPITAL INICIAL GAR 17-mar-2005 DP00022
  ------------------------------------------------------------
     select @o_capital_inicial = 0

     select @o_capital_inicial = isnull(hi_valor, 0)
     from   pf_historia
     where  hi_operacion = @o_operacion
       and  hi_trn_code  = 14901
     if @@rowcount = 0
     begin
        select @o_capital_inicial = isnull(hi_valor, 0)
        from   pf_historia
        where  hi_operacion = @o_operacion
          and  hi_trn_code  = 14953

     end

  --------------------------------------------------------------------------
  -- CAPITAL INICIAL DEL ULTIMO PERIODO DE RENOVACION/PRORROGA O APERTURA
  --------------------------------------------------------------------------
  select @o_capital_periodo = 0

  select @o_capital_periodo = isnull(hi_valor,0)
  from pf_historia
  where hi_operacion = @o_operacion
    and hi_trn_code  in (14919, 14947)
    and hi_fecha     =  @o_fecha_valor
  if @@rowcount = 0
  begin
     select @o_capital_periodo = isnull(hi_valor, 0)
     from   pf_historia
     where  hi_operacion = @o_operacion
       and  hi_trn_code  = 14901
  end



  /* OFICIAL PRINCIPAL Y SECUNDARIO */
  select @o_nombre_oficial_principal = fu_nombre
  from   cobis..cl_funcionario
  where  fu_login          = @o_oficial_principal

  select @o_nombre_oficial_secundario = fu_nombre
  from   cobis..cl_funcionario
  where  fu_login          = @o_oficial_secundario


  select @o_nom_ente_corresp = case when ltrim(rtrim(en_nomlar)) = ''
                               then p_p_apellido + ' ' + p_s_apellido + ' '+ en_nombre + ' '
                               else en_nomlar
                               end
    from cobis..cl_ente
   where en_ente = @o_ente_corresp



  select @o_desc_origen_fondos = valor
  from  cobis..cl_tabla A,
        cobis..cl_catalogo B
  --where A.tabla = 'pf_origen_fondos'
  where A.tabla = 'cl_orig_fond' --LIM 31/ENE/2006
  and   A.codigo = B.tabla
  and   B.codigo = @o_origen_fondos


  select @o_desc_proposito_cuenta = valor
  from  cobis..cl_tabla A,
        cobis..cl_catalogo B
  --where A.tabla = 'pf_prop_cuenta'
  where A.tabla = 'cl_pro_cta'      --LIM 31/ENE/2006
  and   A.codigo = B.tabla
  and   B.codigo = @o_proposito_cuenta


  select @o_desc_producto_bancario1 = valor
  from  cobis..cl_tabla A,
        cobis..cl_catalogo B
  where A.tabla = 'pf_otros_prod_bancarios'
  and   A.codigo = B.tabla
  and   B.codigo = @o_producto_bancario1


  select @o_desc_producto_bancario2 = valor
  from  cobis..cl_tabla A,
        cobis..cl_catalogo B
  where A.tabla = 'pf_otros_prod_bancarios'
  and   A.codigo = B.tabla
  and   B.codigo = @o_producto_bancario2

  select @o_saldo_disponible = 0
  select @o_saldo_disponible = isnull(@o_monto, 0) - isnull(@o_monto_pgdo, 0) - isnull(@o_monto_blq, 0) - isnull(@o_monto_blqlegal ,0)

  select @o_codsuper = ''


  --I. CVA May-12-06
  select @o_monto_prox_pago = 0
  if   @o_total_int_pagados = @o_total_int_estimado
   select @o_monto_prox_pago = 0
  else
   select @o_monto_prox_pago = @o_int_estimado - @o_int_pagados
  --F. CVA May-12-06




--+-+Cambios para buscar fecha de inicio para operaciones producto de Fraccionamiento o Consolidacion
if @o_op_fecha_ult_pago_int_ant > @o_fecha_ult_pg_int
   select @w_fecha_ini_per = @o_op_fecha_ult_pago_int_ant
else
   select @w_fecha_ini_per = @o_fecha_ult_pg_int

-- Obtiene el nuevo plazo
if @o_op_dias_reales = 'S'
   select @o_num_dias_new = datediff(dd,@w_fecha_ini_per,@o_fecha_ven)
else
begin
   exec sp_funcion_1 @i_operacion   = 'DIFE30',
            @i_fechai   = @w_fecha_ini_per,
            @i_fechaf   = @o_fecha_ven,
            @i_dia_pago = @o_dia_pago,
            @o_dias     = @o_num_dias_new out
end


  if @o_localizado = 'S'                     --LIM 15/NOV/2005
   select @o_localizado_out = @o_localizado + ' - ' + convert(varchar(10),@o_fecha_localizacion,@i_formato_fecha)
  else
   select @o_localizado_out = isnull(@o_localizado,'N') + ' - ' + convert(varchar(10),@o_fecha_no_localiza,@i_formato_fecha)

     select @o_alianza = al_alianza, 
            @o_des_alianza = isnull((al_nemonico + ' - ' + al_nom_alianza), '  ')
     from cobis..cl_alianza_cliente with (nolock),
        cobis..cl_alianza      with (nolock)
   where ac_ente    = @o_ente
     and ac_alianza = al_alianza
     and al_estado  = 'V'
     and ac_estado  = 'V'
 
   
 if @i_flag_firma = 'S'
 begin
    select  'NOMBRE:         '  = @o_en_nombre_completo
 end
 else
 begin
  if @i_siguientes = 'N' --12-Abr-2000 Tasa Variable
  begin
      select
       'NUMERO DE LA OPERACION'  = @o_num_banco,
       'CLIENTE TITULAR: '       = @o_ente,
       'NOMBRE:         '        = @o_en_nombre_completo,
       'TIPO DE OPERACION: '     = @o_desc_toperacion,
       'CATEGORIA:         '     = @o_desc_categoria,
       'OFICINA APERTURA:  '     = @o_of_nombre,
       'MONEDA: '                = @o_mo_descripcion,
       'PLAZO:  '                = @o_num_dias,
       'MONTO INICIAL: '         = @o_monto,
       'MONTO ACTUAL:  '         = @o_capital_inicial, /*10*/
       'MONTO EN GARANTIA: '     = @o_monto_pgdo,
       'MONTO BLOQUEADO '        = @o_monto_blq,
       'TASA '                   = @o_tasa,
       'INTERESES GANADOS: '     = @o_int_ganado,         /*14*/
       'INTERESES ESTIMADO: '    = @o_int_estimado,       /*15*/
       'INTERESES PAGADOS:  '    = @o_int_pagados,        /*16*/
       'TOTAL INT GANADOS: '     = @o_total_int_ganados,  /*17*/
       'TOTAL INT PAGADOS: '     = @o_total_int_pagados,  /*18*/
       'TOTAL INT ESTIMADOS:'    = @o_total_int_estimado, /*19*/
       'CAPITALIZA INTERESES: '  = @o_tcapitalizacion,   /*20*/
       'FORMA DE PAGO: '         = @o_fpago,
       'PERIODO CAP/PAGO: '      = @o_pp_descripcion,
       'DUPLICADOS:       '      = @o_duplicados,
       'RENOVACIONES:     '      = @o_renovaciones,
       'ESTADO:           '      = @o_estado,
       'ESTA EN GARANTIA? '      = @o_pignorado,
       'OFICIAL:          '      = @o_fu_nombre,
       'DESCRIPCION:      '      = @o_descripcion,
       'FECHA INGRESO    :'      = convert(char(10),@o_fecha_ing, @i_formato_fecha),/*29*/
       'FECHA ACTIVACION :'      = convert(char(10),@o_fecha_valor, @i_formato_fecha),/*30*/
       'FECHA VENCIMIENTO:'      = convert(char(10),@o_fecha_ven,@i_formato_fecha),
       'PROXIMA FECHA DE PAGO:'  = convert(char(10),@o_fecha_pg_int, @i_formato_fecha),
       'FECHA ULT PG INT: '      = convert(char(10),@o_fecha_ult_pg_int, @i_formato_fecha),
       'FECHA ULT CALCULO:'      = convert(char(10),@o_fecha_ult_calculo, @i_formato_fecha),
       'RETIENE IMP: '           = @o_retienimp,
       'IMPUESTO X RETENER: '    = @o_impuesto, /*36*/
       'DIAS VENCIDOS '          = @o_dia_vencido,
       'BASE DE CALCULO: '       = @o_dias_anio,
       'DESCRIPCION: '           = @o_pd_descripcion,
       'DIA DE PAGO: '           = @o_dia_pago, /*40*/
       'COD: TIPO OP: '          = @o_toperacion,
       'COD. MONEDA: '           = @o_moneda,
       'COD CATEGORIA: '         = @o_categoria,
       'COD: FORMA PAGO: '       = @o_ppago,
       'ACCION SIGUIENTE: '      = @o_accion_sgte,
       'TOTAL IMPUESTO RETENIDO' = @o_total_int_retenido,
       'FECHA DE CANCELACION'    = convert(char(10),@o_fecha_can, @i_formato_fecha),
       'TASA DE IMPUESTO'        = @w_tasa,
       'DIAS'                    = @w_dias,
       'NUEVA OPERACION'         = @o_num_banco_new, /*50*/
       'CED RUC'                 = @o_ced_ruc,
       'DIRECC/CASILLA/NN'       = @o_cd_descripcion,
       'TELEFONO'                = @o_telefono,
       'CONVERSION'              = @o_meses,
       'NUM. DOCUMENTOS'         = @o_numdoc,
       'MANTIENE INVENTARIO'     = @o_mantiene,
       'DISPONIBLE'              = @o_disponible,
       'MONEDA PAGO'             = @o_moneda_pg,
       'COD DIRECCI'             = @o_direccion,
       'CIUDAD'                  = @o_ciudad, /*60*/
       'No. PREIMPRESO'          = @o_preimpreso ,
       'FACTOR EN MESES'         = @o_factor_en_meses,
       'NOMBRE ALTERNO '         = @o_alterno,
       'OPERACION'               = @o_operacion,
       'OFICINA'                 = @o_oficina,
       'NUM.IMP.ORIG'            = @o_num_imp_orig,
       'DIAS ANTES IMPR.CERT'    = @o_dias_antes_impresion,
       'IMPUESTO AL CAPITAL'     = @o_impuesto_capital,
       'CONDICION 2'             = @o_condicion2,
       'CONDICION 3'             = @o_condicion3, /*70*/
       'CAPITAL PAGADO'          = @o_capital_pagado ,
       'ALTERNO 3 '              = @o_alterno3,
       'TELEFONO 2'              = @o_telefono2,
       'LEY'                     = @o_ley,
       'ORIGINAL '               = @o_cert_origen,
       'FECHA CAMB.TASA '        = convert(char(10),@o_fecha_cal_tasa, @i_formato_fecha), /*76*/
       'FECHA REPROGRAMACION'    = convert(char(10),@o_fecha_cert_origen, @i_formato_fecha),
       'TASA CONGELADO'          = @o_tasa_congelado,
       'FECHA COMERCIAL'         = @o_anio_comercial, --04/04/2000 Fecha Comercial /*79*/
       'TASA VARIABLE S/N'       = @o_tasa_variable,  --12-Abr-2000 Tasa Var.
       'FLAG TASA EFECTIVA'      = @o_flag_tasaefec,  --04-May-2000 Efect/Nom
       'VALOR TASA EFECTIVA'     = @o_tasa_efectiva,  --04-May-2000 Efect/Nom
       'TOTAL INT ACUMULADO'     = @o_total_int_acumulado, --12-May-2000 Fus/fra
       'TOT INT ESTIMADO ANT'    = @o_tot_int_est_ant,  --12-May-2000 Fus/Fra
       'RESIDUO'                 = @o_residuo,  /*85*/--12-May-2000 Fus/Fra
       'IMPRIME'                 = @o_imprime,        --12-May-2000 Fus/Fra
       'PLAZO ANT'               = @o_plazo_ant,      --12-May-2000 Fus/Fra
       'FECHA VENCIMIENTO ANT'   = convert(char(10),@o_fecven_ant, @i_formato_fecha),     --12-May-2000 Fus/Fra
       'FECHA ORDEN ACTIVA'      = convert(char(10),@o_fech_ord_act, @i_formato_fecha),   --12-May-2000 Fus/Fra
       'INT. PROVISION'          = @o_int_provision,  -- **90** 12-May-2000 Fus/Fra
       'RETENIDO ?'              = @o_retenido,       --12-May-2000 Fus/Fra
       'TIPO DE MONTO'           = @o_tipo_monto,     --12-May-2000 Fus/Fra
       'TIPO DE PLAZO'           = @o_tipo_plazo,     --12-May-2000 Fus/Fra
       'ESTATUS PRORROGA'        = @o_estatus_prorroga,--12-May-2000 Fus/Fra
       'NUM. PRORROGAS'          = @o_num_prorroga,   --12-May-2000 Fus/Fra
       'MNEMONICO TASA VAR'      = @o_mnemonico_tasavar,--12-Abr-2000 Tasa V.
       'MODALIDAD TASA'          = @o_modalidad_tasa, --12-Abr-2000 Tasa Var.
       'PERIODO TASA VAR'        = @o_periodo_tasa,--12-Abr-2000 Tasa Var.
       'OPERADOR'                = @o_operador, --12-Abr-2000 Tasa Var.
       'SPREAD'                  = @o_spread, --12-Abr-2000 Tasa Var.
       'TRAN.SABADO'             = @o_tran_sabado, --GES 05/14/01 CUZ-009-042
       'PORC. COMISION'          = @o_porc_comision,  /*102*/
       'COMISION'                = @o_comision,   /*103*/
       'PAGA COMISION'           = @o_paga_comision,  /*104*/
       'PROVINCIA OFICINA '      = @o_provincia,     /*105*/
       'MANEJA CUPON '           = @o_cupon,  -- GES 06/22/01 CUZ-020-031
       'CATEGORIA CUPON'         = @o_categoria_cupon, -- CUZ-020-061
       'DESC.CATEGORIA CUPON'    = @o_desc_categoria_cupon,  -- CUZ-020-062
       'CUSTODIA'                = @o_custodia, --WSM 16/07/01 DP-00034-15
       'INSTRUCCION'             = @o_instruccion, --JSA 17/08/2001 DP-000073
       'INCREMENTO PRORROGA'     = @o_incremento_prorroga, -- GES CUZ-024-052
       'VUELTO'                  = @o_vuelto,   -- JSA 04/01/2002
       'INACTIVO'                = isnull(@o_inactivo,'N'),    --LIM 22/OCT/2005 113
       'INCREMENTO SUSPENSO'     = @o_incremento_susp,      --LIM 22/OCT/2005 114
       'OFICIAL PRINCIPAL'       = @o_nombre_oficial_principal,   -- GES DP00010
       'FECHA ULT. INCR. DISM'   = @o_fecha_ult_inc_dism,        -- LIM 08/NOV/2005
       'LOCALIZADO'              = @o_localizado_out,         --LIM 15/NOV/2005
       'VALOR VUELTO'            = isnull(@o_monto_vuelto,0)     --LIM 01/FEB/2006




       end
       else --Si la consulta es para traer los siguientes reg. 12-Abr-2000 TVar.
       begin --12-Abr-2000 Tasa Variable
         select 'DESC. TASA VARIABLE'         = @o_desc_tasa_var,
                'PUNTOS FUERA LIMITE'         = @o_puntos,
                'CAPTADOR'                    = @o_captador,
                'BLOQUEO LEGAL'               = @o_bloqueo_legal,   --GAR 21-FEB-2005 DP00036
                'NOMBRE CAPTADOR'             = @o_captador_nombre, --GAR 22-feb-2005 DP00026              --5
                'APROBADO'                    = @o_aprobado,        -- GAR 23-feb-2005 DP00023
                'FECHA CREACION'              = convert(char(10),@o_fecha_crea, @i_formato_fecha), --KTA GB-GAPDP00049
                'ID OPERACION'                = @o_operacion,       --KTA GB-GAPDP00049
                'SECUENCIA MOV MON'           = @o_mon_sgte,        --KTA GB-GAPDP00049
                'MONTO BLOQUEO LEGAL'         = @o_monto_blqlegal,  --GAR 07-Mar-2005 DP00065              --10
                'CAPITAL INICIAL'             = @o_capital_inicial, --GAR 17-mar-2005 DP00022
                'FECHA DE RENOVACION'         = convert(char(10), @o_fecha_renovacion, @i_formato_fecha),--GAR 17-mar-2005 DP00022
                'PRORROGA AUTOMATICA'         = @o_prorroga_aut,    --GAR 17-mar-2005 DP00022
                'OFICIAL PRINCIPAL'           = @o_nombre_oficial_principal,  -- GES DP00010
                'OFICIAL SECUNDARIO'          = @o_nombre_oficial_secundario, -- GES DP00010               --15
                'LOGIN USUARIO'               = @o_oficial,            -- GES DP00010
                'ORIGEN FONDOS'               = @o_origen_fondos,      --KTA GB-GAPDP00143
                'PROPOSITO CUENTA'            = @o_proposito_cuenta,   --KTA GB-GAPDP00143
                'PRODUCTO BANCARIO1'          = @o_producto_bancario1, --KTA GB-GAPDP00143
                'PRODUCTO BANCARIO2'          = @o_producto_bancario2,  --KTA GB-GAPDP00143                 --20
                'DIAS REALES'                 = @o_op_dias_reales,   --gap DP00008
                'LOGIN OFI. PRIN.'            = @o_oficial_principal,   --gap DP00008
                'LOGIN OFI. SUPLE'            = @o_oficial_secundario,  --gap DP00008
                'COD. ENTE CORRESP'           = @o_ente_corresp,        --GAR GB-DP00120,
                'LOCALIZADO S/N'              = @o_localizado,                                    --25
                'FECHA LOCALIZACION'          = convert(varchar(10),@o_fecha_localizacion,@i_formato_fecha),
                'FECHA NO LOCALIZA'           = @o_fecha_no_localiza,
                'PLAZO ORIGINAL'              = @o_plazo_orig,
                'NOMBRE ENTE CORRESP'         = @o_nom_ente_corresp,
                'ULT. FECHA CAMBIO '          = convert(varchar(10),@o_fech_camb,@i_formato_fecha),                         --30
                'DESC ORIG FONDOS'            = @o_desc_origen_fondos,
                'DESC PROP CUENTA'            = @o_desc_proposito_cuenta,
                'DESC PROD BANC1'             = @o_desc_producto_bancario1,
                'DESC PROD BANC2'             = @o_desc_producto_bancario2,
                'CASILLA POSTAL'              = @o_casilla,  --CVA Set-6-05  --35
                'DIAS DE HOLD'                = @o_dias_hold,
                'SUCURSAL'                    = @o_sucursal,
                'CAJA'                        = isnull(@w_val_caja, 'X'),
                'SALDO DISPONIBLE'            = isnull(@o_saldo_disponible, 0),
                'CODIGO FUNDACION'            = @o_codsuper,  --CVA Oct-27-05   --40
                'TASA BASE'                   = @o_tasa_base,
                'DIAS FUSFRA'                 = @o_num_dias_new,   --+-+
                'FECHA VAL FRACFUS'           = convert(varchar(10),@w_fecha_ini_per,@i_formato_fecha),  --+-+
                'MONTO PROX. PAGO'            = @o_monto_prox_pago, --CVA May-12-05
                'AMORTIZACION POR PERIODO'    = @o_amortiza_per,
                'TOTAL AMORTIZADO'            = @o_total_amortizado,
                'FIDEICOMISO'                 = @o_fideicomiso,
                'CAPITAL INICIAL ULT.PER.VIG' = @o_capital_periodo,
                'MEDIO DE PAGO'               = @w_forma_pago,  --49
                'NUMERO DE CUENTA'            = @w_num_cuenta  , --50,
                'DESMATERIALIZA'              = @o_desmaterializa,
                'ISIN'                        = @o_isin,
                'FUNGIBLE'                    = @o_fungible,
                --NYM DPF00015 ICA
                'IMP_ICA'                     = @o_ret_ica,
                'VALOR IMPUESTO ICA'          = @o_imp_ica,
                'TASA IMPUESTO RENTA'         = @o_tasa_retencion,
                'TASA IMPUESTO ICA'           = @o_tasa_ica,
                'AUTORETENEDOR'               = @o_autoretenedor, --  58 NYM DPF000018 AUTORETENEDOR
                'INT VENCIDO COLOMBIA'        = @o_int_dias_vencidos,   --*-*
                'CAUSAL BLOQUEO ADMIN'        = @o_causa_op_retenido,
                'DESC. CAUSAL'                = @o_desc_causa_retenido,
                'ALIANZA'                     = @o_alianza,
                'DESC ALIANZA'                = @o_des_alianza    --63
       end    --12-Abr-2000 Tasa Variable
 end

end --@i_operacion = 'Q'
return 0

go
