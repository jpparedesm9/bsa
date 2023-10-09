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
or      ts_tipo_transaccion    =    1609
or      ts_tipo_transaccion    =    1606
go

------------------------------------------------------------------------------------------------------------
--RESPALDO DE LA TABLA respaldo cl_direccion_geo
------------------------------------------------------------------------------------------------------------
use cobis
go
IF OBJECT_ID ('dbo.cl_direccion_geo_118397_tmp') IS NOT NULL
	DROP table dbo.cl_direccion_geo_118397_tmp
go

create table dbo.cl_direccion_geo_118397_tmp
	(
	dg_t_ente         int,
	dg_t_direccion    tinyint,
	dg_t_lat_coord    char (1),
	dg_t_lat_grad     tinyint,
	dg_t_lat_min      tinyint,
	dg_t_lat_seg      float,
	dg_t_long_coord   char (1),
	dg_t_long_grad    tinyint,
	dg_t_long_min     tinyint,
	dg_t_long_seg     float,
	dg_t_path_croquis varchar (50),
	dg_t_secuencial   int
	)
go

------------------------------------------------------------------------------------------------------------
--PROCESO PARA ACTUALIZAR GEO LOCALIZACION
------------------------------------------------------------------------------------------------------------
----------Creacion de tablas temporales con clientes y direcciones a trabajar
use cobis
go

create table #cli_sin_lat_long
( cliente        int,
  cod_direccion  int,
  lat_seg        float,
  long_seg       float
)

insert  #cli_sin_lat_long
select  en_ente, di_direccion, dg_lat_seg, dg_long_seg
from    cobis..cl_direccion, cobis..cl_direccion_geo, cobis..cl_ente  --por pruebas **borrar
where   di_ente = dg_ente
and     dg_ente = en_ente
and     di_tipo in ('AE','RE')
and     di_direccion = dg_direccion
and     dg_lat_seg in (0,null)
and     dg_long_seg in (0,null)
and     en_fecha_crea > '11/30/2018'
and     en_ente in (select op_cliente from cob_cartera..ca_operacion)

----------Respaldo de la tabla real direccion_geo
insert into   cl_direccion_geo_118397_tmp
select * from cl_direccion_geo

----------insertar datos de la vista
create table #dir_ts
( ts_cliente        int,
  ts_cod_direccion  int,
  ts_lat_seg        float,
  ts_long_seg       float,
  ts_fecha             datetime
)

insert  #dir_ts
select  ente,
        direccion,
        latitud_segundos,
        longitud_segundos,
        fecha
from    cobis..ts_direccion_geo TSG, #cli_sin_lat_long
where   TSG.ente      = cliente
and     TSG.direccion = cod_direccion

----------Borrado de registros que tienen coordenadas cero , y fechas no maximas
delete #dir_ts
where ((ts_lat_seg is null) or (ts_lat_seg = 0))
and   ((ts_long_seg is null) or (ts_long_seg = 0))

delete #dir_ts
from   #dir_ts TS
where  TS.ts_cliente       = ts_cliente
and    TS.ts_cod_direccion = ts_cod_direccion
and    TS.ts_fecha not in (select max(ts_fecha) from #dir_ts
                        where  ts_cliente = TS.ts_cliente and ts_cod_direccion = TS.ts_cod_direccion)

----------Actualizacion de temporal
update #cli_sin_lat_long
set    lat_seg  = isnull(ts_lat_seg,lat_seg),
       long_seg = isnull(ts_long_seg,long_seg)
from   #dir_ts
where  ts_cliente       = cliente
and    ts_cod_direccion = cod_direccion

----------Enviar un valor cualquier a los que no tienen direcion geo
update #cli_sin_lat_long
/*set    lat_seg = 20.032695,
       long_seg = -98.312978000000001*/
set    lat_seg = 18.9343245,
       long_seg = -99.234624	   
where  ((lat_seg  is null) or (lat_seg = 0))
and    ((long_seg  is null) or (long_seg = 0))

----------Actualizacion de Tabla real
select 'ant_caso'='ant_caso',dg_ente, dg_direccion, dg_lat_seg, dg_long_seg 
from cobis..cl_direccion_geo order by dg_ente, dg_direccion

update cobis..cl_direccion_geo
set    dg_lat_seg  = lat_seg,
       dg_long_seg = long_seg
from   #cli_sin_lat_long
where  cliente       = dg_ente
and    cod_direccion = dg_direccion

select 'desp_caso'='desp_caso',dg_ente, dg_direccion, dg_lat_seg, dg_long_seg 
from cobis..cl_direccion_geo order by dg_ente, dg_direccion

--drop table #cli_sin_lat_long
--drop table #dir_ts
go
