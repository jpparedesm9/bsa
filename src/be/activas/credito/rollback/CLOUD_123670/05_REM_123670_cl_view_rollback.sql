use cobis
go

--Vista Direccion
ALTER VIEW [dbo].[ts_direccion]    (
  secuencial,          tipo_transaccion,          clase,                     fecha,	hora,
  usuario,             terminal,                  srv,                       lsrv,    
  ente,                direccion,                 descripcion,               vigencia,
  sector,              zona,                      parroquia,                 ciudad,    
  tipo,                oficina,                   verificado,                barrio,
  provincia,           codpostal,                 casa,                      calle,
  pais,                correspondencia,           alquilada,                 cobro,
  edificio,            departamento,              rural_urbano,              fact_serv_pu,
  tipo_prop,           nombre_agencia,            fuente_verif,              fecha_ver,
  reside,              negocio,                   poblacion,                 nro,                       
  nro_interno,         referencia,                nro_residentes,            canal)    
as
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
  ts_tiempo_reside,    ts_lugar_doc,              ts_localidad,              ts_secuencial1,                 
  ts_seccuenta,        ts_desc_larga,             ts_naciona,                ts_term
from    cl_tran_servicio
where    ts_tipo_transaccion    =    109
or       ts_tipo_transaccion    =    110
or       ts_tipo_transaccion    =    1226

go


--Vista Direccion Geo
alter view [dbo].[ts_direccion_geo]  (
   secuencia,          tipo_transaccion,       clase,              fecha,
   oficina_s,          usuario,                terminal_s,         srv,    
   lsrv,               hora,                   ente,               direccion,
   latitud_coord,      latitud_grados,         latitud_minutos,    latitud_segundos,
   longitud_coord,     longitud_grados,        longitud_minutos,   longitud_segundos,
   path_croquis,       canal)
as select    
   ts_secuencial,      ts_tipo_transaccion,    ts_clase,            ts_fecha,
   ts_oficina,         ts_usuario,             ts_terminal,         ts_srv,
   ts_lsrv,            ts_fecha_modifi,        ts_empresa,          ts_moneda,    
   ts_garantia,        ts_num_cargas,          ts_filial,           ts_segundos_lat,
   ts_rep_superban,    ts_notaria,             ts_cod_atr,          ts_segundos_long,
   ts_path_croquis,    ts_term
from    cl_tran_servicio
where   ts_tipo_transaccion    =    1608
or      ts_tipo_transaccion    =    1609
or      ts_tipo_transaccion    =    1606

go


--Vista Telefono
alter view [dbo].[ts_telefono]    (
   secuencial,      alterno,         tipo_transaccion,       clase,          fecha,	   hora,
   usuario,         terminal,        srv,                    lsrv,           ente,       direccion,
   telefono,        valor,           tipo,                   cobro,          codarea,    oficina,
   canal
) as select    
   ts_secuencial,    ts_cod_alterno,  ts_tipo_transaccion,    ts_clase,        ts_fecha,	ts_hora,
   ts_usuario,       ts_terminal,     ts_srv,                 ts_lsrv,         ts_ente,     ts_direccion,
   ts_codigo,        ts_valor,        ts_tipo,                ts_doc_validado, ts_promotor, ts_oficina,
   ts_term
from    cl_tran_servicio
where   ts_tipo_transaccion    =    111
or      ts_tipo_transaccion    =    112
or      ts_tipo_transaccion    =    148

go
