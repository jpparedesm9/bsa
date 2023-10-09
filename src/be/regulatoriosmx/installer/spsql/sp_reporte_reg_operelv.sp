/************************************************************************/
/*      Archivo:                reporte_reg_ope_relavantes.sp           */
/*      Stored procedure:       sp_reporte_reg_operelv                  */
/*      Base de datos:          cob_conta_super                         */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:                                                   */
/*      Fecha de escritura:                                             */
/************************************************************************/
/*                               IMPORTANTE                             */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por  escrito de COBISCorp.    */
/*  Este programa esta  protegido  por la ley de   derechos de autor    */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a COBISCorp para    */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Archivo Reporte de Traslado Masivo de Oficinas                  */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA         AUTOR              RAZON                            */
/*  08/09/2016   Karen Meza         Migración a CEN                     */
/************************************************************************/


use cob_conta_super
go

if exists (select 1 from sysobjects where name = 'sp_reporte_reg_operelv')
   drop proc sp_reporte_reg_operelv
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

create proc sp_reporte_reg_operelv (
@t_show_version  bit = 0,
@i_param1        int , --tipo de reporte
@i_param2        datetime 
)
as
declare
@w_operacion int,
@w_codigo   int,
@w_folio  int,
@w_consecutivo char(2),
@w_cabecera                 varchar(2500),
@w_nom_tabla                varchar(100),
@w_comando                  varchar(2500),
@w_fecha_proc               datetime,
@w_path_destino             varchar(30),
@w_cmd                      varchar(2500),
@w_anio                     varchar(4),
@w_mes                      varchar(2),
@w_dia                      varchar(2),
@w_fecha1                   varchar(10),
@w_fecha_proceso            datetime,
@w_fecha_traslado           datetime,
@w_fecha_ini                datetime,
@w_dias                     int,
/* param propios de bcp*/
@w_msg                      descripcion,
@w_sp_name                  varchar(20),
@w_s_app                    varchar(255),
@w_path                     varchar(255),
@w_nombre                   varchar(255),
@w_nombre_cab               varchar(255),
@w_destino                  varchar(2500),
@w_errores                  varchar(1500),
@w_error                    int,
@w_supervisor               varchar(12),
@w_sujeto                   varchar(12),
@w_nombre_plano             varchar(2500),
@w_nacionalidad             CHAR(4),
@w_nombre_cab1              varchar(12),
@w_nombre_cab2              varchar(12)

if @t_show_version = 1
begin
    print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end


select @w_codigo = codigo from cobis..cl_tabla 
 where tabla = 'sb_causa_reportado'
 
 select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso
  --FOLIIO
 select @w_folio = 1 
  --ORGANO SUPERVISOR
select @w_supervisor = REPLACE(pa_char,'-','')
FROM   cobis..cl_parametro 
WHERE  pa_nemonico  ='COS'
and    pa_producto  ='REC'
 --CLAVE_DEL_SUJETO
select @w_sujeto     =  REPLACE(pa_char,'-','')
FROM   cobis..cl_parametro 
WHERE  pa_nemonico='CSO' 
and    pa_producto  ='ADM'      
 
--CONSECUTIVO DE CUENTAS
select @w_consecutivo = '01'

/*** VALIDACION DE PARAMETROS DE ENTRADA ***/
if @i_param1 = ''
begin
   select
   @w_error = 2902799,
   @w_msg   = 'EL PARAMETRO TIPO DE OPERACION ES OBLIGATORIO'
   goto ERRORFIN
end
else
 SELECT @w_operacion = @i_param1 
 
 truncate table sb_reporte_operacrelev
 
--OPERACIONES PREOCUPANTE E INUSUALES
if @w_operacion = 2 or @w_operacion = 3  
begin
print 'ingresa al reporte'
     insert into sb_reporte_operacrelev(
	  Tipo_reporte           ,Periodo_reporte      , Folio ,              Organo_supervisor,   Clave_sujobl,        
      Sucursal,              Tipo_operacion,      Inst_monetario   ,Numero_cuenta,       Monto ,Moneda,                
	  Fecha_operacion,       Fecha_det_operacion,   Consecutivo_cuentas, Num_cuenta         , clave_sujeto,           
	  Descrip_operacion
	  )                 
	  
	  select  @w_operacion,                                                                                     --TIPO DE REPORTE 
	  convert(varchar(12),dt_fecha,112),                                                                      --PERIODO DEL REPORTE
	 RIGHT('00000'+ISNULL(convert(varchar(12),row_number() OVER (ORDER BY dt_fecha ASC) ),''),6) ,            ---FOLIO 
     -- convert(varchar(12),row_number() OVER (ORDER BY a.dt_fecha ASC)),	 
	  @w_supervisor ,                                                                                           --ORGANO SUPERVISOR
	  @w_sujeto ,                                                                                               --CLAVE_DEL_SUJETO
	  dt_oficina,	 	                                                                                        --SUCURSAL
	 (SELECT eq_valor_cat FROM sb_equivalencias WHERE eq_valor_arch = dt_tipo_trans  AND eq_catalogo = 'TIPTRNSREP'),     --TIPO TRANSACCION	  
	 (SELECT eq_valor_cat FROM sb_equivalencias                                                                           --INSTRUMENTO_MONETARIO
                                WHERE eq_descripcion = (SELECT dd_concepto FROM sb_dato_transaccion_det 
                                                         WHERE dt_banco = dd_banco
                                                         and ct_secuencial_det = dd_secuencial
                                                         AND dd_concepto <> 'CAP'
                                                         and dd_monto = (SELECT max(dd_monto) FROM sb_dato_transaccion_det
                                                         WHERE dt_banco = dd_banco
                                                         and ct_secuencial_det = dd_secuencial
                                                         AND dd_concepto <> 'CAP')) 
                                                         AND eq_catalogo = 'INSTMONET'),
	 	                                                                                                 
	  dd_banco,                                                                                                 --NUEMERO_CUENTA
	  dd_monto ,                                                                                                --MONTO
	  dd_moneda,                                                                                                --MONEDA
	  convert(varchar(12),dt_fecha,112),                                                                      --FECHA_OPERACION
	  convert(varchar(12),dt_fecha_trans,112),                                                                --FECHA_DETECCION_OPERACION                                                                                      
                                                                                                        --TELEFONO
   --AGENTE O APODERADO DE SEGUROS Y/O FIANZAS SOLO APLICA A PERSONA NATURALES           
    @w_consecutivo,                                                                                              --CONSECUTIVO DE CUENTAS
    dp_banco,                                                                                                    --NUMERO DE CUENTA
    null,                                                                                                        --CLAVE DEL SUJETO OBLIGADO
    ct_descripcion                                                                                                  --DESCRIPCION_OPERACION 
  from sb_dato_transaccion,        
       sb_dato_transaccion_det,  
       sb_dato_pasivas,             
       sb_consulta_transacciones, 
       sb_dato_deudores
WHERE dt_banco = dd_banco
AND   dt_banco = dp_banco
AND   dt_banco = ct_cuenta
AND   dt_banco = de_banco 
AND   dp_cliente = ct_ente
AND   dp_cliente = de_cliente
AND   dt_aplicativo = dd_aplicativo
AND   dt_aplicativo = dp_aplicativo
AND   dt_aplicativo = ct_aplicativo                 
AND   dt_aplicativo = de_aplicativo
AND   dt_toperacion = dd_toperacion
AND   dt_toperacion = dp_toperacion
AND   dt_toperacion = de_toperacion
and   dt_secuencial = dd_secuencial
and   dd_fecha     = dt_fecha_trans
AND   ct_causa = 'OPRE'
AND   ct_secuencial_det = dd_secuencial
AND   ct_secuencial_det = dt_secuencial
and  ((dp_fecha                            = @i_param2) 
    or (dp_fecha=(select max(dp_fecha) from sb_dato_pasivas where dp_banco=dd_banco)))
and ((de_fecha                            = @i_param2) 
    or (de_fecha=(select max(de_fecha) from sb_dato_deudores where de_banco=dd_banco)))
AND dd_concepto = 'CAP'
	 	 
end	    
 
 --OPERACIONES RELEVANTES
 else
  begin   
	insert into sb_reporte_operacrelev(
	      Tipo_reporte           ,Periodo_reporte      , Folio ,              Organo_supervisor,   Clave_sujobl,        
          Sucursal               ,Tipo_operacion,      Inst_monetario   ,      Numero_cuenta,       Monto ,
		  Moneda                ,Fecha_operacion,       Fecha_det_operacion,   Consecutivo_cuentas, Num_cuenta,        
		  clave_sujeto          ,Descrip_operacion
	  ) 
	 
	  select  @w_operacion,                                                                                         --TIPO DE REPORTE 
	  datepart(year,dt_fecha)+ datepart(month,dt_fecha),                                                        --PERIODO DEL REPORTE
	  RIGHT('00000'+ISNULL(convert(varchar(12),row_number() OVER (ORDER BY dt_fecha ASC) ),''),6),                 --FOLIO                             
	  @w_supervisor,                                                                                                --ORGANO SUPERVISOR
	  @w_sujeto    ,                                                                                                --CLAVE_DEL_SUJETO
	  dt_oficina,                                                                                                  --SUCURSAL
	(SELECT eq_valor_cat FROM sb_equivalencias WHERE eq_valor_arch = dt_tipo_trans  AND eq_catalogo = 'TIPTRNSREP'), --TIPO TRANSACCION
	 (SELECT eq_valor_cat FROM sb_equivalencias                                                                           --INSTRUMENTO_MONETARIO
                                WHERE eq_descripcion = (SELECT dd_concepto FROM sb_dato_transaccion_det 
                                                         WHERE dt_banco = dd_banco
                                                         and ct_secuencial_det = dd_secuencial
                                                         AND dd_concepto <> 'CAP'
                                                         and dd_monto = (SELECT max(dd_monto) FROM sb_dato_transaccion_det
                                                         WHERE dt_banco = dd_banco
                                                         and ct_secuencial_det = dd_secuencial
                                                         AND dd_concepto <> 'CAP')) 
                                                         AND eq_catalogo = 'INSTMONET'), 
	 dd_banco,                                                                                                     --NUEMERO_CUENTA
	 dd_monto ,                                                                                                     --MONTO
	  dd_moneda,                                                                                                    --MONEDA
	convert(varchar(12), dt_fecha,112),                                                                           --FECHA_OPERACION
	  null,                                                                                                         --FECHA DE DETECCION DE LA OPERACION
                                                                                                           --TELEFONO
	 NULL,                                                                                                          --CONSECUTIVO DE CUENTAS
	 NULL,                                                                                                           --NUMERO DE CUENTA   
	 null,                                                                                                           --CLAVE DEL SUJETO OBLIGADO                                                                                                             
    ct_descripcion                                                                                                   --DESCRIPCION_OPERACION 
FROM sb_dato_transaccion,        
       sb_dato_transaccion_det,  
       sb_dato_pasivas,             
       sb_consulta_transacciones, 
       sb_dato_deudores
WHERE dt_banco = dd_banco
AND   dt_banco = dp_banco
AND   dt_banco = ct_cuenta
AND   dt_banco = de_banco 
AND   dp_cliente = ct_ente
AND   dp_cliente = de_cliente
AND   dt_aplicativo = dd_aplicativo
AND   dt_aplicativo = dp_aplicativo
AND   dt_aplicativo = ct_aplicativo                 
AND   dt_aplicativo = de_aplicativo
AND   dt_toperacion = dd_toperacion
AND   dt_toperacion = dp_toperacion
AND   dt_toperacion = de_toperacion
and   dt_secuencial = dd_secuencial
and   dd_fecha     = dt_fecha_trans
AND   ct_causa = 'OPRE'
AND   ct_secuencial_det = dd_secuencial
AND   ct_secuencial_det = dt_secuencial
and  ((dp_fecha                            = @i_param2) 
    or (dp_fecha=(select max(dp_fecha) from sb_dato_pasivas where dp_banco=dd_banco)))
and ((de_fecha                            = @i_param2) 
    or (de_fecha=(select max(de_fecha) from sb_dato_deudores where de_banco=dd_banco)))
AND dd_concepto = 'CAP'
	 	 
end  

--LOCALIDAD
UPDATE sb_reporte_operacrelev SET Localidad = (SELECT eq_valor_cat FROM sb_equivalencias where eq_catalogo = 'CODPARRQ' AND eq_valor_arch = ( 
(SELECT DISTINCT dd_parroquia FROM sb_dato_direccion 
WHERE dd_cliente in (SELECT DISTINCT ct_ente 
                                                FROM sb_consulta_transacciones 
                                                WHERE ct_cuenta = Numero_cuenta) 
and ((dd_fecha = @i_param2) 
 or (dd_fecha=(select max(dd_fecha) from sb_dato_direccion 
                                where dd_cliente in 
                                (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones 
                                 WHERE ct_cuenta = Numero_cuenta)))) ) ))

--NACIONALIDAD
 UPDATE sb_reporte_operacrelev SET Nacionalidad =(SELECT CASE dc_pais WHEN  '1' THEN '1' ELSE '2' end FROM sb_dato_cliente WHERE dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
                                                   WHERE ct_cuenta = Numero_cuenta)
                                                   and   ((dc_fecha = @i_param2)
 or (dc_fecha=(select max(dc_fecha) from sb_dato_cliente where dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
 WHERE ct_cuenta = Numero_cuenta))))  )
 --TIPO DE PERSONA
 UPDATE sb_reporte_operacrelev SET Tipo_persona =(SELECT  dc_subtipo FROM sb_dato_cliente WHERE dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
                                                                                                           WHERE ct_cuenta = Numero_cuenta)
                                                                                                            and   ((dc_fecha = @i_param2)

            or (dc_fecha=(select max(dc_fecha) from sb_dato_cliente where dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
            WHERE ct_cuenta = Numero_cuenta))))  )
 
 --RAZON SOCIAL
 
 UPDATE sb_reporte_operacrelev SET Razon_social =(SELECT concat(dc_nombre ,' ' ,dc_p_apellido ,' ' , dc_s_apellido) FROM sb_dato_cliente WHERE dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
                                                                                                           WHERE ct_cuenta = Numero_cuenta)
                                                                                                            and   ((dc_fecha =  @i_param2)

            or (dc_fecha=(select max(dc_fecha) from sb_dato_cliente where dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
            WHERE ct_cuenta = Numero_cuenta))))  )

 --NOMBRE
 UPDATE sb_reporte_operacrelev SET Nombre =(SELECT dc_nombre  FROM sb_dato_cliente WHERE dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
                                                                                                           WHERE ct_cuenta = Numero_cuenta)
                                                                                                            and   ((dc_fecha = @i_param2)

            or (dc_fecha=(select max(dc_fecha) from sb_dato_cliente where dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
            WHERE ct_cuenta = Numero_cuenta))))  )
--APELLIDO PATERNO

UPDATE sb_reporte_operacrelev SET Apellido_paterno =(SELECT case dc_p_apellido WHEN NULL THEN 'xxxx' ELSE dc_p_apellido end   FROM sb_dato_cliente WHERE dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
                                                                                                           WHERE ct_cuenta = Numero_cuenta)
                                                                                                            and   ((dc_fecha = @i_param2)

            or (dc_fecha=(select max(dc_fecha) from sb_dato_cliente where dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
            WHERE ct_cuenta = Numero_cuenta))))  )			
			
--APELLIDO MATERNO
UPDATE sb_reporte_operacrelev SET Apellido_materno =(SELECT case dc_s_apellido WHEN NULL THEN 'xxxx' ELSE dc_s_apellido end   FROM sb_dato_cliente WHERE dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
                                                                                                           WHERE ct_cuenta = Numero_cuenta)
                                                                                                            and   ((dc_fecha = @i_param2)

            or (dc_fecha=(select max(dc_fecha) from sb_dato_cliente where dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
            WHERE ct_cuenta = Numero_cuenta))))  )

--RFC
UPDATE sb_reporte_operacrelev SET RFC =(SELECT case dc_nit WHEN NULL THEN (select REPLACE(dc_ced_ruc,'-','') from sb_dato_cliente where dc_tipo_ced='RFC')
                                                                                            ELSE replace(dc_nit,'-','') end  
                                                                                                        FROM sb_dato_cliente WHERE dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
                                                                                                        WHERE ct_cuenta = Numero_cuenta)
                                                                                                        and   ((dc_fecha = @i_param2)

            or (dc_fecha=(select max(dc_fecha) from sb_dato_cliente where dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
            WHERE ct_cuenta = Numero_cuenta))))  )     
			
--CURP

UPDATE sb_reporte_operacrelev SET CURP =(SELECT dc_ced_ruc  FROM sb_dato_cliente WHERE  dc_tipo_ced='CURP'
                                                                                                AND dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
                                                                                                           WHERE ct_cuenta = Numero_cuenta)
                                                                                                            and   ((dc_fecha = @i_param2)

            or (dc_fecha=(select max(dc_fecha) from sb_dato_cliente where dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
            WHERE ct_cuenta = Numero_cuenta))))  ) 

			--FECHA NACIMIENTO
			
UPDATE sb_reporte_operacrelev SET Fecha_nacm =(SELECT convert(varchar(12),dc_fecha_nac,112)  FROM sb_dato_cliente WHERE dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
                                                                                                           WHERE ct_cuenta = Numero_cuenta)
                                                                                                            and   ((dc_fecha = @i_param2)

            or (dc_fecha=(select max(dc_fecha) from sb_dato_cliente where dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
            WHERE ct_cuenta = Numero_cuenta))))  )
			
--DOMICILIO

UPDATE sb_reporte_operacrelev SET Domicilio =  (SELECT dd_descripcion FROM sb_dato_direccion WHERE dd_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
                                                                                        WHERE ct_cuenta = '702041000157')
                                                                                        and ((dd_fecha = '11/01/2016') 
 or (dd_fecha=(select max(dd_fecha) from sb_dato_direccion where dd_cliente IN 
                                                (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones 
WHERE ct_cuenta = '702041000157')))) 
AND dd_principal = 'S'                           
 )
UPDATE sb_reporte_operacrelev SET Domicilio =  (SELECT TOP 1 dd_descripcion FROM sb_dato_direccion WHERE dd_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
                                                                                        WHERE ct_cuenta = '702041000157')
                                                                                        and ((dd_fecha = '11/01/2016') 
 or (dd_fecha=(select max(dd_fecha) from sb_dato_direccion where dd_cliente IN 
                                                (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones 
WHERE ct_cuenta = '702041000157')))) 
AND dd_principal = 'N'                           

 ) WHERE  Domicilio = NULL		

--CIUDAD
UPDATE sb_reporte_operacrelev SET Ciudad =( SELECT eq_valor_cat FROM sb_equivalencias where eq_catalogo = 'CODCIU' AND eq_valor_arch = (
(SELECT DISTINCT dd_ciudad FROM sb_dato_direccion 
WHERE dd_cliente in (SELECT DISTINCT ct_ente 
                     FROM sb_consulta_transacciones
                     WHERE ct_cuenta = Numero_cuenta)
and ((dd_fecha = @i_param2)
or (dd_fecha=(select max(dd_fecha) from sb_dato_direccion 
                                                where dd_cliente in 
                                                (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
                                                 WHERE ct_cuenta = Numero_cuenta)))))) )
--ACTIVIDAD ECONOMICA

 UPDATE sb_reporte_operacrelev SET Actividad_economica =(SELECT  dc_actividad FROM sb_dato_cliente WHERE dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
                                                                                                           WHERE ct_cuenta = Numero_cuenta)
                                                                                                            and   ((dc_fecha = @i_param2)

            or (dc_fecha=(select max(dc_fecha) from sb_dato_cliente where dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
            WHERE ct_cuenta = Numero_cuenta))))  )
			
--NOMBRE AGENTE  
            
UPDATE sb_reporte_operacrelev SET Nombre_agente =(SELECT case dc_nombre WHEN NULL THEN 'xxxx' ELSE dc_nombre end   FROM sb_dato_cliente WHERE dc_subtipo ='F'
                                                                                                              and dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
                                                                                                           WHERE ct_cuenta = Numero_cuenta)
                                                                                                            and   ((dc_fecha = @i_param2)

            or (dc_fecha=(select max(dc_fecha) from sb_dato_cliente where dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
            WHERE ct_cuenta = Numero_cuenta))))  )
            
--APELLIDO PATERNO AGENTE

UPDATE sb_reporte_operacrelev SET Apellidop_agente =(SELECT case dc_p_apellido WHEN NULL THEN 'xxxx' ELSE dc_p_apellido end   FROM sb_dato_cliente WHERE dc_subtipo ='F'
                                                                                                              and dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
                                                                                                           WHERE ct_cuenta = Numero_cuenta)
                                                                                                            and   ((dc_fecha = @i_param2)

            or (dc_fecha=(select max(dc_fecha) from sb_dato_cliente where dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
            WHERE ct_cuenta = Numero_cuenta))))  )
            
            
--APELLIDO MATERNO AGENTE   


UPDATE sb_reporte_operacrelev SET Apellidom_agente =(SELECT case dc_s_apellido WHEN NULL THEN 'xxxx' ELSE dc_s_apellido end   FROM sb_dato_cliente WHERE dc_subtipo ='F'
                                                                                                              and dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
                                                                                                           WHERE ct_cuenta = Numero_cuenta)
                                                                                                            and   ((dc_fecha = @i_param2)

            or (dc_fecha=(select max(dc_fecha) from sb_dato_cliente where dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
            WHERE ct_cuenta = Numero_cuenta))))  )     

--RFC AGENTE
UPDATE sb_reporte_operacrelev SET RFC_agente =(SELECT case dc_nit WHEN NULL THEN (select REPLACE(dc_ced_ruc,'-','') from sb_dato_cliente where dc_tipo_ced='RFC')
                                                                                            ELSE replace(dc_nit,'-','') end  
                                                                                                        FROM sb_dato_cliente WHERE dc_subtipo='F'
                                                                                                        AND dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
                                                                                                        WHERE ct_cuenta = Numero_cuenta)
                                                                                                        and   ((dc_fecha = @i_param2)

            or (dc_fecha=(select max(dc_fecha) from sb_dato_cliente where dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
            WHERE ct_cuenta = Numero_cuenta))))  )  	

--CURP AGENTE	

 	
UPDATE sb_reporte_operacrelev SET CURP_agente =(SELECT REPLACE(dc_ced_ruc,'-','')                              
                                                FROM sb_dato_cliente WHERE dc_subtipo='F'
                                                AND dc_tipo_ced='CURP'
                                                AND dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
                                                WHERE ct_cuenta = Numero_cuenta)
                                                and   ((dc_fecha =  @i_param2)

            or (dc_fecha=(select max(dc_fecha) from sb_dato_cliente where dc_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones
            WHERE ct_cuenta = Numero_cuenta))))  )   	
--NOMBRE TITULAR

UPDATE sb_reporte_operacrelev SET Nombre_titular =(SELECT isnull(dc_nombre,'xxxx') 
from sb_dato_cliente,sb_dato_deudores 
where dc_cliente= de_cliente 
and de_rol= 'T'
AND de_banco = Numero_cuenta
and ((dc_fecha =  @i_param2)
or (dc_fecha=(select max(dc_fecha) from sb_dato_cliente where dc_cliente=de_cliente)))
                                                       AND ((de_fecha =  @i_param2)
OR (de_fecha = (select max(dc_fecha) from sb_dato_cliente where dc_cliente=de_cliente)))) 

--APELLIDO PATERNO TITULAR
 			
UPDATE sb_reporte_operacrelev SET Apellidop_titular =(SELECT isnull(dc_p_apellido,'xxxx') 
from sb_dato_cliente,sb_dato_deudores 
where dc_cliente= de_cliente 
and de_rol= 'T'
AND de_banco = Numero_cuenta
and ((dc_fecha =  @i_param2)
or (dc_fecha=(select max(dc_fecha) from sb_dato_cliente where dc_cliente=de_cliente)))
                                                       AND ((de_fecha =  @i_param2)
OR (de_fecha = (select max(dc_fecha) from sb_dato_cliente where dc_cliente=de_cliente)))) 
 
--APELLIDO MATERNO TITULAR
 			
UPDATE sb_reporte_operacrelev SET Apellidom_titular =(SELECT isnull(dc_s_apellido,'xxxx') 
from sb_dato_cliente,sb_dato_deudores 
where dc_cliente= de_cliente 
and de_rol= 'T'
AND de_banco = Numero_cuenta
and ((dc_fecha =  @i_param2)
or (dc_fecha=(select max(dc_fecha) from sb_dato_cliente where dc_cliente=de_cliente)))
                                                       AND ((de_fecha =  @i_param2)
OR (de_fecha = (select max(dc_fecha) from sb_dato_cliente where dc_cliente=de_cliente)))) 

--TELEFONO

UPDATE sb_reporte_operacrelev SET Telefono = (SELECT dt_valor FROM sb_dato_telefono 
WHERE dt_cliente  IN (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones WHERE ct_cuenta = Numero_cuenta)
and ((dt_fecha = @i_param2) 
 or (dt_fecha=(select max(dt_fecha) from sb_dato_telefono 
                                where dt_cliente  IN (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones WHERE ct_cuenta = Numero_cuenta)))) 
AND dt_direccion = (SELECT dd_direccion FROM sb_dato_direccion WHERE dd_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones 

                                                                                        WHERE ct_cuenta = Numero_cuenta)

                                                                                        and ((dd_fecha = @i_param2)  
 or (dd_fecha=(select max(dd_fecha) from sb_dato_direccion where dd_cliente IN  
                                                (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones  
                                                  WHERE ct_cuenta = Numero_cuenta))))  
AND dd_principal = 'S'  ))


UPDATE sb_reporte_operacrelev SET Telefono = (SELECT TOP 1 dt_valor FROM sb_dato_telefono 
WHERE dt_cliente  IN (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones WHERE ct_cuenta = Numero_cuenta)
and ((dt_fecha = '11/01/2016') 
 or (dt_fecha=(select max(dt_fecha) from sb_dato_telefono 
                                where dt_cliente  IN (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones WHERE ct_cuenta = Numero_cuenta)))) 
AND dt_direccion = (SELECT dd_direccion FROM sb_dato_direccion WHERE dd_cliente in (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones 

                                                                                        WHERE ct_cuenta = Numero_cuenta)

                                                                                        and ((dd_fecha = '11/01/2016')  
 or (dd_fecha=(select max(dd_fecha) from sb_dato_direccion where dd_cliente IN  
                                                (SELECT DISTINCT ct_ente FROM sb_consulta_transacciones  
                                                  WHERE ct_cuenta = Numero_cuenta))))  
AND dd_principal = 'N'  ))

WHERE Telefono=NULL


	/* Iniciando BCP */
select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'


--Seleccionando el path destino para archivo de salida
select @w_path = pp_path_destino
from   cobis..ba_path_pro
where  pp_producto = 4

----------------------------------------
--Generar Archivo de Cabeceras
----------------------------------------
select
@w_nombre       = 'reporte_opinu_',
@w_nom_tabla    = 'sb_reporte_operacrelev',
@w_nombre_cab   = @w_nombre
--Ejecucion para Generar Archivo Datos
select @w_comando = @w_s_app + 's_app bcp -auto -login cob_conta_super..sb_reporte_operacrelev out '
select
@w_destino  = @w_path + @w_nombre + convert(varchar, datepart(yy, @i_param2)) + right('0'+ convert(varchar,datepart(mm,@i_param2)),2)+ '.csv',
@w_errores  = @w_path + @w_nombre + convert(varchar, datepart(yy, @i_param2)) + right('0'+ convert(varchar,datepart(mm,@i_param2)),2)+ '.err'

select @w_comando = @w_comando + @w_destino + ' -b5000 -c -e' + @w_errores + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0
begin
   select @w_msg = 'Error Generando Archivo Reporte de: '+ @w_nombre,
   @w_error = 2902797

   goto ERRORFIN
end

return 0

ERRORFIN:
exec cob_ahorros..sp_errorlog
@i_fecha        = @i_param2,
@i_error        = @w_error,
@i_usuario      = 'batch',
@i_tran         = 26004,
@i_descripcion  = @w_msg,
@i_programa     = @w_sp_name

return @w_error

go

