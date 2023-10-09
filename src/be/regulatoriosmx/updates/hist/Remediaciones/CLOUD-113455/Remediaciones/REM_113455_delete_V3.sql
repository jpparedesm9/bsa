print 'Proceso respaldo'
use cobis
go

declare  @w_fecha datetime
select   @w_fecha = pa_datetime from cobis..cl_parametro where pa_nemonico='FCSALD' AND  pa_producto='CLI' 

select   @w_fecha
select   convert(varchar(10),@w_fecha)

create table alertas_riesgo_113455_v3(
	tar_id_alerta       int null,
	tar_sucursal        int null,
	tar_grupo           int null,
	tar_ente            int null,
	tar_nombre_grupo    varchar (64)  null,
	tar_nombre          varchar (254) null,
	tar_rfc             varchar (30)  null,
	tar_contrato        varchar (24)  null,
	tar_tipo_producto   varchar (255) null,
	tar_tipo_lista      varchar (2)   null,
	tar_fecha_consulta  datetime null,
	tar_fecha_alerta    datetime null,
	tar_fecha_operacion datetime null,
	tar_fecha_dictamina datetime null,
	tar_fecha_reporte   datetime null,
	tar_observaciones   varchar (500) null,
	tar_nivel_riesgo    varchar (255) null,
	tar_etiqueta        varchar (255) null,
	tar_escenario       varchar (300) null,
	tar_tipo_alerta     varchar (100) null,
	tar_tipo_operacion  varchar (255) null,
	tar_monto           money         null,
	tar_status          varchar (100) null,
	tar_genera_reporte  varchar (2)   null,
	tar_codigo          int null
)

insert into alertas_riesgo_113455_v3
select * from cl_alertas_riesgo
where ar_fecha_operacion < @w_fecha

delete from cl_alertas_riesgo
where ar_fecha_operacion < @w_fecha

go
