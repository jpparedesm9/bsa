/*****************************************************************/
/* Archivo:            renovaut.sp                               */
/* Stored procedure:   sp_renova_aut                             */
/* Base de datos:      cob_pfijo                                 */
/* Producto:           PLAZO FIJO                                */
/* Disenado por:       Ximena Cartagena                          */
/* Fecha de escritura: 02-Dic-1997                               */
/*****************************************************************/
/*                          IMPORTANTE                           */
/* Este programa es parte de los paquetes bancarios propiedad de */
/* 'MACOSA', representantes exclusivos para el Ecuador de la     */
/* 'NCR CORPORATION'.                                            */
/* Su uso no autorizado queda expresamente prohibido asi como    */
/* cualquier alteracion o agregado hecho por alguno de sus       */
/* usuarios sin el debido consentimiento por escrito de la       */
/* Presidencia Ejecutiva de MACOSA o su representante.           */
/*****************************************************************/
/*                          PROPOSITO                            */
/* Este programa tiene como objetivo realizar la prorroga auto-  */
/* matica de aquellas operaciones en las cuales la fecha de ven -*/
/* cimiento sea igual a la fecha en la cual se ejecuta el batch  */
/* de fin de dia, ademas la operacion debera estar en estado ACT */
/*****************************************************************/
/*                        MODIFICACIONES                         */
/* FECHA       AUTOR          RAZON                              */
/*****************************************************************/
/* 20-mar-2007 Ricardo Ramos   Operaciones overnight, hererar    */
/*                             el spread autorizado al momento   */
/*                             de la prorroga                    */
/* 25-Abr-2007 Humberto Ayarza Cambia @s_date x @w_fecha_hoy     */
/*                             en pf_historia.                   */
/* 11-May-2007 Clotilde Vargas Cambios para tener funcional      */
/*                             el manejo de dias de gracia       */
/* 12-Ene-2017 Jorge Salazar   DPF-H94952 MANEJO RETENCIONES MX  */
/*****************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_renova_aut')
   drop proc sp_renova_aut
go
create proc sp_renova_aut (
   @s_ssn            int         = NULL,
   @s_user           login       = NULL,
   @s_term           varchar(30) = NULL,
   @s_date           datetime    = NULL,
   @s_srv            varchar(30) = NULL,
   @s_lsrv           varchar(30) = NULL,
   @s_rol            smallint    = NULL,
   @s_ofi            smallint    = NULL,
   @s_org_err        char(1)     = NULL,
   @s_error          int         = NULL,
   @s_sev            tinyint     = NULL,
   @s_msg            descripcion = NULL,
   @s_org            char(1)     = NULL,
   @t_debug          char(1)     = 'N',
   @t_file           varchar(14) = NULL,
   @t_from           varchar(32) = NULL,
   @t_trn            int         = NULL,
   @i_renovaut       char(1)     = NULL,
   @i_fecha_proceso  datetime    = NULL,
   @i_inicio         int         = 0,
   @i_fin            int         = 99999999
)
with encryption
as
declare
   @w_fecha_hoy                  datetime,
   @w_fecha_proceso              datetime,
   @w_sp_name                    varchar(32),
   @w_dias                       int,
   @w_num_meses                  int,
   @w_return                     int,
   @w_error                      int,
   @w_secuencial                 int,
   @w_num_banco                  cuenta,
   @w_emision_inicial            int,
   @w_stock                      int,
   @w_puntos                     float,
   @w_preimpreso                 int,
   @w_operacion                  int,
   @w_ente                       int,
   @w_toperacion                 catalogo,
   @w_nem_toperacion             catalogo,
   @w_categoria                  catalogo,
   @w_estado                     catalogo,
   @w_estado_ant                 catalogo,
   @w_rol                        catalogo,
   @w_tipo_deposito              tinyint, -- xca
   @w_duplicados                 tinyint,
   @w_producto                   tinyint,
   @w_oficina                    smallint,
   @w_moneda                     tinyint,
   @w_num_dias                   smallint,
   @w_num_dias_labor             smallint,
   @w_num_dias_old               int,
   @w_base_calculo               smallint,
   @w_total_int_acumulado        money,
   @w_monto                      money,
   @w_monto_cierre               money,
   @w_monto_ren                  money,
   @w_monto_ren_pg_int           money,   --11/Nov/98
   @w_monto_pg_int               money,
   @w_monto_pgdo                 money,
   @w_monto_blq                  money,
   @w_residuo                    float,
   @w_tasa_mer                   float,
   @w_tasa                       float,
   @w_tasa1                      float,
   @w_tasa_efectiva              float,
   @w_periodo                    float,
   @w_tot_int_est_ant            money,
   @w_int_ganado                 money,
   @w_int_estimado               money,
   @w_int_estim_new              money,
   @w_int_pagados                money,
   @w_int_provision              money,
   @w_total_int_ganados          money,
   @w_total_int_pagados          money,
   @w_total_int_estimado         money,
   @w_total_int_estim            money,     -- 11/Nov/98 capitalizacion
   @w_num_pagos                  smallint,  -- 11/Nov/98 capitalizacion
   @w_tot_int_estim_new          money,
   @w_total_int_retenido         money,
   @w_total_retencion            money,
   @w_fpago                      catalogo,
   @w_ppago                      catalogo,
   @w_casilla                    tinyint,
   @w_direccion                  tinyint,
   @w_telefono                   varchar(8),
   @w_oficina_renova             varchar(6),
   @w_historia                   smallint,
   @w_renovaciones               smallint,
   @w_incremento                 money,
   @w_mon_sgte                   smallint,
   @w_usa_limite                 char(1),
   @w_pignorado                  char(1),
   @w_mantiene_stock             char(1),
   @w_imprime                    char(1),
   @w_renova_todo                char(1),
   @w_retenido                   char(1),
   @w_retienimp                  char(1),
   @w_totalizado                 char(1),
   @w_tcapitalizacion            char(1),
   @w_moneda_pg                  char(2),
   @w_oficial                    login,
   @w_accion_sgte                catalogo,
   @w_tipo_plazo                 catalogo,
   @w_plazo_escalonado           char(1),

   @w_tplazo_old                 catalogo,
   @w_tipo_monto                 catalogo,
   @w_causa_mod                  catalogo,
   @w_descripcion                varchar(255),
   @w_fecha_ord_act              datetime,
   @w_fecven_ant                 datetime,
   @w_fecha_crea                 datetime,
   @w_fecha_total                datetime,
   @w_ult_fecha_calculo          datetime,
   @w_fecha_cancela              datetime,
   @w_fecha_valor                datetime,
   @w_fecha_ven_old              datetime, -- var. para fecha_back_value
   @w_fecha_valor_old            datetime, -- var. para fecha_back_value
   @w_dias_back                  int,      -- No. de dias back_value
   @w_fecha_ven                  datetime,
   @w_fecha_ingreso              datetime,
   @w_fecha_pg_int               datetime,
   @w_fecha_pg_int_new           datetime, -- xca
   @w_fecha_ult_pg_int           datetime,
   @w_fecha_mod                  datetime,
   @w_ced_ruc                    varchar(35),
   @w_plazo_ant                  smallint,
   @w_impuesto                   float,
   @w_imp_base                   money,
   @w_int_neto                   money,
   @w_numdeci                    tinyint,
   @w_usadeci                    char(1),
   @w_fecha2                     datetime,
   @w_tasa_new_vigente           float,
   @w_tasa_efectiva_conver       float,
   @w_limite_max                 float,
   @w_limite_min                 float,
   @w_monto_max                  money,
   @w_usa_lim                    char(1),
   @w_num_banco_new              cuenta,
   @w_op_int_ganado              money,        -- var. para update de pf_operacion
   @w_op_int_pagados             money,        -- var. para update de pf_operacion
   @w_op_total_int_pagados       money,        -- var. para update de pf_operacion
   @w_op_tot_int_est_ant         money,        -- var. para update de pf_operacion
   @w_op_descripcion             varchar(255), -- Nombre del cliente
   @w_contador_commit            int,
   @w_prorroga_aut               char(1),
   /* VARIABLES PARA PF_RENOVACION */
   @w_re_monto                   money,
   @w_re_monto_ren               money,
   @w_re_tot_int                 money,
   @w_re_moneda                  char(2),
   @w_re_impuesto_ren            money,       -- Impuesto a insertar en pf_prorroga_aut
   @w_impuesto_ren               money,       -- Impuesto generado a retener (8%)
   @w_porcent_impren             money,       -- % impto. retener para mas de 1 reg en pf_det_pago 12-Ago-2000 xca
/* VARIABLES PARA PF_MOV_MONET */
   @w_secuencia                  int,         -- secuencia para pf_mov_monet
   @w_sub_secuencia              int,         -- sub_secuencia para pf_mov_monet
   @w_mm_sub_secuencia           int,         -- sub_secuencia para pf_mov_monet
   @w_mm_subsec                  int,         -- sub_secuencia para pf_mov_monet
   @w_mm_producto                catalogo,
   @w_mm_moneda                  smallint,
   @w_mm_cuenta                  cuenta,
   @w_mm_valor                   money,
   @w_mm_valor_ext               money,
   @w_mm_impuesto                money,
   @w_mm_secuencia_up            int,         -- secuen. actualizar pf_mov_monet
   @w_secuencia_ren              int,         -- secuencia para pf_mov_monet
   @w_secuencia_aper             int,         -- secuencia para pf_mov_monet
   @w_int_ren_neto               money,       -- int. neto a insertar en pf_mov_monet
   @w_int_ren                    money,       -- interes bruto
   @w_monto_renovar              money,       -- capital + int. neto para pf_mov_monet
   @w_tasa_variable              char(1),     -- 12-Abr-2000 Tasa Variable
   @w_mnemonico_tasa_var         catalogo,    -- 12-Abr-2000 Tasa Variable
   @w_modalidad_tasa             char(1),     -- 12-Abr-2000 Tasa Variable
   @w_periodo_tasa               smallint,    -- 12-Abr-2000 Tasa Variable
   @w_descr_tasa                 descripcion, -- 12-Abr-2000 Tasa Variable
   @w_operador                   char(1),     -- 12-Abr-2000 Tasa Variable
   @w_spread                     float,       -- 12-Abr-2000 Tasa Variable
   @w_valor_tasa_var             float,       -- 12-Abr-2000 Tasa Variable
   @w_int_xpagar                 money,       -- 10-mar-99 pago int. VEN CAP
   @w_flag_tasaefec              char(1),     -- 04-May-2000 Efectiva/Nominal
/* VARIABLES PARA PF_DET_PAGO  */
   @w_dp_secuencia_max           int,
   @w_dp_secuencia_min           int,
   @w_dp_secuencia_up            int,         -- max. secu. para operaciones PER
   @w_dp_cuenta                  cuenta,
   @w_dp_fpago                   catalogo,
   @w_dp_monto                   money,
   @w_sum_dp_monto               money,       -- valor total de pf_det_pago 12-Ago-2000
   @w_dp_monto_new               money,       -- valor nuevo interes a pagar
   @w_dp_monto_reg               money,       -- valor del reg. leido en pf_det_pago
   @w_dp_count                   int,
   @w_dp_sum_secuencia           int,
   @w_dp_count_lazo              int,
   @w_dp_porcent                 float,         -- porcent respecto total de dp_monto
   @w_dp_secuencia               int,
/* VARIABLES PARA PF_EMISION_CHEQUE  */
   @w_ec_secuen                  int,         -- secuencia para pf_emision_cheque
   @w_ec_subsec                  int,         -- subsecuencia para pf_emision_cheque
/* VARIABLES PARA PF_FPAGO  */
   @w_fp_transito                tinyint,
/* VARIABLES PARA CTE/AHO  */
   @w_ah_cta_banco               cuenta,      -- var. con No. cta. aho. cliente
   @w_cc_cta_banco               cuenta,      -- var. con No. cta. cte. cliente
   @w_codprod_aho                char(2),
   @w_codprod_aho_def            char(1),
   @w_cod_aso_ter                char(1),
/* VARIABLES PARA FP_TIPO_DEPOSITO */
   @w_op_num_dias_gracia         tinyint,     -- No. de dias espera prorroga
   @w_td_dias_gracia             char(1),     -- El producto tiene dias de gracia S/N
   @w_diferen_prorroga           int,
   @w_fecha_dias_gracia          datetime,
/* VARIABLES PARA PF_BENEFICIARIO */
   @w_pt_forma_pago              catalogo,
   @w_pt_beneficiario            int,
   @w_pt_cuenta                  cuenta,
   @w_pt_monto                   money,
   @w_pt_porcentaje              float,
   @w_monto_mov                  money,
   @w_dp_money                   money,
   @w_contor                     tinyint,
   @w_pt_secuencia               int,
   @w_r1                         float,
   @w_r2                         float,
   @w_imp                        money,
   @w_impuesto_pg                money,
   @w_total_pagar_pg             money,
/* VARIABLES PARA CONTABILIZACION */
   @w_monto1                     money,
   @w_int_renovar                money,       -- int. bruto para asiento sp_aplica_conta
   @w_sa_int_renovar             money,       -- int.  bruto para pf_sasiento
   @w_sa_total_pagar             money,       -- int.  neto para pf_sasiento
   @w_oficina_ant                smallint,
   @o_comprobante                int,
   @w_tasa_base                  float,
/* VARIABLES PARA NUMERO DE PRORROGAS - HJPG */
   @w_estatus_prorroga           char,
   @w_num_prorroga               int,
   @w_td_num_prorrogas           int,
/* VARIABLE PARA PARAMETRIZACION ENTRE FECHA COMERCIAL Y FECHA CALENDARIO */
   @w_fpago_ctaaho               catalogo,
   @w_fpago_ctacte               catalogo,
   @w_anio_comercial             char(1),    -- 06-Abr-2000 xca
   @w_alt                        int,
   @w_op_dias_reales             char(1),
   @w_op_int_total_prov_vencida  money,
   @w_num_dias_real              int,
   @w_mensaje                    descripcion,  --CVA Oct-03-05
   @w_operador_ajust             char(1),  --xca 18-Oct-2005
   @w_spread_ajust               float,    --xca 18-Oct-2005
   @w_tasavar_orig               float,          --xca 18-Oct-2005
   @w_tasa_max                   float,    --xca 18-Oct-2005
   @w_tasa_min                   float,      --xca 18-Oct-2005
   @w_plazo_min                  smallint,       --xca 18-Oct-2005
   @w_plazo_min_1                smallint,
   @w_monto_min                  money,          --xca 18-Oct-2005
   @w_pi_cuenta                  cuenta,         --xca 18-Oct-2005
   @w_pi_producto                catalogo,        --xca 18-Oct-2005
   @w_suma                       money,
   @w_dia_pago                   int,     --*-*
   @w_modifica                   char(1),
   @w_ssn                        int,
   @w_provision_dias_gracia      char(1),        --CVA May-14-07
   -- NYM DOF00015 ICA
   @w_ret_ica                    char(1),       -- GAL 18/SEP/2009 - RVVBANCAMIA
   @w_tasa_ica                   float,
   -- NYM DPF00015 ICA
   @w_tplazo_cont                catalogo,      --MVG 19/09/2009
   @w_tplazo_cont_old            catalogo ,      --MVG 19/09/2009
   @w_ente_aux                   int,
   @w_bloqueado   		         varchar(5), 
   @w_malaref     		         varchar(5),
   @w_conc0                      float,
   @w_conc1                      float,
   @w_op_operador                varchar(10),
   @w_operador_tmp               char(1),
   @w_spread_tmp                 float,
   @w_op_spread_tmp              char(1),
   @w_fecha_p                    datetime,
   @w_valor_retenido             money

      
set ansi_warnings off

-------------------------------------------------
-- 06-Abr-2000 xca cambio calculo del secuencial
-------------------------------------------------
select @w_sp_name    = 'sp_renova_aut',

       @w_secuencial = @s_ssn


select @w_fecha_hoy             = convert(datetime,convert(varchar,isnull(@i_fecha_proceso,@s_date),101))
select @i_renovaut              = isnull(@i_renovaut, 'S')
select @t_trn                   = isnull(@t_trn, 14947)
select @w_contador_commit       = 0
select @w_alt                   = 0
select @w_provision_dias_gracia = 'N'



if @t_debug = 'S' print 'renovaut antes de crsor a fecha '+ cast(@w_fecha_hoy  as varchar)

---------------------------------------------------
-- Declaracion de cursor para acceso a operaciones
---------------------------------------------------
declare cursor_operacion cursor for
select
   op_num_banco,          op_operacion,                      op_ente,                   op_toperacion,
   op_categoria,          op_estado,                         op_producto,               op_oficina,
   op_moneda,             isnull(op_plazo_orig,op_num_dias), op_base_calculo,           op_monto,
   op_monto_pg_int,       op_monto_pgdo,                     op_monto_blq,              op_tasa,
   op_tasa_efectiva,      op_int_ganado,                     op_int_estimado,           op_residuo,
   op_int_pagados,        op_int_provision,                  op_total_int_ganados,      op_total_int_pagados,
   op_total_int_estimado, op_total_int_retenido,             op_total_retencion,        op_fpago,
   op_ppago,              op_casilla,                        op_direccion,              op_telefono,
   op_historia,           op_duplicados,                     op_renovaciones,           op_incremento,
   op_mon_sgte,           op_pignorado,                      op_renova_todo,            op_imprime,           -- 41
   op_retenido,           op_retienimp,                      op_totalizado,             op_tcapitalizacion,
   op_oficial,            op_accion_sgte,                    op_preimpreso,             op_tipo_plazo,        -- 49
   op_tipo_monto,         op_causa_mod,                      op_descripcion,            op_fecha_valor,
   op_fecha_ven,          op_fecha_cancela,                  op_fecha_ingreso,          op_fecha_pg_int,
   op_fecha_ult_pg_int,   op_ult_fecha_calculo,              op_fecha_crea,             op_fecha_mod,         -- 61
   op_fecha_total,        op_puntos,                         op_total_int_acumulado,    op_tasa_mer,
   op_ced_ruc,            op_plazo_ant,                      op_fecven_ant,             op_tot_int_est_ant,   -- 69
   op_fecha_ord_act,      op_mantiene_stock,                 op_stock,                  op_emision_inicial,   -- 73
   op_moneda_pg,          op_impuesto,                       op_prorroga_aut,           op_tasa_variable,     -- 77 Tasa Variable
   op_mnemonico_tasa,     op_modalidad_tasa,                 op_periodo_tasa,           op_descr_tasa,        -- 81 Tasa Variable
   op_operador,           op_spread,                         op_estatus_prorroga,       op_num_prorroga,      -- 85 numero de prorrogas 21-Dic-98
   op_anio_comercial,     op_flag_tasaefec,                  op_int_total_prov_vencida, op_num_dias_gracia,
   isnull(op_dias_reales,'N'),   op_dia_pago
from pf_operacion
where op_fecha_ven                 <= @w_fecha_hoy    /* fecha ven. menor si tiene dias gracia */
and   op_estado                    in ('ACT','VEN')
and   isnull(op_accion_sgte,'NULL') is null
and   op_prorroga_aut               = 'S' --se grabara desde front end
and   isnull(op_pago_interes,'S')   = 'S' --CVA Oct-28-06 Para identificar si ya se le pago el interes
and   op_operacion                 >= @i_inicio
and   op_operacion                 <= @i_fin
for update

open cursor_operacion

fetch cursor_operacion into
   @w_num_banco,               @w_operacion,                      @w_ente,                      @w_toperacion,
   @w_categoria,               @w_estado,                         @w_producto,                  @w_oficina,
   @w_moneda,                  @w_num_dias,                       @w_base_calculo,              @w_monto,
   @w_monto_pg_int,            @w_monto_pgdo,                     @w_monto_blq,                 @w_tasa,
   @w_tasa_efectiva,           @w_int_ganado,                     @w_int_estimado,              @w_residuo,
   @w_int_pagados,             @w_int_provision,                  @w_total_int_ganados,         @w_total_int_pagados,
   @w_total_int_estimado,      @w_total_int_retenido,             @w_total_retencion,           @w_fpago,
   @w_ppago,                   @w_casilla,                        @w_direccion,                 @w_telefono,
   @w_historia,                @w_duplicados,                     @w_renovaciones,              @w_incremento,
   @w_mon_sgte,                @w_pignorado,                      @w_renova_todo,               @w_imprime,
   @w_retenido,                @w_retienimp,                      @w_totalizado,                @w_tcapitalizacion,
   @w_oficial,                 @w_accion_sgte,                    @w_preimpreso,                @w_tipo_plazo,
   @w_tipo_monto,              @w_causa_mod,                      @w_op_descripcion,            @w_fecha_valor,
   @w_fecha_ven,               @w_fecha_cancela,                  @w_fecha_ingreso,             @w_fecha_pg_int,
   @w_fecha_ult_pg_int,        @w_ult_fecha_calculo,              @w_fecha_crea,                @w_fecha_mod,
   @w_fecha_total,             @w_puntos,                         @w_total_int_acumulado,       @w_tasa_mer,
   @w_ced_ruc,                 @w_plazo_ant,                      @w_fecven_ant,                @w_tot_int_est_ant,
   @w_fecha_ord_act,           @w_mantiene_stock,                 @w_stock,                     @w_emision_inicial,
   @w_moneda_pg,               @w_impuesto,                       @w_prorroga_aut,              @w_tasa_variable,
   @w_mnemonico_tasa_var,      @w_modalidad_tasa,                 @w_periodo_tasa,              @w_descr_tasa,
   @w_operador,                @w_spread,                         @w_estatus_prorroga,          @w_num_prorroga,
   @w_anio_comercial,          @w_flag_tasaefec,                  @w_op_int_total_prov_vencida, @w_op_num_dias_gracia,
   @w_op_dias_reales,          @w_dia_pago
   
while @@fetch_status = 0
begin
   
   select @w_operador_tmp  = @w_operador
   select @w_spread_tmp    = @w_spread
   
if @w_op_dias_reales = 'N' 
   select @w_anio_comercial = 'S'
else   
   select @w_anio_comercial = 'N'

   
   select @w_alt = @w_alt + 1

   select @w_fecha_hoy     = convert(datetime,convert(varchar,isnull(@i_fecha_proceso,@s_date),101))

   select @w_fecha_proceso = convert(datetime,convert(varchar,isnull(@i_fecha_proceso,@s_date),101))

   select @w_mensaje = NULL

   select
      @s_ofi      = @w_oficina,
      @w_modifica = 'N'

if @t_debug = 'S'  print 'VA A PROROGAR:  '+ cast(@w_num_banco as varchar) + cast(@@FETCH_STATUS  as varchar)

   begin tran


      -- proceso de validacion bloqueos y referencia inhibitorias
      
      
	if exists (      
		select 	1
      		from 	pf_beneficiario,
			cobis..cl_ente,
			cobis..cl_refinh
      		where 	be_ente = en_ente
		and	be_operacion 	= @w_operacion
      		and	be_estado 	= 'I' 
      		and	be_estado_xren 	<> 'S'
      		and	be_tipo 	<> 'F'
		and	en_mala_referencia = 'S'
		and	in_tipo_ced = en_tipo_ced
		and	in_ced_ruc = en_ced_ruc
		)
	begin
		select 	@w_mensaje = 'Error Ente ' +  cast(@w_ente as varchar) +' En listas Inhibitorias. No se Prorroga'
            		select @w_error =  141255
            		goto ERROR
      	end

      ----------------------------------------------------------------
      -- Proceso para validar prorroga de operaciones libor tipo xxxA
      ----------------------------------------------------------------
      if ((datalength(@w_toperacion) > 3) and (substring(@w_toperacion,4,1) = 'A'))
      begin
         select @w_nem_toperacion = substring(@w_toperacion,1,3)

         exec @w_return = cob_pfijo..sp_rangos_libor
            @t_trn        = 14996,
            @i_batch      = 'S',
            @i_operacion  = @w_operacion,
            @o_monto_min  = @w_monto_min out,
            @o_plazo_min  = @w_plazo_min out
         if @w_return <> 0
         begin
            select @w_mensaje = 'Error en busqueda de rangos libor'
            select @w_error =  @w_return
            goto ERROR
         end
         else   -- Devuelve valores
         begin
            -----------------------------------------------------
            -- Monto y plazo deben estar en rango de xxxD o xxxF
            -----------------------------------------------------
            if datalength(@w_toperacion) > 3
            begin
               if substring(@w_toperacion,4,1) = 'A'
               begin
                  select @w_plazo_min = 1095, @w_plazo_min_1 = 1825
                  if (@w_monto < @w_monto_min) or ((@w_num_dias < @w_plazo_min or @w_num_dias < @w_plazo_min_1))
                  begin
                     -- No cumple con los minimos establecidos, no debe prorrogar
                     goto SIGUIENTE
                  end

                  if @w_num_dias >= @w_plazo_min_1 and  @w_num_dias < @w_plazo_min
                     select  @w_toperacion = @w_nem_toperacion + 'F'
                  else
                     select  @w_toperacion = @w_nem_toperacion + 'D'
               end
            end
         end
      end

      -------------------------------------------------------------
      -- Proceso para validar si el producto tiene dias de gracia
      -- con el fin de prorrogar o no la operacion.
      -------------------------------------------------------------
      select @w_td_dias_gracia     = td_dias_gracia,     /* (S/N) */
             @w_td_num_prorrogas   = td_num_prorrogas,    /* No. maximo de prorr*/
             @w_tipo_deposito      = td_tipo_deposito
      from pf_tipo_deposito
      where td_mnemonico = @w_toperacion
      and   td_estado    = 'A'
      if @@rowcount = 0
      begin
         select @w_mensaje = 'Error Tipo Deposito Deshabilitado'
         select @w_error =  141115
         goto ERROR
      end

      if @w_op_num_dias_gracia is null
         select @w_op_num_dias_gracia = 0

      if @w_anio_comercial = 'N'
      begin
         select @w_diferen_prorroga = datediff(dd,@w_fecha_ven,@w_fecha_hoy)
      end
      else
      begin
         exec sp_funcion_1 @i_operacion = 'DIFE30',
            @i_fechai   = @w_fecha_hoy,
            @i_fechaf   = @w_fecha_ven,
            @i_dia_pago = @w_dia_pago, --*-*
            @o_dias     = @w_diferen_prorroga out
      end

      --select @w_fecha_dias_gracia = dateadd(dd,@w_op_num_dias_gracia,@w_fecha_ven)

      exec sp_primer_dia_labor
           @t_file         = @t_file,
           @t_from         = @w_sp_name,
           @s_ofi    = @s_ofi,
           @i_fecha        = @w_fecha_ven,
           @i_operacion    = 'C',
           @i_ttransito    = @w_op_num_dias_gracia,
           @i_tipo_deposito = @w_tipo_deposito,
           @o_fecha_labor  = @w_fecha_dias_gracia out


      -------------------------------------------------------------------------
      -- Validacion de si el titulo se puede prorrogar de acuerdo al numero
      -- de prorrogas permitido para el producto.
      -- Si no ha llegado al max de prorrogas o si tiene prorrogas ilimitadas
      -------------------------------------------------------------------------

      if (@w_num_prorroga < @w_td_num_prorrogas) or (@w_td_num_prorrogas=9999)
      begin
         if    ((@w_diferen_prorroga  >= 0) and (@w_td_dias_gracia = 'N'))
            or ((@w_fecha_dias_gracia = @w_fecha_hoy) and (@w_td_dias_gracia = 'S'))
         begin
            --------------------------------------------------------------------------------
            -- Asignacion de Valores a variables que deben conservar los valores originales
            --------------------------------------------------------------------------------
            select
            @w_tplazo_old      = @w_tipo_plazo,
            @w_estado_ant      = @w_estado,
            @w_fecha_ven_old   = @w_fecha_ven,
            @w_fecha_valor_old = @w_fecha_valor,
            @w_num_dias_old    = @w_num_dias    --MVG 19/09/2009

            --CVA Para Dpfs con d¡as de gracia, la fecha de inicio del dpf es la fecha de vencimiento del mismo
            --*-*if (@w_fecha_dias_gracia = @w_fecha_hoy) and (@w_td_dias_gracia = 'S')
            --*-*begin
            select @w_fecha_hoy          = @w_fecha_ven_old
            select @w_op_num_dias_gracia = 0 --una vez cumplido el tiempo de gracia que se encere
            select @w_provision_dias_gracia = 'S'  --para que genere provision de dias que estuvo vencido
            --*-*end

            ------------------------------------------------------------------
            -- Proceso para calcular nuevo plazo y nueva fecha de vencimiento
            ------------------------------------------------------------------

if @t_debug = 'S' print  'FV w_fecha_hoy ' + cast(@w_fecha_hoy as varchar)
if @t_debug = 'S' print  'w_dia_pago ' + cast(@w_dia_pago as varchar)
if @t_debug = 'S' print  'w_num_dias ' + cast(@w_num_dias as varchar)
if @t_debug = 'S' print  'w_toperacion ' + cast(@w_toperacion as varchar)
if @t_debug = 'S' print  'w_op_dias_reales ' + cast(@w_op_dias_reales as varchar)
if @t_debug = 'S' print  'w_num_dias ' + cast(@w_num_dias as varchar)

            exec @w_return = sp_valida_fecha
               @s_ssn               = @w_secuencial,
               @s_user              = @s_user,
               @s_term              = @s_term,
               @s_date              = @s_date,
               @s_srv               = @s_srv,
               @s_lsrv              = @s_lsrv,
               @s_ofi               = @s_ofi,
               @s_rol               = @s_rol,
               @t_debug             = @t_debug,
               @t_file              = @t_file,
               @t_from              = @w_sp_name,
               @t_trn               = 14446,
               @i_fecha             = @w_fecha_hoy,
               @i_flag_renovaut     = 'S',
               @i_batch             = 0,     --*-*
               @i_dia_pago          = @w_dia_pago, --*-*
               @i_plazo             = @w_num_dias,
               @i_toperacion        = @w_toperacion,
               @i_dias_reales       = @w_op_dias_reales,
               @i_nem_tipo_deposito = @w_toperacion,
               @o_num_dias_labor    = @w_num_dias_labor out
            if @w_return <> 0
            begin
               select @w_mensaje = 'Error recibido por sp_valida_fecha'
               select @w_error =  @w_return
               goto ERROR
            end

if @t_debug = 'S' print  'FV w_num_dias_labor ' + cast(@w_num_dias_labor as varchar)

            if @w_num_dias_labor > 0 /* fecha de vencimiento dia no laborable */
            begin
               select @w_num_dias = @w_num_dias + @w_num_dias_labor

if @t_debug = 'S' print  'FV w_num_dias ' + cast(@w_num_dias as varchar)

               ----------------------------------------------------------------
               -- Proceso para tomar fecha de vencimiento comercial/calendario
               ----------------------------------------------------------------
               if @w_anio_comercial = 'N'
               begin
                  select @w_fecha_ven = dateadd(dd,@w_num_dias,@w_fecha_hoy)
               end
               else
               begin
                  exec sp_funcion_1
                     @i_operacion = 'SUMDIA',
                     @i_fechai    = @w_fecha_hoy,
                     @i_dias      = @w_num_dias,
                     @i_dia_pago  = @w_dia_pago,
                     @i_batch     = 0,
                     @o_fecha     = @w_fecha_ven out
               end

            end  -- num_dias_labor > 0
            else -- Fecha de vencimiento dia laborable
            begin
               ----------------------------------------------------------------
               -- Proceso para tomar fecha de vencimiento comercial/calendario
               ----------------------------------------------------------------
               if @w_anio_comercial = 'N'
               begin
                  select @w_fecha_ven = dateadd(dd,@w_num_dias,@w_fecha_hoy)
               end
               else
               begin
                  exec sp_funcion_1
                     @i_operacion = 'SUMDIA',
                     @i_fechai    = @w_fecha_hoy,
                     @i_dias      = @w_num_dias,
                     @i_dia_pago  = @w_dia_pago,
                     @i_batch     = 0,
                     @o_fecha     = @w_fecha_ven out
               end

            end  -- Fecha de vencimiento dia laborable

            --------------------------------------------------
            -- Obtener Fecha vencimiento para dia laborable
            --------------------------------------------------
            exec sp_primer_dia_labor
                 @t_debug       = @t_debug,
                 @t_file        = @t_file,
                 @t_from        = @w_sp_name,
                 @i_fecha       = @w_fecha_ven,
                 @s_ofi         = @s_ofi,
                 @i_tipo_deposito = @w_tipo_deposito,
                 @o_fecha_labor = @w_fecha_ven out

            -----------------------------------------------------------------------------------------
            -- Proceso para recalcular el mnemonico del plazo en caso que el nuevo numero de dias
            -- se incremente por que la fecha de vencimiento cae en dia no laborable por lo tanto
            -- el nuevo numero de dias podria caer en otro rango de plazo comercial y plazo contable
            -----------------------------------------------------------------------------------------
            select @w_tipo_deposito = td_tipo_deposito
            from pf_tipo_deposito
            where td_mnemonico = @w_toperacion
            if @@rowcount = 0
            begin
               select @w_error =  141115
               goto ERROR
            end


if @t_debug = 'S' print  'FV w_tipo_deposito ' + cast(@w_tipo_deposito as varchar)

            select @w_tipo_plazo = pl_mnemonico --nemonico plazo nuevo si cambia
            from cob_pfijo..pf_plazo, pf_auxiliar_tip
            where @w_num_dias      >= pl_plazo_min
            and   @w_num_dias      <= pl_plazo_max
            and   pl_mnemonico      = at_valor
            and   at_tipo           = 'PLA'
            and   at_tipo_deposito  = @w_tipo_deposito
            and   at_estado         = 'A'
            and   at_moneda         = @w_moneda
            if @@rowcount = 0
            begin
               select @w_mensaje = 'Tipo Deposito ' + convert(varchar(10),@w_tipo_deposito) + convert(varchar(10),@w_num_dias)
               select @w_error =  141054
               goto ERROR
            end

            select @w_usadeci = mo_decimales
            from cobis..cl_moneda
            where mo_moneda = @w_moneda

            if @w_usadeci = 'S'
            begin
               ----------------------------------------------
               -- Obtener parametro de decimales para montos
               ----------------------------------------------
               select @w_numdeci = isnull(pa_tinyint,0)
               from cobis..cl_parametro
               where pa_nemonico = 'DCI'
               and   pa_producto = 'PFI'
               if @@rowcount = 0
               begin
                  select @w_mensaje = 'Error no encuentra parametro de decimales'
                  select @w_error =  141054
                  goto ERROR
               end
            end
            else
               select @w_numdeci = 0

            select @w_imp_base = 0

         /*RRRRR   if @w_fpago = 'VEN'
            begin
               ----------------------------------------------------------------
               -- Linea de codigo agregada para verificar si se realizo pago
               -- de intereses antes de ejecutar prorroga a pesar de que el
               -- interes pase a formar parte del capital (producto capitaliza)
               -----------------------------------------------------------------
               select @w_int_xpagar = round((@w_total_int_ganados - @w_total_int_pagados),@w_numdeci)

               if @w_tcapitalizacion = 'S'
               begin
                  if @w_int_xpagar > 0 -- xca 10-mar-99
                     select @w_int_neto = round((@w_int_xpagar - @w_imp_base),@w_numdeci) -- valor del interes neto a pagar xca 10-mar-99
                  else
                  begin
                     select @w_int_neto = 0
                     select @w_imp_base = 0 -- cero cambia naturaleza producto
                  end
                  select @w_monto_ren = round((@w_monto + @w_int_neto),@w_numdeci)
                  -- valor del monto a renovar (capital + interes neto) xca
               end
               else -- No capitaliza los intereses
                  select @w_monto_ren = @w_monto -- valor del monto a renovar xca

            end  -- w_fpago = VEN
   RRRRR */


            if @w_fpago in('PER','VEN')
               select @w_monto_ren = @w_monto_pg_int --valor monto a renovar 31/oct/98

            ----------------------------
            -- Calculo de la nueva tasa
            ----------------------------
            if @w_tasa_variable = 'N'
            begin

               select @w_tasa_efectiva_conver = 0

               -------------------------------------------
               -- Controla los lðmites de la tasa vigente
               -------------------------------------------
               select @w_oficina_renova = convert(varchar(6),@w_oficina)
               exec @w_return = sp_limite
                  @s_ssn           = @w_secuencial,
                  @s_user          = @s_user,
                  @s_term          = @s_term,
                  @s_date          = @s_date,
                  @s_srv           = @s_srv,
                  @s_lsrv          = @s_lsrv,
                  @s_ofi           = @w_oficina,
                  @s_rol           = @s_rol,
                  @t_debug         = @t_debug,
                  @t_file          = @t_file,
                  @t_from          = @w_sp_name,
                  @t_trn           = 14435,
                  @i_operacion     = 'C',
                  @i_oficina       = @w_oficina_renova,
                  @i_funcionario   = @w_oficial,
                  @i_mnemonico     = @w_toperacion,
                  @i_moneda        = @w_moneda,
                  @i_monto         = @w_monto_ren,
                  @i_plazo         = @w_num_dias,
                  @i_flag_renovaut = 'S',
                  @o_tasa_vigente  = @w_tasa_new_vigente out, --xca tasa efectiva de la tabla
                  @o_limite_max    = @w_limite_max out,
                  @o_limite_min    = @w_limite_min out,
                  @o_monto_max     = @w_monto_max out--, -- solo para inventario xca
                  --@o_usa_limite    = @w_usa_limite out -- solo por 'U'
               if @w_return <> 0
               begin
                  select @w_mensaje = 'Error recibido por sp_limite N'
                  select @w_error =  @w_return
                  goto ERROR
               end

               if @w_operador='+'
                     select @w_tasa_new_vigente = @w_tasa_new_vigente + @w_puntos
               else
                     if @w_operador='-'
                        select @w_tasa_new_vigente = @w_tasa_new_vigente - @w_puntos
                     else
                        select @w_puntos = 0, @w_operador = NULL

            -----------------------------------------------------------
            -- Calculo de la tasa nominal a partir de la tasa efectiva
            -- unicamente para operaciones que trabajan con tasa fija O VARIABLE OJO||||||||
            -----------------------------------------------------------
            select @w_tasa_efectiva_conver = @w_tasa_new_vigente

            exec  @w_return=sp_tasa_nominal
           @t_trn=14950,
           @i_tasa_efectiva = @w_tasa_efectiva_conver,
           @i_op_ppago = @w_ppago,
           @i_op_fpago = @w_fpago,
           @i_td_base_calculo = @w_base_calculo,
           @i_op_num_dias = @w_num_dias,
           @o_tasa_nominal = @w_tasa_new_vigente output --valor de la tasa nominal


               select @w_tasa_base = @w_tasa_new_vigente


            end  -- si tasa_variable = 'N'
            else -- Si @w_tasa_variable = 'S'
            begin
	       select @w_op_operador = @w_operador

               ------------------------------------------------------------
               -- Proceso para tomar el valor del operador y del spread a
               -- considerar para el calculo del valor real de la tasa a
               -- negociar. 12-Abr-2000 Tasa Variable.
               ------------------------------------------------------------
               exec @w_return = cob_pfijo..sp_tasa_variable
                  @t_trn             = 14415,
                  @i_operacion       = 'Q',
                  @i_tipo            = 'E',
                  @i_monto           = @w_monto_ren,
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
                  @s_ofi          = @w_oficina,    --REQ 455
                  @i_toperacion   = @w_toperacion, --REQ 455
                  @o_valor_ref    = @w_valor_tasa_var out --valor tasa referencial
               if @w_return <> 0
               begin
                  select @w_mensaje = 'Error recibido por sp_cons_tasa_var'
                  select @w_error = @w_return
                  goto ERROR
               end

               select @w_tasa_base = @w_valor_tasa_var

               ------------------------------
               -- Tomar valor para num_meses
               ------------------------------
               select @w_num_meses = pp_factor_en_meses
               from pf_ppago
               where pp_codigo = @w_ppago

               if @w_ppago = 'NNN'
               begin
                  select @w_num_meses = 1
               end


	  --NYM INC 44213
	  if isnull(@w_spread,0) >= 0 or isnull(@w_puntos,0) >= 0 begin

	     select @w_conc0 = isnull(@w_op_operador ,'+') + convert(varchar(100),isnull(@w_puntos,0))
if @t_debug = 'S' print '@w_conc0 ' + cast (@w_conc0 as varchar)

	     select @w_conc1 = isnull(@w_operador,'+') + convert(varchar(100),isnull(@w_spread,0))
if @t_debug = 'S' print '@w_conc1 ' + cast (@w_conc1 as varchar)

	     select @w_spread = convert(float,@w_conc0 ) + convert(float,@w_conc1)

	     if @w_spread  >= 0
		    select @w_operador = '+'
	     else
		   select @w_operador = '-'

	     select @w_spread = abs(@w_spread )

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
                  @i_en_linea        = 'N',
                  @i_moneda          = @w_moneda,
                  @i_monto           = @w_monto_ren,
                  @i_inicio_periodo  = 'S',     --CVA Jun-20-06 Para que obtenga la tasa del primer rango del periodo
                  @o_tasa_EA         = @w_tasa_efectiva_conver out, /* valor tasa efect */
                  @o_tasa_nom_reexp  = @w_tasa_new_vigente out /* valor tasa nominal */

               if @w_return <> 0
               begin
                  select @w_mensaje = 'Error recibido por sp_calcula_tasa_var'
                  select @w_error = @w_return
                  goto ERROR
               end


if @t_debug = 'S' print 'w_tasa_efectiva_conver ' + cast (@w_tasa_efectiva_conver as varchar)
if @t_debug = 'S' print 'w_tasa_new_vigente ' + cast (@w_tasa_new_vigente as varchar)


            end   -- Fin @w_tasa_variable = 'S'

            --------------------------------------
            -- Nuevo calculo del interes estimado
            --------------------------------------
            if @w_fpago in ('VEN','ANT')
            begin
               select @w_tot_int_estim_new = round(((@w_monto_ren * @w_tasa_new_vigente*@w_num_dias)/(@w_base_calculo*100)),@w_numdeci)
               select @w_int_estim_new = @w_tot_int_estim_new
               select @w_dias = 0 -- para update pf_operacion periodica xca

               --------------------------------------------------------------
               -- Si el cliente retiene impuestos se debe calcular el nuevo
               -- valor de la retencion en el caso de que el nuevo total
               -- de interes estimado sea diferente al original.
               --------------------------------------------------------------
               /*                                                 GAL 18/SEP/2009 - RVVBANCAMIA
               if @w_retienimp = 'S'
               begin
                  select @w_tasa1 = pa_float
                  from cobis..cl_parametro
                  where pa_producto = 'PFI'
                  and   pa_nemonico = 'IMP'
                  select @w_impuesto_ren = round((@w_tot_int_estim_new * @w_tasa1/100),@w_numdeci) -- valor del impto. a retener sobre los intereses  nuevos xca
               end  /* Si paga impuesto  */
               else
               */
                  select @w_impuesto_ren = 0
            end

            if @w_fpago in ('PER','VEN') --CVA Jul-05-06 Para escalonados que busque el total en base a los cambios de fecha
            begin
               if @w_ppago <> 'NNN'   --para pagos periodicos
               begin
                  select @w_num_meses = pp_factor_en_meses
                  from pf_ppago
                  where pp_codigo = @w_ppago

                  select @w_dias = @w_num_meses * 30
               end

               -- Si el cliente retiene impuestos se debe calcular el nuevo
               -- valor de la retencion en el caso de que el nuevo total
               -- de interes estimado sea diferente al original.
               --if @w_op_dias_reales = 'S'                                           GAL 16/SEP/2009 - RVVUNICA
                  exec sp_estima_int
                     @i_fecha_inicio    = @w_fecha_ven_old,
                     @s_ofi             = @s_ofi,
                     @s_date            = null, --*-*BANCAMIA@s_date,
                     @i_fecha_final     = @w_fecha_ven,
                     @i_monto           = @w_monto_ren,
                     @i_tasa            = @w_tasa_new_vigente,
                     @i_tcapitalizacion = @w_tcapitalizacion,
                     @i_fpago           = @w_fpago,
                     @i_ppago           = @w_ppago,
                     @i_dias_anio       = @w_base_calculo,
                     @i_dia_pago        = @w_dia_pago,
                     @i_batch           = 'S',
                     @i_retienimp       = @w_retienimp,       --15-may-98 capitalizacion
                     @i_moneda          = @w_moneda,          --15-may-98 capitalizacion
                     -- @i_num_dias        = @w_num_dias,        --12/ene/99 fechas comerciales
                     @i_dias_reales     = @w_op_dias_reales,
                     --I. CVA Jul-04-06 Parametros para escalonado
                     @i_op_operacion    = @w_operacion,
                     @i_toperacion      = @w_toperacion,
                     @i_periodo_tasa    = @w_periodo_tasa,       -- cobis..te_pizarra..pi_periodo
                     @i_modalidad_tasa  = @w_modalidad_tasa,     -- cobis..te_pizarra..pi_modalidad, en la IPC no aplica
                     @i_descr_tasa      = @w_descr_tasa,
                     @i_mnemonico_tasa  = @w_mnemonico_tasa_var,     -- DTF, TCC, IPC, PRIME, ESC
                     @i_tipo_plazo      = @w_tipo_plazo,
                     @i_en_linea        = 'N',
                     --F. CVA Jul-04-06 Parametros para escalonado
                     @i_tasa1           = @w_tasa1,
                     @i_ret_ica         = @w_ret_ica,
                     @i_tasa_ica        = @w_tasa_ica,
                     @o_fecha_prox_pg   = @w_fecha_pg_int_new out,
                     @o_int_pg_ve       = @w_total_int_estim out,
                     @o_int_pg_pp       = @w_int_estim_new out,
                     @o_num_pagos       = @w_num_pagos out

               select @w_tot_int_estim_new =  @w_total_int_estim

if @t_debug = 'S' print 'RENOVAUT...AAAA..@w_fecha_pg_int_new:' + cast(@w_fecha_pg_int_new  as varchar)

            -- NYM DPF00015 RETENCION ICA
            exec @w_return = cob_pfijo..sp_aplica_impuestos                   -- GAL 18/SEP/2009 - INTERFAZ - IMPCOL
               @s_ofi              = @s_ofi,   
               @t_debug            = @t_debug,
               @i_ente             = @w_ente,
               @i_plazo            = @w_num_dias,
               @i_capital          = @w_monto_ren,
               @i_interes          = @w_tot_int_estim_new,
               @i_base_calculo     = @w_base_calculo,
               @o_retienimp        = @w_retienimp      out,
               @o_tasa_retencion   = @w_tasa1          out,
               @o_valor_retencion  = @w_valor_retenido out

            if @w_return <> 0
            begin
               select @w_error   = @w_return
               goto ERROR
            end

               /*                                                             GAL 18/SEP/2009 - RVVBANCAMIA
               if @w_retienimp = 'S'
               begin
                  select @w_tasa1 = pa_float from cobis..cl_parametro
                  where pa_producto = 'PFI'
                  and   pa_nemonico = 'IMP'

                  select @w_impuesto_ren = round((@w_int_estim_new * @w_tasa1/100),@w_numdeci)
               end
               else
               */
                  select @w_impuesto_ren = 0

               --------------------------------------------------------------
               -- Para las operaciones que son pagos periodicos vencidos o
               -- anticipados no interesa enviar el valor de los impuestos
               -- a retener a pf_prorroga_aut ya que los intereses se pagan
               -- con el inicio de dia y el momento de la renovacion
               -- unicamente llega el valor del capital.
               --------------------------------------------------------------
               select @w_re_impuesto_ren = 0
            end -- Fin fpago = 'PER', 'PRA'
            else -- si @w_fpago in('VEN','ANT')
               select @w_re_impuesto_ren = @w_imp_base /* val.impto oper. original */

            select @w_op_int_ganado   = 0

            --------------------------------------------------
            -- Calculo de la nueva fecha de pago de intereses
            --------------------------------------------------
            if @w_fpago = 'VEN'
            begin
               select @w_fecha_pg_int_new   = @w_fecha_ven
               select @w_re_tot_int   = @w_total_int_ganados
               select @w_op_int_ganado   = 0
               select @w_op_int_pagados  = 0
               select @w_op_total_int_pagados = 0
               select @w_op_tot_int_est_ant = @w_tot_int_estim_new
            end

            if @w_fpago = 'PER'
            begin
               select @w_re_tot_int = 0
               select @w_op_int_ganado = 0
               select @w_op_int_pagados = 0
               select @w_op_total_int_pagados = 0
               select @w_op_tot_int_est_ant = @w_tot_int_estim_new
            end

            ------------------------------------------------------------------
            -- Proceso para tomar el siguiente secuencial op_mon_sgte
            --utilizadas para la renovacion automatica.
            ------------------------------------------------------------------
            select @w_secuencia_ren  = @w_mon_sgte
            select @w_secuencia_aper = @w_mon_sgte
            select @w_sub_secuencia  = 0
            select @w_re_monto        = @w_monto
            select @w_monto1          = @w_re_monto
            select @w_re_monto_ren    = @w_monto_ren
            select @w_re_moneda       = convert(char(2),@w_moneda)

            select @w_contador_commit = @w_contador_commit +1

            select @w_op_descripcion = substring(@w_op_descripcion,1,64)

            -------------------------------------------
            -- Processo para insertar en pf_renovacion
            -------------------------------------------
            insert pf_prorroga_aut (pa_operacion,       pa_renovacion,      pa_incremento,  pa_tasa,
                                    pa_plazo,           pa_monto,           pa_int_vencido, pa_monto_renovar,
                                    pa_oficina,         pa_oficial,         pa_fecha_valor, pa_fecha_crea,
                                    pa_fecha_mod,       pa_descripcion,     pa_estado,      pa_estado_ant,
                                    pa_impuesto,        pa_tot_int,         pa_moneda_pg,   pa_oficina_ant,
                                    pa_vuelto,          pa_fecha_pg_int,    pa_int_pagados, pa_total_int_pagados,
                                    pa_fecha_ult_pg_int)
                            values (@w_operacion,       @w_num_prorroga,    0,              @w_tasa_new_vigente,
                                    @w_num_dias,        @w_re_monto,        0,              @w_re_monto_ren,
                                    @w_oficina,         @w_oficial,         @w_fecha_hoy,   @s_date,
                                    @s_date,            @w_op_descripcion,  'A',            @w_estado,
                                    @w_re_impuesto_ren, @w_re_tot_int,      @w_re_moneda,   @w_oficina,
                                    0,                  @s_date,            @w_int_pagados, @w_total_int_pagados,
                                    @w_fecha_ult_pg_int)
            if @@error <> 0
            begin
                select @w_mensaje = 'Error en insercion de pf_prorroga_aut'
                select @w_error = 143004
                goto ERROR
            end

            ----------------------------------------
            -- Proceso para insertar en pf_historia
            ----------------------------------------
            select @w_historia = @w_historia + 1
            insert pf_historia (hi_operacion, hi_secuencial,  hi_fecha,   hi_trn_code,
                                hi_valor,     hi_funcionario, hi_oficina, hi_fecha_crea,
                                hi_fecha_mod, hi_fecha_back,  hi_tasa)
                        values (@w_operacion, @w_historia,    @w_fecha_hoy,   14947,
                                @w_monto_ren, 'sa',     @w_oficina, @s_date,
                                @s_date,      @w_fecha_ven_old, @w_tasa_new_vigente)
            if @@error <> 0
            begin
                select @w_mensaje = 'Error en insercion de pf_historia 14947'
                select @w_error = 143006
                goto ERROR
            end

            ------------------------------------------------------------------------------
            -- Proceso para insercion de pf_mov_monet del primer registro que corresponde
            -- al valor del monto de la operacion original
            ------------------------------------------------------------------------------
            select @w_monto_cierre  = @w_monto --monto de la operacion original
            select @w_secuencia     = @w_secuencia_ren
            select @w_sub_secuencia = @w_sub_secuencia + 1

            insert pf_mov_monet(mm_operacion,        mm_tran,      mm_secuencia,    mm_sub_secuencia,
                                mm_producto,         mm_cuenta,    mm_valor,        mm_fecha_crea,
                                mm_fecha_mod,        mm_tipo,      mm_beneficiario, mm_secuencial,
                                mm_fecha_aplicacion, mm_estado,    mm_moneda,       mm_fecha_real,
                                mm_usuario,          mm_fecha_valor)
                         values(@w_operacion,        14947,        @w_secuencia,    @w_sub_secuencia,
                                'REN',               @w_num_banco, @w_monto_cierre, @s_date,
                                @s_date,             'I',          @w_ente,         0,
                                NULL,                NULL,         @w_moneda,       getdate(),
                                @s_user,             @s_date)
            if @@error <> 0
            begin
               select @w_mensaje = 'Error en insercion de pf_mov_monet 14947'
               select @w_error = 143022
               goto ERROR
            end

            exec @w_return        = sp_aplica_mov
                 @s_ssn           = @w_secuencial,
                 @s_user          = @s_user,
                 @s_ofi           = @s_ofi,
                 @s_date          = @s_date,
                 @s_srv           = @s_srv,
                 @s_term          = @s_term,
                 @t_file          = @t_file,
                 @t_from          = @w_sp_name,
                 @t_debug         = @t_debug,
                 @t_trn           = 14947,
                 @i_tipo          = 'N',
                 @i_en_linea      = 'N',
                 @i_operacionpf   = @w_operacion,
                 @i_secuencia     = @w_secuencia,
                 @i_sub_secuencia = @w_sub_secuencia,
                 --@i_inicio        = @i_inicio,
                 --@i_fin           = @i_fin,
                 @i_op_num_banco  = @w_num_banco
            if @w_return <> 0
            begin
               select @w_mensaje = 'Error en aplicacion pf_mov_monet 14947'
               select @w_error = @w_return
               goto ERROR
            end
            ---------------------------------------------------------------
            -- Proceso para insertar en pf_mov_monet el valor del interes
            -- neto y el impuesto calculado sobre los intereses de la
            -- operacion original en aquellas operaciones que retengan
            -- impuesto y que el valor de los intereses sea mayor que cero
            ---------------------------------------------------------------
            select @w_int_ren      = @w_total_int_ganados - @w_total_int_pagados
            select @w_int_ren_neto = round((@w_int_ren - @w_imp_base),@w_numdeci)
            select @w_oficina_ant  = @w_oficina -- oficina para sp_aplica_conta

            if @w_int_ren_neto > 0 and @w_tcapitalizacion = 'S'
            begin
               select @w_secuencia = @w_secuencia_ren + 1

               insert pf_mov_monet(mm_operacion,        mm_tran,       mm_secuencia,    mm_sub_secuencia,
                                   mm_producto,         mm_cuenta,     mm_valor,        mm_fecha_crea,
                                   mm_fecha_mod,        mm_tipo,       mm_beneficiario, mm_secuencial,
                                   mm_fecha_aplicacion, mm_estado,     mm_moneda,       mm_valor_ext,
                                   mm_impuesto,         mm_fecha_real, mm_usuario)
                            values(@w_operacion,        14947,        @w_secuencia,    @w_sub_secuencia,
                                   'REN',               @w_num_banco, @w_int_ren_neto, @s_date,
                                   @s_date,             'I',          @w_ente,         0,
                                   NULL,                NULL,         @w_moneda,       @w_int_neto,
                                   @w_imp_base,         getdate(),    @s_user)
               if @@error <> 0
               begin
                  select @w_mensaje = 'Error en insercion de pf_mov_monet 14947 capitalizacion'
                  select @w_error = 143022
                  goto ERROR
               end
               select @w_int_renovar = @w_int_ren -- int. bruto para sp_aplica_conta
               exec @w_return        = sp_aplica_mov
                    @s_ssn           = @w_secuencial,
                    @s_user          = @s_user,
                    @s_ofi           = @s_ofi,
                    @s_date          = @s_date,
                    @s_srv           = @s_srv,
                    @s_term          = @s_term,
                    @t_file          = @t_file,
                    @t_from          = @w_sp_name,
                    @t_debug         = @t_debug,
                    @t_trn           = 14947,
                    @i_tipo          = 'N',
                    @i_en_linea      = 'N',
                    @i_operacionpf   = @w_operacion,
                    @i_secuencia     = @w_secuencia,
                    @i_sub_secuencia = @w_sub_secuencia,
                    @i_op_num_banco  = @w_num_banco,
                    @i_alt           = @w_alt
               if @w_return <> 0
               begin
                  select @w_mensaje = 'Error en aplicacion pf_mov_monet 14947 cap'
                  select @w_error = @w_return
                  goto ERROR
               end
            end     -- int a renovar > 0

            ---------------------------------------------------------------------------------------------
            -- Proceso para insertar en pf_mov_monet el valor del capital mas el valor del interes neto
            -- si la operacion tiene pago de interes al vencimiento y que el valor de estos intereses se
            -- los deba capitalizar. O insertar en pf_mov_monet unicamente el capital, si los intereses
            -- se pagaron como en el caso de productos anticipados o periodicos, o como en el caso de
            -- pagos al vencimiento, pero que no se deban capitalizar los intereses.
            ----------------------------------------------------------------------------------------------
            if @w_fpago = 'VEN'
            begin
               if @w_tcapitalizacion ='S' /* capitaliza int */
               begin
                  select @w_monto_renovar = round((@w_monto+@w_int_ren_neto),@w_numdeci)
               end
               else /* si no se capitalizan los intereses */
               begin
                  select @w_monto_renovar = @w_monto
               end     -- Vencimiento no capitalizable
            end        -- Forma de Pago al vencimiento

            if @w_fpago in ('PER','PRA','ANT')
            begin
               if @w_tcapitalizacion ='S' --04/nov/98 xca operaciones si capitalizan
                  select @w_monto_renovar = @w_monto
               else /* operaciones que NO capitalizan 04/nov/98 capitaliza */
                  select @w_monto_renovar = @w_monto
            end

            --------------------------------------------------------------------------------
            -- Proceso para insertar en pf_mov_monet el registro correspondiente al pago de
            -- intereses anticipados en la tabla pf_mov_monet y en pf_emision_cheque
            --------------------------------------------------------------------------------
            if @w_fpago in ('ANT','PER','VEN')
            begin
               select @w_dp_monto     = sum(dp_monto),
                      @w_sum_dp_monto = sum(dp_monto) --12-Ago-2000 xca
               from pf_det_pago
               where dp_operacion    = @w_operacion
               and   dp_tipo        in('INT','REN','INTV')
               and   dp_estado_xren  = 'N'
               and   dp_estado       = 'I'
                --order by dp_operacion,dp_tipo NYMPSQL
               if @w_dp_monto  is null
                  select @w_dp_monto = 0

               select @w_dp_count = count(*)
               from pf_det_pago
               where dp_operacion   = @w_operacion
               and   dp_tipo       in ('INT','REN','INTV')
               and   dp_estado_xren = 'N'
               and   dp_estado      = 'I'

               select @w_dp_monto_new = round((@w_int_estim_new - @w_impuesto_ren),@w_numdeci)

               ----------------------------------------------------------------------------------------------------
               -- Proceso para tomar el secuencial max y min de pf_det_pago para el registro correspondiente
               -- con la condicion de que el tipo puede estar en 'INT' (apertura) o 'REN' (renovado via front_end)
               -- pero en cualquiera de los dos casos el campo dp_estado_xren debe estar en 'N'
               ----------------------------------------------------------------------------------------------------
               select @w_dp_secuencia_max = max(dp_secuencia),
                      @w_dp_secuencia_min = min(dp_secuencia),
                      @w_dp_secuencia_up  = min(dp_secuencia)
               from pf_det_pago
               where dp_operacion    = @w_operacion
               and   dp_tipo        in ('INT','REN', 'INTV')
               and   dp_estado_xren  = 'N'
               and   dp_estado       = 'I'
            end -- w_fpago


            ---------------------------------------
            -- Proceso para actualizar pf_det_pago
            ---------------------------------------
            if @w_fpago in ('PER', 'VEN')
            begin
               select @w_dp_count_lazo = 1

               if @w_dp_count > 1
               begin
                  while @w_dp_count >= @w_dp_count_lazo
                  begin
                     select @w_dp_fpago     = dp_forma_pago,
                            @w_dp_cuenta    = dp_cuenta,
                            @w_dp_monto_reg = dp_monto,
                            @w_dp_porcent   = dp_porcentaje
                     from pf_det_pago
                     where dp_operacion    = @w_operacion
                     and   dp_secuencia    = @w_dp_secuencia_up
                     and   dp_tipo        in ('INT','REN', 'INTV')
                     and   dp_estado_xren  = 'N'
                     and   dp_estado       = 'I'
                     order by dp_secuencia

                     --select @w_dp_porcent      = round(((@w_dp_monto_reg * 100) / @w_sum_dp_monto),@w_numdeci)--12-Ago-2000 xca
                     select @w_dp_monto_new    = round((@w_int_estim_new - @w_impuesto_ren),@w_numdeci)
                     select @w_dp_monto        = round(((@w_dp_monto_new * @w_dp_porcent) / 100),@w_numdeci)
                     select @w_porcent_impren  = round(((@w_impuesto_ren * @w_dp_porcent) / 100),@w_numdeci) --12-Ago-2000 xca

                     update pf_det_pago
                     set dp_monto     = @w_dp_monto,
                         dp_fecha_mod = @w_fecha_hoy
                     where dp_operacion   = @w_operacion
                     and   dp_secuencia   = @w_dp_secuencia_up
                     and   dp_tipo       in ('INT','REN', 'INTV')
                     and   dp_estado_xren = 'N'
                     and   dp_estado      = 'I'
                     if @@error <> 0
                     begin
                        select @w_mensaje = 'Error en actualizacion pf_det_pago'
                        select @w_error = 147038
                        goto ERROR
                     end

                     select @w_dp_count_lazo = @w_dp_count_lazo + 1
                     select @w_dp_secuencia_up = @w_dp_secuencia_up + 1
                  end /* fin while */

                  ---------------------------------------------------
                  ----Ajuste de la ultima cuota en caso de diferencia
                  ---------------------------------------------------
                  select @w_suma = sum(dp_monto)
                  from  pf_det_pago
                  where dp_operacion = @w_operacion
                  and   dp_tipo in ('INT','REN', 'INTV')
                  and   dp_estado_xren = 'N'
                  and   dp_estado   = 'I'

                  if @w_int_estim_new <> isnull(@w_suma, @w_int_estim_new)
                  begin
                     update   pf_det_pago
                     set   dp_monto = dp_monto + (@w_int_estim_new - @w_suma)
                     where dp_operacion = @w_operacion
                     and   dp_tipo in ('INT','REN', 'INTV')
                     and   dp_estado_xren = 'N'
                     and   dp_estado   = 'I'
                     and   dp_secuencia   = (select max(dp_secuencia)
                                             from  pf_det_pago
                                             where dp_operacion = @w_operacion
                                             and   dp_tipo in ('INT','REN', 'INTV')
                                             and   dp_estado_xren = 'N'
                                             and   dp_estado   = 'I'
                                             )
                  end

               end /* fin @w_dp_count > 1 */
               else /* si unicamente hay un registro en pf_det_pago */
               begin
                  select   @w_dp_fpago     = dp_forma_pago,
                           @w_dp_cuenta    = dp_cuenta,
                           @w_dp_monto     = dp_monto
                  from pf_det_pago
                  where dp_operacion = @w_operacion
                  and   dp_tipo in ('INT','REN', 'INTV')
                  and   dp_estado_xren = 'N'
                  and   dp_estado      = 'I'
                  order by dp_secuencia

                  select @w_dp_monto = round((@w_int_estim_new - @w_impuesto_ren),@w_numdeci)

                  update pf_det_pago
                    set dp_monto     = @w_dp_monto,
                        dp_fecha_mod = @w_fecha_hoy
                  where dp_operacion = @w_operacion
                  and   dp_secuencia = @w_dp_secuencia_up
                  and   dp_tipo in('INT','REN', 'INTV')
                  and   dp_estado_xren  = 'N'
                  and   dp_estado       = 'I'

                  if @@error <> 0
                  begin
                     select @w_mensaje = 'Error en actualizacion pf_det_pago 1 registro'
                     select @w_error = 147038
                     goto ERROR
                  end
               end
            end /* fin @w_fpago = 'PER', 'VEN' */


            ----------------------------------------
            -- Proceso para actualizar pf_operacion
            ----------------------------------------
            select @w_historia = @w_historia + 1
            select @w_mon_sgte = @w_secuencia

            ---------------------------------------------------------------------------------------------------------------
            -- Proceso incrementado para enviar a op_monto_pg_int el valor real si es PRA y si capitaliza iteres 11/Nov/98
            ---------------------------------------------------------------------------------------------------------------
            if @w_fpago in('PRA','ANT') and @w_tcapitalizacion = 'S'
            begin
               select @w_monto_ren_pg_int = (@w_monto_ren + (@w_int_estim_new  - @w_impuesto_ren))
            end
            else /* (VEN,PER CapitalSi o No) (PRA,ANT solo si no capitali)*/
            begin
               select @w_monto_ren_pg_int = @w_monto_ren
            end

            -------------------------------------------------------------------
            -- Proceso para determinar el numero de prorroga en el que VA-HJPG
            -------------------------------------------------------------------
            select @w_num_prorroga = @w_num_prorroga + 1

            /* Recalculo de interes estimado Total */
            if @w_anio_comercial = 'N'
            begin
               select @w_num_dias_real = datediff(dd,@w_fecha_hoy,@w_fecha_ven)
            end
            else
            begin
               exec sp_funcion_1 @i_operacion = 'DIFE30',
                  @i_fechai   = @w_fecha_hoy,
                  @i_fechaf   = @w_fecha_ven,
                  @i_dia_pago = @w_dia_pago, --*-*
                  @o_dias     = @w_num_dias_real  out
            end

            if @w_fpago = 'VEN'
               select @w_int_estim_new = @w_tot_int_estim_new

            --*-* Envia a contabilizar la prorroga automatica
            select @w_descripcion = 'PRORROGA AUTOMATICA (' + @w_num_banco + ')'

            select
            @w_tplazo_cont_old = pc_plazo_cont
            from  pf_plazo_contable
            where @w_num_dias_old  between pc_plazo_min and pc_plazo_max

            select
            @w_tplazo_cont     =  pc_plazo_cont
            from  pf_plazo_contable
            where @w_num_dias_real between pc_plazo_min and pc_plazo_max

            exec @w_return = cob_pfijo..sp_aplica_conta
            @s_date         = @s_date,
            @s_user         = @s_user,
            @s_term         = @s_term,
            @s_ofi          = @s_ofi,
            @i_fecha        = @w_fecha_hoy,
            @i_tran         = @t_trn,
            @i_ente_endoso  = @w_ente,
            @i_ente	    = @w_ente,
            @i_oficina_oper = @w_oficina,         -- op_oficina
            @i_oficina      = @w_oficina,         -- mm_oficina
            @i_toperacion   = @w_toperacion,
            @i_tplazo       = @w_tplazo_cont,
            @i_tplazo_old   = @w_tplazo_cont_old,
            @i_operacionpf  = @w_operacion,
            @i_afectacion   = 'N',   --'N',       -- N=Normal,  R=Reverso
            @i_descripcion  = @w_descripcion,
            @i_monto        = @w_monto_ren,      -- CVA May-25-06
            @i_secuencia    = @w_mon_sgte,       -- Toma reg. de sec. adec
            @o_comprobante  = @o_comprobante out

            if @w_return <> 0
            begin
               select @w_mensaje = 'Error en contabilizacion de prorroga:' + @w_num_banco
               select @w_error = @w_return
               goto ERROR
            end

            select @w_estado = 'ACT'


            if  @w_op_int_ganado is null
               select @w_op_int_ganado = 0

if @t_debug = 'S'  print 'RENOVAUT.....@w_fecha_pg_int_new:' + cast(@w_fecha_pg_int_new  as varchar)


            /* Actualizacion de operacion */
            update cob_pfijo..pf_operacion
               set op_monto                  = @w_monto_ren,
                   op_monto_pg_int           = @w_monto_ren,      --11/Nov/98
                   op_tasa                   = @w_tasa_new_vigente,
                   op_tasa_efectiva          = @w_tasa_efectiva_conver,
                   op_int_ganado             = @w_op_int_ganado,
                   op_int_estimado           = round(@w_int_estim_new,@w_numdeci),         --verificar PRP
                   op_residuo                = 0,
                   op_int_pagados            = @w_op_int_pagados,        --verifica si es PRP
                   op_int_provision          = 0,
                   op_total_int_ganados      = 0,                        --considerar si no capitaliza
                   op_total_int_pagados      = @w_op_total_int_pagados,  --verificar PRP
                   op_tot_int_est_ant        = @w_op_tot_int_est_ant,
                   op_total_int_estimado     = round(@w_tot_int_estim_new,@w_numdeci),
                   op_total_int_retenido     = 0,
                   op_historia               = @w_historia,
                   op_renovaciones           = op_renovaciones + 1,
                   op_mon_sgte               = (@w_secuencia + 1),
                   op_tipo_plazo             = @w_tipo_plazo,           -- evaluar si el monto cambia
                   op_tipo_monto             = @w_tipo_monto,           --evaluar si el monto cambia
                   op_causa_mod              = 'TREN',
                   op_fecha_valor            = @w_fecha_hoy,
                   op_fecha_ven              = @w_fecha_ven,
                   op_fecha_pg_int           = @w_fecha_pg_int_new,
                   op_fecha_ult_pg_int       = @w_fecha_hoy,
                   op_fecha_ult_pago_int_ant = NULL, --CVA Nov-22-05
                   op_ult_fecha_calculo      = '01/01/1900',
                   op_fecha_mod              = @w_fecha_hoy,
                   op_fecha_total            = @w_fecha_pg_int_new,
                   op_tasa_mer               = @w_tasa_base,
                   op_fecven_ant             = @w_fecha_ven,
                   op_fecha_ord_act          = @w_fecha_hoy,
                   --*-* op_num_dias_gracia    = @w_op_num_dias_gracia,
                   op_num_dias               = @w_num_dias_real,        --para actualiza. 04/nov/98
                   op_estatus_prorroga       = 'N',                     --HJPG 21-Dic-98
                   op_num_prorroga           = @w_num_prorroga,         --HJPG 21-Dic-98
                   op_int_total_prov_vencida = 0,
                   op_int_prov_vencida       = 0,
                   --op_operador               = @w_operador,
                   op_spread                 = @w_spread,
                   op_toperacion             = @w_toperacion,
                   op_estado                 = @w_estado--,
                   --op_total_int_retenido     = 0,
                   --op_total_ica           = 0
            where current of cursor_operacion
            if @@error <> 0
            begin
               select @w_mensaje = 'Error en actualizacion de pf_operacion'
               select @w_error =  145001
               goto ERROR
            end

            select @w_fecha_p = fp_fecha
            from cobis..ba_fecha_proceso
            
            insert into cob_pfijo..pf_tasa_var_p (
            pt_fecha,             pt_operacion,          pt_trn,
            pt_puntos,            pt_operador_puntos,    pt_spread,
            pt_operador_spread,   pt_tasa_nominal,       pt_tasa_efectiva,
            pf_tasa_ref)
            values (
            @w_fecha_p,           @w_operacion,       14905,
            @w_puntos,            @w_operador_tmp,       @w_spread_tmp,
            @w_op_operador,       @w_tasa_new_vigente,   @w_tasa_efectiva_conver,
            @w_tasavar_orig)
            
            if @@error <> 0
            begin
               select @w_error = 145001,@w_mensaje = 'Error en insercion en operacion pf_tasa_var_p'
               goto ERROR
            end
            --------------------------------------------------------------------------------------------
            -- Proceso para operaciones con pago de intereses al vencimiento y en las cuales NO se debe
            -- capitalizar los intereses al ejecutar la prorroga automatica.
            --------------------------------------------------------------------------------------------
            if @w_fpago in('PER','PRA')
            begin
               select @w_sa_int_renovar = 0
               select @w_sa_total_pagar = round((@w_dp_monto_new - @w_impuesto_ren),@w_numdeci)
               select @w_secuencia = NULL
               select @w_impuesto_ren = 0
            end

            --------------------------------------------------------------------------------------------------------------
            -- Proceso para realizar la provision de intereses con fecha retroactiva si la operacion tiene dias de gracia
            --------------------------------------------------------------------------------------------------------------
            if @w_provision_dias_gracia = 'S'
            begin
               if @w_anio_comercial = 'N'
               begin
                  select @w_dias_back = datediff(dd,@w_fecha_ven_old,@w_fecha_proceso)
               end
               else
               begin
                  exec sp_funcion_1 @i_operacion = 'DIFE30',
                     @i_fechai   = @w_fecha_ven_old,
                     @i_fechaf   = @w_fecha_proceso,
                     @i_dia_pago = @w_dia_pago, --*-*
                     @o_dias     = @w_dias_back  out
               end

               if @w_dias_back > 0
               begin
                  exec @w_return = sp_calc_diario_int
                     @s_ssn           = @w_secuencial,
                     @s_user          = @s_user,
                     @s_term          = @s_term,
                     @s_date          = @s_date,
                     @s_srv           = @s_srv,
                     @s_lsrv          = @s_lsrv,
                     @s_ofi           = @s_ofi,
                     @s_rol           = @s_rol,
                     @t_debug         = @t_debug,
                     @t_file          = @t_file,
                     @t_from          = @t_from,
                     @t_trn           = 14926,
                     @i_num_banco     = @w_num_banco,
                     @i_dias_interes  = @w_dias_back,
                     @i_batch       = 0,  --*-*
                     @i_fecha_proceso = @w_fecha_ven_old,
                     @i_tipo_act      = 'R',
                     --@i_prorroga_aut  = 'S',
                     --@i_prov_vencida  = @w_op_int_total_prov_vencida,
                     --@i_inicio        = @i_inicio,
                     --@i_fin           = @i_fin,
                     @i_en_linea      = 'N'  --CVA May-11-07
                  if @w_return <> 0
                  begin
                        select @w_error =  149015
                        goto ERROR
                  end
               end -- @w_dias_back > 0
            end    -- @w_provision_dias_gracia = 'S'
         end       -- primer if
      end          -- del if @w_num_prorroga < @w_td_num_prorrogas

      --------------------------------------------
      -- Generar archivo de cuotas
      --------------------------------------------
      if @w_fpago = 'PER' and @w_estado = 'ACT' and @w_tasa_new_vigente IS NOT  NULL --CVA Sep-25-06
      begin
         ---------------------
         -- Borrado de cuotas
         ---------------------
         delete cob_pfijo..pf_cuotas_his

         -------------------------------------------------------------
         -- Grabar las cuotas en un archivo historico para el reverso
         -------------------------------------------------------------
         insert into cob_pfijo..pf_cuotas_his(
                ch_ente,           ch_operacion, ch_cuota,    ch_fecha_pago,
                ch_valor_cuota,    ch_retencion, ch_capital,  ch_fecha_crea,
                ch_moneda,         ch_oficina,   ch_num_dias, ch_estado,
                ch_fecha_ult_pago, ch_tasa,      ch_ppago,    ch_base_calculo,
                ch_fecha_grab)
         select cu_ente,           cu_operacion, cu_cuota,    cu_fecha_pago,
                cu_valor_cuota,    cu_retencion, cu_capital,  cu_fecha_crea,
                cu_moneda,         cu_oficina,   cu_num_dias, cu_estado,
                cu_fecha_ult_pago, cu_tasa,      cu_ppago,    cu_base_calculo,
                @i_fecha_proceso
         from cob_pfijo..pf_cuotas
         where cu_operacion =  @w_operacion

         /* Borrado de registros en la tabla de cuotas */
         delete cob_pfijo..pf_cuotas where cu_operacion = @w_operacion

         /* Generacion de nuevo archivo de cuotas por operacion */
         exec @w_return = sp_cuotas
            @s_ssn                 = @s_ssn,
            @s_user                = @s_user,
            @s_sesn                = @s_ssn,
            @s_ofi                 = @s_ofi,
            @s_date                = @i_fecha_proceso,
            @t_trn                 = 14146,
            @s_srv                 = @s_srv,
            @s_term                = @s_term,
            @t_file                = @t_file,
            @t_from                = @w_sp_name,
            @t_debug               = @t_debug,
            @i_en_linea            = 'N',
            @i_op_ente             = @w_ente,
            @i_op_operacion        = @w_operacion,
            @i_op_fecha_valor      = @w_fecha_hoy,
            @i_op_fecha_ven        = @w_fecha_ven,
            @i_op_monto            = @w_monto_ren,
            @i_op_tasa             = @w_tasa_new_vigente,
            @i_op_num_dias         = @w_num_dias_real,
            @i_op_ppago            = @w_ppago,
            @i_op_retienimp        = @w_retienimp,
            @i_op_moneda           = @w_moneda,
            @i_op_oficina          = @s_ofi,
            @i_op_tcapitalizacion  = @w_tcapitalizacion,
            @i_op_fpago            = @w_fpago,
            @i_op_base_calculo     = @w_base_calculo,
            @i_op_anio_comercial   = @w_anio_comercial,
            @i_modifica            = @w_modifica,
            @i_tot_int_estimado    = @w_total_int_estim
         if @w_return <> 0
         begin
              select @w_mensaje = 'Error en gener. de cuotas'
              select @w_error =  @w_return
              goto ERROR
         end
      end

      ----------------------------------------------------
      -- Proceso para actualizar informaci«n en garantias
      ----------------------------------------------------
      if (@w_tasa <> @w_tasa_new_vigente and @w_tasa_new_vigente IS  NOT NULL) and @w_pignorado = 'S'
      begin
         if exists(select pi_cuenta
                   from   pf_pignoracion
                   where pi_operacion    = @w_operacion
                   and   pi_producto     = 'GAR'       )
         begin

            insert pf_cambio_tasa (ct_operacion,ct_fecha_crea,ct_num_banco,ct_tasa_ant,
                    ct_tasa_act, ct_estado,ct_login)
            values (@w_operacion, @s_date, @w_num_banco,@w_tasa,
               @w_tasa_new_vigente,'I', @s_user)

            select @w_error =  @@error
            if @w_error <> 0
            begin
                   select @w_mensaje = 'Error almacenar cambio tasa'
                   goto ERROR
            end
         end
      end

   commit tran

   --I. CVA Set-08-06 implementacion para obtener seqnos del kernel
   exec @w_ssn = ADMIN...rp_ssn

   select @w_secuencial = @w_ssn,
          @s_ssn        = @w_ssn

SIGUIENTE:
   select @w_num_dias = 0

   fetch cursor_operacion into
       @w_num_banco,               @w_operacion,                      @w_ente,                      @w_toperacion,
       @w_categoria,               @w_estado,                         @w_producto,                  @w_oficina,
       @w_moneda,                  @w_num_dias,                       @w_base_calculo,              @w_monto,
       @w_monto_pg_int,            @w_monto_pgdo,                     @w_monto_blq,                 @w_tasa,
       @w_tasa_efectiva,           @w_int_ganado,                     @w_int_estimado,              @w_residuo,
       @w_int_pagados,             @w_int_provision,                  @w_total_int_ganados,         @w_total_int_pagados,
       @w_total_int_estimado,      @w_total_int_retenido,             @w_total_retencion,           @w_fpago,
       @w_ppago,                   @w_casilla,                        @w_direccion,                 @w_telefono,
       @w_historia,                @w_duplicados,                     @w_renovaciones,              @w_incremento,
       @w_mon_sgte,                @w_pignorado,                      @w_renova_todo,               @w_imprime,
       @w_retenido,                @w_retienimp,                      @w_totalizado,                @w_tcapitalizacion,
       @w_oficial,                 @w_accion_sgte,                    @w_preimpreso,                @w_tipo_plazo,
       @w_tipo_monto,              @w_causa_mod,                      @w_op_descripcion,            @w_fecha_valor,
       @w_fecha_ven,               @w_fecha_cancela,                  @w_fecha_ingreso,             @w_fecha_pg_int,
       @w_fecha_ult_pg_int,        @w_ult_fecha_calculo,              @w_fecha_crea,                @w_fecha_mod,
       @w_fecha_total,             @w_puntos,                         @w_total_int_acumulado,       @w_tasa_mer,
       @w_ced_ruc,                 @w_plazo_ant,                      @w_fecven_ant,                @w_tot_int_est_ant,
       @w_fecha_ord_act,           @w_mantiene_stock,                 @w_stock,                     @w_emision_inicial,
       @w_moneda_pg,               @w_impuesto,                       @w_prorroga_aut,              @w_tasa_variable,
       @w_mnemonico_tasa_var,      @w_modalidad_tasa,                 @w_periodo_tasa,              @w_descr_tasa,
       @w_operador,                @w_spread,                         @w_estatus_prorroga,          @w_num_prorroga,
       @w_anio_comercial,          @w_flag_tasaefec,                  @w_op_int_total_prov_vencida, @w_op_num_dias_gracia,
       @w_op_dias_reales,          @w_dia_pago
end /*while cursor_operacion*/


if @@fetch_status =  -2
begin
   close cursor_operacion
   deallocate  cursor_operacion
   raiserror ('200001 - Fallo lectura del cursor ', 16, 1)
   return 0
end


close cursor_operacion
deallocate  cursor_operacion

return 0

-------------------
-- Manejo de Error
-------------------
ERROR:

   rollback tran

   exec  sp_errorlog
      @i_fecha       = @s_date,
      @s_date        = @s_date,
      @i_error       = @w_error,
      @i_usuario     = @s_user,
      @i_tran        = @t_trn,
      @i_cuenta      = @w_num_banco,
      @i_cta_pagrec  = @w_mensaje, --CVA Oct-20-05
      @i_descripcion = @w_sp_name

   goto SIGUIENTE
go
