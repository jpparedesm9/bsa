/*  ecdatope.sp CONT_SUP *****************************************************/
/*  Archivo:                         ecdatope.sp                             */
/*  Stored procedure:                sp_datos_operacion                      */
/*  Base de datos:                   cob_conta_super                         */
/*  Producto:                        REC                                     */
/*  Fecha de escritura:              01/05/2009                              */
/*****************************************************************************/
/*                            IMPORTANTE                                     */
/* Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCorp */
/* Su uso no autorizado queda  expresamente  prohibido asi como cualquier    */
/* alteracion o agregado hecho  por alguno de sus usuarios sin el debido     */
/* consentimiento por escrito de COBISCorp. Este programa esta protegido por */
/* la ley de derechos de autor y por las convenciones internacionales de     */
/* propiedad intelectual.  Su uso  no  autorizado dara derecho a COBISCORP   */
/* para obtener ordenes  de secuestro o  retencion  y  para  perseguir       */
/* penalmente a  los autores de cualquier infraccion.                        */
/*****************************************************************************/
/*              PROPOSITO                                                    */
/*  Insertando saldos de creditos desde cob_externos a cob_conta_super       */
/*  sb_dato_operacion y sb_dato_operacion_rubro                              */
/*  TO = TODOS                                                               */
/*  DO = SALDOS DE OPERACIONES SB_DATO_OPERACION                             */
/*                             SB_DATO_OPERACION_RUBROTODOS                  */
/*  DT = DATOS DE TRANSACCIONES SB_DATO_TRANSACCION                          */
/*                              SB_DATO_TRANSACCION_DET                      */
/*                              SB_DATO_REAJUSTE                             */
/*                              SB_MSV_PROC_CA                               */
/*  DD = DATO DE DEUDORES SB_DATO_DEUDORES                                   */  
/*  PY = DATOS DE PROYECCIONES SB_DATO_CUOTA_PRY                             */
/*                             SB_DATO_RUBRO_PRY                             */
/*  CL = DATOS GENERALES DE CLIENTES SB_DATO_CLIENTE                         */
/*                                   SB_DATO_SITUACION_CLIENTE               */
/*  TR = DATOS DE TRAMITES SB_DATO_TRAMITE                                   */
/*                         SB_POTENCIALES_CUPO                               */ 
/*                         SB_DATO_SITUACION_TRAMITE                         */
/*                         SB_DATO_MICROEMPRESA_SIT                          */
/*                         SB_DATO_BAL_FNCIERO                               */
/*                         SB_DATO_BAL_FNCIERO_DET                           */
/*                         SB_DATO_BAL_RESULTADO                             */
/*                         SB_DATO_RUTA                                      */
/*                         SB_DATO_ENCUESTA_RESP                             */
/*                         SB_DATO_ENCUESTA_PREG                             */
/*                         SB_DATO_ACCIONES_COBRANZA                         */
/*                         SB_VARIABLES_ENTRADA_MIR                          */
/*                         SB_RESPUESTAS_VARIABLES_MIR                       */
/*                         SB_MICRO_SEGURO                                   */
/*                         SB_ASEG_MICROSEGURO                               */
/*                         SB_BENEFIC_MICRO_ASEG                             */
/*                         SB_ENFERMEDADES                                   */
/*                         SB_FILTROS                                        */
/*                         SB_RUTA_FILTROS                                   */
/*                         SB_PASOS_FILTROS                                  */
/*                         SB_DEF_VARIABLES_FILTROS                          */
/*                         SB_VARIABLES_FILTROS                              */
/*                         SB_VALOR_VARIABLES_FILTROS                        */
/*                         SB_MSV_PROC_CR                                    */
/*  DC = DATOS DE COBRANZAS SB_DATO_COBRANZA                                 */
/*  TE = DATOS DE TESORERIA SB_DATO_TESORERIA                                */
/*****************************************************************************/
/*                               MODIFICACIONES                              */
/* 17/05/2019     DCumbal       Requerimiento #110097                        */
/* 24/07/2019     DCumbal       Requerimiento #119171                        */
/* 31/07/2019     MDiaz         Requerimiento #117956                        */
/* 15/07/2019     PXSG          Requerimiento #115931                        */
/* 31/07/2019     MDias         Requerimiento #117956                        */
/* 31/07/2019     AGO           Requerimiento #121717                        */
/* 29/11/2019     PXSG          Requerimiento #129681 Cob. Mc Collect        */
/* 14/01/2020     MTA           Caso 131766, agregar campos al reporte       */
/*                              ODS Saldos cartera                           */
/* Feb/2020       A.GONZALEZ    Req. 123672 -TIMBRADOS, EJECUCION DE         */
/*                              HISTORICO SB_DATO_CUOTA_PRY DIA 9            */ 
/* 10/09/2020     JSA           OPTIMIZACION BATCH                           */
/* ENE/2021       AGO           Req 147999   Renovaciones  Financiadas       */
/* 18/05/2021     DCumbal       Cambios #156405                              */
/* 04/11/2021     DCU           Caso: 169559 Ajuste reporte banxico          */
/* 13/12/2021     JEOM          Caso #172727                                 */
/* 01/07/2022     DCU           Caso: 188641 Frecuencia Pago                 */
/* 08/12/2022     ACH           Caso: 194284 DIA DE PAGO                     */
/* 15/06/2023     KVI           Req.205892 Rpt Riesgo Ind nva evaluacion     */
/*****************************************************************************/

USE cob_conta_super
GO


SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

if exists (select 1 from sysobjects where name = 'sp_datos_operacion')
   drop procedure sp_datos_operacion
go

---LLS 103135 Feb.19.2013

create procedure sp_datos_operacion(
   @t_show_version        bit = 0,
   @i_param1              smalldatetime,
   @i_param2              varchar(2)
)
as declare
   @i_fecha_proceso         smalldatetime,
   @i_toperacion            varchar(2) ,      
   @w_error                 varchar(255),
   @w_sp_name               varchar(30),
   @w_retorno               int, 
   @w_bancamia              int,
   @w_fuente                descripcion,
   @w_aplicativo            tinyint,
   @w_ult_finmes            datetime,
   @w_mes                   tinyint,
   @w_anios                 int,
   @w_est_vigente           tinyint,
   @w_est_novigente         tinyint,
   @w_est_vencido           tinyint,
   @w_est_cancelado         tinyint,
   @w_est_suspenso          tinyint,
   @w_est_castigado         tinyint,
   @w_est_diferido          tinyint

select  
   @i_fecha_proceso  = @i_param1,
   @i_toperacion     = @i_param2,
   @w_retorno        = 0,
   @w_sp_name        = 'sp_datos_operacion',
   @w_error          = 'FIN DEL PROCESO'

-- Versionamiento del Programa --
if @t_show_version = 1
begin
  print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.1'
  return 0
end
																												  
/* ESTADOS DE CARTERA */
exec @w_error = cob_cartera..sp_estados_cca
@o_est_vigente    = @w_est_vigente   out,
@o_est_novigente  = @w_est_novigente out,
@o_est_vencido    = @w_est_vencido   out,
@o_est_cancelado  = @w_est_cancelado out,
@o_est_castigado  = @w_est_castigado out,
@o_est_suspenso   = @w_est_suspenso  out,
@o_est_diferido   = @w_est_diferido  out


if @w_error <> 0 begin
   exec cob_conta_super..sp_errorlog
   @i_operacion     = 'I',
   @i_fecha_fin     = @i_fecha_proceso,
   @i_fuente        = @w_sp_name,
   @i_origen_error  = '28003',
   @i_descrp_error  = 'ERROR al consultar estados de Cartera'           
end

/*CREACION DE TABLAS TEMPORALES DE TRABAJO */
create table #aplicativo(aplicativo tinyint null)

delete sb_errorlog where er_fuente = @w_sp_name

--codigo de ente asignado al Banco 
select @w_bancamia = en_ente 
  from cobis..cl_ente 
 where en_ced_ruc  = '9002150711'
   and en_tipo_ced = 'N'

if @@rowcount = 0 Begin
   exec cob_conta_super..sp_errorlog
        @i_operacion     = 'I',
        @i_fecha_fin     = @i_fecha_proceso,
        @i_fuente        = @w_sp_name,
        @i_origen_error  = '28001',
        @i_descrp_error  = 'ERROR NO EXISTE CODIGO DE ENTE ASIGNADO A LA ENTIDAD BANCARIA'
end 

/* DETERMINAR LA LISTA DE APLICATIVOS QUE REPORTAN DATOS */
if @i_toperacion in ('TO','DO') begin  --procesar todas las tablas
   /***ELIMINANDO DATOS EN sb_cartera_trasladada_canc  REQ 00375 ***/
   
   if exists (select 1 from sb_cartera_trasladada_canc
               where ct_fecha = @i_fecha_proceso)
   begin       
      delete sb_cartera_trasladada_canc 
       where ct_fecha = @i_fecha_proceso
   end
   
   /***INSERTANDO DATOS EN sb_cartera_trasladada_canc REQ 00375***/
   insert into sb_cartera_trasladada_canc 
   select * from cob_externos..ex_cartera_trasladada_canc
    where et_fecha = @i_fecha_proceso

   /***	AJUSTES PARA CONCILIACION DE REFERIDOS DEL CLIENTE  REQ 00518 ***/
   
   if exists (select 1 from sb_abonos_referidos
               where sar_fecha_corte = @i_fecha_proceso)
   begin       
      delete sb_abonos_referidos
       where sar_fecha_corte = @i_fecha_proceso
         if @@error <> 0 
         begin
           exec cob_conta_super..sp_errorlog
                @i_operacion     = 'I',
                @i_fecha_fin     = @i_fecha_proceso,
                @i_fuente        = @w_sp_name,
                @i_origen_error  = '28003',
                @i_descrp_error  = 'ERROR ELIMINANDO DATOS EN sb_abonos_referidos' 
         end       
   end
   
   /***INSERTANDO DATOS EN sb_abonos_referidos REQ 00518***/
   insert into sb_abonos_referidos 
   select * from cob_externos..ex_abonos_referidos
    where ar_fecha_corte = @i_fecha_proceso
   
   if @@error <> 0 
   Begin
      exec cob_conta_super..sp_errorlog
           @i_operacion     = 'I',
           @i_fecha_fin     = @i_fecha_proceso,
           @i_fuente        = @w_sp_name,
           @i_origen_error  = '28003',
           @i_descrp_error  = 'ERROR INSERTANDO DATOS EN sb_abonos_referidos' 
   end 
   
   insert into #aplicativo
   select distinct dt_aplicativo
     from cob_externos..ex_dato_tesoreria
    where dt_fecha = @i_fecha_proceso

   insert into #aplicativo
   select distinct do_aplicativo
     from cob_externos..ex_dato_operacion
    where do_fecha = @i_fecha_proceso

   insert into #aplicativo
   select distinct dp_aplicativo
     from cob_externos..ex_dato_pasivas
    where dp_fecha = @i_fecha_proceso

   insert into #aplicativo
   select distinct ts_aplicativo
     from cob_externos..ex_dato_tramite_sit
    where ts_fecha = @i_fecha_proceso
   
   insert into #aplicativo
   select distinct vo_aplicativo
     from cob_externos..ex_val_oper_finagro
    where vo_fecha = @i_fecha_proceso
   
end else begin

   if @i_toperacion = 'TE' begin  --solo datos de tesoreria
      insert into #aplicativo
      select distinct dt_aplicativo
        from cob_externos..ex_dato_tesoreria
       where dt_fecha = @i_fecha_proceso
   end

   if @i_toperacion = 'DT' begin  --solo datos de las transacciones
      insert into #aplicativo
      select distinct dt_aplicativo
        from cob_externos..ex_dato_transaccion
       where dt_fecha = @i_fecha_proceso
   end

   if @i_toperacion = 'PY' begin  --solo proyecciones de cuotas
      insert into #aplicativo
      select distinct dc_aplicativo
        from cob_externos..ex_dato_cuota_pry
       where dc_fecha = @i_fecha_proceso
   end
   
   if @i_toperacion = 'DD' begin  --solo datos de los deudores
      insert into #aplicativo
      select distinct de_aplicativo
        from cob_externos..ex_dato_deudores
       where de_fecha = @i_fecha_proceso
   end

  if @i_toperacion = 'TR' begin  --solo datos de Tramites
      insert into #aplicativo
      select distinct ts_aplicativo
        from cob_externos..ex_dato_tramite_sit
       where ts_fecha = @i_fecha_proceso
   end

  if @i_toperacion = 'DC' begin  --solo datos de Cobranzas
      insert into #aplicativo
      select distinct dc_aplicativo
        from cob_externos..ex_dato_cobranza
       where dc_fecha = @i_fecha_proceso
   end
end

/* DETERMINAR LA FECHA DEL ULTIMO FIN DE MES */
select @w_ult_finmes = max(do_fecha)
from sb_dato_operacion 
where do_fecha <= dateadd(dd,-1*datepart(dd,@i_fecha_proceso),@i_fecha_proceso)

select @w_aplicativo = 0 

if exists (select 1 from sb_repuntuacion
            where re_fecha_repuntuacion = @i_fecha_proceso)
begin
  delete sb_repuntuacion
   where re_fecha_repuntuacion = @i_fecha_proceso
end
     
insert into sb_repuntuacion (
 re_tramite,   re_fecha_repuntuacion,	   re_tipo_proceso)
select 
 re_tramite,	   re_fecha_repuntuacion,	   re_tipo_proceso
  from  cob_externos..ex_repuntuacion exr
 where exr.re_fecha_repuntuacion = @i_fecha_proceso

if @@error <> 0 
begin
      exec cob_conta_super..sp_errorlog
           @i_operacion     = 'I',
           @i_fecha_fin     = @i_fecha_proceso,
           @i_fuente        = @w_sp_name,
           @i_origen_error  = '28003',
           @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_REPUNTUACION' 
end

while 1=1 and (@i_toperacion <> 'CL') 
begin   -- lazo para procesar cada uno de los aplicativos reportados

   set rowcount 1
   select @w_aplicativo = aplicativo
     from #aplicativo
    where aplicativo > @w_aplicativo
 order by aplicativo

   if @@rowcount = 0 
   begin
      set rowcount 0
      break
   end
   
   set rowcount 0
																																 
   /* DATOS DE LAS OPERACIONES */
   if @i_toperacion in ('DO','TO') 
   begin
       if exists(select 1 from sb_desmarca_fng_his
                  where df_fecha      = @i_fecha_proceso
                   and  df_aplicativo = @w_aplicativo)
       begin
          delete sb_desmarca_fng_his
           where df_fecha      = @i_fecha_proceso
             and df_aplicativo = @w_aplicativo
       end

       insert into sb_desmarca_fng_his (
       df_fecha,           df_aplicativo,     df_banco,          
       df_garantia,        df_est_gar_ant,    df_est_gar_nue,    
       df_val_ant,         df_val_nue,        df_admisible_ant,  
       df_admisible_nue,   df_desmarca,       df_marca
       )
       select 
       df_fecha,           df_aplicativo,     df_banco,          
       df_garantia,        df_est_gar_ant,    df_est_gar_nue,    
       df_val_ant,         df_val_nue,        df_admisible_ant,  
       df_admisible_nue,   'S',               'N'
       from cob_externos..ex_desmarca_fng_his 
       where df_fecha      = @i_fecha_proceso
       and   df_aplicativo = @w_aplicativo

       if @@error <> 0 
	   begin
          exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @i_fecha_proceso,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28006',
               @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DESMARCA_FNG_HIS' 
       end

       if exists (select 1 from cob_externos..ex_dato_operacion
                   where do_aplicativo = 203)
       begin
          update cob_externos..ex_dato_operacion
             set do_cliente = en_ente
            from cob_externos..ex_dato_operacion, cobis..cl_ente
           where do_aplicativo = 203
             and en_tipo_ced = do_documento_tipo 
             and en_ced_ruc = do_documento_numero

		   if @@error <> 0 
		   Begin
			  exec cob_conta_super..sp_errorlog
			       @i_operacion     = 'I',
			       @i_fecha_fin     = @i_fecha_proceso,
			       @i_fuente        = @w_sp_name,
			       @i_origen_error  = '28003',
			       @i_descrp_error  = 'ERROR AL ACTUALIZAR LOS DATOS DE BONOS'           
		   end
       end

      /*ENTRAR BORRANDO LAS TABLAS DE TRABAJO TEMPORALES */
       truncate table sb_datos_rubros_tmp
       truncate table sb_dato_operacion_tmp
       SELECT * INTO #sb_dato_operacion_tmp FROM sb_dato_operacion_tmp
       SELECT * INTO #sb_datos_rubros_tmp FROM sb_datos_rubros_tmp
       
       PRINT 'Inicia insertando en --> #sb_dato_operacion_tmp ' + convert(varchar(40),getdate())
       insert into #sb_dato_operacion_tmp(
       do_fecha                 ,do_banco                   ,do_tipo_operacion           ,do_aplicativo           ,    
       do_oficina               ,do_moneda                  ,do_monto                    ,do_codigo_cliente       ,   
       do_tasa                  ,do_modalidad               ,do_codigo_destino           ,do_clase_cartera        ,   
       do_fecha_concesion       ,do_fecha_vencimiento       ,do_saldo_cap                ,do_saldo_int            ,   
       do_saldo_otros           ,do_saldo_int_contingente   ,do_saldo                    ,do_linea_credito        ,   
       do_periodicidad_cuota    ,do_edad_mora               ,do_estado_cartera           ,do_plazo_dias           ,   
       do_num_cuotas            ,do_valor_mora              ,do_valor_cuota              ,do_fecha_ult_pago       ,   
       do_cuotas_pag            ,do_valor_ult_pago          ,do_fecha_ult_pago_cap       ,do_valor_ult_pago_cap   ,
       do_fecha_ult_pago_int    ,do_valor_ult_pago_int      ,do_num_cuotaven             ,do_saldo_cuotaven       ,   
       do_fecha_castigo         ,do_num_acta                ,do_clausula                 ,do_reestructuracion     ,   
       do_fecha_reest           ,do_nat_reest               ,do_num_reest                ,do_no_renovacion        ,   
       do_estado_contable       ,
       do_situacion_cliente     ,do_calificacion            ,do_probabilidad_default     ,  
       do_calificacion_mr       ,do_proba_incum             ,do_perd_incum               ,do_tipo_emp_mr          ,  
       do_tipo_garantias        ,do_valor_garantias         ,do_admisible                ,do_prov_cap             ,  
       do_prov_int              ,do_prov_cxc                ,do_prov_con_int             ,do_prov_con_cxc         ,  
       do_prov_con_cap          ,do_tipo_reg                ,do_edad_cod                 ,do_oficial              ,
       do_naturaleza            ,do_fuente_recurso          ,do_categoria_producto       ,do_fecha_prox_vto       ,
       do_op_anterior           ,do_num_cuotas_reest        ,do_tramite                  ,do_nota_int             ,  -- GAL 01/AGO/2010 - OMC (do_nota_int)
       do_fecha_ini_mora        ,do_gracia_mora             ,do_estado_cobranza          ,do_saldo_otr_contingente,  -- GAL 01/AGO/2010 - OMC
       do_tasa_mora             ,do_tasa_com                ,do_entidad_convenio         ,do_fecha_cambio_linea   ,  -- GAL 01/AGO/2010 - OMC
       do_valor_nominal         ,do_emision                 ,do_sujcred                  ,do_cap_vencido          ,
       do_valor_proxima_cuota   ,do_saldo_total_Vencido     ,do_saldo_otr                ,do_saldo_cap_total      ,  --Req 378 12/08/2013  (do_valor_proxima_cuota)
       do_regional              ,do_dias_mora_365           ,do_normalizado              ,do_tipo_norm            ,  --OMOG 03/DIC/2014. Req 472. Se agrega el campo do_dias_mora_365
       do_frec_pagos_capital    ,do_frec_pagos_int          ,do_fec_pri_amort_cubierta   ,do_monto_condo          ,
       do_fecha_condo           ,do_monto_castigo           ,do_inte_castigo             ,do_monto_bonifica       ,
       do_inte_vencido          ,do_inte_vencido_fbalance   ,do_inte_refina              ,do_emproblemado         ,
       do_mod_pago              ,do_tipo_cartera            ,do_subtipo_cartera          ,do_dias_mora_ant        ,
       do_grupal                ,do_cociente_pago           ,do_numero_ciclos            ,do_numero_integrantes   ,
       do_grupo                 ,do_valor_cat               ,do_gar_liq_orig             ,do_gar_liq_fpago        ,
       do_gar_liq_dev           ,do_gar_liq_fdev            ,                                                        
       do_cuota_cap             ,do_cuota_int               ,do_cuota_iva                ,do_fecha_suspenso       ,
       do_cuenta                ,do_plazo                   ,do_venc_dividendo           ,do_fecha_aprob_tramite  ,
       do_subtipo_producto      ,do_atraso_grupal           ,do_fecha_dividendo_ven      ,do_operacion            ,
       do_cuota_min_vencida     ,do_tplazo                  ,do_fecha_proceso            ,
       do_subproducto           ,do_cuota_max_vencida       ,do_atraso_gr_ant            , do_monto_aprobado,
	   do_fecha_ult_vto			,do_cuota_ult_vto			,do_tipo_amortizacion        ,do_cupo_original,          
	   do_importe_ult_vto       ,do_importe_pri_vto         ,do_fecha_pri_vto            ,do_banco_padre,
       do_fecha_ven_orig        ,do_fecha_can_ant           ,do_fecha_ini_desp           ,do_fecha_fin_desp,
       do_cuota_int_esp         ,do_cuota_iva_esp           ,do_renovacion_grupal        ,do_renovacion_ind,
       do_meses_primer_op	    ,do_periodicidad            ,do_dia_pago
       )
       select
       do_fecha                 ,do_banco                   ,do_toperacion               ,do_aplicativo           ,
       do_oficina               ,do_moneda                  ,do_monto                    ,case do_cliente when 0 then @w_bancamia else do_cliente end,
       do_tasa                  ,do_modalidad               ,do_destino_economico        ,do_clase_cartera        ,
       do_fecha_desembolso      ,do_fecha_vencimiento       ,0                           ,0                       ,
       0                        , 0                         ,0                           ,do_cupo_credito         ,
       do_periodicidad_cuota    ,do_edad_mora               ,do_estado                   ,do_plazo_dias           ,
       do_num_cuotas            ,do_cap_mora                ,do_valor_cuota              ,do_fecha_ult_pago       ,
       do_cuotas_pag            ,do_valor_ult_pago          ,do_fecha_ult_pago_cap       ,do_valor_ult_pago_cap   ,
       do_fecha_ult_pago_int    ,do_valor_ult_pago_int      ,do_cuotas_ven               ,do_saldo_ven            ,
       do_fecha_castigo         ,do_num_acta                ,do_clausula                 ,do_reestructuracion     ,
       do_fecha_reest           ,do_nat_reest               ,do_num_reest                ,do_num_renovaciones     ,
       case when do_estado = 4 then 3 when do_estado = 3 then 4  when do_estado in (1,2,9) then 1 else do_estado end,
       'NOR'                    ,'A'                        ,' '                         ,
       ''                       ,0                          ,0                           ,''                      ,
       do_tipo_garantias        ,0                          ,''                          ,0                       ,
       0                        ,0                          ,0                           ,0                       ,
       0                        ,'D'                        ,isnull(do_edad_cod,0)       ,do_oficial              ,
       do_naturaleza            ,do_fuente_recurso          ,do_categoria_producto       ,do_fecha_prox_vto       ,
       do_op_anterior           ,do_num_cuotas_reest        ,do_tramite                  ,do_nota_int             ,  -- GAL 01/AGO/2010 - OMC (do_nota_int)
       do_fecha_ini_mora        ,do_gracia_mora             ,do_estado_cobranza          ,0                       ,  -- GAL 01/AGO/2010 - OMC
       do_tasa_mora             ,do_tasa_com                ,do_entidad_convenio         ,do_fecha_cambio_linea   ,  -- GAL 01/AGO/2010 - OMC
       do_valor_nominal         ,do_emision                 ,do_sujcred                  ,do_cap_vencido          ,  -- DAL Bonos
       do_valor_proxima_cuota   ,do_saldo_total_Vencido     ,do_saldo_otr                ,do_saldo_cap_total      ,  --Req 378 12/08/2013  (do_valor_proxima_cuota)
       do_regional              ,do_dias_mora_365           ,do_normalizado              ,do_tipo_norm            ,  --OMOG 03/DIC/2014. Req 472. Se agrega el campo do_dias_mora_365
       do_frec_pagos_capital    ,do_frec_pagos_int          ,do_fec_pri_amort_cubierta   ,do_monto_condo          ,
       do_fecha_condo           ,do_monto_castigo           ,do_inte_castigo             ,do_monto_bonifica       ,
       do_inte_vencido          ,do_inte_vencido_fbalance   ,do_inte_refina              ,do_emproblemado         ,
       do_mod_pago              ,do_tipo_cartera            ,do_subtipo_cartera          ,do_dias_mora_ant        ,
       do_grupal                ,do_cociente_pago           ,do_numero_ciclos            ,do_numero_integrantes   ,
       /* NUEVOS CAMPOS */
       -- LGU 2018-01-15
       do_grupo                 ,do_valor_cat               ,do_gar_liq_orig             ,do_gar_liq_fpago        ,
       do_gar_liq_dev           ,do_gar_liq_fdev            ,
       do_cuota_cap             ,do_cuota_int               ,do_cuota_iva                ,do_fecha_suspenso,
       do_cuenta                ,do_plazo                   ,do_venc_dividendo           ,do_fecha_aprob_tramite  ,
       do_subtipo_producto      ,do_atraso_grupal           ,do_fecha_dividendo_ven      ,do_operacion            ,
       do_cuota_min_vencida     ,do_tplazo                  ,do_fecha_proceso            ,
       do_subproducto           ,do_cuota_max_vencida       ,do_atraso_gr_ant            , do_monto_aprobado	  ,
	   do_fecha_ult_vto 	  	,do_cuota_ult_vto			,do_tipo_amortizacion        ,do_cupo_original,          
	   do_importe_ult_vto       ,do_importe_pri_vto         ,do_fecha_pri_vto            ,do_banco_padre          ,
	   do_fecha_ven_orig        ,do_fecha_can_ant           ,do_fecha_ini_desp           ,do_fecha_fin_desp,
       do_cuota_int_esp         ,do_cuota_iva_esp           ,do_renovacion_grupal        ,do_renovacion_ind,
       do_meses_primer_op	    ,do_periodicidad            ,do_dia_pago     
       from cob_externos..ex_dato_operacion
       where do_fecha      = @i_fecha_proceso
       and   do_aplicativo = @w_aplicativo
       ORDER BY do_banco
      
       if @@error <> 0 begin
          exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @i_fecha_proceso,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28002',
               @i_descrp_error  = 'ERROR INSERTANDO DATOS EN #SB_DATO_OPERACION_TMP'          
       end 

       CREATE CLUSTERED INDEX idx1 ON #sb_dato_operacion_tmp (do_banco)
            
       /* REPORTAR TODOS LOS CREDITOS QUE NO SE ENCUENTRE EL CLIENTE */ 
       insert into sb_errorlog
       select
       er_fecha        = @i_fecha_proceso,        
       er_fecha_proc   = getdate(),      
       er_fuente       = @w_sp_name,
       er_origen_error = do_banco,  
       er_descrp_error = 'CLIENTE NO EXISTE' 
       from sb_dato_operacion --with (index = idx2)
       where do_codigo_cliente = @w_bancamia   
       and   do_fecha          = @i_fecha_proceso
       
       select 
       aplicativo    =do_aplicativo     ,banco                      =do_banco                      ,prov_cap       =do_prov_cap    ,
       prov_int      =do_prov_int       ,prov_cxc                   =do_prov_cxc                   ,prov_con_int   =do_prov_con_int,
       prov_con_cxc  =do_prov_con_cxc   ,prov_con_cap               =do_prov_con_cap               ,calificacion   =do_calificacion,
       calificacion_mr=do_calificacion_mr,proba_incum                =do_proba_incum                ,perd_incum     =do_perd_incum  ,
       tipo_emp_mr   =do_tipo_emp_mr    ,situacion_cli              =do_situacion_cliente          ,edad_cod       =0              ,
       tipo_gar      =do_tipo_garantias ,valor_gar                  =isnull(do_valor_garantias,0)  ,calif_reest    =do_calif_reest ,  
	   unidad_atraso =do_unidad_atraso  ,severidad_perdida          =do_severidad_perdida          ,cociente_pago  =do_cociente_pago,               
	   monto_expuesto=do_monto_expuesto ,probabilidad_incumplimiento=do_probabilidad_incumplimiento,provision      =do_provision                 
	   into #sb_datos_corte_anterior_tmp
       from sb_dato_operacion
       where do_fecha      = @w_ult_finmes
       and   do_aplicativo = @w_aplicativo

       if @@error <> 0 begin
          exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @i_fecha_proceso,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28003',
               @i_descrp_error  = 'ERROR AL BUSCAR LOS DATOS DEL CORTE ANTERIOR' 
       end
      
       create index idx1 on #sb_datos_corte_anterior_tmp(banco)

       update #sb_dato_operacion_tmp set
       do_prov_cap                    = prov_cap,
       do_prov_int                    = prov_int,
       do_prov_cxc                    = prov_cxc,
       do_prov_con_int                = prov_con_int,
       do_prov_con_cxc                = prov_con_cxc,
       do_prov_con_cap                = prov_con_cap,
       do_calificacion                = calificacion,
       do_calificacion_mr             = calificacion_mr,
       do_proba_incum                 = proba_incum,
       do_perd_incum                  = perd_incum,
       do_tipo_emp_mr                 = tipo_emp_mr,
       do_situacion_cliente           = situacion_cli,
       do_calif_reest                 = calif_reest,
       do_valor_garantias             = valor_gar,
	   do_provision                   = provision, 
	   do_unidad_atraso               = unidad_atraso,              
	   do_cociente_pago               = cociente_pago,             
	   do_probabilidad_incumplimiento = probabilidad_incumplimiento,
	   do_severidad_perdida           = severidad_perdida,         
	   do_monto_expuesto              = monto_expuesto             
	   from #sb_datos_corte_anterior_tmp
       where do_banco           = banco              

       if @@error <> 0 begin
          exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @i_fecha_proceso,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28003',
               @i_descrp_error  = 'ERROR AL ACTUALIZAR LOS DATOS DEL CORTE ANTERIOR'           
       end
    
       --Actualizar valor Garantias y tipo de Garantias para Desmarcados FNG
       
       select bancoh = df_banco, fecha_max = df_fecha
       into #marcafng
       from cob_conta_super..sb_desmarca_fng_his
       group by df_banco,  df_fecha
       
       select banco = df_banco, marca = case when df_marca = 'S' then 'S' else 'N' end, val_nue = df_val_nue
       into #marcafng_def
       from #marcafng, cob_conta_super..sb_desmarca_fng_his
       where df_banco = bancoh
       and   df_fecha = fecha_max
        
       update #sb_dato_operacion_tmp set
       do_valor_garantias = val_nue
       from #marcafng_def, #sb_dato_operacion_tmp
       where do_banco = banco

       if @@error <> 0 begin
          exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @i_fecha_proceso,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28003',
               @i_descrp_error  = 'ERROR AL ACTUALIZAR LOS DATOS DE GARANTIAS DESMARCADAS FNG'           
       end

       select @w_mes   = datepart(mm, @i_fecha_proceso)
       select @w_anios = datepart(yy, @i_fecha_proceso)
       
       update #sb_dato_operacion_tmp set
       do_calif_reest = do_calificacion
       where do_reestructuracion = 'S'
       and   datepart(mm,do_fecha_reest) = @w_mes
       and   datepart(yy,do_fecha_reest) = @w_anios

       if @@error <> 0 Begin
          exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @i_fecha_proceso,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28003',
               @i_descrp_error  = 'ERROR AL ACTUALIZAR LOS DATOS DE REESTRUCTURADOS'           
       end
       
       --CARGUE TABLA sb_normalizacion
       delete cob_conta_super..sb_normalizacion
        where sn_fecha      = @i_fecha_proceso
          and sn_aplicativo = @w_aplicativo
       
       if @@error <> 0 begin
          exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @i_fecha_proceso,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28003',
               @i_descrp_error  = 'ERROR AL ELIMINAR DATOS DE sb_normalizacion'           
       end
       
       insert into cob_conta_super..sb_normalizacion
       select *
         from cob_externos..ex_normalizacion
        where en_fecha      = @i_fecha_proceso
          and en_aplicativo = @w_aplicativo
       
       if @@error <> 0 begin
          exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @i_fecha_proceso,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28003',
               @i_descrp_error  = 'ERROR AL INSERTAR DATOS en sb_normalizacion'           
       end
        
       --INC junio 2015 NORMALIZADOS TIPO 1, 2 Y 3 CALIF REEST     
       select cliente = do_codigo_cliente, banco = sn_banco
         into #opera_normali
         from #sb_dato_operacion_tmp, cob_conta_super..sb_normalizacion
        where do_fecha                    = @i_fecha_proceso       
          and do_aplicativo               = @w_aplicativo
          and do_reestructuracion         = 'S'


          and datepart(mm,do_fecha_reest) = @w_mes
          and datepart(yy,do_fecha_reest) = @w_anios
          and do_codigo_cliente           = sn_cliente

       select cliente_ca = do_codigo_cliente, calificacion = MAX(do_calificacion)
         into #maxi_calif_norm
         from cob_conta_super..sb_dato_operacion, #opera_normali
        where do_fecha          = @w_ult_finmes
          and do_aplicativo     = @w_aplicativo
          and do_codigo_cliente = cliente
     group by do_codigo_cliente

       update #sb_dato_operacion_tmp set
       do_calif_reest  = case when calificacion = 'A' then 'B' else calificacion end

         from #maxi_calif_norm, #opera_normali
        where do_fecha                    = @i_fecha_proceso
          and do_aplicativo               = @w_aplicativo
          and do_reestructuracion         = 'S'
          and cliente_ca                  = cliente
          and banco                       = do_banco

          and datepart(mm,do_fecha_reest) = @w_mes
          and datepart(yy,do_fecha_reest) = @w_anios
       
       if @@error <> 0 begin
          exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @i_fecha_proceso,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28003',
               @i_descrp_error  = 'ERROR AL ACTUALIZAR LOS DATOS DE CALIF REEST NORM TIPO 1,2 Y 3'           
       end
       --FIN junio 2015 NORMALIZADOS TIPO 1, 2 Y 3  CALIF REEST
              
       insert into #sb_datos_rubros_tmp
       select 
       banco          = dr_banco,
       aplicativo     = @w_aplicativo,
       saldo_cap      = sum(case when dr_concepto     in ('CAP')       and dr_estado in (@w_est_vigente, @w_est_vencido, @w_est_suspenso) then dr_valor else 0 end),
       saldo_int      = sum(case when dr_concepto     in ('INT')       and dr_estado in (@w_est_vigente, @w_est_vencido)                  then dr_valor else 0 end),
       saldo_otr      = sum(case when dr_concepto not in ('CAP','INT') and dr_estado in (@w_est_vigente, @w_est_vencido)                  then dr_valor else 0 end),
       int_cont       = sum(case when dr_concepto     in ('INT')       and dr_estado in (@w_est_suspenso)                                 then dr_valor else 0 end),
       saldo_cap_cas  = sum(case when dr_concepto     in ('CAP')       and dr_estado in (@w_est_castigado)                                then dr_valor else 0 end),
       saldo_int_cas  = sum(case when dr_concepto     in ('INT')       and dr_estado in (@w_est_castigado)                                then dr_valor else 0 end),       
       saldo_otr_cas  = sum(case when dr_concepto not in ('CAP','INT') and dr_estado in (@w_est_castigado)                                then dr_valor else 0 end),
       otr_cont       = sum(case when dr_concepto not in ('CAP','INT') and dr_estado in (@w_est_suspenso)                                 then dr_valor else 0 end) 
       from cob_externos..ex_dato_operacion_rubro
       where dr_fecha      = @i_fecha_proceso
       and   dr_aplicativo = @w_aplicativo
       AND   dr_exigible <> 3
       group by dr_banco
       ORDER BY dr_banco
      
       if @@error <> 0 begin
          exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @i_fecha_proceso,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28004',
               @i_descrp_error  = 'ERROR NO EXISTEN SALDOS DE RUBROS EN LA TABLA ex_dato_operacion_rubro'           
       end

       create CLUSTERED index idx1 on #sb_datos_rubros_tmp(banco)
                     
       update #sb_dato_operacion_tmp set
       do_saldo_cap             = case do_estado_cartera when 4 then saldo_cap_cas else saldo_cap end,
       do_saldo_int             = case do_estado_cartera when 4 then saldo_int_cas else saldo_int end,
       do_saldo_otros           = case do_estado_cartera when 4 then saldo_otr_cas else saldo_otr end,
       do_saldo_int_contingente = case do_estado_cartera when 4 then 0             else int_cont  end,
       do_saldo_otr_contingente = case do_estado_cartera when 4 then 0             else otr_cont  end,                     -- GAL/AZU 30/JUL/2010 - OMC
       do_saldo                 = case do_estado_cartera
                                  when 4 then saldo_cap_cas + saldo_int_cas + saldo_otr_cas
                                  else saldo_cap + saldo_int + saldo_otr + int_cont + otr_cont      -- GAL/AZU 10/AGO/2010 - OMC - (otr_cont)
                                  end 
       from #sb_datos_rubros_tmp
       where do_banco           = banco     
       
       if @@error <> 0 begin
          exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @i_fecha_proceso,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28003',
               @i_descrp_error  = 'ERROR AL ACTUALIZAR LOS SALDOS DE LA OPERACION'           
       end        

       /* ELIMINAR SI EXISTEN, LOS DATOS DE LA SB_DATO_OPERACION */
       if exists (select 1 from sb_dato_operacion
                   where do_fecha      = @i_fecha_proceso
                     and do_aplicativo = @w_aplicativo) 
       begin
          delete sb_dato_operacion
          where do_fecha      = @i_fecha_proceso
          and  do_aplicativo = @w_aplicativo
       end
	   
	   /* ELIMINAR SI EXISTEN, LOS DATOS DE LA SB_DATO_OPERACION */
       if exists (select 1 from sb_dato_verificacion
                   where dv_fecha      = @i_fecha_proceso) 
       begin
          delete sb_dato_verificacion 
          where dv_fecha      = @i_fecha_proceso
       end
             
       insert into sb_dato_operacion
       select * from #sb_dato_operacion_tmp
       ORDER BY do_banco

       if @@error <> 0 begin
          exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @i_fecha_proceso,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28003',
               @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_OPERACION'           
       end
     
	   print 'guarda informacion en el sb_dato_operacion'
	   
	    -- Inicio Req.205892
	    if exists(select 1 from sb_operacion
                  where op_fecha    = @i_fecha_proceso
                  and op_aplicativo = @w_aplicativo)
        begin
            delete sb_operacion
            where op_aplicativo = @w_aplicativo
            and   op_fecha      = @i_fecha_proceso   
        end   
      
        insert into dbo.sb_operacion (  
        op_fecha        ,  op_operacion ,  op_banco,
        op_cliente      ,  op_toperacion,  op_aplicativo)
        select
	    eo_fecha        , eo_operacion ,   eo_banco,
	    eo_cliente      , eo_toperacion,   eo_aplicativo
	    from  cob_externos..ex_operacion  
        where eo_fecha      = @i_fecha_proceso
        and   eo_aplicativo = @w_aplicativo  
        and   not exists (select 1 from dbo.sb_operacion where op_operacion = eo_operacion)
		
		print 'guarda informacion en el sb_operacion'		
		-- Fin Req.205892
		
	   
	   insert into sb_dato_verificacion 
	   select * from cob_externos..ex_dato_verificacion 
	   ORDER BY dv_fecha, dv_cliente
	   
	   if @@error <> 0 begin
        exec cob_conta_super..sp_errorlog
             @i_operacion     = 'I',
             @i_fecha_fin     = @i_fecha_proceso,
             @i_fuente        = @w_sp_name,
             @i_origen_error  = '28003',
             @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_VERIFICACION' 
       end 
       
       /* ELIMINAR SI EXISTEN, LOS DATOS DE LA sb_cuota_minima */
       if exists (select 1 from sb_cuota_minima
                   where cm_fecha      = @i_fecha_proceso
                     ) 
       begin
          delete sb_cuota_minima 
          where cm_fecha      = @i_fecha_proceso
       end
       
       insert into sb_cuota_minima(
       	        cm_fecha      ,  cm_aplicativo,     cm_banco  ,
                cm_monto      ,  cm_capital   ,     cm_interes,
                cm_iva_interes,  cm_comision  ,     cm_iva_comision)
	   select 	cm_fecha      ,  cm_aplicativo,     cm_banco  ,
                cm_monto      ,  cm_capital   ,     cm_interes,
                cm_iva_interes,  cm_comision  ,     cm_iva_comision 
	   from cob_externos..ex_cuota_minima
	   
	   /* ELIMINAR SI EXISTEN, LOS DATOS DE LA sb_datos_lcr */
	   
	   if exists (select 1 from sb_datos_lcr
                   where dl_fecha      = @i_fecha_proceso
                     ) 
       begin
          delete sb_datos_lcr 
           where dl_fecha      = @i_fecha_proceso
           
       end
       
       print 'Antes de cargar los datos de la lcr'
       insert into sb_datos_lcr (
                dl_fecha                 ,    dl_aplicativo            ,    dl_banco                ,
	            dl_dias_de_atraso_6_meses,    dl_dias_de_atraso_3_meses,    dl_num_de_atraso_6_meses,
                dl_num_de_atraso_3_meses ,    dl_num_incrementos       ,    dl_num_estrellas        ,
                dl_fecha_prox_aumento    ,    dl_fecha_ult_aumento     ,    dl_bloqueado            ,
                dl_usuario_ult_modifica  ,    dl_num_renovacion        ,    dl_credito_anterior)       
       select   dl_fecha                 ,    dl_aplicativo            ,    dl_banco                ,
                dl_dias_de_atraso_6_meses,    dl_dias_de_atraso_3_meses,    dl_num_de_atraso_6_meses,
                dl_num_de_atraso_3_meses ,    dl_num_incrementos       ,    dl_num_estrellas        ,
                dl_fecha_prox_aumento    ,    dl_fecha_ult_aumento     ,    dl_bloqueado            ,
                dl_usuario_ult_modifica  ,    dl_num_renovacion        ,    dl_credito_anterior 
       from   cob_externos..ex_datos_lcr     
       	               
       /***ELIMINANDO DATOS EN SB_DATO_OPERACION_RUBRO ***/
       if exists (select 1 from sb_dato_operacion_rubro
                   where dr_fecha      = @i_fecha_proceso
                     and dr_aplicativo = @w_aplicativo)
       begin
          delete sb_dato_operacion_rubro
          where dr_fecha      = @i_fecha_proceso
          and dr_aplicativo = @w_aplicativo
       end

       PRINT 'Inicia insercion  --> sb_dato_operacion_rubro ' + convert(varchar(30),getdate())
	   
       /***INSERTANDO DATOS EN SB_DATO_OPERACION_RUBRO ***/
       insert into cob_conta_super..sb_dato_operacion_rubro(
       dr_fecha            ,dr_banco            ,dr_toperacion,
       dr_aplicativo       ,dr_concepto         ,dr_estado,
	   dr_exigible         ,dr_codvalor         ,dr_valor,
	   dr_cuota            ,dr_acumulado        ,dr_pagado,
	   dr_categoria        ,dr_rubro_aso        ,dr_cat_rub_aso)
       select 
       dr_fecha            ,dr_banco            ,dr_toperacion,
       dr_aplicativo       ,dr_concepto         ,dr_estado,
       dr_exigible         ,dr_codvalor         ,isnull(dr_valor,0),
	   dr_cuota            ,dr_acumulado        ,dr_pagado,
	   dr_categoria        ,dr_rubro_aso        ,dr_cat_rub_aso
       from cob_externos..ex_dato_operacion_rubro
       where dr_fecha      = @i_fecha_proceso
       and   dr_aplicativo = @w_aplicativo 
       ORDER BY dr_fecha, dr_banco, dr_concepto, dr_estado
      
       if @@error <> 0 begin
          exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @i_fecha_proceso,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28003',
               @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_OPERACION_RUBRO' 
       end  
       PRINT 'Finaliza insercion  --> sb_dato_operacion_rubro ' + convert(varchar(30),getdate())

       /***ELIMINANDO DATOS EN SB_PAGO_RECONO ***/--RQ293
       if exists (select 1 from sb_pago_recono
                   where pr_fecha_rep  = @i_fecha_proceso
                     and pr_aplicativo = @w_aplicativo)
       begin
          delete sb_pago_recono
          where pr_fecha_rep  = @i_fecha_proceso
          and pr_aplicativo = @w_aplicativo
       end

       PRINT 'Inicia insercion  --> sb_pago_recono ' + convert(varchar(30),getdate())
       /***INSERTANDO DATOS EN SB_PAGO_RECONO ***/--RQ293
       insert into cob_conta_super..sb_pago_recono(
       pr_fecha_rep           ,pr_aplicativo           ,pr_banco               ,
       pr_trn                 ,pr_fecha                ,pr_fecha_ult_pago      ,
       pr_vlr                 ,pr_vlr_amort            ,pr_estado              ,
       pr_tipo_gar            ,pr_subtipo_gar          ,pr_3nivel_gar          ,
       pr_vlr_calc_fijo       ,pr_div_pend             ,pr_div_venc)
       select
       pr_fecha_rep           ,pr_aplicativo           ,pr_banco               ,
       pr_trn                 ,pr_fecha                ,pr_fecha_ult_pago      ,
       isnull(pr_vlr,0)       ,isnull(pr_vlr_amort,0)  ,pr_estado              ,
       pr_tipo_gar            ,pr_subtipo_gar          ,pr_3nivel_gar          ,
       pr_vlr_calc_fijo       ,pr_div_pend             ,pr_div_venc
       from cob_externos..ex_pago_recono
       where pr_fecha_rep  = @i_fecha_proceso
       and   pr_aplicativo = @w_aplicativo 
       PRINT 'Finaliza insercion  --> sb_pago_recono ' + convert(varchar(30),getdate())
       
       /***ELIMINANDO DATOS EN SB_CONDONACION ***/--RQ230
       if exists (select 1 from sb_condonacion
                   where co_fecha  = @i_fecha_proceso
                     and co_aplicativo = @w_aplicativo)
       begin
          delete sb_condonacion
           where co_fecha  = @i_fecha_proceso
             and co_aplicativo = @w_aplicativo
       end

       PRINT 'Inicia insercion  --> sb_pago_recono ' + convert(varchar(30),getdate())
       /***INSERTANDO DATOS EN SB_CONDONACION ***/--RQ230
       insert into cob_conta_super..sb_condonacion(
       co_fecha           ,co_aplicativo          ,co_secuencial               ,
       co_banco           ,co_cliente             ,co_fecha_aplica             ,
       co_valor           ,co_porcentaje          ,co_concepto                 ,
       co_estado_concepto ,co_usuario             ,co_rol_condona              ,
       co_autoriza        ,co_estado)
       select
       co_fecha           ,co_aplicativo          ,co_secuencial               ,
       co_banco           ,co_cliente             ,co_fecha_aplica             ,
       co_valor           ,co_porcentaje          ,co_concepto                 ,
       co_estado_concepto ,co_usuario             ,co_rol_condona              ,
       co_autoriza        ,co_estado
       from cob_externos..ex_condonacion
       where co_fecha  = @i_fecha_proceso
       and   co_aplicativo = @w_aplicativo 
       
       if @@error <> 0 begin
          exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @i_fecha_proceso,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28006',
               @i_descrp_error  = 'ERROR INSERTANDO DATOS EN sb_condonacion' 
       END
       
       PRINT 'Finaliza insercion  --> sb_condonacion ' + convert(varchar(30),getdate())
       
       /***ELIMINANDO DATOS EN sb_op_reest_padre_hija ***/
       if exists (select 1 from sb_op_reest_padre_hija
                   where ph_fecha_proceso  = @i_fecha_proceso
                     and ph_aplicativo     = @w_aplicativo)
       begin
          delete sb_op_reest_padre_hija
           where ph_fecha_proceso  = @i_fecha_proceso
             and ph_aplicativo     = @w_aplicativo
       end

       PRINT 'Inicia insercion  --> sb_op_reest_padre_hija ' + convert(varchar(30),getdate())
       /***INSERTANDO DATOS EN SB_CONDONACION ***/--RQ230
       insert into cob_conta_super..sb_op_reest_padre_hija(
       ph_fecha_proceso,  ph_aplicativo,          ph_banco_padre,
       ph_banco_hija,     ph_ente,                ph_sec_reest,
       ph_fecha)
       select
       ph_fecha_proceso,  ph_aplicativo,          ph_banco_padre,
       ph_banco_hija,     ph_ente,                ph_sec_reest,
       ph_fecha
       from cob_externos..ex_op_reest_padre_hija
       where ph_fecha_proceso  = @i_fecha_proceso
       and   ph_aplicativo     = @w_aplicativo 
       
       if @@error <> 0 begin
          exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @i_fecha_proceso,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28006',
               @i_descrp_error  = 'ERROR INSERTANDO DATOS EN sb_op_reest_padre_hija' 
       end
       
       PRINT 'Finaliza insercion  --> sb_op_reest_padre_hija ' + convert(varchar(30),getdate())
       
       drop table #marcafng
       drop table #marcafng_def
       drop table #opera_normali
       drop table #maxi_calif_norm

       /***ELIMINANDO DATOS EN sb_dato_seguros ***/
       if exists (select 1 from sb_dato_seguros
                   where se_fecha      = @i_fecha_proceso
                     and se_aplicativo = @w_aplicativo)
       begin          
          delete sb_dato_seguros
           where se_fecha      = @i_fecha_proceso
             and se_aplicativo = @w_aplicativo
       end
 
       PRINT 'Inicia insercion  --> sb_dato_seguros ' + convert(varchar(30),getdate())
       /***INSERTANDO DATOS EN SB_DATO_SEGUROS ***/
       insert into cob_conta_super..sb_dato_seguros(
       se_fecha,         se_aplicativo,         se_sec_seguro,
       se_tipo_seguro,   se_sec_renovacion,     se_tramite,
       se_operacion,     se_fec_devolucion,     se_mto_devolucion,
       se_estado)
       select 
       se_fecha,         se_aplicativo,         se_sec_seguro,
       se_tipo_seguro,   se_sec_renovacion,     se_tramite,
       se_operacion,     se_fec_devolucion,     se_mto_devolucion,
       se_estado
       from cob_externos..ex_dato_seguros
       where se_fecha      = @i_fecha_proceso
       and   se_aplicativo = @w_aplicativo 
      
       if @@error <> 0 begin
          exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @i_fecha_proceso,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28003',
               @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_SEGURO' 
       end  
       PRINT 'Finaliza insercion  --> sb_dato_seguro ' + convert(varchar(30),getdate())	   

      /***ELIMINANDO DATOS EN sb_dato_seguros_det ***/
       if exists (select 1 from sb_dato_seguros_det
                   where sed_fecha      = @i_fecha_proceso
                     and sed_aplicativo = @w_aplicativo)
       begin          
          delete sb_dato_seguros_det
           where sed_fecha      = @i_fecha_proceso
             and sed_aplicativo = @w_aplicativo
       end
	   
       PRINT 'Inicia insercion  --> sb_dato_seguros_det ' + convert(varchar(30),getdate())
       /***INSERTANDO DATOS EN SB_DATO_SEGUROS_DET ***/
       insert into cob_conta_super..sb_dato_seguros_det(
       sed_fecha,          sed_aplicativo,  sed_operacion,
       sed_sec_seguro,     sed_tipo_seguro, sed_sec_renovacion, 
       sed_tipo_asegurado, sed_estado,      sed_dividendo,
       sed_cuota_cap,      sed_pago_cap,    sed_cuota_int,
       sed_pago_int,       sed_cuota_mora,  sed_pago_mora,
       sed_sec_asegurado)
       select 
       sed_fecha,          sed_aplicativo,  sed_operacion,
       sed_sec_seguro,     sed_tipo_seguro, sed_sec_renovacion, 
       sed_tipo_asegurado, sed_estado,      sed_dividendo,
       sed_cuota_cap,      sed_pago_cap,    sed_cuota_int,
       sed_pago_int,       sed_cuota_mora,  sed_pago_mora,
       sed_sec_asegurado
       from cob_externos..ex_dato_seguros_det
       where sed_fecha      = @i_fecha_proceso
       and   sed_aplicativo = @w_aplicativo 
      
       if @@error <> 0 begin
          exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @i_fecha_proceso,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28003',
               @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_SEGURO_DET' 
       end  
       PRINT 'Finaliza insercion  --> sb_dato_seguro_det ' + convert(varchar(30),getdate())      


      /* VENTA CARTERA CASTIGADA */
      /***ELIMINANDO DATOS EN sb_venta_universo ***/
       if exists (select 1 from sb_venta_universo
                   where vu_fecha      = @i_fecha_proceso
                     and vu_aplicativo = @w_aplicativo)
       begin          
          delete sb_venta_universo
           where vu_fecha      = @i_fecha_proceso
             and vu_aplicativo = @w_aplicativo
       end
	   
       PRINT 'Inicia insercion  --> sb_venta_universo ' + convert(varchar(30),getdate())
       /***INSERTANDO DATOS EN SB_VENTA_UNIVERSO ***/
       insert into cob_conta_super..sb_venta_universo(
       vu_fecha,             vu_aplicativo,         Id_cliente,
       Nombre_Cliente,       Tipo_Identificacion,   Segmento,           
       Ciudad_Desembolso,    Tipo_Producto,         Saldo_capital,      
       Intereses,            Otros_cargos,          Saldo_deuda_total,  
       Saldo_Mora,           Fecha_desembolso,      Valor_desembolso,   
       Plazo_credito,        Fecha_Mora,            Fecha_Castigo,      
       Edad_Mora,            Numero_Obli_o_Crd,     Existencia_acuerdo_pag,
       Estado_Cobranza,      Ciudad_Cred,           Valor_pagado,
       Fecha_Ult_pago,       Capital_Pagado,        Intereses_pagados,
       Otros_concep_pag,     Direccion_Cliente,     Ciudad,
       Telefono,             Fecha_Nacimiento,      Ingresos,
       Egresos,              Estrato,               Nivel_Estudio,
       Profesion,            Nota_Interna_Bmia,     Calificacion_Op,
       operacion_interna,    Banca,                 Oficina,            
       Cod_CIIU,             Fecha_Venta,           Secuencial_Ing_Ven, 
       Secuencial_Ing_Vig,   Secuencial_Ing_Nvig,   Estado_Venta,
       Id_Comprador,         Porc_Venta)                    
       select 
       vu_fecha,             vu_aplicativo,         Id_cliente,
       Nombre_Cliente,       Tipo_Identificacion,   Segmento,           
       Ciudad_Desembolso,    Tipo_Producto,         Saldo_capital,      
       Intereses,            Otros_cargos,          Saldo_deuda_total,  
       Saldo_Mora,           Fecha_desembolso,      Valor_desembolso,   
       Plazo_credito,        Fecha_Mora,            Fecha_Castigo,      
       Edad_Mora,            Numero_Obli_o_Crd,     Existencia_acuerdo_pag,
       Estado_Cobranza,      Ciudad_Cred,           Valor_pagado,
       Fecha_Ult_pago,       Capital_Pagado,        Intereses_pagados,
       Otros_concep_pag,     Direccion_Cliente,     Ciudad,
       Telefono,             Fecha_Nacimiento,      Ingresos,
       Egresos,              Estrato,               Nivel_Estudio,
       Profesion,            Nota_Interna_Bmia,     Calificacion_Op,
       operacion_interna,    Banca,                 Oficina,            
       Cod_CIIU,             Fecha_Venta,           Secuencial_Ing_Ven, 
       Secuencial_Ing_Vig,   Secuencial_Ing_Nvig,   Estado_Venta,
       Id_Comprador,         Porc_Venta                              
       from cob_externos..ex_venta_universo
       where vu_fecha      = @i_fecha_proceso
       and   vu_aplicativo = @w_aplicativo 
      
       if @@error <> 0 begin
          exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @i_fecha_proceso,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28003',
               @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_SEGURO' 
       end  
       PRINT 'Finaliza insercion  --> sb_venta_universo ' + convert(varchar(30),getdate())	          

       
      --REQ479 INSERTA DATOS EN SB_VAL_OPER_FINAGRO
      if exists (select 1 from cob_conta_super..sb_val_oper_finagro 
                  where vo_fecha      = @i_fecha_proceso
                    and vo_aplicativo = @w_aplicativo)
      begin       
         delete cob_conta_super..sb_val_oper_finagro 
          where vo_fecha      = @i_fecha_proceso
            and vo_aplicativo = @w_aplicativo
      end

      insert into cob_conta_super..sb_val_oper_finagro(
      vo_fecha,           vo_operacion,   vo_ced_ruc,    vo_tipo_ruc,
      vo_oper_finagro,    vo_num_gar,     vo_aplicativo)
      select 
      vo_fecha,           vo_operacion,   vo_ced_ruc,    vo_tipo_ruc,
      vo_oper_finagro,    vo_num_gar,     vo_aplicativo
      from  cob_externos..ex_val_oper_finagro
      where vo_fecha      = @i_fecha_proceso

      and   vo_aplicativo = @w_aplicativo

      if @@error <> 0 
      begin
         exec cob_conta_super..sp_errorlog
              @i_operacion     = 'I',
              @i_fecha_fin     = @i_fecha_proceso,
              @i_fuente        = @w_sp_name,
              @i_origen_error  = '28003',
              @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_VAL_OPER_FINAGRO' 
      end       
       
   end        

      /* DATOS DE LAS TRANSACCIONES */
   if @i_toperacion in ('DT','TO')
   BEGIN
      if exists (select 1 from sb_dato_transaccion
                 where dt_fecha      = @i_fecha_proceso
                  and dt_aplicativo = @w_aplicativo) 
      begin
          delete cob_conta_super..sb_dato_transaccion
          where dt_aplicativo = @w_aplicativo
          and dt_fecha      = @i_fecha_proceso
      end
        
      /*** INSERTA DATOS EN SB_DATO_TRANSACCION ***/
      insert into cob_conta_super..sb_dato_transaccion(
      dt_fecha,        dt_secuencial,      dt_banco,       dt_toperacion,
      dt_aplicativo,   dt_fecha_trans,     dt_tipo_trans,  dt_reversa,
      dt_naturaleza,   dt_canal,           dt_oficina,     dt_secuencial_caja,
      dt_usuario,      dt_terminal,        dt_fecha_hora)
      select 
      dt_fecha,        dt_secuencial,      dt_banco,       dt_toperacion,
      dt_aplicativo,   dt_fecha_trans,     dt_tipo_trans,  dt_reversa,
      dt_naturaleza,   dt_canal,           dt_oficina,     dt_secuencial_caja,
      dt_usuario,      dt_terminal,        dt_fecha_hora
      from cob_externos..ex_dato_transaccion
      where dt_fecha      = @i_fecha_proceso
      and   dt_aplicativo = @w_aplicativo
      ORDER BY dt_fecha, dt_banco, dt_secuencial
             
      if @@error <> 0
      begin
         exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @i_fecha_proceso,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28006',
               @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_TRANSACCION' 
      end
      
      /*** ELIMINANDO DATOS EN SB_DATO_TRANSACCION_DET ***/
      if exists (select 1 from sb_dato_transaccion_det
                 where dd_fecha      = @i_fecha_proceso
                 and dd_aplicativo = @w_aplicativo)
      begin 
         delete sb_dato_transaccion_det
         where dd_aplicativo = @w_aplicativo
         and dd_fecha      = @i_fecha_proceso 
      end
	   
      /*** INSERTA DATOS EN SB_DATO_TRANSACCION_DET ***/  
      insert into cob_conta_super..sb_dato_transaccion_det(
      dd_fecha,        dd_secuencial,      dd_banco,             dd_toperacion,
      dd_aplicativo,   dd_concepto,        dd_moneda,            dd_cotizacion,
      dd_monto,        dd_codigo_valor,    dd_origen_efectivo,   dd_dividendo)
      select
      dd_fecha,        dd_secuencial,      dd_banco,            dd_toperacion,
      dd_aplicativo,   dd_concepto,        dd_moneda,           isnull(dd_cotizacion,0),    
      dd_monto,        dd_codigo_valor,    dd_origen_efectivo,  dd_dividendo
      from cob_externos..ex_dato_transaccion_det
      where dd_fecha      = @i_fecha_proceso
      and   dd_aplicativo = @w_aplicativo
      ORDER BY dd_fecha, dd_banco, dd_secuencial
         
      if @@error <> 0 begin
         exec cob_conta_super..sp_errorlog
              @i_operacion     = 'I',
              @i_fecha_fin     = @i_fecha_proceso,
              @i_fuente        = @w_sp_name,
              @i_origen_error  = '28007',
              @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_TRANSACCION_DET' 
      end
       
      /*** ELIMINANDO DATOS EN SB_DATO_TRANSACCION_EFEC ***/
      if exists (select 1 from #aplicativo, sb_dato_transaccion_efec
                 where di_fecha      = @i_fecha_proceso
                 and di_aplicativo = aplicativo)
      begin 
         delete cob_conta_super..sb_dato_transaccion_efec
         from #aplicativo, sb_dato_transaccion_efec
         where di_aplicativo = aplicativo
         and di_fecha      = @i_fecha_proceso 
      end
         
      /*** INSERTA DATOS EN SB_DATO_TRANSACCION_EFEC ***/  
      insert into cob_conta_super..sb_dato_transaccion_efec(
      di_fecha,                di_aplicativo,         di_secuencial_caja,   di_banco,
      di_nombre_tit,           di_doc_tipo_tit,       di_iden_tit,            di_cliente,
      di_doc_tipo_pri_autor,   di_iden_pri_autor,     di_nombres_pri_autor, di_p_apellido_pri_autor,
      di_s_apellido_pri_autor, di_doc_tipo_seg_autor, di_iden_seg_autor,    di_nombres_seg_autor,   
      di_p_apellido_seg_autor, di_s_apellido_seg_autor)
      select
      di_fecha,                di_aplicativo,         di_secuencial_caja,   di_banco,
      di_nombre_tit,           di_doc_tipo_tit,       di_iden_tit,          di_cliente,
      di_doc_tipo_pri_autor,   di_iden_pri_autor,     di_nombres_pri_autor, di_p_apellido_pri_autor,
      di_s_apellido_pri_autor, di_doc_tipo_seg_autor, di_iden_seg_autor,    di_nombres_seg_autor,   
      di_p_apellido_seg_autor, di_s_apellido_seg_autor
      from cob_externos..ex_dato_transaccion_efec
      where di_fecha = @i_fecha_proceso
      
      if @@error <> 0 begin
         exec cob_conta_super..sp_errorlog
              @i_operacion     = 'I',
              @i_fecha_fin     = @i_fecha_proceso,
              @i_fuente        = @w_sp_name,
              @i_origen_error  = '28008',
              @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_TRANSACCION_EFEC' 
      end
      
      /*** ELIMINANDO DATOS EN SB_DATO_REAJUSTE ***/
      if exists (select 1 from sb_dato_reajuste where dr_fecha = @i_fecha_proceso)
      begin
         delete cob_conta_super..sb_dato_reajuste
         where dr_fecha = @i_fecha_proceso
      end

      /*** INSERTA DATOS EN SB_DATO_REAJUSTE ***/
      insert into cob_conta_super..sb_dato_reajuste(
      dr_fecha,               dr_aplicativo,
      dr_secuencial,          dr_operacion,    dr_fecha_crea,                          
      dr_reajuste_especial,   dr_desagio,      dr_sec_aviso,
      dr_concepto,            dr_referencial,  dr_signo,               
      dr_factor,              dr_porcentaje)   
      select 
      dr_fecha,               dr_aplicativo,
      dr_secuencial,          dr_operacion,    dr_fecha_crea,    
      dr_reajuste_especial,   dr_desagio,      dr_sec_aviso,
      dr_concepto,            dr_referencial,  dr_signo,               
      dr_factor,              dr_porcentaje
      from cob_externos..ex_dato_reajuste
      where dr_fecha = @i_fecha_proceso
       
      if @@error <> 0 begin
         exec cob_conta_super..sp_errorlog
              @i_operacion     = 'I',
              @i_fecha_fin     = @i_fecha_proceso,
              @i_fuente        = @w_sp_name,
              @i_origen_error  = '28009',
              @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_REAJUSTE' 
      end
       
      /*** ELIMINANDO DATOS EN SB_MSV_PROC_CA ***/
      if exists (select 1 from sb_msv_proc_ca
                  where mp_fecha_proc = @i_fecha_proceso)
      begin
         delete cob_conta_super..sb_msv_proc_ca
         where mp_fecha_proc =  @i_fecha_proceso
      end
      
      /*** INSERTA DATOS EN SB_MSV_PROC_CA ***/
      insert into cob_conta_super..sb_msv_proc_ca(
      mp_fecha,     mp_aplicativo, 
      mp_id_carga,  mp_id_alianza,    mp_tipo_tr,                          
      mp_tramite,   mp_tipo,          mp_banco,
      mp_estado,    mp_monto,         mp_toperacion,               
      mp_tasa,      mp_descripcion,   mp_fecha_proc)   
      select 
      mp_fecha,     mp_aplicativo, 
      mp_id_carga,  mp_id_alianza,    mp_tipo_tr,                          
      mp_tramite,   mp_tipo,          mp_banco,
      mp_estado,    mp_monto,         mp_toperacion,               
      mp_tasa,      mp_descripcion,   mp_fecha_proc
      from cob_externos..ex_msv_proc_ca
      where mp_fecha_proc = @i_fecha_proceso
      
      if @@error <> 0
      begin
         exec cob_conta_super..sp_errorlog
              @i_operacion     = 'I',
              @i_fecha_fin     = @i_fecha_proceso,
              @i_fuente        = @w_sp_name,
              @i_origen_error  = '28010',
              @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_MSV_PROC_CA' 
      end
    
      --REQ425
      if exists (select 1 from sb_dato_castigos
                 where dt_fecha      = @i_fecha_proceso
                 and dt_aplicativo = @w_aplicativo) 
      begin
         delete cob_conta_super..sb_dato_castigos
         where dt_aplicativo = @w_aplicativo
         and dt_fecha      = @i_fecha_proceso
      end
      
      -- INSERTA DATOS EN SB_DATO_CASTIGOS 
      insert into cob_conta_super..sb_dato_castigos(
      dt_fecha,        dt_secuencial,      dt_banco,       dt_toperacion,
      dt_aplicativo,   dt_fecha_trans,     dt_tipo_trans,  dt_reversa,
      dt_naturaleza,   dt_canal,           dt_oficina,     dt_secuencial_caja,
      dt_usuario,      dt_terminal,        dt_fecha_hora)
      select 
      dt_fecha,        dt_secuencial,      dt_banco,       dt_toperacion,
      dt_aplicativo,   dt_fecha_trans,     dt_tipo_trans,  dt_reversa,
      dt_naturaleza,   dt_canal,           dt_oficina,     dt_secuencial_caja,
      dt_usuario,      dt_terminal,        dt_fecha_hora
      from cob_externos..ex_dato_castigos
      where dt_fecha      = @i_fecha_proceso
      and   dt_aplicativo = @w_aplicativo
      
      if @@error <> 0
      begin
         exec cob_conta_super..sp_errorlog
              @i_operacion     = 'I',
              @i_fecha_fin     = @i_fecha_proceso,
              @i_fuente        = @w_sp_name,
              @i_origen_error  = '28006',
              @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_CASTIGOS' 
      end
      
      -- ELIMINANDO DATOS EN SB_DATO_CASTIGOS_DE
      if exists (select 1 from sb_dato_castigos_det
                 where dd_fecha      = @i_fecha_proceso
                 and   dd_aplicativo = @w_aplicativo)
      begin 
         delete sb_dato_castigos_det
         where dd_aplicativo = @w_aplicativo
         and dd_fecha      = @i_fecha_proceso 
      end
         
      --  INSERTA DATOS EN SB_DATO_CASTIGOS_DET 
      insert into cob_conta_super..sb_dato_castigos_det(
      dd_fecha,        dd_secuencial,      dd_banco,       dd_toperacion,
      dd_aplicativo,   dd_concepto,        dd_moneda,      dd_cotizacion,
      dd_monto,        dd_codigo_valor)
      select
      dd_fecha,        dd_secuencial,      dd_banco,       dd_toperacion,
      dd_aplicativo,   dd_concepto,        dd_moneda,      isnull(dd_cotizacion,0),    
      dd_monto,        dd_codigo_valor
      from cob_externos..ex_dato_castigos_det
      where dd_fecha      = @i_fecha_proceso
      and   dd_aplicativo = @w_aplicativo
         
      if @@error <> 0 
      begin
         exec cob_conta_super..sp_errorlog
              @i_operacion     = 'I',
              @i_fecha_fin     = @i_fecha_proceso,
              @i_fuente        = @w_sp_name,
              @i_origen_error  = '28007',
              @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_CASTIGOS_DET' 
      end --REQ425	
	
	  /* ELIMINAR SI EXISTEN, LOS DATOS DE LA SB_DATO_OPERACION_ABONO */
      if exists (select 1 from sb_dato_operacion_abono
                 where doa_fecha      = @i_fecha_proceso
                 and doa_aplicativo = @w_aplicativo) 
      begin
         delete sb_dato_operacion_abono
         where doa_fecha      = @i_fecha_proceso
         and  doa_aplicativo = @w_aplicativo
      end
      
      INSERT INTO cob_conta_super..sb_dato_operacion_abono (doa_aplicativo , 		doa_fecha , 		doa_banco , 
      doa_operacion  , 		doa_sec_pag , 		doa_fecha_pag , 
      doa_di_fecha_ven ,	doa_dividendo , 	doa_dias_atraso ,
      doa_fpago ,   		   doa_total , 		doa_capital , 
      doa_int , 		      doa_otro , 		   doa_saldo_cap , 
      doa_sec_ing , 		   doa_oficina , 		doa_estado , 
      doa_usuario , 		   doa_moneda, doa_iva_int,
      doa_imo             ,doa_iva_imo      ,doa_disp,
      doa_iva_disp        ,doa_objetado     ,doa_sec_rpa      ,
      doa_tipo_trn        ,doa_condonaciones)--JEOM Se agrega el campo de si corresponde a una condonación
      SELECT 
      doa_aplicativo , 		doa_fecha , 		doa_banco , 
      doa_operacion  , 		doa_sec_pag , 		doa_fecha_pag , 
      doa_di_fecha_ven ,	doa_dividendo , 	doa_dias_atraso ,
      doa_fpago ,   		   doa_total , 		doa_capital , 
      doa_int , 		      doa_otro , 		   doa_saldo_cap , 
      doa_sec_ing , 		   doa_oficina , 		doa_estado , 
      doa_usuario , 		   doa_moneda       ,doa_iva_int,
      doa_imo             ,doa_iva_imo      ,doa_disp,
      doa_iva_disp        ,doa_objetado     ,doa_sec_rpa      ,
      doa_tipo_trn        ,doa_condonaciones--JEOM Se agrega el campo de si corresponde a una condonación
      FROM cob_externos..ex_dato_operacion_abono
      where doa_fecha      = @i_fecha_proceso
      and   doa_aplicativo = @w_aplicativo
      ORDER BY doa_fecha, doa_aplicativo, doa_banco, doa_sec_pag
      
  	  if @@error <> 0
	  BEGIN
         exec cob_conta_super..sp_errorlog
              @i_operacion     = 'I',
              @i_fecha_fin     = @i_fecha_proceso,
              @i_fuente        = @w_sp_name,
              @i_origen_error  = '28003',
              @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_VERIFICACION' 
      END 
   END
   
   /* DATOS DE LAS PROYECCIONES DE CUOTAS */
   if @i_toperacion = 'PY' or @i_toperacion = 'TO' begin

       /*** ELIMINANDO DATOS EN SB_DATO_CUOTA_PRY ***/
       if exists (select 1 from sb_dato_cuota_pry
                   where dc_fecha      = @i_fecha_proceso
                     and dc_aplicativo = @w_aplicativo)
       begin
           delete cob_conta_super..sb_dato_cuota_pry
             from sb_dato_cuota_pry
            where dc_aplicativo = @w_aplicativo
              and dc_fecha      = @i_fecha_proceso   
       end

       /*** INSERTA DATOS EN SB_DATO_CUOTA_PRY ***/  
       insert into cob_conta_super..sb_dato_cuota_pry(
       dc_fecha,            dc_banco,           dc_toperacion,      dc_aplicativo,
       dc_num_cuota,        dc_fecha_vto,       dc_estado,          dc_valor_pry,
       /* NUEVOS CAMPOS */
       -- LGU 2018-01-15
	   dc_cap_cuota     ,	dc_int_cuota     ,	dc_imo_cuota     ,
	   dc_pre_cuota     ,	dc_iva_int_cuota ,	dc_iva_imo_cuota ,
	   dc_iva_pre_cuota ,	dc_otros_cuota   ,	dc_int_acum      ,  dc_iva_int_acum ,
	   dc_cap_pag       ,	dc_int_pag       ,	dc_imo_pag       ,
	   dc_pre_pag       ,	dc_iva_int_pag   ,	dc_iva_imo_pag   ,
	   dc_iva_pre_pag   ,	dc_otros_pag     ,  dc_fecha_can     ,  dc_fecha_upago,
	   dc_fecha_ini     ,   dc_com_lcr       ,  dc_ivacom_lcr
       )
       select 
       dc_fecha,            dc_banco,           dc_toperacion,      dc_aplicativo,
       dc_num_cuota,        dc_fecha_vto,       dc_estado,          dc_valor_pry,
       /* NUEVOS CAMPOS */
       -- LGU 2018-01-15
	   dc_cap_cuota     ,	dc_int_cuota     ,	dc_imo_cuota     ,
	   dc_pre_cuota     ,	dc_iva_int_cuota ,	dc_iva_imo_cuota ,
	   dc_iva_pre_cuota ,	dc_otros_cuota   ,	dc_int_acum      ,  dc_iva_int_acum ,
	   dc_cap_pag       ,	dc_int_pag       ,	dc_imo_pag       ,
	   dc_pre_pag       ,	dc_iva_int_pag   ,	dc_iva_imo_pag   ,
	   dc_iva_pre_pag   ,	dc_otros_pag     ,  dc_fecha_can,       dc_fecha_upago,
	   dc_fecha_ini     ,   dc_com_lcr       ,  dc_ivacom_lcr 
       from cob_externos..ex_dato_cuota_pry
       where dc_fecha      = @i_fecha_proceso 
       and   dc_aplicativo = @w_aplicativo
       ORDER BY dc_banco, dc_num_cuota  
    
       if @@error <> 0 begin
          exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @i_fecha_proceso,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28009',
               @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_CUOTA_PRY' 
          
       end
	   
	   
	    
   --OPERACIONES LCR
   select 
   banco      = dc_banco,
   cuota      = dc_num_cuota,
   fecha_ini  = dc_fecha_ini,
   fecha_fin  = dc_fecha_vto
   into #operaciones_lcr 
   from cob_conta_super..sb_dato_cuota_pry
   where dc_toperacion = 'REVOLVENTE'
   and   dc_fecha = @i_fecha_proceso
   and   dc_aplicativo = 7 

   --FECHAS INI DE TODAS LAS OPERACION SE CONSIDERAN LA FECHA DE LA PRIMERA UTILIZACION 
   
   
   select 
   prestamo        = tr_banco,
   fec_primer_des  = min(tr_fecha_ref) 
   into #primera_utilizacion 
   from cob_cartera..ca_transaccion ,#operaciones_lcr
   where tr_tran= 'DES'
   and tr_banco = banco
   and tr_estado <> 'RV'
   and tr_secuencial >0
   group by tr_banco
   
   --ACTUALIZAMOS LA TABLA DE LAS OPERACIONES LCR DE LA CUOTA 1 CONSIDERANDO LA FECHA DEL PRIMER DESEMSBOLSO
   update #operaciones_lcr set 
   fecha_ini = fec_primer_des
   from #primera_utilizacion  
   where prestamo = banco
   and  cuota = 1  
   
   --COMISIONES DENTRO DEL PERIODO DE VIGENCIA 
   --PERIODO DE VIGENCIAS [FECHA INI,FECHA FIN)

   select 
   banco      = tr_banco,
   cuota      = cuota,
   comisiones =sum(case when  dtr_concepto in ('COM')      then  dtr_monto else 0 end ),
   iva_com    =sum(case when  dtr_concepto in ('IVA_COM')  then  dtr_monto else 0 end )
   into #comisiones 
   from cob_cartera..ca_transaccion,cob_cartera..ca_det_trn ,#operaciones_lcr
   where tr_banco           = banco
   and   tr_tran            = 'DES' 
   and   dtr_concepto       in ('COM', 'IVA_COM')
   and   tr_operacion       =dtr_operacion 
   and   tr_secuencial     = dtr_secuencial
   and   tr_secuencial      >0 
   and   tr_estado         <> 'RV'
   and   tr_fecha_ref >= fecha_ini and tr_fecha_ref < fecha_fin
   group by tr_banco,cuota
   
   
   --ACTUALIZAMOS TABLA FINAL

   update cob_conta_super..sb_dato_cuota_pry set 
   dc_com_lcr    = comisiones,
   dc_ivacom_lcr = iva_com  
   from #comisiones
   where banco    = dc_banco
   and   cuota    = dc_num_cuota
   and   dc_fecha = @i_fecha_proceso
   and   dc_aplicativo = 7    
	   
	   
	   
	   

       /*** ELIMINANDO DATOS EN SB_DATO_RUBRO_PRY ***/
      if exists (select 1 from sb_dato_rubro_pry
                  where dr_fecha      = @i_fecha_proceso
                    and dr_aplicativo = @w_aplicativo)
      begin
         delete sb_dato_rubro_pry
          where dr_aplicativo = @w_aplicativo
            and dr_fecha      = @i_fecha_proceso   
      end
																																						   
      /*** INSERTA DATOS EN SB_DATO_RUBRO_PRY ***/  
      insert into cob_conta_super..sb_dato_rubro_pry(
      dr_fecha,        dr_banco,       dr_toperacion,      dr_aplicativo,
      dr_num_cuota,    dr_concepto,    dr_estado,          dr_valor_pry)
      select 
      dr_fecha,        dr_banco,       dr_toperacion,      dr_aplicativo,
      dr_num_cuota,    dr_concepto,    dr_estado,          dr_valor_pry
      from cob_externos..ex_dato_rubro_pry
      where dr_fecha      = @i_fecha_proceso 
      and   dr_aplicativo = @w_aplicativo                
      
      if @@error <> 0 begin
          exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @i_fecha_proceso,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28010',
               @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_RUBRO_PRY'           
      end
                
   end

   /* DATOS DE LOS DEUDORES DE LAS OPERACIONES */
   if @i_toperacion = 'DD' or @i_toperacion = 'TO' begin

      /*** ELIMINA DATOS EN SB_DATO_DEUDORES ***/
      if exists (select 1 from sb_dato_deudores
                  where de_fecha      = @i_fecha_proceso
                    and de_aplicativo = @w_aplicativo)
      begin
        delete sb_dato_deudores
         where de_aplicativo = @w_aplicativo
           and de_fecha      = @i_fecha_proceso 
      end

      /*** INSERTA DATOS EN SB_DATO_DEUDORES ***/
      insert into cob_conta_super..sb_dato_deudores(
      de_fecha,        de_banco,       de_toperacion,      de_aplicativo,
      de_rol,          de_cliente)
      select 
      de_fecha,        de_banco,       de_toperacion,      de_aplicativo,
      de_rol,          case de_cliente when 0 then @w_bancamia else de_cliente end      
      from cob_externos..ex_dato_deudores
      where de_fecha      = @i_fecha_proceso
      and   de_aplicativo = @w_aplicativo

       if @@error <> 0 begin
          exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @i_fecha_proceso,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28011',
               @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_DEUDORES'           
       end

      /*** INSERTANDO LOG DE ERRORES ***/
      insert into sb_errorlog(
      er_fecha,            er_fecha_proc,      er_fuente,      er_origen_error,
      er_descrp_error) 
      select 
      @i_fecha_proceso,    getdate(),          @w_sp_name,     (de_banco + de_toperacion + de_rol), 
      'ERROR CLIENTE NO EXISTE'
      from cob_externos..ex_dato_deudores 
      where de_cliente    = @w_bancamia   
      and   de_fecha      = @i_fecha_proceso
      and   de_aplicativo = @w_aplicativo 

   end

   /* DATOS DE TRAMITES */
   if @i_toperacion = 'TR' or @i_toperacion = 'TO' begin
      
      /*** ELIMINA DATOS EN SB_DATO_TRAMITE ***/

      if exists (select 1 from sb_impresion_cartas where ic_fecha_proceso = @i_fecha_proceso)
      begin
        delete from sb_impresion_cartas 
         where ic_fecha_proceso = @i_fecha_proceso
           and ic_aplicativo = @w_aplicativo
      end
      
      if exists (select 1 from sb_potenciales_cupo where pt_fecha_proceso = @i_fecha_proceso)
      begin
        delete from sb_potenciales_cupo 
         where pt_fecha_proceso = @i_fecha_proceso
           and pt_aplicativo = @w_aplicativo
      end

      if exists (select 1 from sb_dato_tramite where dt_fecha = @i_fecha_proceso) begin
         delete sb_dato_tramite
          where dt_fecha      = @i_fecha_proceso        
            and dt_aplicativo = @w_aplicativo
      end 
      if exists (select 1 from sb_dato_tramite_sit where ts_fecha = @i_fecha_proceso) begin
         delete sb_dato_tramite_sit
          where ts_fecha      = @i_fecha_proceso        
            and ts_aplicativo = @w_aplicativo

         delete sb_dato_ruta
          where dr_fecha      = @i_fecha_proceso
            and dr_aplicativo = @w_aplicativo
         
         delete sb_dato_microempresa
          where dm_fecha      = @i_fecha_proceso        
            and dm_aplicativo = @w_aplicativo

         delete sb_dato_microempresa_sit
          where ms_fecha      = @i_fecha_proceso        
            and ms_aplicativo = @w_aplicativo

         delete sb_dato_bal_fnciero
          where bf_fecha      = @i_fecha_proceso        
            and bf_aplicativo = @w_aplicativo

         delete sb_dato_bal_fnciero_det
          where bd_fecha      = @i_fecha_proceso        
            and bd_aplicativo = @w_aplicativo

         delete sb_dato_bal_resultado
          where br_fecha      = @i_fecha_proceso        
            and br_aplicativo = @w_aplicativo
         
         delete sb_dato_causa_rechazo 
          where cr_fecha      = @i_fecha_proceso        
            and cr_aplicativo = @w_aplicativo

         delete sb_dato_encuesta_preg
          where ep_fecha      = @i_fecha_proceso        
            and ep_aplicativo = @w_aplicativo
         
         delete sb_dato_encuesta_resp
          where er_fecha      = @i_fecha_proceso        
            and er_aplicativo = @w_aplicativo
         
          --control de cambio 260
         delete sb_calificacion_orig
          where cm_fecha      = @i_fecha_proceso        
            and cm_aplicativo = @w_aplicativo
      end
      
      -- INI - REQ 184 - COMPLEMENTO REPOSITORIO - GAL 09/DIC/2010
      if exists (select 1 from sb_micro_seguro where ms_fecha = @i_fecha_proceso) begin
         delete sb_micro_seguro
          where ms_fecha = @i_fecha_proceso
         
         delete sb_aseg_microseguro
          where am_fecha = @i_fecha_proceso
         
         delete sb_benefic_micro_aseg
          where bm_fecha = @i_fecha_proceso
         
         delete sb_enfermedades
          where en_fecha = @i_fecha_proceso
      end
      
      if exists (select 1 from sb_variables_entrada_mir where ve_fecha = @i_fecha_proceso) begin
         delete sb_variables_entrada_mir
          where ve_fecha = @i_fecha_proceso
      end
      
      if exists (select 1 from sb_respuestas_variables_mir where rv_fecha = @i_fecha_proceso) begin
         delete sb_respuestas_variables_mir
          where rv_fecha = @i_fecha_proceso
      end
      
      if exists (select 1 from sb_filtros where fi_fecha = @i_fecha_proceso) begin
         delete sb_filtros
          where fi_fecha = @i_fecha_proceso
         
         ---Inicio MAL04282011 ---
         
         delete  sb_ruta_filtros
          where rf_fecha = @i_fecha_proceso

         delete  sb_pasos_filtros
          where pf_fecha = @i_fecha_proceso
         
         ---Fin MAL04282011 ---
                 
         delete sb_def_variables_filtros
          where df_fecha = @i_fecha_proceso
         
         delete sb_variables_filtros
          where vf_fecha = @i_fecha_proceso
         
         delete sb_valor_variables_filtros
          where vv_fecha = @i_fecha_proceso
      end
      -- FIN - REQ 184 - COMPLEMENTO REPOSITORIO - GAL 09/DIC/2010

      --CCA 366
      if exists (select 1 from sb_seguros_tramite where st_fecha = @i_fecha_proceso) begin
         delete sb_seguros_tramite
          where st_fecha      = @i_fecha_proceso        
            and st_aplicativo = @w_aplicativo
      end

      if exists (select 1 from sb_asegurados where as_fecha = @i_fecha_proceso) begin
         delete sb_asegurados
          where as_fecha      = @i_fecha_proceso        
            and as_aplicativo = @w_aplicativo
      end

      if exists (select 1 from sb_beneficiarios where be_fecha = @i_fecha_proceso) begin
         delete sb_beneficiarios
        where be_fecha      = @i_fecha_proceso        
            and be_aplicativo = @w_aplicativo
      end

	  --INI REQ486 ENE/2015
      --ESTADISTICAS SEGUROS
      /***ELIMINANDO DATOS EN sb_seguros_estadistica ***/
      if exists (select 1 from sb_seguros_estadistica where se_fecha = @i_fecha_proceso) begin          
         delete sb_seguros_estadistica
          where se_fecha      = @i_fecha_proceso
      end


      /***ELIMINANDO DATOS EN sb_asegurados_estadistica ***/
      if exists (select 1 from sb_asegurados_estadistica where ae_fecha = @i_fecha_proceso) begin          
         delete sb_asegurados_estadistica
          where ae_fecha      = @i_fecha_proceso
      end
      --FIN REQ486 ENE/2015
	  
       /*INSERTA DE SB_IMPRESION_CARTAS*/
      insert into cob_conta_super..sb_impresion_cartas (
      ic_fecha_proceso,     ic_aplicativo,      ic_no_operacion,
      ic_nombre_cliente,    ic_zona,            ic_oficina,
      ic_carta,             ic_reimpresiones,   ic_saldo_vencido,
      ic_saldo_capital,     ic_saldo_total,     ic_altura_mora)
      select
      ic_fecha_proceso,     ic_aplicativo,      ic_no_operacion,
      ic_nombre_cliente,    ic_zona,            ic_oficina,
      ic_carta,             ic_reimpresiones,   ic_saldo_vencido,
      ic_saldo_capital,     ic_saldo_total,     ic_altura_mora
      from cob_externos..ex_impresion_cartas
      where ic_fecha_proceso = @i_fecha_proceso
        and ic_aplicativo = @w_aplicativo

	 if @@error <> 0 begin
        exec cob_conta_super..sp_errorlog
             @i_operacion     = 'I',
             @i_fecha_fin     = @i_fecha_proceso,
             @i_fuente        = @w_sp_name,
             @i_origen_error  = '28017',
             @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_IMPRESION_CARTAS'           
      end

      delete sb_dato_linea
       where dl_fecha = @i_fecha_proceso

      delete sb_dato_lin_ope_moneda
       where dm_fecha = @i_fecha_proceso

        /*INSERTA DE SB_POTENCIALES_CUPO*/
      insert into cob_conta_super..sb_potenciales_cupo (
      pt_fecha_proceso,     pt_aplicativo,      pt_cliente,
      pt_oficina,           pt_oficial,         pt_monto_credito,
      pt_tipo_cliente,      pt_monto_aprobado,  pt_monto_utilizado,
      pt_plazo,             pt_cred_canc,       pt_desc_oficial,
      pt_desc_oficina,      pt_cedula,          pt_nombre_clien,
      pt_des_actividad,     pt_dir_nego,        pt_tel_nego,
      pt_tel_domc,          pt_tiene_micro,     pt_saldo_vig,
      pt_dir_casa,          pt_nota_ult_obl,    pt_segmento,
      pt_desc_segmento,     pt_celular,         pt_fecha_corte )
      select
      pt_fecha_proceso,     pt_aplicativo,      pt_cliente,
      pt_oficina,           pt_oficial,         pt_monto_credito,
      pt_tipo_cliente,      pt_monto_aprobado,  pt_monto_utilizado,
      pt_plazo,             pt_cred_canc,       pt_desc_oficial,
      pt_desc_oficina,      pt_cedula,          pt_nombre_clien,
      pt_des_actividad,     pt_dir_nego,        pt_tel_nego,
      pt_tel_domc,          pt_tiene_micro,     pt_saldo_vig,
      pt_dir_casa,          pt_nota_ult_obl,    pt_segmento,
      pt_desc_segmento,     pt_celular,         pt_fecha_corte
      from cob_externos..ex_potenciales_cupo
      where pt_fecha_proceso = @i_fecha_proceso
        and pt_aplicativo = @w_aplicativo

	 if @@error <> 0 begin
        exec cob_conta_super..sp_errorlog
             @i_operacion     = 'I',
             @i_fecha_fin     = @i_fecha_proceso,
             @i_fuente        = @w_sp_name,
             @i_origen_error  = '28017',
             @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_POTENCIALES_CUPO'           
      end
   
      /*** INSERTA DATOS EN SB_DATO_TRAMITE ***/
      insert into cob_conta_super..sb_dato_tramite(
      dt_fecha                     ,dt_aplicativo                  ,dt_tramite,
      dt_tipo               	   ,dt_truta                       ,dt_fecha_creacion,
      dt_mercado                   ,dt_tipo_credito                ,dt_sujcred,
      dt_clase                     ,dt_cliente                     ,dt_oficina,
      dt_fuente_recurso            ,dt_banco                       ,dt_alianza,
      dt_autoriza_central          ,dt_campana                     ,dt_negado_mir,
      dt_num_devri)
      select 
      dt_fecha                     ,dt_aplicativo                  ,dt_tramite,
      dt_tipo                      ,dt_truta                       ,dt_fecha_creacion,
      dt_mercado                   ,dt_tipo_credito                ,dt_sujcred,
      dt_clase                     ,dt_cliente                     ,dt_oficina,
      dt_fuente_recurso            ,dt_banco                       ,dt_alianza,
      dt_autoriza_central          ,dt_campana                     ,dt_negado_mir,
      dt_num_devri
      from cob_externos..ex_dato_tramite
      where dt_fecha      = @i_fecha_proceso        
      and   dt_aplicativo = @w_aplicativo

      if @@error <> 0 begin
        exec cob_conta_super..sp_errorlog
             @i_operacion     = 'I',
             @i_fecha_fin     = @i_fecha_proceso,
             @i_fuente        = @w_sp_name,
             @i_origen_error  = '28017',
             @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_TRAMITE'           
      end

      /*** INSERTA DATOS EN SB_DATO_SITUACION_TRAMITE ***/
      insert into  sb_dato_tramite_sit(
      ts_fecha                     ,ts_aplicativo                ,ts_tramite             ,
      ts_estado                    ,ts_oficina                   ,ts_oficial             ,
      ts_ciudad                    ,ts_cuota_aprox               ,ts_cant_benef_seg      ,
      ts_tipo_cuota                ,ts_tipo_plazo                ,ts_plazo               ,
      ts_monto                     ,ts_tasa_op                   ,ts_toperacion          ,
      ts_fecha_concesion           ,ts_mercado_objetivo          ,ts_sujcred             ,  -- GAL 01/AGO/2010 - OMC(ts_mercado_objetivo, ts_sujcred)
      ts_fecha_apr                 ,ts_banco                     ,ts_funcionario)
      select
      ts_fecha                     ,ts_aplicativo                ,ts_tramite             ,
      ts_estado                    ,ts_oficina                   ,ts_oficial             ,
      ts_ciudad                    ,ts_cuota_aprox               ,ts_cant_benef_seg      ,
      ts_tipo_cuota                ,ts_tipo_plazo                ,ts_plazo               ,
      ts_monto                     ,ts_tasa_op                   ,ts_toperacion          ,
      ts_fecha_concesion           ,ts_mercado_objetivo          ,ts_sujcred             ,  -- GAL 01/AGO/2010 - OMC(ts_mercado_objetivo, ts_sujcred)
      ts_fecha_apr                 ,ts_banco                     , ts_funcionario
      from cob_externos..ex_dato_tramite_sit      
      where ts_fecha      = @i_fecha_proceso        
      and   ts_aplicativo = @w_aplicativo
      if @@error <> 0 begin
        exec cob_conta_super..sp_errorlog
             @i_operacion     = 'I',
             @i_fecha_fin     = @i_fecha_proceso,
             @i_fuente        = @w_sp_name,
             @i_origen_error  = '28018',
             @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_SITUACION_TRAMITE'           
      end

      /*** INSERTA DATOS EN SB_DATO_MICROEMPRESA ***/
      insert into sb_dato_microempresa( 
      dm_fecha                     ,dm_aplicativo               ,dm_id_microempresa           ,
      dm_nombre                    ,dm_descripcion)             
      select
      dm_fecha                     ,dm_aplicativo               ,dm_id_microempresa           ,
      dm_nombre                    ,dm_descripcion
      from cob_externos.. ex_dato_microempresa
      where dm_fecha      = @i_fecha_proceso        
      and   dm_aplicativo = @w_aplicativo
      if @@error <> 0 begin
        exec cob_conta_super..sp_errorlog
             @i_operacion     = 'I',
             @i_fecha_fin     = @i_fecha_proceso,
             @i_fuente        = @w_sp_name,
             @i_origen_error  = '28020',
             @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_MICROEMPRESA'           
      end
      
      /*** INSERTA DATOS EN SB_DATO_MICROEMPRESA_SIT ***/
      insert into sb_dato_microempresa_sit(        
      ms_fecha                        ,ms_aplicativo                   ,ms_id_microempresa              ,
      ms_microempresa                 ,ms_tramite                      ,ms_actividad                    ,
      ms_tipo_local                   ,ms_tipo_empresa                 ,ms_dias_trabajados              ,
      ms_num_trbjdr_remu              ,ms_num_trbjdr_no_remu           ,ms_decl_jurada                  ,
      ms_fecha_apertura               ,ms_fini_posesion                ,ms_fini_experiencia             ,
      ms_fini_abr_econ)      
      select
      ms_fecha                        ,ms_aplicativo                   ,ms_id_microempresa              ,
      ms_microempresa                 ,ms_tramite                      ,ms_actividad                    ,
      ms_tipo_local                   ,ms_tipo_empresa                 ,ms_dias_trabajados              ,
      ms_num_trbjdr_remu              ,ms_num_trbjdr_no_remu           ,ms_decl_jurada                  ,
      ms_fecha_apertura               ,ms_fini_posesion                ,ms_fini_experiencia             ,
      ms_fini_abr_econ
      from cob_externos..ex_dato_microempresa_sit
      where ms_fecha      = @i_fecha_proceso        
      and   ms_aplicativo = @w_aplicativo
      if @@error <> 0 begin
        exec cob_conta_super..sp_errorlog
             @i_operacion     = 'I',
             @i_fecha_fin     = @i_fecha_proceso,
             @i_fuente        = @w_sp_name,
             @i_origen_error  = '28023',
             @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_MICROEMPRESA_SIT'           
      end

      /*** INSERTA DATOS EN SB_DATO_BAL_FNCIERO ***/
      insert into sb_dato_bal_fnciero(
      bf_fecha           ,bf_aplicativo      ,bf_id_microempresa ,
      bf_microempresa    ,bf_tramite         ,bf_sec_balance     ,
      bf_nivel1          ,bf_nivel2          ,bf_nivel3          ,
      bf_nivel4          ,bf_sumatoria       ,bf_total           ,
      bf_descripcion     ,bf_nivel           ,bf_actualizado)
      select
      bf_fecha           ,bf_aplicativo      ,bf_id_microempresa ,
      bf_microempresa    ,bf_tramite         ,bf_sec_balance     ,
      bf_nivel1          ,bf_nivel2          ,bf_nivel3          ,
      bf_nivel4          ,bf_sumatoria       ,bf_total           ,
      bf_descripcion     ,bf_nivel           ,bf_actualizado
      from cob_externos..ex_dato_bal_fnciero
      where bf_fecha      = @i_fecha_proceso        
      and   bf_aplicativo = @w_aplicativo
      if @@error <> 0 begin
        exec cob_conta_super..sp_errorlog
             @i_operacion     = 'I',
             @i_fecha_fin     = @i_fecha_proceso,
             @i_fuente        = @w_sp_name,
             @i_origen_error  = '28024',
             @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_BAL_FNCIERO'           
      end

      /*** INSERTA DATOS EN SB_DATO_BAL_FNCIERO_DET ***/
      insert into sb_dato_bal_fnciero_det(      
      bd_fecha            ,bd_aplicativo       ,bd_id_microempresa  ,
      bd_microempresa     ,bd_tramite          ,bd_sec_balance      ,
      bd_codigo_var       ,bd_secuencial       ,bd_tipo             ,
      bd_valor            ,bd_decl_jur)
      select
      bd_fecha            ,bd_aplicativo       ,bd_id_microempresa  ,
      bd_microempresa     ,bd_tramite          ,bd_sec_balance      ,
      bd_codigo_var       ,bd_secuencial       ,bd_tipo       ,
      bd_valor            ,bd_decl_jur
      from cob_externos..ex_dato_bal_fnciero_det
      where bd_fecha      = @i_fecha_proceso        
      and   bd_aplicativo = @w_aplicativo
      if @@error <> 0 begin
        exec cob_conta_super..sp_errorlog
             @i_operacion     = 'I',
             @i_fecha_fin     = @i_fecha_proceso,
             @i_fuente        = @w_sp_name,
             @i_origen_error  = '28025',
             @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_BAL_FNCIERO_DET'           
      end

      /*** INSERTA DATOS EN SB_DATO_BAL_RESULTADO ***/
      insert into sb_dato_bal_resultado(
      br_fecha                ,br_aplicativo            ,br_secuencial    ,
      br_costo_mercancia      ,br_id_microempresa       ,br_microempresa  ,
      br_tramite              ,br_producto              ,br_ventas        ,
      br_part_ventas          ,br_costo                 ,br_costo_pond    ,
      br_precio_unidad        ,br_unidad_prod           ,br_precio_venta  ,
      br_costo_var            ,br_tipo_costo            )
      select
      br_fecha                ,br_aplicativo            ,br_secuencial    ,
      br_costo_mercancia      ,br_id_microempresa       ,br_microempresa  ,
      br_tramite              ,br_producto              ,br_ventas        ,
      br_part_ventas          ,br_costo                 ,br_costo_pond    ,
      br_precio_unidad        ,br_unidad_prod           ,br_precio_venta  ,
      br_costo_var            ,br_tipo_costo            
      from cob_externos..ex_dato_bal_resultado
      where br_fecha      = @i_fecha_proceso        
      and   br_aplicativo = @w_aplicativo
      if @@error <> 0 begin
        exec cob_conta_super..sp_errorlog
             @i_operacion     = 'I',
             @i_fecha_fin     = @i_fecha_proceso,
             @i_fuente        = @w_sp_name,
             @i_origen_error  = '28025',
             @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_BAL_RESULTADO'           
      end
      
      /*** INSERTA DATOS EN SB_DATO_RUTA ***/
      insert into sb_dato_ruta(      
      dr_fecha                     ,dr_aplicativo               ,dr_tramite                   ,
      dr_secuencia                 ,dr_truta                    ,dr_paso                      ,
      dr_etapa                     ,dr_estacion                ,dr_funcionario                ,
      dr_llegada                   ,dr_estado                  ,dr_prioridad                  ,
      dr_comite)
      select
      dr_fecha                     ,dr_aplicativo               ,dr_tramite                   ,
      dr_secuencia                 ,dr_truta                    ,dr_paso                      ,
      dr_etapa                     ,dr_estacion                ,dr_funcionario                ,
      dr_llegada                   ,dr_estado                  ,dr_prioridad                  ,
      dr_comite    
      from cob_externos..ex_dato_ruta
      where dr_fecha      = @i_fecha_proceso        
      and   dr_aplicativo = @w_aplicativo
      if @@error <> 0 begin
        exec cob_conta_super..sp_errorlog
             @i_operacion     = 'I',
             @i_fecha_fin     = @i_fecha_proceso,
             @i_fuente        = @w_sp_name,
             @i_origen_error  = '28025',
             @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_RUTA'           
      end


      /*** INSERTA DATOS EN SB_DATO_CAUSA_RECHAZO ***/
      insert into sb_dato_causa_rechazo(  
      cr_fecha        ,cr_aplicativo  ,
      cr_tramite      ,cr_causal      ,
      cr_tipo ) 
      select
      cr_fecha        ,cr_aplicativo  ,
      cr_tramite      ,cr_causal      ,
      cr_tipo 
      from cob_externos..ex_dato_causa_rechazo
      where cr_fecha      = @i_fecha_proceso        
      and   cr_aplicativo = @w_aplicativo
      if @@error <> 0 begin
        exec cob_conta_super..sp_errorlog
             @i_operacion     = 'I',
             @i_fecha_fin     = @i_fecha_proceso,
             @i_fuente        = @w_sp_name,
             @i_origen_error  = '28025',
             @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_CAUSA_RECHAZO'           
      end

      /*** INSERTA DATOS EN SB_DATO_ENCUESTA_RESP UESTA ***/
      insert into sb_dato_encuesta_resp(
      er_fecha,               er_aplicativo,          er_tramite,             
      er_pregunta,            er_respuesta)
      select 
      er_fecha,               er_aplicativo,          er_tramite,             
      er_pregunta,            er_respuesta
      from cob_externos..ex_dato_encuesta_resp
      where er_fecha      = @i_fecha_proceso        
      and   er_aplicativo = @w_aplicativo
      if @@error <> 0 begin
        exec cob_conta_super..sp_errorlog
             @i_operacion     = 'I',
             @i_fecha_fin     = @i_fecha_proceso,
             @i_fuente        = @w_sp_name,
             @i_origen_error  = '28025',
             @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_ENCUESTA_RESP'           
      end

      /*** INSERTA DATOS EN SB_DATO_ENCUESTA_PREG UNTA ***/
      insert into sb_dato_encuesta_preg(
      ep_fecha,               ep_aplicativo,          ep_pregunta,            ep_texto,               
      ep_tipo_resp,           ep_catalogo,            ep_estado,              ep_identificador,
      ep_tipo,                ep_subtipo_m)
      select 
      ep_fecha,               ep_aplicativo,          ep_pregunta,            ep_texto,               
      ep_tipo_resp,           ep_catalogo,            ep_estado,              ep_identificador,
      ep_tipo,                ep_subtipo_m
      from cob_externos..ex_dato_encuesta_preg
      where ep_fecha      = @i_fecha_proceso        
      and   ep_aplicativo = @w_aplicativo
      if @@error <> 0 begin
        exec cob_conta_super..sp_errorlog
             @i_operacion     = 'I',
             @i_fecha_fin     = @i_fecha_proceso,
             @i_fuente        = @w_sp_name,
             @i_origen_error  = '28025',
             @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_ENCUESTA_PREG'           
      end
      
      -- INI - REQ 184 - COMPLEMENTO REPOSITORIO - GAL 10/DIC/2010
      /*** INSERTA DATOS EN SB_VARIABLES_ENTRADA_MIR ***/
      insert into sb_variables_entrada_mir(
      ve_fecha,                ve_fecha_cons,           ve_tramite,
      ve_orden,                ve_tipo,                 ve_identificador,
      ve_valor)
      select
      ve_fecha,                ve_fecha_cons,           ve_tramite,
      ve_orden,                ve_tipo,                 ve_identificador,
      ve_valor
      from cob_externos..ex_variables_entrada_mir
      where ve_fecha = @i_fecha_proceso
      if @@error <> 0 begin
         exec cob_conta_super..sp_errorlog
              @i_operacion     = 'I',
              @i_fecha_fin     = @i_fecha_proceso,
              @i_fuente        = @w_sp_name,
              @i_origen_error  = '28025',
              @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_VARIABLES_ENTRADA_MIR'           
      end 
      
      /*** INSERTA DATOS EN SB_RESPUESTAS_VARIABLES_MIR ***/
      insert into sb_respuestas_variables_mir(
      rv_fecha,                rv_tramite,              rv_variable,
      rv_valor,                rv_fecha_resp,           rv_orden)
      select
      rv_fecha,                rv_tramite,              rv_variable,
      rv_valor,                rv_fecha_resp,           rv_orden
      from cob_externos..ex_respuestas_variables_mir
      where rv_fecha  = @i_fecha_proceso
      if @@error <> 0 begin
         exec cob_conta_super..sp_errorlog
              @i_operacion     = 'I',
              @i_fecha_fin     = @i_fecha_proceso,
              @i_fuente        = @w_sp_name,
              @i_origen_error  = '28025',
              @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_RESPUESTAS_VARIABLES_MIR'           
      end      
            
      /*** INSERTA DATOS EN SB_MICRO_SEGURO ***/
      insert into sb_micro_seguro(
      ms_fecha,                ms_secuencial,           ms_tramite,
      ms_plazo,                ms_director_ofic,        ms_vendedor,
      ms_estado,               ms_fecha_ini,            ms_fecha_fin,
      ms_fecha_envio,          ms_cliente_aseg,         ms_valor,
      ms_pagado,               ms_fecha_mod,            ms_usuario_mod)
      select 
      ms_fecha,                ms_secuencial,           ms_tramite,
      ms_plazo,                ms_director_ofic,        ms_vendedor,
      ms_estado,               ms_fecha_ini,            ms_fecha_fin,
      ms_fecha_envio,          ms_cliente_aseg,         ms_valor,
      ms_pagado,               ms_fecha_mod,            ms_usuario_mod
      from cob_externos..ex_micro_seguro
      where ms_fecha  = @i_fecha_proceso
      if @@error <> 0 begin
         exec cob_conta_super..sp_errorlog
              @i_operacion     = 'I',
              @i_fecha_fin     = @i_fecha_proceso,
              @i_fuente        = @w_sp_name,
              @i_origen_error  = '28025',
              @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_MICRO_SEGURO'           
      end
      
      /*** INSERTA DATOS EN SB_ASEG_MICROSEGURO ***/
      insert into sb_aseg_microseguro(
      am_fecha,                am_microseg,             am_secuencial,
      am_tipo_iden,            am_tipo_aseg,            am_lugar_exp,
      am_identificacion,       am_nombre_comp,          am_fecha_exp,
      am_fecha_nac,            am_genero,               am_lugar_nac,
      am_estado_civ,           am_ocupacion,            am_parentesco,
      am_direccion,            am_derecho_acrec,        am_plan,
      am_valor_plan,           am_telefono,             am_observaciones,
      am_principal)
      select 
      am_fecha,                am_microseg,             am_secuencial,
      am_tipo_iden,            am_tipo_aseg,            am_lugar_exp,
      am_identificacion,       am_nombre_comp,          am_fecha_exp,
      am_fecha_nac,            am_genero,               am_lugar_nac,
      am_estado_civ,           am_ocupacion,            am_parentesco,
      am_direccion,            am_derecho_acrec,        am_plan,
      am_valor_plan,           am_telefono,             am_observaciones,
      am_principal
      from cob_externos..ex_aseg_microseguro
      where am_fecha  = @i_fecha_proceso
      if @@error <> 0 begin
         exec cob_conta_super..sp_errorlog
              @i_operacion     = 'I',
              @i_fecha_fin     = @i_fecha_proceso,
              @i_fuente        = @w_sp_name,
              @i_origen_error  = '28025',
              @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_ASEG_MICROSEGURO'           
      end      
      
      /*** INSERTA DATOS EN SB_BENEFIC_MICRO_ASEG ***/
      insert into sb_benefic_micro_aseg(
      bm_fecha,                bm_microseg,             bm_asegurado,
      bm_secuencial,           bm_tipo_iden,            bm_identificacion,
      bm_nombre_comp,          bm_fecha_nac,            bm_genero,
      bm_lugar_nac,            bm_estado_civ,           bm_ocupacion,
      bm_parentesco,           bm_direccion,            bm_telefono,
      bm_porcentaje)
      select 
      bm_fecha,                bm_microseg,             bm_asegurado,
      bm_secuencial,           bm_tipo_iden,            bm_identificacion,
      bm_nombre_comp,          bm_fecha_nac,            bm_genero,
      bm_lugar_nac,            bm_estado_civ,           bm_ocupacion,
      bm_parentesco,           bm_direccion,            bm_telefono,
      bm_porcentaje
      from cob_externos..ex_benefic_micro_aseg
      where bm_fecha  = @i_fecha_proceso
      if @@error <> 0 begin
         exec cob_conta_super..sp_errorlog
              @i_operacion     = 'I',
              @i_fecha_fin     = @i_fecha_proceso,
              @i_fuente        = @w_sp_name,
              @i_origen_error  = '28025',
              @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_BENEFIC_MICRO_ASEG'           
      end   
      
      /*** INSERTA DATOS EN SB_ENFERMEDADES ***/
      insert into sb_enfermedades(
      en_fecha,                en_microseg,             en_asegurado,
      en_enfermedad)
      select 
      en_fecha,                en_microseg,             en_asegurado,
      en_enfermedad
      from cob_externos..ex_enfermedades
      where en_fecha  = @i_fecha_proceso
      if @@error <> 0 begin
         exec cob_conta_super..sp_errorlog
              @i_operacion     = 'I',
              @i_fecha_fin     = @i_fecha_proceso,
              @i_fuente        = @w_sp_name,
              @i_origen_error  = '28025',
              @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_ENFERMEDADES'           
      end   
      
      /*** INSERTA DATOS EN SB_FILTROS ***/
      insert into sb_filtros(
      fi_fecha,                fi_filtro,               fi_descripcion,
      fi_tipo_persona,         fi_etapa)
      select 
      fi_fecha,                fi_filtro,               fi_descripcion,
      fi_tipo_persona,         fi_etapa
      from cob_externos..ex_filtros
      where fi_fecha  = @i_fecha_proceso
      if @@error <> 0 begin
         exec cob_conta_super..sp_errorlog
              @i_operacion     = 'I',
              @i_fecha_fin     = @i_fecha_proceso,
              @i_fuente        = @w_sp_name,
              @i_origen_error  = '28025',
              @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_FILTROS'           
      end  
      
       ---Inicio MAL04282011 ---
         
       /*** INSERTA DATOS EN SB_RUTA_FILTROS ***/
      insert into sb_ruta_filtros(
      rf_fecha,                rf_ruta,               rf_descripcion,
      rf_estado)
      select 
      rf_fecha,                rf_ruta,               rf_descripcion,
      rf_estado
      from cob_externos..ex_ruta_filtros
      where rf_fecha  = @i_fecha_proceso
      if @@error <> 0 begin
         exec cob_conta_super..sp_errorlog
              @i_operacion     = 'I',
              @i_fecha_fin     = @i_fecha_proceso,
              @i_fuente        = @w_sp_name,
              @i_origen_error  = '28025',
              @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_RUTA_FILTROS'           
      end   
         
      /*** INSERTA DATOS EN SB_PASOS_FILTROS ***/
      insert into sb_pasos_filtros(
      pf_fecha,                pf_ruta,               pf_paso,
      pf_etapa)
      select 
      pf_fecha,                pf_ruta,               pf_paso,
      pf_etapa
      from cob_externos..ex_pasos_filtros
      where pf_fecha  = @i_fecha_proceso
      if @@error <> 0 begin
         exec cob_conta_super..sp_errorlog
              @i_operacion     = 'I',
              @i_fecha_fin     = @i_fecha_proceso,
              @i_fuente        = @w_sp_name,
              @i_origen_error  = '28025',
              @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_PASOS_FILTROS'           
      end       
                  
      ---Fin MAL04282011 ---      
      
      /*** INSERTA DATOS EN SB_DEF_VARIABLES_FILTROS ***/
      insert into sb_def_variables_filtros(
      df_fecha,                df_variable,             df_descripcion,
      df_programa,             df_tipo_var,             df_tipo_dato,
      df_estado)
      select 
      df_fecha,                df_variable,             df_descripcion,
      df_programa,             df_tipo_var,             df_tipo_dato,
      df_estado
      from cob_externos..ex_def_variables_filtros
      where df_fecha  = @i_fecha_proceso
      if @@error <> 0 begin
         exec cob_conta_super..sp_errorlog
              @i_operacion     = 'I',
              @i_fecha_fin     = @i_fecha_proceso,
              @i_fuente        = @w_sp_name,
              @i_origen_error  = '28025',
              @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DEF_VARIABLES_FILTROS'           
      end  

      /*** INSERTA DATOS EN SB_VARIABLES_FILTROS ***/
      insert into sb_variables_filtros(
      vf_fecha,                vf_filtro,               vf_variable,
      vf_condicion,            vf_operador,             vf_valor_referencial,
      vf_puntaje)
      select 
      vf_fecha,                vf_filtro,               vf_variable,
      vf_condicion,            vf_operador,             vf_valor_referencial,
      vf_puntaje
      from cob_externos..ex_variables_filtros
      where vf_fecha  = @i_fecha_proceso
      if @@error <> 0 begin
         exec cob_conta_super..sp_errorlog
              @i_operacion     = 'I',
              @i_fecha_fin     = @i_fecha_proceso,
              @i_fuente        = @w_sp_name,
              @i_origen_error  = '28025',
              @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_VARIABLES_FILTROS'           
      end  
      
      /*** INSERTA DATOS EN SB_VALOR_VARIABLES_FILTROS ***/
      insert into sb_valor_variables_filtros(
      vv_fecha,                vv_ruta,                 vv_etapa,
      vv_filtro,               vv_ente,                 vv_tramite,
      vv_paso,                 vv_variable,             vv_valor_obtenido,
      vv_valor_modificado,     vv_fecha_ult_modif,      vv_login,
      vv_dictamen,             vv_dictamen_final )
      select 
      vv_fecha,                vv_ruta,                 vv_etapa,
      vv_filtro,               vv_ente,                 vv_tramite,
      vv_paso,                 vv_variable,             vv_valor_obtenido,
      vv_valor_modificado,     vv_fecha_ult_modif,      vv_login,
      vv_dictamen,             vv_dictamen_final
      from cob_externos..ex_valor_variables_filtros
      where vv_fecha = @i_fecha_proceso
      if @@error <> 0 begin
         exec cob_conta_super..sp_errorlog
              @i_operacion     = 'I',
              @i_fecha_fin     = @i_fecha_proceso,
              @i_fuente        = @w_sp_name,
              @i_origen_error  = '28025',
              @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_VALOR_VARIABLES_FILTROS'           
      end 
      -- FIN - REQ 184 - COMPLEMENTO REPOSITORIO - GAL 10/DIC/2010

      /* INSERTA DATOS en SB_CALIFICACION_ORIG */
      insert into sb_calificacion_orig (
      cm_fecha,            cm_aplicativo,       cm_tramite,
      cm_fecha_resp,       cm_calificacion,     cm_modo_calif,
      cm_valor)
      select
      cm_fecha,            cm_aplicativo,       cm_tramite,
      cm_fecha_resp,       cm_calificacion,     cm_modo_calif,
      cm_valor
      from cob_externos..ex_calificacion_orig
      where cm_fecha      = @i_fecha_proceso
      and   cm_aplicativo = @w_aplicativo
      if @@error <> 0 begin
        exec cob_conta_super..sp_errorlog
             @i_operacion     = 'I',
             @i_fecha_fin     = @i_fecha_proceso,
             @i_fuente        = @w_sp_name,
             @i_origen_error  = '28025',
             @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_CALIFICACION_ORIG'
      end
          
      --ORS: 512
      insert into sb_dato_linea
      select * from cob_externos..ex_dato_linea
      if @@error <> 0 begin
        exec cob_conta_super..sp_errorlog
             @i_operacion     = 'I',
             @i_fecha_fin     = @i_fecha_proceso,
             @i_fuente        = @w_sp_name,
             @i_origen_error  = '28025',
             @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_LINEA'
      end

      insert into sb_dato_lin_ope_moneda
      select * from cob_externos..ex_dato_lin_ope_moneda
      if @@error <> 0 begin
        exec cob_conta_super..sp_errorlog
             @i_operacion     = 'I',
             @i_fecha_fin     = @i_fecha_proceso,
             @i_fuente        = @w_sp_name,
             @i_origen_error  = '28025',
             @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_LIN_OPE_MONEDA'
      end
      
      /*** ELIMINANDO DATOS EN SB_MSV_PROC_CR ***/
      if exists (select 1 from sb_msv_proc_cr
                  where mp_fecha_proc =  @i_fecha_proceso)
      begin
         delete cob_conta_super..sb_msv_proc_cr
          where mp_fecha_proc =  @i_fecha_proceso
      end

       /*** INSERTA DATOS EN SB_MSV_PROC_CR ***/
      insert into cob_conta_super..sb_msv_proc_cr(
      mp_fecha,       mp_aplicativo,
      mp_id_carga,    mp_id_Alianza,   mp_cedula,                          
      mp_tipo_ced,    mp_oficial,      mp_tramite,     
      mp_tipo,        mp_estado,       mp_ruta,
      mp_etapa,       mp_estacion,     mp_ejecutivo,
      mp_descripcion, mp_fecha_proc)   
      select 
      mp_fecha,       mp_aplicativo,
      mp_id_carga,    mp_id_Alianza,   mp_cedula,                          
      mp_tipo_ced,    mp_oficial,      mp_tramite,     
      mp_tipo,        mp_estado,       mp_ruta,
      mp_etapa,       mp_estacion,     mp_ejecutivo,
      mp_descripcion, mp_fecha_proc 
      from  cob_externos..ex_msv_proc_cr
      where mp_fecha = @i_fecha_proceso

      if @@error <> 0 begin
        exec cob_conta_super..sp_errorlog
             @i_operacion     = 'I',
             @i_fecha_fin     = @i_fecha_proceso,
             @i_fuente        = @w_sp_name,
             @i_origen_error  = '28025',
             @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_MSV_PROC_CR'
      end

      --CCA 366
      insert into sb_seguros_tramite (
      st_fecha,            st_aplicativo,            st_secuencial_seguro,
      st_tipo_seguro,      st_tramite,               st_vendedor,
      st_cupo)
      select
      st_fecha,            st_aplicativo,            st_secuencial_seguro,
      st_tipo_seguro,      st_tramite,               st_vendedor,
      st_cupo
      from cob_externos..ex_seguros_tramite
      where st_fecha      = @i_fecha_proceso
      and   st_aplicativo = @w_aplicativo
      if @@error <> 0 begin
        exec cob_conta_super..sp_errorlog
             @i_operacion     = 'I',
             @i_fecha_fin     = @i_fecha_proceso,
             @i_fuente        = @w_sp_name,
             @i_origen_error  = '28025',
             @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_SEGUROS_TRAMITE'
      end

      insert into sb_asegurados (
      as_fecha,            as_aplicativo,        as_secuencial_seguro,
      as_sec_asegurado,    as_tipo_aseg,         as_apellidos,
      as_nombres,          as_tipo_ced,          as_ced_ruc,
      as_lugar_exp,        as_fecha_exp,         as_ciudad_nac,
      as_fecha_nac,        as_sexo,              as_estado_civil,
      as_parentesco,       as_ocupacion,         as_direccion,
      as_telefono,         as_ciudad,            as_correo_elec,
      as_celular,          as_correspondencia,   as_plan,
      as_fecha_modif,      as_usuario_modif,     as_observaciones,
      as_act_economica,    as_ente)
      select
      as_fecha,            as_aplicativo,        as_secuencial_seguro,
      as_sec_asegurado,    as_tipo_aseg,         as_apellidos,
      as_nombres,          as_tipo_ced,          as_ced_ruc,
      as_lugar_exp,        as_fecha_exp,         as_ciudad_nac,
      as_fecha_nac,        as_sexo,              as_estado_civil,
      as_parentesco,       as_ocupacion,         as_direccion,
      as_telefono,         as_ciudad,            as_correo_elec,
      as_celular,          as_correspondencia,   as_plan,
      as_fecha_modif,      as_usuario_modif,     as_observaciones,
      as_act_economica,    as_ente
      from cob_externos..ex_asegurados
      where as_fecha      = @i_fecha_proceso
      and   as_aplicativo = @w_aplicativo
      if @@error <> 0 begin
        exec cob_conta_super..sp_errorlog
             @i_operacion     = 'I',
             @i_fecha_fin     = @i_fecha_proceso,
             @i_fuente        = @w_sp_name,
             @i_origen_error  = '28025',
             @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_ASEGURADOS'
      end

      insert into sb_beneficiarios (
      be_fecha,            be_aplicativo,        be_secuencial_seguro,
      be_sec_asegurado,    be_sec_benefic,       be_apellidos,
      be_nombres,          be_tipo_ced,          be_ced_ruc,
      be_lugar_exp,        be_fecha_exp,         be_ciudad_nac,
      be_fecha_nac,        be_sexo,              be_estado_civil,
      be_parentesco,       be_ocupacion,         be_direccion,
      be_telefono,         be_ciudad,            be_correo_elec,
      be_celular,          be_correspondencia,   be_fecha_modif,
      be_usuario_modif,    be_porcentaje,        be_ente)
      select
      be_fecha,            be_aplicativo,        be_secuencial_seguro,
      be_sec_asegurado,    be_sec_benefic,       be_apellidos,
      be_nombres,          be_tipo_ced,          be_ced_ruc,
      be_lugar_exp,        be_fecha_exp,         be_ciudad_nac,
      be_fecha_nac,        be_sexo,              be_estado_civil,
      be_parentesco,       be_ocupacion,         be_direccion,
      be_telefono,         be_ciudad,            be_correo_elec,
      be_celular,          be_correspondencia,   be_fecha_modif,
      be_usuario_modif,    be_porcentaje,        be_ente
      from cob_externos..ex_beneficiarios
      where be_fecha      = @i_fecha_proceso
      and   be_aplicativo = @w_aplicativo
      if @@error <> 0 begin
        exec cob_conta_super..sp_errorlog
             @i_operacion     = 'I',
             @i_fecha_fin     = @i_fecha_proceso,
             @i_fuente        = @w_sp_name,
             @i_origen_error  = '28025',
             @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_BENEFICIARIOS'
      end

	              --CCA 486: ESTADISTICAS SEGUROS
      /***INSERTANDO DATOS EN SB_SEGUROS_ESTADISTICA ***/
      insert into cob_conta_super..sb_seguros_estadistica(
      se_fecha,             se_tipo_seguro,
      se_tipo_seg_desc,     se_codigo_plan,        se_cod_plan_desc,
      se_certificado,       se_antiguedad,         se_oficina,
      se_zona,              se_of_nombre,          se_banco,
      se_identif_vend,      se_codigo_vend,        se_nombre_vend,
      se_fecha_venta,       se_fecha_desde,        se_fecha_hasta,
      se_identif_cli,       se_tipo_doc_cli,       se_nombre_cli,
      se_monto_aseg,        se_prima_total,        se_prima_mensual)
      select 
      se_fecha,             se_tipo_seguro,
      se_tipo_seg_desc,     se_codigo_plan,        se_cod_plan_desc,
      se_certificado,       se_antiguedad,         se_oficina,
      se_zona,              se_of_nombre,          se_banco,
      se_identif_vend,      se_codigo_vend,        se_nombre_vend,
      se_fecha_venta,       se_fecha_desde,        se_fecha_hasta,
      se_identif_cli,       se_tipo_doc_cli,       se_nombre_cli,
      se_monto_aseg,        se_prima_total,        se_prima_mensual
      from cob_externos..ex_seguros_estadistica
      where se_fecha      = @i_fecha_proceso
      
      if @@error <> 0 begin
         exec cob_conta_super..sp_errorlog
              @i_operacion     = 'I',
              @i_fecha_fin     = @i_fecha_proceso,
              @i_fuente        = @w_sp_name,
              @i_origen_error  = '28003',
              @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_SEGUROS_ESTADISTICA' 
      end  

      /***INSERTANDO DATOS EN SB_ASEGURADOS_ESTADISTICA ***/
      insert into cob_conta_super..sb_asegurados_estadistica(
      ae_fecha,         ae_certificado,
      ae_tipo_doc,      ae_identif,            ae_nombre,
      ae_genero,        ae_fecha_nac,          ae_fecha_venta)
      select 
      ae_fecha,         ae_certificado,
      ae_tipo_doc,     ae_identif,            ae_nombre,
      ae_genero,        ae_fecha_nac,          ae_fecha_venta
      from cob_externos..ex_asegurados_estadistica
      where ae_fecha      = @i_fecha_proceso
      
      if @@error <> 0 begin
         exec cob_conta_super..sp_errorlog
              @i_operacion     = 'I',
              @i_fecha_fin     = @i_fecha_proceso,
              @i_fuente        = @w_sp_name,
              @i_origen_error  = '28003',
              @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_ASEGURADOS_ESTADISTICA' 
      end
      --FIN CCA 486: ESTADISTICAS SEGUROS

	  
   end -- operacion 'TR'

   /* DATOS DE LOS DEUDORES DE LAS OPERACIONES */
   if @i_toperacion = 'DC' or @i_toperacion = 'TO' begin

      /*** ELIMINA DATOS EN SB_DATO_DEUDORES ***/
      if exists (select 1 from sb_dato_deudores
                  where de_fecha      = @i_fecha_proceso
                    and de_aplicativo = @w_aplicativo)
      begin

																																							   

        delete sb_dato_deudores
         where de_aplicativo = @w_aplicativo
           and de_fecha      = @i_fecha_proceso 
      end

      /* INI - GAL 12/AGO/2010 - OMC */
      if exists (select 1 from sb_dato_acciones_cobranza where ac_fecha = @i_fecha_proceso) begin
         delete sb_dato_acciones_cobranza
          where ac_fecha      = @i_fecha_proceso
            and ac_aplicativo = @w_aplicativo
      end
      /* FIN - GAL 12/AGO/2010 - OMC */
   
      /*** INSERTA DATOS EN SB_DATO_COBRANZA***/
      insert into cob_conta_super..sb_dato_cobranza(
      dc_fecha                     ,dc_aplicativo               ,dc_cobranza                  ,
      dc_banco                     ,dc_estado                   ,dc_ente_abogado              ,
      dc_fecha_citacion            ,dc_fecha_acuerdo)           
      select 
      dc_fecha                     ,dc_aplicativo               ,dc_cobranza                  ,
      dc_banco                     ,dc_estado                   ,dc_ente_abogado              ,
      dc_fecha_citacion      ,dc_fecha_acuerdo
      from cob_externos..ex_dato_cobranza
      where dc_fecha      = @i_fecha_proceso
      and   dc_aplicativo = @w_aplicativo

      if @@error <> 0 begin
          exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @i_fecha_proceso,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28011',
               @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_COBRANZA'           
       end
      /* INI - GAL 01/AGO/2010 - OMC */
      /*** INSERTA DATOS EN SB_DATO_ACCIONES_COBRANZA  ***/
      insert into sb_dato_acciones_cobranza(
      ac_fecha,               ac_aplicativo,          ac_banco,               ac_cliente,
      ac_cobranza,            ac_taccion,             ac_numero_acc,          ac_abogado,
      ac_valor,               ac_descripcion  )
      select 
      ac_fecha,               ac_aplicativo,          ac_banco,               ac_cliente,
      ac_cobranza,            ac_taccion,             ac_numero_acc,          ac_abogado,
      ac_valor,               ac_descripcion
      from cob_externos..ex_dato_acciones_cobranza
      where ac_fecha      = @i_fecha_proceso
      and   ac_aplicativo = @w_aplicativo
      if @@error <> 0 begin
        exec cob_conta_super..sp_errorlog
             @i_operacion     = 'I',
             @i_fecha_fin     = @i_fecha_proceso,
             @i_fuente        = @w_sp_name,
             @i_origen_error  = '28025',
             @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_ACCIONES_COBRANZA'           
      end
      /* FIN - GAL 01/AGO/2010 - OMC */     
      
   end --operacion CB

   /* DATOS DE TESORERIA */
   If @i_toperacion = 'TE' or @i_toperacion = 'TO' begin

      /*** ELIMINA DATOS EN SB_DATO_TESORERIA ***/
      if exists (select 1 from sb_dato_tesoreria
                  where dt_fecha = @i_fecha_proceso
                    and dt_aplicativo = @w_aplicativo)
      begin
        delete sb_dato_tesoreria
         where dt_aplicativo = @w_aplicativo
           and dt_fecha      = @i_fecha_proceso 
      end

      insert into cob_conta_super..sb_dato_tesoreria (
         dt_fecha,                dt_banco,                dt_toperacion,         dt_aplicativo,        
         dt_categoria_producto,   dt_cliente,              dt_documento_tipo,     dt_documento_numero,  
         dt_oficina,              dt_moneda,               dt_valor_nominal,      dt_valor_inicial,      
         dt_valorizacion_mercado, dt_valorizacion_interes, dt_tipo_tasa,          dt_referencial,       
         dt_factor,               dt_spread,               dt_tasa_orig,          dt_tasa_actual,         
         dt_modalidad,            dt_plazo_dias,           dt_fecha_apertura,     dt_fecha_vencimiento,   
         dt_estado,               dt_num_cuotas,           dt_periodicidad_cuota, dt_valor_cuota,          
         dt_fecha_prox_vto,       dt_tipo_doc_oficial,     dt_documento_oficial,  dt_naturaleza,        
         dt_tipo_inversion,       dt_ubicacion_contrato,   dt_renovado,           dt_fecha_ren )
      select
         dt_fecha,                dt_banco,                dt_toperacion,         dt_aplicativo,        
         dt_categoria_producto,   dt_cliente,              dt_documento_tipo,     dt_documento_numero,  
         dt_oficina,              dt_moneda,               dt_valor_nominal,      dt_valor_inicial,      
         dt_valorizacion_mercado, dt_valorizacion_interes, dt_tipo_tasa,          dt_referencial,       
         dt_factor,               dt_spread,               dt_tasa_orig,          dt_tasa_actual,         
         dt_modalidad,            dt_plazo_dias,           dt_fecha_apertura,     dt_fecha_vencimiento,   
         dt_estado,               dt_num_cuotas,           dt_periodicidad_cuota, dt_valor_cuota,          
         dt_fecha_prox_vto,       dt_tipo_doc_oficial,     dt_documento_oficial,  dt_naturaleza,        
         dt_tipo_inversion,       dt_ubicacion_contrato,   dt_renovado,           dt_fecha_ren
      from cob_externos..ex_dato_tesoreria
      where dt_fecha      = @i_fecha_proceso
      and   dt_aplicativo = @w_aplicativo

      if @@error <> 0 begin
        exec cob_conta_super..sp_errorlog
             @i_operacion     = 'I',
             @i_fecha_fin     = @i_fecha_proceso,
             @i_fuente        = @w_sp_name,
             @i_origen_error  = '28012',
             @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_TESORERIA'
      end

   end -- operacion TE
  
end --while

/* DATOS GENERALES DE CLIENTES */
if @i_toperacion = 'CL' or @i_toperacion = 'TO' begin

   /*** ELIMINA DATOS EN SB_DATO_CLIENTE ***/
   if exists (select 1 from sb_dato_cliente where dc_fecha = @i_fecha_proceso) begin
      delete sb_dato_cliente
       where dc_fecha  = @i_fecha_proceso        

      delete sb_dato_direccion
       where dd_fecha  = @i_fecha_proceso        

      delete sb_dato_telefono
       where dt_fecha  = @i_fecha_proceso
    end
   
																																					  

    /*** INSERTA DATOS EN SB_DATO_CLIENTE ***/
    insert into cob_conta_super..sb_dato_cliente(
    dc_fecha               ,dc_cliente         ,dc_tipo_ced            ,
      dc_ced_ruc           ,dc_nombre          ,dc_p_apellido          ,
      dc_s_apellido        ,dc_subtipo         ,dc_oficina             ,
      dc_oficial           ,dc_sexo            ,dc_actividad           ,
      dc_retencion         ,dc_sector          ,dc_situacion_cliente   ,
      dc_victima           ,dc_exc_sipla       ,dc_estado_civil        ,
      dc_nivel_ing         ,dc_nivel_egr       ,dc_fecha_ingreso       ,
      dc_fecha_mod         ,dc_fecha_nac       ,dc_ciudad_nac          ,
      dc_iden_conyuge      ,dc_tipo_doc_cony   ,dc_p_apellido_cony     ,
      dc_s_apellido_cony   ,dc_nombre_cony     ,dc_estrato             ,
      dc_tipo_vivienda     ,dc_pais            ,dc_nivel_estudio       ,
      dc_num_carga         ,dc_PEP             ,dc_fecha_vinculacion   ,
      dc_hipoteca_viv      ,dc_num_activas     ,dc_estado_cliente      ,
      dc_banca             ,dc_segmento        ,dc_subsegmento         ,
      dc_actprincipal      ,dc_actividad2      ,dc_actividad3          ,
      dc_bancarizado       ,dc_alto_riesgo     ,dc_fecha_riesgo        ,
	  dc_perf_tran         ,dc_riesgo          ,dc_nit)
    select 
    dc_fecha               ,dc_cliente         ,dc_tipo_ced            ,
      dc_ced_ruc           ,dc_nombre          ,dc_p_apellido          ,
      dc_s_apellido        ,dc_subtipo         ,dc_oficina             ,
      dc_oficial           ,dc_sexo            ,dc_actividad           ,
      dc_retencion         ,dc_sector          ,dc_situacion_cliente   ,
      dc_victima           ,dc_exc_sipla       ,dc_estado_civil        ,
      dc_nivel_ing         ,dc_nivel_egr       ,dc_fecha_ingreso       ,
      dc_fecha_mod         ,dc_fecha_nac       ,dc_ciudad_nac          ,
      dc_iden_conyuge      ,dc_tipo_doc_cony   ,dc_p_apellido_cony     ,
      dc_s_apellido_cony   ,dc_nombre_cony     ,dc_estrato             ,
      dc_tipo_vivienda     ,dc_pais            ,dc_nivel_estudio       ,
      dc_num_carga         ,dc_PEP             ,dc_fecha_vinculacion   ,
      dc_hipoteca_viv      ,dc_num_activas     ,dc_estado_cliente      ,
      dc_banca             ,dc_segmento        ,dc_subsegmento         ,
      dc_actprincipal      ,dc_actividad2      ,dc_actividad3          ,
      dc_bancarizado       ,dc_alto_riesgo     ,dc_fecha_riesgo        ,
	  dc_perf_tran         ,dc_riesgo          ,dc_nit  
    from cob_externos..ex_dato_cliente
    where dc_fecha  = @i_fecha_proceso      
    if @@error <> 0 begin
       exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @i_fecha_proceso,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = '28013',
            @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_CLIENTE'           
    end

    insert into cob_conta_super..sb_dato_direccion(
    dd_fecha                ,dd_cliente             ,dd_direccion   ,
    dd_descripcion          ,dd_ciudad              ,dd_tipo        ,
    dd_fecha_ingreso        ,dd_fecha_modificacion  ,dd_principal   ,
    dd_rural_urb            ,dd_provincia           ,dd_parroquia  )
    select
    dd_fecha                ,dd_cliente             ,dd_direccion   ,
    dd_descripcion          ,dd_ciudad              ,dd_tipo        ,
    dd_fecha_ingreso        ,dd_fecha_modificacion  ,dd_principal   ,
    dd_rural_urb            ,dd_provincia           ,dd_parroquia  
    from cob_externos..ex_dato_direccion
    where dd_fecha    = @i_fecha_proceso   
    if @@error <> 0 begin
       exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @i_fecha_proceso,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = '28014',
            @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_DIRECCION'           
    end

																																					   

    insert into cob_conta_super.. sb_dato_telefono(
    dt_fecha                ,dt_cliente         ,dt_direccion       ,
    dt_secuencial           ,dt_valor           ,dt_tipo_telefono   ,
    dt_prefijo              ,dt_fecha_ingreso   ,dt_fecha_mod ,
    dt_tipo_operador)
    select
    dt_fecha                ,dt_cliente         ,dt_direccion       ,
    dt_secuencial           ,dt_valor           ,dt_tipo_telefono   ,
    dt_prefijo              ,dt_fecha_ingreso   ,dt_fecha_mod       ,
    dt_tipo_operador
    from cob_externos..ex_dato_telefono
    where dt_fecha  = @i_fecha_proceso 
    if @@error <> 0 begin
       exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
         @i_fecha_fin     = @i_fecha_proceso,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = '28015',
            @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_DIRECCION'           
    end
    
    -- DFPS 331
    
    delete sb_dato_sostenibilidad
     where convert(varchar(10),dt_fecha_modif,101) = convert(varchar(10),@i_fecha_proceso,101) 

    insert into cob_conta_super.. sb_dato_sostenibilidad(
    dt_cliente             ,dt_viv_mat,
    dt_viv_comb            ,dt_viv_dorm         ,dt_viv_conforman,
    dt_viv_aportan         ,dt_edu_financiera   ,dt_grupo_etnico,
    dt_viv_serv_pub        ,dt_viv_vias_llegar  ,dt_viv_equipo,
    dt_viv_tema_tratado    ,dt_fecha_modif   )
    select
    dt_cliente             ,dt_viv_mat,
    dt_viv_comb            ,dt_viv_dorm         ,dt_viv_conforman,
    dt_viv_aportan         ,dt_edu_financiera   ,dt_grupo_etnico,
    dt_viv_serv_pub        ,dt_viv_vias_llegar  ,dt_viv_equipo,
    dt_viv_tema_tratado    ,dt_fecha_modif           
    from cob_externos..ex_dato_sostenibilidad
    where convert(varchar(10),dt_fecha_modif,101) = convert(varchar(10),@i_fecha_proceso,101) 
    
    if @@error <> 0 begin
       exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @i_fecha_proceso,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = 'xxxxx',
            @i_descrp_error  = 'ERROR INSERTANDO DATOS EN sb_dato_sostenibilidad'           
    end

    delete sb_dato_educa_hijos
     where convert(varchar(10),dt_fecha_modif,101) = convert(varchar(10),@i_fecha_proceso,101) 

    insert into cob_conta_super..sb_dato_educa_hijos(
    dt_cliente             ,dt_edad             ,dt_niv_edu,
    dt_hijos               ,dt_fecha_modif)
    select
    dt_cliente             ,dt_edad             ,dt_niv_edu,
    dt_hijos               ,dt_fecha_modif           
    from cob_externos..ex_dato_educa_hijos
    where convert(varchar(10),dt_fecha_modif,101) = convert(varchar(10),@i_fecha_proceso,101) 
    
    if @@error <> 0 begin
       exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @i_fecha_proceso,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = 'xxxxx',
            @i_descrp_error  = 'ERROR INSERTANDO DATOS EN sb_dato_educa_hijos'           
    end

    delete sb_dato_sostenibilidad_log
     where convert(varchar(10),dt_fecha_actualizacion,101) = convert(varchar(10),@i_fecha_proceso,101) 

    insert into cob_conta_super..sb_dato_sostenibilidad_log(
    dt_cliente             ,dt_ced_ruc          ,dt_nom_cliente,
    dt_nom_campo           ,dt_valor_anterior   ,dt_valor_actual,
    dt_fecha_actualizacion ,dt_usuario)
    select
    dt_cliente             ,dt_ced_ruc          ,dt_nom_cliente,
    dt_nom_campo           ,dt_valor_anterior   ,dt_valor_actual,
    dt_fecha_actualizacion ,dt_usuario           
    from cob_externos..ex_dato_sostenibilidad_log
    where convert(varchar(10),dt_fecha_actualizacion,101) = convert(varchar(10),@i_fecha_proceso,101) 
    
    if @@error <> 0 begin
       exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @i_fecha_proceso,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = 'xxxxx',
            @i_descrp_error  = 'ERROR INSERTANDO DATOS EN sb_dato_sostenibilidad_log'           
    end

    delete sb_dato_escolaridad_log
    where convert(varchar(10),dt_fecha_actualizacion,101) = convert(varchar(10),@i_fecha_proceso,101) 
    
    insert into cob_conta_super..sb_dato_escolaridad_log(
    dt_cliente             ,dt_ced_ruc          ,dt_nom_cliente,
    dt_nom_campo           ,dt_valor_anterior   ,dt_valor_actual,
    dt_fecha_actualizacion ,dt_usuario)
    select
    dt_cliente             ,dt_ced_ruc          ,dt_nom_cliente,
    dt_nom_campo           ,dt_valor_anterior   ,dt_valor_actual,
    dt_fecha_actualizacion ,dt_usuario           
    from cob_externos..ex_dato_escolaridad_log
    where convert(varchar(10),dt_fecha_actualizacion,101) = convert(varchar(10),@i_fecha_proceso,101) 
    
    if @@error <> 0 begin
       exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @i_fecha_proceso,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = 'xxxxx',
            @i_descrp_error  = 'ERROR INSERTANDO DATOS EN sb_dato_escolaridad_log'           
    end
    
    delete sb_forma_extractos
     where convert(varchar(10),fe_fecha,101) = convert(varchar(10),@i_fecha_proceso,101) 

    insert into cob_conta_super..sb_forma_extractos(
    fe_cliente             ,fe_forma_entrega    ,fe_codigo,
    fe_fecha               ,fe_fecha_real       ,fe_usuario,
    fe_oficina_marca       ,fe_terminal)
    select
    fe_cliente             ,fe_forma_entrega    ,fe_codigo,
    fe_fecha               ,fe_fecha_real       ,fe_usuario,
    fe_oficina_marca       ,fe_terminal          
    from cob_externos..ex_forma_extractos
    where convert(varchar(10),fe_fecha,101) = convert(varchar(10),@i_fecha_proceso,101) 
    
    if @@error <> 0 begin
       exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @i_fecha_proceso,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = 'xxxxx',
            @i_descrp_error  = 'ERROR INSERTANDO DATOS EN sb_forma_extractos'           
    end

    delete cob_conta_super..sb_dato_clientes_campana
     where cc_fecha_cli_cam = @i_fecha_proceso
    
    insert into cob_conta_super..sb_dato_clientes_campana(
    cc_fecha,          cc_aplicativo,          cc_cliente,        cc_ced_ruc,                  
    cc_nombre,         cc_toperacion,          cc_tasa_ref,       cc_tasa_neg,
    cc_ejecutivo,      cc_op_banco,            cc_fecha_apr,      cc_tramite,                  
    cc_fecha_cli_cam,  cc_campana,             cc_campana_nombre, cc_campana_tipo,
    cc_condicion,      cc_acepta_contraoferta, cc_encuesta,       cc_fecha_ini,                
    cc_fecha_fin,      cc_asignado_a,          cc_asignado_por,   cc_oficina,
    cc_dir_negocio,    cc_tel_nego,            cc_barrio,         cc_plazo,
    cc_tplazo,         cc_oficial,             cc_oficial_nombre, cc_estado)    
    select 
    cc_fecha,          cc_aplicativo,          cc_cliente,        cc_ced_ruc,                  
    cc_nombre,         cc_toperacion,          cc_tasa_ref,       cc_tasa_neg,
    cc_ejecutivo,      cc_op_banco,            cc_fecha_apr,      cc_tramite,                  
    cc_fecha_cli_cam,  cc_campana,             cc_campana_nombre, cc_campana_tipo,
    cc_condicion,      cc_acepta_contraoferta, cc_encuesta,       cc_fecha_ini,                
    cc_fecha_fin,      cc_asignado_a,          cc_asignado_por,   cc_oficina,
    cc_dir_negocio,    cc_tel_nego,            cc_barrio,         cc_plazo,
    cc_tplazo,         cc_oficial,             cc_oficial_nombre, cc_estado
    from cob_externos..ex_dato_clientes_campana
    where cc_fecha_cli_cam = @i_fecha_proceso
    
    if @@error <> 0 begin
       exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @i_fecha_proceso,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = 'xxxxx',
            @i_descrp_error  = 'ERROR INSERTANDO DATOS EN sb_dato_clientes_campana'           
    end
       
    delete cob_externos..ex_dato_gestion_campana 
     where gc_fecha = @i_fecha_proceso
    
    insert into cob_conta_super..sb_dato_gestion_campana(
    gc_fecha,           gc_aplicativo,       gc_campana,            gc_cliente,
    gc_fecha_campana,   gc_secuencial,       gc_gestor,             gc_forma_gestion,
    gc_logro_contacto,  gc_contacto_con,     gc_causa_no_contacto,  gc_resp_favorable,    
    gc_causa_rechazo,   gc_cerrar_gestion,   gc_causa_cierre,       gc_comentario,
    gc_fecha_gestion,   gc_hora_gestion,     gc_user,               gc_hora_real)
    select 
    gc_fecha,           gc_aplicativo,       gc_campana,            gc_cliente,
    gc_fecha_campana,   gc_secuencial,       gc_gestor,             gc_forma_gestion,
    gc_logro_contacto,  gc_contacto_con,     gc_causa_no_contacto,  gc_resp_favorable,    
    gc_causa_rechazo,   gc_cerrar_gestion,   gc_causa_cierre,       gc_comentario,
    gc_fecha_gestion,   gc_hora_gestion,     gc_user,               gc_hora_real
    from cob_externos..ex_dato_gestion_campana
    where gc_fecha = @i_fecha_proceso 
    
    if @@error <> 0 begin
       exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @i_fecha_proceso,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = 'xxxxx',
            @i_descrp_error  = 'ERROR INSERTANDO DATOS EN sb_dato_gestion_campana'           
    end
    
    delete cob_externos..ex_dato_encuestas
     where re_fecha = @i_fecha_proceso
    
    insert into cob_conta_super..sb_dato_encuestas(
    re_fecha,       re_aplicativo, re_cliente,     re_fecha_resp,   
    re_formulario,  re_version,    re_secuencial,  re_cod_pregunta, 
    re_pregunta, re_respuesta)
    select 
    re_fecha,       re_aplicativo, re_cliente,     re_fecha_resp,   
    re_formulario,  re_version,    re_secuencial,  re_cod_pregunta, 
    re_pregunta, re_respuesta
    from cob_externos..ex_dato_encuestas  
    where re_fecha = @i_fecha_proceso
    
    if @@error <> 0 begin
       exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @i_fecha_proceso,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = 'xxxxx',
            @i_descrp_error  = 'ERROR INSERTANDO DATOS EN sb_dato_encuestas'           
    end
    
    delete cob_conta_super..sb_prospecto_contraoferta
    where pr_fecha_proceso = @i_fecha_proceso
    
    insert into cob_conta_super..sb_prospecto_contraoferta(
    pr_cliente,   pr_operacion,   pr_fecha_proceso)
    select 
    pr_cliente,   pr_operacion,   pr_fecha_proceso
    from cob_externos..ex_prospecto_contraoferta
    where pr_fecha_proceso = @i_fecha_proceso
    
    if @@error <> 0 begin
       exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @i_fecha_proceso,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = 'xxxxx',
            @i_descrp_error  = 'ERROR INSERTANDO DATOS EN sb_prospecto_contraoferta'           
    end
    
    -- NYMR 239

    /*** ELIMINA DATOS EN sb_dato_central_cliente ***/


    delete cob_conta_super..sb_dato_central_cliente
     where dcc_fecha_proceso = @i_fecha_proceso 

    /*** INSERTA DATOS EN sb_dato_central_cliente ***/
    
    insert into cob_conta_super..sb_dato_central_cliente(
    dcc_fecha_proceso,          dcc_orden_consulta,   dcc_central,             
    dcc_fecha_cons,             dcc_tipo_id,         dcc_num_id,              
    dcc_estado_id,              dcc_respuesta,       dcc_aplicativo,          
    dcc_ente)
    select   
    dcc_fecha_proceso,          dcc_orden_consulta,   dcc_central,             
    dcc_fecha_cons,             dcc_tipo_id,         dcc_num_id,              
    dcc_estado_id,              dcc_respuesta,       dcc_aplicativo,
    dcc_ente          
    from cob_externos..ex_dato_central_cliente 
    where dcc_fecha_proceso = @i_fecha_proceso 
    if @@error <> 0 begin
       exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @i_fecha_proceso,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = '28015',
            @i_descrp_error  = 'ERROR INSERTANDO DATOS EN sb_dato_central_cliente'           
    end


    /*** ELIMINA DATOS EN sb_dato_central_producto ***/

    delete sb_dato_central_producto
     where dcp_fecha_proceso = @i_fecha_proceso 

    /*** INSERTA DATOS EN sb_dato_central_producto ***/
    
    insert into cob_conta_super..sb_dato_central_producto(
    dcp_fecha_proceso,          dcp_orden_consulta,       dcp_tipo_reg,                  
    dcp_estado,                 dcp_tipo_prod,            dcp_entidad,                
    dcp_fecha_act,              dcp_numero,               dcp_fecha_aper,                  
    dcp_fecha_ven,              dcp_valor_inicial,        dcp_saldo_act,                  
    dcp_saldo_mora,             dcp_valor_cuota,          dcp_num_cuotas,                  
    dcp_periodicidad,           dcp_ciudad,               dcp_oficina,                     
    dcp_calidad,                dcp_comportamiento,       dcp_calificacion,                
    dcp_aplicativo)                 
    select 
    dcp_fecha_proceso,          dcp_orden_consulta,       dcp_tipo_reg,                  
    dcp_estado,                 dcp_tipo_prod,            dcp_entidad,                
    dcp_fecha_act,              dcp_numero,               dcp_fecha_aper,                  
    dcp_fecha_ven,              dcp_valor_inicial,        dcp_saldo_act,                  
    dcp_saldo_mora,             dcp_valor_cuota,          dcp_num_cuotas,                  
    dcp_periodicidad,           dcp_ciudad,               dcp_oficina,                     
    dcp_calidad,                dcp_comportamiento,       dcp_calificacion,                
    dcp_aplicativo                 
    
    from cob_externos..ex_dato_central_producto 
    where dcp_fecha_proceso = @i_fecha_proceso 


    if @@error <> 0 begin
       exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @i_fecha_proceso,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = '28015',
            @i_descrp_error  = 'ERROR INSERTANDO DATOS EN sb_dato_central_producto'           
    end



    /*** ELIMINA DATOS EN sb_dato_central_endeudamiento ***/

    delete sb_dato_central_endeudamiento
     where dce_fecha_proceso = @i_fecha_proceso 

    /*** INSERTA DATOS EN sb_dato_central_endeudamiento ***/
    
    insert into cob_conta_super..sb_dato_central_endeudamiento(
    dce_fecha_proceso,            dce_orden_consulta,        dce_fecha_corte,		
    dce_valor_com,                dce_cant_com,              dce_calif_com,           
    dce_valor_hip,                dce_cant_hip,              dce_calif_hip,           
    dce_valor_con,                dce_cant_con,              dce_calif_con,           
    dce_valor_mic,                dce_cant_mic,              dce_calif_mic,           
    dce_aplicativo)          
    select 
    dce_fecha_proceso,            dce_orden_consulta,        dce_fecha_corte,		
    dce_valor_com,                dce_cant_com,              dce_calif_com,           
    dce_valor_hip,                dce_cant_hip,              dce_calif_hip,           
    dce_valor_con,                dce_cant_con,              dce_calif_con,           
    dce_valor_mic,                dce_cant_mic,              dce_calif_mic,           
    dce_aplicativo
    from cob_externos..ex_dato_central_endeudamiento 
    where dce_fecha_proceso = @i_fecha_proceso 


    if @@error <> 0 begin
       exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @i_fecha_proceso,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = '28015',
            @i_descrp_error  = 'ERROR INSERTANDO DATOS EN sb_dato_central_endeudamiento'           
    end


    /*** ELIMINA DATOS EN sb_dato_central_cliente ***/

    delete sb_dato_central_huella
     where dch_fecha_proceso = @i_fecha_proceso 

    /*** INSERTA DATOS EN sb_dato_central_huella ***/
    
    insert into cob_conta_super..sb_dato_central_huella(
    dch_fecha_proceso,             dch_orden_consulta,           dch_fecha_cons,		
    dch_tipo_prod,                 dch_entidad,                  dch_oficina,             
    dch_ciudad,                    dch_aplicativo)         
    select 
    dch_fecha_proceso,             dch_orden_consulta,           dch_fecha_cons,		
    dch_tipo_prod,                 dch_entidad,                  dch_oficina,             
    dch_ciudad,                    dch_aplicativo         
    from cob_externos..ex_dato_central_huella 
    where dch_fecha_proceso = @i_fecha_proceso 

    if @@error <> 0 begin
       exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @i_fecha_proceso,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = '28015',
            @i_descrp_error  = 'ERROR INSERTANDO DATOS EN sb_dato_central_huella'           
    end


    /*** ELIMINA DATOS EN sb_dato_central_score ***/

    delete sb_dato_central_score
     where dcs_fecha_proceso = @i_fecha_proceso 

    /*** INSERTA DATOS EN sb_dato_central_score ***/
   
																																							

    insert into cob_conta_super..sb_dato_central_score(
    dcs_fecha_proceso,             dcs_orden_consulta,             dcs_tipo,                
    dcs_puntaje,                   dcs_aplicativo)              
    select                                      
    dcs_fecha_proceso,             dcs_orden_consulta,             dcs_tipo,                
    dcs_puntaje,                   dcs_aplicativo              
    from cob_externos..ex_dato_central_score    
    where dcs_fecha_proceso = @i_fecha_proceso  

    if @@error <> 0 begin
       exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @i_fecha_proceso,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = '28015',
            @i_descrp_error  = 'ERROR INSERTANDO DATOS EN sb_dato_central_score'           
    end
    --  NYMR 239


    -----------------------------------------------------------------------------------------------------------------
    -- REQ 353 ALINZAS COMERCIALES        ---------------------------------------------------------------------------

    /*** ELIMINA DATOS EN cob_conta_super..sb_alianza ***/
    delete cob_conta_super..sb_alianza
     where al_fecha_creacion = @i_fecha_proceso 

    /*** INSERTA DATOS EN cob_conta_super..sb_alianza ***/
    insert into cob_conta_super..sb_alianza (
    al_fecha,              al_aplicativo,   al_alianza,     al_ente,      al_nemonico,     al_nom_alianza,    al_tipo,            al_fecha_creacion,  
    al_fecha_fija,         al_fecha_inicio, al_fecha_fin,   al_estado,    al_tipo_credito, al_restringue_uso, al_num_uso,         al_monto_promedio,    
    al_tipo_recaudador,    al_aplica_mora,  al_dias_gracia, al_tasa_mora, al_signo_spread, al_valor_spread,   al_cuenta_bancaria, al_debito_aut,  
    al_dispersion_fondos,  al_forma_des,    al_des_cta_afi, al_gmf_banco, al_porcentaje_gmfbanco, al_fecha_pago, al_dia_pago,     al_exonera_estudio,
    al_porcentaje_exonera, al_mantiene_condiciones, al_observaciones, al_fecha_cancelacion ) 
    select                                      
    al_fecha,              al_aplicativo,   al_alianza,     al_ente,      al_nemonico,     al_nom_alianza,    al_tipo,            al_fecha_creacion,  
    al_fecha_fija,         al_fecha_inicio, al_fecha_fin,   al_estado,    al_tipo_credito, al_restringue_uso, al_num_uso,         al_monto_promedio,    
    al_tipo_recaudador,    al_aplica_mora,  al_dias_gracia, al_tasa_mora, al_signo_spread, al_valor_spread,   al_cuenta_bancaria, al_debito_aut,  
    al_dispersion_fondos,  al_forma_des,    al_des_cta_afi, al_gmf_banco, al_porcentaje_gmfbanco, al_fecha_pago, al_dia_pago,     al_exonera_estudio,
    al_porcentaje_exonera, al_mantiene_condiciones, al_observaciones, al_fecha_cancelacion 
    from cob_externos..ex_alianza    al
    where al.al_fecha = @i_fecha_proceso  

    if @@error <> 0 begin
       exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @i_fecha_proceso,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = '28015',
            @i_descrp_error  = 'ERROR INSERTANDO DATOS EN cob_conta_super..sb_alianza '           
    end



    /*** ELIMINA DATOS EN cob_conta_super..sb_alianza_banco ***/
    delete cob_conta_super..sb_alianza_banco
     where ab_fecha = @i_fecha_proceso 

    /*** INSERTA DATOS EN cob_conta_super..sb_alianza_banco ***/
    insert into cob_conta_super..sb_alianza_banco (
    ab_fecha, ab_aplicativo, ab_alianza, ab_banco, ab_cuenta, ab_estado ) 
    select                                      
    ab_fecha, ab_aplicativo, ab_alianza, ab_banco, ab_cuenta, ab_estado 
    from cob_externos..ex_alianza_banco ab
    where ab.ab_fecha = @i_fecha_proceso  

    if @@error <> 0 begin
       exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @i_fecha_proceso,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = '28015',
            @i_descrp_error  = 'ERROR INSERTANDO DATOS EN cob_conta_super..sb_alianza_banco '           
    end



    /*** ELIMINA DATOS EN cob_conta_super..sb_alianza_cliente ***/
    delete cob_conta_super..sb_alianza_cliente
     where ac_fecha = @i_fecha_proceso 

    /*** INSERTA DATOS EN cob_conta_super..sb_alianza_cliente ***/
    insert into cob_conta_super..sb_alianza_cliente  (
    ac_fecha, ac_aplicativo, ac_alianza,        ac_ente,            ac_estado, ac_fecha_asociacion,
    ac_fecha_desasociacion,  ac_fecha_creacion, ac_usuario_creador, ac_usuario_modifica )
    select                                      
    ac_fecha, ac_aplicativo, ac_alianza,        ac_ente,            ac_estado,   ac_fecha_asociacion,
    ac_fecha_desasociacion,  ac_fecha_creacion, ac_usuario_creador, ac_usuario_modifica 
    from cob_externos..ex_alianza_cliente  ac
    where ac.ac_fecha = @i_fecha_proceso  

    if @@error <> 0 begin
       exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @i_fecha_proceso,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = '28015',
            @i_descrp_error  = 'ERROR INSERTANDO DATOS EN cob_conta_super..sb_alianza_cliente  '           
    end



    /*** ELIMINA DATOS EN cob_conta_super..sb_alianza_linea ***/
    delete cob_conta_super..sb_alianza_linea 
     where al_fecha = @i_fecha_proceso 

    /*** INSERTA DATOS EN cob_conta_super..sb_alianza_linea  ***/
    insert into cob_conta_super..sb_alianza_linea (
    al_fecha, al_aplicativo, al_alianza, al_linea )
    select                                      
    al_fecha, al_aplicativo, al_alianza, al_linea
    from cob_externos..ex_alianza_linea   al
    where al.al_fecha = @i_fecha_proceso  

    if @@error <> 0 begin
       exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @i_fecha_proceso,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = '28015',
            @i_descrp_error  = 'ERROR INSERTANDO DATOS EN cob_conta_super..sb_alianza_cliente  '           
    end


    /*** ELIMINA DATOS EN cob_conta_super..sb_msv_error ***/
    delete cob_conta_super..sb_msv_error 
    where me_fecha = @i_fecha_proceso 

    /*** INSERTA DATOS EN cob_conta_super..sb_msv_error ***/
    insert into cob_conta_super..sb_msv_error  (
    me_fecha,         me_aplicativo,    me_fecha_crea,     me_id_carga, me_id_alianza, me_referencia,
    me_tipo_proceso,  me_procedimiento, me_codigo_interno, me_codigo_err, me_descripcion )
    select                                      
    me_fecha,         me_aplicativo,    me_fecha_crea,     me_id_carga, me_id_alianza, me_referencia,
    me_tipo_proceso,  me_procedimiento, me_codigo_interno, me_codigo_err, me_descripcion 
    from cob_externos..ex_msv_error  me
    where me.me_fecha  = @i_fecha_proceso  

    if @@error <> 0 begin
       exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @i_fecha_proceso,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = '28015',
            @i_descrp_error  = 'ERROR INSERTANDO DATOS EN cob_conta_super..sb_msv_error  '           
    end

    
	--INI REQ486 ENE/2015
    /*** ELIMINA DATOS EN cob_conta_super..sb_traslado_ctas_ca_ah ***/
    delete cob_conta_super..sb_traslado_ctas_ca_ah 
     where tc_fecha_corte = @i_fecha_proceso 

    /*** INSERTA DATOS EN cob_conta_super..sb_traslado_ctas_ca_ah ***/
    insert into cob_conta_super..sb_traslado_ctas_ca_ah(
    tc_fecha_corte,   tc_cliente,       tc_oficina_ini,
    tc_oficina_fin,   tc_tipo_prod )
    select
    tc_fecha_corte,   tc_cliente,       tc_oficina_ini,
    tc_oficina_fin,   tc_tipo_prod 
    from cob_externos..ex_traslado_ctas_ca_ah
    where  tc_fecha_corte = @i_fecha_proceso
    order by tc_fecha_corte, tc_cliente

    if @@error <> 0 
    begin
       exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @i_fecha_proceso,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = '28015',
            @i_descrp_error  = 'ERROR INSERTANDO DATOS EN cob_conta_super..sb_traslado_ctas_ca_ah  '           
    end
    --FIN REQ486 ENE/2015
    
	 --Req 432 - TRASLADO PASIVOS
      /***ELIMINANDO DATOS EN sb_traslado ***/
      if exists (select 1 from sb_traslado where tr_fecha_corte = @i_fecha_proceso) begin          
         delete sb_traslado
         where tr_fecha_corte = @i_fecha_proceso
      end
	  
      --CCA 432 - TRASLADO PASIVOS
	  insert into cob_conta_super..sb_traslado(
      tr_solicitud    , tr_ente         , tr_tipo_traslado, tr_estado       , 
      tr_causa_rechazo, tr_fecha_sol    , tr_ofi_solicitud, tr_usr_ingresa  , 
      tr_fecha_auto   , tr_usr_autoriza , tr_ofi_autoriza , tr_oficina_dest ,
      tr_fecha_corte)
      select 
      tr_solicitud    , tr_ente         , tr_tipo_traslado, tr_estado       , 
      tr_causa_rechazo, tr_fecha_sol    , tr_ofi_solicitud, tr_usr_ingresa  , 
      tr_fecha_auto   , tr_usr_autoriza , tr_ofi_autoriza , tr_oficina_dest ,
      tr_fecha_corte
      from cob_externos..ex_traslado
	  where tr_fecha_corte = @i_fecha_proceso

	  if @@error <> 0 begin
         exec cob_conta_super..sp_errorlog
              @i_operacion     = 'I',
              @i_fecha_fin     = @i_fecha_proceso,
              @i_fuente        = @w_sp_name,
              @i_origen_error  = '28003',
              @i_descrp_error  = 'ERROR INSERTANDO DATOS EN sb_traslado' 
      end	

      /***ELIMINANDO DATOS EN sb_traslado_detalle ***/
	  if exists (select 1 from sb_traslado_detalle where td_fecha_corte = @i_fecha_proceso) begin          
         delete sb_traslado_detalle
         where td_fecha_corte = @i_fecha_proceso
      end

      insert into cob_conta_super..sb_traslado_detalle(
      td_fecha_corte   , td_solicitud     , td_producto      , td_ofi_orig      , 
      td_ofi_dest      , td_operacion     , td_tipo_operacion, td_estado_ope    , 
      td_saldo_total   , td_saldo_dispo   , td_fecha_cons    , td_fecha_ven     , 
      td_monto         , td_intereses     , td_encanje       , td_estado_batch  , 
      td_fecha_tras    , td_observacion   )
      select
      td_fecha_corte   , td_solicitud     , td_producto      , td_ofi_orig      , 
      td_ofi_dest      , td_operacion     , td_tipo_operacion, td_estado_ope    , 
      td_saldo_total   , td_saldo_dispo   , td_fecha_cons    , td_fecha_ven     , 
      td_monto         , td_intereses     , td_encanje       , td_estado_batch  , 
      td_fecha_tras    , td_observacion   
      from cob_externos..ex_traslado_detalle
	  where td_fecha_corte = @i_fecha_proceso
	  
	  if @@error <> 0 begin
         exec cob_conta_super..sp_errorlog
              @i_operacion     = 'I',
              @i_fecha_fin     = @i_fecha_proceso,
              @i_fuente        = @w_sp_name,
              @i_origen_error  = '28003',
              @i_descrp_error  = 'ERROR INSERTANDO DATOS EN sb_traslado_detalle' 
      end	  
end -- operacion 'CL' 
  
return 0
GO

