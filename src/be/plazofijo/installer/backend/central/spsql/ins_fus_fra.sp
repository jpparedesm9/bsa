/************************************************************************/
/*      Archivo:                insfufra.sp                             */
/*      Stored procedure:       sp_ins_fus_fra                          */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Giovanni White                          */
/*      Fecha de documentacion: 19/Ago/98                               */
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
/*      Este procedimiento debe realizar la insercion de la operacion   */
/*      nueva que es producto de la fusion de varias operaciones.       */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*   FECHA         AUTOR                 RAZON                          */
/*   19-Ago-98  Giovanni White           Emision Inicial                */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where type ='P' and name = 'sp_ins_fus_fra')
   drop proc sp_ins_fus_fra
go
create proc sp_ins_fus_fra (
@s_ssn                  int         = NULL,
@s_sesn                 int         = NULL,
@s_user                 login       = NULL,
@s_term                 varchar(30) = NULL,
@s_date                 datetime    = NULL,
@s_srv                  varchar(30) = NULL,
@s_lsrv                 varchar(30) = NULL,
@s_ofi                  smallint    = NULL,
@s_rol                  smallint    = NULL,
@t_debug                char(1)     = 'N',
@t_file                 varchar(10) = NULL,
@t_from                 varchar(32) = NULL,
@t_trn                  smallint    = NULL,
@i_num_banco            cuenta      = ' ',
@i_operacion            char(1)     = NULL,
@i_renovaut             char(1)     = 'N',
@i_puntos               float       =  0, --12-Abr-2000 Tasa Variable
@i_cancelaut            char(1)     = 'N',
@i_renova_todo          char(1)     = 'N',
@i_monto_base           money       = 0,
@i_int_ganado           money       = 0,
@i_int_pagados          money       = 0,
@i_tot_int_provision    money       = 0,
@i_tot_int_ganados      money       = 0,
@i_tot_int_pagados      money       = 0,
@i_fraccion             char(1)     = 'N',
@i_batch                char(1)     = 'N',
@i_observacion          descripcion = NULL,  --+-+
@i_fecha_inicio         datetime    = NULL,  --+-+
@i_sub_secuencia        int         = 0,
@i_mon_sgte             int,
@o_int_ganado           money out)
with encryption
as
declare  @w_sp_name            varchar(32),
        @w_return             int,
   @w_numdeci            int,
        @w_usadeci            char(1),
        @w_num_oficial        int,
        @w_num_banco          cuenta,
        @w_operacionpf        int,
        @w_toperacion         catalogo,
        @w_categoria          catalogo,
        @w_oficina            int,
        @w_moneda             int,
        @w_num_dias           smallint,
        @w_monto              money,
        @w_tasa               float,
        @w_int_estimado       money,
        @w_total_int_estimado money,
        @w_ppago              catalogo,
        @w_dia_pago           smallint,
        @w_oficial            varchar(14),
        @w_descripcion        varchar(255),
        @w_fecha_valor        datetime,
        @w_fecha_ven          datetime,
        @w_fecha_pg_int       datetime,
        @w_fecha_ing          datetime,
        @w_ult_fecha_calculo  datetime,
        @w_retienimp          char(1),
        @w_tipo_plazo         catalogo,
        @w_tipo_monto         catalogo,
        @w_tasa_efectiva      float,
        @w_tcapitalizacion    catalogo,
        @w_fpago              catalogo,
        @w_base_calculo       int,
        @w_casilla            int,
        @w_direccion          int,
        @w_tasa_imp           float,
        @w_comision           money,
        @w_puntos             float, --12-Abr-2000 Tasa Variable
        @w_ente               int,
        @w_mt_sub_secuencia   int,
        @w_monto_pg_int       money, 
        @w_monto_pgdo         money,
        @w_monto_blq          money,
        @w_int_ganado         money,
        @w_int_pagados        money,
        @w_int_provision      money,
        @w_total_int_ganados  money,
        @w_total_int_pagados  money,
        @w_historia           int,
        @w_tasa_mer           float,
        @w_duplicados         int,
        @w_renovaciones       int,
        @w_incremento         money,
        @w_estado             catalogo,
        @w_pignorado          char(1),
        @w_retenido           char(1),
        @w_totalizado         char(1),
        @w_causa_mod          catalogo,
        @w_total_retencion    money,
        @w_fecha_ult_pg_int   datetime,
        @w_numdoc             int,
        @w_accion_sgte        varchar(4),
        @w_telefono           varchar(12),
        @w_ced_ruc            cuenta,
        @w_historia_fin       int,
        @w_siguiente          int,
        @w_bt_ente            int,
        @w_bt_rol             catalogo,
        @w_bt_fecha_crea      datetime,
        @w_bt_fecha_mod       datetime,
        @w_bt_tipo            char(1),
        @w_bt_condicion       char(1),
        @w_sec                int,
        @w_estado_xren        catalogo,
        @w_en_nombre_completo varchar(254),
        @w_mt_producto        catalogo,
        @w_mt_cuenta          cuenta,
        @w_mt_valor           money,
        @w_mt_tipo            char(1),
        @w_mt_beneficiario    int,
        @w_mt_impuesto        money,
        @w_mt_moneda          int,
        @w_mt_valor_ext       money,
        @w_mt_fecha_crea      datetime,                                 
        @w_mt_fecha_mod       datetime,                                 
        @w_pt_beneficiario    int,                              
        @w_pt_tipo            catalogo,                         
        @w_pt_forma_pago      catalogo, 
        @w_fp_por_defecto  catalogo,   --+-+                        
        @w_pt_cuenta          cuenta,
        @w_pt_monto           money,
        @w_pt_porcentaje      int,
        @w_pt_fecha_crea      datetime,
        @w_pt_fecha_mod       datetime,
        @w_pt_moneda_pago     smallint,  -- GES 04/09/01 CUZ-002-098
        @w_dt_ente            int,
         @w_moneda_pg          varchar(2),
        @w_imprime            char(1),
        @w_plazo_ant          int,
        @w_fecven_ant         datetime,
        @w_fecha_ord_act      datetime,
        @w_tot_int_est_ant    money,
        @w_ciudad             int,
        @w_bonos              char(1),
        @w_cupones            char(1),
        @w_num_cupones        int,
        @w_int_descontados    char(1),
        @w_porc_comision      int,  --ojo
        @w_preimpreso         int,
        @w_sub_secuencia_cupon int,
        @w_prorroga_aut                 char(1), --06-Abr-2000 Prorroga Aut.
        @w_num_dias_gracia              int,     --06-Abr-2000 Prorroga Aut.
        @w_estatus_prorroga             char(1), --06-Abr-2000 Prorroga Aut.
        @w_num_prorroga                 int,     --06-Abr-2000 Prorroga Aut.
        @w_flag_tasaefec                char(1), --04-May-2000 Efectiva/Nominal
        @w_retiene_imp_capital          char(1), --04-May-2000 Efectiva/Nominal
        @w_impuesto_capital             money, --04-May-2000 Efectiva/Nominal
        @w_tot_int_retenido             money, --ral fusfra 06-06-00
   @w_anio_comercial         char(1), --04-Abr-2000 Fecha Comercial 
        @w_tasa_variable                char(1), --12-Abr-2000 Tasa Variable.
        @w_mnemonico_tasa               catalogo,--12-Abr-2000 Tasa Variable.
        @w_modalidad_tasa               char(1), --12-Abr-2000 Tasa Variable.
        @w_periodo_tasa                 smallint,--12-Abr-2000 Tasa Variable.
        @w_descr_tasa                   descripcion,--12-Abr-2000 Tasa Varia.
        @w_operador                     char(1), --12-Abr-2000 Tasa Variable.
        @w_spread                       float,   --12-Abr-2000 Tasa Variable.
        @w_ah_cta_banco                 cuenta, --14-Jul-2000 No. cta. aho
        @w_cc_cta_banco                 cuenta, --14-Jul-2000 No. cta. cte  
        @w_fpago_ctaaho                 catalogo, --14-Jul-2000 xca
        @w_fpago_ctacte                 catalogo,  --14-Jul-2000 xca  
        @w_cupon                        char(1), -- GES 09/20/01 CUZ-024-081
        @w_categoria_cupon              catalogo, -- GES 09/20/01 CUZ-024-081
        @w_scontable                    catalogo,  -- GES 04/09/2002 CUZ-070-008

        @w_pt_descripcion               varchar,   
        @w_pt_oficina                   int,       
        @w_pt_tipo_cliente              char,      
        @w_pt_benef_chq                 varchar,   
        @w_pt_tipo_cuenta_ach           char,      
        @w_pt_banco_ach                 descripcion,
        @w_bt_secuencia                 smallint,
   @w_dias_reales       char(1),       --LIM 20/OCT/2005
   @w_incremento_susp      money,            --LIM 22/OCT/2005
   @w_inactivo             char(1),       --LIM 22/OCT/2005
   @w_localizado           char(1),       --LIM 24/OCT/2005
   @w_fecha_localizacion      smalldatetime,       --LIM 24/OCT/2005
   @w_fecha_no_localiza       smalldatetime,       --LIM 24/OCT/2005
   @w_dias_hold         int,           --LIM 24/OCT/2005
   @w_aprobado       char(1),       --LIM 24/OCT/2005
   @w_plazo_orig        float,            --LIM 24/OCT/2005   
   @w_sucursal       smallint,         --LIM 24/OCT/2005
   @w_prod_bancario1    catalogo,         --LIM 24/OCT/2005
   @w_prod_bancario2          catalogo,         --LIM 24/OCT/2005
   @w_proposito_cuenta        catalogo,         --LIM 24/OCT/2005
   @w_origen_fondos     catalogo,         --LIM 24/OCT/2005
   @w_oficial_sec       login,            --LIM 24/OCT/2005
   @w_oficial_prin         login,            --LIM 24/OCT/2005
   @w_captador       login,            --LIM 24/OCT/2005 
   @w_ente_corresp                 int,            --LIM 24/OCT/2005 
   @w_ult_cuota         tinyint,       --LIM 25/OCT/2005
   @w_valor_cuota       money,            --LIM 25/OCT/2005
   @w_ajuste         money,            --LIM 25/OCT/2005
        @w_tot_int_estimado      money,            --LIM 26/OCT/2005
   @w_oficina_apertura     smallint,               --LIM 12/NOV/2005
        @w_oficial_apertura      login,            --LIM 12/NOV/2005
        @w_dias_restantes_per    int,     --+-+
        @w_monto_new       money,      --+-+
        @w_dias_restantes_ven    int,     --+-+
        @w_num_dias_new       smallint,   --+-+    
        @w_dias_1_cuota       smallint,   --+-+
        @w_int_ganado_new     money,      --+-+
        @w_dias_dev        smallint,   --+-+
   @w_toperacion_apertura     catalogo             --LIM 12/NOV/2005


select   @w_num_cupones = NULL,
   @w_sp_name      ='sp_ins_fus_fra', 
   @w_siguiente    = 0, 
   @w_estado_xren  ='N', 
   @w_sec          = 0, 
   @w_return       = 0,
   @w_ajuste       = 0     --LIM 25/OCT/2005

if   (@i_operacion  <> 'I')
begin
   exec cobis..sp_cerror
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_num       = 141004
   return 1
end

if   (@t_trn <> 14953)
begin
   exec cobis..sp_cerror
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_num       = 141018
   return 1
end  


/* LECTURA DEL OFICIAL QUE REALIZA EL LOGON */
if @i_batch = 'N'
begin
   select @w_num_oficial = fu_funcionario
         from cobis..cl_funcionario
      where fu_login = @s_user
end
else
   select @w_num_oficial  = 99


select @w_fp_por_defecto = isnull(pa_char,'VXP')
from cobis..cl_parametro
where pa_producto = 'PFI'
and pa_nemonico = 'NVXP'



/* LECTURA DE PF_OPERACION_TMP */
select   @w_num_banco      = ot_num_banco, 
   @w_tot_int_retenido  = ot_tot_int_retenido, --RAL fusfra 06-06-00
   @w_operacionpf       = ot_operacion, 
   @w_toperacion     = ot_toperacion, 
   @w_categoria      = ot_categoria, 
   @w_oficina     = ot_oficina,
   @w_moneda      = ot_moneda, 
   @w_num_dias       = ot_num_dias, 
   @w_monto       = ot_monto,
   @w_tasa     = ot_tasa,
   @w_int_estimado   = ot_int_estimado,
   @w_total_int_estimado   = ot_total_int_estimado,
   @w_ppago       = ot_ppago,
   @w_dia_pago       = ot_dia_pago,
   @w_oficial     = ot_oficial,
   @w_descripcion       = ot_descripcion,
   @w_fecha_valor       = ot_fecha_valor,
   @w_fecha_ven      = ot_fecha_ven,
   @w_fecha_pg_int   = ot_fecha_pg_int, 
   @w_fecha_ing      = ot_fecha_ingreso, 
   @w_retienimp      = ot_retienimp,
   @w_tipo_plazo     = ot_tipo_plazo, 
   @w_tipo_monto     = ot_tipo_monto, 
   @w_tasa_efectiva  = ot_tasa_efectiva,
   @w_tcapitalizacion   = ot_tcapitalizacion, 
   @w_fpago       = ot_fpago, 
   @w_base_calculo   = ot_base_calculo,
         @w_casilla     = ot_casilla, 
   @w_direccion      = ot_direccion, 
   @w_tasa_imp       = ot_impuesto,
        @w_prorroga_aut    = ot_prorroga_aut, --06-Abr-2000 Prorroga Aut.
        @w_num_dias_gracia    = ot_num_dias_gracia,--06-Abr-2000 Prorroga Aut.
        @w_estatus_prorroga   = ot_estatus_prorroga,--06-Abr-2000 Prorroga Aut.
        @w_num_prorroga    = ot_num_prorroga,--06-Abr-2000 Prorroga Aut.
        @w_flag_tasaefec   = ot_flag_tasaefec, --04-May-2000 Efectiva/Nominal
        @w_impuesto_capital   = ot_impuesto_capital, --04-May-2000 Efectiva/Nominal
        @w_retiene_imp_capital   = ot_retiene_imp_capital, --04-May-2000 Efectiva/Nominal
   @w_total_int_ganados    = ot_tot_int_ganados,
   @w_int_ganado     = ot_int_ganado, 
   @w_int_pagados       = ot_int_pagados,
   @w_total_int_pagados    = ot_tot_int_pagados, 
   @w_int_provision  = ot_tot_int_provision,
   @w_puntos      = ot_puntos, 
   @w_fecha_ult_pg_int  = ot_fecha_ult_pg_int,
   @w_imprime     = ot_imprime, 
   @w_plazo_ant      = ot_plazo_ant, 
   @w_fecven_ant     = ot_fecven_ant,
   @w_fecha_ord_act  = ot_fecha_ord_act,
   @w_tot_int_est_ant   = ot_tot_int_est_ant, 
   @w_preimpreso     = ot_preimpreso,
   @w_ult_fecha_calculo    = ot_ult_fecha_calculo,
   @w_anio_comercial    = ot_anio_comercial,  --04-Abr-2000 Fech Com.
        @w_tasa_variable   = ot_tasa_variable, --12-Abr-2000 Tasa Var.
        @w_mnemonico_tasa  = ot_mnemonico_tasa,--12-Abr-2000 Tasa Var.
        @w_modalidad_tasa  = ot_modalidad_tasa,--12-Abr-2000 Tasa Var.
        @w_periodo_tasa    = ot_periodo_tasa,  --12-Abr-2000 Tasa Var.
        @w_descr_tasa      = ot_descr_tasa,    --12-Abr-2000 Tasa Var.
        @w_operador        = ot_operador,      --12-Abr-2000 Tasa Var.
        @w_spread          = ot_spread,        --12-Abr-2000 Tasa Var.
        @w_cupon           = ot_cupon, -- GES 09/29/01 CUZ-024-079
   @w_categoria_cupon   = ot_categoria_cupon,  -- GES 09/29/01 CUZ-024-079
   @w_dias_reales       = ot_dias_reales,          --LIM 21/OCT/2005
   @w_incremento_susp   = ot_incremento_suspenso,     --LIM 22/OCT/2005
   @w_inactivo          = ot_inactivo,             --LIM 22/OCT/2005
   @w_localizado        = ot_localizado,           --LIM 24/OCT/2005
      @w_fecha_localizacion   = ot_fecha_localizacion,      --LIM 24/OCT/2005
   @w_fecha_no_localiza    = ot_fecha_no_localiza,       --LIM 24/OCT/2005
   @w_dias_hold      = ot_dias_hold,               --LIM 24/OCT/2005
   @w_aprobado    = ot_aprobado,                --LIM 24/OCT/2005
   @w_plazo_orig     = ot_plazo_orig,           --LIM 24/OCT/2005   
   @w_sucursal    = ot_sucursal,             --LIM 24/OCT/2005
   @w_prod_bancario1 = ot_producto_bancario1,      --LIM 24/OCT/2005
   @w_prod_bancario2       = ot_producto_bancario2,      --LIM 24/OCT/2005
   @w_proposito_cuenta     = ot_proposito_cuenta,        --LIM 24/OCT/2005
   @w_origen_fondos     = ot_origen_fondos,     --LIM 24/OCT/2005
   @w_oficial_sec       = ot_oficial_secundario,   --LIM 24/OCT/2005
   @w_oficial_prin         = ot_oficial_principal,    --LIM 24/OCT/2005
   @w_captador       = ot_captador,       --LIM 24/OCT/2005    
   @w_ente_corresp         = ot_ente_corresp    --LIM 24/OCT/2005
from pf_operacion_tmp
where ot_usuario   =@s_user 
   and  ot_sesion    =@s_sesn 
   and  ot_num_banco =@i_num_banco

if @@error <> 0 or @@rowcount = 0
begin
   exec cobis..sp_cerror @t_debug = @t_debug,
                              @t_file  = @t_file,
                              @t_from  = @w_sp_name,
                              @i_num   = 141004
        return  1
end

/* SELECCION DEL CODIGO DEL CLIENTE DE PF_BENEFICIARIO_TMP */ 
select @w_ente = bt_ente
from  pf_beneficiario_tmp
where bt_usuario = @s_user 
   and bt_sesion = @s_sesn 
   and bt_operacion = @w_operacionpf 
   and bt_rol = 'T'
   and bt_tipo = 'T'
if @@error <> 0 or @@rowcount = 0
begin
        exec cobis..sp_cerror @t_debug = @t_debug,
                              @t_file  = @t_file,
                              @t_from  = @w_sp_name,
                              @i_num   = 141005
        return  1
end

/* Verificar Decimales y Cuantos */
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

/* ----------------------------------------------------------------------- */
/*  CARGAR A VARIABLES LOS VALORES CORRESPONDIENTES A PF_OPERACION         */
select   @w_monto_pg_int   = @w_monto,
   @w_monto_pgdo     = 0,
   @w_monto_new      = 0,  --+-+
   @w_monto_blq      = 0,
   @w_historia       = 1,
   @w_duplicados     = 99,
   @w_renovaciones   = 0,
   @w_incremento     = 0,
   @w_estado         = 'ING',
   @w_pignorado      = 'N',
   @w_retenido       = 'N',
   @w_totalizado     = 'N',
   @w_causa_mod      = 'NULL',
   @w_total_retencion      = 0,
   @w_numdoc         = 0,
   @w_moneda_pg      = convert(char(2),@w_moneda) 

select @w_historia_fin  = @w_historia + 1 
if @i_renovaut = 'S' 
   select @w_historia_fin  = @w_historia_fin + 1 
    
if @i_cancelaut = 'S' 
   select @w_historia_fin  = @w_historia_fin + 1 

/* VARIABLES MON_SGTE Y ACCION_SGTE */
select @w_accion_sgte  =  'NULL' 

select @w_tasa_mer  = @w_tasa 

/* INICIO TRANSACCION  PROCESO DE INSERCION DEFINITIVA */

begin tran  --*****************************************************************************************

/* LECTURA DEL TELEFONO */
select @w_telefono = te_valor
from cobis..cl_telefono
where te_ente       = @w_ente 
   and te_direccion  = 1 
   and te_secuencial = 1 
                
if @@rowcount = 0
   select @w_telefono  =  NULL  
   
/* LECTURA DE LA CEDULA */
select @w_ced_ruc = en_ced_ruc,
@w_descripcion = en_nomlar --+-+
from cobis..cl_ente
where en_ente = @w_ente 

select @w_monto         =  round(@w_monto,@w_numdeci) 
select @w_tot_int_retenido =  round(@w_tot_int_retenido,@w_numdeci) --ral fusfra 06-06-00
select @w_monto_pg_int  =  round(@w_monto_pg_int,@w_numdeci) 
select @w_monto_pgdo    =  round(@w_monto_pgdo,@w_numdeci) 
select @w_monto_blq     =  round(@w_monto_blq,@w_numdeci) 
select @w_int_ganado    =  round(@w_int_ganado,@w_numdeci) 
select @w_int_estimado  =  round(@w_int_estimado,@w_numdeci) 
select @w_int_pagados   =  round(@w_int_pagados,@w_numdeci) 
select @w_int_provision      = round (@w_int_provision,@w_numdeci) 
select @w_total_int_ganados  = round(@w_total_int_ganados,@w_numdeci) 
select @w_total_int_pagados  = round(@w_total_int_pagados,@w_numdeci) 
select @w_incremento    =  round(@w_incremento,@w_numdeci) 
select @w_total_int_estimado =  round(@w_total_int_estimado,@w_numdeci) 

-- Obtiene el nuevo plazo
if @w_dias_reales = 'S'
   select @w_num_dias_new = datediff(dd,@i_fecha_inicio,@w_fecha_ven)
else
begin
   exec sp_funcion_1 @i_operacion   = 'DIFE30',
            @i_fechai   = @i_fecha_inicio,
            @i_fechaf   = @w_fecha_ven,
            @i_dia_pago = @w_dia_pago,
            @o_dias     = @w_num_dias_new out   
end

insert into pf_operacion 
   (op_num_banco, --1
   op_operacion, 
   op_ente, 
   op_toperacion, 
   op_categoria, 
   op_producto, 
   op_oficina, 
   op_moneda, 
   op_num_dias, 
   op_monto, --10
   op_monto_pg_int, 
   op_monto_pgdo, 
   op_monto_blq, 
   op_tasa, 
   op_int_ganado, 
   op_int_estimado, 
   op_int_pagados, 
   op_int_provision, 
   op_total_int_ganados, 
   op_total_int_pagados,  --20
   op_incremento, 
   op_total_int_estimado, 
   op_ppago, 
   op_dia_pago, 
   op_historia, 
   op_duplicados, 
   op_renovaciones, 
   op_estado, 
   op_pignorado, 
   op_oficial,  --30
   op_descripcion, 
   op_fecha_valor, 
   op_fecha_ven, 
   op_fecha_pg_int, 
   op_fecha_ult_pg_int, 
   op_fecha_crea, 
   op_fecha_mod, 
   op_fecha_ingreso, 
   op_totalizado, 
   op_fecha_total,  --40
   op_tipo_plazo, 
   op_tipo_monto, 
   op_causa_mod, 
   op_retenido, 
   op_total_retencion, 
   op_retienimp, 
   op_tasa_efectiva, 
   op_accion_sgte, 
   op_mon_sgte, 
   op_tcapitalizacion, --50
   op_fpago, 
   op_base_calculo, 
   op_casilla, 
   op_direccion, 
   op_residuo, 
   op_total_int_retenido, 
   op_renova_todo, 
   op_imprime, 
   op_puntos, 
   op_total_int_acumulado, --60
   op_tasa_mer, 
   op_telefono, 
   op_ced_ruc, 
   op_moneda_pg, 
   op_impuesto,
   op_preimpreso, 
   op_plazo_ant, 
   op_fecven_ant,
   op_fecha_ord_act,
   op_tot_int_est_ant, --70
   op_ult_fecha_calculo,
   op_num_dias_gracia,  --06-Abr-2000 Prorroga aut
   op_prorroga_aut,  --06-Abr-2000 Prorroga aut
   op_flag_tasaefec, --06-Abr-2000 Prorroga aut
   op_impuesto_capital, --06-Abr-2000 Prorroga aut
   op_retiene_imp_capital, --06-Abr-2000 Prorroga aut
   op_estatus_prorroga, --06-Abr-2000 Prorroga aut
   op_num_prorroga,  --06-Abr-2000 Prorroga aut
   op_anio_comercial,   --04-Abr-2000 Fecha Comercial
   op_tasa_variable,       --12-Abr-2000 Tasa Variable
   op_mnemonico_tasa,      --12-Abr-2000 Tasa Variable
   op_modalidad_tasa,      --12-Abr-2000 Tasa Variable
   op_periodo_tasa,        --12-Abr-2000 Tasa Variable
   op_descr_tasa,          --12-Abr-2000 Tasa Variable
   op_operador,            --12-Abr-2000 Tasa Variable
   op_spread,              --12-Abr-2000 Tasa Variable
   op_fecha_real,          --12-Abr-2000 Tasa Variable
   op_cupon,               -- GES 09/20/01 CUZ-024-080
   op_categoria_cupon,     -- GES 09/20/01 CUZ-024-080
   op_dias_reales,          --LIM 20/OCT/2005
   op_incremento_suspenso, --LIM 22/OCT/2005
   op_inactivo,         --LIM 22/OCT/2005
   op_localizado,       --LIM 24/OCT/2005
   op_fecha_localizacion,  --LIM 24/OCT/2005
   op_fecha_no_localiza,   --LIM 24/OCT/2005
   op_dias_hold,        --LIM 24/OCT/2005
   op_aprobado,         --LIM 24/OCT/2005
   op_plazo_orig,       --LIM 24/OCT/2005
   op_sucursal,         --LIM 24/OCT/2005
   op_producto_bancario1,  --LIM 24/OCT/2005
   op_producto_bancario2,  --LIM 24/OCT/2005
   op_proposito_cuenta, --LIM 24/OCT/2005
   op_origen_fondos,    --LIM 24/OCT/2005
   op_oficial_secundario,  --LIM 24/OCT/2005
   op_oficial_principal,   --LIM 24/OCT/2005
   op_captador,      --LIM 24/OCT/2005
   op_ente_corresp,  --LIM 24/OCT/2005
   op_oficina_apertura, --LIM 12/NOV/2005
   op_oficial_apertura, --LIM 12/NOV/2005
   op_toperacion_apertura, --LIM 12/NOV/2005
   op_tipo_plazo_apertura, --LIM 15/NOV/2005
   op_tipo_monto_apertura  --LIM 15/NOV/2005
   )
values (
   @w_num_banco, 
   @w_operacionpf, 
   @w_ente, 
   @w_toperacion, 
   @w_categoria, 
   14, 
   @w_oficina, 
   @w_moneda, 
   --NYMBMIA @w_num_dias_new,     
   @w_num_dias, 
   @w_monto,  --10
   @w_monto_pg_int, 
   @w_monto_pgdo, 
   @w_monto_blq, 
   @w_tasa, 
   @w_int_ganado, 
   @w_int_estimado, 
   @w_int_pagados,          --+-+@w_int_pagados,  se coloca 0 porque se inicializa valores de la operacion
   @w_int_provision, 
   @w_total_int_ganados, 
   @w_total_int_pagados,          --+-+@w_total_int_pagados,  --20 Se coloca 0 por la misma razon de op_int_pag..
   @w_incremento, 
   @w_total_int_estimado, 
   @w_ppago, 
   --0, --op_dia_pago
   @w_dia_pago, --op_dia_pago 
   @w_historia_fin, 
   @w_duplicados, 
   @w_renovaciones, 
   'ACT', 
   @w_pignorado, 
   @w_oficial,  --30
   @w_descripcion, 
   --@i_fecha_inicio,     
   @w_fecha_valor, 
   @w_fecha_ven, 
   @w_fecha_pg_int, 
   @w_fecha_ult_pg_int, 
   @s_date, 
   @s_date, 
   @s_date,       --+-+@w_fecha_ing, 
   @w_totalizado, 
   @w_fecha_pg_int,  --40
   @w_tipo_plazo, 
   @w_tipo_monto, 
   @w_causa_mod, 
   @w_retenido, 
   @w_total_retencion, 
   @w_retienimp, 
   @w_tasa_efectiva, 
   @w_accion_sgte, 
   @i_mon_sgte, 
   @w_tcapitalizacion, --50
   @w_fpago, 
   @w_base_calculo, 
   @w_casilla, 
   @w_direccion, 
   0, 
   @w_tot_int_retenido,    --ral fusfra 06-06-00
   @i_renova_todo, 
   @w_imprime, 
   @w_puntos, 
   0,  --60
   @w_tasa_mer, 
   @w_telefono, 
   @w_ced_ruc, 
   @w_moneda_pg, 
   @w_tasa_imp,
   @w_preimpreso,  
   @w_plazo_ant,
   @w_fecven_ant,
   @w_fecha_ord_act,
   @w_tot_int_est_ant,
   @w_ult_fecha_calculo,
   @w_num_dias_gracia,  --06-Abr-2000 Prorroga aut
   @w_prorroga_aut,  --06-Abr-2000 Prorroga aut
   @w_flag_tasaefec, --06-Abr-2000 Prorroga aut
   @w_impuesto_capital,    --06-Abr-2000 Prorroga aut
   @w_retiene_imp_capital, --06-Abr-2000 Prorroga aut
   @w_estatus_prorroga, --06-Abr-2000 Prorroga aut
   @w_num_prorroga,  --06-Abr-2000 Prorroga aut
   @w_anio_comercial,   --04-Abr-2000 Fecha Comercial
   @w_tasa_variable,       --12-Abr-2000 Tasa Variable
   @w_mnemonico_tasa,      --12-Abr-2000 Tasa Variable
   @w_modalidad_tasa,      --12-Abr-2000 Tasa Variable
   @w_periodo_tasa,        --12-Abr-2000 Tasa Variable
   @w_descr_tasa,          --12-Abr-2000 Tasa Variable
   @w_operador,            --12-Abr-2000 Tasa Variable
   @w_spread,              --12-Abr-2000 Tasa Variable
   getdate(),              --12-Abr-2000 Tasa Variable
   @w_cupon,               -- GES 09/20/01 CUZ-024-080
   @w_categoria_cupon,      -- GES 09/20/01 CUZ-024-080
   @w_dias_reales,            --LIM 20/OCT/2005
   @w_incremento_susp,        --LIM 22/OCT/2005
   @w_inactivo,            --LIM 22/OCT/2005
   @w_localizado,             --LIM 24/OCT/2005
   @w_fecha_localizacion,     --LIM 24/OCT/2005
   @w_fecha_no_localiza,      --LIM 24/OCT/2005
   @w_dias_hold,           --LIM 24/OCT/2005
   @w_aprobado,            --LIM 24/OCT/2005
   @w_plazo_orig,          --LIM 24/OCT/2005   
   @w_sucursal,            --LIM 24/OCT/2005
   @w_prod_bancario1,         --LIM 24/OCT/2005
   @w_prod_bancario2,         --LIM 24/OCT/2005
   @w_proposito_cuenta,       --LIM 24/OCT/2005
   @w_origen_fondos,       --LIM 24/OCT/2005
   @w_oficial_sec,            --LIM 24/OCT/2005
   @w_oficial_prin,        --LIM 24/OCT/2005
   @w_captador,            --LIM 24/OCT/2005
   @w_ente_corresp,        --LIM 24/OCT/2005
   @w_oficina,          --LIM 12/NOV/2005
   @w_oficial_prin,        --LIM 12/NOV/2005
   @w_toperacion,                --LIM 12/NOV/2005
   @w_tipo_plazo,             --LIM 15/NOV/2005
   @w_tipo_monto           --LIM 15/NOV/2005
   ) 
if @@error <> 0 or @@rowcount = 0
begin
        exec cobis..sp_cerror @t_debug = @t_debug,
                              @t_file  = @t_file,
                              @t_from  = @w_sp_name,
                              @i_num   = 143001
        return  1
end


insert into pf_operacion_his(                --LIM 15/DIC/2005
   oh_num_banco            ,oh_operacion     , oh_retienimp    , oh_tasa,
   oh_base_calculo      ,oh_categoria     , oh_num_dias     , oh_tcapitalizacion,
   oh_oficial_secundario   ,oh_fecha_valor      , oh_int_estimado , oh_total_int_estimado,
   oh_fecha_ven      ,oh_fecha_ult_pg_int    , oh_tasa_efectiva   , oh_tasa_mer, 
   oh_int_ganado     ,oh_total_int_ganados   , oh_ente_corresp    , oh_descripcion,
   oh_fecha_pg_int      ,oh_localizado          , oh_fecha_localizacion , oh_fecha_no_localiza,
   oh_puntos      ,oh_spread              , oh_operador     , oh_casilla,
   oh_direccion      ,oh_sucursal      , oh_fpago     , oh_ppago,
   oh_dia_pago    ,oh_dias_reales         , oh_instruccion_especial, oh_oficina,
   oh_oficial              ,oh_monto)
values(
   @w_num_banco      ,@w_operacionpf      , @w_retienimp    ,@w_tasa,
   @w_base_calculo      ,@w_categoria     , @w_num_dias     ,@w_tcapitalizacion,
   @w_oficial_sec    ,@w_fecha_valor      , @w_int_estimado ,@w_total_int_estimado,
   @w_fecha_ven      ,@w_fecha_ult_pg_int , @w_tasa_efectiva   ,@w_tasa_mer,
   @w_int_ganado     ,@w_total_int_ganados   , @w_ente_corresp ,@w_descripcion,
   @w_fecha_pg_int      ,@w_localizado    , @w_fecha_localizacion , null,
   @i_puntos      , @w_spread    , @w_operador     , @w_casilla,
   @w_direccion      , @w_sucursal     , @w_fpago     , @w_ppago,
   @w_dia_pago    , @w_dias_reales  , null,     @w_oficina, 
   @w_oficial     , @w_monto_pg_int)
if @@error <> 0 or @@rowcount = 0
begin
        exec cobis..sp_cerror @t_debug = @t_debug,
                              @t_file  = @t_file,
                              @t_from  = @w_sp_name,
                              @i_msg   = 'No se pudo insertar operacion_his',
                              @i_num   = 143001
        return  1
end

--Calcula interes estimado a pagar para la primera cuota de acuerdo a las nuevas condiciones (lectura de nueva tasa)
if @w_dias_reales = 'S'
   select   @w_dias_restantes_per = datediff(dd,@i_fecha_inicio,@w_fecha_pg_int),
      @w_dias_restantes_ven = datediff(dd,@i_fecha_inicio,@w_fecha_ven)
else
begin
      exec sp_funcion_1 @i_operacion   = 'DIFE30',
               @i_fechai   = @i_fecha_inicio,
               @i_fechaf   = @w_fecha_pg_int,
               @i_dia_pago = @w_dia_pago,
               @o_dias     = @w_dias_restantes_per out
               
      exec sp_funcion_1 @i_operacion   = 'DIFE30',
               @i_fechai   = @i_fecha_inicio,
               @i_fechaf   = @w_fecha_ven,
               @i_dia_pago = @w_dia_pago,
               @o_dias     = @w_dias_restantes_ven out               
end

select @w_int_estimado = (@w_monto * @w_dias_restantes_per * @w_tasa)/(@w_base_calculo * 100)
select @w_int_estimado = round(@w_int_estimado,@w_numdeci)
--select @w_total_int_estimado = (@w_monto * @w_dias_restantes_ven * @w_tasa)/(@w_base_calculo * 100)         GAL 24/AGO/2009 - RVVUNICA
select @w_total_int_estimado = round(@w_total_int_estimado,@w_numdeci)

/* INICIO GAL 24/AGO/2009 - RVVUNICA */

exec sp_estima_int
   @s_ofi             = @w_oficina,
   @s_date            = @s_date,
   @i_fecha_inicio    = @w_fecha_valor,
   @i_fecha_final     = @w_fecha_ven,
   @i_monto           = @w_monto,
   @i_tasa            = @w_tasa,
   @i_tcapitalizacion = @w_tcapitalizacion,
   @i_fpago           = @w_fpago,
   @i_ppago           = @w_ppago,
   @i_dias_anio       = @w_base_calculo,
   @i_dia_pago        = @w_dia_pago,
   @i_moneda          = @w_moneda,                
   @i_retienimp       = 'N',
   @i_dias_reales     = @w_dias_reales,
   @o_int_pg_ve       = @w_total_int_estimado out  

/* FIN GAL 24/AGO/2009 - RVVUNICA */


--Calcula dias devengados de interes
if @w_dias_reales = 'S'
   select   @w_dias_dev = datediff(dd,@i_fecha_inicio,@s_date)
else
begin
   exec sp_funcion_1 @i_operacion   = 'DIFE30',
            @i_fechai   = @i_fecha_inicio,
            @i_fechaf   = @s_date,
            @i_dia_pago = @w_dia_pago,
            @o_dias     = @w_dias_dev out          
end

select @w_int_ganado_new = round((@w_monto * @w_dias_dev * @w_tasa)/(@w_base_calculo * 100),@w_numdeci)

-- Llena pf_prov_dia
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
   @i_ejecuta_contable = 'N', --+-+
   @i_fecha_proceso = @i_fecha_inicio,  
   @i_num_banco     = @w_num_banco,
   @i_dias_interes  = @w_dias_dev
if @w_return <> 0
begin
   rollback tran
   exec cobis..sp_cerror
      @t_debug         = @t_debug,
      @t_file          = @t_file,
      @t_from          = @w_sp_name,
      @i_msg       = 'Error al calcular provision de operacion...',
      @i_num           = 149015
   return 149015     
end 

--Actualiza interes estimado de la operacion
set rowcount 0
update pf_operacion
set   op_int_estimado   = @w_int_estimado,
   op_total_int_estimado   = @w_total_int_estimado,
   --op_total_int_ganados    = @w_int_ganado_new,
   op_int_ganado     = @w_int_ganado_new
where op_operacion = @w_operacionpf
if @@error <> 0
begin
   exec cobis..sp_cerror
      @t_debug         = @t_debug,
      @t_file          = @t_file,
      @t_from          = @w_sp_name,
      @i_num           = 145001
   return 145001           
end

select @o_int_ganado = @w_int_ganado_new  --+-+

if @w_cupon = 'S'
begin 
   --Crea las cuotas desde la fecha de ultimo pago de interes, solo para colocar fechas
   exec @w_return = cob_pfijo..sp_cuotas
      @s_ssn            = @s_ssn,
      @s_srv            = @s_srv,
      @s_lsrv           = @s_lsrv,
      @s_user           = @s_user,
      @s_sesn           = @s_sesn,
      @s_term           = @s_term,
      @s_date           = @s_date,
      @s_ofi            = @s_ofi,
      @s_rol            = @s_rol,
      @t_trn            = 14146,
      @i_op_ente     = @w_ente,
      @i_op_operacion      = @w_operacionpf,
      @i_op_fecha_valor = @w_fecha_ult_pg_int,
      @i_op_fecha_ven      = @w_fecha_ven,
      @i_op_monto    = @w_monto,
      @i_op_tasa     = @w_tasa,
      @i_op_num_dias    = @w_num_dias,
      @i_op_ppago    = @w_ppago,
      @i_op_retienimp      = @w_retienimp,
      @i_op_moneda      = @w_moneda,
      @i_op_oficina     = @w_oficina,
      @i_op_fpago    = @w_fpago,
      @i_op_base_calculo   = @w_base_calculo,
      @i_op_tcapitalizacion   = @w_tcapitalizacion,
      @i_op_anio_comercial    = @w_anio_comercial,
      @i_op_dias_reales       = @w_dias_reales
   if @w_return <> 0
   begin
      exec cobis..sp_cerror
         @t_debug         = @t_debug,
         @t_file          = @t_file,
         @t_from          = @w_sp_name,
         @i_num           = 143049
      return 1
   end 

   --Encuentra dias de primera cuota
   if @w_dias_reales = 'S'
      select @w_dias_1_cuota = datediff(dd,@i_fecha_inicio,@w_fecha_pg_int)
   else
   begin
      exec sp_funcion_1 @i_operacion   = 'DIFE30',
               @i_fechai   = @i_fecha_inicio,
               @i_fechaf   = @w_fecha_pg_int,
               @i_dia_pago = @w_dia_pago,
               @o_dias     = @w_dias_1_cuota out   
   end      
   
   --Actualiza primera cuota
   
   update pf_cuotas
   set   cu_valor_cuota    = @w_int_estimado,
      cu_valor_neto     = @w_int_estimado,
      cu_fecha_mod   = @i_fecha_inicio,
      cu_num_dias = @w_dias_1_cuota

   where cu_operacion = @w_operacionpf
      and cu_cuota = 1
   if @@error <> 0
   begin
      exec cobis..sp_cerror
         @t_debug         = @t_debug,
         @t_file          = @t_file,
         @t_from          = @w_sp_name,
         @i_num           = 145053
      return 145053
   end                     

   if @w_tcapitalizacion = 'S'
      select @w_monto_new = @w_monto + @w_int_estimado
   else
      select @w_monto_new = @w_monto 
   
   --Actualiza las cuotas de la segunda en adelante
   exec @w_return = sp_actualiza_cuota
      @s_ssn                  = @s_ssn,
      @s_user                 = @s_user,
      @s_sesn                 = @s_sesn,
      @s_ofi                  = @s_ofi,
      @s_date                 = @s_date,
      @t_trn                  = 14146,
      @s_srv                  = @s_srv,
      @s_term                 = @s_term,
      @t_file                 = @t_file,
      @t_from                 = @w_sp_name,
      @t_debug                = @t_debug,
      @i_monto    = @w_monto_new,   --para el caso de que el monto deba sumarse al
                     --interes debido a que el DPF capitaliza intereses
      @i_fecha_proceso        = @w_fecha_pg_int,
      @i_op_operacion         = @w_operacionpf
   if @w_return <> 0
   begin
      exec cobis..sp_cerror
         @t_debug         = @t_debug,
         @t_file          = @t_file,
         @t_from          = @w_sp_name,
         @i_msg       = 'Error al actualizar cuotas fusfra',
         @i_num           = 145053
      return 145053
   end      
end

insert into pf_historia (hi_operacion, 
   hi_secuencial, 
   hi_fecha, 
   hi_trn_code, 
   hi_valor, 
   hi_funcionario, 
   hi_oficina, 
   hi_fecha_crea, 
   hi_fecha_mod,
   hi_observacion)
values (@w_operacionpf, 
   @w_historia,
   @s_date,
   @t_trn,
   @w_monto,
   @s_user,
   @w_oficina,
   @s_date,
   @s_date,
   @i_observacion) 
if @@error <> 0 or @@rowcount = 0
begin
   exec cobis..sp_cerror @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 143006
   return  1
end

select @w_historia  = @w_historia + 1 
    
/* GENERAR NUEVO SECUENCIAL PARA DETALLE DEL PRODUCTO */
exec cobis..sp_cseqnos @t_debug     = @t_debug,
    @t_file      = @t_file,
    @t_from      = @w_sp_name,
    @i_tabla     = 'cl_det_producto',
    @o_siguiente = @w_siguiente out
           
insert into cobis..cl_det_producto (dp_det_producto, 
   dp_filial,  dp_oficina,    dp_producto,   dp_tipo,    dp_moneda,  dp_fecha, 
   dp_comentario,    dp_monto,   dp_tiempo,  dp_cuenta,  dp_estado_ser,    dp_autorizante, 
   dp_oficial_cta)
values (@w_siguiente, 
   1,    @s_ofi,  14,   'R',  @w_moneda,  @s_date,    NULL,    @w_monto, 
   @w_num_dias,   @w_num_banco,  'V',  @w_num_oficial,   @w_num_oficial) 
if @@error <> 0 or @@rowcount = 0
begin
        exec cobis..sp_cerror @t_debug = @t_debug,
                              @t_file  = @t_file,
                              @t_from  = @w_sp_name,
                              @i_num   = 703027
        return  1
end

/* LECTURA DE PF_BENEFICIARIO_TMP */
select @w_bt_ente  =  0 
while (1=1)
begin
   set rowcount 1 
   select   @w_bt_ente  =  bt_ente,
      @w_bt_rol   =  bt_rol,
      @w_bt_fecha_crea= bt_fecha_crea,
      @w_bt_fecha_mod   =  bt_fecha_mod,
      @w_bt_tipo      =       bt_tipo,
      @w_bt_condicion =       bt_condicion,
      @w_bt_secuencia =       bt_secuencia
   from pf_beneficiario_tmp
   where  bt_usuario   = @s_user 
      and bt_sesion    = @s_sesn 
      and bt_ente      > @w_bt_ente 
      and bt_operacion = @w_operacionpf 
   order by bt_ente  
            
   if @@rowcount = 0
      break
            
   /* INSERCION DEFINITIVA EN LA TABLA PF_BENEFICIARIO */
   exec @w_return  = sp_beneficiario
      @s_ssn         = @s_ssn,
      @s_user     = @s_user,
      @s_term     = @s_term,
      @s_date     = @s_date,
      @s_srv      = @s_srv,
      @s_lsrv     = @s_lsrv,
      @s_ofi      = @s_ofi,
      @s_rol      = @s_rol,
      @t_debug = @t_debug,
      @t_file     = @t_file,
      @t_from     = @t_from,
      @t_trn      = 14109,
      @i_operacion   = 'I',
      @i_cuenta   = @w_num_banco,
      @i_ente     = @w_bt_ente,
      @i_rol      = @w_bt_rol,
      @i_estado_xren = @w_estado_xren,
      @i_tipo     = @w_bt_tipo,
      @i_condicion   = @w_bt_condicion,
      @i_secuencia   = @w_bt_secuencia
   if @w_return <> 0  
   begin
           exec cobis..sp_cerror @t_debug = @t_debug,
                              @t_file  = @t_file,
                              @t_from  = @w_sp_name,
                              @i_num   = 149999,
            @i_msg = 'Error en sp_beneficiario'
                return  1 
        end
            
   /* BUSQUEDA DE LA CEDULA DE CADA BENEFICIARIO */
   select   @w_en_nombre_completo = p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre,
      @w_ced_ruc = en_ced_ruc
   from  cobis..cl_ente
   where en_ente = @w_bt_ente 
   
   if @w_bt_tipo = 'T' begin
      insert into cobis..cl_cliente  (cl_cliente, cl_det_producto, cl_rol, 
               cl_ced_ruc, cl_fecha)
            values (@w_bt_ente, @w_siguiente, @w_bt_rol, 
               @w_ced_ruc, @s_date)             
      if @w_return <> 0  begin
         exec cobis..sp_cerror @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 703028
         return  1 
      end
   end

   --CVA Feb-21-06 Actualizar en cl_ente relacion de Cliente
        update cobis..cl_ente
           set en_cliente = 'S'  
        where en_ente   = @w_bt_ente
   if @@error <> 0
   begin
      exec cobis..sp_cerror @t_debug = @t_debug,
                     @t_file  = @t_file,
                       @t_from  = @w_sp_name,
                            @i_num   = 703028
      return  703028
   end

end   /* Fin del WHILE 1 = 1 */

/* INSERCION DETALLE DE PAGO INTERESES */
select @w_sec = isnull(max(dp_secuencia), 0) + 1
from pf_det_pago
where dp_operacion = @w_operacionpf 
        
if (@i_renovaut = 'S' and @i_renova_todo = 'N' AND @w_fpago <> 'ANT')  
   select @w_estado_xren  =  'S' 
   
select @w_pt_beneficiario  = 0 
while (5=5)
begin
   set rowcount 1
   select @w_pt_beneficiario    = dt_beneficiario,
      @w_pt_tipo            = dt_tipo,
      @w_pt_forma_pago      = dt_forma_pago,
      @w_pt_cuenta          = dt_cuenta,
      @w_pt_monto       = op_int_estimado,   --+-+-dt_monto + ((@w_total_int_ganados * dt_porcentaje)/100),    --25/OCT/2005
      @w_pt_porcentaje      = dt_porcentaje,
      @w_pt_fecha_crea      = dt_fecha_crea,
      @w_pt_fecha_mod       = dt_fecha_mod,
      @w_pt_moneda_pago     = dt_moneda_pago,
      @w_pt_descripcion     = dt_descripcion,   
      @w_pt_oficina         = dt_oficina,
      @w_pt_tipo_cliente    = dt_tipo_cliente,      
      @w_pt_benef_chq       = dt_benef_chq,   
      @w_pt_tipo_cuenta_ach = dt_tipo_cuenta_ach,      
      @w_pt_banco_ach       = dt_banco_ach
   from  pf_det_pago_tmp, pf_operacion
   where dt_usuario = @s_user 
      and dt_sesion = @s_sesn 
      and dt_beneficiario > @w_pt_beneficiario
      and dt_operacion = @w_operacionpf 
      and op_operacion = @w_operacionpf 
      and dt_operacion = op_operacion
   order by dt_beneficiario 

   if @@rowcount = 0
   begin
      break
   end

   set rowcount 0
   select @w_pt_monto  = round(@w_pt_monto,@w_numdeci) 


   insert into pf_det_pago (dp_operacion, 
      dp_ente,       dp_tipo,       dp_secuencia,     dp_forma_pago, 
      dp_cuenta,     dp_monto,      dp_porcentaje,       dp_fecha_crea, 
      dp_fecha_mod,     dp_estado_xren,   dp_estado,     dp_moneda_pago,
      dp_descripcion,      dp_oficina,    dp_tipo_cliente,  dp_benef_chq,
      dp_tipo_cuenta_ach,  dp_banco_ach)
   values (@w_operacionpf, 
      @w_pt_beneficiario,  @w_pt_tipo,       @w_sec,        @w_fp_por_defecto, --+-+-+-
      @w_pt_cuenta,     @w_pt_monto,      @w_pt_porcentaje,    @s_date, 
      @s_date,       @w_estado_xren,   'I',        @w_pt_moneda_pago,
      @w_pt_descripcion,   @w_pt_oficina,    @w_pt_tipo_cliente,  @w_pt_benef_chq,
      @w_pt_tipo_cuenta_ach,  @w_pt_banco_ach)
   if @@rowcount <> 1  or @@error <> 0
   begin
      exec cobis..sp_cerror @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 143038
      return  1 
   end

   insert pf_instruccion(in_operacion  , in_instruccion         , in_estadoxren, in_fecha_crea, in_fecha_mod)
   values(@w_operacionpf,' ', 'N'          , @s_date      , @s_date)



   insert into ts_det_pago (secuencial, 
      tipo_transaccion,    clase,      fecha,      usuario,       terminal, 
      srv,        lsrv,       operacion,  ente,          tipo,       forma_pago, 
      cuenta,     monto,      porcentaje,    fecha_crea,       fecha_mod,
      moneda_pago) 
   values (@s_ssn,                  @t_trn,        'N',        @s_date,                @s_user, 
      @s_term,                @s_srv,        @s_lsrv,                @w_operacionpf, 
      @w_pt_beneficiario,     @w_pt_tipo,    @w_fp_por_defecto,   @w_pt_cuenta, 
      @w_pt_monto,      @w_pt_porcentaje,    @s_date,                @s_date,               @w_pt_moneda_pago)
   if @@rowcount <> 1  or @@error <> 0
   begin
      exec cobis..sp_cerror @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 143005
      return  1 
   end






   set rowcount 0
   select @w_sec  = @w_sec + 1 
end   /* Fin del WHILE 5 = 5 */

/* FIN TRANSACCION */
if @w_return = 1  
   rollback tran
else
begin
   commit  tran 
   select @w_return  = 0 
end


return @w_return 

go


