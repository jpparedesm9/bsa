use cobis
go

print '=====>crea la tabla cl_validacion_huella'
go
if exists ( select 1 from sysobjects where name = 'cl_validacion_huella' )
   drop table cl_validacion_huella
go

create table cl_validacion_huella(
vh_tipo_tran   int         null, 
vh_tipo_ced    char(2)     null,    
vh_ced_ruc     varchar(30) null,  
vh_ref         varchar(30) null,
vh_estado      char(1)     null, 
vh_titularidad char(1)     null, 
vh_usuario     varchar(12) null,
vh_id_caja     int         null,
vh_respuesta   varchar(10) null,
vh_fecha       datetime    null
)
go

print '=====>crea la tabla ca_msv_error'
go
if exists ( select 1 from sysobjects where name = 'ca_msv_error' )
   drop table ca_msv_error
go

create table ca_msv_error
(
    me_fecha          datetime     null,
    me_id_carga       int          null,
    me_id_alianza     int          null,
    me_referencia     varchar(30)  null,
    me_tipo_proceso   char(1)      null,
    me_procedimiento  varchar(30)  null,
    me_codigo_interno int          null,
    me_codigo_err     int          null,
    me_descripcion    varchar(255) null
)
go

print '=====>crea la tabla cl_educa_hijos'
go
if exists ( select 1 from sysobjects where name = 'cl_educa_hijos' )
   drop table cl_educa_hijos
go

create table cl_educa_hijos(
    eh_secuencial  int      null,
    eh_cliente     int      null,
    eh_edad        int      null,
    eh_niv_edu     int      null,
    eh_hijos       int      null,
    eh_fecha_modif datetime null
)
go

print '=====>crea la tabla cl_escolaridad_log'
go
if exists ( select 1 from sysobjects where name = 'cl_escolaridad_log' )
   drop table cl_escolaridad_log
go

create table cl_escolaridad_log(
    cs_secuencial          int         null,
    cs_cliente             int         null,
    cs_ced_ruc             varchar(10) null,
    cs_nom_cliente         varchar(40) null,
    cs_nom_campo           varchar(40) null,
    cs_valor_anterior      varchar(40) null,
    cs_valor_actual        varchar(40) null,
    cs_fecha_actualizacion datetime    null,
    cs_usuario             varchar(20) null
)
go

print '=====>crea la tabla cl_sostenibilidad_log'
go
if exists ( select 1 from sysobjects where name = 'cl_sostenibilidad_log' )
   drop table cl_sostenibilidad_log
go

create table cl_sostenibilidad_log(
	cs_cliente             int         null,
	cs_ced_ruc             varchar(10) null,
	cs_nom_cliente         varchar(40) null,
	cs_nom_campo           varchar(40) null,
	cs_valor_anterior      varchar(40) null,
	cs_valor_actual        varchar(40) null,
	cs_fecha_actualizacion datetime    null,
	cs_usuario             varchar(20) null
)
go

print '=====>crea la tabla cl_traslado'
go
if exists ( select 1 from sysobjects where name = 'cl_traslado' )
   drop table cl_traslado
go

create table cl_traslado
(
    tr_solicitud      int         null,
    tr_ente           int         null,
    tr_tipo_traslado  varchar(10) null,
    tr_estado         char(1)     null,
    tr_causa_rechazo  char(3)     null,
    tr_fecha_sol      datetime    null,
    tr_ofi_solicitud  int         null,
    tr_usr_ingresa    login       null,
    tr_fecha_auto     datetime    null,
    tr_usr_autoriza   login       null,
    tr_ofi_autoriza   int         null,
    tr_oficina_dest   int         null,
    tr_fecha_traslado datetime    null
)
go

print '=====>crea la tabla cl_traslado_detalle'
go
if exists ( select 1 from sysobjects where name = 'cl_traslado_detalle' )
   drop table cl_traslado_detalle
go

create table cl_traslado_detalle
(
    td_solicitud       int          null,
    td_producto        int          null,
    td_ofi_orig        int          null,
    td_ofi_dest        int          null,
    td_operacion       varchar(60)  null,
    td_tipo_operacion  varchar(60)  null,
    td_estado_ope      char(3)      null,
    td_saldo_total     money        null,
    td_saldo_dispo     money        null,
    td_fecha_cons      datetime     null,
    td_fecha_ven       datetime     null,
    td_monto           money        null,
    td_intereses       money        null,
    td_encanje         money        null,
    td_estado_batch    char(1)      null,
    td_fecha_tras      datetime     null,
    td_observacion     varchar(255) null
)

create nonclustered index idx1 
    on ca_msv_error(me_fecha,me_tipo_proceso,me_codigo_err)
go
create nonclustered index idx2 
    on ca_msv_error(me_id_carga)
go
create nonclustered index cl_educa_hijos_key 
    on cl_educa_hijos(eh_cliente)
go
