use cob_conta_super
go
/************************************************************/
/*   ARCHIVO:         sp_rep_operacion_inurel.sp            */
/*   NOMBRE LOGICO:   sp_rep_operacion_inurel               */
/*   PRODUCTO:        COBIS CREDITO                         */
/************************************************************/
/*                     IMPORTANTE                           */
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
/*                     PROPOSITO                            */
/*  Genera el reporte de operaciones inusual preocupante    */
/*  y relevantes                                            */
/************************************************************/
/*                     MODIFICACIONES                       */
/*   FECHA         AUTOR            RAZON                   */
/* 23/May/2018     Darío Cumbal     Emision inicial         */
/* 27/May/2019     PXSG             Cambios por             */
/*                                  requerimiento 114569    */
/************************************************************/
if exists(select 1 from sysobjects where name = 'sp_rep_operacion_inurel')
   drop proc sp_rep_operacion_inurel
go
create proc sp_rep_operacion_inurel (
  @t_show_version       bit         =   0   ,
  @i_param1             datetime    =   null, -- FECHA DE PROCESO, por FE is null
  @i_param2             varchar(10) =   null, -- TIPO DE REPORTE 'R-Relevantes', 'I-Inusuales', 'IP - Internas preocupantes', para FE is null
  @i_param3             int         =   NULL  -- Id de Alerta cuando se dispara por FE,por batch is null
)as
declare
  @w_sp_name        varchar(20),
  @w_s_app          varchar(50),
  @w_path           varchar(255),
  @w_path_obj       varchar(255),
  @w_destino        varchar(2500),
  @w_msg            varchar(200) ,
  @w_error          int          ,
  @w_fecha_proceso  datetime     ,
  @w_periodo        varchar(10)  ,
  @w_telefono       varchar(255) ,
  @w_cliente        int          ,
  @w_cliente_ant    int          ,
  @w_aux_telefono   varchar(16)  , 
  @w_secuencial     int          ,
  @w_separador      varchar(2)   ,
  @w_comando        varchar(2500),
  @w_nombre_repo    varchar(20)  ,
  @w_errores        varchar(1500),
  @w_id_alerta_varchar   varchar(6)   ,
  @w_nombre_reporte      varchar (255),
  @w_id_alerta_final     varchar(6),
  @w_ruta_alertas        varchar(30),
  @w_member_code         varchar(20),
  @w_p_apellido         varchar(100),
  @w_s_apellido         varchar(100)

select   @w_sp_name= 'sp_rep_operacion_inurel'

--Versionamiento del Programa --
if @t_show_version = 1
begin
 print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
 return 0
end
select @w_nombre_repo = pa_char
from   cobis..cl_parametro
where  pa_producto = 'REC'
and    pa_nemonico = 'NROPII'

select @w_separador = ';'

select @w_fecha_proceso = fc_fecha_cierre
from cobis..ba_fecha_cierre
where fc_producto = 7


-- NOMBRE DEL ARCHIVO - INI
select @w_member_code = pa_char
from cobis..cl_parametro
where pa_nemonico='MNBRCD'--='BCCU'
and   pa_producto='REC'--='CRE'

select @w_periodo= convert(varchar(10),@w_fecha_proceso,112)  

/*if @i_param2='R'
  select @w_periodo = substring(@w_periodo,1,6)*/

   
--///////////////////////////////

--Tabla temporal de las reglas 
/*declare @temp_reglas_negocio AS TABLE 
(   monto_riesgo_ini     money,
    monto_riesgo_hasta   money,
    operador_moneda      VARCHAR(20),
    moneda               INT,
    periodo              CHAR(1),
    etiqueta             VARCHAR(255),
    tipo_alerta          VARCHAR(255),
    tipo_operacion       VARCHAR(255),
    nivel_riesgo         VARCHAR(255)
)
*/
create table #tmp_telefonos
(
  te_secuencial           int identity,
  te_cliente              int,
  te_telefono             varchar(16)
)

create table #tmp_operaciones_inusuales
(
  oi_secuencial             int identity     ,
  oi_folio                  varchar(6)   null,
  oi_codigo_cliente         int          null,
  oi_tipo_reporte           char(1)      null,  
  oi_periodo_reporte        varchar(10)  null,
  oi_organo_supervisor      varchar(10)  null,
  oi_clave_sujeto           varchar(10)  null,
  oi_localidad              varchar(100) null,
  oi_codigo_postal          varchar(10)  null,
  oi_tipo_operacion         varchar(10)  null,
  oi_instrumento_monetario  varchar(10)  null,
  oi_contrato               varchar(20)  null,
  oi_monto                  money        null,
  oi_codigo_moneda          int          null,
  oi_moneda                 varchar(20)  null,
  oi_fecha_operacion        varchar(10)  null,
  oi_fecha_deteccion        varchar(10)  null,
  oi_nacionalidad           varchar(10)  null,
  oi_tipo_persona           char(1)      null,
  oi_razon_social           varchar(100) null,
  oi_nombre                 varchar(255) null,
  oi_apellido_paterno       varchar(100) null,
  oi_apellido_materno       varchar(100) null,
  oi_rfc                    varchar(30) null,
  oi_curp                   varchar(30) null,
  oi_fecha_nacimiento       varchar(10)  null,
  oi_direccion              varchar(255) null,
  oi_colonia                varchar(255) null,
  oi_ciudad_poblacion       varchar(255) null,
  oi_telefonos              varchar(255) null,
  oi_actividad_economica    varchar(255) null,
  oi_agente                 varchar(50)  null,
  oi_agente_apellido_pat    varchar(50)  null,
  oi_agente_apellido_mat    varchar(50)  null,
  oi_agente_rfc             varchar(50)  null,
  oi_agente_curp            varchar(50)  null,
  oi_personas_relacionadas  varchar(2)   null,
  oi_contrato_relacionado   varchar(20)  null,
  oi_nombre_titular_rel     varchar(100) null, 
  oi_apellido_paterno_rel   varchar(100) null,
  oi_apellido_materno_rel   varchar(100) null,
  oi_descripcion            varchar(255) null,
  oi_razon                  varchar(255) null,
  oi_sucursal               int          null,
  oi_clave                  varchar(30)  null,
  oi_comentario             varchar(500) null,
  oi_monto_alerta           varchar(20)  null,
  oi_fecha_consulta         varchar(10)  null
)


TRUNCATE TABLE sb_reporte_ope_inusuales
--Se llena tabla temporal regla de negocio

/*INSERT INTO @temp_reglas_negocio
select  
      'monto_riesgo_ini'    = cr_etiqueta.cr_min_value,   
      'monto_riesgo_hasta'  = cr_etiqueta.cr_max_value,
      'operador_moneda'     = cr_2.cr_operator, 
      'moneda'              = cr_2.cr_max_value,
      'periodo'             = cr_3.cr_max_value,
      'etiqueta'            = cr_4.cr_max_value  ,
      'tipo_alerta'         = cr_5.cr_max_value  ,
      'tipo_operacion'      = cr_6.cr_max_value  ,
      'nivel_riesgo'        = cr_7.cr_max_value  
from cob_pac..bpl_rule r

        inner join cob_pac..bpl_rule_version rv on rv.rl_id = r.rl_id
        
        inner join cob_pac..bpl_condition_rule cr_etiqueta on rv.rv_id = cr_etiqueta.rv_id and cr_etiqueta.cr_parent is null
        
        inner join cob_workflow..wf_variable v_cr_etiqueta on v_cr_etiqueta.vb_codigo_variable = cr_etiqueta.vd_id
        
        inner join cob_pac..bpl_condition_rule cr_2 on rv.rv_id = cr_2.rv_id and cr_2.cr_parent = cr_etiqueta.cr_id
        
        inner join cob_workflow..wf_variable v_2 on v_2.vb_codigo_variable = cr_2.vd_id
        
        inner join cob_pac..bpl_condition_rule cr_3 on rv.rv_id = cr_3.rv_id and cr_3.cr_parent = cr_2.cr_id
        
        inner join cob_workflow..wf_variable v_3 on v_3.vb_codigo_variable = cr_3.vd_id
        inner join cob_pac..bpl_condition_rule cr_4 on rv.rv_id = cr_4.rv_id and cr_4.cr_parent = cr_3.cr_id
        
        inner join cob_workflow..wf_variable v_4 on v_4.vb_codigo_variable = cr_4.vd_id
        inner join cob_pac..bpl_condition_rule cr_5 on rv.rv_id = cr_5.rv_id and cr_5.cr_parent = cr_4.cr_id
        
        inner join cob_workflow..wf_variable v_5 on v_5.vb_codigo_variable = cr_5.vd_id
        inner join cob_pac..bpl_condition_rule cr_6 on rv.rv_id = cr_6.rv_id and cr_6.cr_parent = cr_5.cr_id
        
        inner join cob_workflow..wf_variable v_6 on v_6.vb_codigo_variable = cr_6.vd_id
        inner join cob_pac..bpl_condition_rule cr_7 on rv.rv_id = cr_7.rv_id and cr_7.cr_parent = cr_6.cr_id
        
        inner join cob_workflow..wf_variable v_7 on v_7.vb_codigo_variable = cr_7.vd_id
        
        where rl_acronym = 'REGNEGOCIO' and rv.rv_status = 'PRO'

*/
insert into #tmp_operaciones_inusuales (
       oi_codigo_cliente       , --1
       oi_tipo_reporte         , --2
       oi_periodo_reporte      , --3
       oi_organo_supervisor    , --4
       oi_clave_sujeto         , --5
       oi_contrato             , --6
       oi_tipo_operacion       , --7
       oi_instrumento_monetario, --8
       oi_monto                , --9
       oi_fecha_operacion      , --10
       oi_fecha_deteccion      , --11
       oi_razon_social         , --12
	   oi_nombre               , --13  
       oi_agente               , --14
       oi_agente_apellido_pat  , --15
       oi_agente_apellido_mat  , --16
       oi_agente_rfc           , --17
       oi_agente_curp          , --18
       oi_sucursal             , --19
       oi_clave                , --20
       oi_comentario           , --21
       oi_monto_alerta         , --22
       oi_fecha_consulta       , --23
       oi_moneda               , --24
       oi_rfc                  , --25,
       oi_curp                 , --26,
       oi_apellido_paterno     , --27
       oi_apellido_materno       --28
       
       )   
select ar_ente              , --1
       case when ar_tipo_lista = 'R' then  '1'
            when ar_tipo_lista = 'I' then  '2'
            when ar_tipo_lista = 'IP' then '3'
       end   ,   --2
       case when ar_tipo_lista <> 'R' then 
            convert(varchar(10)  ,@w_periodo,112)       
       else
            substring(@w_periodo,1,6)  
       end                  , --3
       ''                   , --4	                              
       ''                   , --5
       ar_contrato          , --6
       case when (ar_etiqueta) IS NOT null then 
       
             '09'
                 
       else
             ' '
       END ,                                         --7 
       case when (ar_etiqueta) IS NOT null then 
       
             '01'
                 
       else
             ' '
       end                  ,                         --8              
       ar_monto             ,                         --9
       convert(varchar(10)  ,ar_fecha_operacion,112), --10
       case when ar_tipo_lista <> 'R' then 
            convert(varchar(10)  ,ar_fecha_alerta,112)       
       else
            null
       end                  ,                         --11
       ''                   ,                         --12
       case when ar_codigo is NOT null  then
           ( SELECT isnull(oin_nombre_rep,'') +' '+isnull(oin_s_nombre_rep,'') FROM cobis..cl_operaciones_inusuales
             WHERE oin_codigo=ar_codigo)
	    else
	        ar_nombre
	    end
                            ,--13
       'NA'                 ,--14
	   'NA'                 ,--15
       'NA'                 ,--16
       'NA'                 ,--17
       'NA'                 ,--18
       ar_sucursal          ,--19
       
       case when ar_tipo_lista = 'I' then  @w_member_code
            when ar_tipo_lista = 'IP' then @w_member_code
       end  ,--20
       case when ar_escenario is null or len(ar_escenario) =0 then
            ar_observaciones
	   else
	        ar_escenario
	   end                                         ,--21
       convert(varchar,ar_monto)                   ,--22
       convert(varchar(10)  ,ar_fecha_consulta,112),--23
       ' ',                                         --24
        ar_rfc,                                     --25
        ar_rfc,                                     --26
        case when ar_codigo is NOT NULL  THEN
          (SELECT isnull(oin_apellido_rep,'XXXX') 
            FROM cobis..cl_operaciones_inusuales
            WHERE oin_codigo=ar_codigo
          )
             
	    else
	        ' '
	    end ,
	    case when ar_codigo is NOT null  then
          (SELECT isnull(oin_s_apellido_rep,'XXXX') 
            FROM cobis..cl_operaciones_inusuales
            WHERE oin_codigo=ar_codigo
           )
	    else
	        ' '
	    end                
from cobis..cl_alertas_riesgo
where ar_id_alerta      = isnull(@i_param3,ar_id_alerta) 
    and ar_fecha_alerta = isnull(@i_param1,ar_fecha_alerta)
	and ar_status<>'BA'
      --ar_tipo_lista = isnull(@i_param2,ar_tipo_lista) FECHA
      --and ar_fecha_consulta = @w_periodo

update #tmp_operaciones_inusuales
   set oi_folio               = replicate ('0',6 -len(convert(varchar,oi_secuencial))) +  convert(varchar,oi_secuencial),
       oi_comentario          = replace(replace(replace(oi_comentario, ';',','), char(13), ' '), char(10), ' ')
	   

update #tmp_operaciones_inusuales
set oi_nombre              = isnull(en_nombre,'') + ' ' +isnull(p_s_nombre,''),
    oi_apellido_paterno    = isnull(p_p_apellido,'XXXX')             ,
    oi_apellido_materno    = isnull(p_s_apellido,'XXXX')             ,
    oi_rfc                 = en_nit                              ,
    oi_curp                = en_ced_ruc                          ,
    oi_fecha_nacimiento    = convert(varchar(10),p_fecha_nac,112),
    oi_nacionalidad        = (select c.valor
                               from cobis..cl_tabla    t,
                                    cobis..cl_catalogo c
                               where t.tabla  = 'cl_nacionalidad'
                               and   t.codigo = c.tabla    
                               and   c.codigo = en_nac_aux),
    oi_actividad_economica = (select isnull(ac_descripcion,' ') 
                              from cobis..cl_negocio_cliente,
                                   cobis..cl_actividad_ec 
                              where nc_ente      = en_ente 
                              and nc_actividad_ec= ac_codigo 
                              and nc_estado_reg  ='V' 
                              and nc_codigo      =(select isnull(min(nc_codigo),0)
                                                   from cobis..cl_negocio_cliente 
                                                   where nc_ente=en_ente 
                                                   and nc_estado_reg='V')
                                                  ),
   oi_tipo_persona        = case when en_subtipo = 'P' then
                                 '1'
                            else
                                 '2'
                            end
from cobis..cl_ente
where oi_codigo_cliente = en_ente

update #tmp_operaciones_inusuales
set oi_localidad = cl.valor 
FROM 
cobis..cl_tabla tb,
cobis..cl_catalogo cl
where tb.codigo=cl.tabla
and tb.tabla='cl_oficina'
AND cl.codigo=oi_sucursal
AND oi_monto >0

update #tmp_operaciones_inusuales
set oi_codigo_postal    = c.valor
from cobis..cl_tabla    t,
     cobis..cl_catalogo c
where t.tabla  = 'cl_codigo_postal_suc'
and   t.codigo = c.tabla     
and   c.codigo = convert(varchar(10), oi_sucursal)
AND oi_monto >0

update #tmp_operaciones_inusuales
set  oi_moneda    = (select mo_nemonico
                    from cobis..cl_moneda
                    where mo_moneda = OP.op_moneda)
from cob_cartera..ca_operacion OP
where oi_contrato  = op_banco 
AND oi_monto >0


/*update #tmp_operaciones_inusuales
set oi_codigo_postal    = c.valor
from cobis..cl_tabla    t,
     cobis..cl_catalogo c
where t.tabla  = 'cl_codigo_postal_suc'
and   t.codigo = c.tabla     
and   c.codigo = convert(varchar(10), oi_sucursal)
*/

update #tmp_operaciones_inusuales set
oi_direccion        = rtrim(di_calle + ' ' + convert(varchar(50),di_nro) + ' - ' + convert(varchar(50),di_nro_interno) + '-' + di_codpostal),
oi_colonia          = (select pq_descripcion
                       from cobis..cl_parroquia
                       where pq_parroquia = di_parroquia),
oi_ciudad_poblacion =  di_poblacion
from cobis..cl_direccion
where di_ente      = oi_codigo_cliente
AND di_principal='S' 
and   di_direccion = (select min(di_direccion) 
                      from cobis..cl_direccion 
                      where di_ente = oi_codigo_cliente
                      AND di_principal='S')--Direccion Principal
                      
--PRINT'#tmp_operaciones_inusuales1'
                      
--SELECT * FROM  #tmp_operaciones_inusuales
insert into #tmp_telefonos
( te_cliente    ,
  te_telefono   )
SELECT DISTINCT  te_ente,
       te_valor
FROM #tmp_operaciones_inusuales,cobis..cl_direccion,cobis..cl_telefono 
WHERE  di_ente=oi_codigo_cliente
AND   te_ente=di_ente 
AND di_direccion=te_direccion
and di_principal='S'
AND oi_codigo_cliente=te_ente
and   di_direccion =(select min(di_direccion) 
                      from cobis..cl_direccion 
                      where di_ente = te_ente
                      AND di_principal='S')
 order by te_ente
PRINT'telefonos'

SELECT * from #tmp_telefonos

select @w_secuencial = 0,
       @w_telefono   = '' , 
       @w_cliente_ant=0     

while 1 = 1
begin
      select top 1
             @w_aux_telefono = te_telefono,
             @w_cliente      = te_cliente ,
             @w_secuencial   = te_secuencial
      from #tmp_telefonos
      where te_secuencial> @w_secuencial
      
      if @@rowcount = 0
          break
      
      if @w_cliente <> @w_cliente_ant
      begin
          if @w_telefono <> ''
          begin
               update #tmp_operaciones_inusuales
               set  oi_telefonos = @w_telefono
               where oi_codigo_cliente = @w_cliente_ant
          end     
          
          select @w_telefono    = '',     
                 @w_cliente_ant = @w_cliente
      end
       
      if @w_telefono = '' 
         select @w_telefono = @w_aux_telefono
      else
         if len(@w_telefono + @w_aux_telefono)<= 255 
            select @w_telefono = @w_telefono+'/'+@w_aux_telefono                                        
end

  
SELECT oi_telefonos,* FROM #tmp_operaciones_inusuales
/* ENTRAR BORRANDO LA TABLA DE TRABAJO */

insert into sb_reporte_ope_inusuales (oi_cadena)
      values('TIPO DE REPORTE'          + @w_separador +
             'PERIODO DEL REPORTE'      + @w_separador +
             'FOLIO'                    + @w_separador +
             'ORGANO SUPERVISOR'        + @w_separador +
             'CLAVE DEL SUJETO OBLIGADO'+ @w_separador +
             'LOCALIDAD'                + @w_separador +
             'SUCURSAL'                 + @w_separador +
             'TIPO DE OPERACION'        + @w_separador +
             'INSTRUMENTO MONETARIO'    + @w_separador +
             'NUMERO DE CUENTA, CONTRATO, OPERACION, POLIZA O NUMERO DE SEGURIDAD SOCIAL'         + @w_separador +
             'MONTO'                    + @w_separador +
             'MONEDA'                      + @w_separador +
             'FECHA DE LA OPERACION'       + @w_separador +
             'FECHA DE DETECCION DE LA OPERACION'          + @w_separador +
             'PAIS DE NACIONALIDAD'        + @w_separador +
             'TIPO DE PERSONA'             + @w_separador + 
             'RAZON SOCIAL O DENOMINACION' + @w_separador + 
             'NOMBRE'                      + @w_separador + 
             'APELLIDO PATERNO'            + @w_separador + 
             'APELLIDO MATERNO'            + @w_separador + 
             'RFC'                         + @w_separador + 
             'CURP'                        + @w_separador +  
             'FECHA DE NACIMIENTO O CONSTITUCION'         + @w_separador + 
             'DOMICILIO'                   + @w_separador +  
             'COLONIA'                     + @w_separador +   
             'CIUDAD O POBLACION'          + @w_separador +     
             'TELEFONO OFICINA/PARTICULAR' + @w_separador + 
             'ACTIVIDAD ECONOMICA'         + @w_separador +  
             'AGENTE O APODERADO'          + @w_separador +
             'APELLIDO PATERNO**'          + @w_separador +  
             'APELLIDO MATERNO**'          + @w_separador + 
             'RFC **'                      + @w_separador + 
             'CURP **'                     + @w_separador + 
             'CONSECUTIVO DE CUENTAS Y/O PERSONAS RELACIONADAS **'+ @w_separador + 
             'NUMERO DE CUENTA, CONTRATO, OPERACIÓN, POLIZA O NUMERO DE SEGURIDAD SOCIAL *'+ @w_separador + 
             'CLAVE DEL SUJETO OBLIGADO'   + @w_separador + 
             'NOMBRE DEL TITULAR DE LA CUENTA O DE LA PERSONA RELACIONADA' + @w_separador + 
             'APELLIDO PATERNO *'          + @w_separador + 
             'APELLIDO MATERNO *'          + @w_separador + 
             'DESCRIPCION DE LA OPERACIÓN *'+ @w_separador + 
             'RAZONES POR LAS QUE EL ACTO U OPERACION SE CONSIDERA'
             )
             
             
insert into sb_reporte_ope_inusuales --(oi_cadena)             
select isnull(oi_tipo_reporte,' ')              + @w_separador +  
       isnull(oi_periodo_reporte,' ')           + @w_separador +  
       isnull(oi_folio,' ')                     + @w_separador +  
       isnull(oi_organo_supervisor,' ')         + @w_separador +  
       isnull(oi_clave_sujeto,' ')              + @w_separador +  
       isnull(oi_localidad,' ')                 + @w_separador +  
       isnull(oi_codigo_postal,' ')            + @w_separador +  
       isnull(oi_tipo_operacion,' ')            + @w_separador +  
       isnull(oi_instrumento_monetario,' ')     + @w_separador +  
       isnull(oi_contrato,' ')                  + @w_separador +
       isnull(convert(varchar,oi_monto),' ' )   + @w_separador +
       isnull(oi_moneda,' ')                    + @w_separador +  
       isnull(oi_fecha_operacion,' ')           + @w_separador +  
       isnull(oi_fecha_deteccion ,' ')          + @w_separador +  
       isnull(oi_nacionalidad,' ')              + @w_separador +  
       isnull(oi_tipo_persona,' ')              + @w_separador +  
       isnull(oi_razon_social,' ')              + @w_separador + 
       isnull(oi_nombre,' ')                    + @w_separador + 
       isnull(oi_apellido_paterno,'XXXX')       + @w_separador + 
       isnull(oi_apellido_materno,'XXXX')       + @w_separador +  
       isnull(oi_rfc,' ')                       + @w_separador +  
       isnull(oi_curp,' ')                      + @w_separador +  
       isnull(oi_fecha_nacimiento,' ')          + @w_separador +  
       isnull(oi_direccion,' ')                 + @w_separador +  
       isnull(oi_colonia,' ')                   + @w_separador +  
       isnull(oi_ciudad_poblacion,' ')          + @w_separador +  
       isnull(oi_telefonos,' ')                 + @w_separador +  
       isnull(oi_actividad_economica,' ')       + @w_separador +  
       isnull(oi_agente,' ')                    + @w_separador +  
       isnull(oi_agente_apellido_pat,' ')       + @w_separador +  
       isnull(oi_agente_apellido_mat,' ')       + @w_separador +  
       isnull(oi_agente_rfc,' ')                + @w_separador +  
       isnull(oi_agente_curp,' ')               + @w_separador + 
       ' '                                      + @w_separador + --CONSECUTIVO DE CUENTAS Y/O PERSONAS RELACIONADAS **
       ' '                                      + @w_separador + --NUMERO DE CUENTA, CONTRATO, OPERACIÓN, POLIZA O NUMERO DE SEGURIDAD SOCIAL *
       isnull(oi_clave,' ')                     + @w_separador + --CLAVE DEL SUJETO OBLIGADO
       ' '                                      + @w_separador + --NOMBRE DEL TITULAR DE LA CUENTA O DE LA PERSONA RELACIONADA  
       ' '                                      + @w_separador + --APELLIDO PATERNO * 
       ' '                                      + @w_separador + --APELLIDO MATERNO *
       'Periodo Deteccion: ' + isnull( oi_fecha_deteccion ,' ' ) + @w_separador +             
       isnull(replace(oi_comentario,CHAR(10),' ') ,' ') 
from #tmp_operaciones_inusuales 

SELECT * FROM sb_reporte_ope_inusuales
  -- ------------------------------------------------------------------------------------
  -- ------------------------------------------------------------------------------------
  -- ACTUALIZACION DE LA FECHA DE PROCESADO - FIN
  -- ------------------------------------------------------------------------------------

if @@error != 0
begin
    select @w_error = 710002
    goto ERROR_PROCESO
end

select @w_path = ba_path_destino,
       @w_path_obj = ba_path_fuente
from cobis..ba_batch
where ba_batch = 36007

select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'

SELECT @w_ruta_alertas=pa_char FROM cobis..cl_parametro WHERE pa_nemonico='RALERT' AND pa_producto = 'CRE'

if(@i_param2 is not null)--cuando se ejecuta por bacth
BEGIN
SELECT @w_ruta_alertas
SET    @w_id_alerta_varchar=rtrim(convert(VARCHAR,'0'))
SELECT @w_id_alerta_final=replicate ('0', 6-len(@w_id_alerta_varchar)) + @w_id_alerta_varchar

  select @w_comando = 'bcp "select oi_cadena from cob_conta_super..sb_reporte_ope_inusuales order by oi_id" queryout '
  select @w_destino  = @w_path + @w_nombre_repo +@w_id_alerta_final+ @w_periodo + '.txt',
         @w_errores  = @w_path + @w_nombre_repo +@w_id_alerta_final+ @w_periodo + '.err'
  select @w_comando = @w_comando + @w_destino + ' -b5000 -c' + @w_s_app + 's_app.ini -r \n -T -e' + @w_errores
  --Ejecucion para Generar Archivo Datos
  exec @w_error = xp_cmdshell @w_comando
  -- comienza copiado de archivo a la ruta
  select @w_comando = 'copy ' + @w_path + @w_nombre_repo +@w_id_alerta_final + @w_periodo + '.txt' + ' + ' + @w_ruta_alertas + @w_nombre_repo +@w_id_alerta_final + @w_periodo + '.txt'  +  ' ' + @w_ruta_alertas
  select @w_comando
  exec @w_error = xp_cmdshell @w_comando
  if @w_error <> 0 begin
     select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
     goto ERROR_PROCESO
  END
  
if @w_error = 0 begin
select @w_comando = 'bcp  "select oi_cadena from cob_conta_super..sb_reporte_ope_inusuales order by oi_id" queryout '
    select @w_destino  = @w_path + @w_nombre_repo +@w_id_alerta_final+ @w_periodo + '.csv',
           @w_errores  = @w_path + @w_nombre_repo +@w_id_alerta_final+ @w_periodo + '_csv.err'
 select @w_comando = @w_comando + @w_destino + ' -b5000 -c' + @w_s_app + 's_app.ini -r \n -T -e' + @w_errores

--Ejecucion para Generar Archivo Datos
  exec @w_error = xp_cmdshell @w_comando
  if @w_error <> 0 begin
     select @w_msg = 'ERROR EN EJECUCION ' + @w_comando
     exec cob_conta_super..sp_errorlog
     @i_fecha_fin     = @i_param1,
     @i_fuente        = @w_sp_name,
     @i_origen_error  = '28016',
     @i_descrp_error  = @w_msg
     return 1
  END
    select @w_comando = 'copy ' + @w_path + @w_nombre_repo + @w_id_alerta_final + @w_periodo + '.csv' + ' + ' + @w_ruta_alertas + @w_nombre_repo + @w_id_alerta_final + @w_periodo + '.csv'  +  ' ' + @w_ruta_alertas
  select @w_comando
  exec @w_error = xp_cmdshell @w_comando
  if @w_error <> 0 begin
     select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
     goto ERROR_PROCESO
  END
end
else
begin
     select @w_msg = 'ERROR EN EJECUCION ' + @w_comando
     exec cob_conta_super..sp_errorlog
     @i_fecha_fin     = @i_param1,
     @i_fuente        = @w_sp_name,
     @i_origen_error  = '28016',
     @i_descrp_error  = @w_msg
     return 1
  end
 end
 
 if(@i_param3 is not null)--cuando se ejecuta por FE
BEGIN
SELECT @w_ruta_alertas
SET @w_id_alerta_varchar=rtrim(convert(VARCHAR,@i_param3))
SELECT @w_id_alerta_final=replicate ('0', 6-len(@w_id_alerta_varchar)) + @w_id_alerta_varchar

  select @w_comando = 'bcp "select oi_cadena from cob_conta_super..sb_reporte_ope_inusuales order by oi_id" queryout '
  select @w_destino  = @w_path + @w_nombre_repo + @w_id_alerta_final + @w_periodo + '.txt',
         @w_errores  = @w_path + @w_nombre_repo + @w_id_alerta_final + @w_periodo + '.err'
  select @w_comando = @w_comando + @w_destino + ' -b5000 -c' + @w_s_app + 's_app.ini -r \n -T -e' + @w_errores
  --Ejecucion para Generar Archivo Datos
  exec @w_error = xp_cmdshell @w_comando
  
select @w_comando = 'copy ' + @w_path + @w_nombre_repo + @w_id_alerta_final + @w_periodo + '.txt' + ' + ' + @w_ruta_alertas + @w_nombre_repo + @w_id_alerta_final + @w_periodo + '.txt'  +  ' ' + @w_ruta_alertas

select @w_comando
exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
   goto ERROR_PROCESO
END
  /*if @w_error <> 0 begin
     select @w_msg = 'ERROR EN EJECUCION ' + @w_comando
     exec cob_conta_super..sp_errorlog
     @i_fecha_fin     = @i_param1,
     @i_fuente        = @w_sp_name,
     @i_origen_error  = '28016',
     @i_descrp_error  = @w_msg
     return 1
  end*/

if @w_error = 0 begin
select @w_comando = 'bcp  "select oi_cadena from cob_conta_super..sb_reporte_ope_inusuales order by oi_id" queryout '
    select @w_destino  = @w_path + @w_nombre_repo + @w_id_alerta_final + @w_periodo + '.csv',
           @w_errores  = @w_path + @w_nombre_repo + @w_id_alerta_final + @w_periodo + '_csv.err'
 select @w_comando = @w_comando + @w_destino + ' -b5000 -c' + @w_s_app + 's_app.ini -r \n -T -e' + @w_errores

--Ejecucion para Generar Archivo Datos
  exec @w_error = xp_cmdshell @w_comando
  if @w_error <> 0 begin
     select @w_msg = 'ERROR EN EJECUCION ' + @w_comando
     exec cob_conta_super..sp_errorlog
     @i_fecha_fin     = @i_param1,
     @i_fuente        = @w_sp_name,
     @i_origen_error  = '28016',
     @i_descrp_error  = @w_msg
   return 1
  END
  
  select @w_comando = 'copy ' + @w_path + @w_nombre_repo + @w_id_alerta_final + @w_periodo + '.csv' + ' + ' + @w_ruta_alertas + @w_nombre_repo + @w_id_alerta_final + @w_periodo + '.csv'  +  ' ' + @w_ruta_alertas

select @w_comando
exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
   goto ERROR_PROCESO
END
end
else
begin
     select @w_msg = 'ERROR EN EJECUCION ' + @w_comando
     exec cob_conta_super..sp_errorlog
     @i_fecha_fin     = @i_param1,
     @i_fuente        = @w_sp_name,
     @i_origen_error  = '28016',
     @i_descrp_error  = @w_msg
     return 1
  end
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