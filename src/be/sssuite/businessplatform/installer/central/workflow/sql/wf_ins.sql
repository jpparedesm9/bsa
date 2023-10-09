/* INSERCIONES EN WORKFLOW */

set nocount on
go

use cob_workflow
go

-- Insert de Empresas
delete from wf_empresa
go

insert into wf_empresa
(em_codigo_empresa, em_nombre_empresa)
values (1, 'BANCO-COBIS')
go

-- Insert en actividades
delete from wf_actividad
go

insert into wf_actividad
(ac_codigo_actividad, ac_nombre_actividad, ac_codigo_empresa,
ac_desc_actividad, ac_tipo_actividad, ac_estado, ac_color_fondo,
ac_color_texto)
values (1, 'INICIO', 1, 'ACTIVIDAD INICIAL', 'NOR', 'ACT', -2147483624, 0)
go

insert into wf_actividad
(ac_codigo_actividad, ac_nombre_actividad, ac_codigo_empresa,
ac_desc_actividad, ac_tipo_actividad, ac_estado, ac_color_fondo,
ac_color_texto)
values (2, 'FIN', 1, 'ACTIVIDAD FINAL', 'NOR', 'ACT', 16761024, 0)
go

insert into wf_actividad
(ac_codigo_actividad, ac_nombre_actividad, ac_codigo_empresa,
ac_desc_actividad, ac_tipo_actividad, ac_estado, ac_color_fondo,
ac_color_texto)
values (3, 'LANZADORA', 1, 'ACTIVIDAD LANZADORA', 'LAN', 'ACT', 16761024, 0)
go

insert into wf_actividad
(ac_codigo_actividad, ac_nombre_actividad, ac_codigo_empresa,
ac_desc_actividad, ac_tipo_actividad, ac_estado, ac_color_fondo,
ac_color_texto)
values (4, 'INFORMATIVA', 1, 'ACTIVIDAD INFORMATIVA', 'INF', 'ACT', -2147483624, 0)
go

/*insert into wf_actividad
(ac_codigo_actividad, ac_nombre_actividad, ac_codigo_empresa,
ac_desc_actividad, ac_tipo_actividad, ac_estado, ac_color_fondo,
ac_color_texto)
values (5, 'COMPARADORA', 1, 'ACTIVIDAD COMPARADORA', 'NOR', 'ACT', 8404992, 8454143)
go*/--Cambio solicitado por Franklin Escudero

-- Insert de resultados
delete from wf_resultado
go

insert into wf_resultado
(rs_codigo_resultado, rs_nombre_resultado,rs_evalua_politica)
values (1, 'OK','S')

insert into wf_resultado
(rs_codigo_resultado, rs_nombre_resultado,rs_evalua_politica)
values (2, 'DEVOLVER','N')

insert into wf_resultado
(rs_codigo_resultado, rs_nombre_resultado,rs_evalua_politica)
values (3, 'RECHAZAR','N')

insert into cob_workflow..wf_resultado
(rs_codigo_resultado, rs_nombre_resultado,rs_evalua_politica) 
values (4,'ESCALAR','N')

go

-- Insert de atribuciones
delete from wf_atribucion
go

insert into wf_atribucion
(an_id_atribucion, an_nombre_atribucion, an_desc_atribucion,
an_tipo_atribucion, an_codigo_item, an_condicion,
an_operacion)
values (1, 'ATRIBUCION OK', 'ATRIBUCION OPCION OK',
'RES', 1, null, 'SEL')

insert into wf_atribucion
(an_id_atribucion, an_nombre_atribucion, an_desc_atribucion,
an_tipo_atribucion, an_codigo_item, an_condicion,
an_operacion)
values (2, 'ATRIBUCION DEVOLVER', 'ATRIBUCION OPCION DEVOLVER',
'RES', 2, null, 'SEL')

-- Insert de instrucciones
delete from wf_instruccion
go

insert into wf_instruccion
(in_codigo_instruccion, in_nombre_instruccion, in_tiempo_ejecu,in_producto)
values (1,'CANCELACION PARCIAL DE GARANTIA',0,'CRE')

insert into wf_instruccion
(in_codigo_instruccion, in_nombre_instruccion, in_tiempo_ejecu,in_producto)
values (2,'REAVALUO DE GARANTIA',0,'CRE')

insert into wf_instruccion
(in_codigo_instruccion, in_nombre_instruccion, in_tiempo_ejecu,in_producto)
values (3,'PRORROGA',0,'CRE')

insert into wf_instruccion
(in_codigo_instruccion, in_nombre_instruccion, in_tiempo_ejecu,in_producto)
values (4,'ESPERA',0,'CRE')

insert into wf_instruccion
(in_codigo_instruccion, in_nombre_instruccion, in_tiempo_ejecu,in_producto)
values (5,'REESTRUCTURACION',0,'CRE')
go



-- ------------ ELIMINACIONES ---------------
use cobis
go

-- print 'Eliminando entradas de Cobis Workflow en cl_parametro'
delete from cl_parametro
 where pa_producto = 'CWF'
go

-- print 'Insercion de Parametros de Cobis Workflow en cl_parametro'
-- Hace que esten visibles las plantillas en el Editor de Procesos.
insert into cl_parametro
       (pa_parametro, pa_nemonico, pa_tipo,
        pa_char, pa_tinyint, pa_smallint,
        pa_int, pa_money, pa_datetime,
        pa_float, pa_producto)
values ('PLANTILLAS DE PROCESO VISIBLES', 'PLAPRO', 'C', 
        'SI', null, null, 
        null, null, null, 
        null, 'CWF')

insert into cl_parametro 
       (pa_parametro, pa_nemonico, pa_tipo,
        pa_char, pa_tinyint, pa_smallint,
        pa_int, pa_money, pa_datetime,
        pa_float, pa_producto)
values ('VERSION DE BDD SYBASE', 'BDDVER', 'T', 
        null, 12, null, 
        null, null, null, 
        null, 'CWF')

insert into cl_parametro
       (pa_parametro, pa_nemonico, pa_tipo,
        pa_char, pa_tinyint, pa_smallint,
        pa_int, pa_money, pa_datetime,
        pa_float, pa_producto)
values ('NOMBRE DEL PROGRAMA DE POLITICAS', 'PROPOL', 'C', 
        'cob_workflow..sp_politicas_wf', null, null, 
        null, null, null, 
        null, 'CWF')

insert into cl_parametro
       (pa_parametro, pa_nemonico, pa_tipo,
        pa_char, pa_tinyint, pa_smallint,
        pa_int, pa_money, pa_datetime,
        pa_float, pa_producto)
values ('EVALUAR ULTIMA EXCEPCION', 'EVULEX', 'C', 
        'N', null, null, 
        null, null, null, 
        null, 'CWF')

insert into cl_parametro 
        (pa_parametro, pa_nemonico, pa_tipo, 
         pa_char, pa_tinyint, pa_smallint, 
         pa_int, pa_money, pa_datetime, 
         pa_float, pa_producto)
values ('HISTORICOS POLITICAS WORKFLOW NO ACTIVOS', 'HPWA', 'C', 
        'S', null, null, 
        null, null, null, 
        null, 'CWF')

go

-- print 'Eliminando entradas de Cobis Workflow en cl_catalogo'
delete cobis..cl_catalogo where tabla in
	(select cp_tabla
	 from cobis..cl_catalogo_pro, cobis..cl_tabla 
 	 where cp_tabla = codigo
	   and cp_producto = 'CWF' 
	   and tabla like 'wf_%'
	   and tabla not in('wf_type_variable','wf_subType_variable'))
 
-- print 'Eliminando entradas de Cobis Workflow en cl_catalogo_pro'
delete cobis..cl_catalogo_pro where cp_producto ='CWF' and cp_tabla in
(select cp_tabla
	 from cobis..cl_catalogo_pro, cobis..cl_tabla 
 	 where cp_tabla = codigo
	   and cp_producto = 'CWF' 
	   and tabla like 'wf_%')

-- print 'Eliminando entradas de Cobis Workflow en cl_tabla'
delete cobis..cl_tabla where tabla like 'wf_%' and tabla not in('wf_type_variable','wf_subType_variable')

/* Insercion de Datos de Cobis Workflow. */

/************************************************************************/
-- print 'CREACION DE CATALOGO ESTADO DEL PROCESO.'
/************************************************************************/
declare @w_tabla smallint
select @w_tabla = isnull(max(codigo), 0) + 1
  from cobis..cl_tabla
insert into cl_catalogo_pro(cp_producto, cp_tabla)  values ('CWF',@w_tabla)
insert into cobis..cl_tabla(codigo, tabla, descripcion)
  values  (@w_tabla, 'wf_estado_proc', 'ESTADO PROCESO')
update cobis..cl_seqnos
  set siguiente = @w_tabla
  where tabla = 'cl_tabla'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'ACT', 'ACTIVO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'SUS', 'SUSPENDIDO', 'V')
go

/************************************************************************/
-- print 'CREACION DE CATALOGO TIPO DE ACTIVIDAD'
/************************************************************************/
declare @w_tabla smallint
select @w_tabla = isnull(max(codigo), 0) + 1
  from cobis..cl_tabla
insert into cl_catalogo_pro(cp_producto, cp_tabla)  values ('CWF',@w_tabla)
insert into cobis..cl_tabla(codigo, tabla, descripcion)
  values (@w_tabla, 'wf_tipo_actividad', 'TIPO DE ACTIVIDAD')
update cobis..cl_seqnos
  set siguiente = @w_tabla
  where tabla = 'cl_tabla'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
 values (@w_tabla, 'INF', 'INFORMATIVA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
 values (@w_tabla, 'LAN', 'LANZADORA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
 values (@w_tabla, 'NOR', 'NORMAL', 'V')
go

/************************************************************************/
-- print 'CREACION DE CATALOGO TIPO DE PASO'
/************************************************************************/
declare @w_tabla smallint
select @w_tabla = isnull(max(codigo), 0) + 1
  from cobis..cl_tabla
insert into cl_catalogo_pro(cp_producto, cp_tabla)  values ('CWF',@w_tabla)
insert into cobis..cl_tabla(codigo, tabla, descripcion)
  values(@w_tabla, 'wf_tipo_paso', 'TIPO DE PASO')
update cobis..cl_seqnos
  set siguiente = @w_tabla
  where tabla = 'cl_tabla'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'ACT', 'ACTIVIDAD', 'V')
--insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
--  values (@w_tabla, 'CON', 'CONCENTRADOR', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'FIN', 'FIN', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'INI', 'INICIO', 'V')
--insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
--  values (@w_tabla, 'PAR', 'PARALELO', 'V')
go

/************************************************************************/
-- print 'CREACION DE CATALOGO ESTADO PROCESO'
/************************************************************************/
declare @w_tabla smallint
select  @w_tabla = isnull(max(codigo), 0) + 1
  from  cobis..cl_tabla
insert into cl_catalogo_pro(cp_producto, cp_tabla)  values ('CWF',@w_tabla)
insert into cobis..cl_tabla     (codigo, tabla, descripcion)
                values  (@w_tabla, 'wf_estado_proceso', 'ESTADO PROCESO')
update cobis..cl_seqnos
  set siguiente = @w_tabla
  where tabla = 'cl_tabla'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'CAN', 'CANCELADO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'INI', 'INICIADO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'EJE', 'EJECUTANDOSE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'SUS', 'SUSPENDIDO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'TER', 'TERMINADO', 'V')
go

/************************************************************************/
-- print 'CREACION DE CATALOGO ESTADO ACTIVIDAD'
/************************************************************************/
declare @w_tabla smallint
select  @w_tabla = isnull(max(codigo), 0) + 1
  from  cobis..cl_tabla
insert into cl_catalogo_pro(cp_producto, cp_tabla)  values ('CWF',@w_tabla)
insert into cobis..cl_tabla     (codigo, tabla, descripcion)
                values  (@w_tabla, 'wf_estado_actividad', 'ESTADO ACTIVIDAD')
update cobis..cl_seqnos
  set siguiente = @w_tabla
  where tabla = 'cl_tabla'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'ACT', 'ACTIVA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'COM', 'COMPLETA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'INA', 'INACTIVA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'SUS', 'SUSPENDIDA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'PMO', 'PROBLEMA MOTOR', 'V')
go

/************************************************************************/
-- print 'CREACION DE CATALOGO ESTADO ASIGNACION'
/************************************************************************/
declare @w_tabla smallint
select  @w_tabla = isnull(max(codigo), 0) + 1
  from  cobis..cl_tabla
insert into cl_catalogo_pro(cp_producto, cp_tabla)  values ('CWF',@w_tabla)
insert into cobis..cl_tabla     (codigo, tabla, descripcion)
                values  (@w_tabla, 'wf_estado_asignacion', 'ESTADO ASIGNACION')
update cobis..cl_seqnos
  set siguiente = @w_tabla
  where tabla = 'cl_tabla'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'PEN', 'PENDIENTE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'ABR', 'ABIERTA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'REA', 'REASIGNADA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'COM', 'COMPLETA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'REC', 'RECHAZADA', 'V')
go

/************************************************************************/
-- print 'CREACION DE CATALOGO ESTADO USUARIO'
/************************************************************************/
declare @w_tabla smallint
select @w_tabla = isnull(max(codigo), 0) + 1
  from cobis..cl_tabla
insert into cl_catalogo_pro(cp_producto, cp_tabla)  values ('CWF',@w_tabla)
insert into cobis..cl_tabla(codigo, tabla, descripcion)
  values  (@w_tabla, 'wf_estado_usuario', 'ESTADO USUARIO')
update cobis..cl_seqnos
  set siguiente = @w_tabla
  where tabla = 'cl_tabla'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'ACT', 'ACTIVO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'INA', 'INACTIVO', 'V')
go

/************************************************************************/
-- print 'CREACION DE CATALOGO ESTADO LOGIN'
/************************************************************************/
declare @w_tabla smallint
select @w_tabla = isnull(max(codigo), 0) + 1
  from cobis..cl_tabla
insert into cl_catalogo_pro(cp_producto, cp_tabla)  values ('CWF',@w_tabla)
insert into cobis..cl_tabla(codigo, tabla, descripcion)
  values  (@w_tabla, 'wf_estado_login', 'ESTADO LOGIN')
update cobis..cl_seqnos
  set siguiente = @w_tabla
  where tabla = 'cl_tabla'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'LIN', 'LOG IN', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'LOU', 'LOG OUT', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'PAU', 'PAUSADO', 'V')
go

/************************************************************************/
-- print 'CREACION DE CATALOGO TIPO DESTINATARIO'
/************************************************************************/
declare @w_tabla smallint
select @w_tabla = isnull(max(codigo), 0) + 1
  from cobis..cl_tabla
insert into cl_catalogo_pro(cp_producto, cp_tabla)  values ('CWF',@w_tabla)
insert into cobis..cl_tabla(codigo, tabla, descripcion)
  values  (@w_tabla, 'wf_tipo_destinatario', 'TIPO DESTINATARIO')
update cobis..cl_seqnos
  set siguiente = @w_tabla
  where tabla = 'cl_tabla'
--insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
--  values (@w_tabla, 'COL', 'COLA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'COM', 'COMITE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'PRO', 'PROGRAMA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'ROL', 'ROL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'SUB', 'SUBPROCESO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'USR', 'USUARIO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'JER', 'JERARQUIA DE PARTICIPANTES', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'POL', 'POLITICAS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'RUL', 'REGLAS', 'V')  
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'JEU', 'JERARQUIA DE USUARIOS', 'V')  
go

/************************************************************************/
-- print 'CREACION DE CATALOGO TIPO DISTRIBUCION CARGA'
/************************************************************************/
declare @w_tabla smallint
select @w_tabla = isnull(max(codigo), 0) + 1
  from cobis..cl_tabla
insert into cl_catalogo_pro(cp_producto, cp_tabla)  values ('CWF',@w_tabla)
insert into cobis..cl_tabla(codigo, tabla, descripcion)
  values  (@w_tabla, 'wf_tipo_distribucion_carga', 'TIPO DISTRIBUCION CARGA')
update cobis..cl_seqnos
  set siguiente = @w_tabla
  where tabla = 'cl_tabla'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'MCN', 'MENOR CARGA NUMERO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'MCT', 'MENOR CARGA TIEMPO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'ESP', 'ESPECIFICA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'NIN', 'NINGUNO', 'V')
go

/************************************************************************/
-- print 'CREACION DE CATALOGO TIPO OFICINA DIST CARGA'
/************************************************************************/
declare @w_tabla smallint
select @w_tabla = isnull(max(codigo), 0) + 1
  from cobis..cl_tabla
insert into cl_catalogo_pro(cp_producto, cp_tabla)  values ('CWF',@w_tabla)
insert into cobis..cl_tabla(codigo, tabla, descripcion)
  values  (@w_tabla, 'wf_tipo_oficina_dist_carga', 'OFICINA DIST. CARGA')
update cobis..cl_seqnos
  set siguiente = @w_tabla
  where tabla = 'cl_tabla'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'OFI', 'OFICINA INICIO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'OFE', 'OFICINA ENTREGA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'OFN', 'OFICINA NULA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'OFU', 'JERARAQUIA USUARIOS', 'V')
go

/************************************************************************/
-- print 'CREACION DE CATALOGO TIPO DE ATRIBUCION'
/************************************************************************/
declare @w_tabla smallint
select @w_tabla = isnull(max(codigo), 0) + 1
  from cobis..cl_tabla
insert into cl_catalogo_pro(cp_producto, cp_tabla)  values ('CWF',@w_tabla)
insert into cobis..cl_tabla(codigo, tabla, descripcion)
  values  (@w_tabla, 'wf_tipo_atribucion', 'TIPO DE ATRIBUCION')
update cobis..cl_seqnos
  set siguiente = @w_tabla
  where tabla = 'cl_tabla'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'INS', 'INSTRUCCION', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'EXC', 'EXCEPCION', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'RES', 'RESULTADO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'REQ', 'REQUISITO', 'V')
go


/************************************************************************/
-- print 'CREACION DE CATALOGO TIPO DE PROGRAMA'
/************************************************************************/
declare @w_tabla smallint
select @w_tabla = isnull(max(codigo), 0) + 1
  from cobis..cl_tabla
insert into cl_catalogo_pro(cp_producto, cp_tabla)  values ('CWF',@w_tabla)
insert into cobis..cl_tabla(codigo, tabla, descripcion)
  values  (@w_tabla, 'wf_tipo_programa', 'TIPO DE PROGRAMA')
update cobis..cl_seqnos
  set siguiente = @w_tabla
  where tabla = 'cl_tabla'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'EXE', 'EJECUTABLE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'DLL', 'DLL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'PRA', 'PROCEDIMIENTO', 'V')
go

/************************************************************************/
-- print 'CREACION DE CATALOGO TIPO DE PARAMETRO'
/************************************************************************/
declare @w_tabla smallint
select @w_tabla = isnull(max(codigo), 0) + 1
  from cobis..cl_tabla
insert into cl_catalogo_pro(cp_producto, cp_tabla)  values ('CWF',@w_tabla)
insert into cobis..cl_tabla(codigo, tabla, descripcion)
  values  (@w_tabla, 'wf_tipo_parametro', 'TIPO DE PARAMETRO')
update cobis..cl_seqnos
  set siguiente = @w_tabla
  where tabla = 'cl_tabla'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'ENT', 'ENTRADA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'SAL', 'SALIDA', 'V')
go

/************************************************************************/
-- print 'CREACION DE CATALOGO TIPO DE DATOS'
/************************************************************************/
declare @w_tabla smallint
select @w_tabla = isnull(max(codigo), 0) + 1
  from cobis..cl_tabla
insert into cl_catalogo_pro(cp_producto, cp_tabla)  values ('CWF',@w_tabla)
insert into cobis..cl_tabla(codigo, tabla, descripcion)
  values  (@w_tabla, 'wf_tipo_dato', 'TIPO DE DATO')
update cobis..cl_seqnos
  set siguiente = @w_tabla
  where tabla = 'cl_tabla'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'INT', 'ENTERO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'FLT', 'PUNTO FLOTANTE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'CHR', 'CARACTER', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'VCH', 'CARACTER VARIABLE', 'V')
go

/************************************************************************/
-- print 'CREACION DE CATALOGO TIPO DE MENSAJE'
/************************************************************************/
declare @w_tabla smallint
select @w_tabla = isnull(max(codigo), 0) + 1
  from cobis..cl_tabla
insert into cl_catalogo_pro(cp_producto, cp_tabla)  values ('CWF',@w_tabla)
insert into cobis..cl_tabla(codigo, tabla, descripcion)
  values  (@w_tabla, 'wf_tipo_mensaje', 'TIPO DE MENSAJE')
update cobis..cl_seqnos
  set siguiente = @w_tabla
  where tabla = 'cl_tabla'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'DCA', 'DIST. DE CARGA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'MOT', 'MOTOR', 'V')
go

/************************************************************************/
-- print 'CREACION DE CATALOGO PRIORIDAD'
/************************************************************************/
declare @w_tabla smallint
select @w_tabla = isnull(max(codigo), 0) + 1
  from cobis..cl_tabla
insert into cl_catalogo_pro(cp_producto, cp_tabla)  values ('CWF',@w_tabla)
insert into cobis..cl_tabla(codigo, tabla, descripcion)
  values  (@w_tabla, 'wf_prioridad', 'PRIORIDAD')
update cobis..cl_seqnos
  set siguiente = @w_tabla
  where tabla = 'cl_tabla'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'ALT', 'ALTA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'MED', 'MEDIA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'BAJ', 'BAJA', 'V')
go

/************************************************************************/
-- print 'CREACION DE CATALOGO ESTADO DEL MENSAJE'
/************************************************************************/
declare @w_tabla smallint
select @w_tabla = isnull(max(codigo), 0) + 1
  from cobis..cl_tabla
insert into cl_catalogo_pro(cp_producto, cp_tabla)  values ('CWF',@w_tabla)
insert into cobis..cl_tabla(codigo, tabla, descripcion)
  values  (@w_tabla, 'wf_est_mensaje', 'ESTADO MENSAJE')
update cobis..cl_seqnos
  set siguiente = @w_tabla
  where tabla = 'cl_tabla'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'NUE', 'NUEVO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'LEI', 'LEIDO', 'V')
go

/************************************************************************/
-- print 'CREACION DE CATALOGO TIPO DE CONDICION DE MAPEO CONDICION.'
/************************************************************************/
declare @w_tabla smallint
select @w_tabla = isnull(max(codigo), 0) + 1
  from cobis..cl_tabla
insert into cl_catalogo_pro(cp_producto, cp_tabla)  values ('CWF',@w_tabla)
insert into cobis..cl_tabla(codigo, tabla, descripcion)
  values  (@w_tabla, 'wf_tipo_condicion', 'TIPO DE CONDICIÓN')
update cobis..cl_seqnos
  set siguiente = @w_tabla
  where tabla = 'cl_tabla'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'ENL', 'ENLACE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'ATR', 'ATRIBUCION', 'V')
go

/************************************************************************/
-- print 'CREACION DE CATALOGO TIPO DE ITEM DE MAPEO CONDICION.'
/************************************************************************/
declare @w_tabla smallint
select @w_tabla = isnull(max(codigo), 0) + 1
  from cobis..cl_tabla
insert into cl_catalogo_pro(cp_producto, cp_tabla)  values ('CWF',@w_tabla)
insert into cobis..cl_tabla(codigo, tabla, descripcion)
  values  (@w_tabla, 'wf_tipo_item', 'TIPO DE ITEM')
update cobis..cl_seqnos
  set siguiente = @w_tabla
  where tabla = 'cl_tabla'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'INS', 'INSTRUCCION', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'EXC', 'EXCEPCION', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'RES', 'RESULTADO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'VAR', 'VARIABLE', 'V')
go

/************************************************************************/
-- print 'CREACION DE CATALOGO TIPO DE ESTADO DE VERSION DE PROCESO.'
/************************************************************************/
declare @w_tabla smallint
select @w_tabla = isnull(max(codigo), 0) + 1
  from cobis..cl_tabla
insert into cl_catalogo_pro(cp_producto, cp_tabla)  values ('CWF',@w_tabla)
insert into cobis..cl_tabla(codigo, tabla, descripcion)
  values  (@w_tabla, 'wf_estado_version', 'ESTADO VERSION')
update cobis..cl_seqnos
  set siguiente = @w_tabla
  where tabla = 'cl_tabla'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'CON', 'EN CONSTRUCCION', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'ANT', 'ANTERIOR', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'PRD', 'EN PRODUCCION', 'V')
go

/************************************************************************/
-- print 'CREACION DE CATALOGO ESTADO DE EXCEPCION.'
/************************************************************************/
declare @w_tabla smallint
select @w_tabla = isnull(max(codigo), 0) + 1
  from cobis..cl_tabla
insert into cl_catalogo_pro(cp_producto, cp_tabla)  values ('CWF',@w_tabla)
insert into cobis..cl_tabla(codigo, tabla, descripcion)
  values  (@w_tabla, 'wf_estado_exc', 'ESTADO EXCEPCION')
update cobis..cl_seqnos
  set siguiente = @w_tabla
  where tabla = 'cl_tabla'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'INI', 'INICIADA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'APR', 'APROBADA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'REC', 'RECHAZADA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'REG', 'REGULARIZADA', 'V')
go

/************************************************************************/
-- print 'CREACION DE CATALOGO ESTADO DE INSTRUCCION.'
/************************************************************************/
declare @w_tabla smallint
select @w_tabla = isnull(max(codigo), 0) + 1
  from cobis..cl_tabla
insert into cl_catalogo_pro(cp_producto, cp_tabla)  values ('CWF',@w_tabla)
insert into cobis..cl_tabla(codigo, tabla, descripcion)
  values  (@w_tabla, 'wf_estado_ins', 'ESTADO INSTRUCCION')
update cobis..cl_seqnos
  set siguiente = @w_tabla
  where tabla = 'cl_tabla'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'INI', 'INICIADA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'APR', 'APROBADA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'REC', 'RECHAZADA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'EJE', 'EJECUTADA', 'V')
go

/************************************************************************/
-- print 'CREACION DE CATALOGO MEDIO DE ENVIO DE UN MENSAJE.'
/************************************************************************/
declare @w_tabla smallint
select @w_tabla = isnull(max(codigo), 0) + 1
  from cobis..cl_tabla
insert into cl_catalogo_pro(cp_producto, cp_tabla)  values ('CWF',@w_tabla)
insert into cobis..cl_tabla(codigo, tabla, descripcion)
  values  (@w_tabla, 'wf_medio_envio', 'MEDIO DE ENVIO')
update cobis..cl_seqnos
  set siguiente = @w_tabla
  where tabla = 'cl_tabla'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'PER', 'PERSONAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'DIR', 'DIRECCION', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'FON', 'TELEFONO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'BIP', 'BIPPER', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'CEL', 'CELULAR', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'EML', 'E-MAIL', 'V')
go

/************************************************************************/
-- print 'CREACION DE CATALOGO TIPO DE RECEPTORES.'
/************************************************************************/
declare @w_tabla smallint
select @w_tabla = isnull(max(codigo), 0) + 1
  from cobis..cl_tabla
insert into cl_catalogo_pro(cp_producto, cp_tabla)  values ('CWF',@w_tabla)
insert into cobis..cl_tabla(codigo, tabla, descripcion)
  values  (@w_tabla, 'wf_tipo_receptor', 'TIPO RECEPTOR')
update cobis..cl_seqnos
  set siguiente = @w_tabla
  where tabla = 'cl_tabla'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'USR', 'USUARIO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'PRO', 'PROGRAMA', 'V')
go


/************************************************************************/
-- print 'CREACION DE CATALOGO DE OBSERVACIONES.'
/************************************************************************/
declare @w_tabla smallint
select @w_tabla = isnull(max(codigo), 0) + 1
  from cobis..cl_tabla
insert into cl_catalogo_pro(cp_producto, cp_tabla)  values ('CWF',@w_tabla)
insert into cobis..cl_tabla(codigo, tabla, descripcion)
  values  (@w_tabla, 'wf_observacion', 'OBSERVACIONES WORKFLOW')
go


/************************************************************************/
-- print 'CREACION DE CATALOGO OPERACIONES PARA ATRIBUCIONES.'
/************************************************************************/
declare @w_tabla smallint
select @w_tabla = isnull(max(codigo), 0) + 1
  from cobis..cl_tabla
insert into cl_catalogo_pro(cp_producto, cp_tabla)  values ('CWF',@w_tabla)
insert into cobis..cl_tabla(codigo, tabla, descripcion)
  values  (@w_tabla, 'wf_operacion_atr', 'OPERACION SOBRE ATRIBUCION')
update cobis..cl_seqnos
  set siguiente = @w_tabla
  where tabla = 'cl_tabla'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'SEL', 'SELECCIONAR', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'APR', 'APROBAR', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, 'REC', 'RECHAZAR', 'V')
-- insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
--  values (@w_tabla, 'EJE', 'EJECUTAR-REGULARIZAR', 'V')
go

/************************************************************************/
-- print 'CREACION DE CATALOGO TIPOS DE REQUISITOS.'
/************************************************************************/
delete cobis..cl_catalogo  where tabla in (
select ct.tabla from cobis..cl_catalogo ct, cobis..cl_tabla  t
 	 where ct.tabla = t.codigo
	   and t.tabla in ('cl_tipo_req' ,'cl_categoria_req' , 'cl_vigencia_req'))

delete cobis..cl_tabla where tabla in ('cl_tipo_req','cl_categoria_req','cl_vigencia_req')

declare @codTabla int
select @codTabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla (codigo, tabla, descripcion)
values(@codTabla, 'cl_tipo_req', 'TIPOS DE REQUISITO')

insert into cl_catalogo (tabla, codigo, valor, estado)
values(@codTabla, 'D', 'Documento', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values(@codTabla, 'N', 'Normal', 'V')
go

/************************************************************************/
-- print 'CREACION DE CATALOGO CATEGORIA DE REQUISITOS.'
/************************************************************************/
declare @codTabla int
select @codTabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla (codigo, tabla, descripcion)
values(@codTabla, 'cl_categoria_req', 'CATEGORIAS DE REQUISITO')

insert into cl_catalogo (tabla, codigo, valor, estado)
values(@codTabla, 'P', 'Personal', 'V')
go

/************************************************************************/
-- print 'CREACION DE CATALOGO ERRORES EN PROCESO'
/************************************************************************/
declare @w_tabla smallint
select  @w_tabla = isnull(max(codigo), 0) + 1
  from  cobis..cl_tabla

insert into cobis..cl_tabla     (codigo, tabla, descripcion)
                values  (@w_tabla, 'wf_errores_proceso', 'ERRORES PROCESO')
update cobis..cl_seqnos
  set siguiente = @w_tabla
  where tabla = 'cl_tabla'

insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, '1', 'El Proceso no tiene ACTIVIDADES', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, '2', 'El Proceso no posee la Actividad INICIO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, '4', 'Alguna actividad no tiene enlaces de partida', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, '8', 'Alguna actividad Fin, Lanzadora o Informativa no está conectada', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, '16', 'Alguna actividad no tiene asociado Resultados', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, '32', 'Alguna actividad no tiene asociado Destinatario', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, '64', 'Alguna actividad no tiene la información necesaria asociada a ella', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, '128', 'Algún enlace no tiene condición asociada', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, '256', 'La segunda actividad tiene una Jerarquía de Participantes como destinatario', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, '512', 'Alguna actividad  no tiene asociado un formulario de trabajo', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, '1024', 'Alguna actividad no tiene asociada una regla', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, '2048', 'El proceso no tiene definido variables que estan definida en las reglas asociadas', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, '4096', 'El proceso no tiene definido variables que estan definida en las reglas asociadas a requisitos', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, '8192', 'El proceso tiene definido jerarquías sin condición', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, '16384', 'Alguna actividad LANZADORA o INFORMATIVA no tiene información asociada', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
  values (@w_tabla, '32768', 'No todas las acciones están siendo utilizadas en los enlaces', 'V')

go

/************************************************************************/
-- print 'CREACION DE CATALOGO VIGENCIA DE REQUISITOS.'
/************************************************************************/
declare @codTabla int
select @codTabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla (codigo, tabla, descripcion)
values(@codTabla, 'cl_vigencia_req', 'VIGENCIA DE REQUISITO')

insert into cl_catalogo (tabla, codigo, valor, estado)
values(@codTabla, 'V', 'Vigente', 'V')

insert into cl_catalogo (tabla, codigo, valor, estado)
values(@codTabla, 'N', 'No Vigente', 'V')
go

use cob_workflow
go
print '===> Poblando tabla de tipo de proceso por producto con procesos de negocio'
insert into wf_producto_tipo_proceso (pp_codigo_producto, pp_tipo_proceso)
   select distinct pd_abreviatura, 'BUSINESS' 
    from cobis..cl_producto p
    where not exists(select 1 from wf_producto_tipo_proceso pp where p.pd_abreviatura=pp.pp_codigo_producto)
    and  p.pd_abreviatura <> 'MCH'
go

print '===> Poblando tabla de tipo de proceso por producto con procesos administrativos'
if not exists(select 1 from wf_producto_tipo_proceso where pp_codigo_producto ='MCH')
    insert into wf_producto_tipo_proceso (pp_codigo_producto, pp_tipo_proceso) values( 'MCH', 'ADMIN' )
go

print '===> Actualizando Vigencia de Todos lo Requisitos, si existiesen'
update wf_tipo_documento set td_vigencia_doc = 'V'
go

/************************************************************************/
-- print 'CREACION DE CATALOGO ERRORES DE PROCESO.'
/************************************************************************/
delete cobis..cl_catalogo  where tabla in (
select ct.tabla from cobis..cl_catalogo ct, cobis..cl_tabla  t
 	 where ct.tabla = t.codigo
	   and t.tabla in ('wf_errores_proceso'))

delete cobis..cl_tabla where tabla in ('wf_errores_proceso')

declare @codTabla int
select @codTabla = max(codigo) + 1 from cobis..cl_tabla

insert into cobis..cl_tabla (codigo, tabla, descripcion)
values(@codTabla, 'wf_errores_proceso', 'ERRORES PROCESO')

insert into cobis..cl_catalogo(tabla, codigo, valor, estado) values (@codTabla, '1', 'El Proceso no tiene ACTIVIDADES', 'V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado) values (@codTabla, '2', 'El Proceso no posee la Actividad INICIO', 'V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado) values (@codTabla, '4', 'Alguna actividad no tiene enlaces de partida', 'V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado) values (@codTabla, '8', 'Actividad Fin, Lanzadora o Informativa no están conectada', 'V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado) values (@codTabla, '16', 'Alguna actividad no tiene asociado Resultados', 'V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado) values (@codTabla, '32', 'Alguna actividad no tiene asociado Destinatario', 'V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado) values (@codTabla, '64', 'Alguna actividad LAN. o INF. no tiene inf. asociada', 'V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado) values (@codTabla, '128', 'Actividad no tiene la información necesaria asociada a ella', 'V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado) values (@codTabla, '256', 'Algún enlace no tiene condición asociada', 'V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado) values (@codTabla, '512', 'La 2da actividad tiene Jer. de Participantes como destinatario', 'V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado) values (@codTabla, '1024', 'Alguna actividad  no tiene asociado un formulario de trabajo', 'V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado) values (@codTabla, '2048', 'Alguna actividad no tiene asociada una regla', 'V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado) values (@codTabla, '4096', 'El proceso no tiene variables que estan en reglas asociadas', 'V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado) values (@codTabla, '16384', 'El proceso tiene definido jerarquías sin condición', 'V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado) values (@codTabla, '32768', 'No todas las acciones están siendo utilizadas en los enlaces', 'V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado) values (@codTabla, '65536','No todas las variables de las políticas estan asociadas al proceso','V')

go

/************************************************************************/
-- print 'CREACION DE CATALOGO TIPO DISTRIBUCION DE CARGA.'
/************************************************************************/
delete cobis..cl_catalogo  where tabla in (
select ct.tabla from cobis..cl_catalogo ct, cobis..cl_tabla  t
 	 where ct.tabla = t.codigo
	   and t.tabla in ('wf_tipo_dist_carga'))

delete cobis..cl_tabla where tabla in ('wf_tipo_dist_carga')

declare @codTabla int
select @codTabla = max(codigo) + 1 from cobis..cl_tabla

insert into cobis..cl_tabla (codigo, tabla, descripcion)
values(@codTabla, 'wf_tipo_dist_carga', 'Tipos de distribuciones de carga')

insert into cobis..cl_catalogo(tabla, codigo, valor, estado) values (@codTabla, 'ESP', 'ESPECIFICA', 'V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado) values (@codTabla, 'MCN', 'MENOR CARGA NUMERO', 'V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado) values (@codTabla, 'MCT', 'MENOR CARGA TIEMPO', 'N')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado) values (@codTabla, 'NIN', 'NINGUNO', 'V')

go

/************************************************************************/
-- print 'CREACION DE CATEGORIA REQUISITO.'
/************************************************************************/
delete cobis..cl_catalogo  where tabla in (
select ct.tabla from cobis..cl_catalogo ct, cobis..cl_tabla  t
 	 where ct.tabla = t.codigo
	   and t.tabla in ('cl_categoria_req'))

delete cobis..cl_tabla where tabla in ('cl_categoria_req')

declare @codTabla int
select  @codTabla = max(codigo) + 1 from cobis..cl_tabla

insert into cobis..cl_tabla (codigo, tabla, descripcion)
values(@codTabla, 'cl_categoria_req', 'CATEGORIAS DE REQUISITO')

insert into cobis..cl_catalogo(tabla, codigo, valor, estado) values (@codTabla, 'P', 'Personal', 'V')

go

/*==============================================================*/
/* 					Inserción de una Jerarquia de Usuario       */
/*==============================================================*/
use cob_workflow
go

declare
@w_ip_id_programa int,
@o_siguiente      int

if not exists(select 1 from wf_info_programa where ip_nombre_programa = 'sp_jerarquia_usuario')
begin
	exec cobis..sp_cseqnos
       @i_tabla     = 'wf_info_programa',
       @o_siguiente = @w_ip_id_programa out
	   
	select @o_siguiente = @w_ip_id_programa
	insert into cob_workflow..wf_info_programa values (@o_siguiente,'sp_jerarquia_usuario','Jerarquia Usuario','PRA',null,'cob_workflow',null,null)
end
go

/*==============================================================*/
/* 					Inserción de un Resultado de Politica       */
/*==============================================================*/
use cob_workflow
go

declare
@w_ip_id_programa int,
@o_siguiente      int

if not exists(select 1 from wf_info_programa where ip_nombre_programa = 'sp_sc_resultado_politica')
begin
	exec cobis..sp_cseqnos
       @i_tabla     = 'wf_info_programa',
       @o_siguiente = @w_ip_id_programa out
	   
	select @o_siguiente = @w_ip_id_programa
	insert into cob_workflow..wf_info_programa values (@o_siguiente,'sp_sc_resultado_politica','Resultado Politica','PRA',null,'cob_pac',null,null)
end
go

/*==============================================================*/
/* 					Inserción de una Jerarquia de Usuario       */
/*==============================================================*/
use cob_workflow
go

declare
@w_codigo_variable int,
@o_siguiente      int

if not exists(select 1 from wf_variable where vb_abrev_variable = 'JEU')
begin
	exec cobis..sp_cseqnos
       @i_tabla     = 'wf_variable',
       @o_siguiente = @w_codigo_variable out
	   
	select @o_siguiente = @w_codigo_variable
	insert into cob_workflow..wf_variable values (@o_siguiente,'M-Jerarquia Usuario','JEU','M-Jerarquia Usuario','INT','0',null,'PRB','PRB','wf_tipo_jerarquia_tpl',null,null,null,'0',null)
end
go


/*==============================================================*/
/* 					Inserción de un Resultado de Politica       */
/*==============================================================*/
use cob_workflow
go

declare
@w_codigo_variable int,
@o_siguiente      int

if not exists(select 1 from wf_variable where vb_abrev_variable = 'RPO')
begin
	exec cobis..sp_cseqnos
       @i_tabla     = 'wf_variable',
       @o_siguiente = @w_codigo_variable out
	   
	select @o_siguiente = @w_codigo_variable
	insert into cob_workflow..wf_variable values (@o_siguiente,'M-Resultado Politica','RPO','M-Resultado Politica','INT','0',null,'PRB','PRB','bpl_result_policies',null,null,null,'0',null)
end
go

/*==============================================================*/
/* 					Inserción de un Resultado                   */
/*==============================================================*/
use cob_workflow
go

declare
@w_rs_codigo_resultado int,
@o_siguiente      int

if not exists(select 1 from wf_resultado where rs_nombre_resultado = 'ESCALAR')
begin
	exec cobis..sp_cseqnos
       @i_tabla     = 'wf_resultado',
       @o_siguiente = @w_rs_codigo_resultado out
	   
	select @o_siguiente = @w_rs_codigo_resultado
	insert into cob_workflow..wf_resultado values (@o_siguiente,'ESCALAR','N')
end
go

/*==============================================================*/
/* 					Inserción en ns_template                    */
/*==============================================================*/
use cobis
go

if exists (select 1 from sysobjects where name = 'ns_template')
begin
      declare @w_secuencial int
      
      select @w_secuencial = isnull(max(te_id),0) + 1
      from ns_template
      
      INSERT INTO ns_template ( te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version ) 
		       VALUES ( @w_secuencial, 'XSLT', 'NEUTRAL', 'Desviacion_Indicadores.xslt', 'A', '1.0.0.0' ) 
end

go

declare @w_id int

delete from cob_workflow..wf_tipo_documento 
where td_nombre_tipo_doc in ('COMPROBANTE LIBRO DE INGRESOS',
								'COMPROBANTE FACTURAS',
								'COMPROBANTE NOTAS DE REMISION',
								'COMPROBANTE DE GASTOS 1',
								'COMPROBANTE DE GASTOS 2',
								'COMPROBANTE DE GASTOS 3')

select @w_id = max(td_codigo_tipo_doc)+1 from cob_workflow..wf_tipo_documento

insert into cob_workflow..wf_tipo_documento values(@w_id ,'COMPROBANTE LIBRO DE INGRESOS','D','V','P')
select @w_id = @w_id + 1
insert into cob_workflow..wf_tipo_documento values(@w_id,'COMPROBANTE FACTURAS','D','V','P')
select @w_id = @w_id + 1
insert into cob_workflow..wf_tipo_documento values(@w_id,'COMPROBANTE NOTAS DE REMISION','D','V','P')
select @w_id = @w_id + 1
insert into cob_workflow..wf_tipo_documento values(@w_id,'COMPROBANTE DE GASTOS 1','D','V','P')
select @w_id = @w_id + 1
insert into cob_workflow..wf_tipo_documento values(@w_id,'COMPROBANTE DE GASTOS 2','D','V','P')
select @w_id = @w_id + 1
insert into cob_workflow..wf_tipo_documento values(@w_id,'COMPROBANTE DE GASTOS 3','D','V','P')

/*Biometrico Colectivo*/
delete cob_workflow..wf_tipo_documento where td_nombre_tipo_doc = 'SOLICITUD COMPLEMENTARIA LCR'
insert into cob_workflow..wf_tipo_documento values (30, 'SOLICITUD COMPLEMENTARIA LCR', 'D', 'V', 'P')

go




/*==============================================================*/
/* 		   Inserción resultado -- Biométrico                    */
/*==============================================================*/
use cob_workflow
go

declare
@w_rs_codigo_resultado int,
@o_siguiente           int


if not exists(select 1 from wf_resultado where rs_nombre_resultado = 'DEVOLVER INICIO')
begin
   exec cobis..sp_cseqnos
   @i_tabla     = 'wf_resultado',
   @o_siguiente = @w_rs_codigo_resultado out
	   
   select @o_siguiente = @w_rs_codigo_resultado
   insert into cob_workflow..wf_resultado values (@o_siguiente,'DEVOLVER INICIO','N','S')
end
go


