use cobis
go
set nocount on

print '<<< PARAMETROS INICIALES >>>'
print '<<< Cierre >>>'
--Fecha cierre
delete cobis..ba_fecha_cierre
 where fc_producto in (2)

declare @w_fecha_proceso datetime

select @w_fecha_proceso = isnull(fp_fecha, convert(varchar(10),getdate(),101))
from cobis..ba_fecha_proceso

insert into cobis..ba_fecha_cierre (fc_producto, fc_fecha_cierre, fc_fecha_propuesta)
values (2, @w_fecha_proceso, null)

--Path de producto
delete cobis..ba_path_pro
where pp_producto = 2

insert into cobis..ba_path_pro (pp_producto, pp_path_fuente, pp_path_destino)
values (2, 'C:\Cobis\vbatch\clientes\objetos\', 'C:\Cobis\vbatch\clientes\listados\')
go


/*  BA_BATCH  */
print 'Insertando datos en ba_batch'
go

if exists (select 1 from ba_batch where (ba_batch between 2000 and 2999)
           or ba_batch in (6658,26008,26024,26025,28991,36998))
   delete ba_batch where (ba_batch between 2000 and 2999) or ba_batch in (6658,26008,26024,26025,28991,36998,5001)
go

declare @w_serv   varchar(30),
        @w_path_fuente varchar(50),
        @w_path_destino  varchar(50)

select @w_serv = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'SRVR'
and    pa_producto = 'ADM'

select
     @w_path_destino = pp_path_destino
    ,@w_path_fuente  = pp_path_fuente
from ba_path_pro
where pp_producto = 2

select @w_path_destino = isnull(@w_path_destino, 'C:\Cobis\vbatch\clientes\listados\')
select @w_path_fuente  = isnull(@w_path_fuente,  'C:\Cobis\vbatch\clientes\objetos\')


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2000, 'BORRADO DE CABECERAS Y DETALLE DE BALANCES', 'PROCESO QUE EJECUTA EL BORRADO DE CABECERAS Y DETALLE DE BALANCES', 'QR', '2008-04-10', 2, 'R', 1, 'CL_ENTE  BALANCES', '', 'cl_ajubal.sqr', 1000, '', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2001, 'REFERENCIAS PERSONALES', 'REFERENCIAS PERSONALES DE CLIENTES', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_refpe.lis', 'cl_refpe.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2002, 'REFERENCIAS BANCARIAS', 'REFERENCIAS BANCARIAS DE CLIENTES', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_refba.lis', 'cl_refba.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2003, 'REFERENCIAS DE TARJETAS DE CREDITO', 'REFERENCIAS DE TARJETAS DE CREDITO DE CLIENTES', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_refta.lis', 'cl_refta.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2004, 'REFERENCIAS COMERCIALES', 'REFERENCIAS COMERCIALES DE CLIENTES', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_refco.lis', 'cl_refco.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2005, 'REFERENCIAS FINANCIERAS', 'REFERENCIAS FINANCIERAS DEL CLIENTE', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_reffi.lis', 'cl_reffi.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2006, 'FUENTES DE INGRESO', 'FUENTES DE INGRESO DE CLIENTES', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_emple.lis', 'cl_emple.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2007, 'DIRECCIONES Y TELEFONOS', 'DIRECCIONES Y TELEFONOS DE CLIENTES', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_direc.lis', 'cl_direc.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2008, 'GRUPOS ECONOMICOS', 'GRUPOS ECONOMICOS DE CLIENTES', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_grpec.lis', 'cl_grpec.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2009, 'DETALLE DE GRUPOS ECONOMICOS', 'DETALLE DE GRUPOS ECONOMICOS DE CLIENTES', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_grpde.lis', 'cl_grpde.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2010, 'CLIENTES Y PRODUCTOS', 'CLIENTES Y PRODUCTOS', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_proct.lis', 'cl_proct.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2011, 'RELACIONES ENTRE CLIENTES', 'RELACIONES ENTRE CLIENTES', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_relct.lis', 'cl_relct.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2012, 'INFORMACION DE CLIENTES', 'INFORMACION DE CLIENTES', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_lisct.lis', 'cl_lisct.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2013, 'REFERENCIAS INHIBITORIAS', 'REFERENCIAS INHIBITORIAS DE CLIENTES', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_refin.lis', 'cl_refin.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2014, 'INFORMACION DESACTUALIZADA', 'INFORMACION DESACTUALIZADA DE CLIENTES', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_infde.lis', 'cl_infde.sqr', 1000, 'lp', @w_serv, 'N', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2015, 'REPORTE DE OPERACIONES DE CLIENTES', 'REPORTE DE OPERACIONES DE CLIENTES', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_lisco.lis', 'cl_lisco.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2016, 'REPORTE DE OPERACIONES DE CLIENTES POR SEGMENTO', 'REPORTE DE OPERACIONES DE CLIENTES POR SEGMENTO', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_lisac.lis', 'cl_lisac.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2017, 'REPORTE DE OPERACIONES DE CLIENTES EXCEPTUADOS', 'REPORTE DE OPERACIONES DE CLIENTES EXCEPTUADOS', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_lisex.lis', 'cl_lisex.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2018, 'REPORTE MENSUAL DE OPERACIONES DE MENOR CUANTIA (CLTE)', 'REPORTE MENSUAL DE OPERACIONES DE MENOR CUANTIA POR CLIENTE', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_clime.lis', 'cl_clime.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2019, 'REPORTE DIARIO DE CLIENTES CON HOMONIMOS', 'REPORTE DIARIO DE CLIENTES CON HOMONIMOS', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_clin1.lis', 'cl_clin1.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2020, 'REPORTE DIARIO DE REFERENCIAS CON HOMONIMOS', 'REPORTE DIARIO DE REFERENCIAS CON HOMONIMOS', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_clin2.lis', 'cl_clin2.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2021, 'REPORTE DIARIO DE OPERACIONES DE MAYOR CUANTIA (CLTE)', 'REPORTE DIARIO DE OPERACIONES DE MAYOR CUANTIA POR CLIENTE', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_clidi.lis', 'cl_clidi.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2022, 'REPORTE DIARIO DE OPERACIONES DE MAYOR CUANTIA (NO CLTE)', 'REPORTE DIARIO DE OPERACIONES DE  MAYOR CUANTIA DE NO CLIENTES', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_ncldi.lis', 'cl_ncldi.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2023, 'REPORTE MENSUAL DE OPERACIONES DE MENOR CUANTIA(NO CLTE)', 'REPORTE MENSUAL DE OPERACIONED DE MENOR CUANTIA DE NO CLIENTES', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_nclme.lis', 'cl_nclme.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2024, 'PROCESO DE BLOQUEO MASIVO DE ENTER', 'PROCESO DE BLOQUEO MASIVO DE ENTER', 'QR', '2008-04-10', 2, 'R', 1, 'CL_ENTE/EL DIRRECCION /BLOQUEO/EL_LOG_BLOQUEO', '', 'cl_bloqueo.sqr', 1000, '', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2025, 'REPORTE DE REFERENCIAS PERSONALES', 'REPORTE REFERENCIAS PERSONALES CON INFORMACION DESACTUALIZADA', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_refpc.lis', 'cl_refpc.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2026, 'REPORTE DE REFERENCIAS ECONOMICAS', 'REPORTE REFERENCIAS ECONOMICAS CON INFORMACION DESACTUALIZADA', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_refca.lis', 'cl_refca.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2027, 'PROCESO VERIFICACION CLIENTES CON INFORMACION DESACTUALIZADA', 'PROCESO VERIFICACION CLIENTES CON INFORMACION DESACTUALIZADA', 'SP', '2008-04-10', 2, 'P', 1, 'CL_ENTE', NULL, 'cobis..sp_verifica_vigencia', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2028, 'REPORTE DE EMPLEOS', 'REPORTE EMPLEOS  CON INFORMACION DESACTUALIZADA', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_empca.lis', 'cl_empca.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2029, 'REPORTE DE DIRECCIONES', 'REPORTE DIRECCIONES CON INFORMACION DESACTUALIZADA', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_dirca.lis', 'cl_dirca.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2030, 'PROCESO GENERACION DATOS CLIENTES', 'PROCESO GENERACION DATOS CLIENTES', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTRO', 'cl_ejema.lis', 'cl_ejema.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2031, 'REPORTE DE PROPIEDADES', 'REPORTE PROPIEDADES CON INFORMACION DESACTUALIZADA', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_proca.lis', 'cl_proca.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2032, 'REPORTE DE INFORMACION LEGAL', 'REPORTE CLIENTES CON INFORMACION LEGAL DESACTUALIZADA', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_legca.lis', 'cl_legca.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2033, 'CARGA DE DATOS DISTRIBUCION GEOGRAFICA', 'GENEREACION DE DATOS PARA CONSULTAS DE DISTRIBUCION GEOGRAFICA', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_disge.lis', 'cl_disge.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2034, 'REPORTE DE CONSULTAS A CENTRALES DE RIESGO', 'REPORTE DE CONSULTAS A CENTRALES DE RIESGO. ORS_181.06/28/2011.JCCC', 'QR', '2010-02-28', 2, 'R', 1, 'ORDENES', 'clordconex.lis', 'clordconex.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2035, 'CARGA DE DATOS SIPLA', 'CARGA DE CAMPOS NULOS DE TABLA RP_CONSOLIDACION', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_migsipla.lis', 'cl_migsi.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2036, 'ACTUALIZACION DE DATOS', 'ACTUALIZACION DE DATOS', 'SP', '2008-05-22', 2, 'P', 1, 'REGISTROS', NULL, 'cobis..sp_actualiza_dat', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2037, 'MATRIZ DE PRODUCTOS DE CLIENTES', 'MATRIZ DE PRODUCTOS DE CLIENTES', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_conso.lis', 'cl_conso.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2038, 'REPORTE DE FECHAS DE NACIMIENTO', 'REPORTE DE FECHAS DE NACIMIENTO', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_lisna.lis', 'cl_lisna.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2039, 'REPORTE DE INGRESOS DE CLIENTES', 'REPORTE DE INGRESOS DE CLIENTES', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_lisin.lis', 'cl_lisin.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2040, 'REPORTE DE CLIENTES NUEVOS', 'REPORTE DE CLIENTES NUEVOS', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_clinu.lis', 'cl_clinu.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2041, 'REPORTE DE ELIMINACION DE GERENTE POR DESVINCULACION', 'REPORTE DE ELIMINACION DE GERENTE POR DESVINCULACION', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_gerel.lis', 'cl_gerel.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2042, 'REPORTE DE DIRECCIONES POR PRODUCTO DEL CLIENTE', 'REPORTE DE DIRECCIONES POR PRODUCTO DEL CLIENTE', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_dirpr.lis', 'cl_dirpr.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2043, 'REPORTE DE CLIENTES CON REFERENCIAS DE MERCADO Y NUEVOS PRODUCTO', 'REPORTE DE CLIENTES CON REFERENCIAS DE MERCADO Y NUEVOS PRODUCTOS', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_lisme.lis', 'cl_lisme.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2044, 'REPORTE LISTAS APROBACIONES', 'REPORTE LISTAS APROBACIONES', 'SP', '2008-04-10', 2, 'R', 1, 'aprobaciones', 'cl_rep_aprob.lis', 'cobis..sp_rep_aprob', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2045, 'LISTADO REFERENCIAS INHIBITORIAS X NRO ID', 'LISTADO REFERENCIAS INHIBITORIAS X NRO ID', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_cruce.lis', 'cl_cruce.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2046, 'REPORTE DE BANCA DOMICILIARIA', 'REPORTE DE BANCA DOMICILIARIA', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_badom.lis', 'cl_badom.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2047, 'PROCESO DE EMBARGOS PENDIENTES', 'PROCESO DE EMBARGOS PENDIENTES', 'SP', '2008-04-10', 2, 'P', 1, 'REGISTROS', NULL, 'cobis..sp_pembargo', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2048, 'REPORTE DE COMPRA Y VENTA DIVISAS', 'REPORTE DE COMPRA Y VENTA DIVISAS', 'QR', '2008-04-10', 2, 'R', 1, 'SIPLA', 'cl_aldiv.lis', 'cl_aldiv.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2049, 'ALERTA SIPLA PERSONA NATURAL', 'ALERTA SIPLA PERSONA NATURAL', 'QR', '2008-04-10', 2, 'R', 1, 'SIPLA', 'cl_alepn.lis', 'cl_alepn.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2050, 'ALERTA SIPLA PERSONA JURIDICA', 'ALERTA SIPLA PERSONA JURIDICA', 'QR', '2008-04-10', 2, 'R', 1, 'SIPLA', 'cl_alepj.lis', 'cl_alepj.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2051, 'ALERTA SIPLA NO RELACION INTERNACIONAL', 'ALERTA SIPLA NO RELACION INTERNACIONAL', 'QR', '2008-04-10', 2, 'R', 1, 'SIPLA', 'cl_alrin.lis', 'cl_alrin.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2052, 'PROMEDIO DE VENTAS', 'PROMEDIO DE VENTAS', 'QR', '2008-04-10', 2, 'R', 1, 'SIPLA', 'cl_prove.lis', 'cl_prove.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2053, 'ASIGNA ALERTA', 'ASIGNA ALERTA', 'QR', '2008-04-10', 2, 'R', 1, 'SIPLA', 'genfunal.lis', 'genfunal.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2054, 'ACTUALIZA COTIZACION', 'ACTUALIZA COTIZACION', 'QR', '2008-04-10', 2, 'R', 1, 'SIPLA', 'cl_cotiz.lis', 'cl_cotiz.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2055, 'VALIDA SIPLA', 'VALIDA SIPLA', 'QR', '2008-04-10', 2, 'R', 1, 'SIPLA', 'cl_actsi.lis', 'cl_actsi.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2056, 'REPORTE FUNCIONARIOS', 'REPORTE FUNCIONARIOS', 'QR', '2008-04-10', 2, 'R', 1, 'SIPLA', 'cl_alert.lis', 'cl_alert.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2057, 'REPORTE DE CLIENTES CON REFERENCIAS INHIBITORIAS Y NUEVOS PRODUC', 'REPORTE DE CLIENTES CON REFERENCIAS INHIBITORIAS Y NUEVOS PRODUCTOS', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_lisih.lis', 'cl_lisih.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2058, 'ARCHIVO INTERFAZ TARJETA CREDITO', 'ARCHIVO INTERFAZ TARJETA CREDITO', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cupclimmdd.lis', 'sbmigtar.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2059, 'REPORTE DE CONSOLIDACION DIARIO MENOR CUANTIA', 'REPORTE DE CONSOLIDACION DIARIO MENOR CUANTIA', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_clico.lis', 'cl_clico.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2060, 'CLIENTES NUEVOS - CONTROL DE CALIDAD', 'CLIENTES NUEVOS - CONTROL DE CALIDAD', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_gesca.lis', 'cl_gesca.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2061, 'VALIDACION ARCHIVO PLANO FC', 'VALIDACION ARCHIVO PLANO FC', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'sqr_val.lis', 'sqr_val.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2062, 'REPORTE TOTALES DE CONTROL FC', 'REPORTE TOTALES DE CONTROL FC', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'sqr_clie3.lis', 'sqr_clie3.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2063, 'REPORTE ARCHIVO PLANO FC', 'REPORTE ARCHIVO PLANO FC', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'sqr_clie5.lis', 'sqr_clie5.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2064, 'REPORTE TIPO DOCUMENTO ERROR FC', 'REPORTE TIPO DOCUMENTO ERROR FC', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'sqr_clie6.lis', 'sqr_clie6.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2065, 'LISTADO DE CLIENTES BLOQUEADOS POR OFICINAS', 'LISTADO DE CLIENTES BLOQUEADOS POR OFICINAS', 'QR', '2008-04-10', 2, 'R', 1, 'CL_ENTE/CL_OFICINA/CL_LOG_BLOQUEO', 'cl_blxof.lis', 'cl_blxof.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2066, 'LIMPIAR DATA TEMPORALES/DEFINITIVAS', 'LIMPIAR DATA TEMPORALES/DEFINITIVAS', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'mig_inicializa.lis', 'mig_inicializa.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2067, 'VALIDAR ARCHIVO PLANO', 'VALIDAR ARCHIVO PLANO', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'mig_valida.lis', 'mig_valida.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2068, 'REPORTE ERROR ARCHIVO PLANO', 'REPORTE ERROR ARCHIVO PLANO', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_larch.lis', 'cl_larch.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2069, 'MARCAR REGISTROS CON ERROR', 'MARCAR REGISTROS CON ERROR', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', '', 'cl_marer.sqr', 1000, '', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2070, 'VALIDAR INTEGRIDAD TABLAS DEFINITIVAS', 'VALIDAR INTEGRIDAD TABLAS DEFINITIVAS', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'mig_valtab.lis', 'mig_valtab.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2071, 'REPORTE ERROR INTEGRIDAD', 'REPORTE ERROR INTEGRIDAD', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_integ.lis', 'cl_integ.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2072, 'PASO A DEFINITIVAS / CREA CLAVES', 'PASO A DEFINITIVAS / CREA CLAVES', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'mig_pasdef.lis', 'mig_pasdef.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2073, 'ESTADISTICAS DE CLIENTES BLOQUEADOS', 'ESTADISTICAS DE CLIENTES BLOQUEADOS', 'QR', '2008-04-10', 2, 'R', 1, 'CL_ENTE/CL_OFICINA/CL_LOG_BLOQUEO', 'cl_blest.lis', 'cl_blest.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2074, 'ESTADISTICO DE ALERTAS POR ZONAL', 'PROCESO QUE GENERA ESTADISTICO DE ALERTAS POR ZONAL', 'QR', '2008-04-10', 2, 'R', 1, 'CL_ENTES', 'cl_axzon.lis', 'cl_axzon.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2075, 'ESTADISTICO DE ALERTAS POR REGIONAL', 'PROCESO QUE GENERA LAS ESTADISTICO DE ALERTAS POR REGIONAL', 'QR', '2008-04-10', 2, 'R', 1, 'CL_ENTES', 'cl_axreg.lis', 'cl_axreg.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2076, 'LIMPIAR DATA TEMPORALES', 'LIMPIAR DATA TEMPORALES', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', '', 'cl_inici.sqr', 1000, '', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2077, 'VALIDAR INTEGRIDAD TABLAS DEFINITIVAS', 'VALIDAR INTEGRIDAD TABLAS DEFINITIVAS', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', '', 'cl_vatab.sqr', 1000, '', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2078, 'PASO A DEFINITIVAS', 'PASO A DEFINITIVAS', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', '', 'cl_padef.sqr', 1000, '', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2079, 'VALIDAR ARCHIVO PLANO', 'VALIDAR ARCHIVO PLANO', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', '', 'cl_valid.sqr', 1000, '', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2080, 'CONSULTA MASIVA CENTRALIZADA', 'CONSULTA MASIVA CENTRALIZADA', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', '', 'cl_busma.sqr', 1000, '', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2081, 'PROCESO NOVEDADES SINERGY CLIENTES', 'PROCESO NOVEDADES SINERGY CLIENTES', 'SP', '2008-04-10', 2, 'P', 1, 'cl_ente, cl_direccion, cl_telefono', NULL, 'cobis..sp_interface_sinergy', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2082, 'CARGA Y PROCESO DE EMBARGOS PIT', 'CARGA Y PROCESO DE EMBARGOS PIT', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', '', 'cl_valem.sqr', 1000, '', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2083, 'REPORTE GENERAL DE EMBARGOS PENDIENTES', 'REPORTE GENERAL DE EMBARGOS PENDIENTES', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_embar.lis', 'cl_embar.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2084, 'NOVEDADES DE CLIENTES - CONTROL DE CALIDAD', 'NOVEDADES DE CLIENTES - CONTROL DE CALIDAD', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', 'cl_novcl.lis', 'cl_novcl.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2085, 'ELIMINACION MASIVA DE ENTES', 'ELIMINACION MASIVA DE ENTES', 'QR', '2008-04-10', 2, 'R', 1, 'REGISTROS', '', 'cl_elime.sqr', 1000, '', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2086, 'REPORTE MODIFICACION DE REGIMEN FISCAL - CLIENTES', 'REPORTE MODIFICACION DE REGIMEN FISCAL - CLIENTES', 'QR', '2008-04-10', 2, 'R', 1, 'CLIENTES', 'cl_regfi.lis', 'cl_regfi.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2087, 'DEPURACION DE DATOS TRANS SERVICIO - PASO A HISTORICOS', 'DEPURACION DE DATOS TRANS SERVICIO - PASO A HISTORICOS', 'QR', '2008-04-10', 2, 'R', 1, '', '', 'cl_depur.sqr', 1000, '', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2088, 'CATEGORIZAR CLIENTES VIP', 'CATEGORIZAR CLIENTES VIP', 'QR', '2008-04-10', 2, 'R', 1, 'CLIENTES', '', 'clclivip.sqr', 1000, '', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2089, 'PLANO CLIENTES VIP', 'PLANO CLIENTES VIP', 'QR', '2008-04-10', 2, 'R', 1, 'CLIENTES', 'clplavip.lis', 'clplavip.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2090, 'CLIENTES MAS REPRESENTATIVOS DEL PASIVO', 'CLIENTES MAS REPRESENTATIVOS DEL PASIVO', 'QR', '2008-04-10', 2, 'R', 1, 'PRODUCTO BANCO', 'clmasrep.lis', 'clmasrep.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2091, 'CLIENTES POR PRODUCTO ( PASIVAS )', 'CLIENTES POR PRODUCTO ( PASIVAS )', 'QR', '2008-04-10', 2, 'R', 1, 'PRODUCTO BANCO', 'clporpro.lis', 'clporpro.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2092, 'CLIENTES POR TIPO DE VIVIENDA', 'CLIENTES POR TIPO DE VIVIENDA', 'QR', '2008-04-10', 2, 'R', 1, 'CLIENTES', 'cl_tviv.lis', 'cl_tviv.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2093, 'CLIENTES SIN GERENTE ASOCIADO', 'CLIENTES SIN GERENTE ASOCIADO', 'QR', '2008-04-10', 2, 'R', 1, 'CLIENTES', 'cl_nogte.lis', 'cl_nogte.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2094, 'PROSPECTOS PARA CREDITO', 'PROSPECTOS PARA CREDITO', 'QR', '2008-04-10', 2, 'R', 1, 'CLIENTES', 'cl_prosec.lis', 'cl_prosec.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2095, 'PROCEDENCIA DE CLIENTE POR OFICINA, ZONA, REGION Y TOTAL', 'PROCEDENCIA DE CLIENTE POR OFICINA, ZONA, REGION Y TOTAL', 'QR', '2008-04-10', 2, 'R', 1, 'CLIENTES', 'cl_proclt.lis', 'cl_proclt.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2096, 'GENERA ESTADISTICAS DE CLIENTES', 'GENERA ESTADISTICAS DE CLIENTES', 'QR', '2008-04-10', 2, 'R', 1, 'CLIENTES', 'cl_genest.lis', 'cl_genest.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2097, 'SUBE ARCHIVOS DE MIGRACION CLIENTE', 'SUBE ARCHIVOS DE MIGRACION CLIENTE', 'QR', '2008-04-10', 2, 'P', 1, 'CLIENTES', NULL, 'cl_bcp.sqr', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2098, 'VALIDA TABLAS TMP DE MIGRACION CLIENTE', 'VALIDA TABLAS TMP DE MIGRACION CLIENTE', 'SP', '2009-08-07 09:15:44.193', 2, 'P', 1, 'CLIENTES', NULL, 'cobis..sp_val_maestro_cl', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2099, 'INSERTA EN TABLAS DEFINITIVAS COBIS CLIENTE', 'INSERTA EN TABLAS DEFINITIVAS COBIS CLIENTE', 'SP', '2009-08-07 09:15:44.193', 2, 'P', 1, 'CLIENTES', NULL, 'cobis..sp_ins_maestro_cl', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2100, 'TRASLADO DE CLIENTES', 'TRASLADO DE CLIENTES', 'QR', '2008-05-12', 2, 'P', 1, 'CLIENTES', NULL, 'cl_traclte.sqr', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2101, 'REPORTE DE REGISTROS CON DOCUMENTO DEFAULT EN LISTA DE REFERENCI', 'REPORTE DE REGISTROS CON DOCUMENTO DEFAULT EN LISTA DE REFERENCI', 'QR', '2008-07-01', 2, 'R', 1, 'CL_REFINH', 'cllisofa.lis', 'cllisofa.sqr', 100, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2102, 'INICIALIZA POSIBLES PROMEDIOS DE CLIENTES', 'INICIALIZA POSIBLES PROMEDIOS DE CLIENTES', 'QR', '2008-04-10', 2, 'R', 1, 'CLIENTES', '', 'cl_iniprom.sqr', 1000, '', @w_serv, 'N', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2103, 'ARCHIVO PLANO DE POSIBLES PROMEDIOS DE CLIENTES', 'ARCHIVO PLANO DE POSIBLES PROMEDIOS DE CLIENTES', 'QR', '2008-04-10', 2, 'R', 1, 'CLIENTES', '', 'cl_planprom.sqr', 1000, '', @w_serv, 'N', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2104, 'CARGA LISTA ANTITERRORISTA/ONU', 'CARGA LISTA ANTITERRORISTA/ONU', 'QR', '2008-07-01', 2, 'P', 1, 'CL_REFINH', NULL, 'cliterr.sqr', 100, NULL, @w_serv, 'S', @w_path_fuente, NULL)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2105, 'CARGA TEMPORALES REFERENCIAS INHIBITORIAS', 'CARGA TEMPORALES REFERENCIAS INHIBITORIAS', 'QR', '2008-07-01', 2, 'P', 1, 'CL_REFINH', NULL, 'clcarlis.sqr', 100, NULL, @w_serv, 'S', @w_path_fuente, NULL)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2106, 'DEPURACION TIPO DE BANCA A COMPANIAS CON NATURALEZA JURIDICA OFI', 'DEPURACION TIPO DE BANCA A COMPANIAS CON NATURALEZA JURIDICA OFICIAL', 'QR', '2008-04-10', 2, 'R', 1, 'CLENTES', '', 'cl_actbanca.sqr', 1000, '', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2107, 'CARGA LISTA OFAC', 'CARGA LISTA OFAC', 'QR', '2008-07-01', 2, 'P', 1, 'CL_REFINH', NULL, 'clinofac.sqr', 100, NULL, @w_serv, 'S', @w_path_fuente, NULL)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2108, 'CARGA TEMPORALES REFERENCIAS INHIBITORIAS', 'CARGA TEMPORALES REFERENCIAS INHIBITORIAS', 'QR', '2008-10-30', 2, 'P', 1, 'OFAC', NULL, 'clcarlis.sqr', 10, NULL, @w_serv, 'S', @w_path_fuente, NULL)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2109, 'ESTADISTICAS MIGRACION CLIENTES', 'ESTADISTICAS MIGRACION CLIENTES', 'QR', '2008-11-13', 2, 'R', 1, 'CLIENTES', 'cl_estad.lis', 'cl_estd.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2110, 'INTENTOS DE VINCULACION - CLIENTES NO OBJETIVO SARLAFT', 'INTENTOS DE VINCULACION - CLIENTES NO OBJETIVO SARLAFT
', 'QR', '2010-09-20', 2, 'R', 1, 'CL_INTENTOS_RESTRICTIVAS', 'cl_intentos.lis', 'cl_intentos.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2112, 'REPORTE MARCACIONES GMF', 'REPORTE MARCACIONES GMF
FORMATO_BATCH_INC_081539_V1.xlsx', 'SP', '2012-07-21', 2, 'R', 1, 'CLIENTES', 'REPO_MARC_GMF_DDMMAAAA_HHMM.txt', 'cobis..sp_marcacion_cifin', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2113, 'INVOCA MASIVO CLIENTES EXTERNOS', 'INVOCA MASIVO CLIENTES EXTERNOS', 'SP', '2012-06-19', 2, 'R', 1, 'CLIENTES', 'crea_cliente.txt', 'cobis..sp_invoca_masivo_cliext', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2115, 'CANCELACION ALIANZAS COMERCIALES', 'CANCELACION ALIANZAS COMERCIALES', 'SP', '2014-01-20', 2, 'P', 1, 'ALIANZAS', NULL, 'cobis..sp_validacan_alianza', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2116, 'RESULTADO PROCESO MASIVO CARGA DE ALIANZAS', 'RESULTADO PROCESO MASIVO CARGA DE ALIANZAS', 'SP', '2014-01-20', 2, 'R', 1, 'ALIANZAS', 'No tiene por que envio por correo', 'cobis..sp_proc_masivos', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2117, 'REPORTE ERRORES DE CARGA MASIVA', 'REPORTE ERRORES DE CARGA MASIVA', 'SP', '2016-05-09 16:35:18.023', 2, 'R', 1, 'ALIANZAS', 'Procesados_error_FechaProceso_HoraProceso.txt', 'cobis..sp_err_masivos', 1000, 'lp', '', 'S', '', '')
GO
declare @w_serv   varchar(30),
        @w_path_fuente varchar(50),
        @w_path_destino  varchar(50)

select @w_serv = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'SRVR'
and    pa_producto = 'ADM'

select
     @w_path_destino = pp_path_destino
    ,@w_path_fuente  = pp_path_fuente
from ba_path_pro
where pp_producto = 2

select @w_path_destino = isnull(@w_path_destino, 'C:\Cobis\vbatch\clientes\listados\')
select @w_path_fuente  = isnull(@w_path_fuente,  'C:\Cobis\vbatch\clientes\objetos\')


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2118, 'REPORTE EVENTUAL MARCACION C012', 'REPORTE EVENTUAL MARCACION C012', 'SP', '2014-07-15', 2, 'R', 1, 'CLIENTES', 'C012_fecha.txt', 'cobis..sp_rep_c012', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2120, 'CARGA DE INFORMACION PARA PLANO DE CARTERA', 'CARGA DE INFORMACION PARA PLANO DE CARTERA', 'QR', '2008-04-10', 2, 'R', 1, '', 'clejecca.lis', 'clejecca.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2121, 'GENERA PLANO DE CARTERA', 'GENERA PLANO DE CARTERA', 'QR', '2008-04-10', 2, 'R', 1, '', 'clprocca.lis', 'clprocca.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2122, 'ACTUALIZACION  DE CLIENTES CONVIVENCIA DESDE PIT REUTILIZA RECH', 'ACTUALIZACION  DE CLIENTES CONVIVENCIA DESDE PIT REUTILIZA RECH', 'QR', '2008-04-10', 2, 'R', 1, 'CLIENTES', '', 'cl_actpitcobis.sqr', 1000, '', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2123, 'CONVIVENCIA PIT POSIBLES NOV-PROMEDIOS CLIENTES', 'CONVIVENCIA PIT DE POSIBLES NOV-PROMEDIOS DE CLIENTES', 'QR', '2008-04-10', 2, 'R', 1, 'CLIENTES', '', 'clprompit.sqr', 1000, '', @w_serv, 'N', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2124, 'HOMOLOGACION CODIGOS CIIU', 'HOMOLOGACION CODIGOS CIIU
CC_328           02/23/2013', 'SP', '2013-02-23', 2, 'R', 1, 'CLIENTES', 'listados.lis', 'cobis..sp_homologa_data', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2125, 'REPORTE CLIENTE SARLAFT EVENTUAL', 'REPORTE CLIENTE SARLAFT EVENTUAL
FTO_PARAM_BATCH_ORS599.xlsx', 'SP', '2013-10-23', 2, 'R', 1, 'CLIENTES	', 'sp_reporte_sarlaft.txt', 'cobis..sp_reporte_sarlaft', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2126, 'PROCESO BATCH EVENTUAL PARA ACT NOMBRES DE CLIENTES', 'PROCESO BATCH EVENTUAL PARA ACT NOMBRES DE CLIENTES
FTO_PARAM_BATCH_ORS613 - V 2.xlsx
', 'SP', '2013-08-13', 2, 'R', 1, 'CLIENTES', 'ACT_NOMBRE_CLIENTE.txt', 'cobis..sp_act_nom_cliente', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2127, 'REPORTE EVENTUAL CALIDATA SARLAFT', 'REPORTE EVENTUAL CALIDATA SARLAFT
FTO_PARAM_BATCH_ORS599.xlsx', 'SP', '2013-10-23', 2, 'R', 1, 'CLIENTES	', 'sp_calidata.txt', 'cobis..sp_calidata', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2128, 'PROCESO BATCH EVENTUAL PARA ACTUALIZAR MALA REFERENCIA', 'PROCESO BATCH EVENTUAL PARA ACTUALIZAR MALA REFERENCIA
ORS_617', 'SP', '2013-08-30', 2, 'R', 1, 'CLIENTES', 'Autorizacion_Sarlaft.txt', 'cobis..sp_autorizacion_sarlaft', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2129, 'REPORTE CAMPOS CON INCONSISTENCIA', 'REPORTE CAMPOS CON INCONSISTENCIA', 'SP', '2014-07-10', 2, 'P', 1, 'CLIENTES', NULL, 'cobis..sp_campos_incons', 1000, NULL, @w_serv, 'N', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2133, 'REPORTE DE CONSULTAS A DATACREDITO SIN ASOCIACION', 'REPORTE DE CONSULTAS A DATACREDITO SIN ASOCIACION', 'QR', '2010-12-01', 2, 'R', 1, 'CONSULTA A DATACREDITO', 'clcondatold.lis', 'clcondatold.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2134, 'Informe actualizacion clientes', 'Informe actualizacion clientes
FTO_PARAM_BATCH_Req254_V02.xlsx
CC_254', 'SP', '2012-01-20', 2, 'R', 1, 'CLIENTES', 'PLANO_ACT_CLI_DDMMAAAA_HHMM.txt', 'cobis..cl_plano_act_cli', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2135, 'MIGRACION CLIENTES BANTOTAL', 'MIGRACION CLIENTES BANTOTAL ORS_448               10/15/2015', 'SP', '2015-10-15', 2, 'P', 1, 'CLIENTES', NULL, 'migra_personas..sp_migra_personas', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2136, 'BCP Funcionarios Quincenal', 'BCP Funcionarios Quincenal
ORS_492       10/09/2012', 'SP', '2012-10-09', 2, 'P', 1, 'funcionarios', NULL, 'cobis..sp_reporte_func', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2140, 'ACTUALIZACION MASIVA C012', 'ACTUALIZACION MASIVA C012', 'SP', '2013-04-13', 2, 'P', 1, 'CLIENTES', NULL, 'cobis..sp_actmasc012', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2141, 'EXTRACCION DE DATOS Y CARGUE A ESTRUCTURAS', 'EXTRACCION DE DATOS Y CARGUE A ESTRUCTURAS FO-009-Req_349_V5.xlsx CC_349', 'SP', '2013-03-20', 2, 'P', 1, 'TRANSACCIONES', NULL, 'cob_conta_super..sp_extrac_cobros_c012', 100, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2142, 'GENERACION DE ARCHIVOS PLANOS DE EXTRACTOS DE COSTOS FINANCIEROS', 'GENERACION DE ARCHIVOS PLANOS DE EXTRACTOS DE COSTOS FINANCIEROS PARA IMPRESIaN CC_349 FO-009-Req_349_V5.xlsx', 'SP', '2013-03-20', 2, 'R', 1, 'TRANSACCIONES', 'ExtCobrosGUIA.txt', 'cob_conta_super..sp_genera_plano_extcob', 100, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2143, 'GENERACION DE ARCHIVOS PLANOS DE EXTRACTOS DE COSTOS FINANCIEROS', 'GENERACION DE ARCHIVOS PLANOS DE EXTRACTOS DE COSTOS FINANCIEROS PARA CORREO FO-009-Req_349_V5.xlsx CC_349', 'SP', '2013-03-20', 2, 'R', 1, 'TRANSACCIONES', 'ExtCobrosDATA.txt', 'cob_conta_super..sp_genera_plano_extcob', 100, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2144, 'VALIDACION PLANO MARCACION DIRECCION EXTRACTO C012', 'VALIDACION PLANO MARCACION DIRECCION EXTRACTO C012', 'SP', '2013-03-19', 2, 'R', 1, 'CLIENTES', '<nombre_archivo>_salida.txt', 'cobis..sp_marca_extC12', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2145, 'MARCACION DIRECCION EXTRACTO COSTOS DEL MODULO DE CLIENTES', 'MARCACION DIRECCION EXTRACTO COSTOS DEL MODULO DE CLIENTES
FTO_PARAM_BATCH_CCA_364_V01.xlsx', 'SP', '2013-03-19', 2, 'R', 1, 'CLIENTES', '<nombre_archivo>_salida.txt', 'cobis..sp_marca_extC12', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2146, 'GENERACION ARCHIVOS PARA IMPRESIàN COSTOS FINANCIEROS', 'GENERACION ARCHIVOS PARA IMPRESIàN COSTOS FINANCIEROS', 'SP', '2014-03-07', 2, 'R', 1, 'TRANSACCIONES', 'ExtCobrosDATA_I_OF9999_YYYY_YYYYMMDD.TXT', 'cob_conta_super..sp_genera_archivo_extcob', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2153, 'PROCESO BATCH EVENTUAL PARA ACTUALIZAR VALIDACION CENTRALES DE R', 'PROCESO BATCH EVENTUAL PARA ACTUALIZAR VALIDACION CENTRALES DE RIESGO
FTO_PARAM_BATCH_ORS_670_V01.xlsx', 'SP', '2013-10-22', 2, 'P', 1, 'CLIENTES', NULL, 'cobis..sp_cliente_segmento', 1000, NULL, @w_serv, 'N', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2154, 'REPORTE CUPOS ALIANZAS COMERCIALES', 'REPORTE CUPOS ALIANZAS COMERCIALES', 'SP', '2014-03-07', 2, 'R', 1, 'CLIENTES', 'Cupos_Alianzas_dd_mm_aaaa.txt', 'cobis..sp_cupo_global', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2155, 'GENERAR EXTRACTOS DE COSTOS FINANCIEROS', 'GENERAR EXTRACTOS DE COSTOS FINANCIEROS', 'SP', '2014-03-07', 2, 'P', 1, 'TRANSACCIONES', NULL, 'cob_conta_super..sp_generar_extcob', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2156, 'DESMARCACION CLIENTES ALTO RIESGO', 'DESMARCACION CLIENTES ALTO RIESGO
CC_423
', 'SP', '2015-01-17', 2, 'P', 1, 'CLIENTES', NULL, 'cobis..sp_desmarca_riesgo', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2157, 'CARGA ARCHIVO SEGDEUVEN', 'CARGA ARCHIVO SEGDEUVEN Formato_creacion_batch_REQ_446.xlsx  CC_446', 'SP', '2014-12-09', 2, 'P', 1, 'clientes', NULL, 'cobis..sp_carga_reclamaciones', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2158, 'PROCESO CAMBIO ESTADOS REGISTROS FATCA', 'PROCESO CAMBIO ESTADOS REGISTROS FATCA
CC_430         05/14/2015', 'SP', '2015-05-14', 2, 'R', 1, 'CLIENTES', 'PROCESO_RECALCITRANTE_mmddaaa', 'cobis..sp_estados_fatca', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2159, 'GENERACION DE SOLITIUD PARA TRASLADOS', 'GENERACION DE SOLITIUD PARA TRASLADOS
CC_432', 'SP', '2015-10-01', 2, 'R', 1, 'CLIENTES', 'TRASLADOS		', 'cobis..sp_carga_traslado', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2160, 'TRASLADO DE PRODUCTOS PASIVOS', 'TRASLADO DE PRODUCTOS PASIVOS
CC_432', 'SP', '2015-10-01', 2, 'R', 1, 'CLIENTES', 'TRASLADOS', 'cobis..sp_traslado_oficina', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2199, 'ACTUALIZACION MASIVA DE TOTALES FINANCIEROS DE CLIENTES', 'ACTUALIZACION MASIVA DE TOTALES FINANCIEROS DE CLIENTES', 'QR', '2008-04-10', 2, 'R', 1, '', '', 'cl_acttotales.sqr', 1000, '', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2200, 'GENERACION DE ARCHIVO PLANO DE CLIENTES PARA UN RANGO DE FECHAS', 'GENERACION DE ARCHIVO PLANO DE CLIENTES PARA UN RANGO DE FECHAS', 'QR', '2009-02-18', 2, 'P', 1, '', '', 'cl_arcente.sqr', 1000, '', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2201, 'GENERACION ESTADISTICAS DE MIGRACION', 'GENERACION ESTADISTICAS DE MIGRACION', 'SP', '2009-08-07 09:15:44.193', 2, 'P', 1, 'MIGRACION', NULL, 'cobis..sp_estadistica_mig', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2202, 'GENERACION METRICAS DE MIGRACION', 'GENERACION METRICAS DE MIGRACION', 'SP', '2009-08-07 09:15:44.193', 2, 'P', 1, 'DATOS', NULL, 'cobis..sp_metricas', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2203, 'CONTROL MIGRACION', 'PROCESO CONTROL MIGRACION', 'SP', '2009-08-07 09:15:44.193', 2, 'P', 1, 'DATOS', NULL, 'cobis..sp_control_mig', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2204, 'REPORTE DE APARTADOS AEREOS NO VIGENTES', 'REPORTE DE APARTADOS AEREOS NO VIGENTES', 'QR', '2009-05-11 20:47:24.543', 2, 'R', 1, 'REGISTROS', 'cl_casxcaduc.sqr', 'cl_casxcaduc.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2205, 'VERIFICACION DE HOMONIMOS / CRUCE CEDULAS', 'VERIFICACION DE HOMONIMOS / CRUCE CEDULAS

', 'SP', '2009-05-11', 2, 'P', 1, 'cl_ente', NULL, 'cobis..sp_compara_nomsipla', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2206, 'ENVIO DE DATOS PARA VALIDACION CENTRALES DE RIESGO', 'ENVIO DE DATOS PARA VALIDACION CENTRALES DE RIESGO', 'QR', '2009-05-11 20:47:24.543', 2, 'P', 1, 'REGISTROS', 'cl_envcenrie.sqr', 'cl_envcenrie.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2207, 'REPORTE DE CLIENTES CON DATOS BASICOS INCOMPLETOS', 'REPORTE DE CLIENTES CON DATOS BASICOS INCOMPLETOS', 'QR', '2009-05-11 20:47:24.543', 2, 'R', 1, 'REGISTROS', 'cl_estcl.sqr', 'cl_estcl.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2208, 'MAESTRO DE CLIENTES', 'MAESTRO DE CLIENTES', 'QR', '2009-05-11 20:47:24.543', 2, 'P', 1, 'REGISTROS', 'cl_maest.sqr', 'cl_maest.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2209, 'REPORTE DE CLIENTES Y PRODUCTOS', 'REPORTE DE CLIENTES Y PRODUCTOS', 'QR', '2009-05-11 20:47:24.543', 2, 'R', 1, 'REGISTROS', 'cl_prosr.sqr', 'cl_prosr.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2210, 'LISTADO DE RELACIONES ENTRE CLIENTES', 'LISTADO DE RELACIONES ENTRE CLIENTES', 'QR', '2009-05-11 20:47:24.543', 2, 'R', 1, 'REGISTROS', 'cl_refct.sqr', 'cl_refct.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2211, 'PROCESO SP TRASLADO CLIENTES', 'PROCESO SP TRASLADO CLIENTES
CO-BMI-SPR-00375-FORMATO_CREACION_PROCESOS_BATCH.xlsx', 'SP', '2009-05-21', 2, 'R', 1, 'CLIENTES', 'tracli.txt', 'cobis..sp_traslada_cliente', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2220, 'CLIENTES REPORTADOS EN LISTAS DE REFERENCIAS SARLAFT/RESTRICTIVA', 'CLIENTES EN LISTAS DE REFERENCIAS SARLAFT/RESTRICTIVAS', 'QR', '2010-09-20', 2, 'R', 1, 'cl_refinh', 'clisarlaf.lis', 'clisarlaf.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2221, 'CLIENTES REPORTADOS EN REFERENCIAS SARLAFT/ NO RESTRICTIVAS', 'CLIENTES REPORTADOS EN REFERENCIAS SARLAFT/ NO RESTRICTIVAS		', 'QR', '2010-09-20', 2, 'R', 1, 'cl_refinh', 'clisarlaftnr.lis', 'clisarlaftnr.sqr', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2222, 'CARGUE TOTAL LISTAS WORLD COMPIANCE', 'CARGUE TOTAL LISTAS WORLD COMPIANCE', 'SP', '2010-09-20', 2, 'P', 1, 'cl_refinh', NULL, 'cobis..sp_verifhom', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2223, 'CARGUE LISTAS WORLD COMPIANCE - ARCHIVO DELTA', 'CARGUE LISTAS WORLD COMPIANCE - ARCHIVO DELTA', 'SP', '2010-09-20', 2, 'P', 1, 'cl_refinh', NULL, 'cobis..sp_verifhom', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2224, 'CONSOLIDADOR CLIENTES', 'CONSOLIDADOR CLIENTES', 'SP', '2010-05-31', 2, 'P', 1, 'CLIENTES', NULL, 'cobis..sp_cons_cliente', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2225, 'reporte actualizacion clientes por ruta critica', 'reporte actualizacion clientes por ruta critica', 'SP', '2011-01-21', 2, 'P', 1, 'clientes', NULL, 'cobis..sp_reporte_trn', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2226, 'PROCESO DE VALIDACION ARCHIVO SEGMENTACION', 'PROCESO DE VALIDACION ARCHIVO SEGMENTACION
FTO_PARAM_BATCH_CCA_000153.xlsx', 'SP', '2011-04-11', 2, 'P', 1, 'cl_ente', NULL, 'cobis..sp_segmenta', 100, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2227, 'PROCESO DE VALIDACION Y CARGUE ARCHIVO SEGMENTACION', 'PROCESO DE VALIDACION Y CARGUE ARCHIVO SEGMENTACION
FTO_PARAM_BATCH_CCA_000153.xlsx', 'SP', '2011-04-11', 2, 'P', 1, 'cl_ente', NULL, 'cobis..sp_segmenta', 100, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2228, 'PROCESO DE VALIDACION Y CARGUE ARCHIVO FINAGRO', 'PROCESO DE VALIDACION Y CARGUE ARCHIVO FINAGRO
FTO_PARAM_BATCH_CCA_000153.xlsx', 'SP', '2011-04-11', 2, 'P', 1, 'cl_ente', NULL, 'cobis..sp_act_finagro', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2229, 'reporte usuarios cobis', 'reporte usuarios cobis
Formato_cracion_batch_lotes_ors234.xlsx
CC_234', 'SP', '2011-10-04', 2, 'P', 1, 'usuarios', NULL, 'cobis..sp_reportes_usuarios', 100, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2230, 'ACTUALIZACION DE CORREOS DE FUNCIONARIOS', 'ACTUALIZACION DE CORREOS DE FUNCIONARIOS
FORMATO_BATCH_ORS_286_V1.xlsx', 'SP', '2011-12-05', 2, 'P', 1, 'FUNCIONARIOS', NULL, 'cobis..sp_func_correo', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2231, 'MARCACION DE CLIENTES POR OLA INVERNAL', 'MARCACION DE CLIENTES POR OLA INVERNAL', 'SP', '2011-12-23', 2, 'P', 1, 'CLIENTES', NULL, 'cobis..sp_ola_invernal', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2232, 'ACTUALIZACION SEGMENTO CLIENTE', 'ACTUALIZACION SEGMENTO CLIENTE
', 'SP', '2012-04-16', 2, 'P', 1, 'CLIENTES', NULL, 'cobis..sp_actualiza_seg', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2233, 'ACTUALIZA TIPO DE PERSONA', 'ACTUALIZA TIPO DE PERSONA.FORMATO_BATCH_LLS42910_V1.xlsx', 'SP', '2012-01-20', 2, 'P', 1, 'CLIENTES', NULL, 'cobis..sp_act_tipoper', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2234, 'CARGA DE BARRIOS', 'CARGA DE BARRIOS. LLS_115.01/25/2012.JCCC', 'SP', '2012-01-25', 2, 'P', 1, 'BARRIOS', NULL, 'cobis..sp_adic_barrios', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2235, 'ANULACION DE ORDENES DE COBRO PARA CERTIFICACIONES', 'ANULACION DE ORDENES DE COBRO PARA CERTIFICACIONES.REQ_250_V1_03/26/2012.JCCC', 'SP', '2012-03-26', 2, 'P', 1, 'ORDENES', NULL, 'cobis..sp_anu_orden_cert', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2236, 'ACTUALIZACION DE DATOS CATALOGOS CLIENTES', 'ACTUALIZACION DE DATOS CATALOGOS CLIENTES', 'SP', '2013-01-23', 2, 'P', 1, 'COBIS', NULL, 'cobis..sp_act_catalogo_ente', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2237, 'PROCESO MASIVO DE CREACION CLIENTES UNIVERSO', 'PROCESO MASIVO DE CREACION CLIENTES UNIVERSO', 'SP', '2014-01-20', 2, 'P', 1, 'CLIENTES', NULL, 'cobis..sp_batch_clientes_msv', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2238, 'PROCESO MASIVO DE CREACION CLIENTES BATCH HILOS', 'PROCESO MASIVO DE CREACION CLIENTES BATCH HILOS', 'SP', '2014-01-20', 2, 'P', 1, 'CLIENTES', NULL, 'cobis..sp_batch_clientes_msv', 1000, NULL, @w_serv, 'C', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2239, 'VALIDACION NEGOCIO UNIVERSO', 'VALIDACION NEGOCIO UNIVERSO FO-CCA000353 FORMATO_CREACION_PROCESOS_BATCH_V13.xlsx CC_353', 'SP', '2014-01-20', 2, 'P', 1, 'CLIENTES', NULL, 'cobis..sp_batch_negocio_msv', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2240, 'VALIDACION NEGOCIO HILOS', 'VALIDACION NEGOCIO HILOS FO-CCA000353 FORMATO_CREACION_PROCESOS_BATCH_V13.xlsx CC_353', 'SP', '2014-01-20', 2, 'P', 1, 'CLIENTES', NULL, 'cobis..sp_batch_negocio_msv', 1000, NULL, @w_serv, 'C', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2241, 'REPORTE CARGUE WORLD COMPIANCE', 'REPORTE CARGUE WORLD COMPIANCE
ORS_619', 'SP', '2014-02-26', 2, 'R', 1, 'CLIENTES', 'cl_reporte_verifhom', 'cobis..sp_repo_verifhom', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2242, 'Eliminacion Consultas Externas Fallidas', 'Eliminacion Consultas Externas Fallidas
01/26/2015', 'SP', '2015-01-26', 2, 'P', 1, 'Clientes', NULL, 'cobis..sp_ordext_fallida', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2243, 'PROCESO MASIVO VALIDACION PRODUCTOS ACTIVOS REFERIDOS', 'PROCESO MASIVO VALIDACION PRODUCTOS ACTIVOS REFERIDOS', 'SP', '2015-10-22', 2, 'P', 1, 'CLIENTES', NULL, 'cobis..sp_msv_valrefe', 1000, NULL, @w_serv, 'N', @w_path_fuente, NULL)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2246, 'REPORTE CLIENTES CON PRODUCTOS CANCELADOS', 'REPORTE CLIENTES CON PRODUCTOS CANCELADOS', 'SP', '2015-10-21', 2, 'P', 1, 'CLIENTES', NULL, 'cobis..sp_rep_prodcan', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)

INSERT into cobis..ba_batch
      (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado,ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso,ba_path_fuente, ba_path_destino)
VALUES(2247, 'ARCHIVOS XML SINCRONIZACION POR CLIENTE', 'ARCHIVOS XML SINCRONIZACION POR CLIENTE','SP', '2017-09-13',2,'P',1,'cl_ente',null, 'cob_sincroniza..sp_sinc_arch_xml',1000,null,@w_serv,'S', @w_path_fuente, null)

INSERT into cobis..ba_batch
      (ba_batch, ba_nombre, ba_descripcion,ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado,ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso,ba_path_fuente, ba_path_destino)
VALUES(2248, 'ARCHIVOS XML SINCRONIZACION CLIENTES DESACTUALIZADOS', 'ARCHIVOS XML SINCRONIZACION CLIENTES DESACTUALIZADOS','SP', '2017-09-13',2,'P',1,'cl_ente',null,'cob_sincroniza..sp_sinc_arch_xml',1000,null,@w_serv,'S',@w_path_fuente, null)

INSERT into cobis..ba_batch
      (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado,ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso,ba_path_fuente, ba_path_destino)
VALUES(2249, 'ARCHIVOS XML SINCRONIZACION CLIENTES MASIVO', 'ARCHIVOS XML SINCRONIZACION CLIENTES MASIVO','SP', '2017-09-13', 2, 'P', 1, 'cl_ente',null, 'cob_sincroniza..sp_sinc_arch_xml', 1000, null, @w_serv, 'S', @w_path_fuente, null )


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2250, 'CARGA ARCHIVOS PARA CREAR CLIENTES', 'CARGA ARCHIVOS PARA CREAR CLIENTES', 'SP', '2017-09-13', 2, 'P', 1, 'CLIENTES', NULL, 'cobis..sp_cl_masiva_carga', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2251, 'CREACION MASIVA DE CLIENTES', 'CREACION MASIVA DE CLIENTES', 'SP', '2017-09-13', 2, 'P', 1, 'CLIENTES', NULL, 'cobis..sp_cl_masiva_crear', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2252, 'REPORTE DE CREACION DE CLIENTES', 'REPORTE DE CREACION DE CLIENTES', 'SP', '2017-09-13', 2, 'P', 1, 'CLIENTES', NULL, 'cobis..sp_cl_masiva_rpt', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)

insert into cobis..ba_batch
      (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado,ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso,ba_path_fuente, ba_path_destino)
values(2253, 'ARCHIVOS DE CLIENTES EN LISTAS NEGRAS', 'ARCHIVOS DE CLIENTE EN LISTAS NEGRAS','SP', '2017-11-24',2,'P',1,'cl_ente',null, 'cobis..sp_batch_lista_negra',1000,null,'CLOUDSRV','S', @w_path_fuente, null)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (26008, 'PROCESO MENSUAL TARJETA DEBITO', 'PROCESO MENSUAL TARJETA DEBITO
CC_498', 'SP', '2015-10-01', 2, 'R', 1, 'CLIENTES', 'concilia_TD', 'cob_wservices..sp_compensa_cob_red_mes', 1000, 'lp', @w_serv, 'S', 'F:\Vbatch\Ahorros\RBM\', 'F:\Vbatch\Ahorros\RBM\')


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (26024, 'CARGA INFORMACION PARA PLANO DE OPERACIONES POR OFICINA', 'CARGA INFORMACION PARA PLANO DE OPERACIONES POR OFICINA', 'SP', '2015-11-09', 2, 'R', 1, 'CLIENTES', 'transacciones_of_MMDDYYYY.txt', 'cobis..sp_transaccion_of', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (26025, 'GENERA PLANO DE REPROCESO DE TRANSACCIONES DE OFICINA', 'GENERA PLANO DE REPROCESO DE TRANSACCIONES DE OFICINA
', 'SP', '2015-11-09', 2, 'R', 1, 'MIS', 'sb_transacciones_of_MMDDYYYY.txt', 'cob_conta_super..sp_transaccion_of_sb', 1000, 'lp', @w_serv, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (28991, 'ELIMINACION DE REGISTROS INTERFAZ PROVEEDORES CLIENTES DYNAMICS', 'ELIMINACION REG INTERFAZ CLIENTES DYNAMICS REQ_292_V01.xlsx', 'SP', '2011-12-26', 2, 'P', 1, 'CLIENTES', NULL, 'cobis..sp_borra_cobis_dynamics', 1000, NULL, @w_serv, 'S', @w_path_fuente, NULL)
GO

-- -----------------------------------------------------------------------------------------------------
----'
use cobis
go

declare @w_batch int, @w_fecha_proceso datetime, @w_path_fuente varchar(50), @w_path_destino varchar(50)
select @w_batch = 5001
----------------->>>>>>>>>>>>>>>>>Registro de batch
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

select @w_path_fuente = pp_path_fuente,
	@w_path_destino  = pp_path_destino
from ba_path_pro where pp_producto = 5

select @w_path_fuente  = isnull(@w_path_fuente,  'C:\Cobis\vbatch\regulatorios\objetos\')
select @w_path_destino = isnull(@w_path_destino, 'C:\Cobis\vbatch\regulatorios\listados\')
----'
insert into ba_batch (
	ba_batch, 		ba_nombre, 		ba_descripcion,		ba_lenguaje, 		ba_fecha_creacion, 	ba_producto, 
	ba_tipo_batch, 	ba_sec_corrida, ba_ente_procesado,	ba_arch_resultado, 	ba_arch_fuente, 	ba_frec_reg_proc, 
	ba_impresora, 	ba_serv_destino,ba_reproceso, 		ba_path_fuente, 	ba_path_destino)
values (
	@w_batch, 'RTE EVALUACION GRUPAL EN017', 'RTE EVALUACION GRUPAL EN017', 'SP', @w_fecha_proceso, 5, 
	'R', 1, 'EVALUACION EN017', 'Reporte_EvalGrupal_', 'cobis..sp_eval_grp_en017', 1000, 
	NULL, 'CTSSRV', 'S', @w_path_fuente, @w_path_destino)
-- -----------------------------------------------------------------------------------------------------


/*  BA_PARAMETRO  */

print 'Insertando datos en ba_parametro'
go
if exists (select 1 from ba_parametro where pa_batch between 2000 and 2999)
   delete ba_parametro where pa_batch between 2000 and 2999
go

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2000, 0, 1, 'OPCION', 'C', 'D')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2000, 0, 2, 'FECHA PROCESO', 'D', '03/28/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2001, 0, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2001, 0, 2, 'OFICINA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2001, 0, 3, 'GERENTE', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2001, 0, 4, 'FECHA INICIO', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2001, 0, 5, 'FECHA FIN', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2002, 0, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2002, 0, 2, 'OFICINA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2002, 0, 3, 'GERENTE', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2002, 0, 4, 'FECHA INICIO', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2002, 0, 5, 'FECHA FIN', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2003, 0, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2003, 0, 2, 'OFICINA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2003, 0, 3, 'GERENTE', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2003, 0, 4, 'FECHA INICIO', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2003, 0, 5, 'FECHA FIN', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2004, 0, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2004, 0, 2, 'OFICINA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2004, 0, 3, 'GERENTE', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2004, 0, 4, 'FECHA INICIO', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2004, 0, 5, 'FECHA FIN', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2005, 0, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2005, 0, 2, 'OFICINA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2005, 0, 3, 'GERENTE', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2005, 0, 4, 'FECHA INICIO', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2005, 0, 5, 'FECHA FIN', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2006, 0, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2006, 0, 2, 'OFICINA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2006, 0, 3, 'GERENTE', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2006, 0, 4, 'FECHA INICIO', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2006, 0, 5, 'FECHA FIN', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2007, 0, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2007, 0, 2, 'OFICINA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2007, 0, 3, 'GERENTE', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2007, 0, 4, 'FECHA INICIO', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2007, 0, 5, 'FECHA FIN', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2008, 0, 1, 'GERENTE', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2010, 0, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2010, 0, 2, 'OFICINA', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2010, 0, 3, 'GERENTE', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2010, 0, 4, 'SUBTIPO (COMPANIA, PERSONA)', 'C', 'P')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2010, 0, 5, 'FECHA INICIO', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2010, 0, 6, 'FECHA FIN', 'D', '10/01/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2011, 0, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2012, 0, 2, 'OFICINA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2012, 0, 3, 'GERENTE', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2012, 0, 4, 'SUBTIPO(COMPANIA, PERSONA)', 'C', 'P')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2012, 0, 5, 'FECHA INICIO', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2012, 0, 6, 'FECHA FIN', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2014, 0, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2014, 0, 2, 'OFICINA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2014, 0, 3, 'GERENTE', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2014, 0, 4, 'FECHA INICIO', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2014, 0, 5, 'FECHA FIN', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2015, 0, 1, 'FECHA INICIO', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2015, 0, 2, 'FECHA FIN', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2015, 0, 3, 'CONSOLIDADO (S/N)', 'C', 'S')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2016, 0, 1, 'FECHA INICIO', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2016, 0, 2, 'FECHA FIN', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2016, 0, 3, 'CONSOLIDADO (S/N)', 'C', 'S')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2016, 0, 4, 'SEGMENTO', 'C', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2017, 0, 1, 'FECHA INICIO', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2017, 0, 2, 'FECHA FIN', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2017, 0, 3, 'CONSOLIDADO (S/N)', 'C', 'S')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2018, 0, 1, 'FECHA INICIO', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2018, 0, 2, 'FECHA FIN', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2019, 0, 1, 'FECHA PROCESO', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2020, 0, 1, 'FECHA PROCESO', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2021, 0, 1, 'FECHA INICIO', 'D', '08/09/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2021, 0, 2, 'FECHA FIN', 'D', '08/09/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2022, 0, 1, 'FECHA INICIO', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2022, 0, 2, 'FECHA FIN', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2023, 0, 1, 'FECHA INICIO', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2023, 0, 2, 'FECHA FIN', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2030, 0, 1, 'TIPO', 'C', 'C')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2030, 0, 2, 'FECHA', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2033, 0, 1, 'FECHA PROCESO', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2034, 0, 1, 'FECHA DESDE', 'D', '11/01/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2034, 0, 2, 'FECHA HASTA', 'D', '11/01/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2034, 0, 3, 'MODO (VALORES POSIBLES D - C)', 'C', 'C')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2035, 0, 1, 'FECHA PROCESO', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2036, 0, 1, 'FECHA PROCESO', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2037, 0, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2037, 0, 2, 'OFICINA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2037, 0, 3, 'GERENTE', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2037, 0, 4, 'FECHA INICIO', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2037, 0, 5, 'FECHA FIN', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2038, 0, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2038, 0, 2, 'OFICINA', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2038, 0, 3, 'GERENTE', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2038, 0, 4, 'MES', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2039, 0, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2039, 0, 2, 'OFICINA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2039, 0, 3, 'GERENTE', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2039, 0, 4, 'MONTO MINIMO', 'M', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2039, 0, 5, 'MONTO MAXIMO', 'M', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2040, 0, 1, 'FILIAL', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2040, 0, 2, 'OFICINA', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2040, 0, 3, 'GERENTE', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2040, 0, 4, 'FECHA INICIO', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2040, 0, 5, 'FECHA FIN', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2041, 0, 1, 'FECHA INICIO', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2041, 0, 2, 'FECHA FIN', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2042, 0, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2042, 0, 2, 'OFICINA', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2042, 0, 3, 'GERENTE', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2042, 0, 4, 'FECHA INICIO', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2042, 0, 5, 'FECHA FIN', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2043, 0, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2043, 0, 2, 'OFICINA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2043, 0, 3, 'GERENTE', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2043, 0, 4, 'FECHA INICIO', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2043, 0, 5, 'FECHA FIN', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2044, 0, 1, 'FECHA INICIAL', 'D', '01/01/2010')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2044, 0, 2, 'FECHA FINAL', 'D', '01/01/2010')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2046, 0, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2046, 0, 2, 'OFICINA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2046, 0, 3, 'GERENTE', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2046, 0, 4, 'FECHA INICIO', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2046, 0, 5, 'FECHA FIN', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2048, 0, 1, 'NUMERO DE OPERACIONES', 'I', '30')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2048, 0, 2, 'FECHA INICIO', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2048, 0, 3, 'FECHA FIN', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2049, 0, 1, 'UNIDADES', 'M', '1000000')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2049, 0, 2, 'FECHA INICIO', 'D', '08/27/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2049, 0, 3, 'FECHA FIN', 'D', '08/27/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2050, 0, 1, 'UNIDADES', 'M', '1000000')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2050, 0, 2, 'FECHA INICIO', 'D', '08/06/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2050, 0, 3, 'FECHA FIN', 'D', '08/06/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2051, 0, 1, 'FECHA INICIO', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2051, 0, 2, 'FECHA FIN', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2052, 0, 1, 'UNIDADES', 'M', '1000000')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2053, 0, 1, 'FECHA INICIO', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2053, 0, 2, 'FECHA FIN', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2054, 0, 1, 'FECHA INICIO', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2054, 0, 2, 'FECHA FIN', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2056, 0, 1, 'NIVEL GERENTE', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2056, 0, 2, 'NUMERO DE DIAS', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2057, 0, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2057, 0, 2, 'OFICINA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2057, 0, 3, 'GERENTE', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2057, 0, 4, 'FECHA INICIO', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2057, 0, 5, 'FECHA FIN', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2058, 0, 1, 'EMPRESA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2058, 0, 2, 'FECHA PROCESO', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2059, 0, 1, 'FECHA INICIO', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2059, 0, 2, 'FECHA FIN', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2060, 0, 1, 'FECHA INICIO', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2060, 0, 2, 'FECHA FIN', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2061, 0, 1, 'TIPO OPERACION', 'C', 'V')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2061, 0, 2, 'NOM ARCHIVO', 'C', '')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2067, 0, 1, 'NOM ARCHIVO', 'C', '')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2067, 0, 2, 'FECHA PROCESO', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2077, 0, 1, 'OPERACION', 'C', 'I')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2078, 0, 1, 'OPERACION', 'C', 'I')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2079, 0, 1, 'DIRECTORIO', 'C', '/convivencia/clientes/datosentrada/')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2079, 0, 2, 'NOM ARCHIVO', 'C', 'cl_cliente20050707_1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2079, 0, 3, 'FECHA PROCESO', 'D', '07/08/2005')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2080, 0, 1, 'NOM ARCHIVO', 'C', '')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2081, 0, 1, 'FECHA PROCESO', 'D', '05/31/2010')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2082, 0, 1, 'NOM ARCHIVO', 'C', '')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2082, 0, 2, 'FECHA PROCESO', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2084, 0, 1, 'FECHA INICIO', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2084, 0, 2, 'FECHA FIN', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2086, 0, 1, 'FECHA INICIO', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2086, 0, 2, 'FECHA FIN', 'D', '06/30/2006')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2087, 0, 1, 'FECHA INICIAL', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2087, 0, 2, 'FECHA FINAL', 'D', '10/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2088, 0, 1, 'FECHA PROCESO', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2092, 0, 1, 'OFICINA', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2092, 0, 2, 'PRODUCTO', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2092, 0, 3, 'TIPO VIVIENDA', 'C', '001')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2093, 0, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2093, 0, 2, 'OFICINA', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2093, 0, 4, 'FECHA INICIO', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2093, 0, 5, 'FECHA FIN', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2094, 0, 1, 'FECHA INICIAL', 'D', '01/01/2007')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2094, 0, 2, 'FECHA FINAL', 'D', '01/01/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2094, 0, 3, 'OFICINA', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2097, 0, 1, 'FECHA_PROCESABLE', 'D', '10/31/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2097, 0, 2, 'MODO', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2098, 0, 1, 'PATH SALIDA', 'C', 'F:\Vbatch\Clientes\Validar\')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2099, 0, 1, 'PATH SALIDA', 'C', 'F:\Vbatch\Clientes\Insertar\')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2100, 0, 1, 'NOMBRE ARCHIVO', 'C', 'archivo.txt')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2101, 0, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2103, 0, 1, 'FECHA PROCESO', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2104, 0, 1, 'FECHA PROCESO', 'D', '07/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2105, 0, 1, 'FECHA PROCESO', 'D', '08/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2105, 0, 2, 'LISTA (OFAC/ONU)', 'C', 'ONU')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2105, 0, 3, 'ARCHIVO', 'C', 'ONUSDN.DEL')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2107, 0, 1, 'FECHA PROCESO', 'D', '07/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2108, 0, 1, 'FECHA DE PROCESO', 'D', '08/28/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2108, 0, 2, 'LISTA (OFAC/ONU)', 'C', 'OFAC')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2108, 0, 3, 'ARCHIVO', 'C', 'OFACSDN.DEL')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2109, 0, 1, 'FECHA', 'D', '11/23/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2110, 0, 1, 'FECHA INICIO', 'D', '01/01/2010')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2110, 0, 2, 'FECHA FIN', 'D', '01/01/2010')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2112, 0, 1, 'FECHA INICIAL', 'D', '01/01/2012')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2112, 0, 2, 'FECHA FINAL', 'D', '01/01/2012')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2113, 0, 1, 'FECHA INICIO', 'D', '01/13/2012')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2113, 0, 2, 'TIPO CLIENTE', 'C', '007')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2116, 0, 1, 'Fecha de Proceso', 'D', '01/01/2014')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2116, 0, 2, 'ID Transaccion ', 'C', 'C')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2116, 0, 3, 'Tipo de Transaccion en caso (T o N) en Parametro 2', 'C', 'O')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2116, 0, 4, 'Numero de carga', 'C', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2117, 0, 1, 'Fecha de Proceso', 'D', '01/01/2014')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2117, 0, 2, 'Tipo proceso', 'C', 'T')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2118, 0, 1, 'FECHA INICIAL', 'D', '01/01/2014')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2118, 0, 2, 'FECHA FINAL', 'D', '06/30/2014')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2120, 0, 1, 'FECHA_VTO_OBLIGACION', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2121, 0, 1, 'TIPO_CONSOLIDADO(P-R-Z-O)', 'C', 'P')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2122, 0, 1, 'PROCESO', 'I', '22')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2122, 0, 2, 'FECHA PROCESO', 'D', '01/01/2006')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2122, 0, 3, 'ARCHIVO CLIENTES', 'C', 'novinfo_client_gen')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2122, 0, 4, 'ARCHIVO DIRECCIONES', 'C', 'novinfo_client_dir')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2122, 0, 5, 'ARCHIVO LEGAL', 'C', 'novinfo_client_leg')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2122, 0, 6, 'ARCHIVO BALANCE', 'C', 'novinfo_client_bal')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2122, 0, 7, 'ARCHIVO DIRPRODUCTO', 'C', 'novinfo_client_dpro')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2123, 0, 1, 'TIPO DE PROCESO', 'I', '22')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2123, 0, 2, 'FECHA PROCESO', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2123, 0, 3, 'NOMBRE DE ARCHIVO', 'C', 'clnovprom20070101')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2125, 0, 1, 'FECHA INICIO', 'D', '10/23/2013')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2125, 0, 2, 'FECHA FIN', 'D', '10/23/2013')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2127, 0, 1, 'FECHA REPORTE', 'D', '10/23/2013')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2133, 0, 1, 'FECHA DESDE', 'D', '12/01/2010')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2133, 0, 2, 'FECHA HASTA', 'D', '12/01/2010')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2134, 0, 1, 'FECHA INICIAL', 'D', '01/30/2011')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2134, 0, 2, '''FECHA FINAL', 'D', '01/31/2011')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2134, 0, 3, 'OPCION (O = Oficina, T= Todas)', 'C', 'T')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2134, 0, 4, 'CODIGO OFICINA', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2135, 0, 1, 'NOMBRE TABLA', 'C', 'BJD001')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2135, 0, 2, 'OFICINA(S)', 'C', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2135, 0, 3, 'ZONA', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2135, 0, 4, 'FECHA PROCESO', 'D', '10/01/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2136, 0, 1, 'fecha de proceso', 'D', '09/01/2012')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2140, 0, 1, 'NOMBRE ARCHIVO', 'C', 'Nombre Archivo')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2141, 0, 1, 'AÑO GENERACION', 'C', 'AAAA')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2142, 0, 1, 'AÑO GENERACION', 'C', 'AAAA')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2142, 0, 2, 'TIPO (I)', 'C', 'I')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2143, 0, 1, 'AÑO GENERACION', 'C', 'AAAA')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2143, 0, 2, 'TIPO (P)', 'C', 'E')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2144, 0, 1, 'TIPO (C,A)', 'C', 'C')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2144, 0, 2, 'NOMBRE ARCHIVO', 'C', '<ARCHIVO_TERCERO.TXT>')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2145, 0, 1, 'TIPO (C,A)', 'C', 'A')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2145, 0, 2, 'NOMBRE ARCHIVO', 'C', '<ARCHIVO_TERCERO.TXT>')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2146, 0, 1, 'A¥O GENERACION', 'C', 'AAAA')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2146, 0, 2, 'TIPO (I)', 'C', 'I')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2146, 0, 3, 'TIPO OFICINA', 'C', 'T')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2146, 0, 4, 'CODIGO OFICINA', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2153, 0, 1, 'FECHA PROCESO', 'D', '10/22/2013')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2155, 0, 1, 'GENERA REPORTES', 'C', 'S')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2158, 0, 1, 'FECHA REPORTE', 'D', '04/01/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2159, 0, 1, 'OFICINA ORIGEN', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2159, 0, 2, 'OFICINA DESTINO', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2159, 0, 3, 'NOMBRE DEL ARCHIVO A PROCESAR', 'C', 'CARGUE_CIERRE')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2159, 0, 4, 'TIPO TRASLADO', 'C', 'COM/CIE')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2160, 0, 1, 'FECHA PROCESO', 'D', '10/01/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2199, 0, 1, 'FECHA PROCESO', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2200, 0, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2200, 0, 2, 'FECHA INICIAL', 'D', '03/01/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2200, 0, 3, 'FECHA FINAL', 'D', '03/01/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2201, 0, 1, 'ETAPA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2202, 0, 1, 'PATH SALIDA', 'C', 'F:\Vbatch\Clientes\Archivos\')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2202, 0, 2, 'DATA (H/V)', 'C', 'V')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2203, 0, 1, 'DATA (H/V)', 'C', 'V')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2206, 0, 1, 'FECHA', 'D', '01/06/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2207, 0, 1, 'FECHA', 'D', '01/06/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2207, 0, 2, 'CONSOLIDADO (S/N)', 'C', 'S')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2209, 0, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2209, 0, 2, 'OFICINA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2209, 0, 3, 'GERENTE', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2209, 0, 4, 'SUBTIPO (COMPANIA, PERSONA)', 'C', 'P')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2209, 0, 5, 'FECHA INICIO', 'D', '01/06/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2209, 0, 6, 'FECHA FIN', 'D', '01/06/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2210, 0, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2220, 0, 1, 'FECHA INICIO', 'D', '01/01/2010')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2220, 0, 2, 'FECHA FIN', 'D', '01/01/2010')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2221, 0, 1, 'FECHA INICIO', 'D', '01/01/2010')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2221, 0, 2, 'FECHA FIN', 'D', '01/01/2010')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2222, 0, 1, 'ARCHIVO', 'C', 'Entities.txt')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2222, 0, 2, 'OPERACION', 'C', 'W')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2222, 0, 3, 'PATH', 'C', 'F:\Vbatch\Clientes\Archivos')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2223, 0, 1, 'ARCHIVO', 'C', 'EntitiesDeletions.txt')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2223, 0, 2, 'OPERACION', 'C', 'D')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2223, 0, 3, 'PATH', 'C', 'F:\Vbatch\Clientes\Archivos')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2224, 0, 1, 'FECHA DE PROCESO', 'D', '01/01/2010')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2225, 0, 1, 'fecha de proceso', 'D', '01/01/2010')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2225, 0, 2, 'Nombre del Archivo de Salida', 'C', 'ACT_CLIENTES')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2226, 0, 1, 'NOMBRE DEL ARCHIVO', 'C', 'cl_nomarch.txt')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2226, 0, 2, 'TIPO PROCESO (VALIDACION O CARGUE)', 'C', 'V')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2226, 0, 3, 'PATH ARCIVO DE CARGUE', 'C', 'F:\Vbatch\Clientes\Archivos')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2227, 0, 1, 'NOMBRE DEL ARCHIVO', 'C', 'cl_nomarch.txt')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2227, 0, 2, 'TIPO PROCESO (VALIDACION O CARGUE)', 'C', 'C')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2227, 0, 3, 'PATH ARCIVO DE CARGUE', 'C', 'F:\Vbatch\Clientes\Archivos')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2228, 0, 1, 'NOMBRE DEL ARCHIVO', 'C', 'cl_nomarch.txt')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2228, 0, 2, 'TIPO PROCESO (VALIDACION O CARGUE)', 'C', 'C')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2228, 0, 3, 'PATH ARCIVO DE CARGUE', 'C', 'F:\Vbatch\Clientes\Archivos')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2229, 0, 1, 'fecha proceso', 'D', '09/27/2011')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2230, 0, 1, 'EMPRESA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2230, 0, 2, 'ARCHIVO', 'C', 'Nombre_Archivo_Plano')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2231, 0, 1, 'EMPRESA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2231, 0, 2, 'ARCHIVO', 'C', 'nombre archivo plano')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2231, 0, 3, 'MARCACION/DESMARCACION', 'C', 'M')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2234, 0, 1, 'EMPRESA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2234, 0, 2, 'ARCHIVO', 'C', 'archivo plano')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2235, 0, 1, 'FECHA PROCESO', 'D', '03/26/2012')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2236, 0, 1, 'FECHA DE PROCESO', 'D', '01/17/2013')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2237, 0, 1, 'HIJO', 'C', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2237, 0, 2, 'SARTA', 'C', '2013')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2237, 0, 3, 'BATCH', 'C', '2238')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2237, 0, 4, 'OPCION', 'C', 'G')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2237, 0, 5, 'BLOQUE', 'C', '2')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2238, 0, 1, 'HIJO', 'C', '2')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2238, 0, 2, 'SARTA', 'C', '2013')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2238, 0, 3, 'BATCH', 'C', '2238')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2238, 0, 4, 'OPCION', 'C', 'B')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2238, 0, 5, 'BLOQUE', 'C', '25')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2239, 0, 1, 'HIJO', 'C', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2239, 0, 2, 'SARTA', 'C', '2014')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2239, 0, 3, 'BATCH', 'C', '2240')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2239, 0, 4, 'OPCION', 'C', 'G')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2239, 0, 5, 'BLOQUE', 'C', '2')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2240, 0, 1, 'HIJO', 'C', '2')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2240, 0, 2, 'SARTA', 'C', '2014')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2240, 0, 3, 'BATCH', 'C', '2240')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2240, 0, 4, 'OPCION', 'C', 'B')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2240, 0, 5, 'BLOQUE', 'C', '25')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2241, 0, 1, 'FECHA DE PROCESO', 'D', '02/26/2014')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2242, 0, 1, 'Fecha de Proceso', 'D', '01/01/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2242, 0, 2, 'Tipo de Ejecucion', 'C', 'P')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2242, 0, 3, 'Nombre del Archivo', 'C', 'ordext_fallida_07112014.txt')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2246, 0, 1, 'Fecha Inicio', 'D', '01/01/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2246, 0, 2, 'Fecha Fin', 'D', '01/01/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (1, 2033, 33, 1, 'FECHA PROCESO', 'D', '11/07/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (1000, 2135, 1, 1, 'NOMBRE TABLA', 'C', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (1000, 2135, 1, 2, 'OFICINA(S)', 'C', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (1000, 2135, 1, 3, 'ZONA', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (1000, 2135, 1, 4, 'FECHA PROCESO', 'D', '10/31/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2003, 2110, 1, 1, 'FECHA INICIO', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2003, 2110, 1, 2, 'FECHA FIN', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2003, 2220, 2, 1, 'FECHA INICIO', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2003, 2220, 2, 2, 'FECHA FIN', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2003, 2221, 3, 1, 'FECHA INICIO', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2003, 2221, 3, 2, 'FECHA FIN', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2003, 2222, 4, 1, 'ARCHIVO', 'C', 'Entities2015_11_03.txt')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2003, 2222, 4, 2, 'OPERACION', 'C', 'W')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2003, 2222, 4, 3, 'PATH', 'C', 'F:\Vbatch\Clientes\Archivos')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2003, 2223, 5, 1, 'ARCHIVO', 'C', 'Entities2015_11_03Deletions.txt')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2003, 2223, 5, 2, 'OPERACION', 'C', 'D')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2003, 2223, 5, 3, 'PATH', 'C', 'F:\Vbatch\Clientes\Archivos')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2003, 2044, 6, 1, 'FECHA INICIAL', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2003, 2044, 6, 2, 'FECHA FINAL', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2003, 2241, 8, 1, 'FECHA DE PROCESO', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2004, 2231, 1, 1, 'EMPRESA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2004, 2231, 1, 2, 'ARCHIVO', 'C', 'Marcar_Clientes.txt')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2004, 2231, 1, 3, 'MARCACION/DESMARCACION', 'C', 'M')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2038, 1, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2038, 1, 2, 'OFICINA', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2038, 1, 3, 'GERENTE', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2038, 1, 4, 'MES', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2039, 2, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2039, 2, 2, 'OFICINA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2039, 2, 3, 'GERENTE', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2039, 2, 4, 'MONTO MINIMO', 'M', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2039, 2, 5, 'MONTO MAXIMO', 'M', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2042, 3, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2042, 3, 2, 'OFICINA', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2042, 3, 3, 'GERENTE', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2042, 3, 4, 'FECHA INICIO', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2042, 3, 5, 'FECHA FIN', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2086, 7, 1, 'FECHA INICIO', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2086, 7, 2, 'FECHA FIN', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2087, 8, 1, 'FECHA INICIAL', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2087, 8, 2, 'FECHA FINAL', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2092, 9, 1, 'OFICINA', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2092, 9, 2, 'PRODUCTO', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2092, 9, 3, 'TIPO VIVIENDA', 'C', '001')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2093, 10, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2093, 10, 2, 'OFICINA', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2093, 10, 4, 'FECHA INICIO', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2093, 10, 5, 'FECHA FIN', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2100, 11, 1, 'NOMBRE ARCHIVO', 'C', 'archivo.txt')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2207, 13, 1, 'FECHA', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2207, 13, 2, 'CONSOLIDADO (S/N)', 'C', 'S')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2209, 14, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2209, 14, 2, 'OFICINA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2209, 14, 3, 'GERENTE', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2209, 14, 4, 'SUBTIPO (COMPANIA, PERSONA)', 'C', 'P')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2209, 14, 5, 'FECHA INICIO', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2209, 14, 6, 'FECHA FIN', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2210, 15, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2033, 16, 1, 'FECHA PROCESO', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2040, 17, 1, 'FILIAL', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2040, 17, 2, 'OFICINA', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2040, 17, 3, 'GERENTE', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2040, 17, 4, 'FECHA INICIO', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2040, 17, 5, 'FECHA FIN', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2094, 18, 1, 'FECHA INICIAL', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2094, 18, 2, 'FECHA FINAL', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2094, 18, 3, 'OFICINA', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2034, 19, 1, 'FECHA DESDE', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2034, 19, 2, 'FECHA HASTA', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2034, 19, 3, 'MODO (VALORES POSIBLES D - C)', 'C', 'D')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2123, 20, 1, 'TIPO DE PROCESO', 'I', '22')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2123, 20, 2, 'FECHA PROCESO', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2123, 20, 3, 'NOMBRE DE ARCHIVO', 'C', 'clnovprom20070101')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2133, 21, 1, 'FECHA DESDE', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2133, 21, 2, 'FECHA HASTA', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2226, 22, 1, 'NOMBRE DEL ARCHIVO', 'C', 'cl_nomarch.txt')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2226, 22, 2, 'TIPO PROCESO (VALIDACION O CARGUE)', 'C', 'V')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2226, 22, 3, 'PATH ARCIVO DE CARGUE', 'C', 'F:\Vbatch\Clientes\Archivos')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2227, 23, 1, 'NOMBRE DEL ARCHIVO', 'C', 'cl_nomarch.txt')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2227, 23, 2, 'TIPO PROCESO (VALIDACION O CARGUE)', 'C', 'C')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2227, 23, 3, 'PATH ARCIVO DE CARGUE', 'C', 'F:\Vbatch\Clientes\Archivos')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2228, 24, 1, 'NOMBRE DEL ARCHIVO', 'C', 'cl_nomarch.txt')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2228, 24, 2, 'TIPO PROCESO (VALIDACION O CARGUE)', 'C', 'C')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2228, 24, 3, 'PATH ARCIVO DE CARGUE', 'C', 'F:\Vbatch\Clientes\Archivos')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2229, 25, 1, 'fecha proceso', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2141, 28, 1, 'AÑO GENERACION', 'C', '2014')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2142, 29, 1, 'AÑO GENERACION', 'C', 'AAAA')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2142, 29, 2, 'TIPO (I)', 'C', 'I')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2143, 30, 1, 'AÑO GENERACION', 'C', 'AAAA')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2143, 30, 2, 'TIPO (P)', 'C', 'E')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2144, 31, 1, 'TIPO (C,A)', 'C', 'C')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2144, 31, 2, 'NOMBRE ARCHIVO', 'C', '<ARCHIVO_TERCERO.TXT>')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2145, 32, 1, 'TIPO (C,A)', 'C', 'A')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2145, 32, 2, 'NOMBRE ARCHIVO', 'C', '<ARCHIVO_TERCERO.TXT>')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2140, 33, 1, 'NOMBRE ARCHIVO', 'C', 'Nombre Archivo')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2153, 36, 1, 'FECHA PROCESO', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2125, 37, 1, 'FECHA INICIO', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2125, 37, 2, 'FECHA FIN', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2127, 38, 1, 'FECHA REPORTE', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2117, 39, 1, 'Fecha de Proceso', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2117, 39, 2, 'Tipo proceso', 'C', 'T')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2146, 40, 1, 'A¥O GENERACION', 'C', 'AAAA')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2146, 40, 2, 'TIPO (I)', 'C', 'I')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2146, 40, 3, 'TIPO OFICINA', 'C', 'T')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2146, 40, 4, 'CODIGO OFICINA', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2155, 42, 1, 'GENERA REPORTES', 'C', 'S')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2118, 44, 1, 'FECHA INICIAL', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2118, 44, 2, 'FECHA FINAL', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2242, 46, 1, 'Fecha de Proceso', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2242, 46, 2, 'Tipo de Ejecucion', 'C', 'P')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2242, 46, 3, 'Nombre del Archivo', 'C', 'ordext_fallida_22102015.txt')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2159, 47, 1, 'OFICINA ORIGEN', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2159, 47, 2, 'OFICINA DESTINO', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2159, 47, 3, 'NOMBRE DEL ARCHIVO A PROCESAR', 'C', 'CARGUECOM_25092015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2159, 47, 4, 'TIPO TRASLADO', 'C', 'COM')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2246, 48, 1, 'Fecha Inicio', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2007, 2246, 48, 2, 'Fecha Fin', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2009, 2097, 1, 1, 'FECHA_PROCESABLE', 'D', '10/16/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2009, 2097, 1, 2, 'MODO', 'I', '2')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2009, 2099, 2, 1, 'PATH SALIDA', 'C', 'F:\Vbatch\Clientes\Insertar\')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2009, 2098, 3, 1, 'PATH SALIDA', 'C', 'F:\Vbatch\Clientes\Validar\')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2009, 2109, 4, 1, 'FECHA', 'D', '10/16/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2009, 2097, 5, 1, 'FECHA_PROCESABLE', 'D', '10/16/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2009, 2097, 5, 2, 'MODO', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2009, 2101, 6, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2009, 2203, 7, 1, 'DATA (H/V)', 'C', 'H')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2093, 1, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2093, 1, 2, 'OFICINA', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2093, 1, 3, 'FECHA INICIO', 'D', '01/01/2008')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2093, 1, 4, 'FECHA FIN', 'D', '05/02/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2094, 2, 1, 'FECHA INICIAL', 'D', '05/02/2000')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2094, 2, 2, 'FECHA FINAL', 'D', '01/01/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2094, 2, 3, 'OFICINA', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2101, 4, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2107, 5, 1, 'FECHA PROCESO', 'D', '05/02/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2108, 6, 1, 'FECHA DE PROCESO', 'D', '05/02/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2108, 6, 2, 'LISTA (OFAC/ONU)', 'C', 'OFAC')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2108, 6, 3, 'ARCHIVO', 'C', 'OFACSDN.DEL')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2006, 7, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2006, 7, 2, 'OFICINA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2006, 7, 3, 'GERENTE', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2006, 7, 4, 'FECHA INICIO', 'D', '05/02/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2006, 7, 5, 'FECHA FIN', 'D', '05/02/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2017, 8, 1, 'FECHA INICIO', 'D', '05/02/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2017, 8, 2, 'FECHA FIN', 'D', '05/02/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2017, 8, 3, 'CONSOLIDADO (S/N)', 'C', 'S')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2057, 9, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2057, 9, 2, 'OFICINA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2057, 9, 3, 'GERENTE', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2057, 9, 4, 'FECHA INICIO', 'D', '05/02/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2057, 9, 5, 'FECHA FIN', 'D', '05/02/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2092, 10, 1, 'OFICINA', 'I', '4075')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2092, 10, 2, 'PRODUCTO', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2092, 10, 3, 'TIPO VIVIENDA', 'C', '001')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2094, 11, 1, 'FECHA INICIAL', 'D', '05/02/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2094, 11, 2, 'FECHA FINAL', 'D', '01/01/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2094, 11, 3, 'OFICINA', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2037, 12, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2037, 12, 2, 'OFICINA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2037, 12, 3, 'GERENTE', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2037, 12, 4, 'FECHA INICIO', 'D', '05/02/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2037, 12, 5, 'FECHA FIN', 'D', '05/02/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2040, 13, 1, 'FILIAL', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2040, 13, 2, 'OFICINA', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2040, 13, 3, 'GERENTE', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2040, 13, 4, 'FECHA INICIO', 'D', '05/02/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2040, 13, 5, 'FECHA FIN', 'D', '05/02/2009')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2011, 2019, 1, 1, 'FECHA PROCESO', 'D', '05/07/2011')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2011, 2020, 2, 1, 'FECHA PROCESO', 'D', '05/07/2011')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2011, 2057, 3, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2011, 2057, 3, 2, 'OFICINA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2011, 2057, 3, 3, 'GERENTE', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2011, 2057, 3, 4, 'FECHA INICIO', 'D', '05/07/2011')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2011, 2057, 3, 5, 'FECHA FIN', 'D', '05/07/2011')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2011, 2043, 4, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2011, 2043, 4, 2, 'OFICINA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2011, 2043, 4, 3, 'GERENTE', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2011, 2043, 4, 4, 'FECHA INICIO', 'D', '05/07/2011')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2011, 2043, 4, 5, 'FECHA FIN', 'D', '05/07/2011')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2011, 2081, 8, 1, 'FECHA PROCESO', 'D', '05/07/2011')
GO

INSERT into cobis..ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
VALUES(0       ,     2253,            0,            1,  'OPERACION',      'C',      'Q')
GO

INSERT into cobis..ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
VALUES(0       ,     2253,            0,            2,  'MODO',        'C',      '1')
GO

INSERT into cobis..ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
VALUES(0       ,     2253,            0,            3,  'FECHA PROCESO', 'D', '11/24/2017')
GO

INSERT into cobis..ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
VALUES(2012       ,     2253,            1,            1,  'OPERACION',      'C',      'Q')
GO

INSERT into cobis..ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
VALUES(2012      ,     2253,            1,            2,  'MODO',        'C',      '1')
GO

INSERT into cobis..ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
VALUES(2012       ,     2253,            1,            3,  'FECHA PROCESO', 'D', '11/24/2017')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2013, 2237, 1, 1, 'HIJO', 'C', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2013, 2237, 1, 2, 'SARTA', 'C', '2013')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2013, 2237, 1, 3, 'BATCH', 'C', '2238')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2013, 2237, 1, 4, 'OPCION', 'C', 'G')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2013, 2237, 1, 5, 'BLOQUE', 'C', '2')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2013, 2238, 2, 1, 'HIJO', 'C', '2')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2013, 2238, 2, 2, 'SARTA', 'C', '2013')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2013, 2238, 2, 3, 'BATCH', 'C', '2238')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2013, 2238, 2, 4, 'OPCION', 'C', 'B')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2013, 2238, 2, 5, 'BLOQUE', 'C', '25')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2014, 2239, 1, 1, 'HIJO', 'C', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2014, 2239, 1, 2, 'SARTA', 'C', '2014')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2014, 2239, 1, 3, 'BATCH', 'C', '2240')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2014, 2239, 1, 4, 'OPCION', 'C', 'G')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2014, 2239, 1, 5, 'BLOQUE', 'C', '2')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2014, 2240, 2, 1, 'HIJO', 'C', '2')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2014, 2240, 2, 2, 'SARTA', 'C', '2014')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2014, 2240, 2, 3, 'BATCH', 'C', '2240')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2014, 2240, 2, 4, 'OPCION', 'C', 'B')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2014, 2240, 2, 5, 'BLOQUE', 'C', '25')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2100, 2100, 1, 1, 'NOMBRE ARCHIVO', 'C', 'TRASOFICIAL_1467.txt')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2100, 2224, 3, 1, 'FECHA DE PROCESO', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2100, 2134, 4, 1, 'FECHA INICIAL', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2100, 2134, 4, 2, '''FECHA FINAL', 'D', '11/03/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2100, 2134, 4, 3, 'OPCION (O = Oficina, T= Todas)', 'C', 'T')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2100, 2134, 4, 4, 'CODIGO OFICINA', 'I', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2126, 2117, 2, 1, 'Fecha de Proceso', 'D', '01/01/2014')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2126, 2117, 2, 2, 'Tipo proceso', 'C', 'T')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 2117, 19, 1, 'Fecha de Proceso', 'D', '11/04/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 2117, 19, 2, 'Tipo proceso', 'C', 'A')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (7007, 2160, 12, 1, 'FECHA PROCESO', 'D', '11/09/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (8000, 2033, 8, 1, 'FECHA PROCESO', 'D', '11/10/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (8000, 2036, 9, 1, 'FECHA PROCESO', 'D', '11/10/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (21006, 2224, 58, 1, 'FECHA DE PROCESO', 'D', '11/09/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (21006, 2235, 89, 1, 'FECHA PROCESO', 'D', '11/09/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (21008, 2019, 1, 1, 'FECHA PROCESO', 'D', '11/10/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (21008, 2020, 2, 1, 'FECHA PROCESO', 'D', '11/10/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (21008, 2057, 3, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (21008, 2057, 3, 2, 'OFICINA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (21008, 2057, 3, 3, 'GERENTE', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (21008, 2057, 3, 4, 'FECHA INICIO', 'D', '11/10/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (21008, 2057, 3, 5, 'FECHA FIN', 'D', '11/10/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (21008, 2043, 4, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (21008, 2043, 4, 2, 'OFICINA', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (21008, 2043, 4, 3, 'GERENTE', 'I', '1')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (21008, 2043, 4, 4, 'FECHA INICIO', 'D', '11/10/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (21008, 2043, 4, 5, 'FECHA FIN', 'D', '11/10/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (21008, 2081, 6, 1, 'FECHA PROCESO', 'D', '11/10/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (21202, 2112, 12, 1, 'FECHA INICIAL', 'D', '10/01/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (21202, 2112, 12, 2, 'FECHA FINAL', 'D', '10/31/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (21311, 2116, 27, 1, 'Fecha de Proceso', 'D', '11/04/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (21311, 2116, 27, 2, 'ID Transaccion', 'C', 'C')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (21311, 2116, 27, 3, 'Tipo de Transaccion en caso (T o N)', 'C', 'O')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (21311, 2116, 27, 4, 'Numero de carga', 'C', '0')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (36998, 2236, 3, 1, 'FECHA DE PROCESO', 'D', '11/09/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (36998, 2242, 6, 1, 'Fecha de Proceso', 'D', '11/09/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (36998, 2242, 6, 2, 'Tipo de Ejecucion', 'C', 'T')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (36998, 2242, 6, 3, 'Nombre del Archivo', 'C', 'ordext_fallida_07112014.txt')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (36998, 2158, 10, 1, 'FECHA REPORTE', 'D', '11/09/2015')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (   0, 2250, 0, 1, 'FECHA PROCESO', 'D', '01/01/2015')
GO
INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2250, 4, 1, 'FECHA PROCESO', 'D', '01/01/2015')
GO
INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (   0, 2251, 0, 1, 'FECHA PROCESO', 'D', '01/01/2015')
GO
INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2251, 5, 1, 'FECHA PROCESO', 'D', '01/01/2015')
GO
INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (   0, 2252, 0, 1, 'FECHA PROCESO', 'D', '01/01/2015')
GO
INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (2010, 2252, 6, 1, 'FECHA PROCESO', 'D', '01/01/2015')
GO
--PARAMETROS SINCRONIZACION CLIENTES POR ID
insert into cobis..ba_parametro
(pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(0       ,     2247,            0,            1,  'OPERACION',      'C',      'Q')
GO

insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(0       ,     2247,            0,            2,  'SUBTIPO',        'C',      '0')
GO
insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(0       ,     2247,            0,            3,  'MODO',        'C',      '1')
GO

insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(0       ,     2247,            0,            4,  'CLIENTE',        'I',      '0')
GO

insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(2010    ,     2247,            1,            1,  'OPERACION',      'C',      'Q')
GO

insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(2010    ,     2247,            1,            2,  'SUBTIPO',        'C',      '0')
GO

insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(2010    ,     2247,            1,            3,  'MODO',        'C',      '1')
GO

insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(2010      ,     2247,            1,            4,  'CLIENTE',        'I',      '0')

GO

--PARAMETROS SINCRONIZACION CLIENTES POR FECHA DESACTUALIZACION
insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(0       ,     2248,            0,            1,  'OPERACION',      'C',      'Q')
GO

insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(0       ,     2248,            0,            2,  'SUBTIPO',        'C',      '0')
GO
insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(0       ,     2248,            0,            3,     'MODO',        'C',      '2')
GO


insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(2010    ,     2248,            2,            1,  'OPERACION',      'C',      'Q')
GO

insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(2010    ,     2248,            2,            2,  'SUBTIPO',        'C',      '0')
GO

insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(2010    ,     2248,            2,            3,  'MODO',        'C',      '2')
GO

--PARAMETROS SINCRONIZACION CARGA MASIVA DE CLIENTES
insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(0       ,     2249,            0,            1,  'OPERACION',      'C',      'Q')
GO

insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(0       ,     2249,            0,            2,  'SUBTIPO',        'C',      '0')
GO
insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(0       ,     2249,            0,            3,  'MODO',        'C',      '3')
GO

insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(2010    ,     2249,            3,            1,  'OPERACION',      'C',      'Q')
GO

insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(2010    ,     2249,            3,            2,  'SUBTIPO',        'C',      '0')
GO

insert into cobis..ba_parametro
      (pa_sarta, pa_batch, pa_ejecucion, pa_parametro,    pa_nombre, pa_tipo, pa_valor)
values(2010    ,     2249,            3,            3,  'MODO',        'C',      '3')
GO


/*  BA_SARTA_BATCH */
DELETE cobis..ba_sarta_batch WHERE (sb_sarta between 2000 and 2999) or sb_sarta = 36998

INSERT INTO cobis..ba_sarta_batch VALUES (
2010, 2250, 4 , NULL, 'S', 'N',  2000, 2500, 2010, 'S')
go
INSERT INTO cobis..ba_sarta_batch VALUES (
2010, 2251, 5 , NULL, 'S', 'N',  3450, 2500, 2010, 'S')
go
INSERT INTO cobis..ba_sarta_batch VALUES (
2010, 2252, 6 , NULL, 'S', 'N',  4900, 2500, 2010, 'S')
go
--INSERTAR ARCHIVO DE SINCRONIZACION DE CLIENTES EN LA BA_SARTA_BATCH
INSERT into cobis..ba_sarta_batch
      (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES(2010,2247,1,null,'S','N',500,550,2010,'N')
go

INSERT into cobis..ba_sarta_batch
      (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES(2010,2248,2, null,'S','N',2190,525,2010,'N')
go

INSERT into cobis..ba_sarta_batch
      (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES(2010,2249,3,null,'S','N',4200,555,2010,'N')
go
--INSERTAR ARCHIVO DE LISTAS NEGRAS DE CLIENTES EN LA BA_SARTA_BATCH
INSERT into cobis..ba_sarta_batch
      (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES(2012,2253,1,null,'S','N',500,550,2012,'N')
go

/*  BA_ENLACE */
DELETE cobis..ba_enlace WHERE (en_sarta between 2000 and 2999) or en_sarta = 36998
GO
--INSERTAR ARCHIVO DE SINCRONIZACION DE CLIENTES EN LA BA_ENLACE
insert into cobis..ba_enlace(en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values(2010,2247,1,0,0,'S',null,'N')

insert into cobis..ba_enlace(en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values(2010,2248,2,0,0,'S',null,'N')

insert into cobis..ba_enlace
      (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values(2010,2249,3,0,0,'S',null,'N')

insert into cobis..ba_enlace
      (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values(2010,2250,4,2251,5,'S',null,'N')

insert into cobis..ba_enlace
      (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values(2010,2251,5,2252,6,'S',null,'N')

insert into cobis..ba_enlace
      (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values(2010,2252,6,0,0,'S',null,'N')

GO
insert into cobis..ba_enlace
      (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values(2012,2253,1,0,0,'S',null,'N')
GO

/*  BA_SARTA  */
print 'Insertando datos en ba_sarta'
go

if exists (select 1 from ba_sarta where (sa_sarta between 2000 and 2999) or sa_sarta = 36998)
   delete ba_sarta where (sa_sarta between 2000 and 2999) or sa_sarta = 36998
go

INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (2003, 'CARGA DE LISTAS DE REFERENCIAS INHIBITORIAS', 'CARGA DE LISTAS DE REFERENCIAS INHIBITORIAS', '2014-03-18 19:21:09.733', 'jmartinez', 2, NULL, NULL)
GO

INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (2004, 'LOTE DE PROCESOS DIARIOS DE CLIENTES', 'LOTE DE PROCESOS DIARIOS DE CLIENTES', '2015-07-23 17:30:35.6', 'wcastillo', 2, NULL, NULL)
GO

INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (2007, 'EVENTUAL LOTE DE REPORTES CLIENTES', 'EVENTUAL LOTE DE REPORTES CLIENTES', '2016-01-05 14:35:07.06', 'stapia', 2, NULL, NULL)
GO

INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (2009, 'MIGRACION CLIENTES', 'MIGRACION CLIENTES', '2009-06-05 05:53:02.307', 'jmartinez', 2, NULL, NULL)
GO

INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (2010, 'CLIENTES', 'CLIENTES', '2009-05-12 08:47:24.42', 'magarcia', 2, NULL, NULL)
GO

INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (2011, 'LISTADOS DIARIOS DE CLIENTES', 'LISTADOS DIARIOS DE CLIENTES', '2010-06-21 17:44:49.173', 'stapia', 2, NULL, NULL)
GO

INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (2012, 'CLIENTES LISTA NEGRAS', 'CLIENTES LISTA NEGRAS', '2017-11-24 08:47:24.42', 'psamueza', 2, NULL, NULL)
GO

INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (2013, 'CREACION MASIVA DE CLIENTES', 'CREACION MASIVA DE CLIENTES', '2014-01-19 11:09:54.717', 'pvelandia', 2, NULL, NULL)
GO

INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (2014, 'VALIDACION MASIVA DE NEGOCIO', 'VALIDACION MASIVA DE NEGOCIO', '2014-01-19 10:20:48.473', 'pvelandia', 2, NULL, NULL)
GO

INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (2100, 'TRASLADO DE CLIENTES', 'TRASLADO MASIVO', '2014-12-16 19:47:20.693', 'jcastano', 2, NULL, NULL)
GO

INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (2126, 'PROCESO DIARIO ALIANZAS COMERCIALES', 'PROCESO DIARIO ALIANZAS COMERCIALES', '2014-09-04 19:22:32.94', 'jcastano', 2, NULL, NULL)
GO

INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (36998, 'PREVIOS AL CIERRE CLIENTES - CTA CTE - AHORROS', 'PREVIOS AL CIERRE CLIENTES - CTA CTE - AHORROS', '2015-05-14 16:02:16.83', 'jmartinez', 2, NULL, NULL)
GO



