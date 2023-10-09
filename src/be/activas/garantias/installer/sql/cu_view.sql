USE cob_custodia
GO

IF OBJECT_ID ('dbo.ts_vencimiento') IS NOT NULL
	DROP VIEW dbo.ts_vencimiento
GO

create view ts_vencimiento (
secuencial, tipo_transaccion, clase, 
fecha,usuario,terminal,
oficina,tabla, filial,
sucursal,tipo_cust,custodia,
vencimiento,fecha_ven,valor,
instruccion, sujeto_cobro,num_factura,
cta_debito,mora,comision,
codigo_externo,estado_colateral,fecha_salida,
fecha_retorno,destino_colateral,segmento,ente
)
as
select 
ts_secuencial, ts_tipo_transaccion, ts_clase, 
ts_fecha,ts_usuario, ts_terminal,
ts_oficina,ts_tabla, ts_tinyint1,
ts_smallint1,ts_descripcion1,ts_int1,
ts_smallint2,ts_datetime1, ts_float1,
ts_varchar1,ts_char1,ts_varchar2,
ts_varchar3,ts_money2,ts_money3,
ts_varchar18,ts_char2,ts_datetime2,  --Cambio descripcion2 por varchar18
ts_datetime3,ts_varchar4,ts_varchar5,ts_int13
from   cu_tran_servicio
where  ts_tabla = 'cu_vencimiento'

GO

IF OBJECT_ID ('dbo.ts_tipo_custodia') IS NOT NULL
	DROP VIEW dbo.ts_tipo_custodia
GO

create view ts_tipo_custodia (
   secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,tabla,
   tipo,tipo_superior,descripcion,periodicidad,contabilizar,monetaria,tipo_bien,
   garan_empleado
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
       ts_terminal,ts_oficina,ts_tabla, ts_varchar1,
       ts_varchar2,ts_varchar3,ts_varchar5,ts_char1,ts_char2,ts_char3,ts_char16
from   cu_tran_servicio
where  ts_tabla = 'cu_tipo_custodia'

GO

IF OBJECT_ID ('dbo.ts_resul_abg') IS NOT NULL
	DROP VIEW dbo.ts_resul_abg
GO

create view ts_resul_abg  (
   secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,tabla,
   filial,sucursal,abogado,fecha_envio,fecha_recep,custodia,tipo_cust,
   fecha_concep,sufici_legal,tipo_asig,cobro_juridico,fecha_cobro,
   factura,valor_fact,observaciones,instruccion,codigo_externo
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_tabla,
	ts_tinyint1,ts_smallint1,ts_varchar1,ts_datetime1,ts_datetime2,
        ts_int1,ts_varchar2,ts_datetime3,ts_char1,ts_char2,
	ts_char3,ts_datetime4,ts_varchar3,ts_money1,ts_descripcion1,
	ts_descripcion2,ts_varchar18  -- Cambio varchar4 por varchar18
from   cu_tran_servicio
where  ts_tabla = 'cu_resul_abg'

GO

IF OBJECT_ID ('dbo.ts_recuperacion') IS NOT NULL
	DROP VIEW dbo.ts_recuperacion
GO

create view ts_recuperacion (
secuencial, tipo_transaccion, clase, 
fecha,usuario,terminal,
oficina,tabla, filial, 
sucursal,tipo_cust,custodia,
recuperacion,valor,vencimiento,
fecha_rec,cobro_vencimiento,cobro_mora,
cobro_comision,codigo_externo

)
as
select 
ts_secuencial, ts_tipo_transaccion, ts_clase, 
ts_fecha,ts_usuario, ts_terminal,
ts_oficina,ts_tabla, ts_tinyint1,
ts_smallint1,ts_descripcion1,ts_int1,
ts_smallint2, ts_float1,ts_smallint3,
ts_datetime1,ts_money2,ts_money3,
ts_money4,ts_varchar18 -- Estaba ts_descripcion2
 from   cu_tran_servicio
where  ts_tabla = 'cu_recuperacion'

GO

IF OBJECT_ID ('dbo.ts_por_inspeccionar') IS NOT NULL
	DROP VIEW dbo.ts_por_inspeccionar
GO

create view ts_por_inspeccionar  (
secuencial, tipo_transaccion, clase, 
fecha,usuario,terminal,
oficina,tabla, filial,
sucursal,tipo_cust,custodia,
status,fecha_anterior,inspector_anterior,
estado_anterior,inspector_asignado,fecha_asignacion,
cliente_principal,codigo_externo  --Aumento codigo externo
)
as
select 
ts_secuencial, ts_tipo_transaccion, ts_clase, 
ts_fecha,ts_usuario, ts_terminal,
ts_oficina,ts_tabla, ts_tinyint1,
ts_smallint1,ts_descripcion1,ts_int1,
ts_char1,ts_datetime1, ts_int2,
ts_descripcion2,ts_int3,ts_datetime2,
ts_int4,ts_varchar18
from   cu_tran_servicio
where  ts_tabla = 'cu_control_inspector'

GO

IF OBJECT_ID ('dbo.ts_poliza') IS NOT NULL
	DROP VIEW dbo.ts_poliza
GO

create view ts_poliza (
secuencial, tipo_transaccion, clase,
fecha,usuario,terminal,
oficina,tabla, aseguradora,
poliza,fecha_venc1,fecha_venc2,
moneda,monto_poliza,fecha_endozo,
monto_endozo,cobertura,detalle,
codigo_externo,fendozo_fin,renovacion,
cuenta,tipo_cta,monto_comision
)
as
select 
ts_secuencial, ts_tipo_transaccion, ts_clase, 
ts_fecha,ts_usuario, ts_terminal,
ts_oficina,ts_tabla, ts_varchar1,
ts_varchar2,ts_datetime1,ts_datetime2,
ts_tinyint1, ts_money1,ts_datetime3,
ts_money2,ts_varchar3,ts_varchar4,
ts_varchar18, ts_datetime4,ts_char1, --Cambio varchar5 por varchar18
ts_cuenta1,ts_varchar6,ts_money3
from   cu_tran_servicio
where  ts_tabla = 'cu_poliza'

GO

IF OBJECT_ID ('dbo.ts_observaciones') IS NOT NULL
	DROP VIEW dbo.ts_observaciones
GO

CREATE VIEW ts_observaciones
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal,
      oficina,
      tabla,
      lsrv, 
      srv,
      codigo_externo,
      numero,
      fecha_ob,
      usuario_ob,
      lineas     ) AS   
  SELECT
      cu_tran_servicio.ts_secuencial, 
      cu_tran_servicio.ts_tipo_transaccion, 
      cu_tran_servicio.ts_clase, 
      cu_tran_servicio.ts_fecha,
      cu_tran_servicio.ts_usuario, 
      cu_tran_servicio.ts_terminal, 
      cu_tran_servicio.ts_oficina, 
      cu_tran_servicio.ts_tabla, 
      cu_tran_servicio.ts_lsrv, 
      cu_tran_servicio.ts_srv,
      cu_tran_servicio.ts_varchar35, 
      cu_tran_servicio.ts_smallint5,   
      cu_tran_servicio.ts_datetime24,   
      cu_tran_servicio.ts_login01,   
      cu_tran_servicio.ts_smallint6  
    FROM cu_tran_servicio  
    WHERE ( cu_tran_servicio.ts_tipo_transaccion = 19935 ) OR   
          ( cu_tran_servicio.ts_tipo_transaccion = 19936 ) OR   
          ( cu_tran_servicio.ts_tipo_transaccion = 19937 )

GO

IF OBJECT_ID ('dbo.ts_item_custodia') IS NOT NULL
	DROP VIEW dbo.ts_item_custodia
GO

create view ts_item_custodia  (
secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,tabla,
filial,sucursal,tipo_cust,custodia,item,valor_item,secuencia,codigo_externo
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_tabla,
	ts_tinyint1,ts_smallint1,ts_descripcion1,ts_int1,ts_tinyint2,
        ts_varchar1,ts_smallint2,ts_varchar18 -- estaba ts_descripcion2
from   cu_tran_servicio
where  ts_tabla = 'cu_item_custodia'

GO

IF OBJECT_ID ('dbo.ts_item') IS NOT NULL
	DROP VIEW dbo.ts_item
GO

create view ts_item  (
   secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,tabla,
   tipo_custodia,item,nombre,detalle,tipo_dato,mandatorio
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_tabla,
	ts_varchar1,ts_tinyint1,ts_varchar2,ts_varchar3,ts_char1,ts_char2
from   cu_tran_servicio
where  ts_tabla = 'cu_item'

GO

IF OBJECT_ID ('dbo.ts_inspector') IS NOT NULL
	DROP VIEW dbo.ts_inspector
GO

create view ts_inspector  (
   secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,tabla,
   inspector,cta_inspector,nombre,especialidad,direccion,telefono,     
   principal,cargo,cliente_inspector,tipo_cta,ciudad,regional
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_tabla,
	ts_int1,ts_varchar1,ts_varchar2,ts_varchar3,ts_varchar4,
	ts_varchar5,ts_varchar6,ts_varchar7,ts_int2,ts_varchar8,ts_int3,
	ts_varchar9
from   cu_tran_servicio
where  ts_tabla = 'cu_inspector'

GO

IF OBJECT_ID ('dbo.ts_inspeccion') IS NOT NULL
	DROP VIEW dbo.ts_inspeccion
GO

create view ts_inspeccion  (
secuencial, tipo_transaccion, clase,
fecha,usuario,terminal,
oficina,tabla, filial,
sucursal,tipo_cust,custodia,
fecha_insp,inspector,estado,
factura, valor_fact,observaciones,
instruccion,motivo,valor_avaluo,
estado_tramite, codigo_externo
)
as
select 
ts_secuencial, ts_tipo_transaccion, ts_clase, 
ts_fecha,ts_usuario,ts_terminal,
ts_oficina,ts_tabla, ts_tinyint1,
ts_smallint1,ts_descripcion1,ts_int1,
ts_datetime1,ts_int2, ts_varchar1,
ts_varchar2,ts_money1,ts_varchar3,
ts_varchar4, ts_varchar5,ts_money2,
ts_char1,ts_varchar18  -- Estaba ts_descripcion2
from   cu_tran_servicio
where  ts_tabla = 'cu_inspeccion'

GO

IF OBJECT_ID ('dbo.ts_historia_custodia') IS NOT NULL
	DROP VIEW dbo.ts_historia_custodia
GO

create view ts_historia_custodia(
   secuencial,   tipo_transaccion,   clase, 
   fecha,        usuario,            terminal,   
   tabla,        codigo_externo,     estado,
   dep_origen,   dep_dest,           comentario
)
as
select  
   ts_secuencial,   ts_tipo_transaccion,   ts_clase, 
   ts_fecha,        ts_usuario,            ts_terminal, 
   ts_tabla,        ts_varchar1,           ts_varchar2,     
   ts_varchar3,     ts_varchar4,           ts_varchar5
from cu_tran_servicio
where ts_tabla = 'cu_historia_custodia'

GO

IF OBJECT_ID ('dbo.ts_garantias_custodia') IS NOT NULL
	DROP VIEW dbo.ts_garantias_custodia
GO

create view ts_garantias_custodia(
   secuencial,   tipo_transaccion,   clase, 
   fecha,        usuario,            terminal,   
   tabla,        tipo_gar,           cliente,
   operacion,    estado,             dep_origen,
   dep_dest,     oficina,            descrip,
   motivo,       codigo_externo,     paquete,
   secuen
)
as
select  
   ts_secuencial,   ts_tipo_transaccion,   ts_clase, 
   ts_fecha,        ts_usuario,            ts_terminal, 
   ts_tabla,        ts_varchar1,           ts_int1,
   ts_varchar2,     ts_varchar3,           ts_varchar4,
   ts_varchar5,     ts_oficina,            ts_varchar6,
   ts_varchar7,     ts_varchar8,           ts_int2,
   ts_smallint1
from cu_tran_servicio

where ts_tabla = 'cu_garantias_custodia'

GO

IF OBJECT_ID ('dbo.ts_gar_abogado') IS NOT NULL
	DROP VIEW dbo.ts_gar_abogado
GO

create view ts_gar_abogado  (
   secuencial, tipo_transaccion, clase, 
   fecha, usuario,terminal,
   oficina,tabla, filial,
   sucursal,tipo,custodia,
   codigo_externo,fecha_ant,abogado_ant, 
   abogado_asig, fecha_asig,tipo_asig,
   revisado,fenvio_carta, frecep_reporte,
   tipo_asig_ant)
as
select 
ts_secuencial, ts_tipo_transaccion, ts_clase, 
ts_fecha, ts_usuario, ts_terminal,
ts_oficina,ts_tabla, ts_tinyint1,
ts_smallint1,ts_varchar1,ts_int1,
ts_varchar18,ts_datetime1, ts_varchar3, --Cambio varchar18 por varchar2
ts_varchar4, ts_datetime2,ts_char1,
ts_char2,ts_datetime3, ts_datetime4,
ts_char3
from   cu_tran_servicio
where  ts_tabla = 'cu_gar_abogado'

GO

IF OBJECT_ID ('dbo.ts_estados_garantia') IS NOT NULL
	DROP VIEW dbo.ts_estados_garantia
GO

create view ts_estados_garantia (
   secuencial,tipo_transaccion,clase,fecha,usuario,terminal,oficina,tabla,estado,descripcion,codvalor)
as
select 
ts_secuencial, 
ts_tipo_transaccion, 
ts_clase, 
ts_fecha, 
ts_usuario, 
ts_terminal,
ts_oficina,
ts_tabla,  
ts_char1, -- eg_estado
ts_varchar1, -- eg_descripcion
ts_int1-- eg_codvalor
from   cu_tran_servicio
where  ts_tabla = 'cu_estados_garantia'

GO

IF OBJECT_ID ('dbo.ts_doc_garantia') IS NOT NULL
	DROP VIEW dbo.ts_doc_garantia
GO

create view ts_doc_garantia  (
secuencial, tipo_transaccion, clase,
fecha,usuario,terminal,
oficina,tabla,codigo_externo,
numero_obligacion, ubicacion_garantia, usuario_solicita,
motivo_solicitud,tipo_documento,numero_documento,numero_folios,observacion,
fecha_modificacion,fecha_solicitud,fecha_recibo,fecha_envio,estado) 
as
select 
ts_secuencial, ts_tipo_transaccion, ts_clase,
ts_fecha,ts_usuario, ts_terminal,
ts_oficina,ts_tabla, ts_varchar1,
ts_cuenta2,ts_varchar28, ts_varchar34,
ts_varchar29, ts_varchar30, ts_varchar31,
ts_int14,ts_varchar32, ts_datetime20,
ts_datetime21, ts_datetime22, ts_datetime23,ts_varchar33
from   cu_tran_servicio
where  ts_tabla = 'cu_doc_garantia'

GO

IF OBJECT_ID ('dbo.ts_dependencias') IS NOT NULL
	DROP VIEW dbo.ts_dependencias
GO

CREATE VIEW ts_dependencias( 
   secuencial, tipo_transaccion, clase, fecha,  usuario,     terminal, oficina,
   tabla,      lsrv,             srv,   codigo, descripcion, estado,   ambito
) 
AS   
  SELECT ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,    ts_usuario,  ts_terminal, ts_oficina, 
         ts_tabla,      ts_lsrv,             ts_srv,   ts_varchar1, ts_varchar2, ts_char1,    ts_char2
  FROM  cu_tran_servicio 
  where ts_tabla = 'cu_dependencias'

GO

IF OBJECT_ID ('dbo.ts_dep_usuario') IS NOT NULL
	DROP VIEW dbo.ts_dep_usuario
GO

CREATE VIEW ts_dep_usuario( 
   secuencial, tipo_transaccion, clase, fecha,       usuario,  terminal,    oficina,
   tabla,      lsrv,             srv,   dependencia, usuariod, descripcion, estado
) 
AS   
  SELECT ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,    ts_usuario,  ts_terminal, ts_oficina, 
         ts_tabla,      ts_lsrv,             ts_srv,   ts_varchar1, ts_varchar2, ts_varchar3, ts_char2
  FROM cu_tran_servicio 
  where ts_tabla = 'cu_dep_usuario'

GO

IF OBJECT_ID ('dbo.ts_custodia') IS NOT NULL
	DROP VIEW dbo.ts_custodia
GO

create view ts_custodia  (
secuencial, tipo_transaccion, clase,
fecha,usuario,terminal,
oficina,tabla, filial,
sucursal,tipo,custodia,
propuesta,estado, fecha_ingreso,
valor_inicial,valor_actual,moneda,
garante,instruccion,descripcion,
poliza, inspeccionar,motivo_noinsp,
suficiencia_legal,fuente_valor, situacion,
almacenera,aseguradora,cta_inspeccion,
tipo_cta, direccion_prenda,ciudad_prenda,
telefono_prenda,mes_prx_inspec, fecha_modif,
fecha_const,porcentaje_valor,periodicidad,
depositario,posee_poliza,nro_inspecciones,
intervalo, cobranza_judicial, fecha_retiro,
fecha_devolucion,fecha_modificacion, usuario_crea,
usuario_modifica,estado_poliza, cobrar_comision,
cuenta_dpf,cod_externo, fecha_insp,
abierta_cerrada,adecuada_sino, propietario,
plazo_fijo,monto_pfijo,
oficina_contabiliza,compartida, valor_compartida,
fecha_reg, fecha_prox_insp, valor_cobertura,
num_acciones,valor_accion, 
ubicacion,estado_credito, cuantia,
vlr_cuantia,licencia,fecha_vcto, 
fecha_avaluo, fecha_vencimiento,porcentaje_cobertura,
entidad_emisora,fuente_valor_accion,fecha_accion,
numero_documento,valor_bruto, anticipos,   --XVE
impuestos, retencion, valor_neto,
fecha_emision, fecha_vtodoc, fecha_inineg,
fecha_vtoneg,fecha_pago,base_calculo,
dias_negocio, num_dex, fecha_dex,
proveedor, comprador, resp_pago,
resp_dscto, tasa,siniestro,castigo,agotada,clase_custodia,
fecha_sol_exp, fecha_apr_pre,fecha_sol_rec,fecha_sol_ren,fecha_pro,num_acta_apr_pre,num_acta_apr,
clase_vehiculo,expedido,causa_nexp
)    
as
select 
ts_secuencial, ts_tipo_transaccion, ts_clase,
ts_fecha,ts_usuario, ts_terminal,
ts_oficina,ts_tabla, ts_tinyint1,
ts_smallint1,ts_varchar1,ts_int1,
ts_int2,ts_varchar2, ts_datetime1,
ts_float1,ts_float2,ts_tinyint2, --moneda
ts_int3,ts_varchar3,ts_varchar4,
ts_varchar5, ts_char1,ts_varchar6,
ts_char2, ts_varchar7, ts_char3,
ts_smallint2, ts_varchar8,ts_varchar9,
ts_varchar10, ts_varchar11,ts_int4, --ciudad_prenda
ts_varchar12, ts_tinyint3, ts_datetime2,
ts_datetime3,ts_float3,ts_varchar13,
ts_varchar14,ts_char4,ts_tinyint4,
ts_tinyint5, ts_char5, ts_datetime4,
ts_datetime5,ts_datetime6, ts_varchar15,
ts_varchar16, ts_char6, ts_char7,
ts_varchar17,ts_varchar18,ts_datetime7,  
ts_char8,ts_char9,ts_varchar19,
ts_varchar20,ts_money1,
ts_smallint3,ts_char10,ts_money2,
ts_datetime8,ts_datetime9, ts_money3,
ts_int5, ts_money4,
ts_varchar21, ts_varchar22, ts_char11,
ts_money5,ts_varchar23,ts_datetime10,
ts_datetime11,ts_datetime12,ts_float5,
ts_int7,ts_varchar24,ts_datetime13,
ts_varchar25, ts_money6, ts_money7,   --XVE
ts_float6, ts_float7, ts_money8,
ts_datetime14, ts_datetime15, ts_datetime16,
ts_datetime17, ts_datetime18, ts_varchar26,
ts_int8, ts_varchar27, ts_datetime19,
ts_int9, ts_int10, ts_int11,
ts_int12, ts_float8,ts_char13,ts_char14,ts_char15,ts_char17,
ts_datetime25, ts_datetime26,ts_datetime27,ts_datetime28,ts_datetime29,ts_varchar36,ts_varchar37,
ts_varchar38,ts_char16,ts_varchar28
from   cu_tran_servicio
where  ts_tabla = 'cu_custodia'

GO

IF OBJECT_ID ('dbo.ts_control_inspector') IS NOT NULL
	DROP VIEW dbo.ts_control_inspector
GO

create view ts_control_inspector  (
   secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,tabla,
   inspector,fenvio_carta,frecep_reporte,valor_facturado,fecha_pago
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_tabla,
	ts_int1,ts_datetime1,ts_datetime2,ts_money1,ts_datetime3
from   cu_tran_servicio
where  ts_tabla = 'cu_control_inspector'

GO

IF OBJECT_ID ('dbo.ts_control_abogado') IS NOT NULL
	DROP VIEW dbo.ts_control_abogado
GO

create view ts_control_abogado  (
secuencial, tipo_transaccion, clase, 
fecha,usuario,terminal,oficina,
tabla, abogado,fenvio_carta,
frecep_reporte,valor_facturado,valor_pagado,
fecha_pago
)
as
select 
ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
ts_terminal,ts_oficina,ts_tabla,
ts_varchar1,ts_datetime1,ts_datetime2,ts_money1,ts_money2,ts_datetime3
from   cu_tran_servicio
where  ts_tabla = 'cu_control_abogado'

GO

IF OBJECT_ID ('dbo.ts_compartida') IS NOT NULL
	DROP VIEW dbo.ts_compartida
GO

create view ts_compartida  (
secuencial, tipo_transaccion, clase,
fecha,usuario,terminal,
oficina,tabla,codigo_externo,
secuencial_comp, valor_compartida, entidad,
fecha_comp) 
as
select 
ts_secuencial, ts_tipo_transaccion, ts_clase,
ts_fecha,ts_usuario, ts_terminal,
ts_oficina,ts_tabla, ts_varchar1,
ts_int1, ts_money1, ts_int2,
ts_datetime1
from   cu_tran_servicio
where  ts_tabla = 'cu_compartida'

GO

IF OBJECT_ID ('dbo.ts_codigo_valor') IS NOT NULL
	DROP VIEW dbo.ts_codigo_valor
GO

create view ts_codigo_valor (
   secuencial,  tipo_transaccion,  clase,  fecha, usuario, 
  terminal, oficina, tabla,
   tipo, codigo_valor, descripcion, estado
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha, ts_usuario,
       ts_terminal, ts_oficina, ts_tabla, ts_varchar1, ts_int1,
       ts_varchar2, ts_char1
from   cu_tran_servicio
where  ts_tabla = 'cu_codigo_valor '

GO

IF OBJECT_ID ('dbo.ts_cliente_garantia') IS NOT NULL
	DROP VIEW dbo.ts_cliente_garantia
GO

create view ts_cliente_garantia  (
secuencial, tipo_transaccion, clase,
fecha,usuario,terminal,
oficina,tabla, filial,
sucursal,tipo_cust,custodia,
ente,principal,codigo_externo
)
as
select
ts_secuencial, ts_tipo_transaccion, ts_clase, 
ts_fecha,ts_usuario, ts_terminal,
ts_oficina,ts_tabla, ts_tinyint1,
ts_smallint1,ts_descripcion1,ts_int1,
ts_int2,ts_char1, ts_varchar18  --Cambio ts_descripcion2
from   cu_tran_servicio
where  ts_tabla = 'cu_cliente_garantia'

GO

IF OBJECT_ID ('dbo.ts_cambios_estado') IS NOT NULL
	DROP VIEW dbo.ts_cambios_estado
GO

create view ts_cambios_estado (
   secuencial,tipo_transaccion,clase,fecha,usuario,terminal,oficina,tabla,estado_ini,estado_fin,contabiliza,tranca)
as
select 
ts_secuencial, 
ts_tipo_transaccion, 
ts_clase, 
ts_fecha, 
ts_usuario, 
ts_terminal,
ts_oficina,
ts_tabla,  
ts_char1, -- ce_estado_ini
ts_char2, -- ce_estado_fin
ts_char3, -- ce_contabiliza
ts_varchar1 -- ce_tran
from   cu_tran_servicio
where  ts_tabla = 'cu_cambios_estado'

GO

IF OBJECT_ID ('dbo.ts_avaluos') IS NOT NULL
	DROP VIEW dbo.ts_avaluos
GO

create view ts_avaluos (
        secuencial,     tipo_transaccion,   clase,      fecha, 
        usuario,        terminal,           oficina,    tabla,
        custodia,       avaluo,             fec_avaluo, fec_visita, 
        concepto,       valor,              nombre,     av_p_apellido, 
        av_s_apellido,  usuario_mod,        fecha_mod 
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase,        ts_fecha,
       ts_usuario,    ts_terminal,         ts_oficina,      ts_tabla,
       ts_varchar1,   ts_int1,             ts_datetime1,    ts_datetime2, 
       ts_varchar2,   ts_money1,           ts_varchar3,     ts_varchar4,
       ts_varchar5,   ts_login01,          ts_datetime3
from   cu_tran_servicio
where  ts_tabla = 'cu_avaluos'

GO

IF OBJECT_ID ('dbo.ts_almacenera') IS NOT NULL
	DROP VIEW dbo.ts_almacenera
GO

create view ts_almacenera  (
   secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,tabla,
   almacenera,nombre,direccion,telefono,estado ,licencia
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_tabla,
	ts_smallint1,ts_varchar1,ts_varchar2,ts_varchar3,ts_char1,ts_varchar4
from   cu_tran_servicio
where  ts_tabla = 'cu_almacenera'

GO

IF OBJECT_ID ('dbo.cv_garantia_op') IS NOT NULL
	DROP VIEW dbo.cv_garantia_op
GO

CREATE VIEW cv_garantia_op 
( go_garantia,go_op_banco,go_producto,go_monto,go_moneda )
as
select gp_garantia,tr_numero_op_banco,tr_producto,tr_monto,tr_moneda
from cob_credito..cr_gar_propuesta,cob_credito..cr_tramite
where gp_tramite = tr_tramite

GO

IF OBJECT_ID ('dbo.cv_cliente_op') IS NOT NULL
	DROP VIEW dbo.cv_cliente_op
GO

CREATE VIEW cv_cliente_op
( co_ente,co_garantia,co_op_banco,co_producto,co_monto,co_moneda,co_oficina)
as
select cg_ente,go_garantia,go_op_banco,go_producto,go_monto,go_moneda,cg_sucursal
from cv_garantia_op,cu_cliente_garantia 
where cg_codigo_externo = go_garantia

GO

IF OBJECT_ID ('dbo.cl_tabla_gar') IS NOT NULL
	DROP VIEW dbo.cl_tabla_gar
GO

create view cl_tabla_gar as
select * 
from cobis..cl_tabla 
where tabla like 'cu_%'

GO

IF OBJECT_ID ('dbo.cl_parametro_gar') IS NOT NULL
	DROP VIEW dbo.cl_parametro_gar
GO

create view cl_parametro_gar as
select * 
from cobis..cl_parametro 
where pa_producto   = 'GAR'
and   pa_nemonico not in ('GARESP', 'SGMRC')     -- GAL 12/MAY/2009  PARAMETROS QUE USA EL CONSOLIDADOR NO SE MODIFICAN

GO

IF OBJECT_ID ('dbo.cl_catalogo_pro_gar') IS NOT NULL
	DROP VIEW dbo.cl_catalogo_pro_gar
GO

create view cl_catalogo_pro_gar as
select c.* 
from cobis..cl_tabla t, cobis..cl_catalogo_pro c 
where t.codigo = c.cp_tabla 
and t.tabla like 'cu_%'

GO

IF OBJECT_ID ('dbo.cl_catalogo_gar') IS NOT NULL
	DROP VIEW dbo.cl_catalogo_gar
GO

create view cl_catalogo_gar as
select c.* 
from cobis..cl_tabla t, cobis..cl_catalogo c 
where t.codigo = c.tabla 
and t.tabla like 'cu_%'

GO

