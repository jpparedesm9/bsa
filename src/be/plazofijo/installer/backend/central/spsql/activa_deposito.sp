/************************************************************************/
/*      Archivo:                actioper.sp                             */
/*      Stored procedure:       sp_activa_deposito                      */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
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
/*      Este script cambia a las op.  de plazo fijo a estado activo,    */
/*      Realiza contabilizacion y puede ser reversado en mismo dia      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      13-Jul-95  Erika Sanchez      Creacion                          */
/*      25-Ago-95  Carolina Alvardo   XXXXXX                            */
/*            -05  N. Silva           Identacion, cuotas y renov        */
/*      22-Feb-07  Rolando Linares    Tomar la Codigo del beneficiario  */
/*                                    Para enviar a SBA si es clie. MIS */
/*      05-Oct-12  David Pulido       REQ 00329_GMF_PFIJO               */
/*      10-Ene-17  Jorge Salazar      DPF-H94952 MANEJO RETENCIONES MX  */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

if object_id('sp_activa_deposito') is not null
   drop proc sp_activa_deposito
go

create proc sp_activa_deposito(
      @s_ssn                  int             = NULL,
      @s_ssn_branch           int             = null,
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

      @i_num_banco            cuenta,
      @i_tipo                 char(1)         = 'N',
      @i_operacion            char(1)         = 'I',
      @i_normal               char(1)         = 'S',
      @i_preimpreso           int             = null,
      @i_impuesto             money           = 0,
      @i_tot_int              money           = 0,
      @i_numdoc               smallint        = 0,
      @i_operacion_ant        int             = NULL,
      @i_secuencia_ant        int             = NULL,
      @i_observacion          descripcion     = NULL,
      @i_en_linea             char(1)         = 'S',
      @i_incremento           money           = NULL
)
with encryption
as
declare
   @w_sp_name                      varchar(32),
   @w_descripcion                  varchar(150),
   @w_emite_orden                  char(1),
   @w_trn                          int,
   @w_r1                           float,
   @w_r2                           float,
   @w_return                       int,
   @w_tran_ape                     int,
   @w_stock                        int,
   @w_contador                     int,
   @w_con_movmonet                 char(1),        -- contabiliza movto. mon
   @w_tipo_deposito                int,
   @w_transito                     tinyint,
   @w_valor                        money,
   @w_total_pagar_ren              money,
   @w_valor_transito               money,
   @w_moneda_base                  tinyint,
   @w_codval                       varchar(20),  --se cambia tipo de dato
   @w_movmonet                     char(1),
   @w_mantiene_stock               char(1),
   @w_vuelto                       char(1),
   @w_vuelto_ren                   money,
   @w_secuencial                   int,
   @w_moneda                       smallint,
   @w_moneda_pg                    smallint,
   @w_producto                     tinyint,
   @w_tasa                         float,
   @w_tasa1                        float,
   @w_impuesto                     money,
   @w_impuesto_ren                 money,
   @w_impuesto_pg                  money,
   @w_impuest                      money,
   @w_imp                          money,
   @w_renova_todo                  char(1),
   @w_tcapitalizacion              char(1),
   @w_dias                         smallint,
   @w_numdoc                       smallint,
   @w_dia_pago                     tinyint,
   @w_ttransito                    smallint,
   @w_monto1                       money,
   @w_monto2                       money,
   @w_impuesto1                    varchar(10),
   @w_numdeci                      tinyint,
   @w_numdecipg                    tinyint,
   @w_factor                       float,
   @w_usadeci                      char(1),
   @w_num_banco                    cuenta,
   @w_num_banco_tmp                cuenta,
   @w_mm_oficina                   int,
   @w_producto_mnemonico           char(3),
   @w_moneda_desc                  descripcion,
   @w_mm_secuencia                 int, 

/*** En caso de que la moneda base no sea igual a la del deposito ***/
   @w_cotizacion                   money,
   @w_cotizacion_compra            money,
   @w_cotizacion_venta             money,
   @w_cotizacion_valor             money,
   @w_preimpreso                   int,

/* VARIABLES NECESARIAS PARA PF_OPERACION */
   @w_origen_fondos                catalogo,
   @w_proposito_cuenta             catalogo,
   @w_operacionpf                  int,
   @w_cuenta_dias                  int,
   @w_max_ttransito                int,
   @w_secuencia                    int,
   @w_secuencia_ren                int,
   @w_fecha_valor                  datetime,
   @w_fecha_temp_hoy               datetime,
   @w_fecha_ven                    datetime,
   @w_fecha_ven1                   datetime,
   @w_fecha_ven_ant                datetime,
   @w_fecha_pg_int                 datetime,
   @w_int_pagados                  money,
   @w_int_renovar                  money,
   @w_int_vencido                  money,
   @w_incremento                   money,
   @w_total_int_pagados            money,
   @w_total_int_estimado           money,
   @w_total_int_estim              money,
   @w_dif_estimado                 money,
   @w_dif_estim                    money,
   @w_dif_impuesto                 money,
   @w_int_estimado                 money,
   @w_total_int_acumulado          money,
   @w_total_pagar                  money,
   @w_total_pagar_pg               money,
   @w_total_pag                    money,
   @w_monto                        money,
   @w_money                        money,
   @w_imp_retenido                 money,
   @w_monto_pg_int                 money,
   @w_historia                     smallint,
   @w_dif                          smallint,
   @w_estado                       catalogo,
   @w_error                        int,
   @w_estado_ant                   catalogo,
   @w_oficina_ant                  smallint,
   @w_ch1                          catalogo,
   @w_ppago                        catalogo,
   @w_base_calculo                 smallint,
   @w_msg                          varchar(29),
   @w_fpago                        catalogo,
   @w_toperacion                   catalogo,
   @w_tplazo                       catalogo,
   @w_tplazo_cont                  catalogo,
   @w_tplazo_cont_old              catalogo,
   @w_gmf                          money,
   @w_fecha_mod                    datetime,
   @w_fecha_hoy                    datetime,
   @v_historia                     smallint,
   @v_estado                       catalogo,
   @v_num_dias                     int,
   @v_fecha_ven                    datetime,
   @v_total_int_estimado           money,
   @w_num_dias                     int,
   @w_num_dias_old                 int,
   @w_oficina                      smallint,
   @w_oficina_oper                 smallint,
   @w_total_int_estimado_cap       money,             -- 29-abr-99 capitalizacion xca B061
   @w_interes_neto                 money,             -- 29-abr-99 capitalizacion xca B061
   @w_tasa_variable                char(1),           -- 12-Abr-2000 Tasa Variable.
   @w_tasa_efec_anual              float,             -- 12-Abr-2000 Tasa Variable.
   @o_comprobante                  int,
   @w_retiene_capital              char(1),
/*  Variables para det_cheque_tmp   */
   @w_ct_sub_secuencia             smallint,
   @w_ct_banco                     catalogo,
   @w_ct_cuenta                    cuenta,
   @w_ct_cheque                    int,
   @w_operacion_tmp                int,
   @w_ct_valor                     money,
   @w_ct_val                       money,
   @w_ct_val_tot                   money,
   @w_ct_fpago                     catalogo,
   @w_ct_descripcion               varchar(255),
   @w_ct_fecha_crea                datetime,
   @w_ct_fecha_mod                 datetime,
   @w_fecha_crea                   datetime,
/* VARIABLES NECESARIAS PARA PF_MOV_MONET */
   @w_mm_sub_secuencia             tinyint,
   @w_mm_producto                  catalogo,
   @w_mm_cuenta                    cuenta,
   @w_mm_moneda                    smallint,
   @w_mon_sgte                     int,
   @w_mm_valor                     money,
   @w_mm_valor_ext                 money,
   @w_mm_impuesto                  money,
   @w_mm_impuesto_capital_me       money,
   @w_mm_tipo                      char(1),
   @w_pt_forma_pago                catalogo,
   @w_pt_beneficiario              int,
   @w_pt_cuenta                    cuenta,
   @w_pt_monto                     money,
   @w_pt_monto_ext                 money,
   @w_pt_porcentaje                float,
   @w_pt_moneda                    smallint,
   @w_monto_mov                    money,
   @w_retieneimp                   char(1),
   @w_contor                       tinyint,
   @w_sub_sec                      tinyint,
   @w_pt_secuencia                 tinyint,
   @w_fpago_ticket                 tinyint,        -- MCA 27-Oct-99
   @w_op_dias_reales               char(1),        -- 04/04/2000 Fecha Comercial
   @w_ente                         int,            -- 07/26/2000 Rep SIPLA
   @w_terceros                     char(1),        -- 07/26/2000 Rep SIPLA
   @w_monsipla_mn                  money,          -- 07/26/2000 Rep SIPLA
   @w_monsipla_me                  money,          -- 07/26/2000 Rep SIPLA
   @w_tran_sabado                  char(1),
/*Modificacion: Walter Solis  DP-00017-14 COMISIONES */
   @w_comision                     money ,
   @w_pt_tipo                      catalogo,
   @w_pt_cotizacion                money,          -- JSA 15/02/2002 Tipo cambio a decrementos en
   @w_pt_tipo_cotiza               char(1),        -- JSA 15/02/2002 renovaciones de operaciones
   @w_t_incre_dism                 money,
   @w_total_pagar_decremento       money,
   @w_total_vuelto                 money,
   @w_fp_producto                  tinyint,   -- para cr/db a la vez a cte/aho
   @w_flag_paso                    char(1),        -- para cr/db a la vez a cte/aho
   @w_cont_simultaneo              tinyint, -- para cr/db a la vez a cte/aho
   @w_pt_tipo_cliente              char(1),   -- gap DP00008 tipo de cliente
   @w_pt_oficina                   int,            -- gap DP00008 oficina de pago de cheque
   @w_aprobado                     char(1),
   @w_tran_inc                     int,
   @w_secuencia_aplm               int,
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
   @w_mm_benef_corresp             varchar(255),        --*-*
   @w_descripbenef                 varchar(250),
   @w_origen_ben                   varchar(1),   /*  RLINARES 02222007 */
   @w_campo40                      char(1),
   @w_idlote                       int,
   @w_conceptosb                   tinyint,
--Variables de beneficiario
   @w_cod_ben                      varchar(255), /*  RLINARES 02222007 */
   @w_be_ente                      int,
   @w_be_tipo                      char(1),
--Variables para escalonado
   @w_mnemonico_tasa               catalogo,
   @w_modalidad_tasa               char(1),
   @w_periodo_tasa                 smallint,
   @w_descr_tasa                   descripcion,
   @w_tipo_plazo                   catalogo,
   @w_modifica                     char(1),
   @w_batch                        char(1),
   @w_ctrlsuma                     money,
   -- IMPUESTOS
   @w_ret_ica                      char(1),
   @w_tasa_retencion               float,          -- GAL 14/SEP/2009 - INTERFAZ - IMPCOL
   @w_tasa_ica                     float,
   @w_base_ret                     money,
   @w_base_ica                     money,
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
   @w_mpago_chql                   varchar(10),     -- NYMR NR 192 
   @w_num_dias_antes               int,
   @w_plazo_orig                   int,
   @w_valor_retenido               money


/* Almacena nombre del sp */
select @w_sp_name = 'sp_activa_deposito'
select @w_ctrlsuma = 0

/*-------------------------------------*/
/**  Verificar codigo de transaccion  **/
/*-------------------------------------*/
if   (@t_trn <> 14940 or @i_tipo <> 'A') and
     (@t_trn <> 14914 or @i_tipo <> 'N')
begin
  exec cobis..sp_cerror
       @t_debug = @t_debug,
       @t_file  = @t_file,
       @t_from  = @w_sp_name,
       @i_num   = 141040
  return 141040
end

select @w_secuencial     = @s_ssn,
       @w_oficina        = @s_ofi,
       @w_impuesto       = 0,
       @w_vuelto         = 'N',
       @w_valor_transito = 0,
       @w_trn            = 14924,
       @w_factor         = 1,
       @w_flag_paso      = 'N',
       @w_t_incre_dism   = 0

select @s_date = convert(datetime, convert (varchar(10),@s_date,101))
select @w_fecha_hoy = @s_date

select @w_moneda_base = em_moneda_base
from cob_conta..cb_empresa where em_empresa = 1

-----------------------------------------------------------
-- Valida codigo de transaccion para aplicacion de vuelto
-----------------------------------------------------------
if @t_trn = 14940
   select @w_trn = 14901 -- aplica vuelto como apertura y no como 14924

select @w_cheque_ger = pa_char
from cobis..cl_parametro
where pa_nemonico='NCHG'
and pa_producto='PFI'

-- NYMR NR 192 MEDIO DE PAGO CHEQUE LOCAL
select @w_mpago_chql = pa_char
from cobis..cl_parametro
where pa_nemonico = 'NCHQL'
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


-----------------------------
-- OBTENCION MNEMONICO DE DPF
----------------------------
select @w_producto_mnemonico = pd_abreviatura from cobis..cl_producto
where pd_producto = 14

--------------------------------------------------------------------
-- Acceso a la tabla de operaciones para obtener datos del deposito
--------------------------------------------------------------------
select @w_operacionpf         = op_operacion,
       @w_estado              = op_estado,
       @w_toperacion          = op_toperacion,
       @w_historia            = op_historia,
       @w_fpago               = op_fpago,
       @w_monto               = op_monto,
       @w_moneda              = op_moneda,
       @w_moneda_pg           = convert(smallint,op_moneda_pg),
       @w_tcapitalizacion     = op_tcapitalizacion,
       @w_renova_todo         = op_renova_todo,
       @w_total_int_estim     = op_total_int_estimado,
       @w_producto            = op_producto,
       @w_int_pagados         = op_int_pagados,
       @w_oficina_oper        = op_oficina,
       @w_total_int_acumulado = isnull(op_total_int_acumulado,0),
       @w_num_dias            = op_num_dias,
       @w_num_dias_old        = op_plazo_ant, --MVG 25/09/2009
       @w_total_int_pagados   = op_total_int_pagados,
       @w_retieneimp          = op_retienimp,
       @w_fecha_valor         = op_fecha_valor,
       @w_fecha_ven           = op_fecha_ven,
       @w_tplazo              = op_tipo_plazo,
       @w_mon_sgte            = op_mon_sgte,
       @w_tasa1               = op_tasa,
       @w_ppago               = op_ppago,
       @w_base_calculo        = op_base_calculo,
       @w_fecha_pg_int        = op_fecha_pg_int,
       @w_fecha_crea          = op_fecha_crea,
       @w_fecha_mod           = op_fecha_mod,
       @w_op_dias_reales      = op_dias_reales,     -- 04/Abr/2000 Fecha Comercial
       @w_tasa_efec_anual     = op_tasa_efectiva,      -- 12-Abr-2000 Tasa Variable
       @w_tasa_variable       = op_tasa_variable,      -- 12-Abr-2000 Tasa Variable
       @w_ente                = op_ente,         --Rep. SIPLA
       @w_comision            = op_comision,
       @w_aprobado            = op_aprobado,
       @w_dia_pago            = op_dia_pago,           -- GAR GB-DP00120 Dia Pago
       @w_origen_fondos       = op_origen_fondos,
       @w_proposito_cuenta    = op_proposito_cuenta,
       @w_periodo_tasa        = op_periodo_tasa,
       @w_modalidad_tasa      = op_modalidad_tasa,
       @w_descr_tasa          = op_descr_tasa,
       @w_mnemonico_tasa      = op_mnemonico_tasa,
       @w_tipo_plazo          = op_tipo_plazo
  from cob_pfijo..pf_operacion
where op_num_banco = @i_num_banco
  and op_estado = 'ING'
if @@rowcount = 0
begin
   if @i_en_linea = 'S'
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 141004

      return  141004
  end
  else
  begin
     select @w_error = 141004
     goto ERROR
  end

end

if @w_aprobado <> 'S'
begin
   exec cobis..sp_cerror
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_num       = 141180

   return 141180
end

-----------------------------
-- OBTENCION DESCRIPCION MONEDA
----------------------------
select @w_moneda_desc = mo_descripcion from cobis..cl_moneda
where mo_moneda = @w_moneda

-----------------------------------------------------------------------------
-- No se puede activar una operacion si no se ha recibido, el dinero en Caja
-- si es con Cheques o Efectivo.
-----------------------------------------------------------------------------
select @w_fpago_ticket = count(*)
from pf_secuen_ticket
where st_num_banco = @i_num_banco
   and st_estado = 'I'
   and st_fpago <> 'REN'
   and st_fpago in (select fp_mnemonico
                      from pf_fpago
                     where fp_estado = 'A'
                       and (fp_mnemonico = 'EFEC' or fp_automatico = 'C'
                        or fp_mnemonico = 'TRAI'))
if @w_fpago_ticket > 0
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141153
   return  141153
end

---------------------------------------
-- Control para operaciones reversadas
---------------------------------------
if exists(select *
            from pf_secuen_ticket
           where st_num_banco = @i_num_banco
             and st_estado    = 'R')
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141157
   return  141157
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

select @w_usadeci = mo_decimales
from cobis..cl_moneda
where mo_moneda = @w_moneda_pg

if @w_usadeci = 'S'
begin
   select @w_numdecipg = isnull (pa_tinyint,0)
   from cobis..cl_parametro
   where pa_nemonico = 'DCI'
   and pa_producto = 'PFI'
end
else
   select @w_numdecipg = 0

if @w_moneda <> @w_moneda_base
begin
   set rowcount 1
   select @w_cotizacion_compra =co_compra_billete ,
         @w_cotizacion_venta = co_venta_billete,
         @w_cotizacion_valor = co_conta
   from cob_pfijo..pf_cotizacion
   where co_moneda = @w_moneda
     and co_fecha = @s_date
   order by co_hora desc

   select @w_cotizacion = @w_cotizacion_valor
   set rowcount 0
end

if @w_moneda <> @w_moneda_pg
begin
   exec sp_calc_cotiza
        @t_trn       = 14439,
        @i_moneda1   = @w_moneda,
        @i_moneda2   = @w_moneda_pg,
        @i_operacion = 'Q',
        @o_factor = @w_factor out
end

---------------------------------------------------
-- Verifica si tipo de operacion maneja inventario
---------------------------------------------------
select @w_mantiene_stock = td_mantiene_stock,
       @w_stock           = td_stock,
       @w_tran_sabado   = td_tran_sabado,
       @w_tipo_deposito = td_tipo_deposito
from pf_tipo_deposito
where td_mnemonico=@w_toperacion

select @w_tran_ape           = 14901,
       @w_tran_inc           = 14904, --incremento/disminucion
       @v_fecha_ven          = @w_fecha_ven,
       @v_num_dias           = @w_num_dias,
       @v_total_int_estimado = @w_total_int_estim

select @i_operacion = 'I'

select @w_impuesto_ren  = re_impuesto,
       @w_secuencia     = re_renovacion,
       @w_operacion_tmp = re_operacion,
--       @w_monto1        = re_monto, CVA Ago-02-06 para cuando no se ha realizado el inicio de dia y se hacen las renovaciones
       @w_monto1        = re_monto_renovar,
       @w_monto2        = re_monto_renovar,
       @w_int_renovar   = re_tot_int,
       @w_int_vencido   = re_int_vencido,
       @w_estado_ant    = re_estado_ant,
       @w_oficina_ant   = re_oficina_ant,
       @w_incremento    = re_incremento,
       @w_vuelto_ren    = re_vuelto
from pf_renovacion
where re_operacion_new  = @w_operacionpf
   and re_estado = 'A'
   and   re_fecha_crea  = (select max(re_fecha_crea)
            from pf_renovacion
            where re_operacion_new  = @w_operacionpf
            and re_estado = 'A')

if @@rowcount = 1
begin
   select @i_operacion = 'R'

   select @w_num_banco_tmp = op_num_banco,
          @w_fecha_ven_ant = op_fecha_ven,
          @w_plazo_orig    = op_plazo_orig
   from  pf_operacion
   where op_operacion = @w_operacion_tmp

  -----------------------------------------------------------------------------
  -- GES 05/17/99 RET.IMPTO 1% Para indicar en sp_aplica_mov a CTAS Inversion
  -- si se debe o no retener el 1% al generar la nota de credito automatica
  -- ya que el sp_retiene_capital compara la transaccion y el cliente
  -----------------------------------------------------------------------------
   exec @w_return = sp_retiene_capital
        @s_ssn             = @s_ssn,
        @s_user            = @s_user,
        @s_ofi             = @s_ofi,
        @s_date            = @s_date,
        @s_srv             = @s_srv,
        @s_term            = @s_term,
        @t_file            = @t_file,
        @t_from            = @w_sp_name,
        @t_debug           = @t_debug,
        @t_trn             = @t_trn,
        @i_operacion       = @w_operacionpf,
        @o_retiene_capital = @w_retiene_capital out

  if @@error <> 0
  begin
     exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 141155
     return 141155
  end
end
else
begin
   select @w_retiene_capital = 'N'
   select @w_operacion_tmp = @w_operacionpf,
          @w_secuencia     = 0
end

------------------------------------------------------------------
-- Si se trata de una activacion que no tiene tiempo de transito
------------------------------------------------------------------
if @i_tipo = 'N'
   select @w_max_ttransito = isnull(max(mm_ttransito),0)
   from pf_mov_monet
   where mm_operacion = @w_operacionpf
     and mm_secuencia = 0
   and   mm_estado is null --CCR se aumenta para que no  vuelva a considerar el registro cuando se trata de renovacion
else
   select @w_max_ttransito = 0

if @w_max_ttransito <> 0
   select @w_estado = 'XACT'
else
   select @w_estado = 'ACT'


select @w_cuenta_dias = 1
select @w_fecha_temp_hoy =  @w_fecha_valor

if @w_fecha_temp_hoy < @w_fecha_hoy /** EL DEPOSITO DEBE SER ACTIVADO **/
   select @w_estado = 'ACT'

if @w_int_pagados > 0 or @w_total_int_pagados > 0
begin
   if @i_en_linea = 'S'
   begin
   exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141089

   return  141089
  end
  else
  begin
     select @w_error = 141089
     goto ERROR
  end

end

select @w_num_dias_antes = @w_num_dias

-----------------------------------
-- Control para fechas comerciales
-----------------------------------
if @w_op_dias_reales = 'S'
   select @w_fecha_ven=dateadd(dd,@w_num_dias,@w_fecha_temp_hoy)
else
begin
   if @i_operacion = 'R'
      select @w_num_dias = @w_plazo_orig
   
   exec sp_funcion_1 @i_operacion = 'SUMDIA',
        @i_fechai   = @w_fecha_temp_hoy,
        @i_dias     = @w_num_dias,
        @i_dia_pago = @w_dia_pago, --*-*
        @i_batch    = 0,
        @o_fecha    = @w_fecha_ven out
        
   select @w_num_dias = @w_num_dias_antes 
end


if @w_mantiene_stock = 'S'
   select @w_fecha_ven1=@w_fecha_ven
else
begin
   exec sp_primer_dia_labor
        @t_debug       = @t_debug,
        @t_file        = @t_file,
        @t_from        = @w_sp_name,
        @i_fecha       = @w_fecha_ven,
        @s_ofi         = @w_oficina_oper,
        @i_tran_sabado = @w_tran_sabado,
        @i_tipo_deposito = @w_tipo_deposito,
        @o_fecha_labor = @w_fecha_ven1 out
   if @w_op_dias_reales = 'S'
   begin
      select @w_dif=datediff(dd,@w_fecha_ven,@w_fecha_ven1)
   end
   else
   begin
      exec sp_funcion_1 
           @i_operacion = 'DIFE30',
           @i_fechai    = @w_fecha_ven,
           @i_fechaf    = @w_fecha_ven1,
           @i_dia_pago  = @w_dia_pago,
           @i_batch     = 0,
           @o_dias      = @w_dif out
   end
end


select @w_tasa = isnull(@w_tasa, 0)

exec @w_return = cob_pfijo..sp_aplica_impuestos             -- GAL 14/SEP/2009 - INTERFAZ - IMPCOL
@s_ofi             = @s_ofi,
@i_ente            = @w_ente,
@i_capital         = @w_monto,
@i_plazo           = @w_num_dias,
@i_base_calculo    = @w_base_calculo,
@o_retienimp       = @w_retieneimp     out,
@o_tasa_retencion  = @w_tasa_retencion out,
@o_valor_retencion = @w_impuesto       out

if @w_return <> 0
begin
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = @w_return
   return @w_return
end
-- FIN - GAL 04/SEP/2009 - RVVUNICA

--------------------------------
-- Control para fecha Comercial
--------------------------------
select @w_modifica = 'N'

   exec sp_estima_int
      @i_fecha_inicio    = @w_fecha_temp_hoy,
      @s_ofi             = @s_ofi,
      @s_date            = @s_date,
      @i_fecha_final     = @w_fecha_ven1,
      @i_monto           = @w_monto,
      @i_tasa            = @w_tasa1,
      @i_tcapitalizacion = @w_tcapitalizacion,
      @i_fpago           = @w_fpago,
      @i_ppago           = @w_ppago,
      @i_dias_anio       = @w_base_calculo,
      @i_dia_pago        = @w_dia_pago,
      @i_batch           = 'S',
      @i_retienimp       = @w_retieneimp, -- 29-abr-99 capitalizacion xca B061
      @i_moneda          = @w_moneda,     -- 29-abr-99 capitalizacion xca B061
      @i_ente            = @w_ente,
      --I. CVA Jun-22-06 Parametros para escalonado
      @i_toperacion      = @w_toperacion,
      @i_periodo_tasa    = @w_periodo_tasa,       -- cobis..te_pizarra..pi_periodo
      @i_modalidad_tasa  = @w_modalidad_tasa,     -- cobis..te_pizarra..pi_modalidad, en la IPC no aplica
      @i_descr_tasa      = @w_descr_tasa,
      @i_mnemonico_tasa  = @w_mnemonico_tasa,     -- DTF, TCC, IPC, PRIME, ESC
      @i_tipo_plazo      = @w_tipo_plazo,
      @i_en_linea        = 'S',
      @i_modifica        = @w_modifica,
      @i_op_operacion    = @w_operacionpf,
      --INI NYM DPF00015 ICA
      @i_tasa1           = @w_tasa_retencion,
      @i_ret_ica         = @w_ret_ica,
      @i_tasa_ica        = @w_tasa_ica,
      --FIN NYM DPF00015 ICA
      @i_dias_reales     = @w_op_dias_reales,                          -- GAL 14/SEP/2009 - RVVUNICA
      --F. CVA Jun-22-06 Parametros para escalonado
      @o_fecha_prox_pg   = @w_fecha_pg_int out,
      @o_int_pg_pp       = @w_int_estimado out,
      @o_int_pg_ve       = @w_total_int_estimado out

select @v_historia    = @w_historia,
       @v_estado      = @w_estado,
       @w_historia    = @w_historia + 1


---------------------------
-- Activacion de Apertura
---------------------------
  if @i_en_linea = 'S'
     begin tran

  ----------------------------------------
  -- Aplicacion de movimientos monetarios
  ----------------------------------------
  select @w_mm_sub_secuencia = 0, @w_error = 0,@w_emite_orden = 'N', @w_incremento = 0

  --CVA Ene-13-06 VERIFICACION DE REVERSOS DE ACTIVACION CON VUELTOS
  if exists (select 1 from pf_mov_monet
          where mm_operacion   = @w_operacionpf
          and mm_tran        = 14901
            and mm_secuencia   = (select max(mm_secuencia)
                                   from pf_mov_monet
                           where mm_operacion   = @w_operacionpf
                                   and mm_tran         = 14901
                 and mm_estado       = 'R'
                                     and mm_valor       <> 0)
           and mm_estado = 'R'
            and mm_valor <> 0) and @t_trn = 14914
  begin
     exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141216
     return 141216
  end

while 1 = 1
begin
   set rowcount 1
   select @w_mm_sub_secuencia       = mm_sub_secuencia,
          @w_mm_producto            = mm_producto,
          @w_mm_moneda              = mm_moneda,
          @w_mm_cuenta              = mm_cuenta,
          @w_mm_valor               = mm_valor,
          @w_mm_valor_ext           = mm_valor_ext,
          @w_mm_impuesto            = mm_impuesto,
          @w_mm_impuesto_capital_me = mm_impuesto_capital_me,
          @w_secuencia_aplm         = mm_secuencia,
          @w_mm_tipo                = mm_tipo, --CVA Dic-08-05
          @w_mm_oficina             = mm_oficina,
          @w_mm_beneficiario        = mm_beneficiario,  /* rlinares 02222007 */
          @w_mm_benef_corresp       = mm_benef_corresp,   --*-*
          @w_origen_ben             = mm_tipo_cliente,   /* rlinares 02222007 */
          @w_mm_subtipo_ins         = mm_subtipo_ins      -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
   from pf_mov_monet
   where mm_operacion   = @w_operacionpf
   and mm_tran        in (@w_tran_ape,@w_tran_inc)
   and mm_secuencia   = (select max(mm_secuencia)
                         from pf_mov_monet
                         where mm_operacion  = @w_operacionpf
                         and mm_tran         in (@w_tran_ape,@w_tran_inc)
                         and mm_estado       is null
                         and mm_valor <> 0)
   and mm_estado       is null
   and mm_sub_secuencia > @w_mm_sub_secuencia
   and mm_valor <> 0
   order by mm_sub_secuencia

   if @@rowcount = 0
      break

   set rowcount 0


   if @t_trn = 14914 --Renovacion
   begin
      update pf_mov_monet
      set    mm_fecha_valor = @w_fecha_temp_hoy
      where  mm_operacion   = @w_operacionpf
      and    mm_tran          = @w_tran_inc
      and    mm_sub_secuencia = @w_mm_sub_secuencia
      and    mm_secuencia     = @w_secuencia_aplm
      if @@error<> 0
      begin
         select @w_error = 145020
         goto ERROR
      end

      if @w_mm_tipo = 'C'  --Disminucion de Capital en Renovacion
         select @w_emite_orden = 'S'

      select @w_incremento = @w_incremento + @w_mm_valor

   end
   else
   begin
      update pf_mov_monet
      set    mm_fecha_valor = @w_fecha_temp_hoy
      where  mm_operacion   = @w_operacionpf
      and    mm_tran        = @w_tran_ape
      and  mm_sub_secuencia = @w_mm_sub_secuencia
      and  mm_secuencia     = @w_secuencia_aplm
      if @@error<> 0
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 145020
         return 145020
      end
   end

      -- NYMR NR 192
      -- Realizamos inserccion bloqueo por cheque canje

      if @w_mm_producto in (@w_mpago_chql) begin

            --print 'aplica retencion :' + cast(@w_operacionpf as varchar)

            exec @w_return = cob_pfijo..sp_retencion
                 @s_ssn             = @s_ssn,
                 @s_user            = @s_user,
                 @s_ofi             = @s_ofi,
                 @s_date            = @s_date,
                 @s_srv             = @s_srv,
                 @s_term            = @s_term,
                 @t_file            = @t_file,
                 @t_from            = @w_sp_name,
                 @t_debug           = @t_debug,
                 @t_trn	          = 14108,
                 @i_operacion       = 'I',
                 @i_cuenta          = @i_num_banco,
                 @i_valor           = @w_monto,
                 @i_observacion     = 'BLOQUEO CHEQUE CANJE',
                 @i_motivo          = 'BCHQL',
                 @i_funcionario     = @s_user,
                 @i_tipo            = 'D',
                 @i_batch           = 'N',
                 @i_prod_cobis      = 'PFI',
                 @i_cuenta_referencia = @i_num_banco

            if @@error<> 0 begin
               exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 143008
               return 143008
            end

            select @w_historia  = op_historia + 1,
                   @v_historia   = op_historia
            from   cob_pfijo..pf_operacion
            where  op_num_banco = @i_num_banco

      end

      --------------------------------------------------------------------------------------------------
      -- Proceso para enviar hacia aplicmov @i_alterno incrementado siempre y cuando mm_producto = 3, 4
      --------------------------------------------------------------------------------------------------
      select @w_transito = 0
      select @w_fp_producto = fp_producto,
             @w_transito    = fp_ttransito
      from pf_fpago
      where fp_estado = 'A'
      and fp_mnemonico = @w_mm_producto

      if @w_fp_producto in(3,4)
      begin
         select @w_cont_simultaneo = @w_mm_sub_secuencia + 1
         select @w_flag_paso = 'S'
      end

      -------------------------------------------------------------------------------------------------
      -- Proceso para enviar hacia aplicmov @i_alterno incrementado siempre y cuando mm_cuenta is not null
      -------------------------------------------------------------------------------------------------
      if @w_mm_moneda = @w_moneda_base  -- Moneda nacional
         select @w_mm_valor_ext = 0

      if @w_transito > 0
         select @w_valor_transito = @w_valor_transito + @w_mm_valor


      if @i_operacion = 'R'
         select @w_tran_ape = @w_tran_inc
      else
         select @w_secuencia_aplm = 0

--*-*print 'FDFAS  @w_mm_benef_corresp:%1!',@w_mm_benef_corresp

	--print ' actiop @s_ssn_branch '+ cast( @s_ssn_branch as varchar)
	--print ' @w_secuencia_aplm '+ cast( @w_secuencia_aplm as varchar)
	--print ' @w_mm_sub_secuencia '+ cast( @w_mm_sub_secuencia as varchar)


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
           @t_trn             = @w_tran_ape,
           @i_tipo            = 'N',
           @i_operacionpf     = @w_operacionpf,
           @i_secuencia       = @w_secuencia_aplm,
           @i_sub_secuencia   = @w_mm_sub_secuencia,
           @i_retiene_capital = @w_retiene_capital,
           @i_en_linea        = @i_en_linea,
           @i_benefi          = @w_mm_benef_corresp,
           @i_emite_orden     = @w_emite_orden
      if @w_return <> 0
      begin
         if @i_en_linea = 'S'
         begin
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = @w_return
          return @w_return
         end
         else
         begin
            select @w_error = @w_return
            goto ERROR
         end
      end

      -------------------------------------------------------------------------
      -- CVA Dic-08-05 Incluir codigo para interfaz con SBA
      -- Interface para emision de cheque de gerencia con Servicios bancarios
      -- Se envia a SBA de acuerdo al producto de la forma de pago
      -------------------------------------------------------------------------
      if @w_mm_tipo = 'C'
      begin

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
         ----------------------------------------------------
         -- Tomar la descripcion del beneficiario del cheque
         ----------------------------------------------------


         select @w_descripbenef     = ec_descripcion
         from   pf_emision_cheque
         where  ec_operacion        = @w_operacionpf
         and  ec_tran             = @w_tran_ape
         and  ec_secuencia        = @w_secuencia_aplm
         and  ec_sub_secuencia    = @w_mm_sub_secuencia


--*-*print 'NNNN @w_descripbenef:%1!' ,@w_descripbenef

         /************************************************************************/
         /* Verificar si el beneficiario es del MIS O EXTERNO rlinares 02222007  */
         /************************************************************************/
         if @w_origen_ben <> 'M' /* Si es diferente de MIS NO ENVIO  DATOS A SBANCARIOS */
         begin
            select @w_cod_ben = null
            select @w_origen_ben = null
         end
         else
         begin
            select @w_cod_ben = convert(varchar(255),@w_mm_beneficiario)
         end


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

         exec   @w_idlote    = cob_interfase..sp_isba_cseqnos    -- BRON: 15/07/09  cob_sbancarios..sp_cseqnos
                @i_tabla     = 'sb_identificador_lotes',
                @o_siguiente = @w_numero out


         select @w_campo47  = tn_descripcion,
                @w_concepto = Substring(tn_descripcion,1,25)
         from   cobis..cl_ttransaccion
         where  tn_trn_code = @w_tran_ape

    if @w_tran_ape = 14904
          select @w_concepto = 'DISMINUCION ' + @w_concepto
    else
          select @w_concepto = 'VUELTO - ' + @w_concepto

         select @w_campo48 = 'DEPOSITO A PLAZO ' + @i_num_banco

         select @w_campo1 = 'PFI'

         if @w_mm_producto = @w_cheque_ger
            select @w_campo40 = 'E'

         ------------------------------------------------------------------
         -- Tomar el codigo del concepto asignado a DPF en catalogo se SBA
         ------------------------------------------------------------------
         select @w_conceptosb = convert(tinyint,codigo)
         from   cobis..cl_catalogo
         where  tabla in (select codigo
                          from   cobis..cl_tabla
                          where  tabla = 'sb_conceptos_implot')
         and    valor  = 'DPF'

         -- INICIO - GAL 07/SEP/2009 - INTERFAZ - CHQCOM

         if @w_mm_producto in (@w_mpago_chqcom , @w_cheque_ger)
         begin
            -- OBTENER DATOS DEL TITULAR DEL CREDITO
            select @w_campo1 = en_tipo_ced + '-' + en_ced_ruc,
                   @w_campo2 = en_nomlar
            from   cobis..cl_ente
            where  en_ente = @w_ente


               --NYMBMIA OBTENER DATOS DEL BENEFICIARIO
               if @w_origen_ben = 'M' begin                              -- ESTA EN COBIS..CL_ENTE
                  select @w_campo3     		= en_tipo_ced + '-' + en_ced_ruc,         -- TIPO Y NUMERO DEL BENEFICIARIO EJ. CC-79876545
                         @w_beneficiario     	= en_nomlar,                              -- NOMBRE BENEFICIARIO
                         @w_tipo_benef = c_tipo_compania
                  from   cobis..cl_ente
                  where  en_ente = @w_mm_beneficiario
               end else begin
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
               @w_campo5       = @i_num_banco,                               -- NUMERO PLAZO FIJO (CONOCIDO POR EL CLIENTE)
               @w_campo6       = @w_cod_conc_renova,                         -- CÓDIGO CONCEPTO DE RENOVACION
               @w_campo7       = @w_desc_conc_renova,                        -- DESCRIPCION CONCEPTO DE RENOVACION
               @w_campo4	= @w_beneficiario ,
               @w_referencia   = cast(@w_operacionpf as varchar),
               @w_area_origen  = 99
         end
         else
         begin
            select
               @w_beneficiario = @w_descripbenef,
               @w_referencia   = @w_num_banco,
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
            @i_oficina_origen   = @w_oficina_oper,
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
            @i_concepto         = @w_conceptosb,        -- Catalogo de Servicios bancarios (3)
            @i_fpago            = @w_mm_producto,       -- nuevo requerimiento SBA (nemonico de la forma de pago)
            @i_moneda           = @w_mm_moneda,         -- @w_moneda,
            @i_origen_ing       = '3',
            @i_idlote           = @w_numero,            -- secuencial del seqnos de Servicios bancarios
            @i_cod_ben          = @w_cod_ben,           /*  RLINARES 02222007 */
            @i_orig_ben         = @w_origen_ben,        /*  RLINARES 02222007 */
            @i_estado           = 'D',
            @i_campo21          = 'PFI',
            @i_campo22          = 'D',
            @i_campo40          = @w_campo40,
            @o_idlote           = @w_idlote out,
            @o_secuencial       = @w_secuencial_cheque out

         -- FIN - GAL 07/SEP/2009 - INTERFAZ - CHQCOM

         if @w_return <>0
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
                ec_secuencial_lote  = @w_secuencial_cheque,        --LIM 12/OCT/2005
                ec_subtipo_ins      = @w_subtipo_ins    --@w_mm_subtipo_ins
         where  ec_operacion        = @w_operacionpf
           and  ec_tran             = @w_tran_ape
           and  ec_secuencia        = @w_secuencia_aplm
           and  ec_sub_secuencia    = @w_mm_sub_secuencia
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
            and   mm_tran           = @w_tran_ape
            and   mm_secuencia      = @w_secuencia_aplm
            and   mm_sub_secuencia  = @w_mm_sub_secuencia
         end
         else
         begin
            update pf_mov_monet
            set mm_num_cheque = @w_numero
            where mm_operacion      = @w_operacionpf
            and   mm_tran           = @w_tran_ape
            and   mm_secuencia      = @w_secuencia_aplm
            and   mm_sub_secuencia  = @w_mm_sub_secuencia

            if @@error <> 0
            begin
               select @w_error = 145020
               goto ERROR
            end
         end

      end   --if (@w_producto_fpago = 42)

      end --operacion = 'R' and mm_tipo = 'C'

      ------------------------------------
      -- Aplicacion de detalle de cheques
      ------------------------------------
      select @w_ct_banco = '',@w_ct_val_tot = 0

      while 2 = 2
      begin
         set rowcount 1
         if @i_operacion = 'R'
    begin
       select @w_ct_banco       = ec_banco,
                   @w_ct_cuenta      = ec_cuenta,
                   @w_ct_fpago       = ec_fpago,
                   @w_ct_cheque      = ec_numero,
                   @w_ct_valor       = ec_valor,
                   @w_ct_descripcion = ec_descripcion
              from pf_emision_cheque
             where ec_operacion = @w_operacion_tmp
               and ec_secuencia = @w_secuencia
               and ec_fpago  = @w_mm_producto
               and ec_estado = 'I'
               and ec_tipo = 'B'
             order by ec_banco

            if @@rowcount = 0
               break
         end
         else
    begin
            select @w_ct_sub_secuencia = ct_secuencial,
                   @w_ct_banco         = ct_banco,
                   @w_ct_cuenta        = ct_cuenta,
                   @w_ct_cheque        = ct_cheque,
                   @w_ct_valor         = ct_valor,
         @w_ct_descripcion   = ct_descripcion
              from pf_det_cheque_tmp
             where ltrim(ct_usuario)   = ltrim(@s_user)
               and ct_sesion  = @s_sesn
               and ct_operacion = @w_operacion_tmp
               and ct_secuencial = @w_mm_sub_secuencia
        order by ct_secuencial

            if @@rowcount = 0
               break
         end

         set rowcount 0

         select @w_ct_val = round(@w_ct_valor, @w_numdeci)

         insert pf_emision_cheque (ec_operacion   , ec_secuencia     , ec_sub_secuencia   , ec_secuencial,
                                   ec_moneda      , ec_descripcion   , ec_tipo            , ec_tran,
                                   ec_banco       , ec_cuenta        , ec_numero          , ec_valor,
                                   ec_fecha_crea  , ec_fecha_mod     , ec_fecha_emision   , ec_fecha_mov,
                                   ec_estado      , ec_fpago)
                           values (@w_operacionpf , 0                , @w_mm_sub_secuencia, @w_secuencial,
                                   @w_mm_moneda   , @w_ct_descripcion, 'B'                , 14901,
                                   @w_ct_banco    , @w_ct_cuenta     , @w_ct_cheque       , @w_ct_val,
                                   @s_date        , @s_date          , null               , @s_date            ,
                                   'A'            , @w_ct_fpago)
         if @w_return <> 0
         begin
            if @i_en_linea = 'S'
            begin
            exec cobis..sp_cerror
         @t_debug=@t_debug,
                        @t_file=@t_file,
                        @t_from=@w_sp_name,
                        @i_num = 143031
            return 143031
            end
            else
            begin
                 select @w_error = 143031
                 goto ERROR
            end
         end

         select @w_ct_val_tot = @w_ct_val_tot + @w_ct_valor

    if @i_operacion = 'R'
         begin
       update  pf_emision_cheque
          set ec_estado='A',
              ec_secuencial=999,
         ec_fecha_mov=@s_date,
         ec_fecha_mod=@s_date
             where ec_operacion = @w_operacion_tmp
               and ec_secuencia = @w_secuencia
               and ec_fpago = @w_mm_producto
               and ec_banco = @w_ct_banco
               and ec_cuenta = @w_ct_cuenta
               and ec_numero  = @w_ct_cheque
         end
         else
         begin
            delete  pf_det_cheque_tmp
             where ct_usuario = @s_user
               and ct_sesion = @s_sesn
               and ct_operacion = @w_operacion_tmp
               and ct_secuencial = @w_mm_sub_secuencia
               and ct_banco = @w_ct_banco
               and ct_cuenta = @w_ct_cuenta
               and ct_cheque  = @w_ct_cheque
         end
      end /*  While 2  */

      if (@w_ct_val_tot <> (@w_mm_valor + isnull(@w_mm_impuesto,0))
          and @w_ct_val_tot <> 0 and @w_mm_moneda = @w_moneda_base ) or (@w_ct_val_tot <>(@w_mm_valor_ext +
              isnull(@w_mm_impuesto_capital_me,0))
          and @w_ct_val_tot <> 0 and @w_mm_moneda <> @w_moneda_base)
      begin
         exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
                            @t_from=@w_sp_name,@i_num = 149019
         return 149019
      end
   end /* END WHILE 1 */

   --Disminucion de Capital en Renovacion
   if @w_emite_orden = 'S' and @w_tran_ape = 14904 --Disminucion en Renovacion
      select @w_incremento = @w_incremento  * -1

   ----------------------------------------------------------
   -- Contabilizacion de operacion cuando es emision inicial
   ----------------------------------------------------------
   if @i_operacion <> 'R'
   begin
      select @w_terceros = pa_char
        from cobis..cl_parametro
       where pa_producto = 'PFI'
         and pa_nemonico = 'CTE'

      select @w_descripcion = 'ACTIVACION (' + @i_num_banco + ')'

      exec @w_return = cob_pfijo..sp_aplica_conta
      @s_date         = @s_date,
      @s_user         = @s_user,
      @s_term         = @s_term,
      @s_ofi          = @s_ofi,
      @i_fecha        = @w_fecha_hoy,
      @i_tran         = @w_tran_ape  ,
      @i_oficina_oper = @w_oficina_oper,
      @i_descripcion  = @w_descripcion,
      @i_monto        = @w_monto, --+-+
      @i_operacionpf  = @w_operacionpf,
      @i_afectacion   = 'N',
      @i_secuencia    = 0,
      @o_comprobante  = @o_comprobante out

      if @w_return <> 0
      begin

    if @i_en_linea = 'S'
    begin
            exec cobis..sp_cerror
                     @t_debug         = @t_debug,
                     @t_file          = @t_file,
                     @t_from          = @w_sp_name,
                     @i_num           = @w_return

            return @w_return
         end
    else
    begin
            select @w_error = @w_return
            goto ERROR
    end


      end


      ------------------------------------------
      -- Graba informacion por posible reverso
      ------------------------------------------
      insert into  pf_relacion_comp
      values (@i_num_banco , @o_comprobante, @w_tran_ape, 'APR', 'N', null, 0, @s_date)


   end

   ------------------------------------------------------------------------
   -- Actualizacion de la operacion cuando hay que reajustar valor a pagar
   ------------------------------------------------------------------------
   select @w_dif_estim    = @w_total_int_estimado - @w_total_int_estim,
          @w_dif_impuesto = 0

   if @w_retieneimp = 'S'
   begin
      select @w_impuesto = @w_total_int_estimado*@w_tasa/100,
             @w_dif_impuesto = @w_dif_estim * @w_tasa /100
   end  /* Si paga impuesto  */


   select @w_dif_estimado = @w_dif_estim - @w_dif_impuesto

   if (@w_dif_estimado > 0) and (@w_fpago = 'ANT')
   begin
      set rowcount 1
      select @w_dif_estimado = @w_dif_estimado * @w_factor
      update pf_det_pago
         set dp_monto = dp_monto+round(@w_dif_estimado, @w_numdecipg)
       where dp_operacion = @w_operacionpf
         and dp_tipo = 'INT'
         and dp_estado_xren ='N'
         and dp_secuencia = 1
      set rowcount 0
   end

   if @w_fpago =  'ANT' and @w_estado='ACT'
   begin
      select @w_total_pagar       = @w_total_int_estimado - @w_impuesto,
        @w_int_pagados       = @w_total_int_estimado,
             @w_total_int_pagados = @w_total_int_estimado
   end /* forma de pago anticipado */

   if @w_fpago ='PRA' and @w_estado='ACT' -- 13-Mar-2000 PRA
   begin
      select @w_total_pagar = @w_total_int_estimado - @w_impuesto,
             @w_int_pagados       = @w_int_estimado,
             @w_total_int_pagados = @w_int_estimado
   end /* forma de pago periodico anticipado */

   if @w_mon_sgte=0
      select @w_mon_sgte=1

   if @w_flag_paso = 'N'
   begin
      select @w_contor = 0,
             @w_pt_secuencia = 0
   end
   else
   begin
      select   @w_contor = @w_cont_simultaneo,
      @w_pt_secuencia = 0
   end

   -------------------------------------------------------
   -- Ejecuto pago de intereses cuando es emision inicial
   -------------------------------------------------------
   if (@w_estado = 'ACT' and @w_fpago in('ANT','PRA') and @i_operacion <> 'R') or
      (@w_estado = 'ACT' and @w_fpago = 'PRA' and @i_operacion = 'R')
   begin
      if @w_retieneimp = 'S'
      begin
         select @w_money = round (@w_monto * @w_num_dias * @w_tasa1/(@w_base_calculo * 100),@w_numdeci)  -- CUZ-050-001
         select @w_imp_retenido = round((@w_money*@w_tasa/100),@w_numdeci)
      end

      select @w_money = sum(dp_monto)
        from pf_det_pago
       where dp_operacion = @w_operacionpf
         and dp_tipo = 'INT'
         and dp_estado = 'I'
       --order by dp_operacion,dp_tipo

      if @w_money is null
         select @w_money = 0

      if @w_renova_todo = 'N'
      begin
         if @w_flag_paso = 'N'
         begin
            select @w_contor = @w_contor + 1,
              @w_total_pagar_pg = @w_total_pagar * @w_factor,
              @w_impuesto_pg = @w_impuesto * @w_factor,
         @w_r1 = 0, @w_r2 = 0
         end
         else
         begin
            select @w_total_pagar_pg = @w_total_pagar * @w_factor,
                   @w_impuesto_pg = @w_impuesto * @w_factor,
                   @w_r1 = 0, @w_r2 = 0
         end


         while 2=2
         begin
            set rowcount 1
            select @w_pt_beneficiario = dp_ente,
                   @w_pt_forma_pago   = dp_forma_pago,
                   @w_pt_cuenta       = dp_cuenta,
                   @w_pt_secuencia    = dp_secuencia,
                   @w_pt_monto        = dp_monto,
                   @w_pt_porcentaje   = dp_porcentaje,
                   @w_pt_porcentaje   = dp_porcentaje,
                   @w_pt_tipo_cliente = dp_tipo_cliente, --gap DP00008
                   @w_pt_oficina      = dp_oficina    --gap DP00008
              from pf_det_pago
             where dp_operacion = @w_operacionpf
               and dp_secuencia > @w_pt_secuencia
               and dp_tipo = 'INT'
               and dp_estado_xren='N'
             order by dp_secuencia

            if @@rowcount = 0
               break

            set rowcount 0

            if @w_pt_monto is null
            begin
               select @w_monto_mov = @w_pt_porcentaje*(@w_total_pagar_pg+@w_r1)/100
               select @w_imp= @w_pt_porcentaje*(@w_impuesto_pg+@w_r2)/100
            end
            else
            begin
               select @w_monto_mov = @w_pt_monto
               select @w_imp = @w_pt_monto*(@w_impuesto_pg+@w_r2)/@w_total_pagar_pg
            end

            select @w_r1 =@w_monto_mov -round(@w_monto_mov,@w_numdecipg)
            select @w_r2 =@w_imp - round(@w_imp,@w_numdecipg)
            select @w_monto_mov = round(@w_monto_mov,@w_numdecipg),
         @w_imp       = round(@w_imp,@w_numdecipg)

            -----------------------------
            -- Control de capitalizacion
            -----------------------------
            if @w_tcapitalizacion = 'S'
               select @w_pt_forma_pago ='CAP',
                      @w_pt_cuenta = @i_num_banco

            exec @w_return=sp_debita_int
                @s_ssn                 = @s_ssn,
                 @s_user                = @s_user,
                @s_ofi                 = @s_ofi,
                 @s_date                = @s_date,
       @s_term                = @s_term,
                @s_srv                 = @s_srv,
                 @t_debug               = @t_debug,
                @t_trn                 = 14905,
                 @i_secuencia           = @w_mon_sgte,
                @i_sub_secuencia       = @w_contor,
       @i_num_banco           = @i_num_banco,
                @i_monto               = @w_monto_mov,
       @i_producto            = @w_pt_forma_pago,
                @i_fecha_proceso       = @w_fecha_hoy,
                @i_cuenta              = @w_pt_cuenta,
                @i_en_linea            = 'S',
            @i_beneficiario        = @w_pt_beneficiario,
       @i_moneda              = @w_moneda_pg,
       @i_pago_anticipado     = 'S',
       @i_impuesto            = @w_imp,
       @i_total_int_estimado  = @w_total_int_estimado,
                @i_tasa1               = @w_tasa,
                @i_tot_monto           = @w_money,             -- suma dp_monto/pf_det_pago xca
                @i_tot_impuesto        = @w_imp_retenido,      -- tot. impto xca
                @i_tasa_variable       = @w_tasa_variable,
                @i_tasa_efectiva       = @w_tasa_efec_anual,
                @i_tasa_nominal        = @w_tasa1,
                 @i_tipo_cliente        = @w_pt_tipo_cliente,   -- gap DP00008
       @i_oficina             = @w_pt_oficina      -- gap DP00008


            if @w_return <> 0
            begin
               print 'ERROR en el debitint'
          if @i_en_linea = 'S'
      begin
                     exec cobis..sp_cerror   @t_debug=@t_debug,
                        @t_file=@t_file, @t_from=@w_sp_name,
                       @i_num = @w_return
                     return @w_return
      end
      else
      begin
               select @w_error = @w_return
               goto ERROR
      end


            end

            select @w_contor = @w_contor + 1

            select @w_historia = @w_historia + 1, -- 13-Mar-2000 PRA
                   @v_historia = @v_historia + 1
         end /* END WHILE 2 */
      end
      else
         select @w_total_int_acumulado = @w_total_pagar
   end /* Anticipado, activo y no renovacion    */

   ---------------------------------------------------------------------------------
   -- CONTABILIZACION DE RENOVACION/INCREMENTO/DISMINUCION EN LA RENOVACION
   ---------------------------------------------------------------------------------
   if @i_operacion = 'R'
   begin
      if @w_estado = 'ACT'
      begin
         ----------------------------------
         -- Reporte sipla version colombia
         ----------------------------------
         select @w_terceros = pa_char
           from cobis..cl_parametro
          where pa_producto = 'PFI'
            and pa_nemonico = 'CTE'

         ------------------------------------------------
         -- Ejecucion de asiento contable de renovacion
         ------------------------------------------------
         select @w_descripcion = 'RENOVACION ('+ @i_num_banco + ')'

         select @w_valor = @w_monto1

          if @i_en_linea = 'N' and @i_operacion = 'R'
            select
            @w_incremento   = @i_incremento,
            @w_valor       = @w_monto2,
            @w_monto1      = @w_monto2,
            @w_secuencia_aplm    = @i_secuencia_ant

            select
            @w_tplazo_cont_old = pc_plazo_cont
            from  pf_plazo_contable
            where @w_num_dias_old  between pc_plazo_min and pc_plazo_max

            select
            @w_tplazo_cont     =  pc_plazo_cont
            from  pf_plazo_contable
            where @w_num_dias  between pc_plazo_min and pc_plazo_max
              
            select top 1 @w_mm_secuencia = mm_secuencia
            from pf_mov_monet
            where mm_operacion = @w_operacionpf
            and mm_estado = 'A'
            --and mm_tipo   = 'C'
            and mm_tran = 14904
            and mm_fecha_aplicacion = @s_date
            group by mm_secuencia 
            having sum(isnull(mm_valor,0)) = abs(@w_incremento)                       

            /* CALCULO EL VALOR A CONTABILIZAR POR EMERGENCIA ECONOMICA GMF */
            exec @w_return = sp_valor_gmf
            @s_date = @s_date,
            @i_tran = 14904,
            @i_operacionpf = @w_operacionpf,
            @i_secuencia = @w_mm_secuencia,
            @o_valor_iee = @w_gmf out
            if @w_return <> 0 goto ERROR

            exec @w_return = cob_pfijo..sp_aplica_conta
            @s_date               = @s_date,
            @s_user               = @s_user,
            @s_term               = @s_term,
            @s_ofi                = @s_ofi,
            @i_fecha              = @w_fecha_hoy,
            @i_tran               = 14919,
            @i_tplazo             = @w_tplazo_cont,
            @i_tplazo_old         = @w_tplazo_cont_old,
            @i_operacionpf        = @w_operacionpf,
            @i_afectacion         = 'N',
            @i_oficina            = @w_oficina_oper,
            @i_secuencia          = @w_secuencia_aplm,
            @i_descripcion        = @w_descripcion,
            @i_monto              = @w_monto1,
            @i_intvenc            = @w_int_vencido,
            @i_impuesto           = @w_impuesto_ren,
            @i_incremento         = @w_incremento,
            @i_impuesto_emerg_eco = @w_gmf,          --GRAVAMEN MOVIMIENTO FINANCIERO
            @o_comprobante        = @o_comprobante out

            if @w_return <> 0
            begin
               if @i_en_linea = 'S'
               begin
                  exec cobis..sp_cerror
                  @t_from          = @w_sp_name,
                  @i_num           = @w_return
                  return @w_return
               end
               else
               begin
                  select @w_error = @w_return
                  goto ERROR
               end
            end

         --------------------------------------------------
         -- Graba informacion en el caso de que se reverse
         --------------------------------------------------
         insert into  pf_relacion_comp
         values (@i_num_banco, @o_comprobante, 14904, 'APR', 'N', null, 0, @s_date)
      end

      end /* generacion de mov monet para decremento, intv, int */

     --Fin contabilizacion Disminucion/Incremento Renovacion

      ------------------------------------------------------------
      -- Proceso para calculo de cuotas en operaciones periodicas
      ------------------------------------------------------------
      exec @w_return = cob_pfijo..sp_cuotas
           @s_ssn                = @s_ssn,
           @s_srv                = @s_srv,
           @s_lsrv               = @s_lsrv,
           @s_user               = @s_user,
           @s_sesn               = @s_sesn,
           @s_term               = @s_term,
           @s_date               = @s_date,
           @s_ofi                = @s_ofi,
           @s_rol                = @s_rol,
           @t_trn                = 14146,
           @i_op_ente            = @w_ente,
           @i_op_operacion       = @w_operacionpf,
           @i_op_fecha_valor     = @w_fecha_temp_hoy,
           @i_op_fecha_ven       = @w_fecha_ven1,
           @i_op_monto           = @w_monto,
           @i_op_tasa            = @w_tasa1,
           @i_op_num_dias        = @w_num_dias,
           @i_op_ppago           = @w_ppago,
           @i_op_retienimp       = @w_retieneimp,
           @i_op_moneda          = @w_moneda,
           @i_op_oficina         = @w_oficina_oper,
           @i_op_fpago           = @w_fpago,
           @i_op_base_calculo    = @w_base_calculo,
           @i_op_tcapitalizacion = @w_tcapitalizacion,
           @i_tot_int_estimado   = @w_total_int_estimado,       --*-*
           @i_op_anio_comercial  = 'N',
           @i_op_dias_reales     = @w_op_dias_reales,
           @i_op_fecha_pg_int    = @w_fecha_pg_int

      if @w_return <> 0
      begin
         if @i_en_linea = 'S'
         begin
            exec cobis..sp_cerror
               @t_debug         = @t_debug,
               @t_file          = @t_file,
               @t_from          = @w_sp_name,
               @i_num           = 143049
            return 143049
         end
       else
    begin
            select @w_error = 143049
            goto ERROR
    end
      end

      if @w_contor = 0
    select @w_impuesto = 0

      if @t_trn = 14940
      begin
   insert into pf_autorizacion  (
               au_operacion                   ,au_autoriza                    ,au_adicional                   ,
               au_oficina                     ,au_tautorizacion               ,au_fecha_crea                  ,
               au_num_banco                   ,au_oficial                     )
        values (
               @w_operacionpf                 ,@s_user                        ,0                              ,
               @s_ofi                         ,'ACAU'                         ,@s_date                        ,
               @i_num_banco                   ,@s_user)
      end

      -------------------------------------------------------------------------------------------
      -- Capitalizacion para que se inserte el valor real de op_monto_pg_int en el caso de
      -- operaciones con pagos de intereses anticipados 'ANT' y que SI CAPITALICEN intereses.
      -------------------------------------------------------------------------------------------
      if @w_fpago = 'ANT'
      begin
         if @w_tcapitalizacion = 'S'
         begin
            select @w_interes_neto = round((@w_total_int_pagados - @w_impuesto),@w_numdeci)
            select @w_monto_pg_int = round((@w_monto + @w_interes_neto),@w_numdeci)
         end
         else
         begin
            select @w_monto_pg_int = @w_monto
         end

         -------------------------------------------------------------
         -- Proceso para reasignar a la variable @v_historia el nuevo
         -------------------------------------------------------------
         /* valor que pudo haber tomado el campo op_historia en el caso */
         /* de que se inserto registro en pf_historia por pago de       */
         /* intereses anticipados, para que no falle la insercion en    */
         /* pf_historia de la transaccion de apertura  12-may-99        */

         update pf_operacion
            set op_estado              = @w_estado,
                op_imprime             = 'S',
                op_preimpreso           = @i_preimpreso,
                op_historia            = @w_historia, --13-Mar-2000 PRA
                op_mon_sgte            = @w_mon_sgte + 1,
                op_ult_fecha_calculo   = '01/01/1900',
                op_fecha_ord_act       = @w_fecha_valor,
                op_total_int_acumulado = round (@w_total_int_acumulado ,@w_numdeci),
                op_total_int_retenido  = round (@w_impuesto,@w_numdeci),
                op_fecha_mod           = @s_date,
                op_fecha_valor         = @w_fecha_temp_hoy,
                op_fecha_ult_pg_int    = @w_fecha_temp_hoy,
                op_fecha_ven           = @w_fecha_ven1,
                op_fecha_pg_int        = @w_fecha_pg_int,
                op_int_pagados         = round (@w_int_pagados,@w_numdeci),
                op_int_ganado          = op_int_ganado - round (@w_int_pagados,@w_numdeci),
                op_total_int_pagados   = round (@w_total_int_pagados,@w_numdeci),
                op_int_estimado        = round (@w_int_estimado,@w_numdeci),
                op_total_int_estimado  = round (@w_total_int_estimado,@w_numdeci),
                op_num_dias            = @w_num_dias,
                op_plazo_ant         = @v_num_dias,
                op_fecven_ant        = @v_fecha_ven,
                op_tipo_plazo        = @w_tplazo, --actualiza nuevo tipo_plazo xca
                op_tot_int_est_ant     = round (@v_total_int_estimado,@w_numdeci),
                op_monto_pg_int        = @w_monto_pg_int /* 29-abr-99 capitalizacion xca B061 */
          where op_operacion = @w_operacionpf
         if @@error <> 0
         begin
            if @i_en_linea = 'S'
            begin
               exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
                            @t_from=@w_sp_name,   @i_num = 145001
               return 145001
            end
            else
            begin
               select @w_error = 145001
               goto ERROR
            end
         end
      end /* fin de forma de pago 'ANT' */
      else /* Si es cualquier forma de pago excepto ANT 29-abr-99 xca B061*/
      begin
         update pf_operacion
            set op_estado              = @w_estado,
                op_imprime             = 'S',
                op_preimpreso          = @i_preimpreso,
                op_historia            = @w_historia,
                op_mon_sgte            = @w_mon_sgte + 1,
                op_ult_fecha_calculo   = '01/01/1900',
                op_fecha_ord_act       = @w_fecha_valor,
                op_total_int_acumulado = round (@w_total_int_acumulado ,@w_numdeci),
                op_total_int_retenido  = round (@w_impuesto,@w_numdeci),
                op_fecha_mod           = @s_date,
                op_fecha_valor         = @w_fecha_temp_hoy,
                op_fecha_ult_pg_int    = @w_fecha_temp_hoy,
                op_fecha_ven           = @w_fecha_ven1,
                op_fecha_pg_int        = @w_fecha_pg_int,
                op_int_pagados         = round (@w_int_pagados,@w_numdeci),
                op_int_ganado          = op_int_ganado - round (@w_int_pagados,@w_numdeci),
                op_total_int_pagados   = round (@w_total_int_pagados,@w_numdeci),
                op_int_estimado        = round (@w_int_estimado,@w_numdeci),
                op_total_int_estimado  = round (@w_total_int_estimado,@w_numdeci),
                op_num_dias            = @w_num_dias,
                op_plazo_ant           = @v_num_dias,
                op_fecven_ant          = @v_fecha_ven,
                op_tipo_plazo          = @w_tplazo, --actualiza nuevo tipo_plazo xca
                op_tot_int_est_ant     = round (@v_total_int_estimado,@w_numdeci)
          where op_operacion = @w_operacionpf
         if @@error <> 0
         begin
            if @i_en_linea = 'S'
            begin
               exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
                    @t_from=@w_sp_name,   @i_num = 145001
               return 145001
            end
         else
         begin
            select @w_error = 145001
            goto ERROR
         end
      end

      ----------------------------------------------------------------------
      -- Actualizacion del detalle de pago una vez actualizada la operacion
      ----------------------------------------------------------------------
      if @w_tcapitalizacion <> 'S' and isnull(@w_transito,0) > 0
      begin
         select @w_int_estimado = round(@w_int_estimado,@w_numdeci)
         update cob_pfijo..pf_det_pago
            set dp_monto = round(@w_int_estimado * isnull(dp_porcentaje,0)/100.00,@w_numdeci)
          where dp_operacion = @w_operacionpf
            and dp_estado      = 'I'
            and dp_estado_xren = 'N'
            and dp_tipo        in ('INT','INTV')

         select @w_ctrlsuma = round(sum(dp_monto),@w_numdeci)
           from cob_pfijo..pf_det_pago
          where dp_operacion   = @w_operacionpf
            and dp_estado      = 'I'
            and dp_estado_xren = 'N'
            and dp_tipo        in ('INT','INTV')

         if @w_ctrlsuma <> @w_int_estimado
         begin
            update cob_pfijo..pf_det_pago
               set dp_monto = dp_monto - (@w_ctrlsuma - @w_int_estimado)
             where dp_operacion   = @w_operacionpf
               and dp_estado      = 'I'
               and dp_estado_xren = 'N'
               and dp_tipo        in ('INT','INTV')
               and dp_secuencia   = (select max(dp_secuencia)
                                       from cob_pfijo..pf_det_pago
                                      where dp_operacion = @w_operacionpf
                                        and dp_estado      = 'I'
                                        and dp_estado_xren = 'N'
                                        and dp_tipo        in ('INT','INTV')
                                        and dp_monto       = (select max(dp_monto)
                                                                from cob_pfijo..pf_det_pago
                                                               where dp_operacion   = @w_operacionpf
                                                                 and dp_estado      = 'I'
                                                                 and dp_estado_xren = 'N'
                                                                 and dp_tipo        in ('INT','INTV')))
         end
      end


    update pf_operacion_his                        --LIM 05/ENE/2005
            set oh_fecha_valor         = @w_fecha_temp_hoy,
               oh_fecha_ult_pg_int    = @w_fecha_temp_hoy,
                oh_fecha_ven           = @w_fecha_ven1,     --I. CVA May-15-2006
                oh_fecha_pg_int        = @w_fecha_pg_int,
                oh_num_dias            = @w_num_dias        --F. CVA May-15-2006
          where oh_operacion = @w_operacionpf
    if @@error <> 0
         begin
       if @i_en_linea = 'S'
            begin
            exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
                 @t_from=@w_sp_name,   @i_num = 145001
            return 145001
            end
       else
       begin
            select @w_error = 145001
            goto ERROR
       end

         end

      end /* Fin de actualizacion de cualquier forma de pago excepto ANT */


      ---------------------------------------------------------------
      -- Se actualizan los tickets si forma de pago era ahorros (ND)
      ---------------------------------------------------------------
      update pf_secuen_ticket
         set st_estado = 'A'
       where st_operacion = @w_operacionpf
         and  st_estado    = 'I'
         and   st_fpago in (select fp_mnemonico from pf_fpago -- MCA 27-Oct-99
       where fp_estado = 'A' and (fp_producto = 4 or fp_producto = 3))

      update pf_secuen_ticket
         set st_estado = 'A'
       where st_operacion = @w_operacionpf
         and  st_fpago     = 'REN'
         and  st_estado    = 'I'

      ----------------------------------------
      -- Insercion de transaccion de servicio
      ----------------------------------------
      insert ts_operacion (secuencial  , tipo_transaccion, clase     , usuario,
                           terminal    , srv             , lsrv      , fecha,
                           num_banco   , operacion       ,  historia , estado,
                           fecha_mod   , imprime)
                   values (@s_ssn      , @t_trn          , 'A'        , @s_user,
                           @s_term     , @s_srv          , @s_lsrv    , @s_date,
                           @i_num_banco, @w_operacionpf  , @w_historia, @w_estado,
                           @s_date     , 'S')
      if @@error <> 0
      begin
         if @i_en_linea = 'S'
         begin
            exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
               @t_from=@w_sp_name,   @i_num = 143005
            return 143005
         end
    else
    begin
            select @w_error = 145001
            goto ERROR
    end

      end

      -----------------------------------------------
      -- Realizar provision de intereses back-value
      -----------------------------------------------
      if @w_estado = 'ACT'
      begin
         select  @w_dias = 0

--print 'actioper.sp -> ' + cast(@w_fecha_temp_hoy as varchar) + ' w_fecha_hoy:' + cast(@w_fecha_hoy as varchar)

         if @w_op_dias_reales = 'S' --04/04/2000 Fecha Comercial
      select @w_dias = datediff(dd,@w_fecha_temp_hoy,@w_fecha_hoy)
       else
      exec sp_funcion_1 @i_operacion = 'DIFE30',
                    @i_fechai    = @w_fecha_temp_hoy,
                    @i_fechaf    = @w_fecha_hoy,
                    @i_dia_pago     = @w_dia_pago, --*-*
                    @i_batch  = 0,
                    @o_dias      = @w_dias out

--print 'DIAS actioper.sp:' + cast(@w_dias as varchar)

         if @w_dias > 0
         begin
            exec @w_return = sp_calc_diario_int
                 @s_ssn           = @s_ssn,
                 @s_user          = @s_user,
                 @s_ofi           = @s_ofi,
                 @s_date          = @s_date,
                 @s_srv           = @s_srv,
                 @s_lsrv          = @s_lsrv,
                 @s_term          = @s_term,
                 @s_rol           = @s_rol,
                 @t_debug         = @t_debug,
                 @t_file          = @t_file,
                 @t_from          = @t_from,
                 @t_trn           = 14926,
       @i_fecha_proceso = @w_fecha_temp_hoy,
                 @i_num_banco     = @i_num_banco ,
                 @i_tipo_act      = 'R',
                 @i_dias_interes  = @w_dias
            if @w_return <> 0
            begin
          if @i_en_linea = 'S'
               begin
               exec cobis..sp_cerror
                    @t_debug   = @t_debug,
                    @t_file    = @t_file,
                    @t_from    = @w_sp_name,
                    @i_num     = 149015
               return 149015
               end
          else
          begin
            select @w_error = 149015
            goto ERROR
          end

            end
    end
      end

      ---------------------------
      -- Insercion de Historicos
      ---------------------------
      if @i_operacion     <> 'R' --CVA Oct-03-2005
      begin
      insert pf_historia (hi_operacion  , hi_secuencial , hi_fecha      , hi_trn_code,
                          hi_valor      , hi_funcionario, hi_oficina    , hi_observacion,
                          hi_fecha_crea , hi_fecha_mod)
                  values (@w_operacionpf, @v_historia   , @s_date       , @t_trn,
                          @w_monto      , @s_user       , @s_ofi        , @i_observacion,
                          @s_date       , @s_date)

      if @@error <> 0
      begin
         exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
              @t_from=@w_sp_name,   @i_num = 143006
    return 143006
      end
      end

   if @t_trn = 14914
   begin
      select @w_be_ente = 0, @w_contador = 1
      while 1 = 1
      begin
         set rowcount 1
         select @w_be_ente        = be_ente,
                @w_be_tipo        = be_tipo
         from pf_beneficiario
          where be_operacion  = @w_operacionpf
                 and be_ente     > @w_be_ente
                 and be_estado      = 'I'
                 and be_estado_xren = 'N'
         order by be_ente
         if @@rowcount = 0
            break

         set rowcount 0

              update cobis..cl_ente
                 set en_cliente = 'S'
               where en_ente  = @w_be_ente
         if @@error <> 0
         begin
            select @w_error = 703028
                      goto ERROR
         end


         if @w_be_tipo = 'T'
         begin
            select @w_contador = @w_contador + 1
         end
      end /* while 1 */

      set rowcount 0

   end --if @t_trn = 14914

if @i_en_linea = 'S' and @i_operacion <> 'R' --En la renovacion se elimina la temporal
begin
  delete from pf_rubro_op_tmp    where rot_operacion = @w_operacionpf
end

--print 'SE VA...'
--rollback tran


if @i_en_linea = 'S'
  commit tran

return 0

------------------------------
-- Manejo de mensaje de error
------------------------------
ERROR:
  if @i_en_linea = 'N'
  begin

     rollback tran

     delete from pf_rubro_op_tmp  where rot_operacion = @w_operacionpf

     exec sp_errorlog @i_fecha   = @s_date,
                      @i_error   = @w_error,
                      @i_usuario = @s_user,
                      @i_tran    = @t_trn,
                      @i_descripcion = 'sp_activa_deposito',
                      @i_cuenta  = @i_num_banco

  end

  return @w_error

go