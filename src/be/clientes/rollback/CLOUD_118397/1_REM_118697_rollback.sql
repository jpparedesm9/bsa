----------------------------------------------------------------------------------------
--CREACION DE VISTAS
----------------------------------------------------------------------------------------
use cobis
go
--ts_direccion_geo
if not object_id('ts_direccion_geo') is null
   drop view ts_direccion_geo
go
create view ts_direccion_geo (
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
go


use cobis
go

update cl_direccion_geo
set    dg_lat_seg  = isnull(dg_t_lat_seg, dg_lat_seg),
       dg_long_seg = isnull(dg_t_long_seg, dg_long_seg)
from   cl_direccion_geo_118397_tmp
where  dg_ente = dg_t_ente and
       dg_direccion = dg_t_direccion
go

