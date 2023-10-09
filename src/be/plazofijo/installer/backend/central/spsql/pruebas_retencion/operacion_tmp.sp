/*sp_operacion_tmp*/
/************************************************************************/
/*      Archivo:                operatmp.sp                             */
/*      Stored procedure:       sp_operacion_tmp                        */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Miryam Davila                           */
/*      Fecha de documentacion: 24/Oct/94                               */
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
/*      Este script crea los procedimientos para las transacciones de   */
/*      adicion, modificacion, eliminacion, search y query de las       */
/*      operaciones temporales de plazos fijos.                         */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA       AUTOR              RAZON                            */ 
/*      03-Ago-06   Ricardo Ramos      Adicion de campo de fideicomiso  */
/*      08-Ago-2007 N . Silva          Overnight                        */
/*      11-Jul-2009 Y.Martinez          NYM DPF00015 ICA y Retencion */
/************************************************************************/                                                                            
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if object_id('sp_operacion_tmp') IS   NOT NULL
   drop proc sp_operacion_tmp
go

create proc sp_operacion_tmp (
   @s_ssn                  int             = NULL,
   @s_user                 login           = NULL,
   @s_sesn                 int             = NULL,
   @s_term                 varchar(30)     = NULL,
   @s_date                 datetime        = NULL,
   @s_srv                  varchar(30)     = NULL,
   @s_lsrv                 varchar(30)     = NULL,
   @s_ofi                  smallint        = NULL,
   @s_rol                  smallint        = NULL,
   @t_debug                char(1)         = 'N',
   @t_file                 varchar(10)     = NULL,
   @t_from                 varchar(32)     = NULL,
   @t_trn                  smallint        = NULL,

   @i_operacion            char(1),
   @i_oficina              smallint        = NULL,         -- GAL 31/AGO/2009 - RVVUNICA
   @i_num_banco            cuenta          = NULL,
   @i_toperacion           catalogo        = NULL,
   @i_categoria            catalogo        = NULL,
   @i_moneda               tinyint         = NULL,
   @i_casilla              tinyint         = NULL,
   @i_direccion            tinyint         = NULL,
   @i_num_dias             smallint        = NULL,
   @i_numdoc               smallint        = 0,    
   @i_monto                money           = NULL,
   @i_tasa                 float           = NULL,
   @i_simulacion           char(1)         = 'N',
   @i_retienimp            char(1)         = 'N',
   @i_ret_ica              char(1)         = 'N', -- NYM DPF00015 ICA
   @i_ppago                catalogo        = NULL,
   @i_dia_pago             tinyint         = NULL,  
   @i_fecha_valor          datetime        = NULL,
   @i_fecha_valor_cambio   datetime        = NULL,  --*-* 
   @i_descripcion          descripcion     = NULL,
   @i_flag                 int             = 0,
   @i_retiene_imp_capital  char(1)         = 'N',
   @i_impuesto_capital     money           = 0,
   @i_formato_fecha        int             = 0,        
   @i_prorroga_aut         char(1)         = NULL,    -- 06-Abr-2000 Prorroga Aut.
   @i_num_dias_gracia      int             = 0,       -- 06-Abr-2000 Prorroga Aut.
   @i_tasa_efectiva        float           = 0,       -- 04-May-2000 Tasa Efec/Nom
   @i_flag_tasaefec        char(1)         = 'N',     -- 04-May-2000 Tasa Efec/Nom
   @i_tot_int_ganados      money           = 0,       -- fusfra 05/11/2000
   @i_tot_int_retenido     money           = 0,       -- fusfra 05/11/2000
   @i_tot_int_acumulado    money           = 0,       -- fusfra 05/11/2000
   @i_fracciona            char(1)         = 'N',     -- fusfra 05/11/2000
   @i_operacion_fusfra     int             = 0,       -- fusfra 05/11/2000
   @i_porcentaje           int             = 0,       -- fusfra 05/11/2000
   @i_int_estimado         money           = 0,       -- fusfra 05/11/2000
   @i_tot_int_estimado     money           = 0,       -- fusfra 05/11/2000
   @i_fecha_ingreso        datetime        = NULL,    -- fusfra 05/11/2000
   @i_fecha_ven            datetime        = NULL,    -- fusfra 05/11/2000
   @i_fecha_pg_int         datetime        = NULL,    -- fusfra 05/11/2000
   @i_int_ganado           money           = 0,       -- 12-May-2000 FUS
   @i_int_pagados          money           = 0,       -- 12-May-2000 FUS
   @i_tot_int_pagados      money           = 0,       -- 12-May-2000 FUS
   @i_tot_int_provision    float           = 0,       -- 12-May-2000 FUS
   @i_tot_int_est_ant      money           = 0,       -- 12-May-2000 FUS
   @i_residuo              float           = 0,       -- 12-May-2000 FUS 
   @i_fecha_ult_pg_int     datetime        = NULL,    -- 12-May-2000 FUS
   @i_fecven_ant           datetime        = NULL,    -- 12-May-2000 FUS
   @i_fecha_ord_act        datetime        = NULL,    -- 12-May-2000 FUS
   @i_ult_fecha_calculo    datetime        = NULL,    -- 12-May-2000 FUS
   @i_preimpreso           int             = NULL,    -- 12-May-2000 FUS
   @i_imprime              char(1)         = 'N',     -- 12-May-2000 FUS
   @i_plazo_ant            smallint        = 0,       -- 12-May-2000 FUS
   @i_estatus_prorroga     char(1)         = 'N',     -- 12-May-2000 FUS
   @i_num_prorroga         int             = 0,       -- 12-May-2000 FUS
   @i_ente_fraccion        int             = NULL,    -- 12-May-2000 FRA solo fracci.
   @i_puntos               float           = 0,     
   @i_tasa_variable        char(1)         = 'N',     -- 12-Abr-2000 TASA VARIABLE
   @i_mnemonico_tasa       catalogo        = NULL,    -- 12-Abr-2000 TASA VARIABLE
   @i_modalidad_tasa       char(1)         = NULL,    -- 12-Abr-2000 TASA VARIABLE
   @i_periodo_tasa         smallint        = NULL,    -- 12-Abr-2000 TASA VARIABLE
   @i_descr_tasa           descripcion     = NULL,    -- 12-Abr-2000 TASA VARIABLE
   @i_operador             char(1)         = NULL,    -- 12-Abr-2000 TASA VARIABLE
   @i_spread               float           = 0,       -- 12-Abr-2000 TASA VARIABLE
   @i_tipo_monto           catalogo        = NULL,    -- fusfra 05/11/2000
   @i_tipo_plazo           catalogo        = NULL,    -- fusfra 05/11/2000
   @i_endoso               char(1)         = 'N',     -- Indicador para operaciones de endoso 
   @i_fusfra               char(1)         = 'N',     -- fusfra 05/11/2000
   @i_porc_comision        float           = 0,       -- porc. de comision
   @i_cupon                char(1)         = 'N',     -- GES 06/22/01 CUZ-020-035
   @i_categoria_cupon      catalogo        = NULL,    -- GES 06/28/01 CUZ-020-054
   @i_ente                 int             = NULL,    -- GES 09/12/01 CUZ-031-035
   @i_captador             login           = NULL,    -- GAR 22-feb-2005
   @i_oficial_prin         login           = NULL,    -- gap DP00008
   @i_oficial_sec          login           = NULL,    -- gap DP00008
   @i_tcapitalizacion      char(1)         = NULL,    -- gap DP00008 02/25/2005
   @i_base_calculo         catalogo        = NULL,    -- gap DP00008
   @i_flag_fusfra          char(1)         = 'N',     -- KTA GB-GAPDP00049
   @i_origen_fondos        catalogo        = NULL,    -- KTA GB-GAPDP00143
   @i_proposito_cuenta     catalogo        = NULL,    -- KTA GB-GAPDP00143
   @i_producto_bancario1   catalogo        = NULL,    -- KTA GB-GAPDP00143
   @i_producto_bancario2   catalogo        = NULL,    -- KTA GB-GAPDP00143
   @i_revision_tasa        char(1)         = NULL,    -- gap DP00008
   @i_dias_reales          char(1)         = NULL,    -- gap DP00008 
   @i_incremento           char(1)         = 'N',
   @i_ente_corresp         int             = NULL,    -- GAR GB-DP00120
   @i_plazo_orig           int             = NULL,    -- Control para prorrogas automaticas
   @i_cambio_oper          char(1)         = 'N',     -- Chequea si el cambio viene de pantalla de modificacion de cambios
   @i_fpago                catalogo        = NULL,
   @i_fecha_valor_hold     datetime        = NULL,     --Fecha Valor considerando los dias de hold
   @i_fecha_venci_hold     datetime        = NULL,     --Fecha Vencimiento considerando los dias de hold
   @i_sucursal             smallint        = NULL,  --Sucursal del Banco de retencion de la correspondencia
   @i_inactivo             char(1)         = NULL,  --LIM 22/OCT/2005
   @i_incremento_susp      money           = NULL,  --LIM 22/OCT/2005
   @i_localizado           char(1)         = NULL,  --LIM 22/OCT/2005
   @i_fecha_localizacion   smalldatetime   = NULL, --LIM 22/OCT/2005
   @i_fecha_no_localiza    smalldatetime   = NULL, --LIM 22/OCT/2005
   @i_dias_hold            int             = NULL, --LIM 22/OCT/2005
   @i_aprobado             char(1)         = NULL, --LIM 22/OCT/2005
   @i_telefono             varchar(16)     = NULL, --LIM 22/OCT/2005
   @i_mantenimiento        char(1)         = 'N',
   @i_flag_val_disponible  char(1)         = 'N',   --ccr validar (si/no) el monto disponible del DPF
   @i_monto_incremento     money           = 0,  --ccr monto del incremento/decremento
   @i_oficial_aper         login           = NULL, --LIM 12/NOV/2005
   @i_oficina_aper         smallint        = NULL, --LIM 12/NOV/2005
   @i_tipope_aper          catalogo        = NULL, --LIM 12/NOV/2005
   @i_tasa_base            float           = NULL,  --CVA Ene-24-06
   @i_modifica             char(1)         = 'N',
   @i_op_operacion         int             = NULL,
   @i_amortiza_per         money           = 0,     --CVA Jul-29-06
   @i_fideicomiso          varchar(15)     = NULL,
   @i_desmaterializa       char(1)         = 'N'   -- ER DCVAL
)
with encryption
as
declare 
   @w_sp_name                   varchar(32),
   @w_return                    int,               -- GES 09/19/01 CUZ-034-001
   @w_num_banco                 cuenta,
   @w_operacionpf               int,
   @w_p_operacionpf             int,
   @w_oficial                   login,
   @w_toperacion                varchar(5),
   @w_accion_sgte               varchar(5),
   @w_tipo_plazo                varchar(5),
   @w_tipo_monto                varchar(5),
   @w_tipo_deposito             int,    -- ER DCVAL
   @w_categoria                 catalogo,
   @w_ch1                       catalogo,
   @w_oficina                   smallint,
   @w_base_cal1                 catalogo,
   @w_estado                    catalogo,
   @w_base_calculo              smallint,
   @w_moneda                    tinyint,
   @w_casilla                   tinyint,
   @w_direccion                 tinyint,
   @w_num_dias                  smallint,
   @w_dias                      smallint,         -- diasreales si fe.ven cambio
   @w_dif                       smallint,
   @w_monto                     money,
   @w_impuesto                  money,
   @w_impuesto_ica              money,  -- NYM DPF00015 ICA
   @w_tasa                      float,
   @w_tasa1                     float,
   @w_tasa_efectiva             float,
   @w_int_estimado              money,
   @w_int_estimado_mod          money,
   @w_int_estimado_hold         money,
   @w_total_int_estimado        money,
   @w_num_pagos                 smallint,
   @w_ppago                     char(3),
   @w_fpago                     char(3),
   @w_retienimp                 char(1),
   @w_mantiene_stock            char(1),
   @w_es_lote                   char(1),
   @w_tcapitalizacion           char(1),
   @w_dia_pago                  tinyint,
   @w_descripcion               varchar(255),
   @w_fecha_valor               datetime,
   @w_fecha_real_pg             datetime,
   @w_fecha_ven                 datetime,
   @w_fecha_ven1                datetime,
   @w_fecha_pg_int              datetime,
   @w_numdeci                   tinyint,
   @w_usadeci                   char(1),
   /* Manejo de Fecha Comercial */
   @w_yy_fechval                int,            
   @w_dd_fechval                int,            
   @w_mm_fechval                int,            
   @w_fechaf                    datetime,       
   @w_residuo                   int,            
   @w_dd_ult_pg_int             int,            -- 04/04/2000 Fecha Comercial
   --04/04/2000 Fecha Comercial
   @w_fecha_ingreso             datetime,  -- fusfra 05/11/2000
   @w_dp_ente                   int,    -- fusfra 05/11/2000
   @w_dp_monto                  money,     -- fusfra 05/11/2000
   @w_dp_forma_pago             catalogo,  -- fusfra 05/11/2000
   @w_dp_tipo                   catalogo,  -- fusfra 05/11/2000
   @w_dp_cuenta                 cuenta,    -- fusfra 05/11/2000
   @w_dp_porcentaje             int,    -- fusfra 05/11/2000
   @w_dp_estado                 char(1),
   @w_dp_moneda_pago            smallint,       
   @w_dp_descripcion            varchar,
   @w_dp_oficina                int,
   @w_dp_tipo_cliente           char,
   @w_dp_benef_chq              varchar,
   @w_dp_secuencial             int,
   @w_dp_tipo_cuenta_ach        char,
   @w_dp_banco_ach              descripcion,
   @w_dias_reales               char(1),      -- gap DP00008
   @w_fecha_estimint            datetime,
   @w_ajuste                    money,
   @w_int_ganado                money,
   @w_total_int_ganado          money,
   @w_int_estimado_inc          money,
   @w_total_int_estimado_inc    money,
   @w_op_fecha_ven              datetime,
   @w_op_fecha_valor            datetime,
   @w_op_fecha_pg_int           datetime,
   @w_op_fecha_ult_pg_int       datetime,
   @w_op_int_ganado             money,
   @w_op_total_int_ganados      money,
   @w_op_ult_fecha_calculo      datetime,
   @w_op_int_estimado           money,
   @w_op_total_int_estimado     money,
   @w_op_monto                  money, 
   @w_fecha_inicio_estimint     datetime,      -- GAR GB-DP00120 Dia Pago
   @w_op_dia_pago               tinyint,       -- GAR GB-DP00120 Dia Pago
   @w_cambia_dia_pago           char(1),       -- GAR GB-DP00120 Dia Pago
   @w_interes_act_prox          money,         -- GAR GB-DP00120 Dia Pago
   @w_monto_estim_int           money,         -- GAR GB-DP00120 Dia Pago
   @w_anio_comercial            char(1),
   @w_tot_int_estim_hold        money,
   @w_pl_mnemonico_min          catalogo,
   @w_pl_mnemonico_max          catalogo,
   @w_intereses_dia             float,        --LIM 18/OCT/2005
   @w_dias_calc                 int,           --LIM 18/OCT/2005
   @w_cupon                     char(1),       --LIM 21/OCT/2005
   @w_man_fecha_pg_int          datetime,
   @w_man_fecha_real_pg         datetime,
   @w_man_int_estimado          money,
   @w_man_total_int_estimado    money,
   @w_man_num_pagos             smallint,
   @w_op_monto_pg_int           money,
   @w_op_monto_pgdo             money,
   @w_op_monto_blq              money,
   @w_op_monto_blqlegal         money,
   
   @w_fecha_pg_int_ie           datetime,
   @w_int_ganado_ie             money,
   @w_int_estimado_ie           money,
   @w_total_int_estimado_ie     money,
   @w_afectacion                char(1),
   @w_total_int_ganado_ie       money,
   @w_amortiza_periodo          money,
   @w_porcentaje_amort          money,
   @w_factor_amort              money,
   @w_multiplo_bono             money,
   @w_overnight                 tinyint,       -- Control para plazo Overnight
   @w_prod_over                 catalogo,      -- Control para producto overnight
   @w_td_overnight              catalogo,
   -- NYM DOF00015 ICA
   @w_ret_ica                   char(1),
   @w_tasa_ica                  float,   
   @w_base_ret                  money,   
   @w_base_ica                  money,
   @w_tot_int_est_neto          money,      
   -- NYM DPF00015 ICA
   @w_desmaterializa            char(1) -- ER DCVAL

   select @i_retienimp = 'S'
select   @w_sp_name             = 'sp_operacion_tmp',
         @w_num_banco           = @i_num_banco,
         @w_moneda              = @i_moneda,
         @w_casilla             = @i_casilla,
         @w_direccion           = @i_direccion,
         @w_num_dias            = @i_num_dias,
         @w_monto               = @i_monto,
         @w_tasa                = @i_tasa,
         @w_ppago               = @i_ppago,
         @w_dia_pago            = @i_dia_pago,
         @w_oficial             = @s_user,
         @w_categoria           = @i_categoria,
         @w_retienimp           = @i_retienimp,
         @w_ret_ica             = @i_ret_ica, -- NYM DPF00015 ICA
         @w_descripcion         = @i_descripcion,
         @i_retiene_imp_capital = isnull(@i_retiene_imp_capital, 'N')
/*------------------------------------*/
/* Verificar codigo de la transaccion */
/*------------------------------------*/
if   (@t_trn <> 14111 or @i_operacion <> 'I') and
     (@t_trn <> 14211 or @i_operacion <> 'U') and
     (@t_trn <> 14311 or @i_operacion <> 'R')
begin
  exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 141112
  return 1
end

--print 'operatmp @w_retienimp %1! ,  @w_ret_ica %2! @i_ret_ica %3! ', @w_retienimp,  @w_ret_ica, @i_ret_ica


--------------------------------
-- Inicializaciones automaticas
--------------------------------
if @i_oficina is not null
   select @w_oficina = @i_oficina
else
   select @w_oficina = @s_ofi

----------------------------------  
-- Obtener parametro de Overnight
----------------------------------
select @w_overnight = pa_tinyint,
       @w_prod_over = pa_char
  from cobis..cl_parametro 
 where pa_nemonico  = 'OVER'
   and pa_producto  = 'PFI'

-----------------
-- Encuentra parametro de decimales 
------------------------------------
select @w_usadeci = mo_decimales
  from cobis..cl_moneda
 where mo_moneda = @i_moneda

if @w_usadeci = 'S'
begin
   select @w_numdeci = isnull (pa_tinyint,0)
   from cobis..cl_parametro
   where pa_nemonico = 'DCI'
   and pa_producto = 'PFI'
end
else
   select @w_numdeci = 0 

-----------------------------------------------------------
-- Verificar claves foraneas y codigos de la operacion tmp
-----------------------------------------------------------
select 
   @w_tcapitalizacion = td_capitalizacion,
   @w_base_cal1       = substring (td_base_calculo,1,3),
   @w_tipo_deposito   = td_tipo_deposito,
   @w_fpago           = td_forma_pago,
   @w_mantiene_stock  = td_mantiene_stock,
   @w_cupon           = td_cupon,         -- 21/OCT/2005
   @w_dias_reales     = td_dias_reales,     -- gap DP00008
   @w_td_overnight    = substring(td_descripcion,charindex('OVER',td_descripcion),4)    -- Es temporal, no logico
from pf_tipo_deposito
where td_mnemonico = @i_toperacion

if @@rowcount = 0
begin
   exec cobis..sp_cerror 
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 141115
   return 141115
end

---------------------------------------------
-- Control para plazo de productos overnight
---------------------------------------------
if @w_td_overnight = @w_prod_over and @w_overnight <> @i_plazo_orig
begin
  exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 149101
  return 149101
end

-- Control para cupones CUZ
if @i_cupon is null
   select @i_cupon = @w_cupon

if @i_fpago is not null
   select @w_fpago = @i_fpago
            
----------------------------------------------------------
--Si viene desde el front_end gap DP00008 25-02-2005 xca
----------------------------------------------------------
if @i_tcapitalizacion is not null         
   select @w_tcapitalizacion  = @i_tcapitalizacion 

if @i_dias_reales is not null                
   select @w_dias_reales = @i_dias_reales    
else -- @i_dias_reales IS   NULL
   select @i_dias_reales = @w_dias_reales 

if @i_base_calculo is not null
   select   @w_base_calculo = convert(int,substring (@i_base_calculo,1,3))
else
   select   @w_base_calculo = convert(int,@w_base_cal1)

    exec @w_return = cob_pfijo..sp_aplica_impuestos
       @s_ofi                  = @s_ofi,
       @s_date                 = @s_date,
       @t_debug                = @t_debug,
       @i_ente                 = @i_ente,
       @i_plazo                = @i_num_dias,
       @i_capital              = @i_monto,
       @i_interes              = @w_total_int_estimado,
       @i_base_calculo         = @w_base_calculo,
       @o_retienimp            = @w_retienimp out,
       @o_tasa_retencion       = @w_tasa1 out,
       @o_valor_retencion      = @w_impuesto out

    if @w_return <> 0
    begin
       exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = @w_return
       return @w_return
    end

   
---------------------------------------
-- Control para operaciones de Reverso
---------------------------------------
if @i_operacion <> 'R' 
begin
   if @w_mantiene_stock='S'
   begin
      select @w_tipo_monto = at_valor     
      from pf_auxiliar_tip
      where at_tipo = 'MOT' 
         and at_tipo_deposito = @w_tipo_deposito 
         and at_moneda = @i_moneda 
         and at_estado = 'A'
      if @@rowcount = 0
      begin
         exec cobis..sp_cerror
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 141053
         return 1
      end
   end   
   else  --No mantiene stock
   begin 
      if @i_tipo_monto is null
      begin 
         select @w_tipo_monto = mo_mnemonico 
         from cob_pfijo..pf_monto, pf_auxiliar_tip 
         where @i_monto >= mo_monto_min
            and @i_monto <= mo_monto_max
            and mo_mnemonico = at_valor
            and at_tipo = 'MOT'
            and at_tipo_deposito = @w_tipo_deposito
            and at_estado = 'A'
            and at_moneda = @i_moneda
         if @@rowcount = 0
         begin
            exec cobis..sp_cerror 
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,  
               @i_num   = 141053
            return 1
         end 
      end
      else
         select @w_tipo_monto = @i_tipo_monto


      --I. CVA Jul-29-06 Para Bonos obtener el porcentaje
      select  @w_porcentaje_amort = 0,@w_multiplo_bono = 1000

      select  @w_porcentaje_amort = isnull(at_porcentaje,0)
      from pf_tipo_deposito, pf_auxiliar_tip
                where td_mnemonico     = @i_toperacion
                  and at_tipo_deposito = td_tipo_deposito
                  and at_tipo          = 'PPE'
                  and at_valor         = @i_ppago

      select  @w_factor_amort  = @i_monto / @w_multiplo_bono

      select @w_amortiza_periodo = @w_porcentaje_amort * @w_factor_amort

      --F. CVA Jul-29-06 Para Bonos obtener el porcentaje

   end  /* si no mantiene stock */ 

   if @i_tipo_plazo is null  and @i_incremento <> 'S'
   begin 
      if datalength(@i_toperacion) > 3
      begin
         select   @w_pl_mnemonico_min = min(pl_mnemonico),
            @w_pl_mnemonico_max = max(pl_mnemonico) 
         from pf_plazo, pf_auxiliar_tip
         where  pl_mnemonico  = at_valor
            and at_tipo          = 'PLA'
            and at_tipo_deposito = @w_tipo_deposito
            and at_moneda        = @i_moneda
            and at_estado        = 'A'
                 
         select @w_tipo_plazo = min(pl_mnemonico)
         from pf_plazo, pf_auxiliar_tip
         where at_valor in(@w_pl_mnemonico_min, @w_pl_mnemonico_max)
            and pl_mnemonico  = at_valor
            and at_tipo          = 'PLA'
            and at_tipo_deposito = @w_tipo_deposito
            and at_moneda        = @i_moneda
            and at_estado        = 'A'
      end
      else  -- Es un deposito NO LIBOR
      begin
         select @w_tipo_plazo = pl_mnemonico 
         from cob_pfijo..pf_plazo, 
         cob_pfijo..pf_auxiliar_tip
         where @i_num_dias >= pl_plazo_min
            and @i_num_dias <= pl_plazo_max 
            and pl_mnemonico = at_valor
            and at_tipo = 'PLA'
            and at_tipo_deposito = @w_tipo_deposito
            and at_estado = 'A'
            and at_moneda = @i_moneda
               
         if @@rowcount = 0
         begin
            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 141054
            return 1
         end 
      end  
   end   -- @i_tipo_plazo is null and @i_incremento <> 'S'
   else
   begin
      select @w_tipo_plazo = @i_tipo_plazo
   end

   -----------------------------------
   -- Verificar existencia de la tasa
   -----------------------------------
   if @i_tasa_variable = 'N' and @i_incremento <> 'S' and @i_tipo_plazo is null --CVA Mar-06-07 tipo_plazo is null
   begin
      if not exists ( select 1 from cob_pfijo..pf_tasa 
            where ta_tipo_deposito = @i_toperacion 
            and ta_moneda       = @i_moneda
            and ta_tipo_monto   = @w_tipo_monto
            and ta_tipo_plazo   = @w_tipo_plazo) 
      begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 141055
         return 141055
      end
   end --@i_tasa_variable = 'N'

   -------------------------------------------- 
   -- Verificar existencia de la tasa variable
   --------------------------------------------
   if @i_tasa_variable = 'S'
   begin
      if not exists (select 1 from pf_tasa_variable
               where tv_mnemonico_prod       = @i_toperacion 
                  and tv_moneda         = @i_moneda
                  and tv_mnemonico_tasa = @i_mnemonico_tasa)
      begin
         exec cobis..sp_cerror 
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,   
            @i_msg   = 'No existe parametrizacion de tasa variable',
            @i_num   = 141155
         return 1
      end
   end
end   --@i_operacion <> 'R'
else  --caso contrario de  @i_operacion <> 'R'
begin
   /*CVA Nov-02-05 Agregar consultar los datos de tipo plazo y tipo monto */
   if @i_tipo_monto is null
   begin 
      select @w_tipo_monto = mo_mnemonico 
      from cob_pfijo..pf_monto, pf_auxiliar_tip 
      where   @i_monto     >= mo_monto_min
         and @i_monto      <= mo_monto_max
         and mo_mnemonico  = at_valor
         and at_tipo       = 'MOT'
         and at_tipo_deposito    = @w_tipo_deposito
         and at_estado     = 'A'
         and at_moneda     = @i_moneda
      if @@rowcount = 0
      begin
         exec cobis..sp_cerror 
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,  
            @i_num   = 141053
            return 141053
      end 
   end

   if @i_tipo_plazo is null 
   begin 
      if datalength(@i_toperacion) > 3
      begin
         select   @w_pl_mnemonico_min = min(pl_mnemonico),
            @w_pl_mnemonico_max = max(pl_mnemonico) 
         from pf_plazo, pf_auxiliar_tip
         where  pl_mnemonico  = at_valor
            and at_tipo          = 'PLA'
            and at_tipo_deposito = @w_tipo_deposito
            and at_moneda        = @i_moneda
            and at_estado        = 'A'
                 
         select @w_tipo_plazo = min(pl_mnemonico)
         from pf_plazo, pf_auxiliar_tip
         where at_valor in(@w_pl_mnemonico_min, @w_pl_mnemonico_max)
            and pl_mnemonico  = at_valor
            and at_tipo          = 'PLA'
            and at_tipo_deposito = @w_tipo_deposito
            and at_moneda        = @i_moneda
            and at_estado        = 'A'
      end
      else  -- Es un deposito NO LIBOR
      begin
         select @w_tipo_plazo = pl_mnemonico 
         from cob_pfijo..pf_plazo, 
         cob_pfijo..pf_auxiliar_tip
         where   @i_num_dias     >= pl_plazo_min
            and @i_num_dias   <= pl_plazo_max 
            and pl_mnemonico  = at_valor
            and at_tipo       = 'PLA'
            and at_tipo_deposito    = @w_tipo_deposito
            and at_estado     = 'A'
            and at_moneda     = @i_moneda
               
         if @@rowcount = 0
         begin
            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 141054
            return 141054
         end 
      end  
   end   -- @i_tipo_plazo is null 
end

---------------------------------------------------------
-- Control para incrementos reducciones y cambio de Tasa
---------------------------------------------------------
if @i_incremento = 'S'
begin
   select  @w_tipo_plazo            = op_tipo_plazo,
      @w_op_fecha_ven          = op_fecha_ven,
      @w_op_fecha_valor        = op_fecha_valor,
      @w_op_fecha_pg_int       = op_fecha_pg_int,
      @w_op_fecha_ult_pg_int   = op_fecha_ult_pg_int,
      @w_op_int_ganado         = op_int_ganado,
      @w_op_total_int_ganados  = op_total_int_ganados,
      @w_op_int_estimado       = op_int_estimado,
      @w_op_total_int_estimado = op_total_int_estimado,
      @w_p_operacionpf         = op_operacion,
      @w_op_monto              = op_monto,
      @i_dias_reales           = op_dias_reales,
      @w_op_dia_pago           = op_dia_pago --GAR GB-DP00120 Dia Pago
   from cob_pfijo..pf_operacion
   where op_num_banco = @i_num_banco

   if @i_monto is not null   --CVA Oct-18-05
         select @w_op_monto = @i_monto 
end 

select @w_accion_sgte = 'NULL'

/****************************************
CCR Verificar el monto disponible del DPF
****************************************/
if @i_flag_val_disponible ='S'
begin
   select @i_monto_incremento = isnull(@i_monto_incremento, 0)
   select   @w_op_monto_pg_int   = isnull(op_monto_pg_int, 0),
      @w_op_monto_pgdo  = isnull(op_monto_pgdo, 0),
      @w_op_monto_blq      = isnull(op_monto_blq, 0),
      @w_op_monto_blqlegal = isnull(op_monto_blqlegal, 0)
   from  pf_operacion
   where op_num_banco   = @i_num_banco
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file     = @t_file,
         @t_from     = @w_sp_name,
         @i_num      = 141051
      return 141051
   end
   
   if @i_monto_incremento < 0
   begin
      if abs(@i_monto_incremento) > (@w_op_monto_pg_int - @w_op_monto_pgdo - @w_op_monto_blq - @w_op_monto_blqlegal)
      begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 141189
         return 141189
      end
   end
end

/***** FIN CCR *************************/

--------------------------------
-- Verificar frecuencia de pago
--------------------------------
if @w_fpago = 'PER' 
begin
   if @i_ppago is null
   begin
      exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
      @t_from=@w_sp_name,   @i_num = 141072
      return 1
   end
   else 
      if not exists (select pp_codigo from pf_ppago where pp_codigo = @i_ppago)
      begin
         exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
         @t_from=@w_sp_name,   @i_num = 141071
         return 1
      end
end

--------------------------------------------------------------------------------
-- Estimacion de intereses y fechas. estimar proxima fecha de intereses a pagar
--------------------------------------------------------------------------------
if @i_fecha_valor is null
   select @w_fecha_valor = convert(datetime,convert(varchar,@s_date,101))
else
   select @w_fecha_valor = convert(datetime,convert(varchar,@i_fecha_valor,101))

-------------------------
-- Busca primer dia Habil
-------------------------
exec sp_primer_dia_labor
   @t_debug       = @t_debug,
   @t_file        = @t_file,
   @t_from        = @w_sp_name,
   @i_fecha       = @w_fecha_valor,
   @s_ofi         = @s_ofi,
   @i_tipo_deposito = @w_tipo_deposito,
   @o_fecha_labor = @w_fecha_valor out

if @w_dia_pago is null
   select @w_dia_pago = datepart(dd,@w_fecha_valor)

select @i_simulacion = isnull( @i_simulacion,'N')

-------------------------------
-- Analisis de Fecha comercial
-------------------------------
if @i_dias_reales = 'S'                -- GAL 26/AGO/2009 - RVVUNICA
begin
   select @w_fecha_ven = dateadd(dd,@w_num_dias,@w_fecha_valor) 
   select @w_anio_comercial = 'N'
end
else                                   -- GAL 26/AGO/2009 - RVVUNICA
begin
   exec sp_funcion_1 @i_operacion = 'SUMDIA',
      @i_fechai    = @w_fecha_valor,
      @i_dias      = @w_num_dias,
      @i_dia_pago  = @w_dia_pago,
      @o_fecha     = @w_fecha_ven out
   select @w_anio_comercial = 'S'
end

--------------------------------------
-- Proceso incrementado por DGU y XCA
--------------------------------------
if @i_flag = 0 
begin
   exec sp_primer_dia_labor
      @t_debug       = @t_debug, 
      @t_file        = @t_file,
      @t_from        = @w_sp_name,
      @i_fecha       = @w_fecha_ven,
      @s_ofi         = @s_ofi,
      @i_tipo_deposito = @w_tipo_deposito,
      @o_fecha_labor = @w_fecha_ven out
end

-------------------------------------------
-- Controla si hubo incremento o reduccion 
-------------------------------------------
if @i_incremento = 'S'
begin
   -- Obtener datos generales de pf_operacion
   select  @w_fecha_estimint = op_fecha_valor
   from pf_operacion
        where op_num_banco = @i_num_banco
end

-------------------------------
-- Estimaci¢n de Intereses
-------------------------------
if @i_incremento = 'S' -- GAR GB-DP00120 Dia Pago     ++++LLLLLLLLLLLL
begin
   if @w_op_fecha_valor <> @w_fecha_valor and @w_op_fecha_valor = @w_op_fecha_ult_pg_int
      select @w_fecha_inicio_estimint = @w_fecha_valor
   else
      select @w_fecha_inicio_estimint = @w_op_fecha_ult_pg_int

   select @w_monto_estim_int = @w_op_monto

   select @w_cambia_dia_pago = 'S'
end
else
begin
   select @w_fecha_inicio_estimint = @w_fecha_valor
   select @w_monto_estim_int = @w_monto
   select @w_cambia_dia_pago = 'S'
end

if @i_fecha_ven is null
   select @w_fecha_ven1 = @w_fecha_ven
else
   select @w_fecha_ven1 = @i_fecha_ven


--if @i_dias_reales = 'S'                                    GAL 14/SEP/2009 - RVVUNICA
--begin
   exec @w_return = sp_estima_int 
      @s_ofi              = @s_ofi,
      @s_date             = @s_date,
      @i_fecha_inicio     = @w_fecha_inicio_estimint, --GAR GB-DP00120 Dia Pago
      @i_cambia_dia_pago  = @w_cambia_dia_pago, --GAR GB-DP00120 Dia Pago
      @i_fecha_final      = @w_fecha_ven1,
      @i_monto            = @w_monto_estim_int,
      @i_tasa             = @w_tasa,
      @i_tcapitalizacion  = @w_tcapitalizacion,
      @i_fpago            = @w_fpago,
      @i_ppago            = @w_ppago,
      @i_dias_anio        = @w_base_calculo,
      @i_dia_pago         = @w_dia_pago,
      @i_batch            = 'S',
      @i_retienimp        = @w_retienimp,       
      --INI NYM DPF00015 ICA
      @i_tasa1            = @w_tasa1,
      @i_ret_ica          = @w_ret_ica,
      @i_tasa_ica         = @w_tasa_ica,
      --FIN NYM DPF00015 ICA
      @i_moneda           = @w_moneda,          
      @i_simulacion       = @i_simulacion,      
      @i_ente             = @i_ente,            
      @i_tasa_imp         = @w_tasa1,           
      @i_dias_reales      = @w_dias_reales,
      --I. CVA Jun-22-06 Parametros para escalonado
      @i_modifica         = @i_modifica,
      @i_op_operacion     = @i_op_operacion,
      @i_toperacion       = @i_toperacion,               
      @i_periodo_tasa     = @i_periodo_tasa,       -- cobis..te_pizarra..pi_periodo
      @i_modalidad_tasa   = @i_modalidad_tasa,     -- cobis..te_pizarra..pi_modalidad, en la IPC no aplica 
      @i_descr_tasa       = @i_descr_tasa,
      @i_mnemonico_tasa   = @i_mnemonico_tasa,     -- DTF, TCC, IPC, PRIME, ESC
      @i_tipo_plazo       = @w_tipo_plazo, 
      @i_en_linea         = 'S',     
      --F. CVA Jun-22-06 Parametros para escalonado
      @o_fecha_prox_pg    = @w_fecha_pg_int out,
      @o_fecha_real_pg    = @w_fecha_real_pg out,
      @o_int_pg_pp        = @w_int_estimado out,
      @o_int_pg_ve        = @w_total_int_estimado out,
      @o_num_pagos        = @w_num_pagos out,
      @o_tot_int_est_neto = @w_tot_int_est_neto out -- NYM DPF00015 ICA

   if @w_return <> 0
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141051
      return 141051
   end 

/*end                                                                   GAL 14/SEP/2009 - RVVUNICA
else --@w_anio_comercial = 'S'      --04/04/2000 Fecha Comercial
begin


   exec  @w_return = sp_estima_int_com  
      @s_ofi             = @s_ofi,
      @s_date            = @s_date,
      @i_fecha_inicio    = @w_fecha_inicio_estimint,
      @i_fecha_final     = @w_fecha_ven1,
      @i_monto           = @w_monto_estim_int,
      @i_tasa            = @w_tasa,
      @i_tcapitalizacion = @w_tcapitalizacion,
      @i_fpago           = @w_fpago,
      @i_ppago           = @w_ppago,
      @i_dias_anio       = @w_base_calculo,
      @i_dia_pago        = @w_dia_pago,
      @i_batch           = 1,
      @i_retienimp       = @w_retienimp,       
      @i_moneda          = @w_moneda,          
      @i_simulacion      = @i_simulacion,      
      @i_num_dias        = @w_num_dias,        
      @i_ente            = @i_ente,            
      @i_tasa_imp        = @w_tasa1,           
      --INI NYM DPF00015 ICA
      @i_tasa1           = @w_tasa1,
      @i_ret_ica         = @w_ret_ica,
      @i_tasa_ica        = @w_tasa_ica,
      --FIN NYM DPF00015 ICA
      @o_fecha_prox_pg   = @w_fecha_pg_int out,
      @o_fecha_real_pg   = @w_fecha_real_pg out,
      @o_int_pg_pp       = @w_int_estimado out,
      @o_int_pg_ve       = @w_total_int_estimado out,
      @o_num_pagos       = @w_num_pagos out,
      @o_tot_int_est_neto= @w_tot_int_est_neto out -- NYM DPF00015 ICA
   if @w_return <> 0
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141051
      return 141051
   end 
end
*/

--------------------------------------------
--  Almacenamiento de la operacion temporal
--------------------------------------------
if @i_fracciona = 'S'
begin
   select   @w_int_estimado   = @i_int_estimado,
      @w_total_int_estimado   = @i_tot_int_estimado
end

-------------------------------------------------------------------
-- Proceso de control de Simulacion para incrementos y reducciones
-------------------------------------------------------------------
if @i_simulacion = 'N'
begin
   if @i_operacion = 'U' or @i_operacion = 'R' 
   begin
      select   
         @w_num_banco     = op_num_banco, 
         @w_p_operacionpf = op_operacion,
         @w_estado        = op_estado
      from pf_operacion
      where op_num_banco = @i_num_banco
      
      if @@rowcount = 0
      begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 141051
         return 1
      end 
   end 

   ----------------------------------------------------------
   -- Captura de fechas de pagos de interes cuando es Fusion      
   ----------------------------------------------------------
   if @i_fracciona = 'S' 
   begin
      select @w_fecha_pg_int     = @i_fecha_pg_int
      select @w_fecha_real_pg    = @i_fecha_pg_int  -- En la temporal no existe este campo
      select @w_fecha_ingreso    = @i_fecha_ingreso
      select @w_fecha_ven        = @i_fecha_ven
   end
   else
      select @w_fecha_ingreso = @s_date

   begin tran  --*****************************************************************************************

   --------------------------------------------------
   -- Insercion de la operacion en tablas temporales
   --------------------------------------------------
   if @i_fusfra <> 'S'  --fusfra 05/11/2000 ral
   begin
      delete   pf_operacion_tmp 
      where ot_usuario = @s_user 
      and ot_sesion  = @s_sesn
      
      delete pf_beneficiario_tmp 
      where bt_usuario = @s_user 
      and bt_sesion  = @s_sesn
      
      delete pf_mov_monet_tmp 
      where mt_usuario = @s_user
      and mt_sesion  = @s_sesn
      
      delete pf_det_pago_tmp 
      where dt_usuario = @s_user
      and dt_sesion  = @s_sesn
      
      delete pf_det_cheque_tmp 
      where ct_usuario = @s_user 
      and ct_sesion  = @s_sesn  
      
   end
   
   if (@i_operacion = 'I') or (@i_operacion = 'R' and @w_estado = 'VEN') or
      (@i_operacion='R' and datediff(dd,@w_fecha_valor,@s_date)=0)
   begin
      if @w_mantiene_stock = 'S'
         select @w_es_lote='L'
      else 
         select @w_es_lote='N'

      ------------------------------
      -- Determinacion de la cuenta
      ------------------------------
      exec @w_return = cob_pfijo..sp_numero_oper
         @t_debug       = @t_debug,
         @t_file        = @t_file,
         @t_from        = @w_sp_name,
         @i_oficina     = @w_oficina,   --KTA GB-GAPDP00049 @i_oficina = @s_ofi,
         @i_toperacion  = @i_toperacion, 
         @i_moneda      = @w_moneda, 
         @i_es_lote     = @w_es_lote,
         @o_operacion   = @w_operacionpf out,
         @o_num_banco   = @w_num_banco out
         
      if @w_return <> 0
      begin
         rollback tran
         return @w_return
      end

      if @i_operacion = 'I'
         select  
            @i_num_banco     = @w_num_banco,
            @w_p_operacionpf = @w_operacionpf
   end
   else
      if (@i_operacion = 'U') or
         (@i_operacion = 'R' and @w_estado <> 'VEN' and datediff(dd,@w_fecha_valor,@s_date)<>0)
         
         select   
            @w_num_banco   = @i_num_banco,
            @w_operacionpf = @w_p_operacionpf

   /* --*-* no aplica ya que los calculos vienen de frontend
   ----------------------------------
   -- Calculo de fechas comerciales
   ----------------------------------
   if @i_dias_reales = 'S'  --04/04/2000 Fecha Comercial
      select @w_dias = datediff(dd,@w_fecha_valor,@w_fecha_ven) 
   else  --Es fecha comercial
   begin
      select @w_dd_ult_pg_int = datepart(dd,@i_fecha_valor)
   
      if @w_dd_ult_pg_int = 31
         select @i_fecha_valor = dateadd(dd,1,@i_fecha_valor)

      select @w_yy_fechval = datepart(yy,@i_fecha_valor) --xca 12/ene/99
      select @w_mm_fechval = datepart(mm,@i_fecha_valor) --xca 12/ene/99
      select @w_dd_fechval = datepart(dd,@i_fecha_valor) --xca 12/ene/99

      exec sp_funcion_1 
         @i_operacion = 'DIFE30', 
         @i_fechai   = @i_fecha_valor, 
         @i_fechaf   = @w_fecha_ven,
         @i_dia_pago = @w_dia_pago, --*-*
         @o_dias     = @w_dias out 
      
      ------------------------------------------------------------------------------------------------
      -- Proceso incrementado para tomar el numero real de dias, en un rango de fechas dadas a partir
      ------------------------------------------------------------------------------------------------
      select @w_residuo = @w_dias % 30

      exec sp_funcion_1 @i_operacion = 'SUMDIA',
         @i_fechai    = @i_fecha_valor,
         @i_dias      = @w_dias,
         @i_dia_pago = @w_dia_pago, --*-*
         @o_fecha     = @w_fechaf out
      
      if @w_fecha_ven <> @w_fechaf
      begin
         if @w_residuo > 0
         begin
            if @w_dias > 31 --si el plazo es de 60 dias en adelante
               select @w_dias = @w_dias - 1
            else --si el plazo es menor a 60 dias
            begin
               select @w_dd_fechval = @w_dd_fechval - 1    
               select @w_dias = @w_dd_fechval
            end
         end
      end
      else -- si @w_fecha_ven = @w_fechaf
      begin
         if @w_fpago in('VEN','ANT')
         begin
            if @w_mm_fechval = 1 and @w_dd_fechval >= 29
               select @w_dias = @i_num_dias
         end
      end  
   end */   --*-*

   select @w_dias = @i_num_dias
   
   insert pf_operacion_tmp(
      ot_usuario           , ot_sesion            , ot_num_banco         , ot_operacion, 
      ot_toperacion        , ot_categoria         , ot_oficina           , ot_moneda,
      ot_num_dias          , ot_monto             , ot_tasa              , ot_int_estimado, 
      ot_total_int_estimado, ot_ppago             , ot_dia_pago          , ot_oficial, 
      ot_descripcion       , ot_fecha_valor       , ot_fecha_ven         , ot_fecha_pg_int,
      ot_fecha_total       , ot_accion_sgte       , ot_fecha_ingreso     , ot_retienimp,
      ot_tipo_plazo        , ot_tipo_monto        , ot_tasa_efectiva     , ot_casilla,
      ot_direccion         , ot_fpago             , ot_tcapitalizacion   , ot_base_calculo,
      ot_operacion_new     , ot_impuesto          , ot_impuesto_capital  , ot_retiene_imp_capital, 
      ot_prorroga_aut      , ot_num_dias_gracia   , ot_flag_tasaefec     , ot_tot_int_ganados,
      ot_tot_int_retenido  , ot_tot_int_acumulado , ot_int_ganado        , ot_int_pagados,
      ot_tot_int_pagados   , ot_tot_int_provision , ot_tot_int_est_ant   , ot_residuo, 
      ot_fecha_ult_pg_int  , ot_fecven_ant        , ot_fecha_ord_act     , ot_ult_fecha_calculo, 
      ot_imprime           , ot_plazo_ant         , ot_puntos            , ot_estatus_prorroga,
      ot_num_prorroga      , ot_preimpreso        , ot_anio_comercial    , ot_tasa_variable,
      ot_mnemonico_tasa    , ot_modalidad_tasa    , ot_periodo_tasa      , ot_descr_tasa,
      ot_operador          , ot_spread            , ot_porc_comision     , ot_cupon,
      ot_categoria_cupon   , ot_captador          , ot_oficial_principal , ot_oficial_secundario,
      ot_origen_fondos     , ot_proposito_cuenta  , ot_producto_bancario1, ot_producto_bancario2,
      ot_revision_tasa     , ot_dias_reales       , ot_ente_corresp      , ot_plazo_orig,
      ot_sucursal          , ot_inactivo          , ot_incremento_suspenso, ot_localizado,  --LIM 22/OCT/2005
      ot_fecha_localizacion, ot_fecha_no_localiza , ot_dias_hold         , ot_aprobado, --LIM 22/OCT/2005
      ot_telefono          , ot_oficina_apertura  , ot_oficial_apertura  , ot_toperacion_apertura,
      ot_amortiza_periodo  , ot_fideicomiso       , ot_desmaterializa) -- ER DCVAL 
   values (    
      @s_user              , @s_sesn              , @i_num_banco         , @w_p_operacionpf,
      @i_toperacion        , @i_categoria         , @w_oficina           , @i_moneda       ,
      @w_dias              , @i_monto             , @i_tasa              , @w_int_estimado,
      @w_total_int_estimado, @i_ppago             , @w_dia_pago          , @w_oficial, 
      @i_descripcion       , @w_fecha_valor       , @w_fecha_ven         , @w_fecha_pg_int,
      @w_fecha_real_pg     , @w_accion_sgte       , @s_date              , 'N',
      @w_tipo_plazo        , @w_tipo_monto        , @i_tasa_efectiva     , @i_casilla,
      @i_direccion         , @w_fpago             , @w_tcapitalizacion   , @w_base_calculo,
      @w_operacionpf       , @w_tasa1             , @i_impuesto_capital  , @i_retiene_imp_capital,
      @i_prorroga_aut      , @i_num_dias_gracia   , @i_flag_tasaefec     , @i_tot_int_ganados,
      0			   , @i_tot_int_acumulado , @i_int_ganado        , @i_int_pagados, 
      @i_tot_int_pagados   , @i_tot_int_provision , @i_tot_int_est_ant   , @i_residuo, 
      @i_fecha_ult_pg_int  , @i_fecven_ant        , @i_fecha_ord_act     , @i_ult_fecha_calculo,
      @i_imprime           , @i_plazo_ant         , @i_puntos            , @i_estatus_prorroga,
      @i_num_prorroga      , @i_preimpreso        , @w_anio_comercial    , @i_tasa_variable, 
      @i_mnemonico_tasa    , @i_modalidad_tasa    , @i_periodo_tasa      , @i_descr_tasa, 
      @i_operador          , @i_spread            , @i_tasa_base         , @i_cupon,
      @i_categoria_cupon   , @i_captador          , @i_oficial_prin      , @i_oficial_sec, 
      @i_origen_fondos     , @i_proposito_cuenta  , @i_producto_bancario1, @i_producto_bancario2,
      @i_revision_tasa     , @i_dias_reales       , @i_ente_corresp      , @i_plazo_orig,
      @i_sucursal          , @i_inactivo          , @i_incremento_susp   , @i_localizado,      --LIM 22/OCT/2005
      @i_fecha_localizacion, @i_fecha_no_localiza , @i_dias_hold         , @i_aprobado,      --LIM 22/OCT/2005
      @i_telefono          , @i_oficina_aper      , @i_oficial_aper      , @i_tipope_aper, 
      @i_amortiza_per      , @i_fideicomiso       , @i_desmaterializa   )  -- ER DCVAL
   if @@error <> 0
   begin
      exec cobis..sp_cerror 
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 143001
      return 1
   end

   --CVA Jun-27-06 Solo guarda la parametrizacion al momento de la apertura para escalonados  
   if charindex('C',@w_tipo_plazo ) > 0 and @i_modifica = 'N'
   begin    
      insert pf_rubro_op_tmp 
         (rot_usuario,rot_sesion,rot_num_banco,rot_operacion,
         rot_toperacion,rot_moneda,rot_tipo_monto,rot_tipo_plazo,
         rot_concepto,rot_mnemonico_tasa,rot_operador,rot_modalidad_tasa,
         rot_periodo_tasa,rot_descr_tasa,rot_spread,rot_valor)
      select   @s_user     ,@s_sesn   ,@i_num_banco ,@w_p_operacionpf,
         @i_toperacion, @i_moneda,tv_tipo_monto, tv_tipo_plazo, 
         'INTERES'   ,tv_mnemonico_tasa, tv_operador,  @i_modalidad_tasa,
         @i_periodo_tasa, @i_descr_tasa, tv_spread_vigente, tv_tasa_min
      from  pf_tasa_variable
      where tv_mnemonico_prod = @i_toperacion
        and tv_tipo_monto  = @w_tipo_monto
      if @@error <> 0
      begin
         exec cobis..sp_cerror 
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 143001
         return 1
      end
   end                     

   
   if @i_fracciona = 'S'
   begin
      select @w_dp_forma_pago = isnull(pa_char,'VXP')
      from cobis..cl_parametro
      where pa_producto = 'PFI'
      and pa_nemonico = 'NVXP'   
         
      if @w_fpago = 'VEN'
         select @w_dp_tipo = 'INTV'
      else
         select @w_dp_tipo = 'INT'
         
      select @w_monto = @w_int_estimado
            
      insert into pf_det_pago_tmp 
         (dt_operacion,  dt_beneficiario      ,  dt_tipo            , dt_forma_pago, 
         dt_cuenta        , dt_monto             , dt_porcentaje      , dt_fecha_crea, 
         dt_fecha_mod     , dt_usuario           , dt_sesion          , dt_moneda_pago,
         dt_descripcion   , dt_oficina           , dt_tipo_cliente    , dt_benef_chq,
         dt_secuencia     , dt_tipo_cuenta_ach   , dt_banco_ach)
      values 
         (@w_p_operacionpf,   @i_ente_fraccion, @w_dp_tipo,    @w_dp_forma_pago, 
         null,       @w_monto,      100,     @s_date, 
         @s_date,       @s_user,       @s_sesn,    @i_moneda,
         null,          @w_oficina,    'M' ,       null, 
         0,       null,          null)
      if @@error <> 0 or @@rowcount <> 1
      begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 149999,
            @i_msg = 'Error al insertar detalle de pago'
         return 1
      end
   end   
   
   commit tran --++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
end --if @i_simulacion = 'N'

------------------------------------------------
-- Control para cambios de fecha de vencimiento
------------------------------------------------
if @w_op_fecha_ven <> @w_fecha_ven1 and @i_incremento = 'S'
begin 

   if @w_fecha_pg_int = @w_op_fecha_ven
      select @w_int_estimado = @w_op_int_ganado + round(((@w_op_monto*@w_tasa*datediff(dd,@s_date,@w_fecha_ven))/(@w_base_calculo*100)), @w_numdeci)           -- GAL 01/SEP/2009 - RVVUNICA

   select @w_total_int_estimado = @w_op_total_int_ganados + round(((@w_op_monto*@w_tasa*datediff(dd,@s_date,@w_fecha_ven))/(@w_base_calculo*100)), @w_numdeci) -- GAL 01/SEP/2009 - RVVUNICA

   if @i_tcapitalizacion = 'S' and @w_op_fecha_pg_int <> @w_op_fecha_ven
   begin
      ------------------------------------------------------------------------------
      -- Calcula Interes desde la fecha actual hasta la proxima fecha de pago GAR GB-DP00120
      ------------------------------------------------------------------------------
      select @w_interes_act_prox = round(((@w_op_monto*@w_tasa*datediff(dd,@s_date,@w_fecha_pg_int))/(@w_base_calculo*100)), @w_numdeci)                       -- GAL 01/SEP/2009 - RVVUNICA
      select @w_monto_estim_int = @w_monto_estim_int + @w_op_total_int_ganados + @w_interes_act_prox
      ------------------------------------------------------------------------------
      -- Calcula Interes desde la proxima fecha de pago hasta la fecha de vencimiento GAR GB-DP00120
      ------------------------------------------------------------------------------
      exec sp_estima_int 
         @i_fecha_inicio    = @w_fecha_pg_int, --GAR GB-DP00120 Dia Pago
         @i_cambia_dia_pago = 'N',             --GAR GB-DP00120 Dia Pago No cambia el dia de pago porque ya se calculo antes
         @s_ofi             = @s_ofi,
         @i_fecha_final     = @w_fecha_ven,
         @i_monto           = @w_monto_estim_int,
         @i_tasa            = @w_tasa,
         @i_tcapitalizacion = @w_tcapitalizacion,
         @i_fpago           = @w_fpago,
         @i_ppago           = @w_ppago,
         @i_dias_anio       = @w_base_calculo,
         @i_dia_pago        = @w_dia_pago,
         @i_batch           = 'S',
         @i_retienimp       = @w_retienimp,         
         @i_moneda          = @w_moneda,            
         @i_simulacion      = @i_simulacion,        
         @i_ente            = @i_ente,              
         @i_tasa_imp        = @w_tasa1,           
         --I. CVA Jun-27-06 Parametros para escalonado
         @i_modifica        = @i_modifica,
         @i_op_operacion    = @i_op_operacion,
         @i_toperacion      = @i_toperacion,               
         @i_periodo_tasa    = @i_periodo_tasa,       -- cobis..te_pizarra..pi_periodo
         @i_modalidad_tasa  = @i_modalidad_tasa,     -- cobis..te_pizarra..pi_modalidad, en la IPC no aplica 
         @i_descr_tasa      = @i_descr_tasa,
         @i_mnemonico_tasa  = @i_mnemonico_tasa,     -- DTF, TCC, IPC, PRIME, ESC
         @i_tipo_plazo      = @w_tipo_plazo, 
         @i_en_linea        = 'S',
         --F. CVA Jun-27-06 Parametros para escalonado
         @o_int_pg_pp       = @w_int_estimado out,
         @o_int_pg_ve       = @w_total_int_estimado out

      ------------------------------------------------------------------------------
      -- Suma los dos c lculos anteriores a los intereses ganados GAR GB-DP00120
      ------------------------------------------------------------------------------
      select @w_total_int_estimado = @w_op_total_int_ganados + @w_interes_act_prox + @w_total_int_estimado

   end
end

---------------------------------------
-- Control para cambios de fecha Valor
---------------------------------------
if @i_cambio_oper = 'S' and @w_op_fecha_valor <> @w_fecha_valor and @i_incremento = 'S' and @w_op_fecha_valor = @w_op_fecha_ult_pg_int
begin
   if exists (select 1 from cob_pfijo..pf_incre_op
         where io_operacion = @w_p_operacionpf
         and io_fecha_valor = @w_op_fecha_valor)
   begin
      print 'No puede procesar operacion con inc/reduc'
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141051
      return 1
   end
   else
   begin
      if @w_cambia_dia_pago = 'N'
      begin
         -------------------------------------------------------------------------
         -- Calculo del interes cuando no cambia la fecha de pago GAR GB-DP00120
         -------------------------------------------------------------------------        
         select @w_int_estimado = round(((@w_op_monto*@w_tasa*datediff(dd,@i_fecha_valor,@w_op_fecha_pg_int))/(@w_base_calculo*100)), @w_numdeci) -- GAL 01/SEP/2009 - RVVUNICA

         select @w_monto_estim_int = @w_op_monto + @w_int_estimado

         exec sp_estima_int 
            @i_fecha_inicio    = @w_op_fecha_pg_int, --GAR GB-DP00120 Dia Pago
            @i_cambia_dia_pago = 'N',             --GAR GB-DP00120 Dia Pago No cambia el dia de pago 
            @s_ofi             = @s_ofi,
            @i_fecha_final     = @w_fecha_ven,
            @i_monto           = @w_monto_estim_int,
            @i_tasa            = @w_tasa,
            @i_tcapitalizacion = @w_tcapitalizacion,
            @i_fpago           = @w_fpago,
            @i_ppago           = @w_ppago,
            @i_dias_anio       = @w_base_calculo,
            @i_dia_pago        = @w_dia_pago,
            @i_batch           = 'S',
            @i_retienimp       = @w_retienimp,       
            @i_moneda          = @w_moneda,          
            @i_simulacion      = @i_simulacion,      
            @i_ente            = @i_ente,            
            @i_tasa_imp        = @w_tasa1,    

            --I. CVA Jun-27-06 Parametros para escalonado
            @i_modifica        = @i_modifica,
            @i_op_operacion    = @i_op_operacion,
            @i_toperacion      = @i_toperacion,               
            @i_periodo_tasa    = @i_periodo_tasa,       -- cobis..te_pizarra..pi_periodo
            @i_modalidad_tasa  = @i_modalidad_tasa,     -- cobis..te_pizarra..pi_modalidad, en la IPC no aplica 
            @i_descr_tasa      = @i_descr_tasa,
            @i_mnemonico_tasa  = @i_mnemonico_tasa,     -- DTF, TCC, IPC, PRIME, ESC
            @i_tipo_plazo      = @w_tipo_plazo, 
            @i_en_linea        = 'S',
            --F. CVA Jun-27-06 Parametros para escalonado
       
            @o_int_pg_ve       = @w_total_int_estimado out
         
         select @w_total_int_estimado = @w_total_int_estimado + @w_int_estimado

      end 
   end
end
    -- NYM DPF00015 RETENCION ICA

    if @w_op_monto is null
        select @w_monto = @i_monto
    else
        select @w_monto = @w_op_monto

        exec @w_return = cob_pfijo..sp_aplica_impuestos
       @s_ofi                  = @s_ofi,
       @s_date                 = @s_date,
       @t_debug                = @t_debug,
       @i_ente                 = @i_ente,
       @i_plazo                = @i_num_dias,
       @i_capital              = @w_monto,
       @i_interes              = @w_int_estimado,
       @i_base_calculo         = @w_base_calculo,
       @o_retienimp            = @w_retienimp out,
       @o_tasa_retencion       = @w_tasa1 out,
       @o_valor_retencion      = @w_impuesto out

    if @w_return <> 0
    begin
       exec cobis..sp_cerror
       @t_from  = @w_sp_name,
       @i_num   = @w_return
       return @w_return
    end



--------------------------------------------------
-- RECALCULO DE INTERES POR TIEMPO DE TRANSITO
--------------------------------------------------
if @i_fecha_valor_hold is not null  
begin

   -- if @i_dias_reales = 'S'                                                 GAL 14/SEP/2009 - RVVUNICA
   -- begin
      exec @w_return = sp_estima_int 
         @i_fecha_inicio    = @i_fecha_valor_hold, --GAR GB-DP00120 Dia Pago
         @i_cambia_dia_pago = @w_cambia_dia_pago, --GAR GB-DP00120 Dia Pago
         @s_ofi             = @s_ofi,
         @s_date            = @s_date,
         @i_fecha_final     = @i_fecha_venci_hold,
         @i_monto           = @w_monto_estim_int,
         @i_tasa            = @w_tasa,
         @i_tcapitalizacion = @w_tcapitalizacion,
         @i_fpago           = @w_fpago,
         @i_ppago           = @w_ppago,
         @i_dias_anio       = @w_base_calculo,
         @i_dia_pago        = @w_dia_pago,
         @i_batch           = 'S',
         @i_retienimp       = @w_retienimp,       
         @i_moneda          = @w_moneda,          
         @i_simulacion      = @i_simulacion,      
         @i_ente            = @i_ente,            
         @i_tasa_imp        = @w_tasa1,           
         @i_dias_reales     = @w_dias_reales,
         --I. CVA Jun-22-06 Parametros para escalonado
         @i_modifica        = @i_modifica,
         @i_op_operacion    = @i_op_operacion,
         @i_toperacion      = @i_toperacion,               
         @i_periodo_tasa    = @i_periodo_tasa,       -- cobis..te_pizarra..pi_periodo
         @i_modalidad_tasa  = @i_modalidad_tasa,     -- cobis..te_pizarra..pi_modalidad, en la IPC no aplica 
         @i_descr_tasa      = @i_descr_tasa,
         @i_mnemonico_tasa  = @i_mnemonico_tasa,     -- DTF, TCC, IPC, PRIME, ESC
         @i_tipo_plazo      = @w_tipo_plazo, 
         @i_en_linea        = 'S',
         --F. CVA Jun-22-06 Parametros para escalonado
         @o_fecha_prox_pg   = @w_fecha_pg_int out,    --CVA Set-21-05
         @o_int_pg_pp       = @w_int_estimado_hold out,
         @o_int_pg_ve       = @w_tot_int_estim_hold out,
         @o_num_pagos       = @w_num_pagos out  -- 20-Sep-2005 xca
         
      if @w_return <> 0
      begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 141051
         return 141051
      end 
   /*                                                                        GAL 14/SEP/2009 - RVVUNICA
   end
   else --@w_anio_comercial = 'S'      --04/04/2000 Fecha Comercial
   begin
      exec @w_return = sp_estima_int_com  
         @i_fecha_inicio    = @i_fecha_valor_hold,
         @s_ofi             = @s_ofi,
         @s_date            = @s_date,
         @i_fecha_final     = @i_fecha_venci_hold,
         @i_monto           = @w_monto_estim_int,
         @i_tasa            = @w_tasa,
         @i_tcapitalizacion = @w_tcapitalizacion,
         @i_fpago           = @w_fpago,
         @i_ppago           = @w_ppago,
         @i_dias_anio       = @w_base_calculo,
         @i_dia_pago        = @w_dia_pago,
         @i_batch           = 1,
         @i_retienimp       = @w_retienimp,       
         @i_moneda          = @w_moneda,          
         @i_simulacion      = @i_simulacion,      
         @i_num_dias        = @w_num_dias,        
         @i_ente            = @i_ente,            
         @i_tasa_imp        = @w_tasa1,           
         @o_fecha_prox_pg   = @w_fecha_pg_int out,     --CVA Set-21-05
         @o_int_pg_pp       = @w_int_estimado_hold out,
         @o_int_pg_ve       = @w_tot_int_estim_hold out,
         @o_num_pagos       = @w_num_pagos out  -- 20-Sep-2005 xca
      if @w_return <> 0
      begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 141051
         return 141051
      end 
   end
   */
   
   select   
      @w_int_estimado       = @w_int_estimado_hold,
      @w_total_int_estimado = @w_tot_int_estim_hold
end

--print '@w_fecha_ven1 %1! @w_op_fecha_ven %2!',@w_fecha_ven1, @w_op_fecha_ven
if @i_incremento = 'S' or @i_mantenimiento = 'S'   --*-* and @w_op_fecha_ven = @w_fecha_ven1 --and @w_op_fecha_valor = @w_fecha_valor
begin
   select @w_int_estimado_mod = @w_int_estimado

   if @i_incremento = 'S'
      select 
         @w_afectacion = 'I',
         @w_fecha_ven1 = NULL,
         @w_num_dias   = NULL
   else  
      select @w_afectacion = 'M'

   exec @w_return = sp_calcula_mod
      @s_ofi                 = @s_ofi,
      @s_date                = @s_date,
      @i_toperacion          = NULL,
      @i_categoria           = NULL,  
      @i_oficina             = NULL,  
      @i_num_dias            = @w_num_dias,    --Nuevo plazo
      @i_monto               = @i_monto,    --Monto aplicado el incremento o decremento
      @i_ppago               = @i_ppago,    --Nuevo periodo de pago 
      @i_fpago               = @i_fpago,    --Nueva forma de pago
      @i_dia_pago            = @i_dia_pago,    --Dia de pago modificado
      @i_tcapitalizacion     = @i_tcapitalizacion,   --Condicion de capitalizacion
      @i_base_calculo        = @i_base_calculo,   --Nueva Base de Calculo 
      @i_fecha_ven           = @w_fecha_ven1,  --Nueva Fecha de Vencimiento
      @i_fecha_valor         = @i_fecha_valor, --Nueva Fecha Valor de la operacion
      @i_dias_reales         = @i_dias_reales, --Manejo de fechas comerciales o calendario     
      @i_man_inc             = @w_afectacion,        
      @i_fecha_valor_cambio  = @i_fecha_valor_cambio,--Fecha valor de aplicacion del cambio de condiciones(INC/DEC/TASA)
      @i_tasa                = @i_tasa,     --Nueva tasa
      @i_num_banco           = @i_num_banco,
      @i_formato_fecha       = @i_formato_fecha,
      @i_moneda              = @w_moneda,      
      --I. CVA Jun-27-06 Parametros para escalonado
      @i_modifica            = @i_modifica,           --CVA Jun-28-06
      @i_periodo_tasa        = @i_periodo_tasa,       -- cobis..te_pizarra..pi_periodo
      @i_modalidad_tasa      = @i_modalidad_tasa,     -- cobis..te_pizarra..pi_modalidad, en la IPC no aplica 
      @i_descr_tasa          = @i_descr_tasa,
      @i_mnemonico_tasa      = @i_mnemonico_tasa,     -- DTF, TCC, IPC, PRIME, ESC
      @i_tipo_plazo          = @w_tipo_plazo, 
      @i_en_linea            = 'S',
      --F. CVA Jun-27-06 Parametros para escalonado
      @o_fecha_pg_int        = @w_fecha_pg_int        out,
      @o_int_ganado          = @w_int_ganado          out,
      @o_int_estimado        = @w_int_estimado        out,
      @o_total_int_estimado  = @w_total_int_estimado  out,
      @o_total_int_ganado    = @w_total_int_ganado_ie out,
      @o_num_pagos           = @w_num_pagos           out

   if @w_return <> 0
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_msg    = 'Error en calculo de Cambios para Modificar Certificado...',
         @i_num   = 141051
      return 141051
   end         

        --CVA Dic-16-05 Si esta en su ultimo dia cal_mod retorna 0 en intestimado        
        if @w_int_estimado = 0 
           select @w_int_estimado = @w_int_estimado_mod
   
--print 'XXX int_estim:%1!,int_gan:%2!,fecha_pg_int:%3!,numP:%4!',@w_int_estimado, @w_int_ganado,@w_fecha_pg_int,@w_num_pagos

end  -- if Incremento

--print 'SIM:%1!',@i_simulacion

--*-* Si la fecha de proximo pago de interes es igual a la fecha de proceso => error!
if @w_fecha_pg_int < @s_date
begin 
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_msg    = 'Error fecha de proximo pago no puede ser menor o igual que hoy...',
         @i_num   = 141051
      return 141051
end

if @i_simulacion = 'S'
begin

--print 'M:%1!,N:%2!,O:%3!,P:%4!,Q:%5!,R:%6!,S:%7!',@w_int_estimado,@w_total_int_estimado,@w_impuesto,@w_fecha_pg_int,@w_dia_pago,@w_num_pagos,@w_tasa

--print 'NYM @w_impuesto  %1! , @w_impuesto_ica %2! , @w_tot_int_est_neto %3! ', @w_impuesto, @w_impuesto_ica, @w_tot_int_est_neto
   select   
      'INTERES ESTIMADO'            = round(@w_int_estimado,@w_numdeci),
      'TOTAL INT. ESTIMADO'         = round(@w_total_int_estimado,@w_numdeci),
      'IMPUESTOS A PAGAR '          = round(@w_impuesto,@w_numdeci),
      'FECHA PAGO INTERES'          = convert(varchar,@w_fecha_pg_int, @i_formato_fecha),   
      'DIA DE PAGO'                 = convert(varchar(3),@w_dia_pago) + ' DE CADA MES',
      'NUMERO DE PAGOS'             = @w_num_pagos,
      'TASA EFECTIVA'               = @w_tasa,
      'INTERES ESTIMADO HOLD'       = @w_int_estimado_hold,
      'TOTAL INTERES ESTIMADO HOLD' = @w_tot_int_estim_hold,
      'INT GANADO ACTUAL'           = @w_int_ganado,     --10
      'NUEVO TIPO MONTO'            = @w_tipo_monto,
      'NUEVO TIPO DE PLAZO'         = @w_tipo_plazo,
      'TOTAL INT GANADO'            = @w_total_int_ganado_ie,
      'AMORTIZACION PERIODO'        = isnull(@w_amortiza_periodo,0),
      'IMPUESTO ICA'                = round(isnull(@w_impuesto_ica,0),@w_numdeci),     --NYM DPF00015 ICA
      'TOAL INT NETO'               = round(isnull(@w_tot_int_est_neto,0),@w_numdeci ) --NYM DPF00015 ICA
end
else
begin
   select   
      'NUM. BANCO'                  = @w_num_banco,
      'NUM. OPERACION'              = @w_operacionpf,
      'FECHA VENCIMIENTO'           = convert(varchar(10),@w_fecha_ven,@i_formato_fecha),
      'INTERES ESTIMADO'            = round(@w_int_estimado,@w_numdeci),
      'IMPUESTOS A PAGAR '          = round(@w_impuesto,@w_numdeci),
      'TOTAL INT. ESTIMADO'         = round(@w_total_int_estimado,@w_numdeci),
      'FECHA PAGO INTERES'          = convert(varchar,@w_fecha_pg_int, @i_formato_fecha),      
      'DIA DE PAGO'                 = convert(varchar(3),@w_dia_pago) + ' DE CADA MES',
      'NUMERO DE PAGOS'             = @w_num_pagos,
      'INTERES ESTIMADO HOLD'       = @w_int_estimado_hold,
      'TOTAL INTERES ESTIMADO HOLD' = @w_tot_int_estim_hold,
      'IMPUESTO ICA'                = round(isnull(@w_impuesto_ica,0),@w_numdeci), --NYM DPF00015 ICA
      'TOAL INT NETO'               = round(isnull(@w_tot_int_est_neto,0),@w_numdeci ) --NYM DPF00015 ICA
end

return 0
go
