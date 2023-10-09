/************************************************************************/
/*   Archivo:                 sp_xml_comp_pag_rep.sp                    */
/*   Stored procedure:        sp_xml_comp_pag_rep                       */
/*   Base de Datos:           cob_conta_super                           */
/*   Producto:                Cartera                                   */
/*   Disenado por:                                                      */
/*   Fecha de Documentacion:  03/03/2021                                */
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
/*   Fecha         Nombre       Proposito                               */
/*   03/03/2021    AIN          Modificación creación xml               */
/*   06/07/2021    DCU          Modificacion manejo de fechas           */																	  
/************************************************************************/

use cob_conta_super
go

if not object_id('sp_xml_comp_pag_rep') is null
   drop proc sp_xml_comp_pag_rep
go

create proc sp_xml_comp_pag_rep
   @i_param1   datetime    -- 9 habil de cada mes

as
declare 
@w_dia_ejecucion_his           int 			,
@w_fecha_ini                   smalldatetime,
@w_noveno_habil                datetime		,
@w_fecha_proceso               datetime		,
@w_ejecutar_comp               char(1)		,
@w_error                       varchar(1500),
@w_msg                         varchar(255)	,
@w_sp_name                     varchar(24)	,
@w_ciudad                      int			,
@w_simulacion_comp             char(1)		,
@w_nombre_entidad              varchar(100)	,
@w_regimen_fiscal              varchar(100)	,
@w_uso_cdfi                    varchar(100)	,
@w_cantidad                    varchar(100)	,
@w_clave_unidad                varchar(100)	,
@w_descripcion                 varchar(100)	,
@w_moneda_p                    varchar(100)	,
@w_moneda_dr                   varchar(100)	,
@w_metodo_pago_dr              varchar(100)	,
@w_clave_sat                   varchar(100)	,
@w_forma_pago                  varchar(10)	,
@w_consecutivo                 int			,
@w_fecha_fin_mes_anterior      datetime		,
@w_fecha_fin_mes_anterior_his  datetime		,
@w_rfc_emisor                  varchar(30)	,
@w_reproceso                   char(1)      ,
@w_inicio_mes_anterior         datetime     ,
@w_reporte                     varchar(10)  ,
@w_return                      int          ,
@w_existe_solicitud            char (1)     ,
@w_ini_mes                     datetime     ,
@w_fin_mes                     datetime     ,
@w_fin_mes_hab                 datetime     ,
@w_fin_mes_ant                 datetime     ,
@w_fin_mes_ant_hab             datetime     ,
@w_fin_mes_ant_hab_aux         datetime     ,
@w_mes_ant_aux                 varchar(2)   ,
@w_anio_ant_aux                varchar(4)   ,
@w_fecha_aux_ant               datetime     ,
@w_mes_proceso                 varchar(30) 


select 
@w_sp_name         = 'sp_xml_comp_pag_rep',
----------------------------------------
@w_rfc_emisor      = 'SIF170801PYA',
@w_nombre_entidad  = 'SANTANDER INCLUSION FINANCIERA SA DE CV SOFOM  ENTIDAD REGULADA, GRUPO FINANCIERO SANTANDER MÉXICO',
@w_regimen_fiscal  = '601'	,
@w_uso_cdfi        = 'P01'	,
@w_cantidad		   = '1'	,
@w_clave_unidad    = 'ACT'	,
@w_descripcion     = 'Pago' ,
@w_moneda_p		   = 'MXN'	,
@w_moneda_dr       = 'MXN'	,
@w_metodo_pago_dr  = 'PUE'	,
@w_forma_pago      = '03'	,
-----------------------------------------      
@w_ejecutar_comp   = 'N'	,
@w_simulacion_comp = 'N'	,--por defecto N
-----------------------------------------
@w_reproceso       = 'N'

print '@w_sp_name -> ' + @w_sp_name 

select @w_dia_ejecucion_his = pa_int
from cobis..cl_parametro
where pa_producto = 'CCA'
and   pa_nemonico = 'EJEHIS'

select @w_dia_ejecucion_his  = isnull(@w_dia_ejecucion_his,9)

/* CIUDAD DE FERIADOS */
select @w_ciudad  = pa_int
from cobis..cl_parametro
where pa_nemonico = 'CIUN'
and   pa_producto = 'ADM'

select @w_simulacion_comp = pa_char from cobis..cl_parametro
where pa_nemonico = 'SMCLP'
and pa_producto   = 'REC'

--Obtiene el parametro del código del producto SAT para complemento
select  @w_clave_sat = pa_char 
from    cobis..cl_parametro 
where   pa_nemonico  = 'CPSATC' 
and     pa_producto  = 'REC'

/*CREACION DE TABLA TEMPORAL*/
create table #pendientes(
   sec_id          int identity		,
   banco           varchar(24)  	,
   pago_mes        money			,
   fin_mes         datetime			,
   cuota_ini       int				,
   cuota_hasta     int				,
   insoluto_pago   money			,
   folio_ref       varchar(50)	    ,
   deuda_pagar     money			,
   sec_compl_id    int

)

create table #operaciones_compl_ant( 
   dc_banco        varchar(24),
   dc_num_cuota    int ,
   dc_fecha_vto    datetime,
   dc_estado       char(1),
   dc_int_pag      money,
   dc_otros_pag    money,
   dc_int_acum     money ,
   dc_imo_pag      money,
   dc_imo_cuota    money,
   dc_iva_int_pag  money,
   dc_iva_imo_pag  money
)    

/*DETERMINAR LA FECHA DE PROCESO */
select 
@w_fecha_proceso  = fc_fecha_cierre,
@w_fecha_ini      = dateadd(dd,1-datepart(dd,fc_fecha_cierre), fc_fecha_cierre)
from cobis..ba_fecha_cierre
where fc_producto = 7

if(@i_param1 is not null)
begin
    print '@w_fecha_proceso' + convert(varchar(15),@i_param1,103)
    
   select 
   @w_fecha_proceso = @i_param1,
   @w_fecha_ini     = dateadd(dd,1-datepart(dd,@i_param1), @i_param1)

   /*CUANDO SE VA A REPROCESAR ACTUALIZO LA BANDERA A S*/
   if exists (select 1 from  cob_credito_his..cr_complemento_pago_xml_his
	          where in_fecha_fin_mes_his=@i_param1)
   begin
      select @w_reproceso  = 'S'
   end 
end


/*DIA DE EJECUCION NOVENO HABIL*/
select @w_noveno_habil = dateadd(dd,@w_dia_ejecucion_his,@w_fecha_ini )



while exists (select 1
              from cobis..cl_dias_feriados
              where df_fecha  = @w_noveno_habil
              and   df_ciudad = @w_ciudad)
begin
   select @w_noveno_habil= dateadd(dd, -1, @w_noveno_habil)
end

print '@i_param1 -> '+ convert(varchar(50),@i_param1)
print '@w_noveno_habil -> '+ convert(varchar(50),@w_noveno_habil)
print '@w_reproceso -> '+ @w_reproceso
print '@w_simulacion_comp -> '+ @w_simulacion_comp


/* SI @i_param1 NO ES IGUAL AL NOVENO HABIL NO SE EJECUTA EN UN REPROCESO*/
if @i_param1 <> @w_noveno_habil
begin
   select 
   @w_error = 710002,
   @w_msg   = 'ERROR: FECHA VALOR NO ES IGUAL AL NOVENO HABIL DEL MES'
   --goto ERROR_PROCESO
   select 
   @w_error,
   @w_msg
	
	return 0
end

if @w_fecha_proceso = @w_noveno_habil  select @w_ejecutar_comp  = 'S'

select @i_param1    = isnull (@i_param1,@w_fecha_proceso)

-- SE OBTIENE LA FECHA DE FIN DE MES ANTERIOR
SELECT @w_reporte = 'COMCTA'

EXEC cob_conta..sp_calcula_ultima_fecha_habil
    @i_reporte          = @w_reporte,  -- buro mensual
    @o_existe_solicitud = @w_existe_solicitud  out,
    @o_ini_mes          = @w_ini_mes out,
    @o_fin_mes          = @w_fin_mes out,
    @o_fin_mes_hab      = @w_fin_mes_hab out,
    @o_fin_mes_ant      = @w_fin_mes_ant out,
    @o_fin_mes_ant_hab  = @w_fin_mes_ant_hab OUT


print ' @o_existe_solicitud = ' + convert(varchar,@w_existe_solicitud)
print ' @o_ini_mes          = ' + isnull(convert(varchar,@w_ini_mes         ),'x')
print ' @o_fin_mes          = ' + isnull(convert(varchar,@w_fin_mes         ),'x')
print ' @o_fin_mes_hab      = ' + isnull(convert(varchar,@w_fin_mes_hab     ),'x')
print ' @o_fin_mes_ant      = ' + isnull(convert(varchar,@w_fin_mes_ant     ),'x')
print ' @o_fin_mes_ant_hab  = ' + isnull(convert(varchar,@w_fin_mes_ant_hab ),'x')

if @w_fin_mes_ant_hab is null
begin 
   print 'No se encuentra la fecha del mes anterior'
   return 0
end

select @w_mes_ant_aux = convert(varchar(2),month(@w_fin_mes_ant))
select @w_anio_ant_aux = convert(varchar(4),year(@w_fin_mes_ant))
select @w_fecha_aux_ant = convert(datetime,(@w_mes_ant_aux + '/01/' + @w_anio_ant_aux))

EXEC cob_conta..sp_calcula_ultima_fecha_habil
    @i_reporte          = 'NINGUN',
    @i_fecha            = @w_fecha_aux_ant,
    @o_fin_mes_ant_hab  = @w_fin_mes_ant_hab_aux OUT
    
print ' @o_fin_mes_ant_hab_aux  = ' + isnull(convert(varchar,@w_fin_mes_ant_hab_aux ),'x')

if @w_fin_mes_ant_hab_aux is null
begin 
   print 'No se encuentra la fecha del mes anterior auxiliar'
   return 0
end

-- SE VERIFICA QUE NO EXISTA REGISTROS PARA LA FECHA DE EJECUCION
if exists( select 1 
           from cob_credito..cr_complemento_pago_xml 
	       where in_fecha_fin_mes = @i_param1)
begin
 print 'Ya existen registros para esta fecha en la tabla cr_complemento_pago_xml'
 return 0
end

/* SI LA FECHA PROCESO ES IGUAL AL NOVENO HABIL EJECUTA*/
print '@w_ejecutar_comp -> ' + @w_ejecutar_comp

if(@w_ejecutar_comp ='S')
begin
	/*PASAMOS LOS DATOS A HISTORICOS*/
    /*
	insert into cob_credito_his..cr_complemento_pago_xml_his(
	linea_his          , 	file_name_his          ,  id_ente_his    	, status_his         , 
	rfc_ente_his       , 	num_operation_his      ,  insert_date_his	, processing_date_his, 
	tipo_operacion_his ,    in_fecha_fin_mes_his   ,  rxh_saldo_inso 	, rxh_cuota_ini      ,
	rxh_cuota_hasta    ,    rxh_deuda_pagar        ,  rxh_folio_ref  	, rxh_saldo_inso_fin ,
	rxh_sec_id         ,    rxh_tipo_compl         ,  rxh_id_documento	, rxh_fe_mes_afecta)
	select 
	linea				,	file_name			, 	id_ente				, 	status				, 
	rfc_ente			,	num_operation		,	insert_date			, 	processing_date		, 
	tipo_operacion		, 	in_fecha_fin_mes	,	rx_saldo_inso		,   rx_cuota_ini		,
	rx_cuota_hasta		,   rx_deuda_pagar		,   rx_folio_ref		,	rx_saldo_inso_fin	,
	rx_sec_id			,	rx_tipo_compl		,	rx_id_documento     ,	rx_fe_mes_afecta
	from cob_credito..cr_complemento_pago_xml
	*/
	
	/*Elimino datos de tablas actuales*/
	truncate table cob_conta_super..sb_est_complemento_xml
	--truncate table cob_credito..cr_complemento_pago_xml
	
	-- Si existe reproceso
	if( @w_reproceso  = 'S')
	begin
	
	   print'Reproceso'
	   /*	update cob_credito_his..cr_complemento_pago_xml_his
		set rxh_saldo_inso = rxh_saldo_inso_fin
		where in_fecha_fin_mes_his<@i_param1
		*/
	   update cob_credito..cr_resultado_xml set
       rx_pago_mes        = null,
       rx_pago_mes_ant    = null,
       rx_pag_compl_ant   = null,
       rx_fecha_ult_compl = null,
       rx_pago_compl      = rx_pago_compl_fin
	  
		
       select 
       num_operation_his    = num_operation_his,
       rxh_cuota_ini        = rxh_cuota_ini,
       rxh_cuota_hasta      = rxh_cuota_hasta,
       rxh_folio_ref        = max(rxh_folio_ref),
       in_fecha_fin_mes_his = in_fecha_fin_mes_his,
       max_id               = max(rxh_sec_id),
       rxh_fe_mes_afecta    = rxh_fe_mes_afecta
       into #operaciones_reproceso_1
       from cob_credito_his..cr_complemento_pago_xml_his
       where in_fecha_fin_mes_his=@i_param1
	   group by num_operation_his,rxh_cuota_ini,rxh_cuota_hasta,in_fecha_fin_mes_his,rxh_fe_mes_afecta
       
	   update cob_credito_his..cr_resultado_xml_his
       set rxh_genera_cmpl='S'
       from #operaciones_reproceso_1 a ,cob_credito_his..cr_resultado_xml_his b
       where  a.num_operation_his = b.num_operation
       and    a.rxh_cuota_ini     = b.rxh_cuota_desde
       and    a.rxh_cuota_hasta   = b.rxh_cuota_hasta
       and    a.rxh_folio_ref     = b.rxh_folio_ref
       and    a.rxh_fe_mes_afecta = b.rxh_fecha_fin_mes
       and    a.in_fecha_fin_mes_his=@i_param1
       and    b.rxh_sec_id>0
	  
      
	end
	
    select * into #cr_resultado_xml from cob_credito..cr_resultado_xml/*,cob_conta_super..sb_ns_estado_cuenta*/ where 1 = 2 
   
    --CREACION DE CAMPO FOLIO  Y ESTADO TIMBRADO 
    alter table #cr_resultado_xml  add folio_fiscal varchar(60) 

    create index idx1 on #cr_resultado_xml(num_operation)
   
    /*Operaciones a reportar Padres*/
    if exists(select 1 from sb_operacion_tmp)
    begin
       print 'Parte A - if'
       insert into #cr_resultado_xml ( 
       linea              , file_name          , id_ente           ,
       status             , rfc_ente           , num_operation     ,
       insert_date        , processing_date    , rx_cuota_desde    ,
       rx_cuota_hasta     , rx_int_rep         , rx_com_rep        ,
       rx_int_ant         , rx_iva             , rx_met_fact       ,
       rx_form_pag        , rx_fecha_ult_compl , rx_fecha_env_email,
       rx_tipo_operacion  , rx_pago_compl      , rx_folio_ref      ,
       rx_total_saldo_ant , rx_fecha_fin_mes   , rx_pago_mes       ,
       rx_pago_mes_ant    , rx_deuda_pagar     , 
       rx_pag_compl_ant   , rx_total_saldo )
       select
       linea              = linea				     ,
       file_name          = file_name			     ,
       id_ente            = id_ente		             ,           
       status             = status                   ,
       rfc_ente           = rfc_ente                 ,
       num_operation      = num_operation            ,
       insert_date        = insert_date              ,
       processing_date    = processing_date          ,
       rx_cuota_desde     = rx_cuota_desde           ,
       rx_cuota_hasta     = rx_cuota_hasta           ,
       rx_int_rep         = rx_int_rep               ,
       rx_com_rep         = rx_com_rep               ,
       rx_int_ant         = rx_int_ant               ,
       rx_iva             = rx_iva                   ,
       rx_met_fact        = rx_met_fact              ,
       rx_form_pag        = rx_form_pag              ,
       rx_fecha_ult_compl = rx_fecha_ult_compl       ,
       rx_fecha_env_email = rx_fecha_env_email       ,
       rx_tipo_operacion  = rx_tipo_operacion        ,
       rx_pago_compl      = rx_pago_compl            ,
   	   rx_folio_ref	      = rx_folio_ref             ,
       rx_total_saldo_ant = rx_total_saldo_ant       ,
       rx_fecha_fin_mes   = rx_fecha_fin_mes         ,
       rx_pago_mes        = rx_pago_mes              ,
       rx_pago_mes_ant    = isnull(rx_pago_mes_ant,0),
       rx_deuda_pagar     = rx_deuda_pagar           ,
       rx_pag_compl_ant   = rx_pag_compl_ant         ,
       rx_total_saldo     = rx_total_saldo      
       from cob_credito..cr_resultado_xml
       where  rx_met_fact     = 'PPD'
       and ((isnull(rx_int_rep,0)+isnull(rx_com_rep,0)+isnull(rx_int_ant,0))- rx_pago_mes_ant)>0
       and num_operation in (select ot_banco from cob_conta_super..sb_operacion_tmp)
       and rx_sec_id>0
       and rx_fecha_fin_mes = @w_fin_mes_ant_hab
   	
   end else 
   begin
      	print 'Parte B - else'
       insert into #cr_resultado_xml ( 
       linea             ,file_name          ,id_ente           ,
       status            ,rfc_ente           ,num_operation     ,
       insert_date       ,processing_date    ,rx_cuota_desde    ,
       rx_cuota_hasta    ,rx_int_rep         ,rx_com_rep        ,
       rx_int_ant        ,rx_iva             ,rx_met_fact       ,
       rx_form_pag       ,rx_fecha_ult_compl ,rx_fecha_env_email,
       rx_tipo_operacion ,rx_pago_compl      ,rx_folio_ref      ,
       rx_total_saldo_ant,rx_fecha_fin_mes   ,rx_pago_mes       ,
       rx_pago_mes_ant   ,rx_deuda_pagar     ,
       rx_pag_compl_ant  ,rx_total_saldo )
       select
       linea               = linea,
       file_name           = file_name,
       id_ente             = id_ente,           
       status              = status                   ,
       rfc_ente            = rfc_ente                 ,
       num_operation       = num_operation            ,
       insert_date         = insert_date              ,
       processing_date     = processing_date          ,
       rx_cuota_desde      = rx_cuota_desde           ,
       rx_cuota_hasta      = rx_cuota_hasta           ,
       rx_int_rep          = rx_int_rep               ,
       rx_com_rep          = rx_com_rep               ,
       rx_int_ant          = rx_int_ant               ,
       rx_iva              = rx_iva                   ,
       rx_met_fact         = rx_met_fact              ,
       rx_form_pag         = rx_form_pag              ,
       rx_fecha_ult_compl  = rx_fecha_ult_compl       ,
       rx_fecha_env_email  = rx_fecha_env_email       ,
       rx_tipo_operacion   = rx_tipo_operacion        ,
       rx_pago_compl       = rx_pago_compl            ,
       rx_folio_ref	       = rx_folio_ref             ,
       rx_total_saldo_ant  = rx_total_saldo_ant       ,
       rx_fecha_fin_mes    = rx_fecha_fin_mes         ,
       rx_pago_mes         = rx_pago_mes              ,
       rx_pago_mes_ant     = isnull(rx_pago_mes_ant,0),
       rx_deuda_pagar      = rx_deuda_pagar           ,
       rx_pag_compl_ant    = rx_pag_compl_ant         ,
       rx_total_saldo      = rx_total_saldo      
       from cob_credito..cr_resultado_xml
       where  rx_met_fact    ='PPD'
       and rx_total_saldo_act > 0
       and rx_pago_compl_fin  > 0
       and rx_sec_id>0
       and rx_fecha_fin_mes = @w_fin_mes_ant_hab 
   	 
   end
   
   select count(1) as 'CantidadFacturas'  from #cr_resultado_xml 
      	
   /*Si el Parametro es N Elimino de la tabla temporal los que no han sido timbrados*/	
   if(@w_simulacion_comp ='N')  
   begin
      print 'Se elimina todos los que no fueron timbrados'  
      
	  select count(1) as 'antes del delete w_simulacion_comp' from #cr_resultado_xml 
	  
      delete #cr_resultado_xml 
      from cob_conta_super..sb_ns_estado_cuenta
      where nec_banco = num_operation
      and   in_estd_timb  <>'S'
	  and   in_fecha_fin_mes = @w_fin_mes_ant_hab
	  
	  select count(1) as 'despues del delete w_simulacion_comp' from #cr_resultado_xml 
   end

  
   /*ENCONTRAMOS EL FOLIO FISCAL*/
   update #cr_resultado_xml set 
   folio_fiscal        = in_folio_fiscal 
   from cob_conta_super..sb_ns_estado_cuenta
   where num_operation = nec_banco 
   
   /*CALCULO DEL PAGO MES*/
  
   /*ENCONTRAMOS EL PAGO MES DE LA ULTIMA FECHA ACTUAL*/
   select @w_fecha_fin_mes_anterior = max(rx_fecha_fin_mes) 
   from cob_credito..cr_resultado_xml
   where rx_fecha_fin_mes < @w_noveno_habil
   
   select @w_inicio_mes_anterior = dateadd(dd,1-datepart(dd,@w_fecha_fin_mes_anterior), @w_fecha_fin_mes_anterior)
   
   print '@w_fecha_fin_mes_anterior -> ' + isnull(convert(varchar(15),@w_fecha_fin_mes_anterior,103),'')
   print '@w_inicio_mes_anterior -> ' + isnull(convert(varchar(15),@w_inicio_mes_anterior,103),'')      
   
   update cob_credito..cr_resultado_xml set 
   rx_pago_mes = rx_pago_compl  --isnull(rx_int_rep,0) +isnull(rx_com_rep,0)+isnull(rx_int_ant,0)
   where  rx_fecha_fin_mes = @w_fecha_fin_mes_anterior
   
   /*ENCONTRAMOS EL PAGO MES DE DEL MES ANTERIOR*/
   
   select @w_fecha_fin_mes_anterior_his = max(rx_fecha_fin_mes) 
   from cob_credito..cr_resultado_xml
   where rx_fecha_fin_mes < @w_fecha_fin_mes_anterior

   print '@w_fecha_fin_mes_anterior_his -> ' + isnull(convert(varchar(15),@w_fecha_fin_mes_anterior_his,103),'')
   
   
   /*Se crea tabla temporal para ver cual es el maximo registro en la historica*/
   select 
   num_operation_max        = num_operation,
   rxh_fecha_fin_meshis_max = rx_fecha_fin_mes,
   rxh_fecha_fin_mes_max    = @w_fecha_fin_mes_anterior,
   rxh_pago_compl_hist      = rx_pago_compl,
   max_sec_id               = isnull(max(rx_sec_id),1)
   into #maximo_secuenciales
   from cob_credito..cr_resultado_xml
   where rx_fecha_fin_mes = @w_fecha_fin_mes_anterior_his
   group by num_operation,rx_fecha_fin_mes,rx_pago_compl
   
   
   
   select count(1) as 'maximo_secuenciales' from #maximo_secuenciales   
 
   
   update cob_credito..cr_resultado_xml set 
   rx_pago_mes_ant =rxh_pago_compl_hist--pago complemento mes anterior 
   from   #maximo_secuenciales mx ,cob_credito..cr_resultado_xml a 
   where  num_operation_max = num_operation
   and    rx_fecha_fin_mes  = rxh_fecha_fin_mes_max
	
   update cob_credito..cr_resultado_xml set 
   rx_pago_mes =(case when  isnull(isnull(rx_pago_mes,0)-isnull(rx_pago_mes_ant,0),0)<0 then 0
                     else isnull(isnull(rx_pago_mes,0)-isnull(rx_pago_mes_ant,0),0)    end ) 
   from   cob_credito..cr_resultado_xml
   where  rx_fecha_fin_mes = @w_fecha_fin_mes_anterior
   
   select count (1) as 'antes del delete' from #cr_resultado_xml
	
   /*delete #cr_resultado_xml 
   from  cob_credito..cr_resultado_xml a, #cr_resultado_xml b
   where a.num_operation = b.num_operation
   and   a.rx_pago_mes=0
   and   a.rx_fecha_fin_mes = @w_fecha_fin_mes_anterior
   */
--   select count (1) as 'despues del delete' from #cr_resultado_xml
   
   update cob_credito..cr_resultado_xml set 
   rx_pago_compl=a.rx_pago_compl 
   from  #cr_resultado_xml a ,cob_credito..cr_resultado_xml b
   where a.num_operation     = b.num_operation
   and   a.rx_fecha_fin_mes  = b.rx_fecha_fin_mes
   
   -- Complemento Padre
   insert into cob_conta_super..sb_est_complemento_xml (
   se_Rfc_emisor   	    ,se_Nombre  		,se_RegimenFiscal   ,se_Rfc_receptor   ,	
   se_UsoCFDI 		    ,se_ClaveProdServ 	,se_Cantidad     	,se_ClaveUnidad    ,
   se_Descripcion  	    ,se_ValorUnitario 	,se_Importe 		,se_Version		   ,
   se_FechaPago		    ,se_FormaDePagoP    ,se_MonedaP 		,se_Monto          ,
   se_RfcEmisorCtaOrd   ,se_IdDocumento 	,se_Folio			,se_MonedaDR       ,
   se_MetodoDePagoDR    ,se_NumParcialidad 	,se_ImpSaldoAnt 	,se_ImpPagado      ,
   se_ImpSaldoInsoluto  ,se_banco           ,se_fecha			,se_file_name      ,
   se_id_ente           ,se_estatus         ,se_rfc_ente        ,se_insert_date    ,  
   se_rx_tipo_operacion ,se_cuota_ini       ,se_cuota_hasta     ,se_folio_ref      ,
   se_deuda_pagar       ,se_sec_id          ,se_tipo_compl      ,se_fecha_afectacion )  
   select 
   se_Rfc_emisor       = @w_rfc_emisor			,
   se_Nombre           = @w_nombre_entidad	    ,
   se_RegimenFiscal    = @w_regimen_fiscal 	    ,
   se_Rfc_receptor     = rfc_ente	     		,
   se_UsoCFDI 		   = @w_uso_cdfi   		    ,
   se_ClaveProdServ    = @w_clave_sat			,
   se_Cantidad         = @w_cantidad			,
   se_ClaveUnidad      = @w_clave_unidad 		,
   se_Descripcion      = @w_descripcion		    ,
   se_ValorUnitario    = rx_pago_compl			,
   se_Importe 		    = rx_pago_compl 		,
   se_Version		    = '1.0'					,
   se_FechaPago	        = @i_param1				,
   se_FormaDePagoP      = @w_forma_pago			,
   se_MonedaP 		    = @w_moneda_p 			,
   se_Monto             = rx_pago_compl   		,
   se_RfcEmisorCtaOrd   = @w_rfc_emisor			,
   se_IdDocumento 	    = folio_fiscal			,
   se_Folio			    = rx_folio_ref			,
   se_MonedaDR          = @w_moneda_dr			,
   se_MetodoDePagoDR    = @w_metodo_pago_dr	,
   se_NumParcialidad    = ''						,
   se_ImpSaldoAnt       = isnull(convert(varchar(50),isnull(rx_total_saldo,0)),'0') ,
   se_ImpPagado         = rx_pago_compl,
   se_ImpSaldoInsoluto  = 0,
   se_banco             = num_operation,
   se_fecha             = @w_fecha_proceso,
   se_file_name         = '',
   se_id_ente           = id_ente,
   se_estatus           = 'P',
   se_rfc_ente          = rfc_ente,
   se_insert_date       = @i_param1,--fecha en la que se procesa el complemento
   se_rx_tipo_operacion = rx_tipo_operacion,
   se_cuota_ini         = rx_cuota_desde,
   se_cuota_hasta       = rx_cuota_hasta,
   se_folio_ref         = rx_folio_ref,
   se_deuda_pagar       = rx_deuda_pagar,
   se_sec_id            = 1,
   se_tipo_compl        = 'P',
   se_fecha_afectacion  = rx_fecha_fin_mes
   from #cr_resultado_xml

   update cob_conta_super..sb_est_complemento_xml
   set se_ImpSaldoInsoluto = isnull(convert(varchar(50),case when convert(money,se_ImpSaldoAnt)-convert(money,se_ImpPagado)<0 then 0
                                                             else convert(money,se_ImpSaldoAnt)-convert(money,se_ImpPagado)   end) ,'0')


	/*COMPLEMENTOS HIJOS*/
/*	insert into #pendientes(
   banco		, pago_mes		,fin_mes       ,
   cuota_ini	, cuota_hasta	,insoluto_pago ,
   folio_ref    , deuda_pagar   ,sec_compl_id)
   select 
   num_operation_his    ,
   rxh_saldo_inso   	,
   in_fecha_fin_mes_his ,
   rxh_cuota_ini		,
   rxh_cuota_hasta		,
   rxh_saldo_inso		,
   rxh_folio_ref		,
   rxh_deuda_pagar		,
   isnull(max(rxh_sec_id),1)
   from  
   cob_credito_his..cr_complemento_pago_xml_his
   where rxh_saldo_inso>0
   and   insert_date_his<@w_fecha_fin_mes_anterior
   and   rxh_tipo_compl='P'
   group by    num_operation_his,rxh_saldo_inso,in_fecha_fin_mes_his,
               rxh_cuota_ini,rxh_cuota_hasta,rxh_saldo_inso,rxh_folio_ref,
               rxh_deuda_pagar  
 */
 
 -- cambio
select *
into #pagos_ante
from sb_dato_operacion_abono
where doa_fecha = @w_fin_mes_ant_hab_aux
order by doa_sec_pag 
    
select 
banco     = doa_banco,
operacion = doa_operacion,
sec_pag   = doa_sec_pag,
sec_rpa   = doa_sec_rpa,
fecha_pag = doa_fecha_pag,
dividendo = doa_dividendo
into #pagos_act
from sb_dato_operacion_abono
where doa_fecha = @w_fin_mes_ant_hab 

delete #pagos_act 
where exists(select 1
from #pagos_ante ant
where ant.doa_operacion = operacion
and   ant.doa_fecha_pag = fecha_pag) 

 
 select distinct tr_operacion  = tr_operacion ,
                 tr_banco      = tr_banco, 
                 dtr_dividendo = dtr_dividendo,
                 fecha_ven     = convert(datetime,null)
    into #operaciones_reportar
    from cob_cartera..ca_transaccion, cob_cartera..ca_det_trn,#pagos_act
    where tr_operacion = dtr_operacion
    and   tr_secuencial= dtr_secuencial
    and   tr_operacion = operacion
    and   tr_secuencial  = sec_pag
    and   tr_estado <>'RV'
    and   tr_tran in('PAG')
    and   tr_secuencial > 0
    and   dtr_concepto not in ('CAP','VAC0')
    
    -- desembolso 
    insert into #operaciones_reportar
    select distinct tr_operacion  = tr_operacion ,
                 tr_banco      = tr_banco, 
                 dtr_dividendo = dtr_dividendo,
                 fecha_ven     = convert(datetime,null)
    from cob_cartera..ca_transaccion, cob_cartera..ca_det_trn
    where tr_operacion =dtr_operacion
    and   tr_secuencial=dtr_secuencial
    and   tr_fecha_ref BETWEEN @w_inicio_mes_anterior AND @w_fecha_fin_mes_anterior
    and   tr_estado <>'RV'
    and   tr_tran in('DES')
    and   tr_secuencial > 0
    and   dtr_concepto not in ('CAP','VAC0')
     
    --
    
    select tr_banco into #operaciones_pag from #operaciones_reportar group by tr_banco
    
    select *
    into #pagos_mes_anterior
    from #operaciones_pag,
    cob_conta_super..sb_dato_cuota_pry
    where dc_fecha = @w_fecha_fin_mes_anterior_his
    and dc_banco = tr_banco
    
    select *
    into #pagos_mes_actual
    from #operaciones_pag,
    cob_conta_super..sb_dato_cuota_pry
    where dc_fecha = @w_fin_mes_ant_hab
    and dc_banco = tr_banco
    
    select 
    dc_banco    = act.dc_banco, 
    dc_num_cuota= act.dc_num_cuota,
    int_pag     = isnull(act.dc_int_pag,0) - isnull(ant.dc_int_pag,0),
    imo_pag     = isnull(act.dc_imo_pag,0) - isnull(ant.dc_imo_pag,0),
    iva_int_pag = isnull(act.dc_iva_int_pag,0) - isnull(ant.dc_iva_int_pag,0),
    iva_imo_pag = isnull(act.dc_iva_imo_pag,0) - isnull(ant.dc_iva_imo_pag,0)
    into #ValoresPagados
    from #pagos_mes_anterior ant,
    #pagos_mes_actual act
    where ant.dc_banco   = act.dc_banco
    and ant.dc_num_cuota = act.dc_num_cuota
    --group by act.dc_banco, act.dc_num_cuota
    
    delete #ValoresPagados
    where int_pag <= 0
    and   iva_int_pag <= 0
    
    select '#ValoresPagados', * from #ValoresPagados where dc_banco= '210320023694'
    
    -- 
    update #operaciones_reportar
    set fecha_ven = di_fecha_ven
    from  cob_cartera..ca_dividendo
    where di_operacion = tr_operacion
    and dtr_dividendo  = di_dividendo 
    
    select distinct tr_banco 
    into #operaciones_hijas_finales
    from #operaciones_reportar,cob_credito..cr_resultado_xml
    where tr_banco         = num_operation
    and   rx_total_saldo_act > 0
    and   (rx_cuota_desde = dtr_dividendo or    rx_cuota_hasta = dtr_dividendo)    
    and rx_fecha_fin_mes < 	@w_fin_mes_ant_hab
               
   
                
   print 'antes de los pendientes'
   
  /*Insert de los cr_resultado xml*/
   insert into #pendientes(
   banco		,pago_mes		,fin_mes       ,
   cuota_ini	,cuota_hasta	,insoluto_pago ,
   folio_ref    ,deuda_pagar    ,sec_compl_id)
   select 
   num_operation,
   rx_total_saldo_act,
   rx_fecha_fin_mes,
   rx_cuota_desde,
   rx_cuota_hasta,
   rx_deuda_pagar,
   max(rx_folio_ref),
   rx_total_saldo = rx_total_saldo_act,
   isnull(max(rx_sec_id),1)
   from  cob_credito..cr_resultado_xml,#operaciones_hijas_finales
   where rx_deuda_pagar   > 0
   and   rx_fecha_fin_mes < @w_fecha_fin_mes_anterior
   and   rx_met_fact      = 'PPD'
   and   rx_genera_cmpl   = 'S'
   and   tr_banco         = num_operation
   and   rx_sec_id        > 0
   and   rx_total_saldo_act > 0
   and   rx_fecha_fin_mes < @w_fin_mes_ant_hab
   group by    num_operation,rx_deuda_pagar,rx_fecha_fin_mes,
               rx_cuota_desde,rx_cuota_hasta,
               rx_total_saldo_act 
          
   delete #pendientes where deuda_pagar = 0
   /*insert into #operaciones_compl_ant(  
   dc_banco, 	 dc_num_cuota , 	dc_fecha_vto , dc_estado,
   dc_int_pag,   dc_otros_pag  ,    dc_int_acum  , dc_imo_pag, 
   dc_imo_cuota, dc_iva_int_pag ,   dc_iva_imo_pag  ) 
   select dc_banco,dc_num_cuota,dc_fecha_vto,dc_estado,dc_int_pag,dc_otros_pag,
          dc_int_acum,dc_imo_pag,dc_imo_cuota,dc_iva_int_pag,dc_iva_imo_pag
   from cob_conta_super..sb_dato_cuota_pry
   where dc_fecha    = @w_fecha_fin_mes_anterior
   and dc_aplicativo = 7
   and dc_fecha_vto <@w_fecha_fin_mes_anterior_his
   and dc_estado in (1,2)
   
   insert into #operaciones_compl_ant(  
   dc_banco, 	 dc_num_cuota ,    dc_fecha_vto,   dc_estado,
   dc_int_pag,   dc_otros_pag,     dc_int_acum,    dc_imo_pag, 
   dc_imo_cuota, dc_iva_int_pag,   dc_iva_imo_pag  ) 
   select dc_banco,dc_num_cuota,dc_fecha_vto,dc_estado,dc_int_pag,dc_otros_pag,
   dc_int_acum,dc_imo_pag,dc_imo_cuota,dc_iva_int_pag,dc_iva_imo_pag 
   from cob_conta_super..sb_dato_cuota_pry,#pendientes
   where dc_banco=banco
   and   dc_fecha=@w_fecha_fin_mes_anterior
   and   dc_num_cuota between cuota_ini and cuota_hasta
   and   dc_aplicativo=7
  and   dc_estado not in (1,2,0)*/
   
   select 
   insoluto_pago  = max(insoluto_pago),
   pago_int       = sum(int_pag) ,
   pago_imo       = 0,
   pago_iva_int   = sum(iva_int_pag),
   pago_iva_imo   = 0,
   compl_hijo     = convert(money,0), 
   banco          = banco,
   folio_ref      = folio_ref,
   deuda_pagar    = deuda_pagar,
   sec_id         = sec_id,
   sec_compl_id   = sec_compl_id,
   saldo_total    = convert(money,0) 
   into #operacione_complemento_final
   from #ValoresPagados,#pendientes
   where dc_banco = banco
   and dc_num_cuota between cuota_ini and cuota_hasta
   GROUP BY banco,folio_ref,deuda_pagar,sec_id,sec_compl_id

   update #operacione_complemento_final set
   saldo_total=pago_int+pago_imo+pago_iva_int+pago_iva_imo
   
   alter table #operacione_complemento_final add cuota_ini_c int 
   alter table #operacione_complemento_final add cuota_hasta_c int 
   
   update #operacione_complemento_final
   set cuota_ini_c   =  cuota_ini,	
       cuota_hasta_c =  cuota_hasta
  from #pendientes a,#operacione_complemento_final b
  where a.banco      = b.banco
  and   a.folio_ref  = b.folio_ref

   Update #operacione_complemento_final
   set compl_hijo= saldo_total
   
   -- crear una tabla banco ,fecha parametro ingreso, fecha, 
   
   update #operacione_complemento_final set
   compl_hijo = case 
                when (isnull(rx_total_saldo_act,0)-isnull(compl_hijo,0))<=0.05 then
                  compl_hijo + (isnull(rx_total_saldo_act,0)-isnull(compl_hijo,0))
                else
                  compl_hijo
                end
   from cob_credito..cr_resultado_xml
   where   banco           = num_operation
   and     rx_cuota_desde = cuota_ini_c
   and     rx_cuota_hasta = cuota_hasta_c
   and rx_fecha_fin_mes < 	@w_fin_mes_ant_hab
      
  
      
   select   
   banco              = banco,
   sec_id             = max(rx_sec_id),
   rxh_cuota_desde    = rx_cuota_desde,
   rxh_cuota_hasta    = rx_cuota_hasta,
   rfc_ente           = rfc_ente,
   id_ente            = id_ente,
   tipo_operacion_his = rx_tipo_operacion,
   rxh_folio_ref      = max(rx_folio_ref),--se aumento
   rxh_fin_mes        = rx_fecha_fin_mes,
   rxh_id_documento   = convert(varchar(60),null),
   rxh_estd_timbrado  = convert(char(1),null)
   into #operaciones_max_his
   from #operacione_complemento_final,cob_credito..cr_resultado_xml
   where banco         = num_operation
   and   cuota_ini_c   = rx_cuota_desde
   and   cuota_hasta_c = rx_cuota_hasta
   and rx_fecha_fin_mes < 	@w_fin_mes_ant_hab
   group by  banco,rx_cuota_desde,rx_cuota_hasta,rfc_ente,id_ente,rx_tipo_operacion,rx_fecha_fin_mes
   
   /*Encuentro el folio Fiscal de las historicas*/
   update #operaciones_max_his
   set rxh_id_documento  = in_folio_fiscal,
       rxh_estd_timbrado = in_estd_timb
   from #operaciones_max_his,cob_conta_super..sb_ns_estado_cuenta
   where banco             = nec_banco
   and   rxh_cuota_desde   = in_cuota_desde
   and   rxh_cuota_hasta   = in_cuota_hasta
   and   rxh_fin_mes       = in_fecha_fin_mes
   and   in_folio_ref      = rxh_folio_ref
   

    /*
   insert into cob_conta_super..sb_est_complemento_xml (
	se_Rfc_emisor        ,se_Nombre  	    ,se_RegimenFiscal   ,se_Rfc_receptor   ,	
	se_UsoCFDI 		     ,se_ClaveProdServ  ,se_Cantidad     	,se_ClaveUnidad    ,
	se_Descripcion       ,se_ValorUnitario  ,se_Importe 		,se_Version		   ,
	se_FechaPago	     ,se_FormaDePagoP 	,se_MonedaP 		,se_Monto          ,
	se_RfcEmisorCtaOrd   ,se_IdDocumento 	,se_Folio			,se_MonedaDR       ,
	se_MetodoDePagoDR    ,se_NumParcialidad ,se_ImpSaldoAnt 	,se_ImpPagado      ,
	se_ImpSaldoInsoluto  ,se_banco          ,se_fecha			,se_file_name      ,
	se_id_ente           ,se_estatus        ,se_rfc_ente        ,se_insert_date    ,  
	se_rx_tipo_operacion ,se_cuota_ini      ,se_cuota_hasta     ,se_sec_id         ,
   se_tipo_compl ) 
   select 
	se_Rfc_emisor       = @w_rfc_emisor      	,
	se_Nombre           = @w_nombre_entidad		,
	se_RegimenFiscal    = @w_regimen_fiscal 	,
	se_Rfc_receptor     = rfc_ente_his	      	,
	se_UsoCFDI 		     = @w_uso_cdfi	      	,
	se_ClaveProdServ    = @w_clave_sat	      	,
	se_Cantidad         = @w_cantidad	     	,
	se_ClaveUnidad      = @w_clave_unidad	    ,
	se_Descripcion      = @w_descripcion	    ,
	se_ValorUnitario    =  compl_hijo	      	,  
	se_Importe 		    =  compl_hijo        	,
	se_Version		    = '1.0'	            	,
	se_FechaPago	    = @i_param1	       		,
	se_FormaDePagoP     = @w_forma_pago	      	,
	se_MonedaP 		    = @w_moneda_p         	,
	se_Monto            = compl_hijo          	,
	se_RfcEmisorCtaOrd  = @w_rfc_emisor       	,
	se_IdDocumento 	    = rxh_id_documento    	,
	se_Folio			= rxh_folio_ref    		,
	se_MonedaDR         = @w_moneda_dr        	,
	se_MetodoDePagoDR   = @w_metodo_pago_dr		,
	se_NumParcialidad   = ''	               	,
	se_ImpSaldoAnt   	= isnull(convert(varchar(50),deuda_pagar),'0') ,
	se_ImpPagado        = compl_hijo         	,
	se_ImpSaldoInsoluto = case when isnull(deuda_pagar-compl_hijo,0)<=0 then 0
	                            else isnull(deuda_pagar-compl_hijo,0) end,--isnull(convert(varchar(50),se_ImpSaldoAnt-se_ImpPagado),'0')	,--requiere calculo a historicos
	se_banco            = num_operation_his   	,
	se_fecha            = @w_fecha_proceso   	,
	se_file_name        = ''					,
	se_id_ente          = id_ente_his			,
	se_estatus          = 'P'					,
	se_rfc_ente         = rfc_ente_his			,
	se_insert_date      = @i_param1				,--fecha cuando se procesa el complemento
	se_rx_tipo_operacion= tipo_operacion_his  	,
	se_cuota_ini        = rxh_cuota_ini			,
	se_cuota_hasta      = rxh_cuota_hasta		,
	se_sec_id           = 1						,
	se_tipo_compl       = 'H'
   from #operacione_complemento_final,cob_credito_his..cr_complemento_pago_xml_his
   where banco        = num_operation_his
   and   folio_ref    = rxh_folio_ref
   and   sec_compl_id = rxh_sec_id
   */
   /*Ingreso de las hijas faltantes*/
   
   update  cob_credito..cr_resultado_xml set
   rx_total_saldo_act = rx_total_saldo_act - compl_hijo,
   rx_pago_compl = rx_pago_compl + compl_hijo 
   from #operacione_complemento_final
   where banco         = num_operation
   and   cuota_ini_c   = rx_cuota_desde
   and   cuota_hasta_c = rx_cuota_hasta
   
   
   update cob_credito..cr_resultado_xml
   set rx_genera_cmpl = 'N'
   from #operacione_complemento_final
   where banco         = num_operation
   and   cuota_ini_c   = rx_cuota_desde
   and   cuota_hasta_c = rx_cuota_hasta
   and   rx_total_saldo_act = 0
   
   
   insert into sb_est_complemento_xml (
   se_Rfc_emisor   	    ,se_Nombre  		   ,se_RegimenFiscal 	,se_Rfc_receptor   ,	
   se_UsoCFDI 			,se_ClaveProdServ 	   ,se_Cantidad     	,se_ClaveUnidad    ,
   se_Descripcion  	    ,se_ValorUnitario 	   ,se_Importe 			,se_Version		   ,
   se_FechaPago		    ,se_FormaDePagoP 	   ,se_MonedaP 			,se_Monto          ,
   se_RfcEmisorCtaOrd 	,se_IdDocumento 	   ,se_Folio			,se_MonedaDR       ,
   se_MetodoDePagoDR  	,se_NumParcialidad 	   ,se_ImpSaldoAnt 		,se_ImpPagado      ,
   se_ImpSaldoInsoluto	,se_banco              ,se_fecha			,se_file_name      ,
   se_id_ente           ,se_estatus            ,se_rfc_ente      	,se_insert_date    ,  
   se_rx_tipo_operacion ,se_cuota_ini          ,se_cuota_hasta   	,se_folio_ref      ,
   se_sec_id            ,se_tipo_compl         ,se_fecha_afectacion) 
   select 
   se_Rfc_emisor         = @w_rfc_emisor		,             	
	se_Nombre            = @w_nombre_entidad	,
	se_RegimenFiscal     = @w_regimen_fiscal 	,
	se_Rfc_receptor      = rfc_ente	     		,
	se_UsoCFDI 		     = @w_uso_cdfi  		,
	se_ClaveProdServ     = @w_clave_sat			,
	se_Cantidad          = @w_cantidad			,
	se_ClaveUnidad       = @w_clave_unidad 		,
	se_Descripcion       = @w_descripcion		,
	se_ValorUnitario     =  compl_hijo			,
	se_Importe 		     =  compl_hijo  		,
	se_Version		     = '1.0'  				,
	se_FechaPago	     = @i_param1   			,
	se_FormaDePagoP      = @w_forma_pago		,
	se_MonedaP 		     = @w_moneda_p 			,
	se_Monto             = compl_hijo  			,
	se_RfcEmisorCtaOrd   = @w_rfc_emisor		,
	se_IdDocumento 	     = rxh_id_documento		,
	se_Folio			 = rxh_folio_ref		,
	se_MonedaDR          = @w_moneda_dr			,
	se_MetodoDePagoDR    = @w_metodo_pago_dr	,
	se_NumParcialidad    = ''						,
	se_ImpSaldoAnt   	 = isnull(convert(varchar(50),deuda_pagar),'0') ,
    se_ImpPagado         = compl_hijo				,
	se_ImpSaldoInsoluto  = case when isnull(deuda_pagar-compl_hijo,0)<=0 then 0
	                            else isnull(deuda_pagar-compl_hijo,0) end,
	se_banco             = b.banco 				,
    se_fecha             = @w_fecha_proceso		,
    se_file_name         = ''						,
    se_id_ente           = b.id_ente				,
    se_estatus           = 'P'						,
    se_rfc_ente          = b.rfc_ente				,
    se_insert_date       = @i_param1		   	,
    se_rx_tipo_operacion = b.tipo_operacion_his,
    se_cuota_ini         = b.rxh_cuota_desde	,
    se_cuota_hasta       = b.rxh_cuota_hasta	,
    se_folio_ref         = rxh_folio_ref        ,
    se_sec_id            = 1							,
    se_tipo_compl        = 'H'                 ,
    se_fecha_afectacion  = rxh_fin_mes   
   from #operacione_complemento_final a,#operaciones_max_his b
   where a.banco       = b.banco
   and   cuota_ini_c   = rxh_cuota_desde
   and   cuota_hasta_c = rxh_cuota_hasta

	print 'antes de actualizar rx_fecha_ult_compl'
	
	Update cob_credito..cr_resultado_xml set 
	rx_fecha_ult_compl = @i_param1
	where rx_met_fact  = 'PPD'
	
	select count(1) as 'operacione_complemento_final ' from #operacione_complemento_final 
	
	update cob_credito..cr_complemento_pago_xml
	set rx_saldo_inso=case when isnull(deuda_pagar-compl_hijo,0)<=0 then 0
	                        else isnull(deuda_pagar-compl_hijo,0) end
	from #operacione_complemento_final,cob_credito..cr_complemento_pago_xml
	where banco          = num_operation
	and   folio_ref      = rx_folio_ref
	and   sec_compl_id   = rx_sec_id
	and   rx_tipo_compl = 'P'
	and   in_fecha_fin_mes < @i_param1
	
	print 'Parametro -> @i_param1 : ' + convert(varchar(10),@i_param1,3)
	
		  
   select 
   num_operation_his_act  = num_operation,
   insert_date_his_act    = insert_date,
   rxh_sec_id_max_act     = isnull(max(rx_sec_id),0)
   into #max_sec_actuales
   from cob_credito..cr_complemento_pago_xml
   where insert_date  = @i_param1
   and   in_fecha_fin_mes < @i_param1
   group by num_operation,insert_date
   
   update cob_conta_super..sb_est_complemento_xml 
   set   se_sec_id= isnull(rxh_sec_id_max_act,0)+1
   from #max_sec_actuales ,cob_conta_super..sb_est_complemento_xml
   where num_operation_his_act   = se_banco
   and   insert_date_his_act     = se_insert_date


   -- Información de secuenciales para cada complemento 
   update cob_credito..cr_seqnos_comp_pago_xml 
   set csc_NumParcialidad = csc_NumParcialidad + 1,
       csc_fecha_afec     = se_fecha_afectacion
   from cob_conta_super..sb_est_complemento_xml
   where csc_folio  = se_Folio
     
     
   -- Se inserta los nuevos secuenciales
   insert cob_credito..cr_seqnos_comp_pago_xml
   select se_Folio,
          se_IdDocumento,
		  se_banco,
		  1,
		  getdate(),
		  se_fecha_afectacion
   from cob_conta_super..sb_est_complemento_xml
   where not exists (select 1 from cob_credito..cr_seqnos_comp_pago_xml                                   
                     where csc_folio = se_Folio)
		
   					 			 
   -- Se actualiza el numero de parcialidad con respecto al consecutivo
   update cob_conta_super..sb_est_complemento_xml set 
   se_NumParcialidad = csc_NumParcialidad
   from cob_credito..cr_seqnos_comp_pago_xml
   where csc_folio = se_Folio

   --Actualizaci?n de nombres para los xml de complementos
   update cob_conta_super..sb_est_complemento_xml set 
   se_file_name =isnull(CASE se_rx_tipo_operacion    
                        WHEN 'GRUPAL'        THEN 'GRP_C_'+''+se_banco+'_'+''+replace( CONVERT(VARCHAR(10), @i_param1, 101),'/','')+'_'+RIGHT('00000000' + Ltrim(Rtrim(se_NumParcialidad)),7)
                        WHEN 'REVOLVENTE'    THEN 'LCR_C_'+''+se_banco+'_'+''+replace( CONVERT(VARCHAR(10), @i_param1, 101),'/','')+'_'+RIGHT('00000000' + Ltrim(Rtrim(se_NumParcialidad)),7)
                        ELSE '' END,'')
						
    select @w_mes_proceso = case  
                           when month(@w_fin_mes_ant_hab) = 1 then 'ENERO' 
                           when month(@w_fin_mes_ant_hab) = 2 then 'FEBRERO' 
                           when month(@w_fin_mes_ant_hab) = 3 then 'MARZO' 
                           when month(@w_fin_mes_ant_hab) = 4 then 'ABRIL' 
                           when month(@w_fin_mes_ant_hab) = 5 then 'MAYO' 
                           when month(@w_fin_mes_ant_hab) = 6 then 'JUNIO' 
                           when month(@w_fin_mes_ant_hab) = 7 then 'JULIO' 
                           when month(@w_fin_mes_ant_hab) = 8 then 'AGOSTO' 
                           when month(@w_fin_mes_ant_hab) = 9 then 'SEPTIEMBRE' 
                           when month(@w_fin_mes_ant_hab) = 10 then 'OCTUBRE' 
                           when month(@w_fin_mes_ant_hab) = 11 then 'NOVIEMBRE' 
                           else 'DICIEMBRE' 
                           end  
   
   --   update sb_est_complemento_xml set 
   --   se_Descripcion = se_Descripcion + ' '  + convert(varchar(4),year(@w_fin_mes_ant_hab)) + ' - ' + @w_mes_proceso 
   
   --Insercci?n tabla de xml para complementos
   insert into cob_credito..cr_complemento_pago_xml (
   linea, 				file_name, 		 id_ente, 			  status, 
   rfc_ente, 			num_operation,  insert_date, 	     tipo_operacion, 
   in_fecha_fin_mes, rx_saldo_inso,  rx_cuota_ini,      rx_cuota_hasta,
   rx_folio_ref,     rx_deuda_pagar, rx_saldo_inso_fin, rx_sec_id,
   rx_tipo_compl,       rx_id_documento,rx_fe_mes_afecta,  rx_monto_pag   )
   select 
    '<cfdi:Emisor ' + 
    'Rfc="' + isnull(se_Rfc_emisor,'') +'" ' +
    'Nombre="' + isnull(se_Nombre,'') +'" ' +
    'RegimenFiscal="' + isnull(se_RegimenFiscal,'') +'"/>' +
     --Receptor
     '<cfdi:Receptor Rfc="' + isnull(se_Rfc_receptor,'') +'" ' +
     'UsoCFDI="' + isnull(se_UsoCFDI,'') +'"/>'+ 
     -- Conceptos
     '<cfdi:Conceptos>'+
          '<cfdi:Concepto '+
          'ClaveProdServ="'+isnull(se_ClaveProdServ,'')+'" '+
          'Cantidad="'+isnull(se_Cantidad,'')+'" '+
          'ClaveUnidad="' + isnull(se_ClaveUnidad,'') + '" '+
	      'Descripcion="' + isnull(se_Descripcion,'') + '" '+
	      'ValorUnitario="' + isnull('0.00','') + '" '+
	      'Importe="' + isnull('0.00','') + '"/>'+
     '</cfdi:Conceptos>'+
     --Complemento
     '<cfdi:Complemento>'+
          --Pagos
          '<pago10:Pagos '+
          'Version="'+ isnull(se_Version,'') + '">' +
             --Pago
             '<pago10:Pago '+
             'FechaPago="' + isnull(format(dateadd(ss,43140,se_fecha), 'yyyy-MM-ddTHH:mm:ss'),'') +'" '+
             'FormaDePagoP="' + isnull(se_FormaDePagoP,'') +'" '+
             'MonedaP="' + isnull(se_MonedaP,'') +'" '+
             'Monto="' + isnull(se_Monto,'') +'" '+
             'RfcEmisorCtaOrd="' + isnull(se_RfcEmisorCtaOrd,'') + '">' +
                  --Pago DoctoRealacionado
                  '<pago10:DoctoRelacionado '+
                  'IdDocumento="' + isnull(se_IdDocumento,'')  +'" ' +
                  'Folio="' + isnull(se_Folio,'')  +'" ' +
                  'MonedaDR="' + isnull(se_MonedaDR,'')  +'" ' +
                  'MetodoDePagoDR="' + isnull(se_MetodoDePagoDR,'')  +'" ' +
                  'NumParcialidad="' + isnull(se_NumParcialidad,'')   +'" ' + 
                  'ImpSaldoAnt="' + isnull(se_ImpSaldoAnt,'')  +'" ' +
                  'ImpPagado="' + isnull(se_ImpPagado,'')  +'" ' +
                  'ImpSaldoInsoluto="' + isnull(se_ImpSaldoInsoluto,'')  + '"/>'+
             '</pago10:Pago>'+
          '</pago10:Pagos>'+
     '</cfdi:Complemento>'  ,
	 se_file_name        	,
	 se_id_ente			   	,
	 se_estatus			   	,
	 se_rfc_ente		   	,
	 se_banco 			   	,
	 se_insert_date	   		,
	 se_rx_tipo_operacion	, 
	 se_fecha				,
	 se_ImpSaldoInsoluto	,
	 se_cuota_ini			,
	 se_cuota_hasta			,
	 se_folio_ref			,
	 se_deuda_pagar			,
	 se_ImpSaldoInsoluto 	,
	 se_sec_id				,
	 se_tipo_compl			,
	 se_IdDocumento         ,
	 se_fecha_afectacion    ,
	 se_ValorUnitario
   from cob_conta_super..sb_est_complemento_xml 
  
end

update cob_conta..cb_solicitud_reportes_reg
set   sr_status = 'P'
where sr_reporte = @w_reporte
and   sr_status = 'I'

if @@error <> 0
begin
    select @w_error = 710002
    goto ERROR_PROCESO
end

SALIDA_PROCESO:
return 0

ERROR_PROCESO:
     select @w_msg = isnull(@w_msg, 'ERROR GENERAL DEL PROCESO')
     exec cob_conta_super..sp_errorlog
     @i_fecha_fin     = @i_param1,
     @i_fuente        = @w_sp_name,
     @i_origen_error  = @w_error,
     @i_descrp_error  = @w_msg
go

