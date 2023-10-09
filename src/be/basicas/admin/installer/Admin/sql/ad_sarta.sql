/************************************************************************/
/*	Archivo:		ad_sarta.sql			                            */
/*	Base de datos:	cobis					                            */
/*	Producto:		Admin					                            */
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
/*  05/29/2012  Edison Andrade         Emision Inicial                  */
/*  03/14/2013  Juan Tagle             Inc. 19659 - desabilitar 1002 y  */
/*                                     anteponer 1009 a 1004            */
/*  12/04/2016  BBO                    Migracion SYBASE-SQLServer FAL   */
/************************************************************************/

use cobis
go

print '----->  ad_sarta'

if exists (select * from ba_sarta
	       where sa_sarta between 1001 and 1999)
	delete ba_sarta where sa_sarta between 1001 and 1999

print 'REGISTRO DE LOTES DE PROGRAMAS BATCH - ADMIN'

INSERT INTO ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
                     VALUES (1001, 'DIARIO DE ADMIN', 'DIARIO DE ADMIN', getdate(), 'sa', 1, NULL, 'S')
INSERT INTO ba_sarta(sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion) 
					 VALUES (1002, 'EXTRACTORES ADMIN CARGA INICIAL', 'EXTRACTORES CARGA INICIAL', getdate(), 'sa', 1, null, null)
GO


-------------------------- REGISTRO DE PROGRAMAS BATCH POR LOTE -------------------------------

delete ba_sarta_batch
where sb_sarta between 1001 and 1999
go
print 'REGISTRO DE PROGRAMAS BATCH POR LOTE'

insert into ba_sarta_batch(sb_sarta,sb_batch,sb_secuencial,sb_dependencia,sb_repeticion,sb_critico,sb_left, sb_top, sb_lote_inicio, sb_habilitado)
     values(1001,1003,1,NULL,'S','N',500,550,1001,'S')
-- insert into ba_sarta_batch(sb_sarta,sb_batch,sb_secuencial,sb_dependencia,sb_repeticion,sb_critico,sb_left, sb_top, sb_lote_inicio, sb_habilitado)
--     values(1001,1002,2,1003,'S','N',1500,550,1001,'N') 
insert into ba_sarta_batch(sb_sarta,sb_batch,sb_secuencial,sb_dependencia,sb_repeticion,sb_critico,sb_left, sb_top, sb_lote_inicio, sb_habilitado)
     values(1001,1001,2,1003,'S','N',1500,550,1001,'S')
insert into ba_sarta_batch(sb_sarta,sb_batch,sb_secuencial,sb_dependencia,sb_repeticion,sb_critico,sb_left, sb_top, sb_lote_inicio, sb_habilitado)
     values(1001,1009,3,1001,'S','N',2500,550,1001,'S')
insert into ba_sarta_batch(sb_sarta,sb_batch,sb_secuencial,sb_dependencia,sb_repeticion,sb_critico,sb_left, sb_top, sb_lote_inicio, sb_habilitado)
     values(1001,1004,4,1009,'S','N',3500,550,1001,'S')
insert into ba_sarta_batch(sb_sarta,sb_batch,sb_secuencial,sb_dependencia,sb_repeticion,sb_critico,sb_left, sb_top, sb_lote_inicio, sb_habilitado)
     values(1001,1005,5,1004,'S','N',4500,550,1001,'S')
insert into ba_sarta_batch(sb_sarta,sb_batch,sb_secuencial,sb_dependencia,sb_repeticion,sb_critico,sb_left, sb_top, sb_lote_inicio, sb_habilitado)
     values(1001,1006,6,1005,'S','N',5500,550,1001,'S')
insert into ba_sarta_batch(sb_sarta,sb_batch,sb_secuencial,sb_dependencia,sb_repeticion,sb_critico,sb_left, sb_top, sb_lote_inicio, sb_habilitado)
     values(1001,1007,7,1006,'S','N',6500,550,1001,'S')
insert into ba_sarta_batch(sb_sarta,sb_batch,sb_secuencial,sb_dependencia,sb_repeticion,sb_critico,sb_left, sb_top, sb_lote_inicio, sb_habilitado)
     values(1001,1008,8,1007,'S','N',7500,550,1001,'S')
insert into ba_sarta_batch(sb_sarta,sb_batch,sb_secuencial,sb_dependencia,sb_repeticion,sb_critico,sb_left, sb_top, sb_lote_inicio, sb_habilitado)
     values(1001,1010,9,1008,'S','N',8500,550,1001,'S')
go

INSERT INTO ba_sarta_batch(sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
	VALUES (1002, 1009, 1, null, 'S', 'N', 2500, 550, 1002, 'S')
INSERT INTO ba_sarta_batch(sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
	VALUES (1002, 1004, 2, null, 'S', 'N', 3500, 550, 1002, 'S')
INSERT INTO ba_sarta_batch(sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
	VALUES (1002, 1005, 3, null, 'S', 'N', 4500, 550, 1002, 'S')
INSERT INTO ba_sarta_batch(sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
	VALUES (1002, 1006, 4, null, 'S', 'N', 5500, 550, 1002, 'S')
INSERT INTO ba_sarta_batch(sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
	VALUES (1002, 1007, 5, null, 'S', 'N', 6500, 550, 1002, 'S')
INSERT INTO ba_sarta_batch(sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
	VALUES (1002, 1008, 6, null, 'S', 'N', 7500, 550, 1001, 'S')
GO



/*******************************/
delete ba_enlace
where en_sarta between 1001 and 1999
go

PRINT 'INSERCION: ba_enlace'

insert into ba_enlace values (1001, 1003, 1, 1001, 2, 'S', null, 'N')
-- insert into ba_enlace values (1001, 1002, 2, 1001, 3, 'S', null, 'N')
insert into ba_enlace values (1001, 1001, 2, 1009, 3, 'S', null, 'N')
insert into ba_enlace values (1001, 1009, 3, 1004, 4, 'S', null, 'N')
insert into ba_enlace values (1001, 1004, 4, 1005, 5, 'S', null, 'N')
insert into ba_enlace values (1001, 1005, 5, 1006, 6, 'S', null, 'N')
insert into ba_enlace values (1001, 1006, 6, 1007, 7, 'S', null, 'N')
insert into ba_enlace values (1001, 1007, 7, 1008, 8, 'S', null, 'N')
insert into ba_enlace values (1001, 1008, 8, 1010, 9, 'S', null, 'N')
insert into ba_enlace values (1001, 1010, 9, 0   , 0, 'S', null, 'N')

insert into ba_enlace values (1002,1009,1,1004,2,'S',null,'N')
insert into ba_enlace values (1002,1004,2,1005,3,'S',null,'N')
insert into ba_enlace values (1002,1005,3,1006,4,'S',null,'N')
insert into ba_enlace values (1002,1006,4,1007,5,'S',null,'N')
insert into ba_enlace values (1002,1007,5,1008,6,'S',null,'N')
insert into ba_enlace values (1002,1008,6,0,0,'S',null,'N')
go


