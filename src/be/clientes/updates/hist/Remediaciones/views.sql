

IF OBJECT_ID ('dbo.ts_actividad_economica') IS NOT NULL
	DROP VIEW dbo.ts_actividad_economica
GO

create view ts_actividad_economica    (
        secuencia,        tipo_transaccion,        clase,                   fecha,              usuario,
        terminal_s,       srv,                     lsrv,                    hora,               ente,
        actividad,        sector,                  subactividad,            subsector,          fuente_ing,
        principal,        dias_atencion,           horario_atencion,        fecha_inicio_act,   antiguedad,
        ambiente,         autorizado,              afiliado,                lugar_afiliacion,   num_empleados,    
        desc_actividad,   ubicacion,               horario_actividad,       estado_ae,          desc_caedec,
        verificado,       fecha_verificacion,      fuente_verificacion,		oficina )
as 
select  ts_secuencial,     ts_tipo_transaccion,     ts_clase,                ts_fecha,           ts_usuario,    
        ts_terminal,       ts_srv,                  ts_lsrv,                 ts_hora,   		 ts_ente,
        ts_escritura,      ts_sector,               ts_actividad,            ts_tipo_soc,        ts_origen_ingresos,
        ts_regional,       ts_tipo,                 ts_licencia,             ts_fec_aut_asf,     ts_provincia,
        ts_cod_fie_asf,    ts_nemon,                ts_nemdef,               ts_obs_horario,     ts_procedure,
        ts_desc_seguro,    ts_descrip_ref_per,      ts_login,                ts_estado,          ts_razon_social,
        ts_verificado,     ts_fecha_verificacion,   ts_fuente_verificacion,		ts_oficina
from    cl_tran_servicio
where    ts_tipo_transaccion    =    2436
or       ts_tipo_transaccion    =    2437
or       ts_tipo_transaccion    =    2438
or       ts_tipo_transaccion    =    2439
GO




IF OBJECT_ID ('dbo.ts_grupo') IS NOT NULL
	DROP VIEW dbo.ts_grupo
GO

CREATE VIEW ts_grupo (
                      secuencial,    tipo_transaccion,    clase,              fecha,    --1
                      terminal,      srv,                 lsrv,                         --2
                      grupo,         nombre,              representante,      compania, --3
                      oficial,       fecha_registro,      fecha_modificacion, ruc,      --4					  
                      vinculacion,   tipo_vinculacion,    max_riesgo,         riesgo,   --5					  
                      usuario,       reservado,           tipo_grupo,         estado,   --6					  
                      dir_reunion,   dia_reunion,         hora_reunion,       comportamiento_pago,--7					  
                      num_ciclo                                                         --8
) as
select                ts_secuencial, ts_tipo_transaccion, ts_clase,           ts_fecha,    --1
                      ts_terminal,   ts_srv,              ts_lsrv,                         --2
                      ts_grupo,      ts_nombre,           ts_rep_legal,       ts_ente,     --3
                      ts_jefe_agenc, ts_fecha_emision,    ts_fecha_expira,    ts_cedruc,   --4					  
                      ts_garantia,   ts_tipo,             ts_promedio_ventas, ts_pasivo,   --5					  
                      ts_usuario,    ts_ingresos,         ts_proposito,       ts_grado_soc,--6					  
                      ts_direc,      ts_camara,           ts_fpas_finan,      ts_telefono, --7
                      ts_escritura                                                         --8
from    cl_tran_servicio
where   ts_tipo_transaccion = 800
GO


IF OBJECT_ID ('dbo.ts_cliente_grupo') IS NOT NULL
	DROP VIEW dbo.ts_cliente_grupo
GO

CREATE VIEW ts_cliente_grupo (secuencial, tipo_transaccion, clase,  --1
                              srv,        lsrv,             ente,   --2      
                              grupo,      usuario,          terminal,--3
                              oficial,    fecha_reg,        rol,     --4
                              estado,     calif_interna,    fecha_desasociacion--5								 
)as
select                        ts_secuencial, ts_tipo_transaccion, ts_clase,      --1 
                              ts_srv,        ts_lsrv,             ts_ente,       --2
                              ts_grupo,      ts_usuario,          ts_terminal,   --3
                              ts_jefe_agenc, ts_fecha_emision,    ts_profesion,  --4
                              ts_estado,     ts_tipo_huella,      ts_fecha_expira--5
from    cl_tran_servicio
where   ts_tipo_transaccion = 810
GO

IF OBJECT_ID ('dbo.ts_direccion') IS NOT NULL
	DROP VIEW dbo.ts_direccion
GO

create view ts_direccion    (
  secuencial,          tipo_transaccion,          clase,                     fecha,	hora,
  usuario,             terminal,                  srv,                       lsrv,    
  ente,                direccion,                 descripcion,               vigencia,
  sector,              zona,                      parroquia,                 ciudad,    
  tipo,                oficina,                   verificado,                barrio,
  provincia,           codpostal,                 casa,                      calle,
  pais,                correspondencia,           alquilada,                 cobro,
  edificio,            departamento,              rural_urbano,              fact_serv_pu,
  tipo_prop,           nombre_agencia,            fuente_verif,              fecha_ver,
  reside
)    as
select
  ts_secuencial,       ts_tipo_transaccion,       ts_clase,                  ts_fecha,	ts_hora,
  ts_usuario,          ts_terminal,               ts_srv,                    ts_lsrv,
  ts_ente,             ts_direccion,              ts_descripcion,            ts_posicion,
  ts_sector,           ts_zona,                   ts_parroquia,              ts_ciudad,    
  ts_tipo,             ts_oficina,                ts_tipo_dp,                ts_barrio,
  ts_provincia,        ts_emp_postal,             ts_pasaporte,              ts_sucursal_ref,
  ts_pais,             ts_estatus,                ts_garantia,               ts_mandat,
  ts_razon_social,     ts_ingre,                  ts_dinero,                 ts_toperacion,
  ts_fecha_ref,        ts_clase_bienes_e,         ts_valor,                  ts_fecha_valuo,
  ts_tiempo_reside
from    cl_tran_servicio
where    ts_tipo_transaccion    =    109
or        ts_tipo_transaccion    =    110
or        ts_tipo_transaccion    =    1226
GO



IF OBJECT_ID ('dbo.ts_telefono') IS NOT NULL
	DROP VIEW dbo.ts_telefono
GO

create view ts_telefono(
    secuencial,      alterno,         tipo_transaccion,       clase,          fecha,	   hora,
    usuario,         terminal,        srv,                    lsrv,           ente,       direccion,
    telefono,        valor,           tipo,                   cobro,          codarea,    oficina
)    as select    
   ts_secuencial,    ts_cod_alterno,  ts_tipo_transaccion,    ts_clase,       ts_fecha,	ts_hora,
   ts_usuario,       ts_terminal,     ts_srv,                 ts_lsrv,        ts_ente,    ts_direccion,
   ts_codigo,        ts_valor,        ts_tipo,                ts_doc_validado,ts_promotor,ts_oficina
from    cl_tran_servicio
where    ts_tipo_transaccion    =    111
or        ts_tipo_transaccion    =    112
or        ts_tipo_transaccion    =    148
GO

-- Vista de Referencias

USE 
cobis

IF OBJECT_ID ('dbo.ts_ref_personal') IS NOT NULL
	DROP VIEW dbo.ts_ref_personal
GO

CREATE VIEW dbo.ts_ref_personal (
    secuencial,     tipo_transaccion,   clase,          fecha,
    usuario,        terminal,           srv,            lsrv,
    persona,        referencia,         nombre,         p_apellido, 
    s_apellido,     direccion,          telefono_d,     telefono_e, 
    telefono_o,     parentesco,         vigencia,       descripcion,
    verificacion,   departamento,       ciudad,         barrio,
    calle,          numero,             colonia,        localidad,
    municipio,      estado,             codpostal,      pais,
    tiempo,			correo
)
as
select 
    ts_secuencial,  ts_tipo_transaccion,ts_clase,       ts_fecha,
    ts_usuario,     ts_terminal,        ts_srv,         ts_lsrv,
    ts_ente,        ts_tabla,           ts_nombre,      ts_p_apellido, 
    ts_s_apellido,  ts_direc,           ts_telefono_1,  ts_telefono_2,
    ts_telefono_3,  ts_tipo,            ts_posicion,    ts_descrip_ref_per, 
    ts_dinero,      ts_sector,          ts_tipo_soc,    ts_zona,
    ts_calle,       ts_nro,             ts_colonia,     ts_localidad,
    ts_municipio,   ts_estado,          ts_codpostal,   ts_pais1,
    ts_tiempo_conocido, ts_rep
from   cl_tran_servicio
where  ts_tipo_transaccion = 177
or     ts_tipo_transaccion = 178
or     ts_tipo_transaccion = 1130
GO


-- Vista de Georeferenciacion

USE 
cobis

IF OBJECT_ID ('dbo.ts_direccion_geo') IS NOT NULL
	DROP VIEW dbo.ts_direccion_geo
GO

create view dbo.ts_direccion_geo (
   secuencia,          tipo_transaccion,       clase,              fecha,
   oficina_s,          usuario,                terminal_s,         srv,    
   lsrv,               hora,                   ente,               direccion,
   latitud_coord,      latitud_grados,         latitud_minutos,    latitud_segundos,
   longitud_coord,     longitud_grados,        longitud_minutos,   longitud_segundos,
   path_croquis)
as select    
   ts_secuencial,      ts_tipo_transaccion,    ts_clase,            ts_fecha,
   ts_oficina,         ts_usuario,             ts_terminal,         ts_srv,
   ts_lsrv,            ts_fecha_modifi,        ts_empresa,          ts_moneda,    
   ts_garantia,        ts_num_cargas,          ts_filial,           ts_segundos_lat,
   ts_rep_superban,    ts_notaria,             ts_cod_atr,          ts_segundos_long,
   ts_path_croquis
from    cl_tran_servicio
where   ts_tipo_transaccion    =    1608
or      ts_tipo_transaccion    =    1606
GO

------------------------------------------------------------------
print ('CREACION VISTA - ts_ref_personal' )
------------------------------------------------------------------

if exists (select * from sysobjects where name = 'ts_ref_personal')
   drop view ts_ref_personal
go
/*--- Creacion de transaccion de servicio los campos para tipo de documento ---*/

CREATE VIEW ts_ref_personal (
    secuencial,     tipo_transaccion,   clase,          fecha,
    usuario,        terminal,           srv,            lsrv,
    persona,        referencia,         nombre,         p_apellido, 
    s_apellido,     direccion,          telefono_d,     telefono_e, 
    telefono_o,     parentesco,         vigencia,       descripcion,
    verificacion,   departamento,       ciudad,         barrio,
    calle,          numero,             colonia,        localidad,
    municipio,      estado,             codpostal,      pais,
    tiempo,			correo
)
as
select 
    ts_secuencial,  ts_tipo_transaccion,ts_clase,       ts_fecha,
    ts_usuario,     ts_terminal,        ts_srv,         ts_lsrv,
    ts_ente,        ts_tabla,           ts_nombre,      ts_p_apellido, 
    ts_s_apellido,  ts_direc,           ts_telefono_1,  ts_telefono_2,
    ts_telefono_3,  ts_tipo,            ts_posicion,    ts_descrip_ref_per, 
    ts_dinero,      ts_sector,          ts_tipo_soc,    ts_zona,
    ts_calle,       ts_nro,             ts_colonia,     ts_localidad,
    ts_municipio,   ts_estado,          ts_codpostal,   ts_pais1,
    ts_tiempo_conocido, ts_rep
from   cl_tran_servicio
where  ts_tipo_transaccion = 177
or     ts_tipo_transaccion = 178
or     ts_tipo_transaccion = 1130
GO
