/************************************************************/
/*   ARCHIVO:         sp_xml_estado_cuenta_compl.sp         */
/*   NOMBRE LOGICO:   sp_xml_estado_cuenta_compl            */
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
/*  individuales                                            */
/************************************************************/
/*                           MODIFICACIONES                 */
/*   FECHA       AUTOR        RAZON                         */
/* 04/AGO/2022   DCumbal     Emision inicial                */
/************************************************************/
use cob_conta_super
go

if exists(select 1 from sysobjects where name = 'sp_xml_estado_cuenta_compl')
    drop proc sp_xml_estado_cuenta_compl
go

create proc sp_xml_estado_cuenta_compl (
    @t_show_version     bit         =   0,
    @i_param1           datetime    =  null, -- FECHA DE PROCESO
    @t_debug            char(1) 	= 'N',
    @i_fin_mes_hab      datetime    = null,
	@i_ini_mes          datetime    = null,
	@i_fin_mes          datetime    = null,
	@i_fin_mes_ant      datetime    = null,
	@i_fin_mes_ant_hab  datetime    = null
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
   @w_nombre_entidad   varchar(100),
   @w_regimen_fiscal   varchar(100),
   @w_rfc_emisor       varchar(30)

select @w_sp_name         = 'sp_xml_estado_cuenta',
       @w_rfc_emisor      = 'SIF170801PYA',
       @w_nombre_entidad  = 'SANTANDER INCLUSION FINANCIERA SA DE CV SOFOM  ENTIDAD REGULADA, GRUPO FINANCIERO SANTANDER MÉXICO',
       @w_regimen_fiscal  = '601'

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
@w_habil_anterior        datetime,
@w_fecha_proceso_fact    datetime,
@w_est_vencido           int, 
@w_est_vigente           int,
@w_est_castigado         int,
@w_est_suspenso          int,
@w_est_cancelado         int
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso


exec @w_error    = cob_externos..sp_estados
@i_producto      = 7,
@o_est_vencido   = @w_est_vencido   out,
@o_est_vigente   = @w_est_vigente   out,
@o_est_castigado = @w_est_castigado out,
@o_est_suspenso  = @w_est_suspenso  out,
@o_est_cancelado = @w_est_cancelado out
 

SELECT @w_reporte = 'ESTCTA'

select @w_porcentaje_iva = (pa_float/100)
from  cobis..cl_parametro
where pa_nemonico = 'PIVA'
and   pa_tipo     = 'F'

select 
@w_fin_mes_hab     = @i_fin_mes_hab,
@w_ini_mes         = @i_ini_mes,
@w_fin_mes         = @i_fin_mes,
@w_fin_mes_ant     = @i_fin_mes_ant,
@w_fin_mes_ant_hab = @i_fin_mes_ant_hab


print ' @o_ini_mes          = ' + isnull(convert(varchar,@w_ini_mes         ),'x')
print ' @o_fin_mes          = ' + isnull(convert(varchar,@w_fin_mes         ),'x')
print ' @o_fin_mes_hab      = ' + isnull(convert(varchar,@w_fin_mes_hab     ),'x')
print ' @o_fin_mes_ant      = ' + isnull(convert(varchar,@w_fin_mes_ant     ),'x')
print ' @o_fin_mes_ant_hab  = ' + isnull(convert(varchar,@w_fin_mes_ant_hab ),'x')

if @t_debug = 'S' print 'Ingresa al proceso'


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


select
   @w_ini_mes = dateadd(dd, 1-datepart(dd, @w_fin_mes_hab ), @w_fin_mes_hab) ,
   @w_fin_mes = dateadd(dd, -1,dateadd(mm, 1, @w_ini_mes) )

if @t_debug = 'S' print 'Realiza insert en cr_resultado_cml_his'
select @w_habil_anterior= dateadd(dd, -1, @w_fin_mes_hab)
    
while exists (select 1
                      from cobis..cl_dias_feriados
                where df_fecha  = @w_habil_anterior
                      and   df_ciudad = @w_ciudad_nacional)
begin
   select @w_habil_anterior= dateadd(dd, -1, @w_habil_anterior)
end
    
print '@w_habil_anterior '+convert (varchar(50),@w_habil_anterior) 
    

/****************************************************************/
/* Obtener el universo                                          */
/****************************************************************/
select *
into #sb_dato_operacion_universo_ven
from cob_conta_super..sb_dato_operacion
where do_fecha      = @w_fin_mes_hab
and   do_aplicativo = 7
--and   do_estado_cartera in (@w_est_vencido, @w_est_castigado)
and   do_tipo_operacion = 'INDIVIDUAL'
	
/**************************************************************************/
/* PROCESO PARA OBTENER LOS VALORES FACTURADOS EN EL PERIODO DEL REPORTE */
/**************************************************************************/
if @t_debug = 'S' print 'Insert en tabla amortizacion_aux_ven'


select *
into  #sb_dato_cuota_pry_ven
from  cob_conta_super..sb_dato_cuota_pry,
      #sb_dato_operacion_universo_ven
where dc_fecha      = @w_fin_mes_hab
and   dc_aplicativo = 7
and   dc_banco      = do_banco
      
create index idx0 on #sb_dato_cuota_pry_ven(dc_banco, dc_fecha_vto)
      
-- validar los cuotas
truncate table sb_est_cuenta_xml_venc
  	  
insert into sb_est_cuenta_xml_venc (
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
       ecx_comisiones_efec_mes,
       ecx_estado_cartera)                                          
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
	   0,
	   do_estado_cartera
from #sb_dato_operacion_universo_ven	 
	 
-- Actualizacion Informacion Cliente
update sb_est_cuenta_xml_venc set
ecx_rfc        = convert(varchar(25), en_nit),
ecx_id_externo = convert(varchar(25), en_ente),
ecx_nombre     = isnull(convert(varchar(254), en_nomlar),''),
ecx_buc        = en_banco
from cobis..cl_ente
where en_ente  = ecx_ente 
	 
---drop table #ult_direccion_cliente	 	 
select cliente = ecx_ente, ultima_direccion = max(di_direccion)
into #ult_direccion_cliente
from sb_est_cuenta_xml_venc,
     cobis..cl_direccion
where di_ente = ecx_ente
and   di_tipo = 'RE'--@w_parametro_tipo 
group by ecx_ente 
	 
update sb_est_cuenta_xml_venc set 
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
     
update sb_est_cuenta_xml_venc set 
ecx_telefono   =  te_valor
from cobis..cl_telefono
where ecx_ente = te_ente  
     
update sb_est_cuenta_xml_venc set 
ecx_email   =  convert(varchar(100), isnull(di_descripcion,''))
from cobis..cl_direccion
where ecx_ente     = di_ente  
and   di_tipo      = 'CE'
and  di_descripcion is not null                

update sb_est_cuenta_xml_venc set
ecx_sub_total     = 0,
ecx_total         = 0,
ecx_cfdi_base     = 0,
ecx_total_impuestos_trasladados = 0,
ecx_iva         = 0,
ecx_cfdi_importe= 0


/**********************************************/ 
/*Actualizacion secuencial                    */
/**********************************************/ 
    
select ecx_banco
into #secuenciales
from sb_est_cuenta_xml_venc
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
update sb_est_cuenta_xml_venc set
ecx_secuencial = ss_secuencial
from sb_secuenciales
where ecx_banco = ss_operacion
    
/**********************************************/ 
/*Actualizacion nombre archivo                */
/**********************************************/ 
select @w_fecha_proceso = format(dateadd(ss,-3000,getdate()), 'yyyy-MM-ddTHH:mm:ss')
select @i_param1 = isnull(@i_param1,@w_fin_mes_hab)
   

--CREACION DE TABLA TEMPORAL
   select 
   nec_banco     , 	          nec_fecha               ,    nec_correo            ,     nec_estado             ,
   in_cliente_rfc,            in_cliente_buc          ,    in_folio_fiscal        ,     in_certificado         ,in_sello_digital,
   in_sello_sat  ,            in_num_se_certificado   ,    in_fecha_certificacion ,     in_cadena_cer_dig_sat  ,in_nombre_archivo, 
   in_observacion,            in_fecha_procesamiento  ,    in_fecha_xml           ,     in_rfc_emisor          ,in_estd_timb,
   in_monto_fac  ,            in_toperacion           ,    in_met_fact            ,     in_estado_pdf          ,in_estado_correo,
   in_nombre_pdf ,            in_estd_clv_co          ,    in_grupo               ,     in_nombre_cli          ,in_cuota_desde,
   in_cuota_hasta,            in_folio_ref            ,    in_fecha_fin_mes
   into #sb_ns_estado_cuenta_ven
   from cob_conta_super..sb_ns_estado_cuenta where 1= 2 
   
create index sb1 on #sb_ns_estado_cuenta_ven (nec_banco)
   
alter table #sb_ns_estado_cuenta_ven add in_ente int 
alter table #sb_ns_estado_cuenta_ven add in_operacion int 
   --CREA TABLA TEMPORAL CON REGISTROS
insert into #sb_ns_estado_cuenta_ven (
nec_banco     ,            nec_fecha                   ,    nec_correo                  ,  nec_estado             ,
in_cliente_rfc,            in_cliente_buc              ,    in_folio_fiscal             ,  in_certificado         ,in_sello_digital,
in_sello_sat  ,            in_num_se_certificado       ,    in_fecha_certificacion      ,  in_cadena_cer_dig_sat  ,in_nombre_archivo, 
in_observacion,            in_fecha_procesamiento      ,    in_fecha_xml                ,  in_rfc_emisor          ,in_estd_timb,
in_monto_fac  ,            in_toperacion               ,    in_met_fact                 ,  in_estado_pdf          ,in_estado_correo   ,
in_nombre_pdf,             in_estd_clv_co              ,    in_grupo                    ,  in_nombre_cli          ,in_ente            ,
in_cuota_desde,            in_cuota_hasta              ,    in_folio_ref                ,     
in_fecha_fin_mes)     
select 
ecx_banco                   ,format(dateadd(ss,-86399,ecx_fecha), 'yyyy-MM-ddTHH:mm:ss') , isnull(ecx_email,'')       , convert(varchar (30),'P') ,  
ecx_rfc                     ,ecx_buc                   ,   convert(varchar(60), null)    , convert(varchar (30),null) , convert(varchar(1500),null),
convert(varchar(1500),null) ,convert(varchar(30),null) ,   convert(datetime, null)       , convert(varchar(1500),null), convert(varchar(100),null),
convert(varchar(300) ,null) ,getdate()                 ,  convert(datetime, null)       , convert(varchar(30), null)  , convert(char(1), 'N'),
convert(varchar(30)  ,null) ,convert(varchar(30),null) ,   convert(varchar(5),'PUE')     , convert(char(1), 'P')      , case when ecx_estado_cartera = @w_est_castigado then convert(char(1), null) else convert(char(1), 'P') end,
convert(varchar(100),null)  ,convert(varchar(1),'P')   ,   convert(int,0)                , convert(varchar(255),null) , ecx_ente                    ,
ecx_cuota_ini               ,ecx_cuota_fin             ,   convert(varchar, ecx_banco) + '-' + RIGHT('00' + convert(varchar,ecx_secuencial), 3)     ,
format(dateadd(ss,-86399,ecx_fecha), 'yyyy-MM-ddTHH:mm:ss')
from sb_est_cuenta_xml_venc

if @@error != 0 begin
   select 
   @w_error = 710902,
   @w_msg   = 'ERROR EN TABLA TEMPORAL SB_NS_ESTADO_CUENTA'
   goto ERROR_PROCESO
end


--ACTUALIZACION DEL TIPO DE OPERACION 
   
update #sb_ns_estado_cuenta_ven set 
in_toperacion = op_toperacion, 
in_operacion  = op_operacion
from cob_cartera..ca_operacion 
where nec_banco = op_banco
   
update #sb_ns_estado_cuenta_ven set 
nec_estado = 'X'
from cob_cartera..ca_operacion
where   op_toperacion = 'REVOLVENTE'
and     nec_banco = op_banco
   

select 
operacionca     = dc_operacion ,
max_ciclo       = max(dc_ciclo_grupo)
into #maximos_ciclos
from cob_cartera..ca_det_ciclo,#sb_ns_estado_cuenta_ven
where in_operacion =dc_operacion
group by dc_operacion

select 
grupo       = dc_grupo,
dc_operacion = dc_operacion
into #operaciones_ven_grupo
from cob_cartera..ca_det_ciclo,#maximos_ciclos
where operacionca = dc_operacion
and  dc_ciclo_grupo  = max_ciclo
 
update #sb_ns_estado_cuenta_ven set 
in_grupo = grupo 
from #operaciones_ven_grupo
where dc_operacion = in_operacion
      
update  #sb_ns_estado_cuenta_ven set
in_nombre_cli= en_nomlar
from cobis..cl_ente 
where en_ente = in_ente
   

--INSERCION A DEFINITIVAS 
   
insert into cob_conta_super..sb_ns_estado_cuenta (
nec_banco     , 	nec_fecha            , 	 nec_correo            ,       nec_estado             ,
in_cliente_rfc,  in_cliente_buc          ,   in_folio_fiscal       ,       in_certificado         , in_sello_digital,
in_sello_sat  ,  in_num_se_certificado   ,   in_fecha_certificacion,       in_cadena_cer_dig_sat  , in_nombre_archivo, 
in_observacion,  in_fecha_procesamiento  ,   in_fecha_xml          ,       in_rfc_emisor           , in_estd_timb,
in_monto_fac  ,  in_toperacion           ,   in_met_fact            ,      in_estado_pdf           ,in_estado_correo,
in_nombre_pdf ,  in_estd_clv_co          ,   in_grupo              ,       in_nombre_cli          ,in_cuota_desde    ,
in_cuota_hasta,  in_folio_ref            ,   in_fecha_fin_mes)
select  
nec_banco     ,  nec_fecha               , 	  nec_correo            ,      nec_estado              ,
in_cliente_rfc,  in_cliente_buc          ,    in_folio_fiscal       ,      in_certificado          ,in_sello_digital,
in_sello_sat  ,  in_num_se_certificado   ,    in_fecha_certificacion,      in_cadena_cer_dig_sat   ,in_nombre_archivo, 
in_observacion,  in_fecha_procesamiento  ,    in_fecha_xml          ,      in_rfc_emisor           , in_estd_timb,
in_monto_fac  ,  in_toperacion           ,    in_met_fact           ,      in_estado_pdf           ,in_estado_correo,
in_nombre_pdf,   in_estd_clv_co          ,    in_grupo              ,      in_nombre_cli           ,in_cuota_desde,
in_cuota_hasta,  in_folio_ref            ,    in_fecha_fin_mes        
from #sb_ns_estado_cuenta_ven
      
  
if @@error != 0 begin
   select 
   @w_error = 710802,
   @w_msg   = 'ERROR EN TABLA FISICA SB_NS_ESTADO_CUENTA'
   goto ERROR_PROCESO
end

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

