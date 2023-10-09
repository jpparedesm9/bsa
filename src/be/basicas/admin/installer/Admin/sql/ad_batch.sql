/************************************************************************/
/*      Archivo         :  ad_batch.sql                                 */
/*      Base de datos   :  cobis                                        */
/*      Producto        :  Admin                                        */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  Cobiscorp. Su uso no autorizado queda expresamente prohibido        */
/*  asi como cualquier alteracion o agregado hecho por alguno de        */
/*  sus usuarios sin el debido consentimiento por escrito de la         */
/*  Presidencia Ejecutiva de Cobiscorp o su representante.              */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*      FECHA           AUTOR           RAZON                           */
/*  05/29/2012  Edison Andrade         Emision Inicial                  */
/************************************************************************/

use cobis
go
print '----->  ad_batch'
go

PRINT 'INSERCION: ba_path_pro'
delete ba_path_pro where pp_producto = 1
go

insert into ba_path_pro values (1, '/cobis/kernel/vbatch/objetos/', '/cobis/kernel/vbatch/listados/')
go

if exists (select * from ba_batch
               where ba_batch between 1001 and 1999)
   delete ba_batch where ba_batch between 1001 and 1999
go

declare @w_server varchar(24), @w_path_fuente varchar(255), @w_path_destino varchar(255)

select @w_server = pa_char
from cl_parametro 
where pa_producto = 'ADM'
and   pa_nemonico = 'SRVR'

select @w_path_fuente = pp_path_fuente, @w_path_destino = pp_path_destino
from ba_path_pro
where pp_producto = 1

PRINT 'INSERCION: ba_batch'


insert into ba_batch (ba_batch,ba_nombre,ba_descripcion,ba_lenguaje,ba_fecha_creacion,ba_producto,
                      ba_tipo_batch,ba_sec_corrida,ba_ente_procesado,ba_arch_resultado,ba_arch_fuente,
                      ba_frec_reg_proc,ba_impresora,  
                      ba_serv_destino,ba_reproceso,ba_path_fuente,ba_path_destino)
			   values(1001, 'ELIMINACION MASIVA DE ROLES DE USUARIO CUYA VIGENCIA HA EXPIRADO', 'ELIMINACION MASIVA DE ROLES DE USUARIO CUYA VIGENCIA HA EXPIRADO', 'SP', GETDATE(), 1,
				      'P', 3, NULL, NULL, 'cobis..sp_elim_rol_usuario_ej',
					  50,'lp', @w_server,'S', @w_path_fuente, null)
	   
insert into ba_batch (ba_batch,ba_nombre,ba_descripcion,ba_lenguaje,ba_fecha_creacion,ba_producto,
                      ba_tipo_batch,ba_sec_corrida,ba_ente_procesado,ba_arch_resultado,ba_arch_fuente,
                      ba_frec_reg_proc,ba_impresora,  
                      ba_serv_destino,ba_reproceso,ba_path_fuente,ba_path_destino)
			   values(1002, 'ACTUALIZACION MASIVA DE FECHA CADUCIDAD DE ROLES A USUARIOS', 'ACTUALIZACION MASIVA DE FECHA CADUCIDAD DE ROLES A USUARIOS', 'SP', GETDATE(), 1,
				      'P', 2, NULL, NULL, 'cobis..sp_upd_cadrol_usuario_ej',
				      50,'lp', @w_server,'S', @w_path_fuente, null)

insert into ba_batch (ba_batch,ba_nombre,ba_descripcion,ba_lenguaje,ba_fecha_creacion,ba_producto,
                      ba_tipo_batch,ba_sec_corrida,ba_ente_procesado,ba_arch_resultado,ba_arch_fuente,
                      ba_frec_reg_proc,ba_impresora,  
                      ba_serv_destino,ba_reproceso,ba_path_fuente,ba_path_destino)
			   values(1003, 'INSERCION DE CONSULTAS DE PANTALLAS EN TRANSACCION DE SERVICIO','INSERCION DE CONSULTAS DE PANTALLAS EN TRANSACCION DE SERVICIO', 'SP', GETDATE(), 1,
				      'P', 1, NULL, NULL, 'cobis..sp_ad_inslog_func_ej', 
				      50,'lp', @w_server,'S', @w_path_fuente, null)

/******	    COMENTADO MIGRACION A SQLSERVER
insert into ba_batch (ba_batch,ba_nombre,ba_descripcion,ba_lenguaje,ba_fecha_creacion,ba_producto,
                      ba_tipo_batch,ba_sec_corrida,ba_ente_procesado,ba_arch_resultado,ba_arch_fuente,
                      ba_frec_reg_proc,ba_impresora,  
                      ba_serv_destino,ba_reproceso,ba_path_fuente,ba_path_destino)
			   values(1004, 'CREACION DE TABLAS AUXILIARES PARA EXTRACCION - ADM','CREACION DE TABLAS AUXILIARES PARA EXTRACCION - ADM', 'QL', GETDATE(), 1,
				      'P', 4, NULL, NULL, 'ad_ex_view.sql', 
				      50,'lp', @w_server,'S', @w_path_fuente, null)
*****/

insert into ba_batch (ba_batch,ba_nombre,ba_descripcion,ba_lenguaje,ba_fecha_creacion,ba_producto,
                      ba_tipo_batch,ba_sec_corrida,ba_ente_procesado,ba_arch_resultado,ba_arch_fuente,
                      ba_frec_reg_proc,ba_impresora,  
                      ba_serv_destino,ba_reproceso,ba_path_fuente,ba_path_destino)
			   values(1005, 'EXTRACCION DE PARAMETROS - ADM','EXTRACCION DE PARAMETROS - ADM', 'SP', GETDATE(), 1,
				      'P', 5, NULL, NULL, 'cobis..sp_extrae_param', 
				      50,'lp', @w_server,'S', @w_path_fuente, null)
	   
insert into ba_batch (ba_batch,ba_nombre,ba_descripcion,ba_lenguaje,ba_fecha_creacion,ba_producto,
                      ba_tipo_batch,ba_sec_corrida,ba_ente_procesado,ba_arch_resultado,ba_arch_fuente,
                      ba_frec_reg_proc,ba_impresora,  
                      ba_serv_destino,ba_reproceso,ba_path_fuente,ba_path_destino)
			   values(1006, 'EXTRACCION DE DATOS - ADM','EXTRACCION DE DATOS - ADM', 'SP', GETDATE(), 1,
				      'P', 6, NULL, NULL, 'cobis..sp_ad_eadmin', 
				      50,'lp', @w_server,'S', @w_path_fuente, null)
	   
insert into ba_batch (ba_batch,ba_nombre,ba_descripcion,ba_lenguaje,ba_fecha_creacion,ba_producto,
                      ba_tipo_batch,ba_sec_corrida,ba_ente_procesado,ba_arch_resultado,ba_arch_fuente,
                      ba_frec_reg_proc,ba_impresora,  
                      ba_serv_destino,ba_reproceso,ba_path_fuente,ba_path_destino)
			   values(1007, 'CUADRE DE DATOS - ADM','CUADRE DE DATOS - ADM', 'SP', GETDATE(), 1,
				      'P', 7, NULL, NULL, 'cobis..sp_ad_cuadre', 
			   	      50,'lp', @w_server,'S', @w_path_fuente, null)	   
	   
insert into ba_batch (ba_batch,ba_nombre,ba_descripcion,ba_lenguaje,ba_fecha_creacion,ba_producto,
                      ba_tipo_batch,ba_sec_corrida,ba_ente_procesado,ba_arch_resultado,ba_arch_fuente,
                      ba_frec_reg_proc,ba_impresora,  
                      ba_serv_destino,ba_reproceso,ba_path_fuente,ba_path_destino)
			   values(1008, 'GENERA BCP','GENERA BCP', 'SP', GETDATE(), 1,
				      'P', 8, NULL, NULL, 'cobis..sp_genera_bcp', 
				      50,'lp', @w_server,'S', @w_path_fuente, null)	   
	   
insert into ba_batch (ba_batch,ba_nombre,ba_descripcion,ba_lenguaje,ba_fecha_creacion,ba_producto,
                      ba_tipo_batch,ba_sec_corrida,ba_ente_procesado,ba_arch_resultado,ba_arch_fuente,
                      ba_frec_reg_proc,ba_impresora,  
                      ba_serv_destino,ba_reproceso,ba_path_fuente,ba_path_destino)
			   values(1009, 'BORRADO DE TABLAS AUXILIARES DE EXTRACCION - ADM','BORRADO DE TABLAS AUXILIARES DE EXTRACCION - ADM', 'QL', GETDATE(), 1,
				      'P', 9, NULL, NULL, 'ad_ex_drop.sql', 
				      50,'lp', @w_server,'S', @w_path_fuente, null)
	   
insert into ba_batch (ba_batch,ba_nombre,ba_descripcion,ba_lenguaje,ba_fecha_creacion,ba_producto,
                      ba_tipo_batch,ba_sec_corrida,ba_ente_procesado,ba_arch_resultado,ba_arch_fuente,
                      ba_frec_reg_proc,ba_impresora,  
                      ba_serv_destino,ba_reproceso,ba_path_fuente,ba_path_destino)
			   values(1010, 'REPORTE DE ROLES ELIMINADOS A USUARIOS','REPORTE DE ROLES ELIMINADOS A USUARIOS. ESTE REPORTE SE DEBE EJECUTAR EN EL SERVIDOR DE BODEGA DE DATOS', 'SP', GETDATE(), 1,
				      'P', 10, 'REGISTROS', NULL, 'cob_reportes..sp_genera_archivo', 
				      50, NULL, @w_server,'S', @w_path_fuente, null)
	   
go
