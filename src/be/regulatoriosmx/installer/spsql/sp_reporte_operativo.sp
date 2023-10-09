
/************************************************************************/
/*   Archivo:                 sp_reporte_operativo.sp                   */
/*   Stored procedure:        sp_reporte_operativo                      */
/*   Base de Datos:           cob_cartera                               */
/*   Producto:                Cartera                                   */
/*   Disenado por:                                                      */
/*   Fecha de Documentacion:  Junio 29 de 2017                          */
/************************************************************************/
/*                            IMPORTANTE                                */
/*   Este programa es parte de los paquetes bancario s propiedad de     */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier autorizacion o agregado hecho por alguno de sus          */
/*   usuario sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante                 */
/************************************************************************/
/*                         PROPOSITO                                    */
/*   Generar reporte operativo de cartera y archivo plano respectivo    */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*   Fecha      Nombre          Proposito                               */
/*   29/06/2017 Jorge Salazar   Emision Inicial                         */
/*                              CGS-S115718                             */
/*   21/09/2017 Tania Baidal    Modificacion estructura                 */
/*                              sb_dato_operacion_rubro CGS-S132051     */
/*   10/04/2018 Ma. Jose Taco   Cambio de dias de atraso para dividendos*/
/*                              vencidos                                */
/*   09/08/2018 Santiago Mosquera  Nuevo campos y nuevas condiciones    */
/*                                   de filtrado req#101740             */
/*   15/08/2018 Santiago Mosquera  se elimina la invocacion             */
/*                                 sp_reporte_operativo_antes           */
/*	 15/01/2019 Agustin E. Ortiz Se agregan numeros de empleado         */
/*								   Requerimiento:-109895				*/ 
/*	 02/05/2019 ACHP             Se aumenta una relacion por coordenadas*/
/*								 = 0 Caso 115243                        */
/*   09/05/2019 D. Cumbal        Cambio visualizacion Iva Exigible      */
/*   28/08/2019 MTaco            Valida dia de pago no sea null         */
/*   09/08/2019 ALD			     Modificaciones para LCR                */ 
/*   23/09/2019 A. Ortiz         Agregar campo referencia caso # 119655 */ 
/*   05-07-2019 srojas            Reestructuracion Buro historico       */
/*   30/09/2019 D. Cumbal        Cambios por el caso 127032             */
/*   21/11/2019 M. Taco          Caso 129728 optimizacion batch         */
/*   29/11/2019     PXSG         Requerimiento #129681 Cob. Mc Collect  */
/*   03/07/2020 D. Cumbal        Cambo obtencion intereses              */
/*   04/09/2020 Johan Castro     Requerimiento 142301                   */
/*   29/09/2020 Johan Castro     Corresccion nombre archivo caso 142301 */
/*   15/12/2020 Johan Castro     REQ#149740                             */
/*   ENE/2021   AGO              Req 147999   Renovaciones  Financiadas */
/*   11/08/2021 ACHP             #166473 Ciclo indv no es consistente en*/
/*                               la renovaciÃ³n                          */
/*   09/11/2021 AGO              Error #171517                          */
/*   08/12/2022  ACH             Caso: 194284 DIA DE PAGO               */
/************************************************************************/

use cob_conta_super
go 


if not object_id('sp_reporte_operativo') is null
   drop proc sp_reporte_operativo
go

create proc sp_reporte_operativo
   @i_param1   varchar(10),   --FECHA
   @i_param2   varchar(10),   --BATCH 28793
   @i_param3   varchar(10)    --FORMATO FECHA
as
declare 
@w_s_app           varchar(255),
@w_path            varchar(255),
@w_destino         varchar(255),
@w_destino2        varchar(255),
@w_errores         varchar(255),
@w_cmd             varchar(5000),
@w_error           int,
@w_comando         varchar(6000),
@w_fecha           datetime,
@w_batch           int,
@w_columna         varchar(50),
@w_col_id          int,
@w_cabecera        varchar(5000),
@w_mes             char(20),
@w_anio            char(4), 
@w_fecha2          char(10),
@w_fecha_desde     datetime,
@w_lineas          varchar(10),
@w_garhip          varchar(10),
@w_garpre          varchar(10),
@w_fp_usaid        varchar(30),
@w_tabla           int,
@w_estado_nota     char(1),
@w_empresa         tinyint,
@w_formato_fecha   int,
@w_est_vencido     int,
@w_est_vigente     int,
@w_est_castigado   int,
@w_grupo_act       int,
@w_num_ciclo_ant   int,
@w_resultado       int,
@w_return          int,
@w_fecha_provision datetime,
@w_codigo_ing_sol  int ,
@w_codigo_act_apr   int ,
@w_est_suspenso    int ,
@w_ente_aux        int,
@w_exp_credit      char(1),
@w_query           varchar(2559),
@w_nom_arch        varchar(255),
@w_nom_arch_cab    varchar(255),
@w_nom_log         varchar(255),
@w_patch_cobranza  varchar(255),
@w_destino_cobranza varchar(255),
@w_destino_cobranza2 varchar(255),
@w_lineas_cob         varchar(10),
@w_nom_arch_des      varchar(255),
@w_num_col_mc        int,
@w_est_cancelado     int

select
@w_batch         = convert(int,@i_param2),
@w_formato_fecha = convert(int,@i_param3),
@w_fecha         = @i_param1

select @w_empresa = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'EMP'
and   pa_producto = 'ADM'


/*CODIGO INGRESO DE SOLICITUD*/
select @w_codigo_ing_sol = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_producto = 'CCA'
and    pa_nemonico = 'CFINSO'

/*CODIGO ACTIVIDAD APROBACION- SOLICITUDES*/
select @w_codigo_act_apr = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_producto = 'CCA'
and    pa_nemonico = 'CAAPSO'


--CONSULTAR ESTADO VENCIDO/VIGENTE PARA CARTERA
exec @w_error    = cob_externos..sp_estados
@i_producto      = 7,
@o_est_vencido   = @w_est_vencido   out,
@o_est_vigente   = @w_est_vigente   out,
@o_est_castigado = @w_est_castigado out,
@o_est_suspenso  = @w_est_suspenso  out,
@o_est_cancelado = @w_est_cancelado out
 

if @@error <> 0 begin
   print 'No Encontro Estado Vencido/Vigente/Castigado para Cartera'
   return 1
end


SET NOCOUNT ON
SET ROWCOUNT 0

/*exec sp_reporte_operativo_antes
@i_param1     = @i_param1,--FECHA
@i_param2     = 28793,    --BATCH
@i_param3     = 111       --FORMATO FECHA*/

/* GENERAR LA TABLA DE TRABAJO EN BASE A LOS DATOS DE LA TABLA SB_DATO_OPERACION */
select 
mca_fecha                = convert(varchar,do_fecha,111),
mca_territorial          = convert(varchar(64),''),
mca_division_cod         = convert(smallint,0),
mca_division             = convert(varchar(64),''),
mca_region_cod           = convert(smallint,0),
mca_region               = convert(varchar(64),''),
mca_oficina              = do_oficina,
mca_banco                = do_banco,
mca_grupo                = do_grupo,
mca_nombre_grupo         = convert(varchar(64),''),
mca_tipo_doc             = convert(varchar(10),''),
mca_doc_cliente          = convert(varchar(24),''),
mca_curp                 = convert(varchar(255),null),
mca_tramite              = do_tramite,
mca_oficial_ci           = convert(varchar(64),''),
mca_oficial_id           = do_oficial,
mca_oficial              = convert(varchar(64),''),
mca_oficial_status       = convert(varchar(64),''),
mca_coordinador_id       = convert(int,0),
mca_coordinador          = convert(varchar(64),''),
mca_gerente_id           = convert(int,0),
mca_gerente              = convert(varchar(64),''),
mca_cliente              = do_codigo_cliente,
mca_nombre1              = convert(varchar(64),''),
mca_nombre2              = convert(varchar(64),''),
mca_apellido_paterno     = convert(varchar(64),''),
mca_apellido_materno     = convert(varchar(64),''),
mca_genero               = convert(varchar(10),''),
mca_edad                 = convert(int,0),
mca_fecha_nac            = convert(datetime,null),
mca_tel_negocio          = convert(varchar(16),''),
mca_tel_cliente          = convert(varchar(16),''),
mca_dir_negocio          = convert(varchar(254),''),
mca_dir_domicil          = convert(varchar(254),''),
mca_dep_negocio          = convert(varchar(64),''),
mca_dep_domicil          = convert(varchar(64),''),
mca_ciu_negocio          = convert(varchar(64),''),
mca_ciu_domicil          = convert(varchar(64),''),
mca_bar_negocio          = convert(varchar(64),''),
mca_bar_domicil          = convert(varchar(64),''),
mca_cp_domicil           = convert(int,0),
mca_cp_negocio           = convert(int,0),
mca_tlocal_negocio       = convert(varchar(64),''),
mca_pers_cargo           = convert(int,0),
mca_hijos                = convert(int,0),
mca_estrato              = convert(varchar(64),''),
mca_est_civil            = convert(varchar(64),''),
mca_tipo_vivienda        = convert(varchar(64),''),
mca_nivel_estudio        = convert(varchar(64),''),
mca_cony_nombres         = convert(varchar(255),''),
mca_cony_tipo_doc        = convert(varchar(100),''),
mca_cony_doc             = convert(varchar(30),''),
mca_codeudor1            = convert(varchar(64),''),
mca_codeudor1_dir        = convert(varchar(255),''),
mca_codeudor1_tel        = convert(varchar(16),''),
mca_codeudor2            = convert(varchar(64),''),
mca_codeudor2_dir        = convert(varchar(255),''),
mca_codeudor2_tel        = convert(varchar(16),''),
mca_codeudor3            = convert(varchar(64),''),
mca_codeudor3_dir        = convert(varchar(255),''),
mca_codeudor3_tel        = convert(varchar(16),''),
mca_cr_otros_banc        = convert(int,0),
mca_num_creditos         = convert(int,0),
mca_procedencia          = convert(varchar(64),''),
mca_clave_act_econo      = convert(varchar(10),''),
mca_act_economica        = convert(varchar(200),''),
mca_act_economica_corto  = convert(varchar(100),''),
mca_antiguedad           = convert(int,0),
mca_experiencia          = convert(varchar(10),'N'),
mca_dst_economico        = convert(varchar(64),''),
mca_total_act            = convert(money,0),
mca_total_pas            = convert(money,0),
mca_total_pat            = convert(money,0),
mca_total_ing_b          = convert(money,0),  
mca_total_gastos         = convert(money,0), 
mca_total_ing_add        = convert(money,0),
mca_total_dec_jur        = convert(money,0),
mca_liquidez_disp        = convert(money,0),
mca_banca                = convert(varchar(64),''),
mca_mercado_obj          = convert(varchar(64),''),
mca_mercado_sub          = convert(varchar(64),''),
mca_sujeto_cred          = convert(varchar(64),''),
mca_tipo_usuario         = convert(varchar(64),''),
mca_monto                = do_monto,
mca_monto_par            = convert(money,0),
mca_fecha_sol            = convert(datetime,null),
mca_tipo_cred            = convert(varchar(64),''),
mca_tipo_cuota           = convert(varchar(64),''),
mca_dia_cuota            = convert(int,0),
mca_cap_saldo            = do_saldo_cap,
mca_int_saldo            = convert(money,0),
mca_saldo_cmora          = convert(money,0),
mca_int_saldo_cont       = do_saldo_int_contingente,
mca_saldo_imo            = convert(money,0),
mca_saldo_mip            = convert(money,0),
mca_saldo_fng            = convert(money,0),
mca_seg_saldo            = convert(money,0),
mca_saldo_otr            = convert(money,0),
mca_monto_pg_fng         = convert(money,0),
mca_cap_saldo_v          = do_valor_mora,
mca_int_saldo_v          = convert(money,0),
mca_saldo_imo_v          = convert(money,0),
mca_saldo_mip_v          = convert(money,0),
mca_saldo_fng_v          = convert(money,0),
mca_seg_saldo_v          = convert(money,0),
mca_saldo_otr_v          = convert(money,0),
mca_saldo_v              = do_valor_mora,
mca_pag_cap              = convert(money,0),
mca_pag_int              = convert(money,0),
mca_pag_imo              = convert(money,0),
mca_pag_mip              = convert(money,0),
mca_pag_fng              = convert(money,0),
mca_pag_seg              = convert(money,0),
mca_pag_abog             = convert(money,0),
mca_pag_f_abog           = convert(datetime,null),
mca_pag_otr              = convert(money,0),
mca_pag_total            = convert(money,0),
mca_pag_rev              = convert(money,0),
mca_estado_car           = case when do_estado_cartera in (@w_est_cancelado,@w_est_castigado) then do_estado_cartera
                           when do_estado_cartera not in (@w_est_cancelado,@w_est_castigado) and do_dias_mora_365 <= 30  then 0
                           when do_estado_cartera not in (@w_est_cancelado,@w_est_castigado) and do_dias_mora_365 >= 31  and  do_dias_mora_365 <= 89  then 1
                           when do_estado_cartera not in (@w_est_cancelado,@w_est_castigado) and do_dias_mora_365 >= 90  and  do_dias_mora_365 <= 179 then 2 
						   when do_estado_cartera not in (@w_est_cancelado,@w_est_castigado) and do_dias_mora_365 >= 180 then do_estado_cartera 
                           end						   ,--convert(varchar(64),do_estado_cartera),
mca_estado_cob           = convert(varchar(64),''), 
mca_rango_mora           = convert(varchar(30),''),
mca_etapa_cobranza       = convert(varchar(10),''),
mca_fecha_exp            = convert(datetime,null),
mca_abogado_int          = convert(varchar(64),''),
mca_acuerdo_pag          = convert(varchar(10),'N'),
mca_num_acuer_pag        = convert(int,0),
mca_ult_fec_ac_pg        = convert(datetime,null),
mca_valor_acuerdo        = convert(money,null),
mca_tasa_int             = do_tasa_com,
mca_tasa_com             = convert(float,0),
mca_tasa_mor             = convert(float,0),
mca_nota                 = convert(tinyint,0),
mca_calif_temp           = convert(varchar(10),''),
mca_clase_cartera        = convert(varchar(64),do_clase_cartera),
mca_fecha_desem          = do_fecha_concesion,
mca_fecha_vencimiento    = do_fecha_vencimiento,
mca_fecha_otorga         = convert(datetime,null),
mca_num_cuotas           = do_num_cuotas,
mca_plazo_dias           = do_plazo_dias,
mca_plazo_mes            = do_plazo_dias/30.4,
mca_num_cuotaven         = do_num_cuotaven,
mca_toperacion           = do_tipo_operacion,
mca_valor_cuota          = do_valor_cuota,
mca_periodicidad         = do_periodicidad_cuota,
mca_prox_vto             = do_fecha_prox_vto,
mca_tipo_garantia        = do_tipo_garantias,
mca_saldo                = do_saldo,
mca_edad_mora            = do_dias_mora_365,
mca_valor_mora           = do_cap_vencido,
mca_fecha_ult_pago       = do_fecha_ult_pago,
mca_prov_cap             = do_prov_cap,
mca_prov_int             = do_prov_int,
mca_prov_cxc             = do_prov_cxc,
mca_prov_con_cap         = do_prov_con_cap,
mca_prov_con_int         = do_prov_con_int,
mca_prov_con_cxc         = do_prov_con_cxc,
mca_estado_contable      = do_estado_contable,
mca_calificacion         = do_calificacion,
mca_fecha_castigo        = do_fecha_castigo,
mca_num_acta             = do_num_acta,
mca_cuotas_pendietes     = do_num_cuotas - do_cuotas_pag,
mca_tipo_garantias       = do_tipo_garantias,
mca_valor_garantias      = do_valor_garantias,
mca_aplicativo           = do_aplicativo,
mca_op_lin_credito       = do_linea_credito,               --PGA
mca_consumo_cupo         = convert(money,0),               --PGA
mca_codres_colater       = convert(varchar(13),''),
mca_des_garantia         = convert(varchar(30),''),
mca_pago_x_recono        = convert(varchar(1),''),         --LCM
mca_fecha_recono         = convert(datetime,'01/01/1900'), --LCM
mca_vr_recono_recupera   = convert(money,0),               --LCM
mca_valor_amort          = convert(money,0),               --LCM
mca_subtipo_garantia     = convert(varchar(30),''),        --LCM
mca_3nivel_garantia      = convert(varchar(255),''),       --LCM
mca_des_gar_real         = convert(varchar(30),''),
mca_campana              = convert(int,0),
mca_campana_det          = convert(varchar(64),''),
mca_valor_recono         = convert(money,0),               --113336
mca_alianza              = convert(varchar(100),''),       --Req 353
mca_ciclo                = convert(varchar(3),isnull(do_numero_ciclos,0)),
mca_numero_integrantes   = convert(varchar(4),isnull(do_numero_integrantes,0)),
mca_buc                  = convert(varchar(20),''),
mca_cuenta               = do_cuenta,
mca_correo               = convert(varchar(254),''),
mca_valor_cat            = do_valor_cat,
mca_cuota_cap            = do_cuota_cap,
mca_cuota_int            = do_cuota_int,
mca_cuota_iva            = do_cuota_iva,
mca_capital_exigible     = convert(money,0),
mca_capital_exigible_ven = convert(money,0),
mca_cap_no_exigible_ven  = convert(money,0),
mca_com_saldo            = convert(money,0),
mca_int_devengado        = convert(money,0),
mca_int_suspendido       = convert(money,0),
mca_int_venc_exigible    = convert(money,0),
mca_capital_vigente      = convert(money,0),
mca_int_vigente          = convert(money,0),
mca_int_pry              =(case when do_tipo_operacion = 'REVOLVENTE' then do_saldo_int else do_valor_cuota*do_num_cuotas -do_monto  end),
mca_int_mora_pagado      = convert(money,0),
mca_int_pagado           = convert(money,0),
mca_iva_comision         = convert(money,0),
mca_int_vig_ex           = convert(money,0),
mca_int_vig_ne           = convert(money,0),
mca_int_ven              = convert(money,0),
mca_int_sus              = convert(money,0),
mca_vencimiento_hoy      = do_venc_dividendo,
mca_atraso_max           = convert(int,0),
mca_iva_int_ord_mora     = convert(money,0),
mca_imo_saldo            = convert(money,0),
mca_total_iva_exigible   = convert(money,0),
mca_cap_vig_ex           = convert(money,0),
mca_cap_ven_ex           = convert(money,0),
mca_cap_ven_ne           = convert(money,0),
mca_cap_vig_ne           = convert(money,0),
mca_com_pag              = convert(money,0),
mca_int_pag              = convert(money,0),
mca_iva_int_ex           = convert(money,0),
mca_iva_int_ne           = convert(money,0),
mca_iva_com_saldo        = convert(money,0),
mca_saldo_mora           = convert(money,0),
mca_saldo_real_ex        = convert(money,0),
mca_int_mora             = convert(money,0),
mca_saldo_real           = convert(money,0),
mca_saldo_prestamo       = convert(money,0),
mca_atraso_grupal        = do_atraso_grupal,
mca_fecha_ini_mora       = do_fecha_ini_mora,
mca_dia_pago             = do_dia_pago,
mca_plazo                = (select td_descripcion from cob_cartera..ca_tdividendo a  where a.td_factor = b.do_periodicidad_cuota),
mca_fecha_ult_status     = case when do_dias_mora_365 >= 90 then do_fecha_dividendo_ven else do_fecha end,  
mca_cartera_riesgo       = case when do_dias_mora_365 >= 03 then do_saldo_cap  else   0  end, 
mca_numero_ciclo_ind     = convert(int,0),
mca_correo_asesor        = convert(varchar(64), ''),
mca_telefono_asesor      = convert(varchar(64), ''),
mca_fecha_suspenso       = case when do_estado_cartera = convert(varchar,@w_est_vencido) then do_fecha_suspenso else isnull(do_fecha_ult_pago,do_fecha_concesion) end,  
mca_fecha_susp           = do_fecha_suspenso,
mca_porcentaje_reserva   = convert(float,0),--case when (isnull(do_saldo_cap, 0) + isnull(do_saldo_int, 0)) = 0 then 0 else (isnull(max(do_provision), 0) / (isnull(do_saldo_cap, 0) + isnull(do_saldo_int, 0)) * 100) end ,
mca_provision            = convert(money,0),--do_provision,
mca_fecha_aprob_tramite  = convert(datetime,null),
mca_subtipo_producto     = do_subtipo_producto,
mca_experiencia_cred     = convert(char(2), null),
mca_subproducto          = do_subproducto,
mca_status_tecnologico   = convert(varchar(100) ,null),
mca_fecha_dia_pago       = convert(datetime,null),
mca_fecha_min_vencimiento= do_fecha_dividendo_ven,
mca_r01                  = convert(varchar(64), ''), 
mca_r02                  = convert(varchar(64), ''),
mca_r03                  = convert(varchar(64), ''),
mca_r04                  = convert(varchar(64), ''),
mca_r05                  = convert(varchar(64), ''),
mca_r06                  = convert(varchar(64), ''),
mca_r07                  = convert(varchar(64), ''),
mca_r08                  = convert(varchar(64), ''),
mca_r09                  = convert(varchar(64), ''),
mca_r10                  = convert(varchar(64), ''),           
mca_r11                  = convert(varchar(64), ''),
mca_r12                  = convert(varchar(64), ''),
mca_r13                  = convert(varchar(64), ''),
mca_r14                  = convert(varchar(64), ''), 
mca_r15                  = convert(varchar(64), ''),
mca_r16                  = convert(varchar(64), ''),
mca_r17                  = convert(varchar(64), ''),
mca_r18                  = convert(varchar(64), ''),
mca_fecha_proceso        = do_fecha               ,
mca_imp_max_atraso       = do_cuota_max_vencida   ,
mca_folio_buro           = convert(varchar(64), null),
mca_atraso_max_ant       = convert(int,0)         ,
mca_atraso_max_act       = do_atraso_grupal       ,
mca_nivel_riesgo         = convert(char(1), null),
mca_puntaje_riesgo       = convert(char(3), null),
mca_rol_directiva        = convert(varchar(64), null),
mca_coordenadas_dom      = convert(varchar(100),null),
mca_ingreso_mensual      = convert(money, 0),
mca_gastos_negocio       = convert(money, 0),
mca_gastos_familiares    = convert(money, 0),
mca_otros_ingresos       = convert(money, 0),
mca_capacidad_pago       = convert(money, 0),
mca_num_emp_asesor       = convert(varchar(10), ''),
mca_num_emp_coord        = convert(varchar(10), ''),
mca_num_emp_gerente      = convert(varchar(10),''),
mca_dia_reunion			 = convert(varchar(10), ''),
mca_hora_reunion         = convert(varchar(10), ''),
mca_lim_credito_actual	 = convert(money, 0),
mca_saldo_disponible	 = convert(money, 0),
mca_tipo_mercado		 = convert(varchar(30),''),
mca_niv_cliente_colectivo = convert(varchar(30),''),
mca_valor_gar_liq		 = do_gar_liq_orig,
mca_estado				 = convert(varchar(30),CASE do_estado_cartera when 3 then 'CANCELADO' when 4 then 'CASTIGADO' else 'ACTIVO' end),
mca_dom_reunion          = convert(varchar(125), ''),
mca_coordenadas_neg      = convert(varchar(100),null),
mca_banco_padre          = do_banco_padre,
mca_referencia           = convert(varchar(250),''),
mca_login_asesor         = convert(varchar(64), ''),
mca_cargo_asesor         = convert(varchar(64), ''),
mca_renovacion_grupal    = isnull(do_renovacion_grupal,0),
mca_renovacion_ind       = isnull (do_renovacion_ind  ,0)

into #maestro_cartera
from cob_conta_super..sb_dato_operacion b 
where do_fecha      = @w_fecha
and   do_aplicativo = 7

--and   do_estado_cartera in (@w_est_vencido,@w_est_vigente,@w_est_castigado) --Para que muestre el corte a la fecha de todos los prestamos del mes sin importar el estado

if @@error <> 0 begin
   print 'Error en generacion de data base'
   return 1
end

create index idx1 on #maestro_cartera(mca_banco)
create index idx2 on #maestro_cartera(mca_cliente)





--CALCULO DE MAXIMO DE DIAS DE ATRASO CICLO ANTERIOR 
select distinct
grupo         = mca_grupo,
ciclo         = isnull(mca_ciclo,0) -1
into #grupos_ciclo
from #maestro_cartera
where mca_ciclo >= 2

SELECT ogrupo      = grupo, 
       dias_atraso = max(isnull(CASE WHEN datediff(dd, di_fecha_ven, di_fecha_can ) <= 0 THEN 0 ELSE datediff(dd, di_fecha_ven, di_fecha_can ) END, 0)),
       ociclo      = isnull(ciclo,0)
  into #atraso_anterior
  FROM #grupos_ciclo,
       cob_cartera..ca_ciclo,
       cob_cartera..ca_det_ciclo,
       cob_cartera..ca_dividendo
 WHERE ci_grupo = grupo
   AND ci_ciclo = ciclo
   AND ci_grupo = dc_grupo
   AND ci_ciclo = dc_ciclo_grupo 
   AND dc_operacion = di_operacion
 GROUP BY grupo, ciclo

update #maestro_cartera set 
mca_atraso_max_ant = dias_atraso 
from #atraso_anterior
where mca_grupo = ogrupo 
and   mca_ciclo = ociclo +1


----------------------------------------
--Actualizaciones Masivas
--------------------------

update #maestro_cartera set 
mca_doc_cliente         = en_rfc,
mca_curp                = convert(varchar(255),en_ced_ruc),
mca_tipo_doc            = 'CURP',
mca_genero              = p_sexo,
mca_edad                = datediff(yy,p_fecha_nac,@w_fecha) - case when (month(@w_fecha) * 100) + day(@w_fecha) < (month(p_fecha_nac) * 100) + day(p_fecha_nac) then 1 else 0 end,
mca_fecha_nac           = p_fecha_nac,
mca_nombre1             = UPPER(isnull(en_nombre,'')),
mca_nombre2             = UPPER(isnull(p_s_nombre,'')),
mca_apellido_paterno    = UPPER(isnull(p_p_apellido,'')),
mca_apellido_materno    = UPPER(isnull(p_s_apellido,'')),
mca_est_civil           = p_estado_civil,
mca_nivel_estudio       = p_nivel_estudio,
mca_buc                 = en_banco,
--mca_numero_ciclo_ind    = isnull(en_nro_ciclo,0),
mca_clave_act_econo     = (select min(nc_actividad_ec) from  cobis..cl_negocio_cliente where nc_ente  = mca_cliente and nc_estado_reg  ='V' and nc_actividad_ec is not null),
mca_experiencia_cred    =  ea_experiencia,
mca_status_tecnologico  = case upper(ea_tecnologico) when 'ALTO' then 'ALTAMENTE TECNOLOGICO' when  'MEDIO' then 'TECNOLOGICO' else 'NO TECNOLOGICO' end, 
mca_gastos_negocio      = isnull(ea_ct_operativo,0),
mca_gastos_familiares   = isnull(ea_ct_ventas,0),
mca_otros_ingresos      = isnull(ea_ventas,0),
mca_ingreso_mensual     = isnull(en_otros_ingresos,0),
mca_capacidad_pago      = ea_ventas + en_otros_ingresos - ea_ct_ventas - ea_ct_operativo,
mca_nivel_riesgo        = ea_nivel_riesgo_cg,
mca_puntaje_riesgo      = ea_puntaje_riesgo_cg
from cobis..cl_ente, cobis..cl_ente_aux
where en_ente = mca_cliente 
and   en_ente = ea_ente    

update #maestro_cartera 
set mca_numero_ciclo_ind    = isnull(dc_ciclo,0) ---caso#166473
from cob_cartera..ca_operacion, cob_cartera..ca_det_ciclo 
where mca_banco = op_banco
and op_operacion = dc_operacion


--Actualiza LCR
-----------------------
update #maestro_cartera set
mca_numero_ciclo_ind    = (select count(distinct(do_banco)) from sb_dato_operacion where do_codigo_cliente = mca_cliente and do_tipo_operacion='REVOLVENTE'),
mca_fecha_desem			= convert(datetime,(select isnull(max(dt_fecha_trans),mca_fecha_desem) from cob_conta_super..sb_dato_transaccion where dt_tipo_trans='DES' and dt_banco = mca_banco and dt_toperacion='REVOLVENTE')),
mca_lim_credito_actual	= (select do_monto_aprobado from sb_dato_operacion    where do_banco=mca_banco and do_fecha = @w_fecha),
mca_valor_gar_liq		= (select dc_valor_actual from cob_conta_super..sb_dato_custodia where dc_gl_tramite=mca_tramite and dc_fecha = @w_fecha)
from #maestro_cartera
where mca_toperacion = 'REVOLVENTE'
------------------------
                                    
update #maestro_cartera set                                
mca_act_economica   = isnull(ac_descripcion,' ') 
from cobis..cl_actividad_ec 
where mca_clave_act_econo= ac_codigo 

update #maestro_cartera set                                
mca_act_economica_corto = c.valor 
from cobis..cl_tabla t,cobis..cl_catalogo c
where t.tabla             = 'cl_actividad'
and   t.codigo            = c.tabla
and   mca_clave_act_econo = c.codigo

select distinct
di_cliente          = mca_cliente,
di_neg_telefono     = mca_tel_negocio,
di_neg_cod_dir      = convert(int,0),
di_neg_direccion    = mca_dir_negocio,
di_neg_cod_depar    = convert(int,-999),
di_neg_depar        = mca_dep_negocio,
di_neg_cod_ciu      = convert(int,0),
di_neg_ciudad       = mca_ciu_negocio,
di_neg_cod_bar      = convert(int,0),
di_neg_barrio       = mca_bar_negocio,
di_neg_cp           = convert(int,0),
di_dom_cod_tel      = convert(int,0),
di_dom_telefono     = mca_tel_cliente,
di_dom_cod_dir      = convert(int,0),
di_dom_direccion    = mca_dir_domicil,
di_dom_cod_depar    = convert(int,-999),
di_dom_depar        = mca_dep_domicil,
di_dom_cod_ciu      = convert(int,0),
di_dom_ciudad       = mca_ciu_domicil,
di_dom_cod_bar      = convert(int,0),
di_dom_barrio       = mca_bar_domicil,
di_dom_cp           = convert(int,0),
di_tlocal_negocio   = mca_tlocal_negocio,
di_tiempo_actividad = convert(int,0),
di_correo           = convert(varchar(255),''),
di_dom_latitud      = convert(float,0),
di_dom_longitud     = convert(float,0),
di_neg_latitud      = convert(float,0),
di_neg_longitud     = convert(float,0)
into #direcciones
from #maestro_cartera

create index idx1 on #direcciones(di_cliente)

--DATO DE APROBACION DEL WF
update #maestro_cartera set mca_fecha_sol  = isnull(ia_fecha_inicio,tr_fecha_crea)
from cob_workflow..wf_inst_proceso,cob_workflow..wf_inst_actividad,
cob_credito..cr_tramite_grupal,cob_credito..cr_tramite 
where ia_id_inst_proc = io_id_inst_proc
and   ia_codigo_act   = @w_codigo_ing_sol
and   io_campo_3      = tg_tramite
and   tg_prestamo     = mca_banco
and   tg_grupo        = mca_grupo
and   tg_tramite       = tr_tramite

update #maestro_cartera set mca_fecha_aprob_tramite =isnull(ia_fecha_fin ,tr_fecha_apr )
from cob_workflow..wf_inst_proceso,cob_workflow..wf_inst_actividad,
cob_credito..cr_tramite_grupal,cob_credito..cr_tramite 
where ia_id_inst_proc = io_id_inst_proc
and   ia_codigo_act   = @w_codigo_act_apr
and   io_campo_3      = tg_tramite
and   tg_prestamo     = mca_banco
and   tg_grupo        = mca_grupo
and   tg_tramite      = tr_tramite

update  #maestro_cartera set 
mca_fecha_sol           = isnull(mca_fecha_sol,tr_fecha_crea),
mca_fecha_aprob_tramite =isnull(mca_fecha_aprob_tramite ,tr_fecha_apr )
from cob_credito..cr_tramite
where mca_tramite = tr_tramite

update #direcciones set
di_neg_cod_dir     = di_direccion,
di_neg_direccion   =  rtrim(di_calle + case when di_nro <= 0 then '' else ' ' + convert(varchar(50),di_nro) end + case when  di_nro_interno <= 0 then ''  else ' - ' + convert(varchar(50),di_nro_interno) end),
di_neg_cod_ciu     = di_ciudad,
di_neg_cod_bar     = di_parroquia,
di_neg_cod_depar   = di_provincia,
di_neg_cp          = di_codpostal
from cobis..cl_direccion
where di_ente = di_cliente
and   di_tipo = 'AE' 
and   di_direccion=(SELECT min(di_direccion) FROM cobis..cl_direccion where di_ente = di_cliente
and   di_tipo = 'AE') --negocio

--ACTUALIZACION EN CASO DE NO EXISTIR DIRECCION NEGOCIO 

if exists(select 1 from #direcciones  where di_neg_cod_dir = 0 or di_neg_cod_dir is null)
begin

   update #direcciones set
   di_neg_cod_dir     = di_direccion,
   di_neg_direccion   =  rtrim(di_calle + case when di_nro <= 0 then '' else ' ' + convert(varchar(50),di_nro) end + case when  di_nro_interno <= 0 then ''  else ' - ' + convert(varchar(50),di_nro_interno) end),
   di_neg_cod_ciu     = di_ciudad,
   di_neg_cod_bar     = di_parroquia,
   di_neg_cod_depar   = di_provincia,
   di_neg_cp          = di_codpostal
   from cobis..cl_direccion
   where di_ente = di_cliente
   and   di_direccion=(SELECT min(di_direccion) FROM cobis..cl_direccion where di_ente = di_cliente and di_tipo not in ('CE')) --negocio
   and ( di_neg_cod_dir = 0 or di_neg_cod_dir is null)
end

update #direcciones 
set di_neg_direccion = ltrim(rtrim(replace(replace(replace(di_neg_direccion,':',''),'N.-',''),'.-','')))


update #direcciones set
di_dom_cod_dir     = di_direccion,
di_dom_direccion   = rtrim(di_calle + case when di_nro <= 0 then '' else ' ' + convert(varchar(50),di_nro) end + case when  di_nro_interno <= 0 then ''  else ' - ' + convert(varchar(50),di_nro_interno) end),
di_dom_cod_tel     = di_telefono,
di_dom_cod_ciu     = di_ciudad,
di_dom_cod_bar     = di_parroquia,
di_dom_cod_depar   = di_provincia,
di_dom_cp          = di_codpostal,
di_dom_latitud     = dg_lat_seg,
di_dom_longitud    = dg_long_seg
from cobis..cl_direccion, cobis..cl_direccion_geo
where di_ente = di_cliente
and   di_ente = dg_ente
and   di_tipo = 'RE'  
and   di_direccion=(SELECT min(di_direccion) FROM cobis..cl_direccion where di_ente = di_cliente
and   di_tipo = 'RE')--domicilio
and   di_direccion =  dg_direccion


--ACTUALIZACION EN CASO DE NO EXISTIR DIRECCION DOMICILIO 
if exists(select 1 from #direcciones  where di_dom_cod_dir = 0 or di_dom_cod_dir is null)
begin  
  
   update #direcciones set
   di_dom_cod_dir     = di_direccion,
   di_dom_direccion   = rtrim(di_calle + case when di_nro <= 0 then '' else ' ' + convert(varchar(50),di_nro) end + case when  di_nro_interno <= 0 then ''  else ' - ' + convert(varchar(50),di_nro_interno) end),
   di_dom_cod_tel     = di_telefono,
   di_dom_cod_ciu     = di_ciudad,
   di_dom_cod_bar     = di_parroquia,
   di_dom_cod_depar   = di_provincia,
   di_dom_cp          = di_codpostal
   from cobis..cl_direccion
   where di_ente = di_cliente
   and   di_direccion=(SELECT min(di_direccion) FROM cobis..cl_direccion where di_ente = di_cliente and di_tipo not in ('CE'))--domicilio
   and   (di_dom_cod_dir = 0 or di_dom_cod_dir is null)
end  

update #direcciones 
set di_dom_direccion = ltrim(rtrim(replace(replace(replace(di_dom_direccion,':',''),'N.-',''),'.-','')))

/*Localizacon geografica de Domicilio*/
update #direcciones SET 
di_dom_latitud     = isnull(dg_lat_seg,0),
di_dom_longitud    = isnull(dg_long_seg,0)
from cobis..cl_direccion, cobis..cl_direccion_geo
where di_ente = di_cliente
and   di_ente = dg_ente
and   di_tipo = 'RE'  
and   di_direccion=di_dom_cod_dir
and   di_direccion =  dg_direccion

-----SE AGREGA DATOS DE GEOLOCALIZACION DEL NEGOCIO
update #direcciones SET
di_neg_latitud     = isnull(dg_lat_seg,0),
di_neg_longitud    = isnull(dg_long_seg,0)
from cobis..cl_direccion, cobis..cl_direccion_geo
where di_ente = di_cliente
and   di_ente = dg_ente
and   di_tipo = 'AE'  
and   di_direccion=di_neg_cod_dir
and   di_direccion =  dg_direccion

/*TELEFONO*/
update #direcciones set
di_neg_telefono = case when te_prefijo <> '' then ltrim(rtrim(te_prefijo)) +'-'+ isnull(te_valor,0) else te_valor end 
from cobis..cl_telefono
where te_ente       = di_cliente
and   te_direccion  = di_neg_cod_dir

update #direcciones set
di_dom_telefono = case when te_prefijo <> '' then ltrim(rtrim(te_prefijo)) +'-'+ isnull(te_valor,0) else te_valor end 
from cobis..cl_telefono
where te_ente       = di_cliente
and   te_direccion  = di_dom_cod_dir

/*CIUDAD*/
update #direcciones set
di_neg_ciudad = ci_descripcion
from cobis..cl_ciudad
where ci_ciudad = di_neg_cod_ciu   --negocio

update #direcciones set
di_dom_ciudad = ci_descripcion
from cobis..cl_ciudad
where ci_ciudad = di_dom_cod_ciu   --domicilio


/*DEPARTAMENTO*/
update #direcciones set
di_neg_depar = pv_descripcion
from cobis..cl_provincia
where pv_provincia = di_neg_cod_depar   --negocio

update #direcciones set
di_dom_depar = pv_descripcion
from cobis..cl_provincia
where pv_provincia = di_dom_cod_depar   --domicilio


/*BARRIO*/
update #direcciones set
di_neg_barrio = pq_descripcion
from cobis..cl_parroquia
where pq_parroquia = di_neg_cod_bar   --negocio

update #direcciones set
di_dom_barrio = pq_descripcion
from cobis..cl_parroquia
where pq_parroquia = di_dom_cod_bar   --domicilio

--Datos del Negocio
update #direcciones set
di_tlocal_negocio   = nc_tipo_local
from cobis..cl_negocio_cliente
where di_cliente     = nc_ente
and   nc_estado_reg  = 'V'

if @@error <> 0 begin
   print 'Error Actualizando Datos de Negocio'
   return 1
end

--EXPERIENCIA ACT
update #direcciones set
di_tiempo_actividad = ea_nro_ciclo_oi
from cobis..cl_ente_aux
where di_cliente     = ea_ente

if @@error <> 0 begin
   print 'Error Actualizando Experiencia act'
   return 1
end

--Datos del Negocio
update #direcciones set
di_correo   = di_descripcion
from cobis..cl_direccion
where di_ente  = di_cliente
and   di_tipo  = 'CE'

if @@error <> 0 begin
   print 'Error Actualizando Datos de Negocio'
   return 1
end



/*ACTUALIZA LA MAESTRO DE CARTERA*/

--Datos de Direccion Negocio y Domicilio
update #maestro_cartera set
mca_tel_negocio    = di_neg_telefono,
mca_dir_negocio    = di_neg_direccion,
mca_dep_negocio    = di_neg_depar,
mca_ciu_negocio    = di_neg_ciudad,
mca_bar_negocio    = di_neg_barrio,
mca_cp_negocio     = di_neg_cp,
mca_tel_cliente    = di_dom_telefono,
mca_dir_domicil    = di_dom_direccion,
mca_dep_domicil    = di_dom_depar,
mca_ciu_domicil    = di_dom_ciudad,
mca_bar_domicil    = di_dom_barrio,
mca_cp_domicil     = di_dom_cp,
mca_tlocal_negocio = di_tlocal_negocio,
mca_experiencia    = di_tiempo_actividad,
mca_correo         = di_correo,
mca_coordenadas_dom= 'Latitud: '+ convert(nVARCHAR(32),str(di_dom_latitud , 15,10 ))+' Longitud: '+convert(nVARCHAR(32),str(di_dom_longitud, 15,10 )),
mca_coordenadas_neg= 'Latitud: '+ convert(nVARCHAR(32),str(di_neg_latitud , 15,10 ))+' Longitud: '+convert(nVARCHAR(32),str(di_neg_longitud, 15,10 ))
from #direcciones
where mca_cliente = di_cliente

if @@error <> 0 begin
   print 'Error Actualizando Datos de Negocio y Domicilio'
   return 1
end

--Datos del Conyuge
update #maestro_cartera
set  mca_cony_nombres  = isnull(en_nombre,'') + ' ' + isnull(p_s_nombre, '') + ' ' + isnull(p_p_apellido,'') + ' ' + isnull(p_s_apellido,''),
     mca_cony_doc      = en_ced_ruc,
     mca_cony_tipo_doc = (select c.valor
                          from cobis..cl_tabla t, cobis..cl_catalogo c
                          where t.tabla = 'cl_tipo_documento'
                          and   t.codigo= c.tabla
                          and   c.codigo= en_tipo_ced)
from cobis..cl_ente,
     cobis..cl_instancia ins
where in_ente_i   = mca_cliente
and   in_relacion = 209 --conyuge
and   in_ente_d   = en_ente

if @@error <> 0 begin
   print 'Error Actualizando Datos de Conyuge'
   return 1
end

--Division
update #maestro_cartera
set mca_division = upper(of_nombre)
from cobis..cl_oficina
where  of_oficina = mca_oficina

if @@error <> 0 begin
   print 'Error Actualizando Datos Division'
   return 1
end

update #maestro_cartera
set mca_division = ltrim(rtrim(replace(mca_division,'OFICINA','')))

if @@error <> 0 begin
   print 'Error Actualizando Datos Division'
   return 1
end


--Regional
update #maestro_cartera
set mca_region = (select A.of_nombre
                  from cobis..cl_oficina A, cobis..cl_oficina B
                  where A.of_oficina = B.of_regional
                  and   B.of_oficina = P.mca_oficina)
from  #maestro_cartera P

if @@error <> 0 begin
   print 'Error Actualizando Datos Regional'
   return 1
end

update #maestro_cartera
set mca_nombre_grupo = gr_nombre,
mca_dia_reunion = (case gr_dia_reunion when 1 then 'LUNES' when  2 then 'MARTES' when  3 then 'MIERCOLES' when  4 then 'JUEVES' when  5 then 'VIERNES' else '0' end),
mca_hora_reunion = (substring(convert(nvarchar(25),gr_hora_reunion,108),1,5)),
mca_dom_reunion  =  gr_dir_reunion
from cobis..cl_grupo
where gr_grupo = mca_grupo

if @@error <> 0 begin
   print 'Error Actualizando Nombre Grupo'
   return 1
end

update #maestro_cartera set 
mca_rol_directiva = c.valor
from cobis..cl_cliente_grupo,
cobis..cl_grupo,
cobis..cl_catalogo c,
cobis..cl_tabla t 
where gr_grupo=cg_grupo
and c.tabla=t.codigo
and t.tabla='cl_rol_grupo'
and c.codigo=cg_rol
and gr_estado='V'
and mca_cliente=cg_ente

print 'rol en mesa directiva'

update #maestro_cartera set 
mca_oficial_id   =  gr_oficial 
from cobis..cl_grupo 
where mca_grupo = gr_grupo

update  #maestro_cartera set 
mca_coordinador_id = fu_jefe,
mca_oficial        = fu_nombre,
mca_num_emp_asesor = fu_nomina,
mca_oficial_status = (select upper(valor) from cobis..cl_catalogo c, cobis..cl_tabla t  where t.tabla  = 'cl_estado_ser' and  t.codigo = c.tabla  and  c.codigo = f.fu_estado),                         
mca_correo_asesor  = (select top 1 mf_descripcion from cobis..cl_medios_funcio   where mf_funcionario = f.fu_funcionario and   mf_tipo = 0),
mca_telefono_asesor= (select top 1 mf_descripcion from cobis..cl_medios_funcio   where mf_funcionario = f.fu_funcionario and   mf_tipo = 3),
mca_login_asesor   = fu_login,
mca_cargo_asesor   = (select upper(cl.valor) 
                      from  cobis..cl_tabla t,cobis..cl_catalogo cl
							 where t.codigo=cl.tabla
							 and   t.tabla='cl_cargo'
							 and	cl.codigo=fu_cargo)
from cobis..cl_funcionario f
where fu_funcionario = mca_oficial_id  

update  #maestro_cartera set 
mca_gerente_id  = fu_jefe ,
mca_coordinador = fu_nombre,
mca_num_emp_coord = fu_nomina
from cobis..cl_funcionario 
where fu_funcionario = mca_coordinador_id  

update  #maestro_cartera set 
mca_gerente = fu_nombre,
mca_num_emp_gerente = fu_nomina
from cobis..cl_funcionario 
where fu_funcionario = mca_gerente_id  


----------------------------------------
--Datos Credito
----------------------------------------

update #maestro_cartera
set mca_dst_economico= tr_destino,
    mca_fecha_otorga  = tr_fecha_apr,
    mca_folio_buro    = tr_folio_buro
from cob_credito..cr_tramite
where tr_tramite = mca_tramite

if @@error <> 0 begin
   print 'Error Actualizando Datos Credito'
   return 1
end

------------------------------------------
--Actualizar descripciones de catalogos
------------------------------------------
update #maestro_cartera
set mca_est_civil = c.valor
from cobis..cl_tabla t,cobis..cl_catalogo c
where t.codigo      = c.tabla 
and   t.tabla       = 'cl_ecivil'
and   mca_est_civil = c.codigo

if @@error <> 0 begin
   print 'Error Actualizando cl_ecivil'
   return 1
end

update #maestro_cartera
set mca_nivel_estudio = c.valor
from cobis..cl_tabla t,cobis..cl_catalogo c
where t.codigo      = c.tabla 
and   t.tabla       = 'cl_nivel_estudio'
and   mca_nivel_estudio = c.codigo

if @@error <> 0 begin
   print 'Error Actualizando cl_nivel_estudio'
   return 1
end


update #maestro_cartera
set mca_dst_economico = c.valor
from cobis..cl_tabla t,cobis..cl_catalogo c
where t.codigo          = c.tabla
and   t.tabla           = 'cr_destino'
and   mca_dst_economico = c.codigo

if @@error <> 0 begin
   print 'Error Actualizando cr_destino'
   return 1
end

update #maestro_cartera
set mca_tlocal_negocio = c.valor
from cobis..cl_tabla t,cobis..cl_catalogo c
where t.codigo           = c.tabla
and   t.tabla            = 'cr_tipo_local'
and   mca_tlocal_negocio = c.codigo

if @@error <> 0 begin
   print 'Error Actualizando cr_tipo_local'
   return 1
end



select
dr_banco,
--CAPITALES
dr_cap_vig_ex    = sum(case when dr_categoria  = 'C'  and dr_estado =   @w_est_vigente  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
dr_cap_vig_ne    = sum(case when dr_categoria  = 'C'  and dr_estado =   @w_est_vigente  and dr_exigible   = 0 then  isnull(dr_valor,0) else 0 end ), 
dr_cap_ven_ex    = sum(case when dr_categoria  = 'C'  and dr_estado in (@w_est_vencido,@w_est_castigado)  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
dr_cap_ven_ne    = sum(case when dr_categoria  = 'C'  and dr_estado in (@w_est_vencido,@w_est_castigado)  and dr_exigible   = 0 then  isnull(dr_valor,0) else 0 end ), 
--INTERESES
dr_int_vig_ex    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vigente  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
dr_int_vig_ne    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vigente  and dr_exigible   = 0 then  isnull(dr_valor,0) else 0 end), 
dr_int_ven_ex    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vencido  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
dr_int_ven_ne    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vencido  and dr_exigible   = 0 then  isnull(dr_valor,0) else 0 end),
dr_int_sus_ex    = sum(case when dr_categoria  = 'I' and dr_estado in (@w_est_suspenso,@w_est_castigado) and dr_exigible   = 1   then  isnull(dr_valor,0) else 0 end ),
dr_int_sus_ne    = sum(case when dr_categoria  = 'I' and dr_estado in (@w_est_suspenso,@w_est_castigado) and dr_exigible   = 0   then  isnull(dr_valor,0) else 0 end ),
dr_int_pag       = sum(case when dr_categoria  = 'I' then  isnull(dr_pagado,0) else 0 end),
--IVAS
dr_iva_int_ex    = sum(case when dr_categoria  = 'A' and dr_cat_rub_aso  = 'I' and dr_exigible    = 1 then  isnull(dr_valor,0) else 0 end),
dr_iva_int_ne    = sum(case when dr_categoria  = 'A' and dr_cat_rub_aso  = 'I' and dr_exigible    = 0 then  isnull(dr_valor,0) else 0 end ),
--COMISIONES
dr_com_ex        = sum(case when dr_categoria  = 'O' and dr_exigible    = 1   then isnull(dr_valor,0) else 0 end),
dr_com_ne        = sum(case when dr_categoria  = 'O' and dr_exigible    = 0   then isnull(dr_valor,0) else 0 end),
dr_com_pag       = sum(case when dr_categoria  = 'O' then  isnull(dr_pagado,0) else 0 end), 
--IVA SOBRE COMISIONES 
dr_saldo_iva_com = sum(case when dr_categoria  = 'A' and  dr_cat_rub_aso  = 'O' then isnull(dr_valor,0) else 0 end),
--MORA 
dr_imo_saldo     = sum(case when dr_categoria  = 'M' then  isnull(dr_valor, 0) else 0 end),
dr_imo_pag       = sum(case when dr_categoria  = 'M' then  isnull(dr_pagado,0) else 0 end),
--SEGUROS
dr_seg_saldo     = sum(case when dr_categoria  = 'S' then  isnull(dr_valor, 0) else 0 end),
--SALDOS DEL PRESTAMO
dr_saldo_ex      = sum(case when dr_exigible   = 1   then  isnull(dr_valor, 0) else 0 end),
dr_saldo_prestamo= sum(isnull(dr_valor,0))
into #rubros
from #maestro_cartera, cob_conta_super..sb_dato_operacion_rubro
where dr_fecha      = @w_fecha
and   dr_aplicativo = 7
and   dr_banco      = mca_banco
group by dr_banco


update #maestro_cartera set 
--capitales 
mca_cap_vig_ex           = dr_cap_vig_ex,
mca_cap_ven_ex           = dr_cap_ven_ex,
mca_cap_ven_ne           = dr_cap_ven_ne,
mca_cap_vig_ne           = dr_cap_vig_ne,
mca_cap_saldo            = dr_cap_vig_ex + dr_cap_ven_ex + dr_cap_ven_ne + dr_cap_vig_ne,
--interes 
mca_int_vig_ex           = dr_int_vig_ex,
mca_int_vig_ne           = dr_int_vig_ne,
mca_int_ven              = dr_int_ven_ex + dr_int_ven_ne,
mca_int_sus              = dr_int_sus_ex + dr_int_sus_ne, 
mca_int_pag              = dr_int_pag,
mca_int_pry              = case when mca_toperacion = 'REVOLVENTE' then mca_int_pry 
                           else isnull(dr_int_vig_ex,0) + isnull(dr_int_vig_ne,0) + isnull(dr_int_ven_ex,0) + isnull(dr_int_ven_ne,0) + isnull(dr_int_sus_ex,0) + isnull(dr_int_sus_ne,0) + isnull(dr_int_pag,0) end,
mca_int_mora             = dr_int_vig_ex + dr_int_ven_ex + dr_int_sus_ex,
mca_int_saldo            = dr_int_vig_ex + dr_int_vig_ne  + dr_int_ven_ex + dr_int_ven_ne + dr_int_sus_ex +dr_int_sus_ne,
--iva sobre interes 
mca_iva_int_ex           = dr_iva_int_ex,
mca_iva_int_ne           = dr_iva_int_ne,
--comisiones 
mca_com_saldo            = dr_com_ex + dr_com_ne,
mca_com_pag              = dr_com_pag            ,
--ivas sobre com
mca_iva_com_saldo        = dr_saldo_iva_com,
--mora         
mca_imo_saldo            = dr_imo_saldo,
--seguros 
mca_seg_saldo            =dr_seg_saldo,	
 --saldo real exigible    
mca_saldo_real_ex        = dr_saldo_ex,
mca_saldo_prestamo       = dr_saldo_prestamo
from #rubros
where mca_banco          = dr_banco

--Se Actualiza el saldo disponible para las operaciones REVOLVENTES
update #maestro_cartera set
mca_saldo_disponible    = mca_lim_credito_actual - mca_cap_saldo
from #maestro_cartera
where mca_toperacion = 'REVOLVENTE'

--campos de buro
---Folio BURO

select 
cliente   = ib_cliente ,
max_fecha = max(ib_fecha)
into #fecha_buro 
from #maestro_cartera, cob_credito..cr_interface_buro
where mca_cliente = ib_cliente 
and   ib_estado = 'V'
group by ib_cliente

update #maestro_cartera set 
mca_folio_buro    = ib_folio
from cob_credito..cr_interface_buro
where mca_cliente = ib_cliente
and   ib_estado  = 'V'
and   ib_folio   is not null
and   mca_folio_buro is null


---consulta experiencia _creditica  se usa el programa de la variable Exp Crediticia

/********************************************
select @w_ente_aux = 0
while (1=1) begin 

   select top 1 @w_ente_aux = mca_cliente from #maestro_cartera
   where mca_cliente > @w_ente_aux
   order by mca_cliente asc
   if @@rowcount = 0 break 
   
   exec cob_credito..sp_var_experiencia_crediticia
   @i_id_cliente   =   @w_ente_aux,
   @o_resultado    =   @w_exp_credit output
   
   update #maestro_cartera set 
   mca_experiencia_cred = (case @w_exp_credit when 'S' then 'SI' else 'NO' end )
   where mca_cliente = @w_ente_aux

end 
*****************************/

update #maestro_cartera set 
mca_experiencia_cred = (case ea_experiencia when 'S' then 'SI' else 'NO' end )
FROM cobis..cl_ente_aux
where mca_cliente = ea_ente

 --Paso de datos a tabla formato reporte
----------------------------------------

select 
cliente = dv_cliente, 
fecha   = max(dv_fecha)
into #respuestas 
from #maestro_cartera, sb_dato_verificacion
where mca_cliente = dv_cliente
group by dv_cliente   

update #maestro_cartera set  
mca_r01 = dv_r01,
mca_r02 = dv_r02,
mca_r03 = dv_r03,
mca_r04 = dv_r04,
mca_r05 = dv_r05,
mca_r06 = dv_r06,
mca_r07 = dv_r07,
mca_r08 = dv_r08,
mca_r09 = dv_r09,
mca_r10 = dv_r10,
mca_r11 = dv_r11,
mca_r12 = dv_r12,
mca_r13 = dv_r13,
mca_r14 = dv_r14,
mca_r15 = dv_r15,
mca_r16 = dv_r16,
mca_r17 = dv_r17
from #respuestas,sb_dato_verificacion ,#maestro_cartera  
where  cliente       = dv_cliente  
and    mca_cliente   = cliente   
and    fecha         = dv_fecha 

/** Consultar los pagos Fallecido y actualizar el estado de cartera ***/
	update #maestro_cartera 
	set mca_estado_car = 9
	from #maestro_cartera ,cob_conta_super..sb_dato_transaccion_det
	where dd_fecha = (select max(dd_fecha) from cob_conta_super..sb_dato_transaccion_det where dd_banco = rtrim(mca_banco))
	and dd_secuencial = (select max(dd_secuencial) from cob_conta_super..sb_dato_transaccion_det where dd_banco = rtrim(mca_banco))
	and dd_banco = rtrim(mca_banco)  
	and dd_concepto = 'FALLECIDO'

update #maestro_cartera set 
mca_estado = 'ACTIVO SIN SALDO'
where mca_toperacion = 'REVOLVENTE'
and  mca_fecha_vencimiento>@w_fecha and mca_estado_car=3

update #maestro_cartera set 
mca_estado = 'ACTIVO SIN SALDO'
where mca_toperacion = 'REVOLVENTE'
and mca_saldo =0 and mca_fecha_proceso<mca_fecha_vencimiento

update #maestro_cartera set 
mca_estado = 'CANCELADO'
where mca_toperacion = 'REVOLVENTE' and mca_saldo=0 and mca_fecha_vencimiento<mca_fecha_proceso

	update #maestro_cartera 
	set mca_referencia = di_referencia
	from #maestro_cartera ,cobis..cl_direccion
	where di_ente = mca_cliente
	and di_principal = 'S'

update #maestro_cartera set 
mca_tipo_mercado        = (select valor
                           from cobis..cl_tabla t,
                           cobis..cl_catalogo c
                           where t.tabla = 'cl_tipo_mercado'
                           and   t.codigo = c.tabla
                           and   c.codigo = ea_colectivo),
mca_niv_cliente_colectivo = (select valor
                           from cobis..cl_tabla t,
                           cobis..cl_catalogo c
                           where t.tabla = 'cl_nivel_cliente_colectivo'
                           and   t.codigo = c.tabla
                           and   c.codigo = ea_nivel_colectivo)
from cobis..cl_ente,
     cobis..cl_ente_aux
where en_ente = mca_cliente 
and   en_ente = ea_ente 
 
 
--------------------------------
/* ENTRAR BORRANDO LA TABLA DE TRABAJO */
if not object_id('sb_reporte_operativo') is null drop table sb_reporte_operativo

select 
'OFICINA'                        = isnull(mca_division,' '),                             
'REGION'                         = isnull(mca_region,' '),                               
'CC'                             = isnull(mca_oficina,0),                                
'CONTRATO'                       = isnull(mca_banco,' '),                                  
'ID GRUPO'                       = isnull(mca_grupo,0),                                  
'NOMBRE GRUPO'                   = isnull(mca_nombre_grupo,' '),                         
'CICLO GRUPAL '                  = isnull(mca_ciclo,' '),                        
'NUMERO DE INTEGRANTES'          = isnull(mca_numero_integrantes, 0),                    
'RFC'                            = isnull(mca_doc_cliente,' '),                         
'CURP'                           = isnull(mca_curp,' '),                                 
'CLIENTE COBIS'                  = isnull(mca_cliente,0),                             
'BUC'                            = isnull(mca_buc,' '),                                  
'FOLIO CONSULTA BURO'            = isnull(mca_folio_buro,' '),                                                                              
'APELLIDO PATERNO'               = isnull(mca_apellido_paterno,' '),                    
'APELLIDO MATERNO'               = isnull(mca_apellido_materno,' '),                     
'NOMBRE1'                        = isnull(mca_nombre1,' '),                              
'NOMBRE2'                        = isnull(mca_nombre2,' '),                              
'EXPERIENCIA CREDITICIA'         = isnull(mca_experiencia_cred,' '),                                                             
'EXPERIENCIA ACT'                = isnull(mca_experiencia,' '),                          
'SUBPRODUCTO CUENTA DEPOSITO'    = isnull(mca_subproducto,' '),                                                       
'CUENTA DEPOSITO'                = isnull(mca_cuenta, ' '),                                                                            
'CICLO INDIVIDUAL'               = isnull(mca_numero_ciclo_ind,0),
'GENERO'                         = isnull(mca_genero,' '),                                       
'EDAD'                           = isnull(mca_edad,0),                                           
'FECHA NACIMIENTO'               = isnull(convert(varchar,mca_fecha_nac,@w_formato_fecha),' '),  
'DOM_TELEFONO'                   = isnull(mca_tel_cliente,' '),                                  
'DOM_DIRECCION'                  = isnull(mca_dir_domicil,' '),                         
'ESTADO'                         = isnull(mca_dep_domicil,' '),
'MUNICIPIO'                      = isnull(mca_ciu_domicil,' '),
'LOCALIDAD'                      = isnull(mca_bar_domicil,' '),                           
'C.P.'                           = isnull(mca_cp_domicil,0),
'NEG_TELEFONO'                   = isnull(mca_tel_negocio,' '),
'NEG_DIRECCION'                  = isnull(mca_dir_negocio,' '),
'NEG_ESTADO'                     = isnull(mca_dep_negocio,' '),
'NEG_MUNICIPIO'                  = isnull(mca_ciu_negocio,' '),
'NEG_LOCALIDAD'                  = isnull(mca_bar_negocio,' '),
'NEG_CP'                         = isnull(mca_cp_negocio,0),
'NEG_TIPO DE LOCAL'              = isnull(mca_tlocal_negocio,' '),
'ESCOLARIDAD'                    = isnull(mca_nivel_estudio,' '),
'CLAVE ACTIVIDAD ECON'           = isnull(mca_clave_act_econo, ' '), 
'ACTIVIDAD ECONOMICA'            = isnull(mca_act_economica,' '),
'NOMBRE CORTO ACT'               = isnull(mca_act_economica_corto, ' '),
'CORREO ELECTRONICO DEL CLIENTE' = isnull(mca_correo,''),
'ESTADO CIVIL'                   = isnull(mca_est_civil,' '),
'NOMBRE CONYUGE'                 = isnull(mca_cony_nombres,' '),
'TIPO DOC CONYUGE'               = isnull(mca_cony_tipo_doc,' '),
'DOCUMENTO CONYUGE'              = isnull(mca_cony_doc,' '),
'DESTINO DEL CREDITO'            = isnull(mca_dst_economico,' '),
'NOMBRE GERENTE'                 = isnull(mca_gerente,' '),
'NOMBRE COORDINADOR'             = isnull(mca_coordinador,' '),
'NOMBRE DEL ASESOR'              = isnull(mca_oficial,' '),
'CORREO ELECTRONICO ASESOR'      = isnull(mca_correo_asesor, ' '),
'TELEFONO DEL ASESOR'            = isnull(mca_telefono_asesor, ' '),
'ESTATUS ASESOR'                 = isnull(mca_oficial_status,' '),
'PRODUCTO DE PRESTAMOS'          = isnull(mca_toperacion,' '),
'SUBPRODUCTO PRESTAMO'           = isnull(mca_subtipo_producto, ' ' ),
'MONTO CREDITO'                  = isnull(round(mca_monto,2),0),
'FECHA SOLICITUD'            = isnull(convert(varchar,mca_fecha_sol,@w_formato_fecha),' '),
'FECHA APROBACION MONTOS'        = isnull(convert(varchar,mca_fecha_aprob_tramite,@w_formato_fecha),' '),
'FECHA DESEMBOLSO'               = isnull(convert(varchar,mca_fecha_desem,@w_formato_fecha),' '),
'FECHA VENCIMIENTO PRESTAMO'     = isnull(convert(varchar,mca_fecha_vencimiento,@w_formato_fecha),' '),
'NUMERO DE CONTRATO'             = isnull(mca_banco,' '),
'PLAZO'                          = isnull(mca_plazo, ' '),
'NUMERO CUOTAS'                  = isnull(mca_num_cuotas,0),
'DIA DE PAGO'                    = isnull(mca_dia_pago,' '),
'PLAZO DIAS'                     = isnull(mca_plazo_dias,0),
'PLAZO MES'                      = isnull(mca_plazo_mes,0),
'VALOR CUOTA'                    = isnull(round(mca_valor_cuota,2),0),
'CAPITAL DE LA CUOTA'            = isnull(mca_cuota_cap,0),
'INTERESES DE LA CUOTA'          = isnull(mca_cuota_int,0),            
'IVA DE LA CUOTA'                = isnull(mca_cuota_iva,0),            
'FECHA PROX. CUOTA'              = isnull(convert(varchar,mca_prox_vto,@w_formato_fecha),' '),
'CAT'                            = isnull(mca_valor_cat,0),
'TASA INTERES (ANUAL)'           = isnull(mca_tasa_int,0),--
'ESTATUS DEL CREDITO'            = isnull(mca_estado,' '),
'ESTADO CARTERA'                 = isnull(mca_estado_car,0),
'CUOTAS PENDIENTES'              = isnull(mca_cuotas_pendietes,0),--
'CUOTAS VENCIDAS'                = isnull(mca_num_cuotaven,0),--
'CAPITAL VIGENTE EXIGIBLE'       = isnull(round(mca_cap_vig_ex,2),0),
'CAPITAL VENCIDO EXIGIBLE'       = isnull(round(mca_cap_ven_ex,2),0),
'CAPITAL VENCIDO NO EXIGIBLE'    = isnull(round(mca_cap_ven_ne,2),0),
'CAPITAL VIGENTE NO EXIGIBLE'    = isnull(round(mca_cap_vig_ne,2),0),
'SALDO CAP'                      = isnull(round(mca_cap_saldo,2),0),
'INTERES VIGENTE EXIGIBLE'       = isnull(round(mca_int_vig_ex,2),0),
'INTERES VIGENTE NO EXIGIBLE'    = isnull(round(mca_int_vig_ne,2),0),
'INTERES VENCIDO'                = isnull(round(mca_int_ven,2),0),
'INTERES SUSPENDIDO'             = isnull(round(mca_int_sus,2),0),
'TOTAL INTERES PROYECTADOS'      = isnull(round(mca_int_pry,2),0), 
'TOTAL COMISIONES MORA PAGADAS'  = isnull(round(mca_com_pag,2),0),
'TOTAL INTERES NORMAL PAGADO'    = isnull(round(mca_int_pag,2),0),
'IVA INTERES EXIGIBLE'           = isnull(round(mca_iva_int_ex,2),0),
'IVA INTERES NO EXIGIBLE'        = isnull(round(mca_iva_int_ne,2),0),
'COMISIONES'                     = isnull(round(mca_com_saldo,2),0),
'IVA COMISION'                   = isnull(round(mca_iva_com_saldo,2),0),
'SALDO INTERESES'                = isnull(round(mca_int_saldo,2),0),
'SALDO INT MORA'                 = isnull(round(mca_imo_saldo,2),0),
'SALDO REAL EXIGIBLE'            = isnull(round(mca_saldo_real_ex,2),0),
'SALDO SEG'                      = isnull(round(mca_seg_saldo,2),0),
'SALDO TOTAL'                    = isnull(round(mca_saldo_real_ex,2),0),
'SALDO TOTAL EN MORA'            = isnull(round(mca_int_mora,2),0),
'IMPORTE LIQUIDA CON'            = isnull(round(mca_saldo_prestamo,2),0),
'DIAS MAX ATRASO ANT'            = isnull(mca_atraso_max_ant,0),
'DIAS MAX ATRASO ACT'            = (case when isnull(mca_atraso_max_act,0)  < 0 then 0 else isnull(mca_atraso_max_act,0) end ),
'IMPORTE MAX ATRASO'             = isnull(round(mca_imp_max_atraso,2),0),
'SEMANAS DE ATRASO'              = isnull(mca_edad_mora,0)/7,
'DIAS MORA'                      = isnull(mca_edad_mora,0),
'FECHA RECIBO ANTIGUO IMP'       = isnull(convert(varchar,mca_fecha_min_vencimiento,@w_formato_fecha),' '),
'FECHA ULTIMA SITUACION DEUDA'   = isnull(convert(varchar,mca_fecha_suspenso,@w_formato_fecha),' '),
'FECHA ULT ESTATUS CREDITO'      = isnull(convert(varchar,mca_fecha_ult_status,@w_formato_fecha),' '),
'PORCENTAJE RESERVA'             = isnull(round(mca_porcentaje_reserva,2),0),
'CARTERA EN RIESGO'              = isnull(mca_cartera_riesgo,0),
'CSTN RESP1'                     = isnull(mca_r01,''),
'CSTN RESP2'                     = isnull(mca_r02,''),
'CSTN RESP3'                     = isnull(mca_r03,''),
'CSTN RESP4'                     = isnull(mca_r04,''),
'CSTN RESP5'                     = isnull(mca_r05,''),
'CSTN RESP6'                     = isnull(mca_r06,''),
'CSTN RESP7'                     = isnull(mca_r07,''),
'CSTN RESP8'                     = isnull(mca_r08,''),
'CSTN RESP9'                     = isnull(mca_r09,''),
'CSTN RESP10'                    = isnull(mca_r10,''),
'CSTN RESP11'                    = isnull(mca_r11,''),
'CSTN RESP12'                    = isnull(mca_r12,''),
'CSTN RESP13'                    = isnull(mca_r13,''),
'CSTN RESP14'                    = isnull(mca_r14,''),
'CSTN RESP15'                    = isnull(mca_r15,''),
'CSTN RESP16'                    = isnull(mca_r16,''),
'CSTN RESP17'                    = isnull(mca_r17,''),
'ESTATUS TECNOLOGICO'            = isnull(mca_status_tecnologico,' '),
'NIVEL DE RIESGO'                = isnull(mca_nivel_riesgo,' '),
'PUNTAJE DE RIESGO'              = isnull(mca_puntaje_riesgo,0),
'ROL MESA DIRECTIVA'             = isnull(mca_rol_directiva,' '),
'COORDENADAS DOMICILIO'          = isnull(mca_coordenadas_dom,' '),
'INGRESO MENSUAL'                = isnull(mca_ingreso_mensual,0),
'GASTOS MENSUALES NEGOCIO'       = isnull(mca_gastos_negocio,0),
'GASTOS MENSUALES FAMILIARES'    = isnull(mca_gastos_familiares,0),
'OTROS INGRESOS'                 = isnull(mca_otros_ingresos,0),
'CAPACIDAD DE PAGO'              = isnull(mca_capacidad_pago,0),
'NUMERO DE EMPLEADO DEL ASESOR'      = isnull(mca_num_emp_asesor,''),
'NUMERO DE EMPLEADO DEL COORDINADOR' = isnull(mca_num_emp_coord,''),
'NUMERO DE EMPLEADO DEL GERENTE'     = isnull(mca_num_emp_gerente,''),
'DIA DE REUNION SEMANAL'             = isnull(mca_dia_reunion,''),
'HORA DE REUNION SEMANAL'            = isnull(mca_hora_reunion,''),
'LIMITE DE CREDITO ACTUAL'			 = isnull(mca_lim_credito_actual,0),
'SALDO DISPONIBLE'					 = isnull(mca_saldo_disponible,0),
'TIPO DE MERCADO'					 = isnull(mca_tipo_mercado,''),
'NIVEL CLIENTE EN COLECTIVO'		 = isnull(mca_niv_cliente_colectivo,''),
'VALOR DISPONIBLE GARANTIAS'		 = isnull(mca_valor_gar_liq,0),
'INDICADOR DE REUNION'               = isnull(mca_dom_reunion,''),
'COORDENADAS NEGOCIO'                = isnull(mca_coordenadas_neg,''),
'NRO OPERACION GRUPAL'               = isnull(mca_banco_padre,''),
'REFERENCIA'                		 = isnull(mca_referencia,''),
'RENOVACION GRUPAL'                  = isnull(mca_renovacion_grupal,0),
'RENOVACION INDIVIDUAL'              = isnull(mca_renovacion_ind,0)
into sb_reporte_operativo
from #maestro_cartera


----------------------------------------
--Generar Archivo Plano
----------------------------------------
select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

select @w_path = ba_path_destino
from cobis..ba_batch
where ba_batch = @w_batch

select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_conta_super..sb_reporte_operativo out '

select @w_destino  = @w_path + 'repoperativo_' + replace(convert(varchar, @w_fecha, 102), '.', '') + '_' + replace(convert(varchar, getdate(), 108), ':', '') + '.txt',
       @w_destino2 = @w_path + 'lineas_'      + replace(convert(varchar, @w_fecha, 102), '.', '') + '_' + replace(convert(varchar, getdate(), 108), ':', '') + '.txt',
       @w_errores  = @w_path + 'repoperativo_' + replace(convert(varchar, @w_fecha, 102), '.', '') + '_' + replace(convert(varchar, getdate(), 108), ':', '') + '.err'

select @w_comando = @w_cmd + @w_path + 'repoperativo -b5000 -c -T -e ' + @w_errores + ' -t"\t" ' + '-config ' + @w_s_app + 's_app.ini'

print 'COMANDO 1: ' + @w_comando

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print 'Error generando Reporte Operativo de Cartera'
   print @w_comando
   return 1
end


----------------------------------------
-- Lineas Plano
----------------------------------------

select @w_lineas = convert(varchar,isnull(count(1),0)) from cob_conta_super..sb_reporte_operativo
select @w_comando = 'echo ' + @w_lineas + ' > ' + @w_destino2

print 'COMANDO 2: ' + @w_comando

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print 'Error generando Archivo de Lineas'
   print @w_comando
   return 1
end

----------------------------------------
--Generar Archivo de Cabeceras
----------------------------------------
select @w_col_id   = 0,
       @w_columna  = '',
       @w_cabecera = ''
       
while 1 = 1 begin
   set rowcount 1
   select @w_columna = c.name,
          @w_col_id  = c.colid
   from sysobjects o, syscolumns c
   where o.id    = c.id
   and   o.name  = 'sb_reporte_operativo'
   and   c.colid > @w_col_id
   order by c.colid
    
   if @@rowcount = 0 begin
      set rowcount 0
      break
   end

   select @w_cabecera = @w_cabecera + @w_columna + char(9)
end
--Escribir Cabecera
select @w_comando = 'echo ' + @w_cabecera + ' > ' + @w_destino2

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print 'Error generando Archivo de Cabeceras'
   print @w_comando
   return 1
end

select @w_comando = 'copy ' + @w_destino2 + ' + ' + @w_destino + ' ' + @w_destino2

print 'COMANDO 3: ' + @w_comando

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print 'Error generando Archivo de Lineas mas cabeceras'
   print @w_comando
   return 1
end

select @w_comando = 'copy ' + @w_destino2 + ' + ' + @w_path + 'repoperativo ' + @w_destino

print 'COMANDO 4: ' + @w_comando

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print 'Error Agregando Cabeceras'
   print @w_comando
   return 1
end

-----REPORTE DE INICIO DE DIA DE COBRANZA 
--Reporte operativo para Mc Collect

/* ENTRAR BORRANDO LA TABLA DE TRABAJO */
--LLENADO CABECERA


--INICIANDO REQUERIMIENTO 142301
-----------------------------------------------------------------------------------------
update #maestro_cartera 
set    mca_fecha_sol   = ' ',
       mca_dom_reunion = '0'

-- ACTUALIZA LUGAR DE REUNION
update #maestro_cartera
set    mca_dom_reunion = (case gr_lugar_reunion when 'DT' then '2' when 'OT' then '1' else '0' end)
from   cobis..cl_grupo
where  gr_grupo = mca_grupo

truncate table  cob_conta_super..sb_rep_oper_mc_collect

insert into cob_conta_super..sb_rep_oper_mc_collect	(
OFICINA,                              REGION,                             CC,                                   CONTRATO,                           [ID GRUPO],                     --5                      
[NOMBRE GRUPO],                       [CICLO GRUPAL],                     [NUMERO DE INTEGRANTES],              RFC,                                CURP,                           --10        
[CLIENTE COBIS],                      [APELLIDO PATERNO],                 [APELLIDO MATERNO],                   NOMBRE1,                            NOMBRE2,                        --15        
[CICLO INDIVIDUAL],                   GENERO,                             EDAD,                                 DOM_TELEFONO,                       DOM_DIRECCION,                  --20        
ESTADO,                               MUNICIPIO,                          LOCALIDAD,                            [C.P.],                             [COORDENADAS DOMICILIO],        --25        
NEG_TELEFONO,                         NEG_DIRECCION,                      NEG_ESTADO,                           NEG_MUNICIPIO,                      NEG_LOCALIDAD,                  --30       
NEG_CP,                               [NEG_TIPO DE LOCAL],                [ACTIVIDAD ECONOMICA],                [CORREO ELECTRONICO DEL CLIENTE],   [NOMBRE GERENTE],               --35        
[NOMBRE COORDINADOR],                 [NOMBRE DEL ASESOR],                [CORREO ELECTRONICO ASESOR],          [TELEFONO DEL ASESOR],              [ESTATUS ASESOR],               --40        
[PRODUCTO DE PRESTAMOS],              [SUBPRODUCTO PRESTAMO],             [MONTO CREDITO],                      [FECHA SOLICITUD],                  [FECHA APROBACION MONTOS],      --45        
[FECHA VENCIMIENTO PRESTAMO],         [NUMERO DE CONTRATO],               PLAZO,                                [NUMERO CUOTAS],                    [DIA DE PAGO],                  --50        
[PLAZO DIAS],                         [PLAZO MES],                        [VALOR CUOTA],                        [CAPITAL DE LA CUOTA],              [INTERESES DE LA CUOTA],        --55        
[IVA DE LA CUOTA],                    [TASA INTERES (ANUAL)],             [CUOTAS PENDIENTES],                  [CUOTAS VENCIDAS],                  [CAPITAL VIGENTE EXIGIBLE],     --60        
[CAPITAL VENCIDO EXIGIBLE],           [SALDO CAP],                        [INTERES VIGENTE EXIGIBLE],           [INTERES SUSPENDIDO],               [IVA INTERES EXIGIBLE],         --65        
[IVA INTERES NO EXIGIBLE],            COMISIONES,                         [IVA COMISION],                       [SALDO INTERESES],                  [SALDO REAL EXIGIBLE],          --70       
[SALDO TOTAL],                        [SALDO TOTAL EN MORA],              [IMPORTE LIQUIDA CON],                [DIAS MAX ATRASO ACT],              [SEMANAS DE ATRASO],            --75      
[DIAS MORA],                          [FECHA RECIBO ANTIGUO IMP],         [FECHA ULTIMA SITUACION DEUDA],       [PORCENTAJE RESERVA],               [CARTERA EN RIESGO],            --80        
[NIVEL DE RIESGO],                    [PUNTAJE DE RIESGO],                [ROL MESA DIRECTIVA],                 [INDICADOR DE REUNION],             [NUMERO DE EMPLEADO DEL ASESOR],--85      
[NUMERO DE EMPLEADO DEL COORDINADOR], [NUMERO DE EMPLEADO DEL GERENTE],   [DIA DE REUNION SEMANAL],             [HORA DE REUNION SEMANAL],          [COORDENADAS NEGOCIO],          --90      
[NRO OPERACION GRUPAL],               [NVO DOM_DIRECCION],                [NVO ESTADO],                         [NVO MUNICIPIO],                    [NVO LOCALIDAD],                --95      
[NVO C.P.],                           [NVAS COORDENADAS DOM],             [Foto del Domicilio],                 [Entre calle 1 Dom],                [Entre calle 2 Dom],            --100      
[Entre calle 3 Dom],                  [Entre calle 4 Dom],                [Foto del Negocio],                   [Foto del Negocio 2],               [Entre calle 1 Neg],            --105      
[Entre calle 2 Neg],                  [Entre calle 3 Neg],                [Entre calle 4 Neg],                  [Foto del Domicilio Alterno],       [Entre calle 1 Dom Alterno],    --110      
[Entre calle 2 Dom Alterno],          [Entre calle 3 Dom Alterno],        [Entre calle 4 Dom Alterno],          asesor_login_mc,                    asesor_cargo_mc,                --115 
fecha_prox_couta_mc,                  [NUMERO_CUOTA],                     [MONTO_GARANTIA],                     [ESTADO_CREDITO]
	)
select 
'OFICINA',                           'REGION' ,                           'CC',                                'CONTRATO',                          'ID GRUPO',                     --5                     
'NOMBRE GRUPO',                      'CICLO GRUPAL',                      'NUMERO DE INTEGRANTES',             'RFC',                               'CURP',                         --10             
'CLIENTE COBIS',                     'APELLIDO PATERNO',                  'APELLIDO MATERNO',                  'NOMBRE1',                           'NOMBRE2',                      --15             
'CICLO INDIVIDUAL',                  'GENERO',                            'EDAD',                              'DOM_TELEFONO',                      'DOM_DIRECCION',                --20             
'ESTADO',                            'MUNICIPIO',                         'LOCALIDAD',                         'C.P.',                              'COORDENADAS DOMICILIO',        --25             
'NEG_TELEFONO',                      'NEG_DIRECCION',                     'NEG_ESTADO',                        'NEG_MUNICIPIO',                     'NEG_LOCALIDAD',                --30             
'NEG_CP',                            'NEG_TIPO DE LOCAL',                 'ACTIVIDAD ECONOMICA',               'CORREO ELECTRONICO DEL CLIENTE',    'NOMBRE GERENTE',               --35             
'NOMBRE COORDINADOR',                'NOMBRE DEL ASESOR',                 'CORREO ELECTRONICO ASESOR',         'TELEFONO DEL ASESOR',               'ESTATUS ASESOR',               --40             
'PRODUCTO DE PRESTAMOS',             'SUBPRODUCTO PRESTAMO',              'MONTO CREDITO',                     'FECHA DE DESEMBOLSO',               'FECHA APROBACION MONTOS',      --45           
'FECHA VENCIMIENTO PRESTAMO',        'NUMERO DE CONTRATO',                'PLAZO',                             'NUMERO CUOTAS',                     'DIA DE PAGO',                  --50           
'PLAZO DIAS',                        'PLAZO MES',                         'VALOR CUOTA',                       'CAPITAL DE LA CUOTA',               'INTERESES DE LA CUOTA',        --55           
'IVA DE LA CUOTA',                   'TASA INTERES (ANUAL)',              'CUOTAS PENDIENTES',                 'CUOTAS VENCIDAS',                   'CAPITAL VIGENTE EXIGIBLE',     --60          
'CAPITAL VENCIDO EXIGIBLE',          'SALDO CAP',                         'INTERES VIGENTE EXIGIBLE',          'INTERES SUSPENDIDO',                'IVA INTERES EXIGIBLE',         --65          
'IVA INTERES NO EXIGIBLE',           'COMISIONES',                        'IVA COMISION',                      'SALDO INTERESES',                   'SALDO REAL EXIGIBLE',          --70          
'SALDO TOTAL',                       'SALDO TOTAL EN MORA',               'IMPORTE LIQUIDA CON',               'DIAS MAX ATRASO ACT',               'SEMANAS DE ATRASO',            --75          
'DIAS MORA',                         'FECHA RECIBO ANTIGUO IMP',          'FECHA ULTIMA SITUACION DEUDA',      'PORCENTAJE RESERVA',                'CARTERA EN RIESGO',            --80          
'NIVEL DE RIESGO',                   'PUNTAJE DE RIESGO',                 'ROL MESA DIRECTIVA',                'INDICADOR DE REUNION',              'NUMERO DE EMPLEADO DEL ASESOR',--85     
'NUMERO DE EMPLEADO DEL COORDINADOR','NUMERO DE EMPLEADO DEL GERENTE',    'DIA DE REUNION SEMANAL',            'HORA DE REUNION SEMANAL',           'COORDENADAS NEGOCIO',          --90     
'NRO OPERACION GRUPAL',              'NVO DOM_DIRECCION',                 'NVO ESTADO',                        'NVO MUNICIPIO',                     'NVO LOCALIDAD',                --95      
'NVO C.P.',                          'NVAS COORDENADAS DOM',              'Foto del Domicilio',                'Entre calle 1 Dom',                 'Entre calle 2 Dom',            --100      
'Entre calle 3 Dom',                 'Entre calle 4 Dom',                 'Foto del Negocio',                  'Foto del Negocio 2',                'Entre calle 1 Neg',            --105      
'Entre calle 2 Neg',                 'Entre calle 3 Neg',                 'Entre calle 4 Neg',                 'Foto del Domicilio Alterno',        'Entre calle 1 Dom Alterno',    --110      
'Entre calle 2 Dom Alterno',         'Entre calle 3 Dom Alterno',         'Entre calle 4 Dom Alterno',         'Login Asesor',                      'Cargo Asesor',                 --115 
'Fecha Próxima cuota',               'Numero de Cuota',                   'Monto de Garantia',                 'Estado Crédito'

if @@error != 0 begin
   select 
   @w_error = 70146
   print 'ERROR AL INSERTAR REGISTRO DE CABECERA MC INICIO COlLECT'
end
--Inserccion de datos en la tabla
insert into cob_conta_super..sb_rep_oper_mc_collect	(
OFICINA,                              REGION,                             CC,                                   CONTRATO,                           [ID GRUPO],                     --5                      
[NOMBRE GRUPO],                       [CICLO GRUPAL],                     [NUMERO DE INTEGRANTES],              RFC,                                CURP,                           --10        
[CLIENTE COBIS],                      [APELLIDO PATERNO],                 [APELLIDO MATERNO],                   NOMBRE1,                            NOMBRE2,                        --15        
[CICLO INDIVIDUAL],                   GENERO,                             EDAD,                                 DOM_TELEFONO,                       DOM_DIRECCION,                  --20        
ESTADO,                               MUNICIPIO,                          LOCALIDAD,                            [C.P.],                             [COORDENADAS DOMICILIO],        --25        
NEG_TELEFONO,                         NEG_DIRECCION,                      NEG_ESTADO,                           NEG_MUNICIPIO,                      NEG_LOCALIDAD,                  --30       
NEG_CP,                               [NEG_TIPO DE LOCAL],                [ACTIVIDAD ECONOMICA],                [CORREO ELECTRONICO DEL CLIENTE],   [NOMBRE GERENTE],               --35        
[NOMBRE COORDINADOR],                 [NOMBRE DEL ASESOR],                [CORREO ELECTRONICO ASESOR],          [TELEFONO DEL ASESOR],              [ESTATUS ASESOR],               --40        
[PRODUCTO DE PRESTAMOS],              [SUBPRODUCTO PRESTAMO],             [MONTO CREDITO],                      [FECHA SOLICITUD],                  [FECHA APROBACION MONTOS],      --45        
[FECHA VENCIMIENTO PRESTAMO],         [NUMERO DE CONTRATO],               PLAZO,                                [NUMERO CUOTAS],                    [DIA DE PAGO],                  --50        
[PLAZO DIAS],                         [PLAZO MES],                        [VALOR CUOTA],                        [CAPITAL DE LA CUOTA],              [INTERESES DE LA CUOTA],        --55        
[IVA DE LA CUOTA],                    [TASA INTERES (ANUAL)],             [CUOTAS PENDIENTES],                  [CUOTAS VENCIDAS],                  [CAPITAL VIGENTE EXIGIBLE],     --60        
[CAPITAL VENCIDO EXIGIBLE],           [SALDO CAP],                        [INTERES VIGENTE EXIGIBLE],           [INTERES SUSPENDIDO],               [IVA INTERES EXIGIBLE],         --65        
[IVA INTERES NO EXIGIBLE],            COMISIONES,                         [IVA COMISION],                       [SALDO INTERESES],                  [SALDO REAL EXIGIBLE],          --70       
[SALDO TOTAL],                        [SALDO TOTAL EN MORA],              [IMPORTE LIQUIDA CON],                [DIAS MAX ATRASO ACT],              [SEMANAS DE ATRASO],            --75      
[DIAS MORA],                          [FECHA RECIBO ANTIGUO IMP],         [FECHA ULTIMA SITUACION DEUDA],       [PORCENTAJE RESERVA],               [CARTERA EN RIESGO],            --80        
[NIVEL DE RIESGO],                    [PUNTAJE DE RIESGO],                [ROL MESA DIRECTIVA],                 [INDICADOR DE REUNION],             [NUMERO DE EMPLEADO DEL ASESOR],--85      
[NUMERO DE EMPLEADO DEL COORDINADOR], [NUMERO DE EMPLEADO DEL GERENTE],   [DIA DE REUNION SEMANAL],             [HORA DE REUNION SEMANAL],          [COORDENADAS NEGOCIO],          --90      
[NRO OPERACION GRUPAL],               [NVO DOM_DIRECCION],                [NVO ESTADO],                         [NVO MUNICIPIO],                    [NVO LOCALIDAD],                --95      
[NVO C.P.],                           [NVAS COORDENADAS DOM],             [Foto del Domicilio],                 [Entre calle 1 Dom],                [Entre calle 2 Dom],            --100      
[Entre calle 3 Dom],                  [Entre calle 4 Dom],                [Foto del Negocio],                   [Foto del Negocio 2],               [Entre calle 1 Neg],            --105      
[Entre calle 2 Neg],                  [Entre calle 3 Neg],                [Entre calle 4 Neg],                  [Foto del Domicilio Alterno],       [Entre calle 1 Dom Alterno],    --110      
[Entre calle 2 Dom Alterno],          [Entre calle 3 Dom Alterno],        [Entre calle 4 Dom Alterno],          asesor_login_mc,                    asesor_cargo_mc,                --115
fecha_prox_couta_mc,                  [NUMERO_CUOTA],                     [MONTO_GARANTIA],                     [ESTADO_CREDITO]
	)
select 
	'OFICINA'                           = isnull(mca_division,' '),    --1
	'REGION'                            = isnull(mca_region,' '),      --2
	'CC'                                = isnull(mca_oficina,0),       --3
	'CONTRATO'                          = isnull(mca_banco,' '),       --4
	'ID GRUPO'                          = isnull(mca_grupo,0),         --5
	'NOMBRE GRUPO'                      = isnull(mca_nombre_grupo,' '),--6
	'CICLO GRUPAL '                     = isnull(mca_ciclo,' '),       --7
	'NUMERO DE INTEGRANTES'             = isnull(mca_numero_integrantes, 0),--8
	'RFC'                               = isnull(mca_doc_cliente,' ')      ,--9
	'CURP'                              = isnull(mca_curp,' '),             --10
	'CLIENTE COBIS'                     = isnull(mca_cliente,0),            --11
	'APELLIDO PATERNO'                  = isnull(mca_apellido_paterno,' '), --12
	'APELLIDO MATERNO'                  = isnull(mca_apellido_materno,' '), --13
	'NOMBRE1'                           = isnull(mca_nombre1,' '),          --14
	'NOMBRE2'                           = isnull(mca_nombre2,' '),          --15
	'CICLO INDIVIDUAL'                  = isnull(mca_numero_ciclo_ind,0),   --16
	'GENERO'                            = isnull(mca_genero,' '),           --17
	'EDAD'                              = isnull(mca_edad,0),               --18
	'DOM_TELEFONO'                      = isnull(mca_tel_cliente,' '),      --19
	'DOM_DIRECCION'                     = isnull(mca_dir_domicil,' '),      --20
	'ESTADO'                            = isnull(mca_dep_domicil,' '),      --21
	'MUNICIPIO'                         = isnull(mca_ciu_domicil,' '),      --22
	'LOCALIDAD'                         = isnull(mca_bar_domicil,' '),      --23
	'C.P.'                              = isnull(mca_cp_domicil,0),         --24
   'COORDENADAS DOMICILIO'             = isnull(mca_coordenadas_dom,' '),  --25	
	'NEG_TELEFONO'                      = isnull(mca_tel_negocio,' '),      --26
	'NEG_DIRECCION'                     = isnull(mca_dir_negocio,' '),      --27
	'NEG_ESTADO'                        = isnull(mca_dep_negocio,' '),      --28
	'NEG_MUNICIPIO'                     = isnull(mca_ciu_negocio,' '),      --29
	'NEG_LOCALIDAD'                     = isnull(mca_bar_negocio,' '),      --30
	'NEG_CP'                            = isnull(mca_cp_negocio,0),         --31
	'NEG_TIPO DE LOCAL'                 = isnull(mca_tlocal_negocio,' '),   --32
	'ACTIVIDAD ECONOMICA'               = isnull(mca_act_economica,' '),    --33
	'CORREO ELECTRONICO DEL CLIENTE'    = isnull(mca_correo,''),            --34
	'NOMBRE GERENTE'                    = isnull(mca_gerente,' '),          --35
	'NOMBRE COORDINADOR'                = isnull(mca_coordinador,' '),      --36
	'NOMBRE DEL ASESOR'                 = isnull(mca_oficial,' '),          --37
	'CORREO ELECTRONICO ASESOR'         = isnull(mca_correo_asesor, ' '),   --38
	'TELEFONO DEL ASESOR'               = isnull(mca_telefono_asesor, ' '), --39
	'ESTATUS ASESOR'                    = isnull(mca_oficial_status,' '),   --40
	'PRODUCTO DE PRESTAMOS'             = isnull(mca_toperacion,' '),       --41
	'SUBPRODUCTO PRESTAMO'              = isnull(mca_subtipo_producto, ' ' ),--42
	'MONTO CREDITO'                     = isnull(round(mca_monto,2),0),      --43
	'FECHA DE DESEMBOLSO'               = isnull(convert(varchar,null),' '),          --44 REQ#142301
	'FECHA APROBACION MONTOS'           = isnull(convert(varchar,mca_fecha_aprob_tramite,@w_formato_fecha),' '),--45
	'FECHA VENCIMIENTO PRESTAMO'        = isnull(convert(varchar,mca_fecha_vencimiento,@w_formato_fecha),' '),  --46
	'NUMERO DE CONTRATO'                = isnull(mca_banco,' '),   --47
	'PLAZO'                             = isnull(mca_plazo, ' ')  ,--48
	'NUMERO CUOTAS'                     = isnull(mca_num_cuotas,0),--49
	'DIA DE PAGO'                       = isnull(mca_dia_pago,' '),--50
	'PLAZO DIAS'                        = isnull(mca_plazo_dias,0),--51
	'PLAZO MES'                         = isnull(mca_plazo_mes,0), --52
	'VALOR CUOTA'                       = isnull(round(mca_valor_cuota,2),0),--53
	'CAPITAL DE LA CUOTA'               = isnull(mca_cuota_cap,0),           --54
	'INTERESES DE LA CUOTA'             = isnull(mca_cuota_int,0),           --55
	'IVA DE LA CUOTA'                   = isnull(mca_cuota_iva,0),           --56
	'TASA INTERES (ANUAL)'              = isnull(mca_tasa_int,0) ,           --57
	'CUOTAS PENDIENTES'                 = isnull(mca_cuotas_pendietes,0),    --58
	'CUOTAS VENCIDAS'                   = isnull(mca_num_cuotaven,0),        --59
	'CAPITAL VIGENTE EXIGIBLE'          = isnull(round(mca_cap_vig_ex,2),0), --60
	'CAPITAL VENCIDO EXIGIBLE'          = isnull(round(mca_cap_ven_ex,2),0)   , --61
	'SALDO CAP'                         = isnull(round(mca_cap_saldo,2),0)    , --62
	'INTERES VIGENTE EXIGIBLE'          = isnull(round(mca_int_vig_ex,2),0)   , --63
	'INTERES SUSPENDIDO'                = isnull(round(mca_int_sus,2),0)      , --64
	'IVA INTERES EXIGIBLE'              = isnull(round(mca_iva_int_ex,2),0)   , --65
	'IVA INTERES NO EXIGIBLE'           = isnull(round(mca_iva_int_ne,2),0)   , --66
	'COMISIONES'                        = isnull(round(mca_com_saldo,2),0)    , --67
	'IVA COMISION'                      = isnull(round(mca_iva_com_saldo,2),0), --68
	'SALDO INTERESES'                   = isnull(round(mca_int_saldo,2),0)    , --69
	'SALDO REAL EXIGIBLE'               = isnull(round(mca_saldo_real_ex,2),0), --70
	'SALDO TOTAL'                       = isnull(round(mca_saldo_real_ex,2),0), --71
	'SALDO TOTAL EN MORA'               = isnull(round(mca_int_mora,2),0)     , --72
	'IMPORTE LIQUIDA CON'               = isnull(round(mca_saldo_prestamo,2),0),--73
	'DIAS MAX ATRASO ACT'               = (case when isnull(mca_atraso_max_act,0)  < 0 then 0 else isnull(mca_atraso_max_act,0) end ), --74
	'SEMANAS DE ATRASO'                 = isnull(mca_edad_mora,0)/7 ,--75
	'DIAS MORA'                         = isnull(mca_edad_mora,0) ,  --76
	'FECHA RECIBO ANTIGUO IMP'          = isnull(convert(varchar,mca_fecha_min_vencimiento,@w_formato_fecha),' '),--77
	'FECHA ULTIMA SITUACION DEUDA'      = isnull(convert(varchar,mca_fecha_suspenso,@w_formato_fecha),' '),       --78
	'PORCENTAJE RESERVA'                = isnull(round(mca_porcentaje_reserva,2),0),--79
	'CARTERA EN RIESGO'                 = isnull(mca_cartera_riesgo,0) ,   --80
	'NIVEL DE RIESGO'                   = isnull(mca_nivel_riesgo,' ') ,   --81
	'PUNTAJE DE RIESGO'                 = isnull(mca_puntaje_riesgo,0) ,   --82
	'ROL MESA DIRECTIVA'                = isnull(mca_rol_directiva,' '),   --83
	'INDICADOR DE REUNION'              = isnull(mca_dom_reunion,'')   ,   --84
	'NUMERO DE EMPLEADO DEL ASESOR'     = isnull(mca_num_emp_asesor,''),   --85
	'NUMERO DE EMPLEADO DEL COORDINADOR'= isnull(mca_num_emp_coord,'') ,   --86
	'NUMERO DE EMPLEADO DEL GERENTE'    = isnull(mca_num_emp_gerente,''),  --87
	'DIA DE REUNION SEMANAL'            = isnull(mca_dia_reunion,''),      --88
	'HORA DE REUNION SEMANAL'           = isnull(mca_hora_reunion,''),     --89
	'COORDENADAS NEGOCIO'               = isnull(mca_coordenadas_neg,''),  --90
	'NRO OPERACION GRUPAL'              = isnull(mca_banco_padre,''),       --91
	'NVO DOM_DIRECCION'                 = '',                              --92
   'NVO ESTADO'                         = '',                              --93
   'NVO MUNICIPIO'                      = '',                              --94
   'NVO LOCALIDAD'                      = '',                              --95
   'NVO C.P.'                           = 0,                              --96
   'NVAS COORDENADAS DOM'               = '',                              --97
   'Foto del Domicilio'                 = '',                              --98
   'Entre calle 1 Dom'                  = '',                              --99
   'Entre calle 2 Dom'                  = '',                              --100
   'Entre calle 3 Dom'                  = '',                              --101
   'Entre calle 4 Dom'                  = '',                              --102
   'Foto del Negocio'                   = '',                              --103
   'Foto del Negocio 2'                 = '',                              --104
   'Entre calle 1 Neg'                  = '',                              --105
   'Entre calle 2 Neg'                  = '',                              --106
   'Entre calle 3 Neg'                  = '',                              --107
   'Entre calle 4 Neg'                  = '',                              --108
   'Foto del Domicilio Alterno'         = '',                              --109
   'Entre calle 1 Dom Alterno'          = '',                              --110
   'Entre calle 2 Dom Alterno'          = '',                              --111
   'Entre calle 3 Dom Alterno'          = '',                              --112
   'Entre calle 4 Dom Alterno'          = '',                              --113
   'Asesor login'                       = isnull(mca_login_asesor,''),                              --114
   'Asesor cargo'                       = isnull(mca_cargo_asesor,''),                              --115
   'FECHA PROX. CUOTA'                  = isnull(convert(varchar,mca_prox_vto,@w_formato_fecha),' '),                              --116
   'Numero de Cuota'                    = isnull(mca_num_acta,' '),
   'Monto de Garantia'                  = NULL,
   'Estado Crï¿½dito'                     = isnull(mca_estado,' ')
   from #maestro_cartera
   
if @@error != 0 begin
   select 
   @w_error = 70146
   print 'ERROR AL INSERTAR REGISTRO EN TABLA FINAL MC INICIO COlLECT'
   return 1
END

update cob_conta_super..sb_rep_oper_mc_collect
set    [FECHA SOLICITUD] = convert(varchar(10),do_fecha_concesion,103),
       [NUMERO_CUOTA]    = do_num_acta
from   cob_conta_super..sb_dato_operacion
where  do_codigo_cliente = [CLIENTE COBIS]
and    do_banco          = [CONTRATO]
and    do_fecha          = @w_fecha
and    secuencial_mc    > 1

update cob_conta_super..sb_rep_oper_mc_collect
set    [MONTO_GARANTIA] = ((tg_monto * tg_ahorro) / 100) 
from   cob_credito..cr_tramite_grupal 
where  tg_cliente    = [CLIENTE COBIS]
and    tg_prestamo   = [CONTRATO]
and    secuencial_mc > 1 

update cob_conta_super..sb_rep_oper_mc_collect 
set 
[NVO DOM_DIRECCION]         = isnull(rpini.nvo_dom_direccion,' '),                       
[NVO ESTADO]                = isnull(rpini.nvo_estado,' '),                                 
[NVO MUNICIPIO]             = isnull(rpini.nvo_municipio,' '),                
[NVO LOCALIDAD]             = isnull(rpini.nvo_localidad,' '),                              
[NVO C.P.]                  = isnull(rpini.nvo_c_p,' '),                                    
[NVAS COORDENADAS DOM]      = isnull(rpini.nvas_coordenadas_dom,' '),                   
[Foto del Domicilio]        = isnull(rpini.foto_domicilio,' '),                             
[Entre calle 1 Dom]         = isnull(rpini.entre_calle_1_dom,' '),                      
[Entre calle 2 Dom]         = isnull(rpini.entre_calle_2_dom,' '),                      
[Entre calle 3 Dom]         = isnull(rpini.entre_calle_3_dom,' '),                          
[Entre calle 4 Dom]         = isnull(rpini.entre_calle_4_dom,' '),                      
[Foto del Negocio]          = isnull(rpini.foto_negocio,' '),                               
[Foto del Negocio 2]        = isnull(rpini.foto_negocio_2,' '),                        
[Entre calle 1 Neg]         = isnull(rpini.entre_calle_1_neg,' '),                      
[Entre calle 2 Neg]         = isnull(rpini.entre_calle_2_neg,' '),                          
[Entre calle 3 Neg]         = isnull(rpini.entre_calle_3_neg,' '),                      
[Entre calle 4 Neg]         = isnull(rpini.entre_calle_4_neg,' '),                          
[Foto del Domicilio Alterno]= isnull(rpini.foto_domicilio_alterno,' '),                 
[Entre calle 1 Dom Alterno] = isnull(rpini.entre_calle_1_dom_alterno,' '),                  
[Entre calle 2 Dom Alterno] = isnull(rpini.entre_calle_2_dom_alterno,' '),                  
[Entre calle 3 Dom Alterno] = isnull(rpini.entre_calle_3_dom_alterno,' '),              
[Entre calle 4 Dom Alterno] = isnull(rpini.entre_calle_4_dom_alterno,' ')      
from cob_conta_super..sb_rep_ini_cobis_collect rpini,cob_conta_super..sb_rep_oper_mc_collect rp
where rp.[NRO OPERACION GRUPAL] = rpini.nro_operacion_grupal
and   rp.[CLIENTE COBIS]        = rpini.cliente_cobis
and   rp.[CONTRATO]             = rpini.contrato
and  rpini.fecha_carga_real =(select max(fecha_carga_real) from 
                              cob_conta_super..sb_rep_ini_cobis_collect rpini,cob_conta_super..sb_rep_oper_mc_collect rp
                              where rp.[NRO OPERACION GRUPAL] = rpini.nro_operacion_grupal
                              and   rp.[CLIENTE COBIS]        = rpini.cliente_cobis
                              and   rp.[CONTRATO]             = rpini.contrato)

select @w_query = 'select OFICINA,REGION,CC,CONTRATO,[ID GRUPO],[NOMBRE GRUPO],[CICLO GRUPAL ],[NUMERO DE INTEGRANTES],RFC,CURP,[CLIENTE COBIS],'
	  select @w_query = @w_query +  '[APELLIDO PATERNO],[APELLIDO MATERNO],NOMBRE1,NOMBRE2,[CICLO INDIVIDUAL],GENERO,EDAD,DOM_TELEFONO,DOM_DIRECCION,ESTADO,'
	  select @w_query = @w_query +  'MUNICIPIO,LOCALIDAD,[C.P.],[COORDENADAS DOMICILIO],NEG_TELEFONO,NEG_DIRECCION,NEG_ESTADO,NEG_MUNICIPIO,'
	  select @w_query = @w_query +  'NEG_LOCALIDAD,NEG_CP,[NEG_TIPO DE LOCAL],[ACTIVIDAD ECONOMICA],[CORREO ELECTRONICO DEL CLIENTE],[NOMBRE GERENTE],'
	  select @w_query = @w_query +  '[NOMBRE COORDINADOR],[NOMBRE DEL ASESOR],[CORREO ELECTRONICO ASESOR],[TELEFONO DEL ASESOR],[ESTATUS ASESOR],'
	  select @w_query = @w_query +  '[PRODUCTO DE PRESTAMOS],[SUBPRODUCTO PRESTAMO],[MONTO CREDITO],[FECHA SOLICITUD],[FECHA APROBACION MONTOS],'
	  select @w_query = @w_query +  '[FECHA VENCIMIENTO PRESTAMO],[NUMERO DE CONTRATO],PLAZO,[NUMERO CUOTAS],[DIA DE PAGO],[PLAZO DIAS],[PLAZO MES],'
	  select @w_query = @w_query +  '[VALOR CUOTA],[CAPITAL DE LA CUOTA],[INTERESES DE LA CUOTA],[IVA DE LA CUOTA],[TASA INTERES (ANUAL)],[CUOTAS PENDIENTES],'
     select @w_query = @w_query +  '[CUOTAS VENCIDAS],[CAPITAL VIGENTE EXIGIBLE],[CAPITAL VENCIDO EXIGIBLE],[SALDO CAP],[INTERES VIGENTE EXIGIBLE],[INTERES SUSPENDIDO],'
	  select @w_query = @w_query +  '[IVA INTERES EXIGIBLE],[IVA INTERES NO EXIGIBLE],COMISIONES,[IVA COMISION],[SALDO INTERESES],[SALDO REAL EXIGIBLE],[SALDO TOTAL],'
	  select @w_query = @w_query +  '[SALDO TOTAL EN MORA] ,[IMPORTE LIQUIDA CON] ,[DIAS MAX ATRASO ACT],[SEMANAS DE ATRASO],[DIAS MORA],[FECHA RECIBO ANTIGUO IMP],[FECHA ULTIMA SITUACION DEUDA],'
     select @w_query = @w_query +  '[PORCENTAJE RESERVA],[CARTERA EN RIESGO],[NIVEL DE RIESGO],[PUNTAJE DE RIESGO],[ROL MESA DIRECTIVA],[INDICADOR DE REUNION],[NUMERO DE EMPLEADO DEL ASESOR],'
	  select @w_query = @w_query +  '[NUMERO DE EMPLEADO DEL COORDINADOR],[NUMERO DE EMPLEADO DEL GERENTE],[DIA DE REUNION SEMANAL],[HORA DE REUNION SEMANAL],[COORDENADAS NEGOCIO],[NRO OPERACION GRUPAL],'              
     select @w_query = @w_query +  '[NVO DOM_DIRECCION],[NVO ESTADO],[NVO MUNICIPIO],[NVO LOCALIDAD],[NVO C.P.],[NVAS COORDENADAS DOM],[Foto del Domicilio],'
     select @w_query = @w_query +  '[Entre calle 1 Dom],[Entre calle 2 Dom],[Entre calle 3 Dom],[Entre calle 4 Dom],[Foto del Negocio],[Foto del Negocio 2],[Entre calle 1 Neg],'
     select @w_query = @w_query +  '[Entre calle 2 Neg],[Entre calle 3 Neg],[Entre calle 4 Neg],[Foto del Domicilio Alterno],[Entre calle 1 Dom Alterno],[Entre calle 2 Dom Alterno],[Entre calle 3 Dom Alterno],'
     select @w_query = @w_query +  '[Entre calle 4 Dom Alterno],asesor_login_mc,asesor_cargo_mc,fecha_prox_couta_mc,[NUMERO_CUOTA],[MONTO_GARANTIA],[ESTADO_CREDITO] from cob_conta_super..sb_rep_oper_mc_collect order by secuencial_mc ASC'
            	
--Geneacion del BCP para creacion del archivo 

select @w_nom_arch       = ba_arch_resultado,
       @w_patch_cobranza = ba_path_destino
from cobis..ba_batch 
where ba_batch = 287931

select 
@w_nom_arch_des  = @w_nom_arch+  replace(convert(varchar, @w_fecha, 102), '.', '') + '_' + replace(convert(varchar, getdate(), 108), ':', '') +'_N'+ '.txt',
@w_nom_log       = @w_nom_arch+ replace(convert(varchar, @w_fecha, 102), '.', '') + '_' + replace(convert(varchar, getdate(), 108), ':', '') + +'_N'+'.err'
select 
@w_destino_cobranza = @w_patch_cobranza + @w_nom_arch_des, 
@w_errores = @w_patch_cobranza + @w_nom_log--,
  
	   
select @w_comando = 'bcp "' + @w_query + '" queryout "'	   
select @w_comando = @w_comando + @w_destino_cobranza + '" -b5000 -c -C RAW -T -e ' + @w_s_app + 's_app.ini -T -e"' + @w_errores + '"'

print 'COMANDO 4: ' + @w_comando

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
  select @w_error = 70146
  return 1
end


return 0
go