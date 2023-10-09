/************************************************************************/
/*      Archivo:            ah_batch.sql                                */
/*      Base de datos:      cob_ahorros                                 */
/*      Producto:           Cuentas de Ahorros                          */
/*      Disenado por:       Roxana Sánchez                              */
/*      Fecha de escritura: 29/Agosto/2016                                */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa realiza la creacion de los batch y sartas         */
/*      para el modulo de cuentas de ahorros de migración               */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    29/Agosto/2016   Roxana Sánchez   Migracion a CEN                 */
/************************************************************************/

/*Script de la sarta para la migración*/

use cobis
go
/*  BA_SARTA  */
print 'Insertando datos en ba_sarta'
go

if exists (select 1 from ba_sarta where sa_sarta =4006)
   delete ba_sarta where sa_sarta =4006
go

INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (4006, 'MIGRACION DE AHORROS', 'MIGRACION DE AHORROS', getdate(), 'admuser', 4, NULL, NULL)
GO



/*  BA_BATCH  */
print 'Insertando datos en ba_batch'
go

if exists (select 1 from ba_batch where ba_batch in (4300,4301,4302,4303))
   delete ba_batch where ba_batch in (4300,4301,4302,4303)
go

declare @w_servidor   varchar(30), @w_path_fuente varchar(50), @w_path_destino  varchar(50)

select @w_servidor = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and pa_nemonico = 'SRVR'
--select @w_servidor = isnull(@w_servidor,'CLOUDSRVD')?

select   
@w_path_destino = pp_path_destino
from ba_path_pro
where pp_producto = 4

select @w_path_destino = isnull(@w_path_destino, 'C:/Cobis/vbatch/ahorros/listados/')

select   
@w_path_fuente = pp_path_fuente
from ba_path_pro
where pp_producto = 4

select @w_path_fuente = isnull(@w_path_fuente, 'C:/Cobis/vbatch/ahorros/objetos/')
       
       
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4300, 'CARGA DATOS EXT', 'CARGA DATOS DEL ARCHIVO TEXTO A LA TABLAS EXT', 'SP', getdate(), 4, 'P', 1, 'CARGA_ARCHIVO', 'person.lis', 'cob_externos..sp_ah_carga_ext', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4301, 'CARGA DE DATOS MIG', 'REALIZA EL PASO DE DATOS DE LAS DISTINTAS TABLAS EXT A SUS RESPECTIVAS TABLAS MIG.', 'SP', getdate(), 4, 'P', 1, 'CARGA_ARCHIVO', 'person.lis', 'cob_externos..sp_ah_carga_mig', 10, '', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4302, 'VALIDACIÓN DE DATOS', 'REALIZA LAS DISTINTAS VALIDACIONES DE LOS DATOS EN LAS TABLAS MIG.', 'SP', getdate(), 4, 'P', 1, 'CARGA_ARCHIVO', 'person.lis', 'cob_externos..sp_validacion_principal_mig', 10, '', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4303, 'CARGA DE DATOS EN AHORROS', 'REALIZA EL PASO DE DATOS A LAS TABLAS DEFINITIVAS DE AHORROS', 'SP', getdate(), 4, 'P', 1, 'CARGA_ARCHIVO', 'person.lis', 'cob_externos..sp_traslada_tablas_mig', 10, '', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

go

/*  BA_SARTA_BATCH  */
if exists (select 1 from ba_sarta_batch  where sb_sarta = 4006 and sb_batch in (4300,4301,4302,4303))
   delete ba_sarta_batch  where sb_sarta = 4006  and sb_batch in (4300,4301,4302,4303)
go

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4006, 4300, 1, null, 'S', 'N', 495, 285, 4006, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4006, 4300, 2, null, 'S', 'N', 1440, 690, 4006, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4006, 4300, 3, null, 'S', 'N', 480, 1230, 4006, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4006, 4300, 4, null, 'S', 'N', 1440, 1725, 4006, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4006, 4300, 5, null, 'S', 'N', 480, 2160, 4006, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4006, 4300, 6, null, 'S', 'N', 1440, 2700, 4006, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4006, 4300, 7, null, 'S', 'N', 480, 3150, 4006, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4006, 4300, 8, null, 'S', 'N', 1440, 3585, 4006, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4006, 4300, 9, null, 'S', 'N', 480, 4050, 4006, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4006, 4300, 10, null, 'S', 'N', 1440, 4440, 4006, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4006, 4300, 11, null, 'S', 'N', 480, 4920, 4006, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4006, 4300, 12, null, 'S', 'N', 1440, 5400, 4006, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4006, 4301, 13, null, 'S', 'N', 3900, 2925, 4006, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4006, 4302,  14, null, 'S', 'N', 5340,  2955, 4006, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4006, 4303, 15, null, 'S', 'N', 6720, 2985, 4006, 'S')

go   

/*  BA_PARAMETROS  */
delete FROM cobis..ba_parametro WHERE pa_sarta in (0, 4006) 
                                  AND pa_batch in (4300,4302,4303)
GO
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4300, 0, 1 , 'OPERACION', 'C', 'AH')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4300, 0, 2 , 'NOM_ARCHIVO', 'C', 'ah_cuenta_ext.txt')

insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4006, 4300, 1, 1 , 'OPERACION', 'C', 'AH')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4006, 4300, 1, 2 , 'NOM_ARCHIVO', 'C', 'ah_cuenta_ext.txt')

insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4006, 4300, 2, 1 , 'OPERACION', 'C', 'CC')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4006, 4300, 2, 2 , 'NOM_ARCHIVO', 'C', 're_cuenta_contractual_ext.txt')

insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4006, 4300, 3, 1 , 'OPERACION', 'C', 'CB')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4006, 4300, 3, 2 , 'NOM_ARCHIVO', 'C', 'ah_ctabloqueada_ext.txt')

insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4006, 4300, 4, 1 , 'OPERACION', 'C', 'HB')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4006, 4300, 4, 2 , 'NOM_ARCHIVO', 'C', 'ah_his_bloqueo_ext.txt ')

insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4006, 4300, 5, 1 , 'OPERACION', 'C', 'CD')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4006, 4300, 5, 2 , 'NOM_ARCHIVO', 'C', 'ah_ciudad_deposito_ext.txt ')

insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4006, 4300, 6, 1 , 'OPERACION', 'C', 'HI')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4006, 4300, 6, 2 , 'NOM_ARCHIVO', 'C', 'ah_his_inmovilizadas_ext.txt')

insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4006, 4300, 7, 1 , 'OPERACION', 'C', 'TM')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4006, 4300, 7, 2 , 'NOM_ARCHIVO', 'C', 'ah_tran_monet_ext.txt')

insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4006, 4300, 8, 1 , 'OPERACION', 'C', 'HM')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4006, 4300, 8, 2    , 'NOM_ARCHIVO', 'C', 'ah_his_movimiento_ext.txt')

insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4006, 4300, 9, 1 , 'OPERACION', 'C', 'AN')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4006, 4300, 9, 2 , 'NOM_ARCHIVO', 'C', 're_accion_nd_ext.txt')

insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4006, 4300, 10, 1 , 'OPERACION', 'C', 'LP')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4006, 4300, 10, 2 , 'NOM_ARCHIVO', 'C', 'ah_linea_pendiente_ext.txt')

insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4006, 4300, 11, 1 , 'OPERACION', 'C', 'DC')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4006, 4300, 11, 2 , 'NOM_ARCHIVO', 'C', 're_detalle_cheque_ext.txt')

insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4006, 4300, 12, 1 , 'OPERACION', 'C', 'VS')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4006, 4300, 12, 2 , 'NOM_ARCHIVO', 'C', 'ah_val_suspenso_ext.txt')

insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4302, 0, 1 , 'RANGO', 'I', 3000)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4006, 4302, 14, 1 , 'RANGO', 'I', 3000)
 
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4303, 0, 1 , 'RANGO', 'I', 3000)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4303, 0, 2 , 'INCREMENTO', 'C', 'S')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4006, 4303, 15, 1 , 'RANGO', 'I', 3000)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4006, 4303, 15, 2 , 'INCREMENTO', 'C', 'S')

     
/*  BA_ENLACE   */
delete from cobis..ba_enlace WHERE en_sarta in (4006)
go

--sarta 1
insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4006,4300,1,4301,13,'S',NULL,'N')

insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4006,4300,2,4301,13	,'S',NULL,'N')
insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4006,4300,3,4301,13	,'S',NULL,'N')
insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4006,4300,4,4301,13	,'S',NULL,'N')
insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4006,4300,5,4301,13	,'S',NULL,'N')
insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4006,4300,6,4301,13	,'S',NULL,'N')
insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4006,4300,7,4301,13	,'S',NULL,'N')
insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4006,4300,8,4301,13	,'S',NULL,'N')
insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4006,4300,9,4301,13	,'S',NULL,'N')
insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4006,4300,10,4301,13,'S',NULL,'N')
insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4006,4300,11,4301,13,'S',NULL,'N')
insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4006,4300,12,4301,13,'S',NULL,'N')
insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4006,4301,13,4302,14,'S',NULL,'N')
insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4006,4302,14,4303,15,'S',NULL,'N')
insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4006,4303,15,0,0,'S',NULL,'N')
go



