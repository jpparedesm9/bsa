/************************************************************/
/*   ARCHIVO:         sp_xml_estado_cuenta.sp               */
/*   NOMBRE LOGICO:   sp_xml_estado_cuenta                  */
/*   PRODUCTO:        COBIS CREDITO                         */
/************************************************************/
/*   IMPORTANTE                                             */
/*   Esta aplicacion es parte de los  paquetes bancarios    */
/*   propiedad de MACOSA S.A.                               */
/*   Su uso no autorizado queda  expresamente  prohibido    */
/*   asi como cualquier alteracion o agregado hecho  por    */
/*   alguno de sus usuarios sin el debido consentimiento    */
/*   por escrito de MACOSA.                                 */
/*   Este programa esta protegido por la ley de derechos    */
/*   de autor y por las convenciones  biginternacionales de */
/*   propiedad bigintelectual.  Su uso  no  autorizado dara */
/*   derecho a MACOSA para obtener ordenes  de secuestro    */
/*   o  retencion  y  para  perseguir  penalmente a  los    */
/*   autores de cualquier infraccion.                       */
/************************************************************/
/*   PROPOSITO                                              */
/*  Generacion de archivo de los impuestos cobrados         */
/*  (IVA_CMORA,IVA_COMPRE, IVA_INT ) de los prestamos       */
/*  vigentes y sus respectivas comisiones.                  */
/************************************************************/
/*                           MODIFICACIONES                 */
/*   FECHA       AUTOR        RAZON                         */
/* 08/AGO/2017   Wtoledo     Emision inicial                */
/* 31/AGO/2018   srojas      Modificación cálculo del IVA   */
/* 28/ABR/2019   PXSG        Modificación en la extructura  */
/*                           de xml                         */
/* 06-Junio-2019 PXSG        Se realiza cambios  a la       */
/*                           fecha del estado cuenta        */
/*                           caso 118918                    */
/* 26/Junio/2019  PXSG       Se realiza cambios para EC     */
/*                           LCR req. 115931                */
/* 22/Feb/2020    DCU        Modificacion #123672           */
/* 12/Mar/2020    AGO        #123672 --FASE 2               */
/* 21/May/2020    AIN        Generación XML  para PAX       */
/* 10/10/2020     ACH        Error #148652                  */
/* 14/01/2021     ACH        Error #152243                  */
/* 05/Jul/2021    DCU        Ajuste Req. 123672             */
/* 25/Feb/2022    DCU        Ajuste Req. 179385             */   
/* 23/Mar/2022    DCU        Error #180817                  */   
/* 02/Ago/2022    DCU        Req. #174670                   */   
/************************************************************/

use cob_conta_super
go


if exists(select 1 from sysobjects where name = 'sp_xml_estado_cuenta')
    drop proc sp_xml_estado_cuenta
go
create proc sp_xml_estado_cuenta (
    @t_show_version     bit         =   0,
    @i_param1           datetime    =  null, -- FECHA DE PROCESO
    @t_debug            char(1) 	= 'N',
    @t_file             varchar(14) = null
)as

declare
   @w_sp_name            varchar(24),
   @w_parametro_tipo     varchar(50),     -- Parametro del tipo de direccion para factura
   @w_cod_cliente        int,
   @w_ruta_xml           varchar(255),
   @w_xml                xml,
   @w_sql                varchar(255),
   @w_sql_bcp            varchar(255),
   @w_comando            varchar(255),
   @w_error              int,
   -- -----------------------------
   @w_primer_dia_def_habil  datetime,
   @w_ciudad_nacional    int,
   @w_errores            varchar(1500),
   @w_path_bat           varchar(100),
   @w_riemisor           varchar(12),
   @w_file_name          varchar(64),   
   @w_count              int,
   @w_folio_referencia   varchar(80),
   @w_codigo_postal      varchar(30),
   @w_metodo_pago        varchar(10),
   @w_forma_pago         varchar(10),
   @w_ultima_ejecion     datetime,
   -- ------------------------------
   @w_nombre_entidad     varchar(180),
   @w_regimen_fiscal     varchar(100),
   @w_regimen_fiscal_rec varchar(100),
   @w_rfc_emisor         varchar(30)

select @w_sp_name               = 'sp_xml_estado_cuenta',
       @w_rfc_emisor            = 'SIF170801PYA',
       @w_nombre_entidad        = 'SANTANDER INCLUSION FINANCIERA SOCIEDAD ANONIMA DE CAPITAL VARIABLE SOCIEDAD FINANCIERA DE OBJETO MULTIPLE , ENTIDAD REGULADA, GRUPO FINANCIERO SANTANDER MEXICO',
       @w_regimen_fiscal        = '601',
       @w_regimen_fiscal_rec    = '612'

--///////////////////////////////
-- validar si se procesa o no
DECLARE
@w_reporte          varchar(10),
@w_return           int,
@w_existe_solicitud char (1) ,
@w_ini_mes          datetime ,
@w_fin_mes          datetime ,
@w_fin_mes_hab      datetime ,
@w_fin_mes_ant      datetime ,
@w_fin_mes_ant_hab  DATETIME ,
@w_msg              varchar(255),
@w_banco            varchar(32),
@w_porcentaje_iva   NUMERIC(10,6),
@w_clave_sat        varchar(30),
@w_rfc              varchar(30),
@w_clave_unidad     varchar(30),
@w_codigo           int,
@w_mail_cliente     varchar(254),
@w_buc_cliente      varchar(20),
@w_num_error        int,
@w_estado_xml       char(1),
@w_fecha_proceso    datetime,
@w_habil_anterior   datetime,
@w_fecha_proceso_fact    datetime,
@w_est_vencido           int, 
@w_est_vigente           int,
@w_est_castigado         int,
@w_est_suspenso          int,
@w_est_cancelado         int

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

SELECT @w_reporte = 'ESTCTA'

select @w_porcentaje_iva = (pa_float/100)
from  cobis..cl_parametro
where pa_nemonico = 'PIVA'
and   pa_tipo     = 'F'

exec @w_error    = cob_externos..sp_estados
@i_producto      = 7,
@o_est_vencido   = @w_est_vencido   out,
@o_est_vigente   = @w_est_vigente   out,
@o_est_castigado = @w_est_castigado out,
@o_est_suspenso  = @w_est_suspenso  out,
@o_est_cancelado = @w_est_cancelado out

EXEC @w_return = cob_conta..sp_calcula_ultima_fecha_habil
    @i_reporte          = @w_reporte,  -- buro mensual
    @o_existe_solicitud = @w_existe_solicitud  out,
    @o_ini_mes          = @w_ini_mes out,
    @o_fin_mes          = @w_fin_mes out,
    @o_fin_mes_hab      = @w_fin_mes_hab out,
    @o_fin_mes_ant      = @w_fin_mes_ant out,
    @o_fin_mes_ant_hab  = @w_fin_mes_ant_hab OUT

if @w_return != 0
begin
    select @w_error = @w_return
    select @w_msg   = 'Fallo ejecucion cob_conta..sp_calcula_ultima_fecha_habil'
    goto ERROR_PROCESO
end
print ' @o_existe_solicitud = ' + convert(varchar,@w_existe_solicitud)
print ' @o_ini_mes          = ' + isnull(convert(varchar,@w_ini_mes         ),'x')
print ' @o_fin_mes          = ' + isnull(convert(varchar,@w_fin_mes         ),'x')
print ' @o_fin_mes_hab      = ' + isnull(convert(varchar,@w_fin_mes_hab     ),'x')
print ' @o_fin_mes_ant      = ' + isnull(convert(varchar,@w_fin_mes_ant     ),'x')
print ' @o_fin_mes_ant_hab  = ' + isnull(convert(varchar,@w_fin_mes_ant_hab ),'x')
 
if @w_existe_solicitud = 'N' goto SALIDA_PROCESO

if @t_debug = 'S' print 'Ingresa al proceso'

if exists( select 1 
           from cob_credito..cr_resultado_xml 
	       where rx_fecha_fin_mes = @w_fin_mes_hab)
begin
 print 'Ya existen registros para esta fecha en la tabla cr_complemento_pago_xml'
 return 0
end

--Versionamiento del Programa --
if @t_show_version = 1
begin
  print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
  return 0
end

select @w_path_bat = pp_path_fuente   --C:\Cobis\VBatch\Credito\Objetos\
from cobis..ba_path_pro
where pp_producto = 21

--Obtiene el parametro del codigo moneda local
select @w_codigo_postal = pa_char
from cobis..cl_parametro
where pa_producto = 'REC'
and pa_nemonico = 'CPOSTA'

--Obtiene el parametro del codigo moneda local
select @w_parametro_tipo = pa_char
from cobis..cl_parametro
where pa_producto = 'CLI'
and pa_nemonico = 'RE'

select @w_ruta_xml = pp_path_destino
from cobis..ba_path_pro
where pp_producto = 21
--Obtiene el parametro del c?digo del producto SAT
select  @w_clave_sat=pa_char 
from    cobis..cl_parametro 
where   pa_nemonico ='CLPSAT' 
and     pa_producto='REC'

--CALCULO PARA DETERMINAR EL PRIMER DIA HABIL DEL MES
select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

select @w_riemisor = substring(pa_char,1,12)
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'RIEMIS'
and    pa_producto = 'CRE'
--CLAVE UNIDAD SAT
select @w_clave_unidad=pa_char
from cobis..cl_parametro 
where  pa_nemonico='CLUNSA' 
and pa_producto='REC'

select @w_primer_dia_def_habil  = @w_ini_mes

if @t_debug = 'S' print 'Ant @w_primer_dia_def_habil  = ' + convert(varchar,@w_primer_dia_def_habil )

---------------------RETURN 0 

while exists(select 1 from cobis..cl_dias_feriados
             where df_ciudad = @w_ciudad_nacional
             and   df_fecha  = @w_primer_dia_def_habil) 
begin
   select @w_primer_dia_def_habil = dateadd(day,1,@w_primer_dia_def_habil)
end

set @w_count = 0

if @t_debug = 'S' print 'Dep @w_primer_dia_def_habil = ' + isnull(convert(varchar,@w_primer_dia_def_habil),'x')

begin
    select
        @w_ini_mes = dateadd(dd, 1-datepart(dd, @w_fin_mes_hab ), @w_fin_mes_hab) ,
        @w_fin_mes = dateadd(dd, -1,dateadd(mm, 1, @w_ini_mes) )

	if @t_debug = 'S' print 'Realiza insert en cr_resultado_cml_his'

   /*Inserccion de los datos en la tabla de historicos*/
   insert into cob_credito_his..cr_resultado_xml_his (
      linea              , file_name          ,     id_ente           ,      status         , 
      rfc_ente           , num_operation      ,     insert_date       ,      processing_date, 
      rxh_cuota_desde    , rxh_cuota_hasta    ,     rxh_int_rep       ,      rxh_com_rep    , 
      rxh_int_ant        , rxh_iva            ,     rxh_met_fact      ,      rxh_form_pag   , 
      rxh_fecha_ult_compl, rxh_fecha_env_email,     rxh_tipo_operacion,      rxh_folio_ref  , 
      rxh_total_saldo_ant, rxh_fecha_fin_mes  ,     rxh_pago_compl    ,      rxh_pago_mes   , 
      rxh_pago_mes_ant   , rxh_total_saldo    ,     rxh_deuda_pagar   ,      rxh_sec_id     ,
      rxh_pago_compl_fin , rxh_genera_cmpl    ,     rxh_total_saldo_act,     rxh_pago_compl_efect,
	  rxh_iva_comision_pagada, rxh_iva_int_ant)                      
    select                                                                                    
      linea              , file_name          ,     id_ente           ,      status         , 
      rfc_ente           , num_operation      ,     insert_date       ,      processing_date, 
      rx_cuota_desde     , rx_cuota_hasta     ,     rx_int_rep        ,      rx_com_rep     , 
      rx_int_ant         , rx_iva             ,     rx_met_fact       ,      rx_form_pag    , 
      rx_fecha_ult_compl , rx_fecha_env_email ,     rx_tipo_operacion ,      rx_folio_ref   ,
      rx_total_saldo_ant , rx_fecha_fin_mes   ,     rx_pago_compl     ,      rx_pago_mes    ,
      rx_pago_mes_ant    , rx_total_saldo     ,     rx_deuda_pagar    ,      rx_sec_id      ,
      rx_pago_compl_fin  , rx_genera_cmpl     ,     rx_total_saldo_act,      rx_pago_compl_efect,
	  rx_iva_comision_pagada, rx_iva_int_ant
    from cob_credito..cr_resultado_xml
      
    if @t_debug = 'S' print 'Realiza insert en sb_ns_estado_cuenta_hist'
    
    /*Envio los datos a los historicos de la tabla sb_ns_estado_cuenta  */
    insert into cob_conta_super..sb_ns_estado_cuenta_hist (
       nec_codigo_hist            ,     nec_banco_hist        ,    nec_fecha_hist     ,     nec_correo_hist            , 
       nec_estado_hist            ,     in_cliente_rfc_hist   ,    in_cliente_buc_hist,     in_folio_fiscal_hist       , 
       in_certificado_hist        ,     in_sello_digital_hist ,    in_sello_sat_hist  ,     in_num_se_certificado_hist , 
       in_cadena_cer_dig_sat_hist ,     in_nombre_archivo_hist,    in_observacion_hist,     in_fecha_procesamiento_hist, 
       in_fecha_certificacion_hist,     in_fecha_xml_hist     ,    in_rfc_emisor_hist ,     in_estd_timb_hist          , 
       in_monto_fac_hist  ,     in_toperacion_hist    ,    in_met_fact_hist   ,     in_estado_pdf_hist         ,
	   in_estado_correo_hist      ,     in_nombre_pdf_hist    ,    in_estd_clv_co_hist,     in_grupo_hist           ,
	    in_nombre_cli_hist         ,     in_cuota_desde_hist   ,    in_cuota_hasta_hist,     in_folio_ref_hist          ,
	    in_fecha_fin_mes_hist) 
    select 
       nec_codigo                 ,     nec_banco             ,    nec_fecha          ,     nec_correo                 , 
       nec_estado                 ,     in_cliente_rfc        ,    in_cliente_buc     ,     in_folio_fiscal            , 
       in_certificado             ,     in_sello_digital      ,    in_sello_sat       ,     in_num_se_certificado      , 
       in_cadena_cer_dig_sat      ,     in_nombre_archivo     ,    in_observacion     ,     in_fecha_procesamiento     ,
       in_fecha_certificacion     ,     in_fecha_xml          ,    in_rfc_emisor      ,     in_estd_timb               , 
       in_monto_fac               ,     in_toperacion         ,    in_met_fact        ,     in_estado_pdf              ,
       in_estado_correo           ,     in_nombre_pdf	      ,    in_estd_clv_co     ,     in_grupo                   ,
	    in_nombre_cli              ,     in_cuota_desde        ,    in_cuota_hasta     ,     in_folio_ref               ,
	    in_fecha_fin_mes
    from cob_conta_super..sb_ns_estado_cuenta
      
     /*Envio los datos a los historicos de la tabla cr_rfc_int_error  */ 
     insert into  cob_credito_his..cr_rfc_int_error_hist
     ( rfc_int_error_hist,         status_rfc_err_hist,      
       insert_date_rfc_err_hist,   process_date_rfc_err_hist
     )
     select  
       rfc_int_error,         status_rfc_err,      
       insert_date_rfc_err,   process_date_rfc_err
       from cob_credito..cr_rfc_int_error
   
    /*Elimino datos de la tabla*/
    truncate table cob_credito..cr_resultado_xml
    truncate table cob_conta_super..sb_ns_estado_cuenta
    truncate table cob_credito..cr_rfc_int_error
	
	/*Caso 148652 - Cambios con select por secuencial y banco, en el sp cob_conta_super..sp_cons_estado_cuenta*/
    truncate table sb_estcta_cab_tmp 
    truncate table sb_info_cre_tmp
    truncate table sb_amortizacion_tmp
    truncate table sb_dato_operacion_abono_temp
    truncate table sb_movimientos_tmp
	---
    truncate table sb_estcta_cab_tmp_lcr
    truncate table sb_info_cre_tmp_lcr
    truncate table sb_resumen_pagos_tmp_lcr
    truncate table sb_dato_operacion_abono_temp_lcr	
	
    /* TABLA PARA SACAR INFORMACION DE LOS MESES ANTERIORES */
    CREATE table #amortizacion_aux(
    amx_tipo       varchar(10),
    amx_banco      varchar(32),
    amx_concepto   varchar(30),
    amx_cuota      NUMERIC(20,2) not null,
    amx_acumulado  NUMERIC(20,2) not null,
    amx_pagado     NUMERIC(20,2) not null
    )
    
    /* TABLA PARA SACAR INFORMACION CONSOLIDADA DE LOS MESES ANTERIORES */
    
    create table #amortizacion_def(
    am_tipo          varchar(10),
    am_banco         varchar(32),
    am_concepto      varchar(30),
    am_cuota         numeric(20,2) not null,
    am_pagado        numeric(20,2) not null,
    am_iva           numeric(20,2) not null,
    am_cuota_ini     int null,
    am_cuota_fin     int null,
    am_comision_lcr  numeric(20,2)  null,
    am_iva_com_lcr   numeric(20,2)  null)
    
    create table #comisiones_mora(
    am_tipo          varchar(10),
    am_banco         varchar(32),
    am_concepto      varchar(30),
    am_cuota         numeric(20,2) not null,
    am_pagado        numeric(20,2) not null,
    am_iva           numeric(20,2) not null,
    am_cuota_ini     int null,
    am_cuota_fin     int null,
    am_comision_lcr  numeric(20,2)  null,
    am_iva_com_lcr   numeric(20,2)  null)
    
     /*Encuentro la fecha anterior al fin de mes habil*/
     select @w_habil_anterior= dateadd(dd, -1, @w_fin_mes_hab)
    
    while exists (select 1
                      from cobis..cl_dias_feriados
                where df_fecha  = @w_habil_anterior
                      and   df_ciudad = @w_ciudad_nacional)
    begin
       select @w_habil_anterior= dateadd(dd, -1, @w_habil_anterior)
       
    end
    
    print '@w_habil_anterior '+convert (varchar(50),@w_habil_anterior) 

   /* Tabla para Obtener los operaciones Revolventes a reportar en el mes */
    create table #operaciones_rev(
    op_banco_rev       varchar(24)
    )
	
	/****************************************************************/
	/* Obtener el universo                                          */
	/****************************************************************/
	select *
	into #sb_dato_operacion_universo
	from cob_conta_super..sb_dato_operacion
	where do_fecha      = @w_fin_mes_hab
	and   do_aplicativo = 7
	and   do_tipo_operacion  in ('GRUPAL','REVOLVENTE')
	and   do_estado_cartera not in (@w_est_vencido, @w_est_castigado)
    
    /****************************************************************/
    /*Obtener informacion anterior                                  */
    /****************************************************************/
    select @w_ultima_ejecion = max(insert_date)
    from cob_credito_his..cr_resultado_xml_his
    where rxh_fecha_fin_mes = @w_fin_mes_ant
    
    
    select 
    num_operation = num_operation, 
    rxh_int_ant   = isnull(rxh_int_ant,0),
     max_sec_id    = max(rxh_sec_id),
    rx_iva_int_ant= isnull(rxh_iva_int_ant,0)  
    into #interes_enterior
    from cob_credito_his..cr_resultado_xml_his
    where rxh_fecha_fin_mes = @w_fin_mes_ant
    group by num_operation,rxh_int_ant, rxh_iva_int_ant
    --and   insert_date       = @w_ultima_ejecion
    
	if @t_debug = 'S' print 'Insert en #operaciones_rev'

    /*insert into #operaciones_rev
    select distinct tr_banco
    from cob_cartera..ca_transaccion, cob_cartera..ca_det_trn
    where tr_operacion=dtr_operacion
    and   tr_secuencial=dtr_secuencial
    and   tr_fecha_ref BETWEEN @w_ini_mes AND @w_fin_mes
    and   tr_estado<>'RV'
    and   tr_tran in('DES','PAG')
    and   tr_toperacion='REVOLVENTE'
    and   tr_secuencial>0
   */
    
    /**************************************************************************/
    /* PROCESO PARA OBTENER LOS VALORES FACTURADOS EN EL PERIODO DEL REPORTE */
    /**************************************************************************/

	if @t_debug = 'S' print 'Insert en tabla #amortizacion_aux'

    /* DETERMINAR LAS OPERACIONES Y SUS RUBROS */
	if exists(select 1 from sb_operacion_tmp)
		INSERT INTO #amortizacion_aux
		SELECT 'D' ,dr_banco, dr_concepto, 0, 0, 0
		FROM cob_conta_super..sb_dato_operacion_rubro, sb_operacion_tmp
		WHERE dr_fecha = @w_fin_mes_hab
		AND dr_aplicativo = 7
		and ot_banco = dr_banco
		and dr_concepto  <> 'CAP'
		GROUP BY dr_banco, dr_concepto
	else
	  begin
    	/*Inserto las operaciones Grupales*/
		INSERT INTO #amortizacion_aux
		SELECT 'D' ,dr_banco, dr_concepto, 0, 0, 0
		FROM cob_conta_super..sb_dato_operacion_rubro,
		#sb_dato_operacion_universo
		WHERE dr_fecha = @w_fin_mes_hab
		AND dr_aplicativo = 7
		and dr_concepto  <> 'CAP'
		and dr_banco      = do_banco
		GROUP BY dr_banco, dr_concepto

	  end
         
	  --Creacion de Indice
      create index idx0 on #amortizacion_aux(amx_banco,amx_concepto)
	  
      truncate table #amortizacion_def 
      truncate table #comisiones_mora
          /*Encontramos los Pagos por numero de cuotas*/
    select *
    into #pagos_ante
    from sb_dato_operacion_abono
    where doa_fecha = @w_fin_mes_ant_hab
    order by doa_sec_pag 
        
    select 
    banco    = doa_banco,
    operacion= doa_operacion,
    sec_pag  = doa_sec_pag,
    sec_rpa  = doa_sec_rpa,
    fecha_pag= doa_fecha_pag,
    dividendo = doa_dividendo
    into #pagos_act
    from sb_dato_operacion_abono
    where doa_fecha = @w_fin_mes_hab    
    
    
    delete #pagos_act 
    where exists(select 1
    from #pagos_ante ant
    where ant.doa_operacion = operacion
    and   ant.doa_fecha_pag = fecha_pag) 
      
    
    select distinct 
    tr_banco=tr_banco,
    dividendo=dtr_dividendo,
    tr_tran=tr_tran,
    concepto=dtr_concepto,
    div_min=0,
    div_max=0
    into #operaciones
    from #pagos_act, cob_cartera..ca_transaccion, cob_cartera..ca_det_trn
    where tr_operacion   = operacion
    and   tr_secuencial  = sec_pag
    and   tr_operacion   = dtr_operacion
    and   tr_secuencial  = dtr_secuencial
    and   tr_estado<>'RV'
    and   tr_tran in('DES','PAG')
    and   tr_secuencial>0
    and   dtr_dividendo <>0
    
    select 
    banco   = tr_banco,
    min_div = min(dividendo),
    max_div = max(dividendo) 
    into #operaciones_min_max
    from #operaciones
    where tr_tran='PAG'
    group by tr_banco,tr_tran 
    
    UPDATE #operaciones SET 
    div_min = min_div,
    div_max = max_div
    FROM #operaciones_min_max
    WHERE banco=tr_banco
    AND tr_tran='PAG'
	
      select *
      into  #sb_dato_cuota_pry
      from  cob_conta_super..sb_dato_cuota_pry,
      #sb_dato_operacion_universo 
      where dc_fecha      = @w_fin_mes_hab
      and   dc_aplicativo = 7
      and   dc_banco      = do_banco
      
      create index idx0 on #sb_dato_cuota_pry(dc_banco, dc_fecha_vto)
      
       
      insert into #amortizacion_def(
         am_tipo        ,
         am_banco       ,
         am_concepto    ,
         am_cuota       ,
         am_pagado      ,
         am_iva         ,
         am_cuota_ini   ,
         am_cuota_fin   ,
         am_comision_lcr,
         am_iva_com_lcr)
      select
         'D',
         amx_banco, 
         amx_concepto, 
         am_cuota     = isnull(CASE amx_concepto    
                        WHEN 'INT'        THEN SUM(dc_int_acum)
                        WHEN 'COMPRECAN'  THEN SUM(dc_pre_cuota)
                        ELSE 0 END,0),
         am_pagado    = isnull(CASE   amx_concepto  
                        WHEN 'INT'   THEN SUM(dc_int_pag)
                        WHEN 'COMPRECAN'  THEN SUM(dc_pre_pag)
                        ELSE 0 END,0),		
		 isnull(CASE amx_concepto    
                        WHEN 'INT'        THEN ceiling(sum(dc_int_acum) * @w_porcentaje_iva * 100)/100
                        WHEN 'COMPRECAN'  THEN ceiling(sum(dc_pre_cuota) * @w_porcentaje_iva * 100)/100
                        ELSE 0 END,0),                        
         am_cuota_min =min(dc_num_cuota),
	     am_cuota_max =max(dc_num_cuota),
	     0,
	     0                 
      from  #sb_dato_cuota_pry, #amortizacion_aux
      where dc_banco    = amx_banco
      and   dc_fecha_vto between @w_ini_mes and @w_fin_mes
      and   amx_concepto = 'INT'
      group by amx_banco, amx_concepto 
      
      create index idx0 on #amortizacion_def(am_banco,am_concepto)

      insert into #amortizacion_def(
         am_tipo        ,
         am_banco       ,
         am_concepto    ,
         am_cuota       ,
         am_pagado      ,
         am_iva         ,
         am_cuota_ini   ,
         am_cuota_fin   ,
         am_comision_lcr,
         am_iva_com_lcr)
      select
         'D',
         tr_banco, 
         concepto, 
         am_cuota     = isnull(CASE concepto    
                        WHEN 'COMMORA'        THEN SUM(dc_imo_pag)
                        
                        ELSE 0 END,0),
         am_pagado    = isnull(CASE   concepto  
                        WHEN 'COMMORA'   THEN SUM(dc_imo_pag)
                       
                        ELSE 0 END,0),		
		 isnull(CASE concepto    
                        WHEN 'COMMORA'   THEN ceiling(sum(dc_imo_pag) * @w_porcentaje_iva * 100)/100
                     
                        ELSE 0 END,0),                        
         am_cuota_min =min(dc_num_cuota),
	     am_cuota_max =max(dc_num_cuota),
	     0,
	     0                 
      from  #sb_dato_cuota_pry, #operaciones
      where dc_banco    = tr_banco
      and   dc_num_cuota between div_min and div_max
      AND   dc_num_cuota=dividendo
      and   concepto = 'COMMORA'
      group by tr_banco, concepto 
     
      -- validar los cuotas
      truncate table sb_est_cuenta_xml
      truncate table sb_est_rubro_ope

      select 
      am_banco    = am_banco,
      am_concepto = am_concepto,
      am_pagado   = am_pagado
      INTO #operaciones_rep
      FROM #amortizacion_def

      /*
      select 
      banco  = am_banco,
      cont   = count(1) , 
      concep = convert(varchar(10),null) 
      into #agrupacion_conceptos 
      from #operaciones_rep
      group by am_banco

      update #agrupacion_conceptos set 
      concep = am_concepto 
      from #operaciones_rep a,#agrupacion_conceptos b
      where b.banco = a.am_banco 
      and cont = 1 

      insert into #operaciones_rep 
      select 
      banco = a.banco ,
      concepto  = case  when  concep ='COMMORA' then 'INT' end ,
      monto = 0
      from #agrupacion_conceptos a,#operaciones_rep b 
      where a.banco = b.am_banco  
      and   a.concep = b.am_concepto

      insert into sb_est_rubro_ope(
      ero_fecha            ,     ero_tipo                   ,   ero_banco,   ero_concepto,
      ero_cuota            ,     ero_pagado                 ,   ero_iva  ,
      ero_cfdiClaveProdServ,     ero_cfdiClaveUnidad)   
      SELECT 
      @w_fin_mes_hab      ,     'D'                          ,   am_banco , 'INTERESES DEVENGADOS EXIGIBLES',
      0                   ,      0							, 0          ,
      @w_clave_sat        ,     isnull(@w_clave_unidad,'E48')
      from  #operaciones_rep,#agrupacion_conceptos
      where   am_concepto ='INT' 
      AND banco = am_banco
      AND concep ='COMMORA'
      AND cont=1
      group by am_banco*/
	  
	  insert into sb_est_cuenta_xml (
	        ecx_banco            ,    ecx_tipo_operacion   ,      ecx_ente             , 
	        ecx_cfdi_uso_cfdi    ,    ecx_residencia_fiscal,      ecx_cod_pais         ,
	        ecx_tipo_documento   ,    
	        ecx_lugar_expedicion ,      
	        ecx_fecha            ,
	        ecx_regimen_fiscal_emisor,
	        ecx_moneda           ,
	        ecx_cfdi_metodo_pago ,
	        ecx_codigo_multiple  ,
	        ecx_cfdi_impuesto    ,
	        ecx_cfdi_tipo_factor ,
	        ecx_cfdi_tasao_cuota ,
	        ecx_codigo_multiple_impuesto,
	        ecx_forma_pago       ,
	        ecx_u_x0020_de_x0020_m,
	        ecx_ri                ,
	        ecx_int_anticipado    ,
	        ecx_comision          ,
	        ecx_iva               ,
	        ecx_total_impuestos_trasladados,
	        ecx_sec_id,
	        ecx_comisiones_efec_mes)                                          
	  select do_banco             ,    do_tipo_operacion    ,     do_codigo_cliente    , 
	         'G03'                ,    'MEX'                ,     'MEX'                ,
	         'I'                  ,    
	         convert(varchar(100),@w_codigo_postal),
	         format(dateadd(ss,86399,@w_fin_mes_hab), 'yyyy-MM-ddTHH:mm:ss'),
	         '601',                
	         'MXN',
	         'PUE',
	         'TrasladoConcepto',
	         '002',
	         'Tasa',
	         '0.160000',
	         'cfdiImpuestos',
	         '03',
	         'ACT',
	         @w_riemisor,
	         0,
	         0,
	         0,
	         0,
	         1,
	         0
	  from #sb_dato_operacion_universo,
	       #amortizacion_def
	  where do_fecha      = @w_fin_mes_hab
	  and   do_aplicativo = 7
	  and   do_banco      = am_banco
	  group by do_banco, do_tipo_operacion, do_codigo_cliente
	 
	  /*Encuentro secuencial ultimo de la Historica de acuerdo a la fecha fin mes*/
     select 
     banco_his            = num_operation,
     fecha_fin_mes_his    = rxh_fecha_fin_mes,
     rxh_sec_id_his       = isnull(max(rxh_sec_id),0)
     into #max_sec_operacion
     from cob_credito_his..cr_resultado_xml_his
     where rxh_fecha_fin_mes=@w_fin_mes_hab
     group by num_operation,rxh_fecha_fin_mes
         

     update cob_conta_super..sb_est_cuenta_xml
     set ecx_sec_id= isnull(rxh_sec_id_his,0)+1
     from #max_sec_operacion ,cob_conta_super..sb_est_cuenta_xml
     where banco_his             = ecx_banco
     and   fecha_fin_mes_his     = @w_fin_mes_hab
	 
	 --Comisiones Commora
	 select banco, sec_pag into #pagos_act_sec from #pagos_act group by banco, sec_pag
	 
      insert into #comisiones_mora(
         am_tipo        ,
         am_banco       ,
         am_concepto    ,
         am_cuota       ,
         am_pagado      ,
         am_iva         ,
         am_cuota_ini   ,
         am_cuota_fin   ,
         am_comision_lcr,
         am_iva_com_lcr)
     select 
     'D',
     banco      = banco,
     concepto   = dtr_concepto,
     monto      = sum(dtr_monto),
     monto      = sum(dtr_monto),
     ceiling(sum(dtr_monto) * @w_porcentaje_iva * 100)/100,
     0,
     0,
     0,
     0
    from #pagos_act_sec,
    cob_cartera..ca_transaccion,
    cob_cartera..ca_det_trn,
    sb_est_cuenta_xml
    where banco          = ecx_banco 
    and   tr_banco       = ecx_banco 
    and   tr_secuencial  = sec_pag
    and   tr_operacion   = dtr_operacion
    and   tr_secuencial  = dtr_secuencial
    and   tr_estado<>'RV'
    and   tr_tran in('PAG')
    and   dtr_concepto in ('COMMORA', 'COMPRECAN')
    group by banco, dtr_concepto
     
   
    
      /*select 'D', 
             dt_banco, 
             dd_concepto, 
             sum(isnull(dd_monto,0)),  
             sum(isnull(dd_monto,0)),
             isnull(case dd_concepto    
                    when 'COMMORA'    THEN ceiling(sum(dd_monto) * @w_porcentaje_iva * 100)/100
                    when 'COMPRECAN'  THEN ceiling(sum(dd_monto) * @w_porcentaje_iva * 100)/100
                    else 0 end,0), 
             0,
             0,
             0,
             0    
      from  sb_est_cuenta_xml,
            cob_conta_super..sb_dato_transaccion,
            cob_conta_super..sb_dato_transaccion_det
      where dt_banco      = ecx_banco 
      and   dt_fecha_trans<= @w_fin_mes
      and   dt_fecha_trans>= @w_ini_mes
      and   dt_fecha      = dd_fecha
      and   dt_secuencial = dd_secuencial
      and   dt_banco      = dd_banco
      and   dt_reversa    = 'N'
      and   dt_aplicativo = 7
      and   dt_tipo_trans = 'PAG'
      and   dd_concepto in ('COMMORA', 'COMPRECAN' )
      group by dt_banco, dd_concepto*/

      create index idx0 on #comisiones_mora(am_banco,am_concepto)
      
	  
	 --Comisiones LCR
	 select ecx_banco, comisiones = sum(dc_com_lcr)
	 into #comisiones_lcr
	 from  #sb_dato_cuota_pry    , sb_est_cuenta_xml
     where dc_banco     = ecx_banco
     and   dc_fecha_vto between @w_ini_mes and @w_fin_mes
     and   ecx_tipo_operacion = 'REVOLVENTE'
     group by ecx_banco
       
	 
     -- Actualizacion Informacion Cliente
	 update sb_est_cuenta_xml set
	 ecx_rfc        = convert(varchar(25), en_nit),
	 ecx_id_externo = convert(varchar(25), en_ente),
	 ecx_nombre     = isnull(convert(varchar(254), en_nomlar),''),
	 ecx_buc        = en_banco
	 from cobis..cl_ente
	 where en_ente  = ecx_ente 
	 
	 ---drop table #ult_direccion_cliente	 	 
	 select cliente = ecx_ente, ultima_direccion = max(di_direccion)
	 into #ult_direccion_cliente
	 from sb_est_cuenta_xml,
	      cobis..cl_direccion
	 where di_ente = ecx_ente
	 and   di_tipo = 'RE'--@w_parametro_tipo 
	 group by ecx_ente 
	 
	 update sb_est_cuenta_xml set 
	 ecx_calle             = isnull(convert(varchar(250), di_calle),''),
	 ecx_no_exterior       = convert(varchar(200), di.di_nro),
	 ecx_no_interior       = convert(varchar(200), di.di_nro_interno),
	 ecx_colonia_parroquia = isnull(pq_descripcion,''),
	 ecx_localidad         = isnull(pq_descripcion,''),
	 ecx_municipio_ciudad  = isnull(ci_descripcion,''),
	 ecx_estado_provincia  = isnull(pv_descripcion,''),
	 ecx_codigo_postal     = isnull(convert(varchar(80),di_codpostal),'')
	 from #ult_direccion_cliente,
	      cobis..cl_direccion di,
	      cobis..cl_parroquia p ,
	      cobis..cl_ciudad    c ,
	      cobis..cl_provincia r
	 where ecx_ente         = cliente
	 and   cliente          = di_ente
	 and   ultima_direccion = di_direccion
	 and   p.pq_parroquia   = di.di_parroquia
	 and   c.ci_ciudad      = di.di_ciudad
     and   r.pv_provincia   = di.di_provincia
     
     update sb_est_cuenta_xml set 
     ecx_telefono   =  te_valor
     from cobis..cl_telefono
     where ecx_ente = te_ente  
     
     update sb_est_cuenta_xml set 
     ecx_email   =  convert(varchar(100), isnull(di_descripcion,''))
     from cobis..cl_direccion
     where ecx_ente     = di_ente  
     and   di_tipo      = 'CE'
     and  di_descripcion is not null                
     --
  	
	 --INSERCION INTERESES
	 insert into sb_est_rubro_ope(
     ero_fecha            ,     ero_tipo                   ,   ero_banco,   ero_concepto,
     ero_cuota            ,     ero_pagado                 ,   ero_iva  ,
     ero_cfdiClaveProdServ,     ero_cfdiClaveUnidad)       
     select                                                
     @w_fin_mes_hab      ,     'D'                          ,   am_banco , 'INTERESES DEVENGADOS EXIGIBLES',
     sum(am_cuota)       ,     sum(am_pagado)               ,  sum(am_iva)   ,
     @w_clave_sat        ,     isnull(@w_clave_unidad,'E48')
     from  #amortizacion_def
     where am_concepto = 'INT'
     group by am_banco
     
     --Datos Actuales
     update sb_est_cuenta_xml set
     ecx_int = isnull(am_cuota,0),
     ecx_deuda_por_pagar = isnull(am_cuota,0) - isnull(am_pagado,0)
     from  #amortizacion_def
     where  am_banco    = ecx_banco
     and    am_concepto = 'INT'
     
     --Restar Interes Anteriores
     select 
     operacion            = va_operacion, 
     valor_anticipo       = isnull(va_valor_anticipo,0)    , 
     valor_iva_anticipo   = isnull(va_valor_iva_anticipo,0),
     valor_cuota          = ero_cuota            ,
     valor_pagado         = ero_pagado           ,
     valor_iva            = ero_iva              ,
     res_pendiente        = isnull(va_valor_anticipo,0) - isnull(va_valor_devengado,0),
     res_pendiente_iva    = isnull(va_valor_iva_anticipo,0) - isnull(va_valor_iva_devengado,0)
     into #valores_anticipados_pend
     from sb_valores_anticipados,
     sb_est_rubro_ope
     where va_operacion = ero_banco
     and   va_valor_anticipo - va_valor_devengado > 0
     
     update sb_est_rubro_ope set
     ero_cuota  = case when valor_cuota  - res_pendiente     < 0 then 0 else valor_cuota  - res_pendiente  end,
     ero_pagado = case when valor_pagado - res_pendiente     < 0 then 0 else valor_pagado - res_pendiente  end     
     from #valores_anticipados_pend
     where operacion = ero_banco
     
	 --dcu
	 update sb_est_rubro_ope set
     ero_iva    = ceiling(ero_cuota * @w_porcentaje_iva * 100)/100              
     from #valores_anticipados_pend
     where operacion = ero_banco 
     
     update sb_valores_anticipados set
     va_valor_devengado =  case when va_valor_devengado +  valor_cuota <= va_valor_anticipo 
                           then va_valor_devengado +  valor_cuota
                           else va_valor_anticipo end,
     va_valor_iva_devengado = case when va_valor_iva_devengado +  valor_iva <= va_valor_iva_anticipo 
                           then va_valor_iva_devengado +  valor_iva
                           else va_valor_iva_anticipo end
     from #valores_anticipados_pend
     where operacion = va_operacion 
     
     /*update sb_est_rubro_ope set 
     ero_pagado = ero_pagado - isnull(rxh_int_ant,0),
     ero_iva = ero_iva - isnull(rx_iva_int_ant,0)
     from sb_valores_anticipados
     where va_operacion = num_operation*/
     
     update sb_est_cuenta_xml set
     ecx_int_pagado = ero_pagado
     from sb_est_rubro_ope
     where ecx_banco    = ero_banco
     and   ero_concepto = 'INTERESES DEVENGADOS EXIGIBLES'
     
     /* INTERES PAGADO ANTICIPADO*/
     select 'pa_banco'    = amx_banco   , 
            'pa_concepto' = amx_concepto,
            'pa_pagado'   = isnull(CASE amx_concepto    
                              WHEN 'INT'        THEN SUM(dc_int_pag)                             
                           ELSE 0 END,0),
            'pa_iva_pagado'   = isnull(CASE amx_concepto    
                           WHEN 'INT'        THEN SUM(dc_iva_int_pag)                             
                        ELSE 0 END,0) 
     into #pagos_anticipados                       	
     from  #sb_dato_cuota_pry    , #amortizacion_aux
     where dc_fecha_vto > @w_fin_mes_hab 
     and amx_concepto = 'INT'
     and   amx_banco = dc_banco
     and   dc_int_pag > 0
     and   exists (select 1 from sb_est_rubro_ope where ero_banco = dc_banco and ero_cuota > 0)
     group by amx_banco, amx_concepto 
    
    
     insert into sb_est_rubro_ope(
     ero_fecha            ,     ero_tipo           ,   ero_banco,   ero_concepto,
     ero_cuota            ,     ero_pagado         ,   ero_iva  ,
     ero_cfdiClaveProdServ,     ero_cfdiClaveUnidad)
     select       
     @w_fin_mes_hab        ,     'D'           ,   pa_banco, 'INTERESES ANTICIPADOS',
     sum(pa_pagado)        ,     sum(pa_pagado),   ceiling(sum(pa_pagado) * @w_porcentaje_iva * 100)/100,
     @w_clave_sat          ,     isnull(@w_clave_unidad,'E48')
     from  #pagos_anticipados 
     where pa_pagado > 0
     group by pa_banco
     
     insert into sb_valores_anticipados(
	 va_operacion          ,
	 va_valor_anticipo     ,
     va_valor_iva_anticipo ,
     va_valor_devengado    ,
     va_valor_iva_devengado,
     va_fecha)
     select     
     pa_banco           ,   
     sum(pa_pagado)     ,
     sum(pa_iva_pagado) ,
     0                  ,
     0                  ,
     @w_fin_mes_hab       
     from  #pagos_anticipados 
     where pa_pagado > 0
     group by pa_banco
     
     
     /*COMISIONES PAGADAS*/
     
     select * into #comisiones from sb_est_rubro_ope where 1 = 2
     
    select am_banco, 
    comisiones_acumuladas_pag = sum(isnull(am_pagado,0)), 
    comiones_pagadas_mes =sum(isnull(am_pagado,0))
    into #comisiones_pagadas
    from #comisiones_mora
    group by am_banco
     
    insert into #comisiones(
    ero_fecha                ,     ero_tipo                 ,   ero_banco       ,   ero_concepto         ,
    ero_cuota                ,     ero_pagado               ,   ero_iva         ,   ero_cfdiClaveProdServ,       
    ero_cfdiClaveUnidad      )
    select       
    @w_fin_mes_hab           ,     'D'                      ,   am_banco        ,   'COMISIONES',
    sum(isnull(comiones_pagadas_mes,0)) ,     sum(isnull(comiones_pagadas_mes,0)) ,   0               ,    null       ,     
    null
    from  #comisiones_pagadas 
    where comiones_pagadas_mes   > 0  
    group by am_banco 
    
    insert into #comisiones(
    ero_fecha                ,     ero_tipo                 ,   ero_banco       ,   ero_concepto         ,
    ero_cuota                ,     ero_pagado               ,   ero_iva         ,   ero_cfdiClaveProdServ,       
    ero_cfdiClaveUnidad      )                                
    select                                                    
    @w_fin_mes_hab           ,     'D'                      ,   ecx_banco       ,  'COMISIONES',
    sum(isnull(comisiones,0)),     sum(isnull(comisiones,0)),   0               ,   null       ,     
    null
    from  #comisiones_lcr 
    group by ecx_banco   
    
    insert into sb_est_rubro_ope(
     ero_fecha            ,     ero_tipo           ,   ero_banco,   ero_concepto,
     ero_cuota            ,     ero_pagado         ,   ero_iva  ,
     ero_cfdiClaveProdServ,     ero_cfdiClaveUnidad)
    select       
     ero_fecha            ,     ero_tipo           ,   ero_banco,   ero_concepto,
     sum(ero_cuota)       ,     sum(ero_pagado)    ,   ceiling(sum(ero_cuota) * @w_porcentaje_iva * 100)/100  ,
     @w_clave_sat         ,     isnull(@w_clave_unidad,'E48')
    from  #comisiones
    group by ero_fecha, ero_tipo, ero_banco, ero_concepto
    
    select 
    'com_banco' = ero_banco,
    'com_agrup' = sum(ero_cuota),
    'iva_agrup' = sum(ero_iva)
    into #comisiones_agrup
    from sb_est_rubro_ope
    where ero_concepto = 'COMISIONES'
    group by ero_banco
    
    update  sb_est_cuenta_xml set
    ecx_comision           = com_agrup,
    ecx_iva_comision_pagada= iva_agrup
    from #comisiones_agrup
    where ecx_banco    = com_banco
    --
    
    select ero_banco,
           cuota = sum(isnull(ero_cuota,0)),
           iva   = sum(isnull(ero_iva,0))
    into #totales
    from sb_est_rubro_ope
    group by ero_banco
    
    
    
    update sb_est_cuenta_xml set
    ecx_sub_total     = isnull(cuota,0),
    ecx_total         = isnull(cuota,0) + isnull(iva,0),
    ecx_cfdi_base     = isnull(cuota,0),
    ecx_total_impuestos_trasladados = isnull(iva,0),
    ecx_iva         = isnull(iva,0),
    ecx_cfdi_importe= isnull(iva,0)
    from #totales
    where ero_banco = ecx_banco 
        
    update sb_est_cuenta_xml set
    ecx_int_anticipado = pa_pagado,
    ecx_iva_int_ant    = pa_iva_pagado
    from #pagos_anticipados
    where pa_banco    = ecx_banco
    and   pa_concepto = 'INT'
    
    /****************************************************/
    /* Actualizacion Metodo Pago                        */
    /****************************************************/
    select banco   = am_banco,
           'cuota' = sum(am_cuota), 
           'pago'  = sum(am_pagado),
           'iva'   = sum(am_iva),
           cuota_ini = min (am_cuota_ini),
           cuota_fin = min (am_cuota_fin)
    into #operacion_pagado
    from #amortizacion_def
    where am_concepto in ('INT', 'COMMORA' , 'COMPRECAN')
    group by am_banco
    
     select banco   = am_banco,
           cuota_ini = min (am_cuota_ini),
           cuota_fin = min (am_cuota_fin)
    into #operacion_pagado_sec
    from #amortizacion_def
    where am_concepto = 'INT'
    group by am_banco
    
    
    update sb_est_cuenta_xml set
    ecx_cuota_ini = cuota_ini,
    ecx_cuota_fin = cuota_fin
    from #operacion_pagado_sec
    where banco = ecx_banco

    update sb_est_cuenta_xml set
    ecx_cfdi_metodo_pago = 'PPD',
    ecx_forma_pago       = '99'
    from #operacion_pagado
    where banco = ecx_banco
    and   (cuota - pago) > 0
    and   isnull(ecx_int_pagado,0) >= 0
    
  
    /**********************************************/ 
    /*Actualizacion secuencial                    */
    /**********************************************/ 
    
    select ecx_banco
    into #secuenciales
    from sb_est_cuenta_xml
    group by ecx_banco
    
    update sb_secuenciales
    set ss_secuencial = ss_secuencial + 1
    from #secuenciales
    where ss_operacion = ecx_banco
    
    delete #secuenciales
    from sb_secuenciales
    where ss_operacion = ecx_banco
    
    insert into sb_secuenciales with (rowlock) 
    select ecx_banco, 1
    from #secuenciales
    
    /**********************************************/ 
    /*Actualizacion secuencial                    */
    /**********************************************/ 
    update sb_est_cuenta_xml set
    ecx_secuencial = ss_secuencial
    from sb_secuenciales
    where ecx_banco = ss_operacion
    
    /**********************************************/ 
    /*Actualizacion nombre archivo                */
    /**********************************************/ 
    update sb_est_cuenta_xml set
    ecx_file = case when ecx_tipo_operacion =  'GRUPAL' then 'GRP' else 'LCR' end + '_I_' + ecx_banco + '_'+ format(cast(@w_fin_mes as date),'ddMMyyyy') + '_'+  RIGHT('00000000'+ISNULL(convert(varchar,ecx_secuencial),''),3)
    
    
    /*************************************************/
    /* Actualizacion pago complemento                */
    /*************************************************/
    /*
    select 
    banco      = dt_banco,
    cuota_ini  = ecx_cuota_ini,
    cuota_fin  = ecx_cuota_fin,
    monto      = sum(dd_monto) 
    into #comisiones_efec_mes from
    from #pagos_act, cob_cartera..ca_transaccion, cob_cartera..ca_det_trn
    where tr_operacion   = operacion
    and   tr_secuencial  = sec_pag
    and   tr_operacion   = dtr_operacion
    and   tr_secuencial  = dtr_secuencial
    and   tr_estado<>'RV'
    and   tr_tran in('PAG')
    and   dd_concepto in ('COMMORA', 'COMPRECAN')
    and   tr_secuencial>0
    and   dtr_dividendo <>0
    and   dd_dividendo between ecx_cuota_ini and ecx_cuota_fin
    group by dt_banco, ecx_cuota_ini,ecx_cuota_fin
    */
    /*select 
    banco      = banco,
    cuota_ini  = ecx_cuota_ini,
    cuota_fin  = ecx_cuota_fin,
    monto      = sum(dtr_monto) 
    into #comisiones_efec_mes 
    from #pagos_act_sec,
    cob_cartera..ca_transaccion,
    cob_cartera..ca_det_trn,
    sb_est_cuenta_xml
    where banco          = ecx_banco 
    and   tr_banco       = ecx_banco 
    and   tr_secuencial  = sec_pag
    and   tr_operacion   = dtr_operacion
    and   tr_secuencial  = dtr_secuencial
    and   tr_estado<>'RV'
    and   tr_tran in('PAG')
    and   dtr_concepto in ('COMMORA', 'COMPRECAN')
    --and   dtr_dividendo between ecx_cuota_ini and ecx_cuota_fin
    group by banco, ecx_cuota_ini,ecx_cuota_fin
     */ 
    update sb_est_cuenta_xml
    set ecx_comisiones_efec_mes=ecx_comision
    
    update sb_est_cuenta_xml set
    ecx_pago_complemento   = isnull(ecx_int_anticipado,0) +isnull(ecx_iva_int_ant,0) + 
                             isnull(ecx_int_pagado,0) + ceiling(ecx_int_pagado * @w_porcentaje_iva * 100)/100-- + 
                             --isnull(ecx_comisiones_efec_mes,0) + isnull(ecx_iva_comision_pagada,0)                             
    where ecx_cfdi_metodo_pago = 'PPD'

     /*Se eliminana las operaciones que el dia anterior a fin de mes habil hay quedado en estado 2 y 4*/
    select  do_banco,do_tipo_operacion 
	 into   #operacion_castigadas
	 from cob_conta_super..sb_dato_operacion
    where do_fecha      = @w_habil_anterior
    and   do_aplicativo = 7
    and   do_estado_cartera in (2,4)
    
    delete from sb_est_cuenta_xml
    from #operacion_castigadas,sb_est_cuenta_xml
    where ecx_banco=do_banco
    
   select @w_fecha_proceso = format(dateadd(ss,-3000,getdate()), 'yyyy-MM-ddTHH:mm:ss')
   
   select @i_param1 = isnull(@i_param1,@w_fin_mes_hab)
   
   truncate table sb_detalle_impuesto
   
   insert into sb_detalle_impuesto(
   di_banco,  di_concepto,
   di_base ,  di_porcentaje,
   di_valor  )           
   select                
   ero_banco, ero_concepto,
   ero_cuota, 0.160000,
   ero_iva
   from sb_est_rubro_ope
   
   insert into cob_credito..cr_resultado_xml (
   linea            , file_name    , id_ente         , status           , rfc_ente     , 
   num_operation    , insert_date  , rx_cuota_desde  , rx_cuota_hasta   , rx_int_rep   , 
   rx_com_rep       , rx_int_ant   , rx_iva          , rx_met_fact      , rx_form_pag  , 
   rx_tipo_operacion, rx_pago_compl, rx_fecha_fin_mes , rx_total_saldo    , rx_folio_ref  ,
   rx_deuda_pagar   , rx_sec_id    , rx_pago_compl_fin, rx_total_saldo_act,rx_pago_compl_efect,
   rx_iva_comision_pagada, rx_iva_int_ant)
   select 
   (select '@Version'           = '4.0',
           '@Serie'             = 'A',
           '@Folio'             = isnull(convert(varchar, ecx_banco) + '-' + RIGHT('00' + convert(varchar,ecx_secuencial), 3),''),
           '@Fecha'             = isnull(ecx_fecha,''),
           '@Sello'             = '',
           '@FormaPago'         = isnull(ecx_forma_pago,''),
           '@NoCertificado'     = '',
           '@Certificado'       = '',
           '@SubTotal'          = isnull(ecx_sub_total,0),
           '@Moneda'            = isnull(ecx_moneda,''),
           '@TipoCambio'        = '1',
           '@Total'             = isnull(ecx_total,0),
           '@TipoDeComprobante' = isnull(ecx_tipo_documento,''),
		   '@Exportacion'       = '01',
           '@MetodoPago'        = isnull(ecx_cfdi_metodo_pago,''),
           '@LugarExpedicion'   = isnull(ecx_lugar_expedicion,''),
           '@Referencias'       = '',		   
     (select '@Rfc'           = @w_rfc_emisor, 
             '@Nombre'        = @w_nombre_entidad,
             '@RegimenFiscal' = @w_regimen_fiscal
      for xml path('cfdiEmisor'), type),
     (select '@Rfc'                     = isnull(ecx_rfc,''),
             '@Nombre'                  = isnull(ecx_nombre,''),
			 '@DomicilioFiscalReceptor' = '',
			 '@RegimenFiscalReceptor'   = '',
             '@UsoCFDI'                 = isnull(ecx_cfdi_uso_cfdi,'')          
      for xml path('cfdiReceptor'), type),      
       (select
   		   (select '@ClaveProdServ'     = isnull(ero_cfdiClaveProdServ,''),
   		           '@NoIdentificacion'  = isnull(RTRIM(LTRIM(ero_banco)),''),
   		           '@Cantidad'          = '1',
   		           '@ClaveUnidad'       = isnull(ero_cfdiClaveUnidad,''),
   		           '@Unidad'            ='Servicio',
                   '@Descripcion'       = isnull(ero_concepto,''),
                   '@ValorUnitario'     = isnull(ero_cuota,0),
                   '@Importe'           = isnull(ero_cuota,0),
                   '@ObjetoImp'         = '02',
                   (select
                      (select    
   		                  (select '@Base'        = isnull(di_base,0),
   		                          '@Impuesto'    =  '002',
                                  '@TipoFactor'  =  'Tasa',
   		                          '@TasaOCuota'  =  '0.160000',
   		                          '@Importe'     = isnull(di_valor,0)                                       
   		                   from sb_detalle_impuesto
   		                   where di_banco = ero_banco
   		                   and di_concepto = ero_concepto
		                   and ero_cuota <> 0
   		                   for xml path('cfdiTraslado'), type)
   		               for xml path('cfdiTraslados'), type)    
   	                for xml path('cfdiImpuestos'), type) 				   
   		   from sb_est_rubro_ope
   		   where ecx_banco = ero_banco
		   and ero_cuota <> 0
   		   for xml path('cfdiConcepto'), type)
   	    for xml path('cfdiConceptos'), type),
        (select '@TotalImpuestosTrasladados' = isnull(ecx_total_impuestos_trasladados,0),
            (select 
               (select '@Base'        = isnull(sum(ero_cuota),0),
                       '@Impuesto'    =  '002',
                       '@TipoFactor'  =  'Tasa',
                       '@TasaOCuota'  =  '0.160000',
                       '@Importe'     =  isnull(sum(ero_iva),0) 
		       from sb_est_rubro_ope
		       where ecx_banco = ero_banco
			   for xml path('cfdiTraslado'), type)
   	        for xml path('cfdiTraslados'), type)
        for xml path('cfdiImpuestos'),type)     
	for xml path ('cfdiComprobante')),
	ecx_file ,
	ecx_ente ,
	'P'      ,
	ecx_rfc  ,
	ecx_banco,
	@w_fecha_proceso,
	ecx_cuota_ini,
	ecx_cuota_fin,
	ecx_int,
	ecx_comision,
	ecx_int_anticipado,
	ecx_iva,
	ecx_cfdi_metodo_pago,
	ecx_forma_pago      ,
	ecx_tipo_operacion  ,
	ecx_pago_complemento,
	@w_fin_mes_hab,
	isnull(ecx_total,0) -isnull(ecx_comisiones_efec_mes,0) - isnull(ecx_iva_comision_pagada,0) ,
	convert(varchar, ecx_banco) + '-' + RIGHT('00' + convert(varchar,ecx_secuencial), 3),
	ecx_deuda_por_pagar,
	ecx_sec_id,
	ecx_pago_complemento,
	isnull(ecx_total,0) - isnull(ecx_pago_complemento,0) -isnull(ecx_comisiones_efec_mes,0) - isnull(ecx_iva_comision_pagada,0) ,
	0,
	ecx_iva_comision_pagada,
	ecx_iva_int_ant
   from sb_est_cuenta_xml

   /*Actualiza a los que tienen metodo ppd para qu generen complemento*/
   update cob_credito..cr_resultado_xml
   set   rx_genera_cmpl='S'
   where rx_met_fact='PPD' 
   
   /*Elimino las operaciones que no reportaron nada en ningun concepto*/
   delete from cob_credito..cr_resultado_xml
   where isnull(rx_int_rep,0)=0
   and   isnull(rx_com_rep,0)=0
   and   isnull(rx_int_ant,0)=0
   and   isnull(rx_iva,0)=0
   and   isnull(rx_pago_compl,0)=0
   
   /* eliminacion de las operaciones canceladas anticipadamente*/
   select 
   ero_banco,  
   valor = sum(ero_cuota)
   into #eliminar_facturas
   from cob_conta_super..sb_est_rubro_ope
   group by ero_banco
   having sum(ero_cuota) <= 0
   order by ero_banco

   delete cob_credito..cr_resultado_xml
   from #eliminar_facturas
   where ero_banco = num_operation
   
   delete from sb_est_cuenta_xml
   where not exists(select 1 from cob_credito..cr_resultado_xml where rx_fecha_fin_mes = @w_fin_mes_hab and num_operation = ecx_banco)
   
   --CREACION DE TABLA TEMPORAL
   select 
   nec_banco     , 	          nec_fecha               ,    nec_correo            ,     nec_estado             ,
   in_cliente_rfc,            in_cliente_buc          ,    in_folio_fiscal        ,     in_certificado         ,in_sello_digital,
   in_sello_sat  ,            in_num_se_certificado   ,    in_fecha_certificacion ,     in_cadena_cer_dig_sat  ,in_nombre_archivo, 
   in_observacion,            in_fecha_procesamiento  ,    in_fecha_xml           ,     in_rfc_emisor          ,in_estd_timb,
   in_monto_fac  ,            in_toperacion           ,    in_met_fact            ,     in_estado_pdf          ,in_estado_correo,
   in_nombre_pdf ,            in_estd_clv_co          ,    in_grupo               ,     in_nombre_cli          ,in_cuota_desde,
   in_cuota_hasta,            in_folio_ref            ,    in_fecha_fin_mes
   into #sb_ns_estado_cuenta
   from cob_conta_super..sb_ns_estado_cuenta where 1= 2 
   
   create index sb1 on #sb_ns_estado_cuenta (nec_banco)
   
   alter table #sb_ns_estado_cuenta add in_ente int 
   alter table #sb_ns_estado_cuenta add in_operacion int 
   --CREA TABLA TEMPORAL CON REGISTROS
   insert into #sb_ns_estado_cuenta (
   nec_banco     ,            nec_fecha                   ,    nec_correo             ,     nec_estado             ,
   in_cliente_rfc,            in_cliente_buc              ,    in_folio_fiscal        ,     in_certificado         ,in_sello_digital,
   in_sello_sat  ,            in_num_se_certificado       ,    in_fecha_certificacion ,     in_cadena_cer_dig_sat  ,in_nombre_archivo, 
   in_observacion,            in_fecha_procesamiento      ,    in_fecha_xml           ,     in_rfc_emisor          , in_estd_timb,
   in_monto_fac  ,            in_toperacion               ,    in_met_fact            ,     in_estado_pdf          ,in_estado_correo   ,
   in_nombre_pdf,             in_estd_clv_co              ,    in_grupo                    ,     in_nombre_cli          ,in_ente            ,
   in_cuota_desde,            in_cuota_hasta              ,    in_folio_ref                ,     
   in_fecha_fin_mes)     
   select 
   ecx_banco                   ,format(dateadd(ss,-86399,ecx_fecha), 'yyyy-MM-ddTHH:mm:ss') , isnull(ecx_email,'')       , convert(varchar (30),'') ,  
   ecx_rfc                     ,ecx_buc                   ,   convert(varchar(60), null), convert(varchar (30),null) , convert(varchar(1500),null),
   convert(varchar(1500),null) ,convert(varchar(30),null) ,   convert(datetime, null)   , convert(varchar(1500),null), convert(varchar(100),null),
   convert(varchar(300) ,null) ,convert(varchar(300),null) ,  convert(datetime, null)   , convert(varchar(30), null) , convert(char(1), 'N'),
   convert(varchar(30)  ,null) ,convert(varchar(30),null) ,   convert(varchar(5),null)  , convert(char(1), '')      , convert(char(1), '')       ,
   convert(varchar(100),null)  ,convert(varchar(1),null)  ,   convert(int,0)                , convert(varchar(255),null) , ecx_ente                    ,
   ecx_cuota_ini               ,ecx_cuota_fin             ,   convert(varchar, ecx_banco) + '-' + RIGHT('00' + convert(varchar,ecx_secuencial), 3)     ,
   format(dateadd(ss,-86399,ecx_fecha), 'yyyy-MM-ddTHH:mm:ss')
   from sb_est_cuenta_xml

   if @@error != 0 begin
	   select 
	   @w_error = 710902,
	   @w_msg   = 'ERROR EN TABLA TEMPORAL SB_NS_ESTADO_CUENTA'
	   goto ERROR_PROCESO
	end


   --ACTUALIZACION DEL TIPO DE OPERACION 
   
   update #sb_ns_estado_cuenta set 
   in_toperacion = op_toperacion, 
   in_operacion  = op_operacion
   from cob_cartera..ca_operacion 
   where nec_banco = op_banco
   
   update #sb_ns_estado_cuenta set 
   nec_estado = 'X'
   from cob_cartera..ca_operacion
   where   op_toperacion = 'REVOLVENTE'
   and     nec_banco = op_banco
   

   select 
   operacionca     = dc_operacion ,
   max_ciclo       = max(dc_ciclo_grupo)
   into #maximos_ciclos
   from cob_cartera..ca_det_ciclo,#sb_ns_estado_cuenta
   where in_operacion =dc_operacion
   group by dc_operacion

   select 
   grupo       = dc_grupo,
   dc_operacion = dc_operacion
   into #operaciones_grupo
   from cob_cartera..ca_det_ciclo,#maximos_ciclos
   where operacionca = dc_operacion
   and  dc_ciclo_grupo  = max_ciclo
   
   update #sb_ns_estado_cuenta set 
   in_grupo = grupo 
   from #operaciones_grupo
   where dc_operacion = in_operacion
      
   update  #sb_ns_estado_cuenta set
   in_nombre_cli= en_nomlar
   from cobis..cl_ente 
   where en_ente = in_ente
   

   --INSERCION A DEFINITIVAS 
   
   insert into cob_conta_super..sb_ns_estado_cuenta (
   nec_banco     , 	nec_fecha               , 	nec_correo            ,    	  nec_estado             ,
   in_cliente_rfc,  in_cliente_buc          ,   in_folio_fiscal       ,       in_certificado         , in_sello_digital,
   in_sello_sat  ,  in_num_se_certificado   ,   in_fecha_certificacion,       in_cadena_cer_dig_sat  , in_nombre_archivo, 
   in_observacion,  in_fecha_procesamiento  ,   in_fecha_xml          ,       in_rfc_emisor           , in_estd_timb,
   in_monto_fac  ,  in_toperacion           ,   in_met_fact            ,      in_estado_pdf           ,in_estado_correo,
   in_nombre_pdf ,  in_estd_clv_co          ,   in_grupo              ,       in_nombre_cli          ,in_cuota_desde    ,
   in_cuota_hasta,  in_folio_ref            ,   in_fecha_fin_mes)
   select  
   nec_banco     ,  nec_fecha               , 	 nec_correo            ,     nec_estado              ,
   in_cliente_rfc,  in_cliente_buc          ,    in_folio_fiscal       ,     in_certificado          ,in_sello_digital,
   in_sello_sat  ,  in_num_se_certificado   ,    in_fecha_certificacion,     in_cadena_cer_dig_sat   ,in_nombre_archivo, 
   in_observacion,  in_fecha_procesamiento  ,    in_fecha_xml          ,     in_rfc_emisor           , in_estd_timb,
   in_monto_fac  ,  in_toperacion           ,    in_met_fact           ,     in_estado_pdf       ,in_estado_correo,
   in_nombre_pdf,   in_estd_clv_co          ,    in_grupo              ,     in_nombre_cli           ,in_cuota_desde,
   in_cuota_hasta,  in_folio_ref            ,    in_fecha_fin_mes        
   from #sb_ns_estado_cuenta
      
  
   if @@error != 0 begin
      select 
      @w_error = 710802,
      @w_msg   = 'ERROR EN TABLA FISICA SB_NS_ESTADO_CUENTA'
      goto ERROR_PROCESO
   end
   
   
   exec sp_xml_estado_cuenta_compl
    @i_param1           = @i_param1, -- FECHA DE PROCESO
    @i_fin_mes_hab      = @w_fin_mes_hab,
	@i_ini_mes          = @w_ini_mes,
	@i_fin_mes          = @w_fin_mes,
	@i_fin_mes_ant      = @w_fin_mes_ant,
	@i_fin_mes_ant_hab  = @w_fin_mes_ant_hab

end


update cob_conta..cb_solicitud_reportes_reg
set   sr_status = 'P'
where sr_reporte = @w_reporte
and   sr_status = 'I'

if @@error != 0
begin
    select @w_error = 710002
    goto ERROR_PROCESO
end

SALIDA_PROCESO:
return 0

ERROR_PROCESO:
     select @w_msg = isnull(@w_msg, 'ERROR GENRAL DEL PROCESO')
     exec cob_conta_super..sp_errorlog
     @i_fecha_fin     = @i_param1,
     @i_fuente        = @w_sp_name,
     @i_origen_error  = @w_error,
     @i_descrp_error  = @w_msg

go

