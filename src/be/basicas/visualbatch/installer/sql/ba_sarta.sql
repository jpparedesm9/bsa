/************************************************************************/
/*	Archivo:		ba_sarta.sql			                            */
/*	Base de datos:	cobis					                            */
/*	Producto:		Batch					                            */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  Cobiscorp. Su uso no autorizado queda expresamente prohibido        */
/*  asi como cualquier alteracion o agregado hecho por alguno de        */
/*  sus usuarios sin el debido consentimiento por escrito de la         */
/*  Presidencia Ejecutiva de Cobiscorp o su representante.              */
/************************************************************************/
/*				MODIFICACIONES				                            */
/*	FECHA		AUTOR		RAZON				                        */
/*  10/05/2012  Isaac Torres           Emision Inicial                  */
/*  17/07/2013  Juan Tagle             Se agrega 8004 en lote 8002      */
/*  12/11/2013  Jairo Reyes            Sarta nueva 8006                 */
/*  20/04/2016  BBO                    Migracion Syb-SQL FAL            */
/************************************************************************/

use cobis
go

print '----->  ba_sarta'
go

if exists (select * from ba_sarta
	       where sa_sarta between 8001 and 8999)
	delete ba_sarta where sa_sarta between 8001 and 8999
go

print 'REGISTRO DE LOTES DE PROGRAMAS BATCH - BATCH'
go

INSERT INTO ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
                     VALUES (8001, 'DESHABILITAR PRODUCTOS', 'DESHABILITAR PRODUCTOS', getdate(), 'sa', 8, NULL, 'S')
GO
INSERT INTO ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
                     VALUES (8002, 'HABILITAR PRODUCTOS', 'HABILITAR PRODUCTOS', getdate(), 'sa', 8, NULL, 'S')
GO
INSERT INTO ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
                     VALUES (8003, 'PASO A HISTORICO', 'PASO A HISTORICO DE LOGS DE ERRORES DE BATCH', getdate(), 'sa', 8, NULL, 'S')
GO
INSERT INTO ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
                     VALUES (8005, 'RESPALDOS DE BASES DE DATOS FIN DE DIA', 'BACKUPS FULL DE LAS BASES DE DATOS DEL SYBASE Y DE SQL SERVER', getdate(), 'sa', 8, NULL, 'S')
GO
INSERT INTO ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
                     values (8006, 'RESPALDOS DE BASES DE DATOS INICIO DE DIA', 'BACKUPS FULL DE LAS BASES DE DATOS DEL SYBASE Y DE SQL SERVER', getdate(), 'sa', 8, NULL, 'S')
GO

-------------------------- REGISTRO DE PROGRAMAS BATCH POR LOTE -------------------------------

delete ba_sarta_batch
where sb_sarta between 8001 and 8999
go
print 'REGISTRO DE PROGRAMAS BATCH POR LOTE'
go

insert into ba_sarta_batch(sb_sarta,sb_batch,sb_secuencial,sb_dependencia,sb_repeticion,sb_critico,sb_left, sb_top, sb_lote_inicio, sb_habilitado)
values(8001,8001,1,NULL,'S','N',500,550,8001,'S')
go

insert into ba_sarta_batch(sb_sarta,sb_batch,sb_secuencial,sb_dependencia,sb_repeticion,sb_critico,sb_left, sb_top, sb_lote_inicio, sb_habilitado)
values(8002,8002,1,NULL,'S','N',500,550,8002,'S')
/* COMENTADO PARA FALABELLA
--insert into ba_sarta_batch(sb_sarta,sb_batch,sb_secuencial,sb_dependencia,sb_repeticion,sb_critico,sb_left, sb_top, sb_lote_inicio, sb_habilitado)
--values(8002,8004,2,NULL,'S','N',1500,550,8002,'S')
--go
*/
insert into ba_sarta_batch(sb_sarta,sb_batch,sb_secuencial,sb_dependencia,sb_repeticion,sb_critico,sb_left, sb_top, sb_lote_inicio, sb_habilitado)
values(8003,8003,1,NULL,'S','N',500,550,8003,'S')
go

/* COMENTADO PARA FALABELLA
--insert into ba_sarta_batch(sb_sarta,sb_batch,sb_secuencial,sb_dependencia,sb_repeticion,sb_critico,sb_left, sb_top, sb_lote_inicio, sb_habilitado ) 
--	values(8005,8010,1,NULL,'S','N',450,570,8005,'S' ) 	
--insert into ba_sarta_batch(sb_sarta,sb_batch,sb_secuencial,sb_dependencia,sb_repeticion,sb_critico,sb_left, sb_top, sb_lote_inicio, sb_habilitado)
--	values(8005,8006,2,NULL,'S','N',1965,570,8005,'S')
--go

--insert into ba_sarta_batch(sb_sarta,sb_batch,sb_secuencial,sb_dependencia,sb_repeticion,sb_critico,sb_left, sb_top, sb_lote_inicio, sb_habilitado)
--	values(8006,8006,1,NULL,'S','N',500,550,8006,'S')
--go
*/
/*******************************/
delete ba_enlace
where en_sarta between 8001 and 8999
go

PRINT 'INSERCION: ba_enlace'
go

insert into ba_enlace values (8001, 8001, 1, 0, 0, 'S', null, 'N')
go


insert into ba_enlace values (8002, 8002, 1, 8004, 2, 'S', null, 'N')
/* COMENTADO PARA FALABELLA
--insert into ba_enlace values (8002, 8004, 2, 0, 0, 'S', null, 'N')
*/
go


insert into ba_enlace values (8003, 8003, 1, 0, 0, 'S', null, 'N')
go

/* COMENTADO PARA FALABELLA
--INSERT INTO ba_enlace values (8005, 8010, 1, 8006, 2, 'D', NULL, 'N' ) 
--insert into ba_enlace values (8005, 8006, 2, 0, 0, 'S', null, 'N')
--go	   

--insert into ba_enlace values (8006, 8006, 1, 8007, 2, 'S', null, 'N')
--go
*/

